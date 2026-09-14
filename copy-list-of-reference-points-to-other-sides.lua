-- ========================================================
-- REFERENCE POINT COPIER V1.0
-- ========================================================

-- 1. DEFINE YOUR PARAMETERS HERE
local sourceSide = "NATO"
local targetSides = {"sip", "side1", "side2", "side3", "side4", "side5"} -- Add as many target sides as needed
local rpNames = {"RP-105", "RP-106", "RP-107", "RP-108"} -- The exact names of the RPs to copy

-- 2. EXECUTE THE COPY PROCESS
for _, rpName in ipairs(rpNames) do
    -- Retrieve the original Reference Point wrapper
    local rp = ScenEdit_GetReferencePoint({side = sourceSide, name = rpName})
    
    if rp ~= nil then
        for _, tSide in ipairs(targetSides) do
            -- Attempt to create the new Reference Point on the target side
            -- Using lat/lon properties extracted from the original RP
            local newRP = ScenEdit_AddReferencePoint({
                side = tSide, 
                name = rpName, 
                lat = rp.latitude, 
                lon = rp.longitude
            })
            
            if newRP ~= nil then
                print("[RP Copier] Successfully copied '" .. rpName .. "' to side '" .. tSide .. "'.")
            else
                print("[RP Copier ERROR] Failed to create '" .. rpName .. "' on side '" .. tSide .. "'.")
            end
        end
    else
        print("[RP Copier ERROR] Could not find original RP '" .. rpName .. "' on side '" .. sourceSide .. "'. Check spelling.")
    end
end