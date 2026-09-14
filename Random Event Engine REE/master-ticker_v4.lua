-- ========================================================
-- MASTER TICKER: EVENT EXECUTION ENGINE V2.9 (Complete & Fixed)
-- ========================================================
-- APUFUNKTIO: Tulostaa CMO:n Lua-lokiin tunnin kera
local function LogEvent(msg)
    local currentH = ScenEdit_GetKeyValue("ScenarioHour") or "0"
    print("[Master Ticker Hour " .. currentH .. "] " .. msg)
end

local sideNATO = "NATO"
local sideNeutral = "Neutral"
local sideRussia = "Russia"
local sideUnknown = "UNKNOWN1" -- USA

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
        ScenEdit_SetUnitDamage({guid=unit_guid, dp=remaining_dp, fires=fires or 0})
    end
end

-- 1. PÄIVITETÄÄN KELLO
local currentHourStr = ScenEdit_GetKeyValue("ScenarioHour")
local currentHour = (tonumber(currentHourStr) or 0) + 1
ScenEdit_SetKeyValue("ScenarioHour", tostring(currentHour))
LogEvent("--- Ticker herätetty (Tunti: " .. currentHour .. ") ---")

-- 2. SAATTUEEN SIJAINTI (Vikasietoinen haku)
local convoyGroup = ScenEdit_GetUnit({guid=convoyGroupGUID})
local cLat, cLon = 50.0, -30.0 -- Fallback
local leadGUID = nil

if convoyGroup ~= nil and convoyGroup.group ~= nil then
    local leadShip = ScenEdit_GetUnit({guid=convoyGroup.group.lead})
    if leadShip ~= nil then
        cLat = leadShip.latitude
        cLon = leadShip.longitude
        leadGUID = leadShip.guid
        LogEvent("Sijainti haettu ryhmän " .. convoyGroup.name .. " johtajalta: " .. leadShip.name .. " [Lat: " .. cLat .. ", Lon: " .. cLon .. "]")
    else
        LogEvent("VIRHE: Ryhmän johtajaa (GUID: " .. convoyGroup.group.lead .. ") ei löytynyt!")
    end
else
    LogEvent("VIRHE: Ryhmää (GUID: " .. convoyGroupGUID .. ") ei löytynyt tai se ei ole Group-tyyppinen! Käytetään Fallback-koordinaatteja.")
end

-- 3. JATKUVAT TAPAHTUMAT
local droneExpHour = tonumber(ScenEdit_GetKeyValue("AlliedDroneExpHour")) or -1
if droneExpHour == currentHour then
    local droneGUID = ScenEdit_GetKeyValue("AlliedDroneGUID")
    if droneGUID ~= "" then
        ScenEdit_DeleteUnit({guid = droneGUID})
        LogEvent("JATKUVA: Allied Drone poistettu polttoaineen loppumisen vuoksi.")
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Allied MQ-9B SeaGuardian control transferred back to NATO Command. Drone has departed the area.")
        ScenEdit_SetKeyValue("AlliedDroneGUID", "")
    end
end

local repairHour = tonumber(ScenEdit_GetKeyValue("ShipRepairHour")) or -1
if repairHour == currentHour then
    local shipGUID = ScenEdit_GetKeyValue("DamagedShipGUID")
    if shipGUID ~= "" then
        ApplyPercentDamage(shipGUID, 0, 0)
        ScenEdit_SetUnit({guid=shipGUID, manualSpeed="Off"})
        LogEvent("JATKUVA: Rahtilaivan (GUID: " .. shipGUID .. ") korjaus valmis, nopeus vapautettu.")
        ScenEdit_SpecialMessage(sideNATO, "FLEET UPDATE: Engineering reports mechanical failures resolved. Convoy resuming standard speed.")
        ScenEdit_SetKeyValue("DamagedShipGUID", "")
    end
end

local stealthExpHour = tonumber(ScenEdit_GetKeyValue("StealthExpHour")) or -1
if stealthExpHour == currentHour then
    local stealthGUID = ScenEdit_GetKeyValue("StealthGUID")
    if stealthGUID ~= "" then
        ScenEdit_DeleteUnit({guid = stealthGUID})
        LogEvent("JATKUVA: USA Stealth -yksikkö poistettu alueelta.")
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
        local spawnLon = cLon + (dist / 40)
        LogEvent("EVENT 1: Spawnaan AGI Trawler koordinaatteihin: Lat " .. cLat .. ", Lon " .. spawnLon .. " (Etäisyys saattueesta: " .. dist .. " NM Itään)")
        ScenEdit_AddUnit({type="Ship", name="Unknown Trawler", dbid=2357, side=sideNeutral, latitude=cLat, longitude=spawnLon})
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Electronic surveillance detects unusual emissions from a civilian contact approx " .. dist .. " NM East of the convoy's projected path.")
        
    elseif id == 2 then
        local targetShip = convoyCargoShips[math.random(1, #convoyCargoShips)]
        local repairTime = math.random(6, 16)
        ApplyPercentDamage(targetShip, 50, 0)
        ScenEdit_SetKeyValue("DamagedShipGUID", targetShip)
        ScenEdit_SetKeyValue("ShipRepairHour", tostring(currentHour + repairTime))
        LogEvent("EVENT 2: Laiva " .. targetShip .. " vaurioitettu (50% DP). Korjaus asetettu tunnille: " .. (currentHour + repairTime))
        ScenEdit_SpecialMessage(sideNATO, "FLEET EMERGENCY: Critical mechanical failure on a cargo vessel. Speed severely restricted for estimated " .. repairTime .. " hours.")
        
    elseif id == 3 then
        local dist = math.random(30, 70)
        local spawnLat = cLat + (dist / 60)
        LogEvent("EVENT 3: Spawnaan RuAF Patrol koordinaatteihin: Lat " .. spawnLat .. ", Lon " .. cLon .. " (Etäisyys saattueesta: " .. dist .. " NM Pohjoiseen)")
        ScenEdit_AddUnit({type="Aircraft", name="RuAF Patrol", dbid=5384, course=200, loadoutid=29814, side=sideRussia, latitude=spawnLat, longitude=cLon, altitude=25000})
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Slow-moving airborne contacts detected descending approx " .. dist .. " NM North towards convoy operational area.")
        
    elseif id == 4 then
        local dist = math.random(200, 300)
        local spawnLon = cLon + (dist / 40)
        LogEvent("EVENT 4: Spawnaan Allied Drone koordinaatteihin: Lat " .. cLat .. ", Lon " .. spawnLon .. " (Etäisyys saattueesta: " .. dist .. " NM Itään)")
        local u = ScenEdit_AddUnit({type="Aircraft", name="Allied MQ-9B Support", dbid=7996, loadoutid=31010, side=sideNATO, latitude=cLat, longitude=spawnLon, altitude=30000})
        if u ~= nil then
            local supportDuration = math.random(4, 8)
            ScenEdit_SetUnit({guid=u.guid, throttle=0.2, course=270}) -- Asetetaan Loiter-nopeus ja kurssi kohti saattuetta
            ScenEdit_SetKeyValue("AlliedDroneGUID", u.guid)
            ScenEdit_SetKeyValue("AlliedDroneExpHour", tostring(currentHour + supportDuration))
            LogEvent("EVENT 4: Drone asetettu Loiter-tilaan, kurssi 270. Poistuu " .. supportDuration .. " tunnin kuluttua.")
            ScenEdit_SpecialMessage(sideNATO, "INTEL: NATO Command has diverted an MQ-9B SeaGuardian (approx " .. dist .. " NM East) to provide overwatch. Control transferred for " .. supportDuration .. "h. Please rebase the UAV to a nearby Allied airbase before fuel depletion.")
        end
        
    elseif id == 5 then
        local roll = math.random(1, 3)
        LogEvent("EVENT 5: Submarine Intel arvonta: heitettiin " .. roll)
        ScenEdit_SpecialMessage(sideNATO, "INTEL: SOSUS node anomalous transient detected. Possible periscope/snorkel signature 20-40 NM North-East of convoy.")
        
        local latOff, lonOff = math.random(20,40)/60, math.random(20,40)/40
        local tLat, tLon = cLat + latOff, cLon + lonOff
        local loc = ScenEdit_GetLocation({latitude=tLat, longitude=tLon})
        
        if loc.land == false then -- Varmistetaan ettei spawnata maan päälle
            if roll == 1 then
                LogEvent("EVENT 5: Spawnaan Russian Sub koordinaatteihin: Lat " .. tLat .. ", Lon " .. tLon)
                ScenEdit_AddUnit({type="Submarine", name="Unknown Sub", dbid=748, side=sideRussia, latitude=tLat, longitude=tLon, depth=-150})
            elseif roll == 3 then
                LogEvent("EVENT 5: Spawnaan NATO Hunter Sub koordinaatteihin: Lat " .. tLat .. ", Lon " .. tLon)
                ScenEdit_AddUnit({type="Submarine", name="SSN 751 San Juan", dbid=837, side=sideUnknown, latitude=tLat, longitude=tLon, depth=-200})
            else
                LogEvent("EVENT 5: Arvottiin False Alarm (nolla-tulos), ei lisätä mitään.")
            end
        else
            LogEvent("EVENT 5 VAROITUS: Laskettu sijainti [Lat: " .. tLat .. ", Lon: " .. tLon .. "] oli maan päällä. Sukellusveneen spawnaus peruttu turvallisuussyistä.")
        end

    elseif id == 6 then
        local dist = math.random(200, 300)
        local aLat = cLat + (dist / 60)
        local roll = math.random(1, 3)
        LogEvent("EVENT 6: Radar Contact arvonta: heitettiin " .. roll)
        ScenEdit_SpecialMessage(sideNATO, "INTEL: Intermittent radar contacts detected approx " .. dist .. " NM North towards the Arctic circle. Detection achieved via strategic NATO long-range surveillance radar network; contacts may not be visible on tactical organic sensors.")
        
        if roll == 1 then
            LogEvent("EVENT 6: Spawnaan RuAF Recon koordinaatteihin: Lat " .. aLat .. ", Lon " .. cLon)
            ScenEdit_AddUnit({type="Aircraft", name="RuAF Recon", dbid=2458, loadoutid=8174, side=sideRussia, latitude=aLat, longitude=cLon, altitude=35000})
        elseif roll == 3 then
            LogEvent("EVENT 6: Spawnaan Civilian Airliner koordinaatteihin: Lat " .. aLat .. ", Lon " .. cLon)
            ScenEdit_AddUnit({type="Aircraft", name="Civilian Airliner (IFF failure)", dbid=3976, loadoutid=19919, side=sideNeutral, latitude=aLat, longitude=cLon, altitude=35000})
        else
            LogEvent("EVENT 6: Arvottiin False Alarm, ei lisätä mitään.")
        end
       
    elseif id == 7 then
        LogEvent("EVENT 7: Aloitetaan dynaamisen miinakentän rakentaminen.")
        ScenEdit_SpecialMessage(sideNATO, "FLASH INTEL: Alliance acoustic intelligence has detected distinct acoustic signatures matching mine-laying operations in your sector. Suspected minefield is located roughly 20-40 NM East of the convoy's current position. Divert course 90 degrees or proceed with extreme ASW/MCM caution.") 
        
        if leadGUID ~= nil then
            local rpNames = {"MineRP_1_"..currentHour, "MineRP_2_"..currentHour, "MineRP_3_"..currentHour, "MineRP_4_"..currentHour}
            
            -- 1. Luodaan pisteet NATO-puolelle jotta RelativeTo toimii
            ScenEdit_AddReferencePoint({side=sideNATO, name=rpNames[1], RelativeTo=leadGUID, bearing=75, distance=20})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rpNames[2], RelativeTo=leadGUID, bearing=105, distance=20})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rpNames[3], RelativeTo=leadGUID, bearing=105, distance=40})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rpNames[4], RelativeTo=leadGUID, bearing=75, distance=40})
            
            -- 2. Poistetaan suhteellisuus (clear=true) ja siirretään Venäjän puolelle
            for _, rpName in ipairs(rpNames) do
                ScenEdit_SetReferencePoint({side=sideNATO, name=rpName, clear=true})
                ScenEdit_SetReferencePoint({side=sideRussia, name=rpName})
            end
            LogEvent("EVENT 7: Miinakentän RP-pisteet lukittu absoluuttisiksi koordinaateiksi ja siirretty puolelle: " .. sideRussia)
            
            -- 3. Luodaan miinakenttä Venäjän osapuolelle
            local laidMines = ScenEdit_AddMinefield({side=sideRussia, dbid=634, number=50, delay=0, area=rpNames})
            LogEvent("EVENT 7: Miinakenttä luotu onnistuneesti. Asetettujen miinojen määrä kartalla: " .. tostring(laidMines))
        else
            LogEvent("EVENT 7 VIRHE: Saattueen lead-alusta ei löytynyt, miinakenttää ei voitu ankkuroida!")
        end

    elseif id == 8 then
        local dist = math.random(50, 100)
        local vLat = cLat - (dist / 60)
        LogEvent("EVENT 8: Spawnaan Distressed Vessel koordinaatteihin: Lat " .. vLat .. ", Lon " .. cLon .. " (Etäisyys saattueesta: " .. dist .. " NM Etelään)")
        local u = ScenEdit_AddUnit({type="Ship", name="Distressed Vessel", dbid=1474, side=sideNeutral, latitude=vLat, longitude=cLon})
        
        if u ~= nil then
            ScenEdit_SpecialMessage(sideNATO, "MAYDAY: Civilian vessel struck unknown submerged object approx " .. dist .. " NM South. Vessel is taking on water. Maritime law dictates immediate SAR response (Helicopter/Fast Ship).")
            LogEvent("EVENT 8: Hätäviesti lähetetty ja alus rekisteröity. Luodaan pelastusalueen kiinteät RP-pisteet.")
            
            local rp1, rp2, rp3, rp4 = "SAR_RP_1_"..currentHour, "SAR_RP_2_"..currentHour, "SAR_RP_3_"..currentHour, "SAR_RP_4_"..currentHour
            local offsetLat, offsetLon = 5/60, 5/40 -- 5 NM neliöalue hätäpaikan ympärille
            
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp1, latitude=vLat+offsetLat, longitude=cLon+offsetLon})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp2, latitude=vLat-offsetLat, longitude=cLon+offsetLon})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp3, latitude=vLat-offsetLat, longitude=cLon-offsetLon})
            ScenEdit_AddReferencePoint({side=sideNATO, name=rp4, latitude=vLat+offsetLat, longitude=cLon-offsetLon})
            
            LogEvent("EVENT 8: SAR-alueen referenssipisteet luotu NATO-puolelle. Luodaan dynaaminen pelitapahtuma ja pisteytys.")
            
            local eventName = "SAR_" .. currentHour
            local trigName = "SAR_Trig_" .. currentHour
            local actName = "SAR_Act_" .. currentHour
            
            ScenEdit_SetTrigger({mode='add', type='UnitEntersArea', name=trigName, targetfilter={TargetSide='NATO'}, area={rp1, rp2, rp3, rp4}})
            ScenEdit_SetAction({mode='add', type='Points', name=actName, SideId='NATO', PointChange=50})
            ScenEdit_SetEvent({mode='add', name=eventName, isActive=true})
            ScenEdit_SetEventTrigger(eventName, trigName)
            ScenEdit_SetEventAction(eventName, actName)
            LogEvent("EVENT 8: Dynaaminen SAR-tapahtuma '" .. eventName .. "' kytketty ja aktivoitu peliin (+50 pojoa onnistumisesta).")
        end

    elseif id == 9 then
        LogEvent("EVENT 9: Strateginen viesti lähetetty Bear Gapin laivasto-osastosta, ei spawneja.")
        ScenEdit_SpecialMessage(sideNATO, "STRAT INTEL: NATO satellite pass confirms Russian Surface Action Group (1x Slava, 2x Gorshkov, support vessels) traversing Bear Gap at high speed. Estimated course: North Atlantic.")

    elseif id == 10 then
        local dist = math.random(10, 20)
        local sLat = cLat + (dist / 60)
        local roll = math.random(1, 2)
        local u = nil
        LogEvent("EVENT 10: USA Stealth arvonta: heitettiin " .. roll)
        
        if roll == 1 then
            LogEvent("EVENT 10: Spawnaan F-22 koordinaatteihin: Lat " .. sLat .. ", Lon " .. cLon)
            u = ScenEdit_AddUnit({type="Aircraft", name="Unknown Ghost", dbid=4875, loadoutid=26461, side=sideUnknown, latitude=sLat, longitude=cLon, altitude=50000})
        else
            LogEvent("EVENT 10: Spawnaan B-21 koordinaatteihin: Lat " .. sLat .. ", Lon " .. cLon)
            u = ScenEdit_AddUnit({type="Aircraft", name="Unknown Ghost", dbid=6158, loadoutid=32319, side=sideUnknown, latitude=sLat, longitude=cLon, altitude=50000})
        end
        
        if u ~= nil then
            ScenEdit_SetUnit({guid=u.guid, course=240, throttle=1.0}) -- Asetetaan suunta 240 astetta ja sotilasnopeus (Military)
            ScenEdit_SetKeyValue("StealthGUID", u.guid)
            ScenEdit_SetKeyValue("StealthExpHour", tostring(currentHour + 1))
            LogEvent("EVENT 10: Häivekone asetettu lentämään suuntaan 240. Poisto ajastettu yhdelle tunnille.")
            ScenEdit_SpecialMessage(sideNATO, "INTEL: Low-observable contact inbound from North (" .. dist .. " NM). IFF unresponsive. US assets suspected, but intentions unknown. Do not engage unless fired upon.")
        end
    end
end