-- ============================================================
--  LAKEEND.EVENTS — Event Wiring Helper Module
-- ============================================================

LAKEEND.EVENTS = {}

-- Trigger event by name
function LAKEEND.EVENTS.fire(name)
    ScenEdit_TriggerEvent(name)
    LAKEEND.log("Event fired: " .. name)
end

-- Schedule event after delay (seconds)
function LAKEEND.EVENTS.schedule(name, delay)
    ScenEdit_ScheduleTimeEvent(name, delay)
    LAKEEND.log("Event scheduled: " .. name .. " in " .. delay .. " sec")
end

-- Conditional event firing
function LAKEEND.EVENTS.fireIf(condition, eventName)
    if condition then
        ScenEdit_TriggerEvent(eventName)
        LAKEEND.log("Conditional event fired: " .. eventName)
    end
end

-- Fire random event from list
function LAKEEND.EVENTS.random(list)
    local pick = LAKEEND.randomPick(list)
    ScenEdit_TriggerEvent(pick)
    LAKEEND.log("Random event fired: " .. pick)
end
