-- ============================================================
--  LAKEEND.CYBER — Cyber Pressure & Comms Degradation Module
-- ============================================================

LAKEEND.CYBER = {}

-- Random comms outage on a unit
function LAKEEND.CYBER.commsOut(name)
    ScenEdit_SetUnit({name=name, isactive=false})
    LAKEEND.log("Comms outage applied to: " .. name)
    ScenEdit_TriggerEvent("CommsOut_" .. name)
end

-- Restore comms
function LAKEEND.CYBER.commsRestore(name)
    ScenEdit_SetUnit({name=name, isactive=true})
    LAKEEND.log("Comms restored: " .. name)
    ScenEdit_TriggerEvent("CommsRestored_" .. name)
end

-- Random spoofing effect
function LAKEEND.CYBER.spoof(name)
    local u = ScenEdit_GetUnit({name=name})
    if not u then return end

    local lat = u.latitude + (math.random() * 0.1 - 0.05)
    local lon = u.longitude + (math.random() * 0.1 - 0.05)

    ScenEdit_SetUnit({name=name, latitude=lat, longitude=lon})
    LAKEEND.log("Spoofing applied to: " .. name)
end

-- Network degradation (affects multiple units)
function LAKEEND.CYBER.networkDegrade(list)
    for _, name in ipairs(list) do
        ScenEdit_SetUnit({name=name, isactive=false})
    end
    LAKEEND.log("Network degradation applied to group.")
end
