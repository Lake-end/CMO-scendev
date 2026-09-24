-- ==============================================================================
-- FALKLANDS 2027: ABSTRACTED GROUND CONTROL ENGINE (GCE)
-- SCRIPT 3: CORE ENGINE LOOP (SELF-CONTAINED) v3
-- ==============================================================================
-- README & IMPLEMENTATION GUIDE
--
-- PURPOSE:
-- Evaluates combat power differential in every strategic zone, applies modifiers,
-- calculates hourly control shifts, updates visual UI on the map, and dynamically
-- flips enemy facilities and embarked assets when zones are secured.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: 'Regular Time' trigger set to exactly 1 in-game hour.
-- 2. Action: Lua Script Action (paste this entire block).
--
-- THE REFERENCE POINT UI (DYNAMIC MAP LABELS):
-- - The script scans all UK Reference Points for an RP whose name contains BOTH
--   the base zone name and the string "[CTRL".
-- - MANDATORY SCENARIO EDITOR SETUP: Place a single, locked RP in the center of
--   each zone and name it exactly: ZONE_NAME [CTRL: 0%] (e.g., "ZONE_SAN_CARLOS [CTRL: 0%]").
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

local function IsDevMode()
    local val = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    if val == "false" or val == "0" or val == "FALSE" then
        return false
    end
    return true
end

function GCE_RunEngineCycle()
    local shiftRateMultiplier = 1.5
    local ukSide = VP_GetSide({ side = "UK" })
    if ukSide == nil then return end

    local allUK_RPs = ukSide.rps or {}
    local devMode = IsDevMode()
    local zoneTelemetry = {}
    local isrUnitName = nil

    -- =========================================================
    -- 1. GLOBAL ISR CHECK (ZONE_FALKLANDS_ISR)
    -- =========================================================
    local globalSA = 1.0
    local isrPolygon = {}
    if allUK_RPs ~= nil then
        for _, rp in ipairs(allUK_RPs) do
            if string.find(rp.name, "ZONE_FALKLANDS_ISR") then
                table.insert(isrPolygon, rp.name)
            end
        end
    end

    if #isrPolygon >= 3 then
        local isrUnits = ukSide:unitsInArea({ Area = isrPolygon })
        if isrUnits ~= nil then
            for _, u in ipairs(isrUnits) do
                local unit = ScenEdit_GetUnit({ guid = u.guid })
                if unit ~= nil and unit.type == 'Aircraft' then
                    -- Check for AEW, MPA, or Drones
                    if unit.subtype == 'Airborne_Early_Warning' or unit.subtype == 'Maritime_PatrolAircraft' or unit.subtype == 'UAV' then
                        globalSA = 1.25 -- +25% Global Combat Efficiency
                        isrUnitName = unit.name
                        break
                    end
                end
            end
        end
    end
    ScenEdit_SetKeyValue("GCE_GLOBAL_UK_SA_BONUS", globalSA)

    -- =========================================================
    -- 2. ZONE PROCESSING LOOP
    -- =========================================================
    for _, zoneName in ipairs(GCE_Zones) do
        local ukPwr = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_UK_PWR")) or 0
        local argPwr = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_ARG_PWR")) or 0
        local ctrlPct = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_CTRL_PCT")) or 0
        local morale = (tonumber(ScenEdit_GetKeyValue("GCE_GLOBAL_UK_MORALE")) or 100) / 100
        local supplyTimer = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_SUPPLY_TIMER")) or 0

        local casMod = 1.0
        local ngfsMod = 1.0
        local isSuppliedNow = false
        local activeModsUI = {}

        -- Form Polygon
        local zonePolygon = {}
        if allUK_RPs ~= nil then
            for _, rp in ipairs(allUK_RPs) do
                if string.find(rp.name, zoneName) and not string.find(rp.name, "%[CTRL") then
                    table.insert(zonePolygon, rp.name)
                end
            end
        end

        -- Check Assets in Zone
        if #zonePolygon >= 3 then
            local unitsInZone = ukSide:unitsInArea({ Area = zonePolygon })
            if unitsInZone ~= nil then
                for _, u in ipairs(unitsInZone) do
                    local unit = ScenEdit_GetUnit({ guid = u.guid })
                    if unit ~= nil then
                        -- CAS Check
                        if unit.type == 'Aircraft' and (unit.subtype == 'Fighter' or unit.subtype == 'Attack' or unit.subtype == 'Multirole_FighterAttack' or unit.subtype == 'UCAV' or unit.subtype == 'Utility' or unit.subtype == 'NavalUtility') then
                            casMod = 1.25
                            table.insert(activeModsUI, "CAS")
                        end
                        -- NGFS Check
                        if unit.type == 'Ship' and (unit.subtype == 'SurfaceCombatant' or unit.subtype == 'DDG' or unit.subtype == 'FFG') then
                            ngfsMod = 1.15
                            table.insert(activeModsUI, "NGFS")
                        end
                        -- Supply Tether Check (Amphibious or Aux ships)
                        if unit.type == 'Ship' and (unit.subtype == 'Amphibious' or unit.subtype == 'Auxiliary') then
                            isSuppliedNow = true
                        end
                    end
                end
            end
        end

        -- =========================================================
        -- 3. APPLY TETHER (THE 20% GRACE PERIOD RULE)
        -- =========================================================
        if isSuppliedNow then
            supplyTimer = 24 -- Reset to 24 hours of grace
        elseif supplyTimer > 0 then
            supplyTimer = supplyTimer - 1
        end
        ScenEdit_SetKeyValue("ZCTRL_" .. zoneName .. "_SUPPLY_TIMER", supplyTimer)

        -- Calculate Effective Combat Power
        local ukEffective = ukPwr * globalSA * casMod * ngfsMod * morale
        local argEffective = argPwr

        -- If they are trying to break out of a beachhead (under 50% control) and the tether expires, troops starve
        if ctrlPct < 50 and supplyTimer <= 0 then
            ukEffective = ukEffective * 0.1 -- 90% penalty to combat power
            table.insert(activeModsUI, "UNSUPPLIED")
        end

        -- =========================================================
        -- 4. APPLY MATH & CHECK CAPTURES
        -- =========================================================
        local powerDelta = ukEffective - argEffective
        local shift = (powerDelta / 10) * shiftRateMultiplier

        ctrlPct = ctrlPct + shift
        if ctrlPct > 100 then ctrlPct = 100 end
        if ctrlPct < 0 then ctrlPct = 0 end
        ScenEdit_SetKeyValue("ZCTRL_" .. zoneName .. "_CTRL_PCT", math.floor(ctrlPct))

        -- =========================================================
        -- CAPTURE EVENT PAYOFF (Triggers only once per zone)
        -- =========================================================
        local isSecured = ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_SECURED") or "FALSE"
        if ctrlPct >= 85 and isSecured == "FALSE" then
            ScenEdit_SetKeyValue("ZCTRL_" .. zoneName .. "_SECURED", "TRUE")

            -- BASE HANDOVER LOGIC (Dynamic Area-of-Effect & Hosted Units)
            local enemySideName = "Argentina"
            local enemySide = VP_GetSide({ side = enemySideName })

            if enemySide ~= nil and #zonePolygon >= 3 then
                local enemyUnits = enemySide:unitsInArea({ Area = zonePolygon })
                if enemyUnits ~= nil then
                    for _, u in ipairs(enemyUnits) do
                        local unit = ScenEdit_GetUnit({ guid = u.guid })

                        -- Target Ground Facilities (Airbases, Ports, Ammo Dumps)
                        if unit ~= nil and unit.type == 'Facility' then
                            -- 1. Flip the parent facility
                            ScenEdit_SetUnitSide({ side = unit.side, guid = unit.guid, newside = "UK" })

                            -- 2. Flip embarked units (Aircraft and Boats)
                            if unit.embarkedUnits ~= nil then
                                -- Handle Aircraft
                                if unit.embarkedUnits.Aircraft ~= nil then
                                    for i = 1, #unit.embarkedUnits.Aircraft do
                                        local childGuid = unit.embarkedUnits.Aircraft[i]
                                        ScenEdit_SetUnitSide({ side = unit.side, guid = childGuid, newside = "UK" })
                                    end
                                end

                                -- Handle Boats
                                if unit.embarkedUnits.Boats ~= nil then
                                    for i = 1, #unit.embarkedUnits.Boats do
                                        local childGuid = unit.embarkedUnits.Boats[i]
                                        ScenEdit_SetUnitSide({ side = unit.side, guid = childGuid, newside = "UK" })
                                    end
                                end
                            end
                        end
                    end
                end
            end

            -- MORALE REWARDS
            local moraleBoost = 5
            if zoneName == "ZONE_PLEASANT" or zoneName == "ZONE_STANLEY" then
                moraleBoost = 10
            end

            local newUkMorale = (tonumber(ScenEdit_GetKeyValue("GCE_GLOBAL_UK_MORALE")) or 100) + moraleBoost
            local newArgMorale = (tonumber(ScenEdit_GetKeyValue("GCE_GLOBAL_ARG_MORALE")) or 100) - moraleBoost
            if newUkMorale > 100 then newUkMorale = 100 end
            if newArgMorale < 10 then newArgMorale = 10 end -- Floor ARG morale at 10 to prevent math failure

            ScenEdit_SetKeyValue("GCE_GLOBAL_UK_MORALE", newUkMorale)
            ScenEdit_SetKeyValue("GCE_GLOBAL_ARG_MORALE", newArgMorale)

            local msg = string.format(
            "<b>STRATEGIC VICTORY</b><br>%s has been secured by UK Forces! Global Morale increases by %d%%.<br><br><i>All surviving enemy facilities and their embarked assets in the sector have been captured.</i>",
                zoneName, moraleBoost)
            ScenEdit_SpecialMessage("UK", msg)
        end

        -- =========================================================
        -- 5. UPDATE UI
        -- =========================================================
        local uniqueMods = {}
        local hash = {}
        for _, v in ipairs(activeModsUI) do
            if not hash[v] then
                uniqueMods[#uniqueMods + 1] = v; hash[v] = true
            end
        end
        local modsString = table.concat(uniqueMods, ", ")
        ScenEdit_SetKeyValue("ZCTRL_" .. zoneName .. "_ACTIVE_MODS", modsString)

        local statusStr = "CONTESTED"
        if ctrlPct <= 19 then statusStr = "ARG SECURED" end
        if ctrlPct >= 20 and ctrlPct <= 49 then statusStr = "UK BEACHHEAD" end
        if ctrlPct >= 85 then statusStr = "UK SECURED" end

        local newLabel = string.format("%s [CTRL: %d%%] - %s", zoneName, math.floor(ctrlPct), statusStr)
        if modsString ~= "" then newLabel = newLabel .. " (" .. modsString .. ")" end

        if allUK_RPs ~= nil then
            for _, rp in ipairs(allUK_RPs) do
                if string.find(rp.name, zoneName) and string.find(rp.name, "%[CTRL") then
                    pcall(function() ScenEdit_SetReferencePoint({ side = "UK", guid = rp.guid, newname = newLabel }) end)
                    break
                end
            end
        end

        if devMode then
            table.insert(zoneTelemetry, {
                name        = zoneName,
                oldCtrl     = math.floor(ctrlPct - shift),
                newCtrl     = math.floor(ctrlPct),
                shift       = shift,
                ukBase      = ukPwr,
                argBase     = argPwr,
                globalSA    = globalSA,
                casMod      = casMod,
                ngfsMod     = ngfsMod,
                morale      = morale,
                ukEffective = ukEffective,
                argEffective= argEffective,
                delta       = powerDelta,
                supplied    = isSuppliedNow,
                supplyTimer = supplyTimer,
                mods        = modsString,
                status      = statusStr,
                unitsCount  = (unitsInZone and #unitsInZone or 0)
            })
        end
    end -- <-- THIS IS THE END OF YOUR ZONE PROCESSING LOOP

    -- ==============================================================================
    -- 6. STRATEGIC VICTORY CHECK
    -- ==============================================================================
    local stanleySecured = ScenEdit_GetKeyValue("ZCTRL_ZONE_STANLEY_SECURED") or "FALSE"
    local pleasantSecured = ScenEdit_GetKeyValue("ZCTRL_ZONE_PLEASANT_SECURED") or "FALSE"
    local totalSecured = 0

    for _, zone in ipairs(GCE_Zones) do
        if (ScenEdit_GetKeyValue("ZCTRL_" .. zone .. "_SECURED") or "FALSE") == "TRUE" then
            totalSecured = totalSecured + 1
        end
    end

    -- ==============================================================================
    -- 7. DEVELOPER MODE VERBOSE TELEMETRY DUMP
    -- ==============================================================================
    if devMode then
        local ukMorale = ScenEdit_GetKeyValue("GCE_GLOBAL_UK_MORALE") or "100"
        local argMorale = ScenEdit_GetKeyValue("GCE_GLOBAL_ARG_MORALE") or "100"
        local ukSupply = ScenEdit_GetKeyValue("GCE_GLOBAL_UK_SUPPLY") or "100"
        local ukLosses = ScenEdit_GetKeyValue("GCE_LOSS_SCORE_UK") or "0"

        print("=========================================================================================")
        print(" [GCE DEV TELEMETRY] --- Tactical Ground War Diagnostics ---")
        print("=========================================================================================")
        print(string.format("  GLOBAL METRICS: UK Morale: %s%% | ARG Morale: %s%% | UK Supply: %s%% | UK Losses: %s / 250",
            ukMorale, argMorale, ukSupply, ukLosses))
        print(string.format("  GLOBAL ISR (ZONE_FALKLANDS_ISR): Multiplier x%.2f (Active Aircraft: %s)",
            globalSA, isrUnitName or "None"))
        print("-----------------------------------------------------------------------------------------")
        print(string.format("  %-20s | %-12s | %-14s | %-16s | %-12s",
            "ZONE NAME", "CONTROL", "BASE PWR (U/A)", "EFF PWR (U/A)", "STATUS & MODS"))
        print("-----------------------------------------------------------------------------------------")
        for _, z in ipairs(zoneTelemetry) do
            local ctrlShiftStr = string.format("%d%% (%+d%%)", z.newCtrl, math.floor(z.shift))
            local basePwrStr = string.format("%d / %d", z.ukBase, z.argBase)
            local effPwrStr = string.format("%.1f / %.1f", z.ukEffective, z.argEffective)
            local modStr = z.mods ~= "" and (" [" .. z.mods .. "]") or ""
            print(string.format("  %-20s | %-12s | %-14s | %-16s | %s%s",
                z.name:gsub("ZONE_", ""), ctrlShiftStr, basePwrStr, effPwrStr, z.status, modStr))
            print(string.format("    -> Modifiers: ISR(x%.2f) CAS(x%.2f) NGFS(x%.2f) Morale(x%.2f) | SupplyTether: %dh | UnitsInArea: %d",
                z.globalSA, z.casMod, z.ngfsMod, z.morale, z.supplyTimer, z.unitsCount))
        end
        print("-----------------------------------------------------------------------------------------")
        print(string.format("  STRATEGIC VICTORY PROGRESS: %d / 11 Zones Secured | Stanley: %s | Pleasant: %s (Threshold: 8)",
            totalSecured, stanleySecured, pleasantSecured))
        print("=========================================================================================")
    end

    if stanleySecured == "TRUE" and pleasantSecured == "TRUE" then
        -- Win condition: Stanley + Pleasant + at least 6 other zones (8/11 total)
        if totalSecured >= 8 then
            local msg = string.format([[
                <body bgcolor="#121212" text="#50E3C2" style="font-family: Arial, sans-serif;">
                    <h2>TASK FORCE FALKLANDS: MISSION ACCOMPLISHED</h2>
                    <p>With the capture of Stanley and Mount Pleasant Airfield, along with %d of 11 strategic sectors, Argentine resistance on East and West Falkland has collapsed.</p>
                    <p>Surviving enemy forces have initiated a general surrender.</p>
                    <h3>OUTSTANDING STRATEGIC VICTORY</h3>
                </body>
            ]], totalSecured)

            ScenEdit_SpecialMessage("UK", msg)
            ScenEdit_EndScenario()
        end
    end
end -- <-- THIS IS THE END OF THE GCE_RunEngineCycle FUNCTION

GCE_RunEngineCycle()
