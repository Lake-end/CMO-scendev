--[[
===============================================================
LAKEEND SCRIPTING FRAMEWORK — GLOBAL SCRIPT
Version: 1.0.0
Author: Petri
===============================================================

ABOUT LAKEEND
-------------
LAKEEND is a modular Lua scripting framework for Command: Modern
Operations (CMO). It provides:

- A clean namespace (LAKEEND.*)
- Debugging and logging utilities
- Utility functions (math, geometry, distance, bearings)
- Global state helpers (key-value storage)
- Satellite infrastructure degradation system
- Maritime hybrid threat logic
- Cyber pressure and comms disruption
- Dynamic AI behavior and mission control
- Event wiring helpers
- Narrative tools (messages, intel, briefings)
- Debug overlay (markers, circles, dumps)
- SOF / "little green men" covert ground actions
- Basic test harness

It is designed to be pasted into:
Editor → Scenario → Lua Script

===============================================================
LAKEEND.SOF MODULE — README & MISSION DESCRIPTIONS
===============================================================

ABOUT LAKEEND.SOF
-----------------
LAKEEND.SOF provides a high-level, abstracted way to model covert
ground actions ("little green men") in CMO. It represents SOF
actions through movement, state changes, and events, not direct
infantry combat.

Mission types:
1) SABOTAGE & EXFIL
2) CAPTURE & HOLD
3) AMBIGUOUS PRESENCE

These missions can be triggered by events, escalation levels, or
player actions, and are reusable across scenarios.

===============================================================
END OF README
===============================================================
]]--

-- ============================================================
-- 0. NAMESPACE SETUP
-- ============================================================

LAKEEND = {}
LAKEEND.version = "1.0.0"
LAKEEND.SCEN_START = ScenEdit_CurrentTime()


function LAKEEND.hello()
    print("==========================================")
    print("[LAKEEND] Framework online.")
    print("[LAKEEND] Version: " .. tostring(LAKEEND.version or "unknown"))
    print("[LAKEEND] Namespace OK, modules ready.")
    print("==========================================")
end

ScenEdit_MsgBox("[LAKEEND] Framework online.",1)


-- ============================================================
-- 1. DEBUGGING UTILITIES
-- ============================================================

LAKEEND.debug = true   -- set to false for release builds

function LAKEEND.log(msg)
    if LAKEEND.debug then
        print("[LAKEEND] " .. tostring(msg))
    end
end

function LAKEEND.warn(msg)
    print("[LAKEEND WARNING] " .. tostring(msg))
end

function LAKEEND.error(msg)
    print("[LAKEEND ERROR] " .. tostring(msg))
end

-- ============================================================
-- 2. UTILITY FUNCTIONS
-- ============================================================

function LAKEEND.split(str, sep)
    local t = {}
    for s in string.gmatch(str, '([^' .. sep .. ']+)') do
        table.insert(t, s)
    end
    return t
end

function LAKEEND.randomPick(list)
    if #list == 0 then return nil end
    return list[math.random(#list)]
end

function LAKEEND.timePassed(seconds)
    local now = ScenEdit_CurrentTime() 
    return (now - SCEN_START) >= seconds 
end

function LAKEEND.existsUnit(name)
    return ScenEdit_GetUnit({name=name}) ~= nil
end

-- ============================================================
-- 3. GLOBAL STATE MANAGEMENT
-- ============================================================

function LAKEEND.set(key, value)
    ScenEdit_SetKeyValue(key, tostring(value))
end

function LAKEEND.get(key)
    return ScenEdit_GetKeyValue(key)
end

-- ============================================================
-- 4. LAKEEND.UTILS — Math, Geometry, Distance, Bearings
-- ============================================================

LAKEEND.UTILS = {}

function LAKEEND.UTILS.rad(deg)
    return deg * math.pi / 180
end

function LAKEEND.UTILS.deg(rad)
    return rad * 180 / math.pi
end

function LAKEEND.UTILS.distance(lat1, lon1, lat2, lon2)
    local R = 6371
    local dLat = LAKEEND.UTILS.rad(lat2 - lat1)
    local dLon = LAKEEND.UTILS.rad(lon2 - lon1)

    local a = math.sin(dLat/2)^2 +
              math.cos(LAKEEND.UTILS.rad(lat1)) *
              math.cos(LAKEEND.UTILS.rad(lat2)) *
              math.sin(dLon/2)^2

    local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
    return R * c
end

function LAKEEND.UTILS.bearing(lat1, lon1, lat2, lon2)
    local dLon = LAKEEND.UTILS.rad(lon2 - lon1)
    local y = math.sin(dLon) * math.cos(LAKEEND.UTILS.rad(lat2))
    local x = math.cos(LAKEEND.UTILS.rad(lat1)) * math.sin(LAKEEND.UTILS.rad(lat2)) -
              math.sin(LAKEEND.UTILS.rad(lat1)) * math.cos(LAKEEND.UTILS.rad(lat2)) * math.cos(dLon)
    return (LAKEEND.UTILS.deg(math.atan2(y, x)) + 360) % 360
end

function LAKEEND.UTILS.project(lat, lon, bearing, distance)
    local R = 6371
    local br = LAKEEND.UTILS.rad(bearing)
    local d = distance / R

    local lat1 = LAKEEND.UTILS.rad(lat)
    local lon1 = LAKE.UTILS and LAKEEND.UTILS.rad(lon) or LAKEEND.UTILS.rad(lon) -- safety

    local lat2 = math.asin(
        math.sin(lat1)*math.cos(d) +
        math.cos(lat1)*math.sin(d)*math.cos(br)
    )

    local lon2 = lon1 + math.atan2(
        math.sin(br)*math.sin(d)*math.cos(lat1),
        math.cos(d) - math.sin(lat1)*math.sin(lat2)
    )

    return LAKEEND.UTILS.deg(lat2), LAKEEND.UTILS.deg(lon2)
end

-- ============================================================
-- 5. SATELLITE INFRASTRUCTURE DEGRADATION SYSTEM
-- ============================================================

LAKEEND.SAT = {}

function LAKEEND.SAT.init()
    local stations = {
        'SvalSat',
        'Matera',
        'Neustrelitz',
        'Tenerife',
        'Sodankyla',
        'Kiruna'
    }

    LAKEEND.set('Stations', table.concat(stations, ','))
    LAKEEND.set('Escalation', '0')

    local pick = LAKEEND.randomPick(stations)
    LAKEEND.set('PrimaryTarget', pick)

    LAKEEND.log("SAT Init complete. Primary target: " .. pick)
end

function LAKEEND.SAT.getStations()
    local list = LAKEEND.get('Stations')
    if not list or list == "" then return {} end
    return LAKEEND.split(list, ',')
end

function LAKEEND.SAT.randomOutage()
    local stations = LAKEEND.SAT.getStations()
    local target = LAKEEND.randomPick(stations)
    if not target then
        LAKEEND.error("No stations available for outage.")
        return
    end

    ScenEdit_SetUnit({name=target, isactive=false})
    LAKEEND.set('LastOutage', target)

    ScenEdit_TriggerEvent(target .. "_Down")
    LAKEEND.log("Random outage: " .. target)
end

function LAKEEND.SAT.cascade()
    if math.random() < 0.25 then
        LAKEEND.log("Cascade triggered.")
        ScenEdit_TriggerEvent("RandomOutage")
    else
        LAKEEND.log("No cascade.")
    end
end

function LAKEEND.SAT.repair()
    local target = LAKEEND.get('RepairTarget')
    if not target or target == "" then
        target = LAKEEND.get('LastOutage')
    end

    if not target then
        LAKEEND.warn("RepairAttempt called with no target.")
        return
    end

    if math.random() < 0.5 then
        ScenEdit_SetUnit({name=target, isactive=true})
        ScenEdit_TriggerEvent(target .. "_Restored")
        LAKEEND.log("Repair successful: " .. target)
    else
        ScenEdit_TriggerEvent("RepairFailed")
        LAKEEND.log("Repair failed: " .. target)
    end
end

function LAKEEND.SAT.escalate()
    local lvl = tonumber(LAKEEND.get('Escalation')) or 0

    if lvl == 0 then
        LAKEEND.set('Escalation', '1')
        ScenEdit_TriggerEvent("Escalation_1")
        LAKEEND.log("Escalation → Level 1")

    elseif lvl == 1 then
        LAKEEND.set('Escalation', '2')
        ScenEdit_TriggerEvent("Escalation_2")
        LAKEEND.log("Escalation → Level 2")

    elseif lvl == 2 then
        LAKEEND.set('Escalation', '3')
        ScenEdit_TriggerEvent("Escalation_3")
        LAKEEND.log("Escalation → Level 3")

    else
        LAKEEND.warn("Escalation already at max.")
    end
end

function LAKEEND.SAT.score()
    local score = 0
    local critical = {'SvalSat','Matera','Neustrelitz'}

    for _, name in ipairs(critical) do
        local u = ScenEdit_GetUnit({name=name})
        if u and u.isactive then
            score = score + 25
        end
    end

    ScenEdit_SetScore('Blue', score)
    LAKEEND.log("Score updated: " .. score)
end

-- ============================================================
-- 6. LAKEEND.MARITIME — Maritime Hybrid Threat Module
-- ============================================================

LAKEEND.MARITIME = {}

function LAKEEND.MARITIME.flagSuspicious(name)
    LAKEEND.set("SuspiciousVessel", name)
    LAKEEND.log("Vessel flagged as suspicious: " .. name)
end

function LAKEEND.MARITIME.onDetected(name)
    local u = ScenEdit_GetUnit({name=name})
    if u and u.detectedby then
        ScenEdit_TriggerEvent("HybridStrike")
        LAKEEND.log("Suspicious vessel detected: " .. name)
    end
end

function LAKEEND.MARITIME.onPlatformDestroyed(name)
    if not LAKEEND.existsUnit(name) then
        ScenEdit_TriggerEvent("Retaliation")
        LAKEEND.log("Covert maritime platform destroyed: " .. name)
    end
end

function LAKEEND.MARITIME.randomBehavior(name)
    local behaviors = {
        "slow",
        "drift",
        "course_change",
        "lights_off"
    }

    local pick = LAKEEND.randomPick(behaviors)

    if pick == "slow" then
        ScenEdit_SetUnit({name=name, speed=5})
    elseif pick == "drift" then
        ScenEdit_SetUnit({name=name, speed=1})
    elseif pick == "course_change" then
        ScenEdit_SetUnit({name=name, heading=math.random(0,359)})
    elseif pick == "lights_off" then
        ScenEdit_SetEMCON(name, "Radar=Passive;OECM=Passive")
    end

    LAKEEND.log("Random maritime behavior applied to " .. name .. ": " .. pick)
end

-- ============================================================
-- 7. LAKEEND.CYBER — Cyber Pressure & Comms Degradation
-- ============================================================

LAKEEND.CYBER = {}

function LAKEEND.CYBER.commsOut(name)
    ScenEdit_SetUnit({name=name, isactive=false})
    LAKEEND.log("Comms outage applied to: " .. name)
    ScenEdit_TriggerEvent("CommsOut_" .. name)
end

function LAKEEND.CYBER.commsRestore(name)
    ScenEdit_SetUnit({name=name, isactive=true})
    LAKEEND.log("Comms restored: " .. name)
    ScenEdit_TriggerEvent("CommsRestored_" .. name)
end

function LAKEEND.CYBER.spoof(name)
    local u = ScenEdit_GetUnit({name=name})
    if not u then return end

    local lat = u.latitude + (math.random() * 0.1 - 0.05)
    local lon = u.longitude + (math.random() * 0.1 - 0.05)

    ScenEdit_SetUnit({name=name, latitude=lat, longitude=lon})
    LAKEEND.log("Spoofing applied to: " .. name)
end

function LAKEEND.CYBER.networkDegrade(list)
    for _, name in ipairs(list) do
        ScenEdit_SetUnit({name=name, isactive=false})
    end
    LAKEEND.log("Network degradation applied to group.")
end

-- ============================================================
-- 8. LAKEEND.AI — Dynamic Enemy Behavior
-- ============================================================

LAKEEND.AI = {}

function LAKEEND.AI.posture(sideA, sideB, posture)
    ScenEdit_SetSidePosture(sideA, sideB, posture)
    LAKEEND.log("Posture changed: " .. sideA .. " → " .. sideB .. " = " .. posture)
end

function LAKEEND.AI.activateMission(side, mission)
    ScenEdit_SetMission(side, mission, {isactive=true})
    LAKEEND.log("Mission activated: " .. mission)
end

function LAKEEND.AI.deactivateMission(side, mission)
    ScenEdit_SetMission(side, mission, {isactive=false})
    LAKEEND.log("Mission deactivated: " .. mission)
end

function LAKEEND.AI.onDetectedActivate(unitName, side, mission)
    local u = ScenEdit_GetUnit({name=unitName})
    if u and u.detectedby then
        LAKEEND.AI.activateMission(side, mission)
        LAKEEND.log("Detection-triggered mission activation: " .. mission)
    end
end

function LAKEEND.AI.randomMission(side, missions)
    local pick = LAKEEND.randomPick(missions)
    LAKEEND.AI.activateMission(side, pick)
end

-- ============================================================
-- 9. LAKEEND.EVENTS — Event Wiring Helpers
-- ============================================================

LAKEEND.EVENTS = {}

function LAKEEND.EVENTS.fire(name)
    ScenEdit_TriggerEvent(name)
    LAKEEND.log("Event fired: " .. name)
end

function LAKEEND.EVENTS.schedule(name, delay)
    ScenEdit_ScheduleTimeEvent(name, delay)
    LAKEEND.log("Event scheduled: " .. name .. " in " .. delay .. " sec")
end

function LAKEEND.EVENTS.fireIf(condition, eventName)
    if condition then
        ScenEdit_TriggerEvent(eventName)
        LAKEEND.log("Conditional event fired: " .. eventName)
    end
end

function LAKEEND.EVENTS.random(list)
    local pick = LAKEEND.randomPick(list)
    ScenEdit_TriggerEvent(pick)
    LAKEEND.log("Random event fired: " .. pick)
end

-- ============================================================
-- 10. LAKEEND.NARRATIVE — Messages, Intel, Briefings
-- ============================================================

LAKEEND.NARRATIVE = {}

function LAKEEND.NARRATIVE.message(text)
    ScenEdit_MsgBox(text)
    LAKEEND.log("Message shown: " .. text)
end

function LAKEEND.NARRATIVE.intel(text, followupEvent)
    ScenEdit_MsgBox("[INTEL] " .. text)
    LAKEEND.log("Intel drop: " .. text)

    if followupEvent then
        ScenEdit_TriggerEvent(followupEvent)
        LAKEEND.log("Intel follow-up event fired: " .. followupEvent)
    end
end

function LAKEEND.NARRATIVE.briefing(side, text)
    local s = ScenEdit_GetSide({side=side})
    local newBrief = (s.briefing or "") .. "\n\n" .. text
    ScenEdit_SetSide({side=side, briefing=newBrief})
    LAKEEND.log("Briefing updated for side: " .. side)
end

function LAKEEND.NARRATIVE.escalation(level)
    local msg = {
        [1] = "Hybrid pressure intensifies across the region.",
        [2] = "Coordinated disruptions detected in multiple domains.",
        [3] = "Crisis escalating toward open confrontation."
    }

    ScenEdit_MsgBox(msg[level] or "Escalation event triggered.")
    LAKEEND.log("Escalation narrative: Level " .. tostring(level))
end

-- ============================================================
-- 11. LAKEEND.DEBUG — Map Markers, Visual Cues
-- ============================================================

LAKEEND.DEBUG = {}

function LAKEEND.DEBUG.marker(lat, lon, text)
    ScenEdit_AddMarker({
        latitude = lat,
        longitude = lon,
        text = text or "DEBUG"
    })
    LAKEEND.log("Marker placed: " .. (text or "DEBUG"))
end

function LAKEEND.DEBUG.markUnit(name)
    local u = ScenEdit_GetUnit({name=name})
    if not u then
        LAKEEND.warn("Cannot mark unit: " .. name)
        return
    end

    ScenEdit_AddMarker({
        latitude = u.latitude,
        longitude = u.longitude,
        text = "UNIT: " .. name
    })

    LAKEEND.log("Unit marked: " .. name)
end

function LAKEEND.DEBUG.circle(lat, lon, radius)
    ScenEdit_AddCircle({
        latitude = lat,
        longitude = lon,
        radius = radius
    })
    LAKEEND.log("Circle drawn at (" .. lat .. "," .. lon .. ") r=" .. radius)
end

function LAKEEND.DEBUG.dump(tbl)
    for k,v in pairs(tbl) do
        print("[LAKEEND DEBUG] " .. tostring(k) .. " = " .. tostring(v))
    end
end

-- ============================================================
-- 12. LAKEEND.SOF — Covert Ground Actions & "Little Green Men"
-- ============================================================

LAKEEND.SOF = {}

function LAKEEND.SOF.spawn(name, side, lat, lon, dbid)
    dbid = dbid or 1701
    ScenEdit_AddUnit({
        type = "Ground",
        name = name,
        side = side,
        dbid = dbid,
        latitude = lat,
        longitude = lon
    })
    LAKEEND.log("SOF spawned: " .. name .. " (" .. side .. ")")
end

function LAKEEND.SOF.despawn(name)
    ScenEdit_DeleteUnit({name = name})
    LAKEEND.log("SOF despawned: " .. name)
end

function LAKEEND.SOF.moveTo(name, lat, lon)
    ScenEdit_SetUnit({
        name = name,
        course = { {lat, lon} }
    })
    LAKEEND.log("SOF moving: " .. name .. " → (" .. lat .. "," .. lon .. ")")
end

function LAKEEND.SOF.moveAlongPath(name, points)
    ScenEdit_SetUnit({
        name = name,
        course = points
    })
    LAKEEND.log("SOF moving along path: " .. name)
end

function LAKEEND.SOF.disableFacility(facility)
    ScenEdit_SetUnit({name = facility, isactive = false})
    LAKEEND.log("Facility disabled (SOF action): " .. facility)
end

function LAKEEND.SOF.damageFacility(facility, fraction)
    local u = ScenEdit_GetUnit({name = facility})
    if not u then
        LAKEEND.warn("Cannot damage facility, not found: " .. facility)
        return
    end

    local newDamage = (u.damage or 0) + fraction
    if newDamage > 1 then newDamage = 1 end

    ScenEdit_SetUnit({name = facility, damage = newDamage})
    LAKEEND.log("Facility damage updated: " .. facility .. " → " .. tostring(newDamage))
end

function LAKEEND.SOF.captureFacility(facility, newSide)
    ScenEdit_SetUnit({name = facility, side = newSide})
    LAKEEND.log("Facility captured: " .. facility .. " → " .. newSide)
end

function LAKEEND.SOF.insertAndApproach(args)
    LAKEEND.SOF.spawn(args.sofName, args.side, args.spawnLat, args.spawnLon, args.dbid)
    LAKEEND.SOF.moveTo(args.sofName, args.approachLat, args.approachLon)
end

function LAKEEND.SOF.extract(name, lat, lon)
    LAKEEND.SOF.moveTo(name, lat, lon)
    LAKEEND.log("SOF extracting: " .. name)
end

function LAKEEND.SOF.sabotageAndExfil(args)
    LAKEEND.SOF.disableFacility(args.facility)
    if args.message then
        LAKEEND.NARRATIVE.message(args.message)
    end
    LAKEEND.SOF.extract(args.sofName, args.extractLat, args.extractLon)
end

function LAKEEND.SOF.captureAndHold(args)
    LAKEEND.SOF.captureFacility(args.facility, args.newSide)
    if args.message then
        LAKEEND.NARRATIVE.message(args.message)
    end
    LAKEEND.log("SOF holding position at: " .. args.facility)
end

function LAKEEND.SOF.setLowProfile(name)
    ScenEdit_SetEMCON(name, "Radar=Passive;OECM=Passive")
    LAKEEND.log("SOF set to low profile: " .. name)
end

function LAKEEND.SOF.randomPause(name, minSec, maxSec)
    local delay = math.random(minSec, maxSec)
    LAKEEND.EVENTS.schedule("EVT_SOF_RESUME_" .. name, delay)
    LAKEEND.log("SOF random pause: " .. name .. " for " .. delay .. " sec")
end

function LAKEEND.SOF.flagUnmarked(name)
    LAKEEND.set("SOF_UNMARKED_" .. name, "1")
    LAKEEND.log("SOF flagged as unmarked: " .. name)
end

-- Example mission helpers (you can call these from events)

function LAKEEND.SOF.missionSabotage()
    local args = {
        sofName     = "SOF_SABOTAGE_01",
        side        = "Red",
        spawnLat    = 60.000,
        spawnLon    = 25.000,
        approachLat = 60.005,
        approachLon = 25.005,
        dbid        = 1701
    }

    LAKEEND.SOF.insertAndApproach(args)
    LAKEEND.SOF.setLowProfile(args.sofName)
    LAKEEND.SOF.flagUnmarked(args.sofName)
end

function LAKEEND.SOF.missionCapture()
    local args = {
        sofName     = "SOF_CAPTURE_01",
        side        = "Red",
        spawnLat    = 60.100,
        spawnLon    = 25.200,
        approachLat = 60.105,
        approachLon = 25.205,
        dbid        = 1701
    }

    LAKEEND.SOF.insertAndApproach(args)
    LAKEEND.SOF.setLowProfile(args.sofName)
    LAKEEND.SOF.flagUnmarked(args.sofName)
end

function LAKEEND.SOF.missionPresence()
    local args = {
        sofName     = "SOF_PRESENCE_01",
        side        = "Red",
        spawnLat    = 60.300,
        spawnLon    = 25.400,
        approachLat = 60.305,
        approachLon = 25.405,
        dbid        = 1701
    }

    LAKEEND.SOF.insertAndApproach(args)
    LAKEEND.SOF.setLowProfile(args.sofName)
    LAKEEND.SOF.flagUnmarked(args.sofName)

    LAKEEND.NARRATIVE.intel(
        "Unidentified armed personnel reported near critical infrastructure. Intent unclear.",
        nil
    )
end

-- ============================================================
-- 13. LAKEEND.TEST — Basic Test Harness
-- ============================================================

LAKEEND.TEST = {}

function LAKEEND.TEST.run()
    LAKEEND.log("Running LAKEEND test suite...")

    local t = {"A","B","C"}
    LAKEEND.log("Random pick: " .. tostring(LAKEEND.randomPick(t)))

    LAKEEND.SAT.init()

    LAKEEND.log("Test suite complete.")
end

-- ============================================================
-- END OF LAKEEND GLOBAL SCRIPT
-- ============================================================
