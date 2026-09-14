-- ============================================================
--  LAKEEND.MARITIME — Maritime Hybrid Threat Module
-- ============================================================

LAKEEND.MARITIME = {}

-- Mark a vessel as suspicious
function LAKEEND.MARITIME.flagSuspicious(name)
    LAKEEND.set("SuspiciousVessel", name)
    LAKEEND.log("Vessel flagged as suspicious: " .. name)
end

-- Trigger hybrid maritime escalation when detected
function LAKEEND.MARITIME.onDetected(name)
    local u = ScenEdit_GetUnit({name=name})
    if u and u.detectedby then
        ScenEdit_TriggerEvent("HybridStrike")
        LAKEEND.log("Suspicious vessel detected: " .. name)
    end
end

-- Covert platform destruction → retaliation
function LAKEEND.MARITIME.onPlatformDestroyed(name)
    if not LAKEEND.existsUnit(name) then
        ScenEdit_TriggerEvent("Retaliation")
        LAKEEND.log("Covert maritime platform destroyed: " .. name)
    end
end

-- Random suspicious vessel behavior
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
