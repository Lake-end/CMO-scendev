-- ==============================================================================
-- FALKLANDS 2027: RANDOM EVENT ENGINE (REE)
-- SCRIPT 1: MASTER INITIALIZATION & KVS SEEDING v2
-- ==============================================================================
-- PURPOSE:
-- Seeds the CMO Key-Value Store (KVS) with baseline tracking variables for the
-- dynamic month-long Falklands 2027 Random Event Engine.
--
-- INTEGRATION IN CMO SCENARIO EDITOR:
-- 1. Trigger: 'Time' trigger set to 1 second after scenario start (or 'Scenario Loaded').
-- 2. Action: Lua Script Action (paste this entire block).
-- 3. Condition: None required.
-- ==============================================================================

local function LogInit(msg)
    print("[REE Init] " .. msg)
end

LogInit("==================================================")
LogInit("Initializing Falklands 2027 Random Event Engine...")
LogInit("==================================================")

-- 1. CONFIGURABLE SCENARIO PARAMETERS
local DEFAULT_SCENARIO_DAYS = 30 -- Standard month-long campaign (configurable)
local currentMaxDays = ScenEdit_GetKeyValue("REE_CONFIG_MAX_DAYS")
if currentMaxDays == "" or currentMaxDays == nil then
    ScenEdit_SetKeyValue("REE_CONFIG_MAX_DAYS", tostring(DEFAULT_SCENARIO_DAYS))
    LogInit("Configured Scenario Duration: " .. DEFAULT_SCENARIO_DAYS .. " days (" .. (DEFAULT_SCENARIO_DAYS * 24) .. " hours)")
else
    LogInit("Existing Scenario Duration preserved: " .. currentMaxDays .. " days")
end

-- 2. INITIALIZE TRACKING VARIABLES (Safe: do not wipe if already running mid-scenario)
local function SafeInitKey(key, defaultVal)
    local existing = ScenEdit_GetKeyValue(key)
    if existing == "" or existing == nil then
        ScenEdit_SetKeyValue(key, tostring(defaultVal))
        return tostring(defaultVal)
    end
    return existing
end

-- 1.1 GLOBAL DEVELOPER MODE (Default: true for testing; set to "false" manually for release)
SafeInitKey("FALKL_DEV_MODE", "true")
SafeInitKey("REE_DEV_FORCE_EVENT_HOURLY", "false") -- Set to "true" to trigger an event every hour in Dev Mode
SafeInitKey("REE_DEV_FORCE_SEQUENTIAL", "false")   -- Set to "true" to test all events sequentially (EVT_01 -> EVT_29)
LogInit("Global Developer Mode (FALKL_DEV_MODE): " .. ScenEdit_GetKeyValue("FALKL_DEV_MODE"))

SafeInitKey("REE_INITIALIZED", "true")
SafeInitKey("REE_SCENARIO_HOUR", "0")
SafeInitKey("REE_LAST_PLANNED_DAY", "0")
SafeInitKey("REE_SCHEDULED_HOURS", "")
SafeInitKey("REE_EXECUTED_EVENTS", "")

-- 3. PLAN DAY 1 SCHEDULE IMMEDIATELY
-- Day 1 spans hours 1 to 24.
-- Two 12-hour slots: Slot 1 (hours 1..12), Slot 2 (hours 13..24). 50% chance each.
local day1Hours = {}

-- Slot 1 roll (50%)
if math.random() <= 0.50 then
    local h1 = math.random(1, 12)
    table.insert(day1Hours, h1)
    LogInit("Day 1: Slot 1 (00:00-12:00) event scheduled for Hour " .. h1)
else
    LogInit("Day 1: Slot 1 (00:00-12:00) roll: No event")
end

-- Slot 2 roll (50%)
if math.random() <= 0.50 then
    local h2 = math.random(13, 24)
    table.insert(day1Hours, h2)
    LogInit("Day 1: Slot 2 (12:00-24:00) event scheduled for Hour " .. h2)
else
    LogInit("Day 1: Slot 2 (12:00-24:00) roll: No event")
end

table.sort(day1Hours)
local schedStr = table.concat(day1Hours, ",")
ScenEdit_SetKeyValue("REE_SCHEDULED_HOURS", schedStr)
ScenEdit_SetKeyValue("REE_LAST_PLANNED_DAY", "1")

LogInit("Day 1 Event Hours: [" .. schedStr .. "] (Count: " .. #day1Hours .. ")")
LogInit("Falklands 2027 Random Event Engine successfully initialized.")