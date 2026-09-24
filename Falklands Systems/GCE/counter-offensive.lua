-- ==============================================================================
-- FALKLANDS 2027: ABSTRACTED GROUND CONTROL ENGINE (GCE)
-- SCRIPT 5: ARG AI COUNTER-OFFENSIVE DIRECTOR (PHYSICAL SPAWNS) v2
-- ==============================================================================

local GCE_Zones        = {
    "ZONE_SAN_CARLOS", "ZONE_BLUFF_COVE", "ZONE_GOOSE_GREEN", "ZONE_MT_KENT",
    "ZONE_FALKLAND_SOUND", "ZONE_PORT_HOWARD", "ZONE_FOX_BAY",
    "ZONE_TEAL_INLET", "ZONE_PEBBLE_ISLAND", "ZONE_STANLEY", "ZONE_PLEASANT"
}

-- Coastal zones that are eligible to spawn SSM (Exocet) batteries
local Coastal_Zones    = {
    ["ZONE_SAN_CARLOS"]     = true,
    ["ZONE_BLUFF_COVE"]     = true,
    ["ZONE_FALKLAND_SOUND"] = true,
    ["ZONE_PORT_HOWARD"]    = true,
    ["ZONE_FOX_BAY"]        = true,
    ["ZONE_TEAL_INLET"]     = true,
    ["ZONE_PEBBLE_ISLAND"]  = true,
    ["ZONE_STANLEY"]        = true
}

-- ==============================================================================
-- DATABASE IDs
-- ==============================================================================
local DBID_ARG_MANPADS = 3913 -- e.g., RBS-70 or Igla Platoon
local DBID_ARG_SSM     = 3913 -- e.g., Exocet Coastal Battery
local DBID_ARG_STRIKE  = 73   -- e.g., A-4AR Fightinghawk or Su-24
local DBID_ARG_LOADOUT = 390  -- e.g., Iron Bombs or Stand-off Munitions

local function IsDevMode()
    local val = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    if val == "false" or val == "0" or val == "FALSE" then
        return false
    end
    return true
end

function GCE_ARG_CounterAttack()
    math.randomseed(ScenEdit_CurrentTime())
    local devMode = IsDevMode()

    local roll = math.random(1, 100)
    -- 25% chance to launch a counter-attack every time this script runs
    if roll > 25 then
        if devMode then
            print(string.format("[GCE Counter-Attack DEBUG] Evaluated: Roll was %d/100 (Threshold <= 25). No assault launched this cycle.", roll))
        end
        return
    end

    local eligibleTargets = {}

    -- Find zones where the UK is pushing hard (>50% control)
    for _, zone in ipairs(GCE_Zones) do
        local ukCtrl = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zone .. "_CTRL_PCT")) or 0
        if ukCtrl >= 50 then
            table.insert(eligibleTargets, zone)
        end
    end

    if #eligibleTargets > 0 then
        local targetZone = eligibleTargets[math.random(1, #eligibleTargets)]

        -- 1. ABSTRACT INJECTION (The Math)
        local currentArgPwr = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. targetZone .. "_ARG_PWR")) or 0
        ScenEdit_SetKeyValue("ZCTRL_" .. targetZone .. "_ARG_PWR", currentArgPwr + 150)

        local currentUkCtrl = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. targetZone .. "_CTRL_PCT")) or 0
        local newUkCtrl = currentUkCtrl - 10
        if newUkCtrl < 0 then newUkCtrl = 0 end
        ScenEdit_SetKeyValue("ZCTRL_" .. targetZone .. "_CTRL_PCT", math.floor(newUkCtrl))

        if (ScenEdit_GetKeyValue("ZCTRL_" .. targetZone .. "_SECURED") or "FALSE") == "TRUE" then
            ScenEdit_SetKeyValue("ZCTRL_" .. targetZone .. "_SECURED", "FALSE")
        end

        if devMode then
            print(string.format("[GCE Counter-Attack DEBUG] >>> LAUNCHING COUNTER-OFFENSIVE AT %s! Injected +150 ARG PWR (New Total: %d). UK Control shifted from %d%% to %d%%.",
                targetZone, currentArgPwr + 150, currentUkCtrl, math.floor(newUkCtrl)))
        end

        -- 2. PHYSICAL SPAWNS (The Tactical Threat)
        local ukSide = VP_GetSide({ side = "UK" })
        if ukSide == nil then return end
        local allUK_RPs = ukSide.rps or {}
        local zonePolygon = {}
        local latSum, lonSum, rpCount = 0, 0, 0

        -- Gather RPs and calculate the geographic center of the zone
        if allUK_RPs ~= nil then
            for _, rp in ipairs(allUK_RPs) do
                if string.find(rp.name, targetZone) and not string.find(rp.name, "%[CTRL") then
                    table.insert(zonePolygon, rp.name)
                    latSum = latSum + rp.latitude
                    lonSum = lonSum + rp.longitude
                    rpCount = rpCount + 1
                end
            end
        end

        if rpCount >= 3 then
            local centerLat = latSum / rpCount
            local centerLon = lonSum / rpCount

            -- Spawn MANPADS at the center of the zone
            if DBID_ARG_MANPADS > 0 then
                ScenEdit_AddUnit({
                    side = "Argentina",
                    type = "Facility",
                    name = "Ambush MANPADS - " .. targetZone,
                    dbid = DBID_ARG_MANPADS,
                    latitude = centerLat,
                    longitude = centerLon
                })
            end

            -- Spawn Coastal SSM if the zone is coastal
            if Coastal_Zones[targetZone] and DBID_ARG_SSM > 0 then
                -- Offset slightly so they don't stack on top of the MANPADS
                ScenEdit_AddUnit({
                    side = "Argentina",
                    type = "Facility",
                    name = "Ambush SSM - " .. targetZone,
                    dbid = DBID_ARG_SSM,
                    latitude = centerLat + 0.02,
                    longitude = centerLon + 0.02
                })
            end

            -- 3. THE AIR RAID
            if DBID_ARG_STRIKE > 0 then
                local missionName = "QRA Strike - " .. targetZone

                -- Create the mission dynamically if it doesn't exist
                if ScenEdit_GetMission("Argentina", missionName) == nil then
                    ScenEdit_AddMission("Argentina", missionName, "patrol", { type = "land", PatrolZone = zonePolygon })
                end

                -- Spawn the aircraft roughly 100 NM to the West of the target zone at 15,000 ft
                local flightName = "Raid Flight " .. math.random(100, 999)
                local strikeAircraft = ScenEdit_AddUnit({
                    side = "Argentina",
                    type = "Aircraft",
                    name = flightName,
                    dbid = DBID_ARG_STRIKE,
                    loadoutid = DBID_ARG_LOADOUT,
                    latitude = centerLat,
                    longitude = centerLon - 2.5,
                    altitude = 5000
                })

                if strikeAircraft ~= nil then
                    ScenEdit_AssignUnitToMission(strikeAircraft.guid, missionName)
                end
            end
        end

        -- 4. PLAYER NOTIFICATION
        local msg = string.format(
            "<b>FLASH OVERRIDE - HIGH PRIORITY</b><br><br>Warning! Satellite imagery and SIGINT confirm a major Argentine counter-offensive is underway at <b>%s</b>.<br><br>Enemy combat power in the sector has surged, and pop-up air defense threats have been detected in the zone. Fast-movers are inbound from the mainland.<br><br>Immediate Close Air Support (CAS) or troop reinforcements are required to prevent a collapse of the line.",
            targetZone
        )
        ScenEdit_SpecialMessage("UK", msg)
    end
end

-- Execute script
GCE_ARG_CounterAttack()
