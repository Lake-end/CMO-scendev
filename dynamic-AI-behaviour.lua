-- ============================================================
--  LAKEEND.AI — Dynamic Enemy Behavior Module
-- ============================================================

LAKEEND.AI = {}

-- Change posture dynamically
function LAKEEND.AI.posture(sideA, sideB, posture)
    ScenEdit_SetSidePosture(sideA, sideB, posture)
    LAKEEND.log("Posture changed: " .. sideA .. " → " .. sideB .. " = " .. posture)
end

-- Activate mission based on conditions
function LAKEEND.AI.activateMission(side, mission)
    ScenEdit_SetMission(side, mission, {isactive=true})
    LAKEEND.log("Mission activated: " .. mission)
end

-- Deactivate mission
function LAKEEND.AI.deactivateMission(side, mission)
    ScenEdit_SetMission(side, mission, {isactive=false})
    LAKEEND.log("Mission deactivated: " .. mission)
end

-- Adaptive behavior: if unit detected, activate mission
function LAKEEND.AI.onDetectedActivate(unitName, side, mission)
    local u = ScenEdit_GetUnit({name=unitName})
    if u and u.detectedby then
        LAKEEND.AI.activateMission(side, mission)
        LAKEEND.log("Detection-triggered mission activation: " .. mission)
    end
end

-- Random mission activation
function LAKEEND.AI.randomMission(side, missions)
    local pick = LAKEEND.randomPick(missions)
    LAKEEND.AI.activateMission(side, pick)
end
