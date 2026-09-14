-- CMO One-Shot: Side Change using nested hostedUnits table
local side = 'UNKNOWN1'
local newSide = 'NATO'
local unitName = 'R 08 Queen Elizabeth' -- Works with single-unit Airfield aswell, but probably not with grouped airfield

local u = ScenEdit_GetUnit({side=side, name=unitName})

if u ~= nil then
    -- 1. Vaihdetaan emäaluksen puoli
    ScenEdit_SetUnitSide({guid=u.guid, newside=newSide})
    print("Alus '" .. unitName .. "' siirretty puolelle " .. newSide)
    
    local count = 0
    
    -- 2. Tarkistetaan foorumin mukainen rakenne: hostedUnits.Aircraft
    if u.hostedUnits ~= nil then
        -- Käsitellään lentokoneet
        if u.hostedUnits.Aircraft ~= nil then
            local acList = u.hostedUnits.Aircraft
            for i = 1, #acList do
                local g = acList[i]
                if g ~= nil then
                    ScenEdit_SetUnitSide({guid=g, newside=newSide})
                    count = count + 1
                end
            end
        end
        
        -- Käsitellään veneet (jos niitä on)
        if u.hostedUnits.Boats ~= nil then
            local boatList = u.hostedUnits.Boats
            for i = 1, #boatList do
                local g = boatList[i]
                if g ~= nil then
                    ScenEdit_SetUnitSide({guid=g, newside=newSide})
                    count = count + 1
                end
            end
        end
    end
    
    print("Yhteensä " .. count .. " embarked-yksikköä siirretty.")
else
    print("Virhe: Alusta ei löytynyt.")
end