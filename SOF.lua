-- ============================================================
--  LAKEEND.SOF — Covert Ground Actions & "Little Green Men"
-- ============================================================


--[[
===============================================================
LAKEEND.SOF MODULE — README & MISSION DESCRIPTIONS
===============================================================

ABOUT THIS MODULE
-----------------
LAKEEND.SOF provides a high-level, abstracted way to model covert
ground actions ("little green men") in Command: Modern Operations.
CMO does not simulate infantry firefights directly, so this module
represents SOF actions through movement, state changes, and events.

This includes:
- Spawning SOF units
- Moving them toward objectives
- Disabling or capturing facilities
- Extracting or holding position
- Low-profile / ambiguous behavior
- Narrative messages and event hooks

All actions are abstract and non-graphic, focusing on effects and
scenario logic rather than tactical combat.

===============================================================
MISSION PACK OVERVIEW
===============================================================

The LAKEEND.SOF mission pack includes three core mission types:

1) SABOTAGE & EXFIL
2) CAPTURE & HOLD
3) AMBIGUOUS PRESENCE

These missions can be triggered by events, escalation levels, or
player actions. Each mission is modular and can be reused across
scenarios.

===============================================================
MISSION TYPE 1 — SABOTAGE & EXFIL
===============================================================

DESCRIPTION:
A covert SOF team appears near the AO, moves toward a facility,
disables it upon arrival, then withdraws to an extraction point
and despawns. This models a deniable sabotage action.

FLOW:
1. Spawn SOF at hidden location
2. Move toward target facility
3. When entering trigger zone:
     - Disable facility (isactive=false)
     - Show narrative message
4. Move SOF back to extraction point
5. Despawn SOF

NOTES:
- Movement is intentionally slow and deliberate
- SOF uses low-profile EMCON
- Player may detect or intercept depending on scenario design

===============================================================
MISSION TYPE 2 — CAPTURE & HOLD
===============================================================

DESCRIPTION:
A covert SOF team approaches a facility and seizes control of it.
Ownership changes to the attacking side. The SOF team remains in
place to represent occupation or control.

FLOW:
1. Spawn SOF at hidden location
2. Move toward target facility
3. When entering trigger zone:
     - Change facility owner (side="Red" or other)
     - Show narrative message
4. SOF remains near the facility

NOTES:
- Represents a deniable seizure of infrastructure
- Works well with escalation logic
- Can trigger follow-on missions or political consequences

===============================================================
MISSION TYPE 3 — AMBIGUOUS PRESENCE
===============================================================

DESCRIPTION:
A SOF team appears near critical infrastructure but does not take
immediate action. Their presence creates tension and uncertainty.
They may later receive orders to sabotage, capture, or withdraw.

FLOW:
1. Spawn SOF near AO
2. Move to a staging point near facility
3. Show intel-style narrative message
4. SOF remains idle until another event directs them

NOTES:
- Useful for early-phase hybrid pressure
- Can escalate into sabotage or capture missions
- Can be used to mislead or distract the player

===============================================================
MODELING "LITTLE GREEN MEN" IN CMO
===============================================================

Since CMO does not simulate infantry firefights, this module uses
abstracted effects to represent covert ground actions:

- SOF units move slowly and quietly
- They operate with passive EMCON
- They trigger effects when reaching a facility:
    * disable facility
    * damage facility
    * change ownership
    * trigger narrative events
- They may exfiltrate or remain in place
- Their identity is intentionally ambiguous

This approach fits hybrid warfare scenarios and maintains CMO's
abstraction level while enabling dynamic, reactive gameplay.

===============================================================
END OF README
===============================================================
]]--



LAKEEND.SOF = {}

---------------------------------------------------------------
-- CORE SPAWN / DESPAWN
---------------------------------------------------------------

function LAKEEND.SOF.spawn(name, side, lat, lon, dbid)
    dbid = dbid or 1701  -- Generic SOF / special forces team
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

---------------------------------------------------------------
-- MOVEMENT HELPERS
---------------------------------------------------------------

function LAKEEND.SOF.moveTo(name, lat, lon)
    ScenEdit_SetUnit({
        name = name,
        course = { {lat, lon} }
    })
    LAKEEND.log("SOF moving: " .. name .. " → (" .. lat .. "," .. lon .. ")")
end

function LAKEEND.SOF.moveAlongPath(name, points)
    -- points = { {lat1,lon1}, {lat2,lon2}, ... }
    ScenEdit_SetUnit({
        name = name,
        course = points
    })
    LAKEEND.log("SOF moving along path: " .. name)
end

---------------------------------------------------------------
-- FACILITY EFFECTS (SABOTAGE / CAPTURE)
---------------------------------------------------------------

-- Disable facility (sabotage)
function LAKEEND.SOF.disableFacility(facility)
    ScenEdit_SetUnit({name = facility, isactive = false})
    LAKEEND.log("Facility disabled (SOF action): " .. facility)
end

-- Damage facility (abstracted)
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

-- Capture facility (change owner)
function LAKEEND.SOF.captureFacility(facility, newSide)
    ScenEdit_SetUnit({name = facility, side = newSide})
    LAKEEND.log("Facility captured: " .. facility .. " → " .. newSide)
end

---------------------------------------------------------------
-- INSERTION / EXTRACTION PATTERNS
---------------------------------------------------------------

function LAKEEND.SOF.insertAndApproach(args)
    -- args: { sofName, side, spawnLat, spawnLon, approachLat, approachLon, dbid }
    LAKEEND.SOF.spawn(args.sofName, args.side, args.spawnLat, args.spawnLon, args.dbid)
    LAKEEND.SOF.moveTo(args.sofName, args.approachLat, args.approachLon)
end

function LAKEEND.SOF.extract(name, lat, lon)
    LAKEEND.SOF.moveTo(name, lat, lon)
    LAKEEND.log("SOF extracting: " .. name)
end

---------------------------------------------------------------
-- HIGH-LEVEL ACTIONS
---------------------------------------------------------------

-- Pattern 1: Sabotage and exfiltrate
function LAKEEND.SOF.sabotageAndExfil(args)
    -- args: { sofName, facility, extractLat, extractLon, message }
    LAKEEND.SOF.disableFacility(args.facility)
    if args.message then
        LAKEEND.NARRATIVE.message(args.message)
    end
    LAKEEND.SOF.extract(args.sofName, args.extractLat, args.extractLon)
end

-- Pattern 2: Capture and hold
function LAKEEND.SOF.captureAndHold(args)
    -- args: { sofName, facility, newSide, message }
    LAKEEND.SOF.captureFacility(args.facility, args.newSide)
    if args.message then
        LAKEEND.NARRATIVE.message(args.message)
    end
    LAKEEND.log("SOF holding position at: " .. args.facility)
end

---------------------------------------------------------------
-- STEALTH / "LITTLE GREEN MEN" BEHAVIOR
---------------------------------------------------------------

function LAKEEND.SOF.setLowProfile(name)
    -- Abstracted: reduce emissions, no obvious signatures
    ScenEdit_SetEMCON(name, "Radar=Passive;OECM=Passive")
    LAKEEND.log("SOF set to low profile: " .. name)
end

function LAKEEND.SOF.randomPause(name, minSec, maxSec)
    local delay = math.random(minSec, maxSec)
    LAKEEND.EVENTS.schedule("EVT_SOF_RESUME_" .. name, delay)
    LAKEEND.log("SOF random pause: " .. name .. " for " .. delay .. " sec")
end

-- Mark that SOF is "unmarked" / ambiguous (purely narrative)
function LAKEEND.SOF.flagUnmarked(name)
    LAKEEND.set("SOF_UNMARKED_" .. name, "1")
    LAKEEND.log("SOF flagged as unmarked: " .. name)
end
