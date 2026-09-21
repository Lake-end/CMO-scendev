-- ==============================================================================
-- FALKLANDS 2027: ABSTRACTED GROUND CONTROL ENGINE (GCE)
-- SCRIPT 1: MASTER KV STORE INITIALIZATION
-- ==============================================================================
-- README & IMPLEMENTATION GUIDE
--
-- PURPOSE:
-- Seeds the CMO Key-Value store with the baseline numerical values for the 
-- campaign. It gives Argentina starting control of all zones and sets global 
-- modifiers (like Morale and Supply) to 100%.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: 'Time' trigger set to exactly 1 second after scenario start. 
--    (Alternatively, use 'Scenario is Loaded' combined with a flag).
-- 2. Action: Lua Script Action (paste this entire block).
-- 3. Condition: None required. The script safely checks if values exist before 
--    writing, preventing accidental overwrites mid-campaign.
-- ==============================================================================

local GCE_Zones = {
    "ZONE_SAN_CARLOS",
    "ZONE_BLUFF_COVE",
    "ZONE_GOOSE_GREEN",
    "ZONE_MT_KENT",
    "ZONE_FALKLAND_SOUND",
    "ZONE_PORT_HOWARD",
    "ZONE_FOX_BAY",
    "ZONE_TEAL_INLET",
    "ZONE_PEBBLE_ISLAND",
    "ZONE_STANLEY",
    "ZONE_PLEASANT"
}

function InitializeGCEStore()
    
    -- Helper function: Only sets the key if it is empty/nil
    local function SafeSetKV(key, default_val)
        local current_val = ScenEdit_GetKeyValue(key)
        if current_val == "" or current_val == nil then
            ScenEdit_SetKeyValue(key, tostring(default_val))
        end
    end

    -- 1. Initialize Global Variables
    SafeSetKV("GCE_GLOBAL_UK_MORALE", 100)
    SafeSetKV("GCE_GLOBAL_ARG_MORALE", 100)
    SafeSetKV("GCE_GLOBAL_UK_SUPPLY", 100)
    SafeSetKV("GCE_GLOBAL_UK_SA_BONUS", 1.0)
    SafeSetKV("GCE_GLOBAL_ARG_SA_BONUS", 1.0)
    SafeSetKV("GCE_LOSS_SCORE_UK", 0)

    -- 2. Initialize Zonal Variables for every zone in the map
    for _, zoneName in ipairs(GCE_Zones) do
        
        -- Start with 0% UK Control (100% ARG Control)
        SafeSetKV("ZCTRL_" .. zoneName .. "_CTRL_PCT", 0) 
        
        -- Starting power levels
        SafeSetKV("ZCTRL_" .. zoneName .. "_UK_PWR", 0)
        -- Set a baseline ARG garrison strength (e.g., 100 points to overcome)
        SafeSetKV("ZCTRL_" .. zoneName .. "_ARG_PWR", 100) 
        
        -- Default Modifiers
        SafeSetKV("ZCTRL_" .. zoneName .. "_SA_LOCAL", 1.0)
        SafeSetKV("ZCTRL_" .. zoneName .. "_CAS_ACTIVE", "FALSE")
        SafeSetKV("ZCTRL_" .. zoneName .. "_NGFS_ACTIVE", "FALSE")
        SafeSetKV("ZCTRL_" .. zoneName .. "_STATUS_TEXT", "ARG SECURED")
        
    end
    
    ScenEdit_Print("GCE Key-Value Store Initialized Successfully.")
end

InitializeGCEStore()