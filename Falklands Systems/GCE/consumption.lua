-- ==============================================================================
-- FALKLANDS 2027: ABSTRACTED GROUND CONTROL ENGINE (GCE)
-- SCRIPT 2: CONSUMPTION INFILTRATION SCRIPT (SELF-CONTAINED)
-- ==============================================================================
-- README & IMPLEMENTATION GUIDE
--
-- PURPOSE:
-- Scans designated strategic zones for newly arrived friendly ground units,
-- converts those units into numerical "Combat Power" points, saves those points
-- to the Key-Value (KV) store, and deletes the physical units from the map.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: 'Regular Time' trigger set to evaluate every 15 or 30 minutes, or
--    'Unit Remains in Area' for instant processing.
-- 2. Action: Lua Script Action (paste this entire block).
-- 3. Condition: "Scenario Has Started" (prevents editor accidents).
--
-- MAP & REFERENCE POINT (RP) REQUIREMENTS:
-- - Boundary RPs MUST be named sequentially using the zone name as a prefix
--   (e.g., "ZONE_SAN_CARLOS_1", "ZONE_SAN_CARLOS_2").
-- - Do NOT include the word "[CTRL" in your boundary RP names.
--
-- API USAGE NOTES:
-- - Utilizes the Side wrapper method `unitsInArea({Area})` which returns a
--   table of unit descriptors, optionally filtered.
-- - Extracts the `.guid` property from each descriptor to fetch the actual
--   unit wrapper via `ScenEdit_GetUnit`.
-- ==============================================================================

local GCE_Zones = {
    "ZONE_SAN_CARLOS",
    "ZONE_BLUFF_COVE",
    "ZONE_GOOSE_GREEN",
    "ZONE_MT_KENT",
    "ZONE_FALKLAND_SOUND",
    "ZONE_PORT_HOWARD",
    "ZONE_FOX_BAY",
    "ZONE_TEAL_INLET",
    "ZONE_PEBBLE_ISLAND",
    "ZONE_STANLEY",
    "ZONE_PLEASANT"
}

local GCE_UnitPowerMapping = {
    -- UK Forces
    ["Royal Marine Strike Team"]      = 30,
    ["Royal Marine Commando Coy"]     = 120,
    ["SAS Troop"]                     = 80,
    ["SBS Troop"]                     = 80,
    ["Pathfinder Platoon"]            = 70,
    ["Parachute Regiment Coy"]        = 110,
    ["Gurkha Rifles Coy"]             = 110,
    ["L118 Light Gun Battery"]        = 100,
    ["Exactor (Spike NLOS) Battery"]  = 150,
    ["Javelin ATGM Section"]          = 40,
    ["Starstreak HVM Troop"]          = 50,
    ["Combat Engineer Troop"]         = 60,

    -- ARG Forces
    ["Comandos Anfibios Group"]       = 80,
    ["Buzos Tacticos"]                = 80,
    ["IMARA Marine Coy"]              = 110,
    ["FDR Paratrooper Coy"]           = 100,
    ["Mechanized Infantry Coy (TAM)"] = 130,
    ["Motorized Infantry Coy"]        = 90,
    ["Conscript Platoon"]             = 20,
    ["Oto Melara 105mm Battery"]      = 80,
    ["CITEDEF 155mm Battery"]         = 120,
    ["RBS-70 MANPADS Section"]        = 40,
    ["Exocet Coastal Battery"]        = 150
}

function GCE_ConsumeForces()
    local logMessages = {}
    local ukSide = VP_GetSide({ side = "UK" })

    -- GUARD CLAUSE: Safely abort if the UK side doesn't exist
    if ukSide == nil then
        ScenEdit_Print("GCE Error: Side 'UK' not found. Cannot run consumption.")
        return
    end

    for _, zoneName in ipairs(GCE_Zones) do
        local rps = ScenEdit_GetReferencePoints({ side = "UK" })
        local zonePolygon = {}

        -- Safely check if rps exists before attempting to iterate over it
        if rps ~= nil then
            for _, rp in ipairs(rps) do
                if string.find(rp.name, zoneName) and not string.find(rp.name, "%[CTRL") then
                    table.insert(zonePolygon, rp.name)
                end
            end
        end

        if #zonePolygon >= 3 then
            local unitsInZone = ukSide:unitsInArea({ Area = zonePolygon })

            if unitsInZone ~= nil then
                local zonePointsAdded = 0
                local unitsConsumedList = {}

                for _, u_descriptor in ipairs(unitsInZone) do
                    local unit = ScenEdit_GetUnit({ guid = u_descriptor.guid })

                    if unit ~= nil and unit.type == 'Facility' then
                        for mapName, pointValue in pairs(GCE_UnitPowerMapping) do
                            if string.find(unit.name, mapName) then
                                local currentPower = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_UK_PWR")) or
                                    0
                                ScenEdit_SetKeyValue("ZCTRL_" .. zoneName .. "_UK_PWR", currentPower + pointValue)

                                zonePointsAdded = zonePointsAdded + pointValue
                                table.insert(unitsConsumedList, unit.name)

                                ScenEdit_DeleteUnit({ guid = unit.guid })
                                break
                            end
                        end
                    end
                end

                if zonePointsAdded > 0 then
                    local msg = string.format(
                        "[LOGISTICS NET] Deployment successful at %s. +%d Combat Power.\nUnits Integrated:\n- %s",
                        zoneName, zonePointsAdded, table.concat(unitsConsumedList, "\n- "))
                    table.insert(logMessages, msg)
                end
            end
        end
    end

    if #logMessages > 0 then
        local finalLog = table.concat(logMessages, "\n\n")
        ScenEdit_SpecialMessage("UK", finalLog)
    end
end

GCE_ConsumeForces()
