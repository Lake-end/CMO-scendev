-- ============================================================
--  LAKEEND.NARRATIVE — Messages, Intel Drops, Briefings
-- ============================================================

LAKEEND.NARRATIVE = {}

-- Simple message to player
function LAKEEND.NARRATIVE.message(text)
    ScenEdit_MsgBox(text)
    LAKEEND.log("Message shown: " .. text)
end

-- Intel drop (message + optional event)
function LAKEEND.NARRATIVE.intel(text, followupEvent)
    ScenEdit_MsgBox("[INTEL] " .. text)
    LAKEEND.log("Intel drop: " .. text)

    if followupEvent then
        ScenEdit_TriggerEvent(followupEvent)
        LAKEEND.log("Intel follow-up event fired: " .. followupEvent)
    end
end

-- Briefing update (append to side briefing)
function LAKEEND.NARRATIVE.briefing(side, text)
    local s = ScenEdit_GetSide({side=side})
    local newBrief = (s.briefing or "") .. "\n\n" .. text
    ScenEdit_SetSide({side=side, briefing=newBrief})
    LAKEEND.log("Briefing updated for side: " .. side)
end

-- Narrative escalation message
function LAKEEND.NARRATIVE.escalation(level)
    local msg = {
        [1] = "Hybrid pressure intensifies across the region.",
        [2] = "Coordinated disruptions detected in multiple domains.",
        [3] = "Crisis escalating toward open confrontation."
    }

    ScenEdit_MsgBox(msg[level] or "Escalation event triggered.")
    LAKEEND.log("Escalation narrative: Level " .. tostring(level))
end
