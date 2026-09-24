-- ==============================================================================
-- FALKLANDS 2027: ABSTRACTED GROUND CONTROL ENGINE (GCE)
-- SCRIPT 5: ARGENTINE AI DIRECTOR v2
-- ==============================================================================
-- README & IMPLEMENTATION GUIDE
--
-- PURPOSE:
-- Automates the Argentine response. Adds fresh reinforcements to western zones 
-- (simulating mainland supply drops) and dynamically shifts defensive power from 
-- Stanley to any contested frontline zones.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: 'Regular Time' set to evaluate every 6 or 12 hours.
-- 2. Action: Lua Script Action (paste this entire block).
-- ==============================================================================

local function IsDevMode()
    local val = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    if val == "false" or val == "0" or val == "FALSE" then
        return false
    end
    return true
end

function GCE_ARG_AI_Director()
    local devMode = IsDevMode()

    -- 1. Mainland Reinforcements (Simulating C-130 flights to West Falkland)
    local westernZones = {"ZONE_PORT_HOWARD", "ZONE_FOX_BAY", "ZONE_PEBBLE_ISLAND"}
    for _, zone in ipairs(westernZones) do
        local current = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zone .. "_ARG_PWR")) or 0
        -- Adds 20 points (equiv to 1 platoon) per cycle
        ScenEdit_SetKeyValue("ZCTRL_" .. zone .. "_ARG_PWR", current + 20)
        if devMode then
            print(string.format("[GCE AI Director] Mainland Air-Bridge: Reinforcing %s (+20 ARG PWR -> Total: %d)",
                zone, current + 20))
        end
    end
    
    -- 2. Stanley Reserve Deployment
    local stanleyReserve = tonumber(ScenEdit_GetKeyValue("ZCTRL_ZONE_STANLEY_ARG_PWR")) or 0
    local reserveThreshold = 200 -- The AI will never reduce Stanley's defense below this number
    
    if stanleyReserve > reserveThreshold then
        -- The primary approaches to the capital
        local frontlines = {"ZONE_GOOSE_GREEN", "ZONE_MT_KENT", "ZONE_BLUFF_COVE"}
        
        for _, front in ipairs(frontlines) do
            local ukCtrl = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. front .. "_CTRL_PCT")) or 0
            local isSecured = ScenEdit_GetKeyValue("ZCTRL_" .. front .. "_SECURED") or "FALSE"
            
            -- If the UK is attacking the zone, but hasn't won it yet
            if ukCtrl > 0 and isSecured == "FALSE" then
                
                local availableToDeploy = stanleyReserve - reserveThreshold
                if availableToDeploy >= 30 then
                    -- Move 30 power points from Stanley to the Front
                    local frontPwr = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. front .. "_ARG_PWR")) or 0
                    ScenEdit_SetKeyValue("ZCTRL_" .. front .. "_ARG_PWR", frontPwr + 30)
                    
                    stanleyReserve = stanleyReserve - 30
                    ScenEdit_SetKeyValue("ZCTRL_ZONE_STANLEY_ARG_PWR", stanleyReserve)

                    if devMode then
                        print(string.format("[GCE AI Director] Strategic Defense Shift: Diverted 30 ARG PWR from Stanley to contested %s (Stanley Reserve remaining: %d)",
                            front, stanleyReserve))
                    end
                end
            end
        end
    end
end

GCE_ARG_AI_Director()