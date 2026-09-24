
-- ==============================================================================
-- FALKLANDS 2027: GENERAL SCRIPT
-- SCRIPT 6: UK LOSS TRACKER & FAIL STATE v3
-- ==============================================================================
-- README & IMPLEMENTATION GUIDE
--
-- PURPOSE:
-- Simulates the political fragility of the UK expeditionary force. High-value 
-- losses accumulate penalty points. If the threshold is breached, the scenario 
-- ends in a strategic defeat.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: 'Unit is Destroyed' trigger, set to Target Filter: Side = "UK".
-- 2. Action: Lua Script Action (paste this entire block).
-- ==============================================================================

local function IsDevMode()
    local val = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    if val == "false" or val == "0" or val == "FALSE" then
        return false
    end
    return true
end

function GCE_ProcessUKLoss()
    -- Set the political breaking point (Adjust based on playtesting)
    local lossThreshold = 250
    local devMode = IsDevMode()

    -- Catch the specific unit that was just destroyed
    local deadUnit = ScenEdit_UnitX()

    if deadUnit ~= nil then
        local penalty = 0
        
        -- Categorize the loss and assign point values
        if deadUnit.type == "Ship" then
            -- Carriers are catastrophic losses
            if deadUnit.subtype == "Carrier" or deadUnit.subtype == "CV" or deadUnit.subtype == "CVN" then
                penalty = 150
            -- Amphibious ships carry the ground troops and logistics
            elseif deadUnit.subtype == "Amphibious" or deadUnit.subtype == "LHD" or deadUnit.subtype == "LPD" then
                penalty = 100
            -- Destroyers and Frigates
            elseif deadUnit.subtype == "SurfaceCombatant" or deadUnit.subtype == "DDG" or deadUnit.subtype == "FFG" then
                penalty = 50
            -- RFA Supply ships
            elseif deadUnit.subtype == "Auxiliary" then
                penalty = 40
            else
                penalty = 20
            end
            
        elseif deadUnit.type == "Submarine" then
            penalty = 75
            
        elseif deadUnit.type == "Aircraft" then
            -- F-35s are highly sensitive political losses
            if string.find(deadUnit.name, "F-35") then
                penalty = 20
            -- High-value ISR assets (Wedgetail, Poseidon)
            elseif deadUnit.subtype == "Airborne_Early_Warning" or deadUnit.subtype == "Maritime_PatrolAircraft" then
                penalty = 30
            -- Drones are acceptable losses
            elseif deadUnit.subtype == "UAV" then
                penalty = 2
            else
                -- Generic aircraft/helicopter
                penalty = 5 
            end
        end
        
        -- If a scored unit was killed, apply the math
        if penalty > 0 then
            local currentLosses = tonumber(ScenEdit_GetKeyValue("GCE_LOSS_SCORE_UK")) or 0
            currentLosses = currentLosses + penalty
            ScenEdit_SetKeyValue("GCE_LOSS_SCORE_UK", currentLosses)
            
            local pct = (currentLosses / lossThreshold) * 100
            if devMode then
                print(string.format("[UK LOSS TRACKER DEBUG] Unit Destroyed: %s (Type: %s, Subtype: %s) | Penalty: +%d pts | Loss Score: %d / %d (%.1f%% towards strategic withdrawal threshold)",
                    deadUnit.name, deadUnit.type or "Unknown", deadUnit.subtype or "Unknown", penalty, currentLosses, lossThreshold, pct))
            end

            -- CHECK THE FAIL STATE
            if currentLosses >= lossThreshold then
                local msg = string.format("<body bgcolor='#121212' text='#FF5A5F' style='font-family: Arial, sans-serif;'><h2>CATASTROPHIC LOSSES</h2><p>The destruction of <b>%s</b> has pushed UK casualties past the threshold of political acceptability.</p><p>With %d penalty points accumulated, the Government has ordered the immediate withdrawal of the Task Force.</p><h3>STRATEGIC DEFEAT</h3></body>", deadUnit.name, currentLosses)

                ScenEdit_SpecialMessage("UK", msg)

                -- Force the scenario to end immediately
                ScenEdit_EndScenario()
            else
                -- Optional: Give the player a warning ping in the message log so they know they are bleeding points
                print(string.format("POLITICAL COMMAND ALERT: Loss of %s has cost %d political points. Current Loss Score: %d / %d", deadUnit.name, penalty, currentLosses, lossThreshold))
            end
        end
    end
end

-- Execute
GCE_ProcessUKLoss()