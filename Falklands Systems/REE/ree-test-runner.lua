-- ==============================================================================
-- FALKLANDS 2027: RANDOM EVENT ENGINE (REE)
-- SCRIPT 3: DEVELOPER TEST RUNNER & EVENT SUITE v1
-- ==============================================================================
-- PURPOSE:
-- Interactive developer utility for scenario designers and playtesters.
-- Allows instantaneous execution, verification, and debugging of all 29 Random Events,
-- controls hourly test firing, and resets campaign event tracking.
--
-- HOW TO USE IN CMO:
-- 1. Run this entire script in the CMO Interactive Lua Console (or via a Special Action).
-- 2. Call any of the exposed utility functions:
--    - REE_SetHourlyRunner(true)    --> Forces REE to fire an event EVERY hour.
--    - REE_SetSequentialRunner(true)--> Forces REE to cycle events in sequence (EVT_01 -> EVT_29).
--    - REE_ResetAllEvents()         --> Clears event history so all events can be re-tested.
--    - REE_PrintStatus()            --> Dumps comprehensive REE telemetry to the console.
-- ==============================================================================

local function IsDevMode()
    local val = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    if val == "false" or val == "0" or val == "FALSE" then
        return false
    end
    return true
end

function REE_PrintStatus()
    local h = ScenEdit_GetKeyValue("REE_SCENARIO_HOUR") or "0"
    local dev = ScenEdit_GetKeyValue("FALKL_DEV_MODE") or "true"
    local hourly = ScenEdit_GetKeyValue("REE_DEV_FORCE_EVENT_HOURLY") or "false"
    local seq = ScenEdit_GetKeyValue("REE_DEV_FORCE_SEQUENTIAL") or "false"
    local sched = ScenEdit_GetKeyValue("REE_SCHEDULED_HOURS") or "<none>"
    local executed = ScenEdit_GetKeyValue("REE_EXECUTED_EVENTS") or "<none>"
    local lastEvt = ScenEdit_GetKeyValue("REE_LAST_TRIGGERED_EVENT") or "<none>"

    print("================================================================================")
    print(" [REE DEVELOPER STATUS TELEMETRY]")
    print("================================================================================")
    print(string.format("  * Current Scenario Hour: %s (Day %d)", h, math.floor((tonumber(h) or 0) / 24) + 1))
    print(string.format("  * Global Dev Mode (FALKL_DEV_MODE): %s", tostring(dev)))
    print(string.format("  * Force Hourly Event Mode: %s", tostring(hourly)))
    print(string.format("  * Force Sequential Mode: %s", tostring(seq)))
    print(string.format("  * Scheduled Hours for Day: [%s]", sched))
    print(string.format("  * Last Triggered Event: %s", lastEvt))
    print(string.format("  * All Executed Events: [%s]", executed))
    print("--------------------------------------------------------------------------------")
    print("  Milestone Tiers:")
    print("    - T0 (Transit / Open Ocean): UNLOCKED (Always true)")
    print("    - T1 (Ascension Island):     " .. tostring(ScenEdit_GetKeyValue("UK_CARRIER_ARRIVES_ASCENSION") == "true"))
    print("    - T2 (Falklands Approaches): " .. tostring(ScenEdit_GetKeyValue("UK_CARRIER_ARRIVES_FALKLAND_APPROACHES") == "true"))
    print("    - T3 (Greater Zone Spotted): " .. tostring(ScenEdit_GetKeyValue("UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE") == "true"))
    print("    - T4 (Vicinity Spotted):     " .. tostring(ScenEdit_GetKeyValue("UK_UNITS_SPOTTED_VICINITY_FALKLANDS") == "true"))
    print("================================================================================")
end

function REE_SetHourlyRunner(enable)
    local state = (enable == true or enable == "true" or enable == 1) and "true" or "false"
    ScenEdit_SetKeyValue("REE_DEV_FORCE_EVENT_HOURLY", state)
    print(string.format("[REE Test Runner] Set REE_DEV_FORCE_EVENT_HOURLY = %s. %s",
        state, (state == "true" and "REE will now fire an event on EVERY hour tick." or "Standard two-slot randomized scheduling restored.")))
end

function REE_SetSequentialRunner(enable)
    local state = (enable == true or enable == "true" or enable == 1) and "true" or "false"
    ScenEdit_SetKeyValue("REE_DEV_FORCE_SEQUENTIAL", state)
    print(string.format("[REE Test Runner] Set REE_DEV_FORCE_SEQUENTIAL = %s. %s",
        state, (state == "true" and "Events will now cycle sequentially (EVT_01 -> EVT_29)." or "Standard random pool selection restored.")))
end

function REE_ResetAllEvents()
    for i = 1, 30 do
        local idStr = string.format("EVT_%02d", i)
        ScenEdit_SetKeyValue("REE_EVENT_USED_" .. idStr, "false")
        local altIdStr = string.format("EVT_%d", i)
        ScenEdit_SetKeyValue("REE_EVENT_USED_" .. altIdStr, "false")
    end
    ScenEdit_SetKeyValue("REE_EXECUTED_EVENTS", "")
    print("[REE Test Runner] All REE event lockout flags have been CLEARED. All events can be triggered again.")
end

-- Immediately print telemetry upon running
REE_PrintStatus()
