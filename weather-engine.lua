-- 0. Asetetaan varmuudeksi ensimmäisessä ajossa current day 0, HUOM vain ensimmäisellä triggeröinnillä tämä, tee erilliset EVENTit
ScenEdit_SetKeyValue("ConvoyDay", tostring(0))



-- FULL ONE-SHOT SCRIPT: Weather Engine V7.1 (No Hallucinated Fields)
local sideName = "NATO"

-- 1. Persistent Data
local dayStr = ScenEdit_GetKeyValue("ConvoyDay")
local stormStr = ScenEdit_GetKeyValue("ConvoyStormReached")
local prevSeaStr = ScenEdit_GetKeyValue("ConvoySeaState")

local currentDay = (tonumber(dayStr) or 0) + 1
local stormReached = (stormStr == "true")
local prevSeaState = tonumber(prevSeaStr) or 2

-- 2. Weather Logic
local prevWeather = ScenEdit_GetWeather()
local temp = prevWeather.temp or 10
local rain = prevWeather.rainfall or 0
local clouds = prevWeather.undercloud or 0.5
local seaState = prevSeaState

local stormChance = {5, 15, 30, 50, 75, 100, 100, 100}
local currentChance = stormChance[currentDay] or 100

if prevSeaState > 7 then
    seaState = prevSeaState - 2
    clouds = math.max(0.5, clouds - 0.1)
    rain = math.max(5, rain - 10)
elseif prevSeaState == 7 then
    seaState = prevSeaState - 1
    clouds = math.max(0.5, clouds - 0.1)
    rain = math.max(5, rain - 10)
elseif not stormReached and math.random(1, 100) <= currentChance then
    seaState = math.random(7, 9); clouds = math.random(8, 10)/10; rain = math.random(30, 50); temp = math.random(2, 6)
    stormReached = true
else
    seaState = math.max(2, math.min(5, seaState + math.random(-1, 1)))
    clouds = math.max(0.3, math.min(0.9, clouds + (math.random(-2, 2)/10)))
    rain = math.max(0, math.min(20, rain + math.random(-10, 10)))
    temp = math.max(2, math.min(12, temp + math.random(-2, 2)))
end
seaState = math.floor(seaState)

-- 3. Apply Weather
ScenEdit_SetWeather(math.floor(temp), math.floor(rain), clouds, seaState)
ScenEdit_SetKeyValue("ConvoyDay", tostring(currentDay))
ScenEdit_SetKeyValue("ConvoyStormReached", tostring(stormReached))
ScenEdit_SetKeyValue("ConvoySeaState", tostring(seaState))

-- 4. Tactical Override: AirFacility Iteration
-- FULL ONE-SHOT SCRIPT: Aseta 24h readytime ryhmän laivojen lentokoneille
local groupName = "Convoy HG-004"

local sideInfo = VP_GetSide({side = sideName})

if sideInfo ~= nil and sideInfo.units ~= nil and seaState >=6  then
    -- VP_GetSide().units palauttaa taulukon deskriptoreita
    for _, u_info in ipairs(sideInfo.units) do 
        local u = ScenEdit_GetUnit({guid = u_info.guid})
        
        -- Nollatarkistus: Varmistetaan että yksikkö on olemassa
        if u ~= nil then
            -- Suodatetaan vain laivat
            if u.type == 'Ship' then
                
                -- Tarkistetaan, kuuluuko yksikkö haluttuun ryhmään
                if u.group ~= nil and u.group.name == groupName then
                    print("Löydetty ryhmän '" .. groupName .. "' jäsen: " .. u.name .. " (GUID: " .. u.guid .. ")")
                    
                    -- Etsitään Aircraft-tyyppiset yksiköt assignedUnits-taulukosta
                    if u.assignedUnits ~= nil and u.assignedUnits.Aircraft ~= nil then
                        for _, ac_guid in ipairs(u.assignedUnits.Aircraft) do
                            local ac = ScenEdit_GetUnit({guid = ac_guid})
                            
                            -- Nollatarkistus kiinnitetylle lentokoneelle
                            if ac ~= nil then
                                local isUAV = (ac.classname:upper():find("UAV") ~= nil)
                                local shouldGround = false
                                
                                -- Sääntö: UAV vaatii SS 8, miehitetty vaatii SS 6
                                if isUAV and seaState >= 8 then
                                    shouldGround = true
                                elseif not isUAV and seaState >= 6 then
                                    shouldGround = true
                                end
                                
                                if shouldGround then
                                    ScenEdit_SetUnit({guid = ac.guid, timetoready_minutes = 1440})
                                    print("Grounding unit: " .. ac.name .. " due to Sea State " .. seaState)
                                end
                            end
                        end
                    else
                        print("  -> Ei lentokoneita assignedUnits-listassa yksiköllä: " .. u.name)
                    end
                end
            end
        end
    end
else
    print("Virhe: Puolta '" .. sideName .. "' ei löytynyt tai sillä ei ole yksiköitä.")
end

-- 5. English SITREP
local advisory = "Flight operations normal."
if seaState >= 8 then
    advisory = "<font color='#FF4444'>DANGER: SEA STATE " .. seaState .. ". ALL NAVAL BASED AVIATION CEASED FOR 24H. CONVOY SPEED LIMITED DUE TO ROUGH SEAS.</font>"
elseif seaState >= 6 then
    advisory = "<font color='#FF9900'>WARNING: SEA STATE " .. seaState .. ". NAVAL BASED MANNED AVIATION CEASED. UAV OPS PERMITTED. CONVOY SPEED LIMITED DUE TO ROUGH SEAS.</font>"
end

local fullReport = string.format(
    "<h2>WEATHER REPORT - DAY %d</h2><hr>" ..
    "<b>Sea State:</b> %d | <b>Temp:</b> %d &deg;C<br>" ..
    "<b>Cloud Cover:</b> %d %%<br><br>" ..
    "<h3><font color='#FF9900'>*** FLEET STANDING ORDERS ***</font></h3>" ..
    "<ul><li><b>Aviation Status:</b> %s</li>",
    currentDay, seaState, math.floor(temp), math.floor(clouds*100), advisory
)
ScenEdit_SpecialMessage(sideName, fullReport)