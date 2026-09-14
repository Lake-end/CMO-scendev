-- CONFIGURATION
local spawnLat = 5 + 18/60 + 31/3600      -- 5°18'31" N
local spawnLon = -(52 + 51/60 + 42/3600)  -- 52°51'42" W
local targetLat = 5 + 15/60 + 57/3600     -- 5°15'57" N
local targetLon = -(52 + 47/60 + 33/3600) -- 52°47'33" W
local radius_nm = 0.2                     -- spawn radius in nautical miles
local side = 'UNKNOWN'

-- List of DBIDs to spawn
local dbids = {
    736,  -- example infantry unit
    2744,  -- another infantry type
    2945   -- add more as needed
}

-- Function to convert nm to degrees (approx)
local function offset_nm()
    local deg_lat = radius_nm / 60
    local deg_lon = radius_nm / (60 * math.cos(math.rad(spawnLat)))
    return deg_lat, deg_lon
end

-- Spawn units
for i, dbid in ipairs(dbids) do
    local dlat, dlon = offset_nm()
    local randLat = spawnLat + (math.random() * 2 - 1) * dlat
    local randLon = spawnLon + (math.random() * 2 - 1) * dlon

    local unitName = 'Infantry_' .. i

    local u = ScenEdit_AddUnit({
        side = side,
        name = unitName,
        type = 'Facility',
        dbid = dbid,
        latitude = randLat,
        longitude = randLon
    })

    -- Assign course to launchpad
    ScenEdit_SetUnit({guid = u.guid, manual_speed = 10})  -- full speed (adjust as needed)
    ScenEdit_SetUnit({guid = u.guid, course = {{latitude = targetLat, longitude = targetLon}}})
end
