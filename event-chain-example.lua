--[[
===============================================================
 CMANO / CMO LUA TEMPLATE:
 FULLY AUTOMATED EVENT CHAIN CREATION
 --------------------------------------------------------------
 This script demonstrates how to:
   1. Create a new event
   2. Add a trigger to it
   3. Add a condition to it
   4. Add multiple actions to it
   5. Create a second event
   6. Link Event A → Event B using an EventToggle action
   7. Provide extensive documentation for scenario designers

 This is a safe, generic template you can adapt for:
   - escalation ladders
   - multi‑stage missions
   - dynamic storylines
   - procedural event generation
===============================================================
]]


----------------------------------------------------------------
-- 1. CREATE EVENT A
----------------------------------------------------------------
local eventA = ScenEdit_AddEvent("Event_A_InitialDetection", true)
-- true = event starts active
-- This event will fire when the trigger + condition are satisfied.

ScenEdit_SpecialMessage("SideA", "Created Event A: " .. eventA.guid)



----------------------------------------------------------------
-- 2. ADD A TRIGGER TO EVENT A
-- Example trigger: Time trigger (fires at a specific scenario time)
----------------------------------------------------------------
local triggerA = ScenEdit_AddTrigger({
    type = "Time",
    name = "TriggerA_TimeReached",
    time = "00:10:00"   -- 10 minutes into scenario
})

ScenEdit_AssignTriggerToEvent(eventA.guid, triggerA.guid)



----------------------------------------------------------------
-- 3. ADD A CONDITION TO EVENT A
-- Example condition: Check if a side has fewer than X units remaining
----------------------------------------------------------------
local conditionA = ScenEdit_AddCondition({
    type = "SidePosture",
    name = "ConditionA_PostureCheck",
    sideA = "NATO",
    sideB = "Russia",
    posture = "Hostile"
})

ScenEdit_AssignConditionToEvent(eventA.guid, conditionA.guid)



----------------------------------------------------------------
-- 4. ADD ACTIONS TO EVENT A
-- Example actions:
--   A) Send a message to the player
--   B) Activate Event B (created later)
----------------------------------------------------------------

-- A) Message action
local actionA1 = ScenEdit_AddAction({
    type = "Message",
    name = "ActionA_Message",
    side = "NATO",
    message = "Event A has fired. Situation escalating."
})

ScenEdit_AssignActionToEvent(eventA.guid, actionA1.guid)



----------------------------------------------------------------
-- 5. CREATE EVENT B (initially inactive)
----------------------------------------------------------------
local eventB = ScenEdit_AddEvent("Event_B_FollowUp", false)
-- false = event starts inactive
-- Event A will activate this event.

ScenEdit_SpecialMessage("SideA", "Created Event B: " .. eventB.guid)



----------------------------------------------------------------
-- 6. ADD ACTION TO EVENT A THAT ACTIVATES EVENT B
----------------------------------------------------------------
local actionA2 = ScenEdit_AddAction({
    type = "EventToggle",
    name = "ActionA_ActivateEventB",
    event = eventB.guid,
    isactive = true
})

ScenEdit_AssignActionToEvent(eventA.guid, actionA2.guid)



----------------------------------------------------------------
-- 7. ADD ACTIONS TO EVENT B
-- Example: Send a message when Event B fires
----------------------------------------------------------------
local actionB1 = ScenEdit_AddAction({
    type = "Message",
    name = "ActionB_Message",
    side = "NATO",
    message = "Event B triggered. Follow‑up actions underway."
})

ScenEdit_AssignActionToEvent(eventB.guid, actionB1.guid)



----------------------------------------------------------------
-- 8. OPTIONAL: Add a trigger to Event B
-- Example: Fires immediately when activated
----------------------------------------------------------------
local triggerB = ScenEdit_AddTrigger({
    type = "ScenEvent",
    name = "TriggerB_OnActivation",
    event = eventB.guid
})

ScenEdit_AssignTriggerToEvent(eventB.guid, triggerB.guid)



----------------------------------------------------------------
-- DONE
----------------------------------------------------------------
ScenEdit_SpecialMessage("SideA", "Event chain successfully created.")
