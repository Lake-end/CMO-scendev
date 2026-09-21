-- =============================================================================
-- README: CTFS (Carrier Task Force Selector) - Core System Backend
-- =============================================================================
-- PURPOSE:
-- Serves as the Lua backend for the CTFS UI. Receives the JSON payload, 
-- advances scenario time, applies Argentine escalations, and dynamically 
-- constructs the UK Task Force including weapons loadouts.
--
-- IMPLEMENTED MECHANICS:
-- 1. Time Advancement: Converts points to hours (1 pt = 5 hours). Uses `os.date` to properly format the epoch integer into a date/time table required by `ScenEdit_SetTime`.
-- 2. Argentine Boons Matrix: Escalates enemy capabilities based on delay thresholds. Includes Mount Pleasant aircraft spawns, San Carlos MDM-5 minefields (via `SpawnMinefield`), and mainland F-16AM strikes.
-- 3. Quantity Parsing: Reads the `qty` field from the UI payload and loops the `ScenEdit_AddUnit` function to spawn multiple units of the same type (e.g., 10x A400Ms).
-- 4. Dynamic Magazine Fills: Reads the `upgrades` dictionary from the UI. Iterates through the spawned unit's `magazines` property and uses `ScenEdit_AddWeaponToUnitMagazine` to inject exact weapon quantities based on the purchased percentage.
--
-- USAGE & MAP REQUIREMENTS:
-- 1. Ensure reference points "FLEET_SPAWN1" through "FLEET_SPAWN5" and "BASE_ASCENSION" exist on the map.
-- 2. Replace DB ID placeholders if the scenario database changes.
-- 3. Run this file as an Event Action when the scenario begins.
-- =============================================================================

local CTFS = {}
CTFS.MaxPoints = 100
CTFS.HoursPerPoint = 5

-- =============================================================================
-- CONFIGURATION & DB IDs
-- =============================================================================
-- UK DB IDs (From CTFS Specs)
local DB_UK = {
    QE = 1008,
    Type45_SeaCeptor = 3438,
    Type45_Base = 3200,
    Type23 = 3199,
    Type26 = 2795,
    Type31 = 2795,
    Astute = 725,
    Tide = 2581,
    FortVictoria = 406,
    Bay = 1451,
    Point = 2423,
    Wave = 1406,
    F35B = 1095,
    F35B_Loadout = 25647
}

-- Argentine DB IDs
local DB_ARG = {
    RBS70 = 3913,
    ExocetSSM = 4532,
    SpyderSR = 3010,
    SpyderMR = 4037,
    Submarine = 671,      -- Chang Bogo Type 209-1200
    Fighter = 7227,       -- F-16AM Falcon MLU
    Fighter_A2A = 33847,  -- Loadout ID
    Fighter_A2G = 33848,  -- Loadout ID
    Mine = 3406           -- MDM-5 mine
}

-- Target Coordinates (Format: {latitude="X", longitude="Y"})
local COORDS = {
    Stanley_Canopus = {latitude="-51.6894", longitude="-57.7833"},    -- SR Spyder
    Stanley_Tumbledown = {latitude="-51.6969", longitude="-57.9631"}, -- MR Spyder
    Stanley_Port = {latitude="-51.6972", longitude="-57.8897"},       -- RBS 70 NG
    Chokepoint1 = {latitude="-51.4653", longitude="-59.1361"},        -- Fanning Head (SSM & Mines)
    SubPatrol1 = {latitude="-49.2500", longitude="-57.5000"},
    SubPatrol2 = {latitude="-49.8000", longitude="-55.2000"},
    Pleasant = {latitude="-51.8220", longitude="-58.4460"}            -- Added for Phase 1 aircraft
}

-- =============================================================================
-- HELPER FUNCTIONS
-- =============================================================================
-- Spawns a randomized field of mines around a central coordinate
local function SpawnMinefield(side, dbid, centerLat, centerLon, mineCount, radiusNm)
    local numLat = tonumber(centerLat)
    local numLon = tonumber(centerLon)
    
    for i = 1, mineCount do
        -- 1 degree of latitude is approx 60 NM
        local latOffset = (math.random() - 0.5) * 2 * (radiusNm / 60)
        local lonOffset = (math.random() - 0.5) * 2 * (radiusNm / 60) 
        
        ScenEdit_AddUnit({
            type = "Weapon", 
            side = side, 
            dbid = dbid, 
            name = "MDM-5 Mine #" .. i, -- Added to satisfy the Intellisense requirement
            latitude = tostring(numLat + latOffset), 
            longitude = tostring(numLon + lonOffset)
        })
    end
end

-- =============================================================================
-- CORE FUNCTIONS
-- =============================================================================

-- Executes the time jump based on spent points
function CTFS.ExecuteTimeJump(pointsSpent)
    if pointsSpent > CTFS.MaxPoints then
        pointsSpent = CTFS.MaxPoints
    end
    
    local hoursToDelay = pointsSpent * CTFS.HoursPerPoint
    local currentTime = ScenEdit_CurrentTime()
    
    -- CMO uses Unix Epoch time (seconds). 1 hour = 3600 seconds.
    local newTime = currentTime + (hoursToDelay * 3600)
    
    -- Convert the integer epoch time back into a formatted string table for CMO
    local dateStr = os.date("!%d.%m.%Y", newTime)
    local timeStr = os.date("!%H:%M:%S", newTime)
    
    ScenEdit_SetTime({Date = dateStr, Time = timeStr})
    ScenEdit_MsgBox("Task Force launch delayed by " .. hoursToDelay .. " hours.", 1)
end

-- Spawns Argentine Boons based on the points threshold
function CTFS.ApplyArgentineBoons(points)
    -- Phase 1: 10 - 25 pts
    if points >= 10 then
        ScenEdit_AddUnit({type="Facility", side="Argentina", dbid=DB_ARG.SpyderSR, name="SPYDER-SR Bty (Stanley)", latitude=COORDS.Stanley_Canopus.latitude, longitude=COORDS.Stanley_Canopus.longitude})
    end
    if points >= 20 then
        -- Spawn additional aircraft at Mount Pleasant
        ScenEdit_AddUnit({type="Aircraft", side="Argentina", dbid=DB_ARG.Fighter, loadoutid=DB_ARG.Fighter_A2A, name="Phase 1 CAP Fighter", latitude=COORDS.Pleasant.latitude, longitude=COORDS.Pleasant.longitude, altitude=10000})
    end
    
    -- Phase 2: 26 - 50 pts
    if points >= 30 then
        ScenEdit_AddUnit({type="Facility", side="Argentina", dbid=DB_ARG.ExocetSSM, name="Coastal SSM Bty", latitude=COORDS.Chokepoint1.latitude, longitude=COORDS.Chokepoint1.longitude})
    end
    if points >= 40 then
        -- Trigger Minefield at San Carlos approach (15 mines, 2 NM radius)
        SpawnMinefield("Argentina", DB_ARG.Mine, COORDS.Chokepoint1.latitude, COORDS.Chokepoint1.longitude, 15, 2.0)
    end
    if points >= 50 then
        ScenEdit_SetSideOptions({side="Argentina", proficiency="Veteran"})
    end
    
    -- Phase 3: 51 - 75 pts
    if points >= 60 then
        ScenEdit_AddUnit({type="Facility", side="Argentina", dbid=DB_ARG.SpyderMR, name="SPYDER-MR Bty", latitude=COORDS.Stanley_Tumbledown.latitude, longitude=COORDS.Stanley_Tumbledown.longitude})
    end
    if points >= 70 then
        ScenEdit_AddUnit({type="Submarine", side="Argentina", dbid=DB_ARG.Submarine, name="Arg Sub 1", latitude=COORDS.SubPatrol1.latitude, longitude=COORDS.SubPatrol1.longitude})
    end
    if points >= 75 then
        ScenEdit_AddUnit({type="Submarine", side="Argentina", dbid=DB_ARG.Submarine, name="Arg Sub 2", latitude=COORDS.SubPatrol2.latitude, longitude=COORDS.SubPatrol2.longitude})
    end
    
    -- Phase 4: 76 - 100 pts
    if points >= 80 then
        -- Spawn Mainland Strike Aircraft fully loaded (A2G) inbound
        ScenEdit_AddUnit({type="Aircraft", side="Argentina", dbid=DB_ARG.Fighter, loadoutid=DB_ARG.Fighter_A2G, name="Max Readiness Strike 1", latitude=COORDS.Chokepoint1.latitude, longitude=COORDS.Chokepoint1.longitude - 2.0, altitude=5000})
        ScenEdit_AddUnit({type="Aircraft", side="Argentina", dbid=DB_ARG.Fighter, loadoutid=DB_ARG.Fighter_A2G, name="Max Readiness Strike 2", latitude=COORDS.Chokepoint1.latitude, longitude=COORDS.Chokepoint1.longitude - 2.1, altitude=5000})
    end
    if points >= 95 then
        ScenEdit_AddUnit({type="Facility", side="Argentina", dbid=DB_ARG.RBS70, name="RBS 70 NG", latitude=COORDS.Stanley_Port.latitude, longitude=COORDS.Stanley_Port.longitude})
    end
    if points >= 99 then
        ScenEdit_SetSideOptions({side="Argentina", proficiency="Ace"})
    end
end

-- =============================================================================
-- UI CALLBACK HANDLER
-- This function catches the JSON string passed back from the HTML UI.
-- =============================================================================
function CTFS_ProcessUIResponse(jsonString)
    -- Requires a JSON parser (CMO has ScenEdit_ParseJSON or you can use a lua json library)
    -- local selections = ScenEdit_ParseJSON(jsonString) 
    
    -- MOCK PAYLOAD FOR LUA TESTING:
    local selections = {
        totalPoints = 14,
        units = {
            {type="Ship", dbid=1008, name="HMS Queen Elizabeth", spawnRP="FLEET_SPAWN1", qty=1},
            {type="Ship", dbid=3438, name="HMS Defender", spawnRP="FLEET_SPAWN2", qty=1},
            {type="Aircraft", dbid=1420, name="A400M Atlas", spawnRP="BASE_ASCENSION", qty=3}
        },
        upgrades = {
            ["HMS Queen Elizabeth"] = 50, -- Represents two tickboxes (+50%)
            ["HMS Defender"] = 25 -- Represents one tickbox (+25%)
        }
    }
    
    -- 1. Advance Time & Execute Boons
    CTFS.ExecuteTimeJump(selections.totalPoints)
    CTFS.ApplyArgentineBoons(selections.totalPoints)
    
    -- 2. Spawn All Selected Units (Including Default Fleet)
    for _, item in ipairs(selections.units) do
        local rp = ScenEdit_GetReferencePoint({side="UK", name=item.spawnRP})
        if rp then
            -- Loop for quantities (e.g., spawning 3x A400Ms)
            for i = 1, item.qty do
                local unitName = item.name
                if item.qty > 1 then unitName = unitName .. " #" .. i end
                
                local newUnit = ScenEdit_AddUnit({type=item.type, side="UK", dbid=item.dbid, name=unitName, latitude=rp.latitude, longitude=rp.longitude})
                
                -- 3. Magazine & VLS Upgrade Logic
                if newUnit and selections.upgrades[item.name] then
                    local percentToAdd = selections.upgrades[item.name] / 100
                    local mags = newUnit.magazines
                    if mags then
                        for _, mag in ipairs(mags) do
                            local capacity = mag.capacity
                            local wpnDbid = mag.weapon.dbid
                            local amountToAdd = math.floor(capacity * percentToAdd)
                            
                            if amountToAdd > 0 then
                                ScenEdit_AddWeaponToUnitMagazine({guid=newUnit.guid, wpn_dbid=wpnDbid, number=amountToAdd})
                            end
                        end
                    end
                end
                
            end
        end
    end
    
    ScenEdit_MsgBox("Task Force Launch Complete. Assets deployed.", 1)
end

-- Command to open the UI (Requires ctfs_ui.html in the Attachments folder)
-- ScenEdit_ShowCustomDialog("CTFS: Carrier Task Force Selector", "ctfs_ui.html")