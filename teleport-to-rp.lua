-- Get the Reference Point object from the side 'UNKNOWN'
local rp = ScenEdit_GetReferencePoint({side='UNKNOWN', name='Teleport1'})

-- Check if the Reference Point actually exists to avoid errors
if rp ~= nil then
    -- Move the unit via its GUID to the RP coordinates
    ScenEdit_SetUnit({
        guid = 'W8V2DT-0HNIOBJ2UA6GD', 
        lat = rp.lat, 
        lon = rp.lon
    })
    print("Teleport Successful: Unit moved to Teleport1 location.")
else
    print("Error: Reference Point 'Teleport1' not found on side 'UNKNOWN'.")
end