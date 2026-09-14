-- ========================================================
-- BOARDING ACTION SPECIAL ACTION SCRIPT V1.0
-- ========================================================

local playerside = ScenEdit_PlayerSide()
local selectedUnits = ScenEdit_SelectedUnits()

-- 1. SELECTION VALIDATION
local function ValidUnitSelection(sel)
    -- Safely extract counts using fallbacks to prevent 'nil length' runtime crashes
    local uCount = (sel.units and #sel.units) or 0
    local cCount = (sel.contacts and #sel.contacts) or 0
    
    -- Enforce an exact 1-to-1 selection (1 friendly unit, 1 target contact)
    if uCount ~= 1 or cCount ~= 1 then
        ScenEdit_SpecialMessage(playerside, "Invalid selection. Please select exactly ONE friendly unit (RHIB or helicopter) and ONE target contact for the boarding action.")
        return false
    end
    
    -- Validate that the friendly unit is an individual asset, not a Group wrapper
    local unit = ScenEdit_GetUnit({guid = sel.units[1].guid})
    if unit ~= nil and unit.type ~= "Group" then
        return true
    else
        ScenEdit_SpecialMessage(playerside, "Please select an individual unit (RHIB/helicopter), not a Group object.")
        return false
    end
end

-- 2. RANGE & TARGET SIDE VALIDATION
local function checkUnitRange(sel)
    if not ValidUnitSelection(sel) then
        return false, "", ""
    end
    
    local guid1 = sel.units[1].guid
    local guid2 = ""
    
    -- Locate the contact and verify it belongs to side5
    for _, cWrapper in ipairs(sel.contacts) do
        local contact = ScenEdit_GetContact({side = playerside, guid = cWrapper.guid})
        if contact ~= nil and contact.actualunitid ~= nil then
            local targetUnit = ScenEdit_GetUnit({guid = contact.actualunitid})
            if targetUnit ~= nil then
                if targetUnit.side == "side5" then
                    guid2 = targetUnit.guid
                    break
                else
                    ScenEdit_SpecialMessage(playerside, "Boarding aborted: The selected contact is not a valid boarding target.")
                    return false, guid1, "" -- Abort immediately to prevent range check crashes
                end
            end
        end
    end
    
    if guid2 == "" then
        ScenEdit_SpecialMessage(playerside, "Boarding aborted: Could not resolve target contact actual unit.")
        return false, guid1, ""
    end
    
    -- Check distance (Must be within 1 NM)
    local range = Tool_Range(guid1, guid2)
    if range <= 1 then
        return true, guid1, guid2
    else
        ScenEdit_SpecialMessage(playerside, string.format("Boarding action failed. The selected units are too far apart (%.1f NM). Must be within 1 NM.", range))
        return false, guid1, guid2
    end
end

-- 3. EXECUTE BOARDING ACTION
local function boardingAction(sel)
    local success, guid1, guid2 = checkUnitRange(sel)
    if not success then return end
    
    local side5Pos = ScenEdit_GetSidePosture('side5', playerside)
    if side5Pos == 'H' then
        ScenEdit_SpecialMessage(playerside, "Boarding aborted: Target side is actively Hostile. Intercept with kinetic rules of engagement instead.")
        return
    end
    
    local sideA = ScenEdit_GetUnit({guid = guid1})
    local sideB = ScenEdit_GetUnit({guid = guid2})
    if sideA == nil or sideB == nil then return end
    
    local boardingAsset = nil
    local targetVessel = nil
    
    -- Identify friendly boarding asset vs. target ship cleanly
    if sideA.side == playerside then
        boardingAsset = sideA
        targetVessel = sideB
    elseif sideB.side == playerside then
        boardingAsset = sideB
        targetVessel = sideA
    end
    
    -- Validate unit types
    if boardingAsset == nil or (boardingAsset.type ~= "Ship" and boardingAsset.type ~= "Aircraft") then
        ScenEdit_SpecialMessage(playerside, "Boarding action failed: The friendly boarding unit must be a Ship (RHIB/boat) or an Aircraft (Helicopter).")
        return
    end
    
    if targetVessel == nil or targetVessel.type ~= "Ship" then
        ScenEdit_SpecialMessage(playerside, "Boarding action failed: The target must be a surface Ship.")
        return
    end
    
    -- Dynamic RNG Seeding using Target GUID hash to prevent identical rolls
    local guidHash = 0
    for i = 1, #targetVessel.guid do
        guidHash = guidHash + string.byte(targetVessel.guid, i)
    end
    math.randomseed(os.time() + guidHash)
    
    -- Safe Score Initialization
    local currentScore = ScenEdit_GetScore(playerside) or 0
    
    -- Untrapped Random Roll (Executes AFTER all validations)
    local roll = math.random()
    print(string.format("[Boarding Action] Attempting boarding of '%s' by '%s'. Roll: %.2f (Success threshold <= 0.75)", targetVessel.name, boardingAsset.name, roll))
    
    if roll <= 0.75 then
        -- SUCCESS
        ScenEdit_SetScore(playerside, currentScore + 5, "Vessel Boarded: " .. targetVessel.name)
        
        -- Transfer side using the dedicated SetUnitSide function
        local transferSuccess = ScenEdit_SetUnitSide({guid = targetVessel.guid, newside = "BOARDED"})
        
        if tonumber(transferSuccess) == 1 or transferSuccess == true then
            -- Stop speed using valid CMO API attribute and rename using the original GUID
            ScenEdit_SetUnit({guid = targetVessel.guid, newname = "Boarded - " .. targetVessel.name, speed = 0})
            
            -- Unassign from any active missions cleanly
            ScenEdit_AssignUnitToMission(targetVessel.guid, "none")
            
            ScenEdit_SpecialMessage(playerside, string.format("SUCCESS: We have boarded '%s' and taken control of the bridge. The vessel is stopped and held under our control for inspection.", targetVessel.name))
            print("[Boarding Action] SUCCESS: Vessel '" .. targetVessel.name .. "' transferred to side BOARDED.")
        else
            print("[Boarding Action ERROR] Side transfer failed for GUID: " .. tostring(targetVessel.guid))
        end
    else
        -- FAILURE
        ScenEdit_SetScore(playerside, currentScore - 10, "Boarding repelled: " .. targetVessel.name)
        ScenEdit_SpecialMessage(playerside, string.format("FAILURE: Our attempt to board '%s' was repelled by the crew! Prepare for potential escalation.", targetVessel.name))
        print("[Boarding Action] FAILURE: Boarding repelled on vessel '" .. targetVessel.name .. "'.")
    end
end

-- Execute the action
boardingAction(selectedUnits)