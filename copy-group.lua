-- ============================================================
-- MARIEHAMN UNIQUE GROUP DUPLICATOR
-- ============================================================

local sideName = 'NATO'
local targetGroupGuid = 'W8V2DT-0HNJNS145NKBI'
local newLat = 61.3438
local newLon = 24.5930

-- Generate a unique name using the current system time
local uniqueID = os.time()
local newGroupName = "ITO26-patteri_" .. uniqueID

print("--- INITIALIZING DEPLOYMENT: " .. newGroupName .. " ---")

local sideObj = VP_GetSide({side=sideName})
local newUnitGuids = {}

if sideObj and sideObj.units then
    for _, u_desc in pairs(sideObj.units) do
        local u = ScenEdit_GetUnit({guid=u_desc.guid})
        
        -- Filter: Only members of the target group, excluding the group object (DBID 0)
        if u and u.group and u.group.guid == targetGroupGuid and u.dbid > 0 then
            
            local newU = ScenEdit_AddUnit({
                type = 'Facility', 
                name = u.name .. " (" .. uniqueID .. ")",
                dbid = u.dbid,
                side = sideName,
                lat = newLat,
                lon = newLon
            })
            
            if newU then
                table.insert(newUnitGuids, newU.guid)
            end
        end
    end
end

-- Final Step: Bind the new units into the unique group
if #newUnitGuids > 0 then
    for _, g_guid in ipairs(newUnitGuids) do
        ScenEdit_SetUnit({guid=g_guid, group=newGroupName})
    end
    print("--- SUCCESS: " .. #newUnitGuids .. " units spawned in unique group: " .. newGroupName .. " ---")
else
    print("--- ERROR: No valid physical members found for target group ---")
end