-- ========================================================
-- MASTER TICKER: EVENT EXECUTION ENGINE V2.5 (Simple Logging)
-- ========================================================
-- APUFUNKTIO: Tulostaa CMO:n Lua-lokiin tunnin kera
local function LogEvent(msg)
    local currentH = ScenEdit_GetKeyValue("ScenarioHour") or "0"
    print("[Master Ticker Hour " .. currentH .. "] " .. msg)
end

local sideNATO = "NATO"
local sideNeutral = "Neutral"
local sideRussia = "Russia"
local sideUnknown = "UNKNOWN1" --USA

local convoyGroupGUID = "W8V2DT-0HNL0G7IIHV51"
local convoyCargoShips = {
    "CZ9UQ5-0HNJCGTAJI8P3", 
    "CZ9UQ5-0HNJCGTAJI8PB", 
    "CZ9UQ5-0HNJCGTAJI8PJ", 
    "CZ9UQ5-0HNJCGTAJI8PR",
    "CZ9UQ5-0HNJCGTAJI8Q4"
}

-- APUFUNKTIO: Vaurion asettaminen prosentteina
local function ApplyPercentDamage(unit_guid, percent, fires)
    local u = ScenEdit_GetUnit({guid=unit_guid})
    if u and u.damage then
        local remaining_dp = u.damage.startdp * (1 - (percent / 100))
        ScenEdit_SetUnitDamage({
            guid=unit_guid, 
            dp=remaining_dp, 
            fires=fires or 0
        })
    end
end

-- 1. PÄIVITETÄÄN KELLO
local currentHourStr = ScenEdit_GetKeyValue("ScenarioHour")
local currentHour = (tonumber(currentHourStr) or 0) + 1
ScenEdit_SetKeyValue("ScenarioHour", tostring(currentHour))
LogEvent("--- Ticker herätetty (Tunti: " .. currentHour .. ") ---")

-- 2. SAATTUEEN SIJAINTI (Lead Unit)
local convoyGroup = ScenEdit_GetUnit({guid=convoyGroupGUID})
local cLat, cLon = 50.0, -30.0 -- Default
if convoyGroup ~= nil and convoyGroup.lead ~= nil then
    local lead = convoyGroup:lead()
    cLat = lead.latitude
    cLon = lead.longitude
end

-- 3. JATKUVAT TAPAHTUMAT
-- Event 4: Drone exit
local droneExpHour = tonumber(ScenEdit_GetKeyValue("AlliedDroneExpHour")) or -1
if droneExpHour == currentHour then
    local droneGUID = ScenEdit_GetKeyValue("AlliedDroneGUID")
    if droneGUID ~= "" then
        ScenEdit_DeleteUnit({guid = droneGUID})
        LogEvent("Allied Drone poistettu polttoaineen loppumisen vuoksi.")
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Allied MQ-9B SeaGuardian is bingo fuel and returning to base.")
    end
end

-- Event 2: Rahtilaivan korjaus
local repairHour = tonumber(ScenEdit_GetKeyValue("ShipRepairHour")) or -1
if repairHour == currentHour then
    local shipGUID = ScenEdit_GetKeyValue("DamagedShipGUID")
    if shipGUID ~= "" then
        ApplyPercentDamage(shipGUID, 0, 0)
        ScenEdit_SetUnit({guid=shipGUID, manualSpeed="Off"}) -- Vapauttaa vauhdin (Auto)
        LogEvent("Rahtilaivan (GUID: " .. shipGUID .. ") korjaus valmis, nopeus vapautettu.")
        ScenEdit_SpecialMessage(sideNATO, "FLEET UPDATE: Engineering reports mechanical failures resolved. Convoy resuming standard speed.")
        ScenEdit_SetKeyValue("DamagedShipGUID", "")
    end
end

-- Event 10: USA Stealth poisto
local stealthExpHour = tonumber(ScenEdit_GetKeyValue("StealthExpHour")) or -1
if stealthExpHour == currentHour then
    local stealthGUID = ScenEdit_GetKeyValue("StealthGUID")
    if stealthGUID ~= "" then
        ScenEdit_DeleteUnit({guid = stealthGUID})
        LogEvent("USA Stealth -yksikkö poistettu alueelta.")
        ScenEdit_SetKeyValue("StealthGUID", "")
    end
end

-- 4. JONON PURKAMINEN
local eventString = ScenEdit_GetKeyValue("MasterEventList") or ""
local newEventString = ""
local eventsToExecute = {}

for eventData in string.gmatch(eventString, "([^|]+)") do
    local idStr, hourStr = string.match(eventData, "(%d+):(%d+)")
    local id, hour = tonumber(idStr), tonumber(hourStr)
    
    if hour == currentHour then
        table.insert(eventsToExecute, id)
    else
        newEventString = newEventString .. id .. ":" .. hour .. "|"
    end
end
ScenEdit_SetKeyValue("MasterEventList", newEventString)

-- 5. TAPAHTUMIEN SUORITUS
for _, id in ipairs(eventsToExecute) do
    LogEvent("Executing Random Event ID: " .. id)
    
    if id == 1 then
        local dist = math.random(50, 100)
        ScenEdit_AddUnit({type="Ship", name="Unknown Trawler", dbid=2357, side=sideNeutral, latitude=cLat, longitude=cLon + (dist / 40)})
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Electronic surveillance detects unusual emissions from a civilian contact approx " .. dist .. " NM East of the convoy's projected path.")
        
    elseif id == 2 then
        local targetShip = convoyCargoShips[math.random(1, #convoyCargoShips)]
        local repairTime = math.random(8, 24)
        ApplyPercentDamage(targetShip, 50, 0)
        ScenEdit_SetKeyValue("DamagedShipGUID", targetShip)
        ScenEdit_SetKeyValue("ShipRepairHour", tostring(currentHour + repairTime))
        LogEvent("Event 2: Laiva " .. targetShip .. " vaurioitettu. Korjaus tunnin " .. (currentHour + repairTime) .. " kohdalla.")
        ScenEdit_SpecialMessage(sideNATO, "FLEET EMERGENCY: Critical mechanical failure on a cargo vessel. Speed severely restricted for estimated " .. repairTime .. " hours.")
        
    elseif id == 3 then
        local dist = math.random(30, 70)
        ScenEdit_AddUnit({type="Aircraft", name="RuAF Patrol", dbid=5384, loadoutid=29814, side=sideRussia, latitude=cLat + (dist/60), longitude=cLon, altitude=25000})
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Slow-moving airborne contacts detected descending approx " .. dist .. " NM North towards convoy operational area.")
        
    if id == 4 then -- Drone: Loiter + viesti
        local u = ScenEdit_AddUnit({type="Aircraft", name="Allied MQ-9B Support", dbid=7996, loadoutid=31010, side=sideNATO, latitude=cLat, longitude=cLon + (250/40), altitude=30000})
        if u ~= nil then
            ScenEdit_SetUnit({guid=u.guid, throttle=0.2, course=270}) -- Loiter-nopeus
            ScenEdit_SpecialMessage(sideNATO, "INTEL: MQ-9B SeaGuardian arrived. Sector overhead. Please rebase to nearest NATO airbase at your earliest convenience.")
        end
        
    elseif id == 5 then -- Sub: Vedessäolon tarkistus
        local latOff, lonOff = math.random(20,40)/60, math.random(20,40)/40
        local tLat, tLon = cLat+latOff, cLon+lonOff
        local loc = ScenEdit_GetLocation({latitude=tLat, longitude=tLon})
        if loc.land == false then -- Varmistus: vain jos vedessä
            ScenEdit_AddUnit({type="Submarine", name="Unknown Sub", dbid=748, side=sideRussia, latitude=tLat, longitude=tLon, depth=-150})
            LogEvent("Event 5: Sub spawnattu koordinaatteihin " .. tLat .. "," .. tLon)
        else
            LogEvent("Event 5: Spawnausyritys maalle, peruttu.")
        end

    elseif id == 6 then
        -- EVENT 6: Radar Contact North (33/33/33)
        local dist = math.random(200, 300)
        local aLat = cLat + (dist / 60)
        local roll = math.random(1, 3)
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Faint, intermittent radar contacts detected approx " .. dist .. " NM towards the Arctic circle.")
        if roll == 1 then
            ScenEdit_AddUnit({type="Aircraft", name="RuAF Recon", dbid=2458, loadoutid=8174, side=sideRussia, latitude=aLat, longitude=cLon, altitude=35000})
        elseif roll == 3 then
            ScenEdit_AddUnit({type="Aircraft", name="Civilian Airliner (IFF failure)", dbid=3976, loadoutid=19919, side=sideNeutral, latitude=aLat, longitude=cLon, altitude=35000})
        end
       
    elseif id == 7 then -- Miinat: Pisteiden lukitus
        local rpNames = {"MineRP_1_"..currentHour, "MineRP_2_"..currentHour, "MineRP_3_"..currentHour, "MineRP_4_"..currentHour}
        for _, name in ipairs(rpNames) do
            ScenEdit_AddReferencePoint({side=sideNATO, name=name, RelativeTo=leadGUID, bearing=75, distance=20})
            -- Poistetaan RelativeTo-kytkös, jotta RP:t jäävät paikalleen
            ScenEdit_SetReferencePoint({side=sideNATO, name=name, clear=true})
            -- Siirretään Venäjän sidelle
            ScenEdit_SetReferencePoint({side=sideRussia, name=name})
        end
        local laidMines = ScenEdit_AddMinefield({side=sideRussia, dbid=634, number=50, area=rpNames})
        ScenEdit_SpecialMessage(sideNATO, "FLASH INTEL: Minefield detected approx 20-40nm East of current convoy course.")
        LogEvent("Event 7: Miinakenttä luotu koordinaatteihin idässä.")
        
    elseif id == 8 then
        -- SAR EVENT: Luodaan laiva, dynaamiset RP:t, trigger ja action
        local dist = math.random(50, 100)
        local vLat = cLat - (dist / 60)
        local u = ScenEdit_AddUnit({type="Ship", name="Distressed Vessel", dbid=1474, side=sideNeutral, latitude=vLat, longitude=cLon})
        
        if u ~= nil then
            ScenEdit_SpecialMessage(sideNATO, "MAYDAY: Civilian vessel struck unknown submerged object approx " .. dist .. " NM South. SAR response required.")
            LogEvent("SAR Event luotu etäisyydelle " .. dist .. " NM. Kohde: " .. u.guid)
            
            -- Luodaan dynaamiset referenssipisteet 5 NM etäisyydelle uppoavasta aluksesta
            local rp1, rp2, rp3, rp4 = "SAR_RP_1_"..currentHour, "SAR_RP_2_"..currentHour, "SAR_RP_3_"..currentHour, "SAR_RP_4_"..currentHour
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp1, RelativeTo=u.guid, bearing=45, distance=5})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp2, RelativeTo=u.guid, bearing=135, distance=5})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp3, RelativeTo=u.guid, bearing=225, distance=5})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp4, RelativeTo=u.guid, bearing=315, distance=5})
            
            local eventName, trigName, actName = "SAR_" .. currentHour, "SAR_Trig_" .. currentHour, "SAR_Act_" .. currentHour
            ScenEdit_SetTrigger({mode='add', type='UnitEntersArea', name=trigName, targetfilter={TargetSide='NATO'}, area={rp1, rp2, rp3, rp4}})
            ScenEdit_SetAction({mode='add', type='Points', name=actName, SideId='NATO', PointChange=50})
            ScenEdit_SetEvent({mode='add', name=eventName, isActive=true})
            ScenEdit_SetEventTrigger(eventName, trigName)
            ScenEdit_SetEventAction(eventName, actName)
        end

    elseif id == 9 then
        -- EVENT 9: Bear Gap SAG
        ScenEdit_SpecialMessage(sideNATO, "STRAT INTEL: NATO satellite pass confirms Russian Surface Action Group (1x Slava, 2x Gorshkov, support vessels) traversing Bear Gap at high speed. Estimated course: North Atlantic.")
       
    elseif id == 10 then
        -- EVENT 10: USA Stealth
        local dist = math.random(10, 20)
        local sLat = cLat + (dist / 60)
        local roll = math.random(1, 2)
        local u = nil
        if roll == 1 then
            u = ScenEdit_AddUnit({type="Aircraft", name="Unknown Ghost", dbid=4875, loadoutid=26461, side=sideUnknown, latitude=sLat, longitude=cLon, altitude=50000})
        else
            u = ScenEdit_AddUnit({type="Aircraft", name="Unknown Ghost", dbid=6158, loadoutid=32319, side=sideUnknown, latitude=sLat, longitude=cLon, altitude=50000})
        end
        
        if u ~= nil then
            ScenEdit_SetKeyValue("StealthGUID", u.guid)
            ScenEdit_SetKeyValue("StealthExpHour", tostring(currentHour + 1))
            ScenEdit_SpecialMessage(sideNATO, "INTEL: Low-observable contact inbound from North (" .. dist .. " NM). IFF unresponsive. US assets suspected, but intentions unknown. Do not engage unless fired upon.")
        end
    end
end