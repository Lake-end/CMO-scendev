-- Safe-Spawn Commercial Traffic (v512 Compatible)
local side = "Civilian" 
local count = 20

local aircraft_dbids = {
    2623, -- A320-200
    2625, -- A330-300
    3051, -- A380-800
    2273, -- 737-800
    1948, -- 747-400
    2642, -- 777-300ER
    3056  -- 787-8
}

for i = 1, count do
    local dbid = aircraft_dbids[math.random(#aircraft_dbids)]
    local lat = math.random(-50, 65)
    local lon = math.random(-180, 180)
    local name = "Civ-Air #" .. math.random(100, 999)

    -- 1. ADD UNIT with mandatory 'loadoutid = 0'
    local unit = ScenEdit_AddUnit({
        type = 'Aircraft', 
        name = name, 
        dbid = dbid, 
        side = side, 
        lat = lat, 
        lon = lon, 
        altitude = math.random(32000, 39000),
        loadoutid = 0 -- Satisfies the "Missing LoadoutID" error
    })

    if unit then
        -- 2. GET the actual valid loadouts from the DB for this unit
        -- We must fetch the wrapper again to ensure loadout table is populated
        local u = ScenEdit_GetUnit({guid=unit.guid})
        local selected_loadout = 0

        if u.loadouts then
            for _, ld in ipairs(u.loadouts) do
                local ld_name = ld.name:lower()
                -- Filter for civilian-style keywords
                if ld_name:find("passenger") or ld_name:find("service") or ld_name:find("standard") then
                    selected_loadout = ld.dbid
                    break 
                end
            end
        end

        -- 3. APPLY the found loadout
        if selected_loadout ~= 0 then
            -- Set to ready immediately (0 minutes)
            ScenEdit_SetLoadout({guid=unit.guid, loadoutid=selected_loadout, timetoready_minutes=0})
        end

        -- 4. SET FLIGHT PATH
        local dest_lat = math.min(math.max(lat + math.random(-33, 33), -85), 85)
        local dest_lon = lon + math.random(-33, 33)
        ScenEdit_SetUnit({guid=unit.guid, course={{lat=dest_lat, lon=dest_lon}}, manualSpeed=460, throttle='Cruise'})
        
        print("Spawned " .. name .. " [DBID: " .. dbid .. "] with Loadout: " .. selected_loadout)
    end
end