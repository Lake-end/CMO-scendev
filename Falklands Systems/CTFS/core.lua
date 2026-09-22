-- =============================================================================
-- CTFS (Carrier Task Force Selector) - Master Backend Engine (Falklands 2027)
-- =============================================================================
-- ARCHITECTURE:
-- Implements the Command: Modern Operations (CMO) HTML UI Reference Architecture:
--   1. Zero-External-Dependency "One-Shot" Scripting with embedded pure Lua JSON.
--   2. Dual IPC Bridge Support:
--      - Bridge 1 (Synchronous / Modal): UI_CallAdvancedHTMLDialog (Clock Paused)
--      - Bridge 2 (Asynchronous / Live): ScenEdit_SpecialMessage via postMessage
--   3. CSS Formatting Collision Protection (EscapePercentsButKeep_s).
--   4. Model-View-Controller (MVC) with Lua Server-Side Anti-Spoofing Math Validation.
--   5. Persistent Game State via CMO Global Key-Value Store (ScenEdit_SetKeyValue).
--   6. Dynamic Force Spawner with correct Unit Magazine and Host GUID Binding.
-- =============================================================================

CTFS = CTFS or {}
CTFS.MaxPoints = 100
CTFS.HoursPerPoint = 5
CTFS.DEBUG_MODE = true -- Set to false for release (hides points budget & redacts threat matrix)

-- =============================================================================
-- EMBEDDED ZERO-DEPENDENCY PURE LUA JSON ENGINE
-- Credit: Tyler Neylon (Public Domain) - Embedded for 100% standalone reliability
-- =============================================================================
local JSON = {}

function JSON.kind_of(obj)
    if type(obj) ~= 'table' then return type(obj) end
    local i = 1
    for _ in pairs(obj) do
        if obj[i] ~= nil then i = i + 1 else return 'table' end
    end
    if i == 1 then return 'table' else return 'array' end
end

function JSON.escape_str(s)
    local in_char  = { '\\', '"', '/', '\b', '\f', '\n', '\r', '\t' }
    local out_char = { '\\', '"', '/', 'b', 'f', 'n', 'r', 't' }
    for i, c in ipairs(in_char) do
        s = s:gsub(c, '\\' .. out_char[i])
    end
    return s
end

function JSON.skip_delim(str, pos, delim, err_if_missing)
    pos = pos + #str:match('^%s*', pos)
    if str:sub(pos, pos) ~= delim then
        if err_if_missing then
            error('JSON Error: Expected ' .. delim .. ' near position ' .. pos)
        end
        return pos, false
    end
    return pos + 1, true
end

function JSON.parse_str_val(str, pos, val)
    val = val or ''
    if pos > #str then error('JSON Error: End of input found while parsing string.') end
    local c = str:sub(pos, pos)
    if c == '"' then return val, pos + 1 end
    if c ~= '\\' then return JSON.parse_str_val(str, pos + 1, val .. c) end
    local esc_map = { b = '\b', f = '\f', n = '\n', r = '\r', t = '\t' }
    local nextc = str:sub(pos + 1, pos + 1)
    if not nextc then error('JSON Error: End of input found while parsing string.') end
    return JSON.parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

function JSON.parse_num_val(str, pos)
    local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
    local val = tonumber(num_str)
    if not val then error('JSON Error: Error parsing number at position ' .. pos .. '.') end
    return val, pos + #num_str
end

function JSON.stringify(obj, as_key)
    local s = {}
    local kind = JSON.kind_of(obj)
    if kind == 'array' then
        if as_key then error('JSON Error: Cannot encode array as key.') end
        s[#s + 1] = '['
        for i, val in ipairs(obj) do
            if i > 1 then s[#s + 1] = ', ' end
            s[#s + 1] = JSON.stringify(val)
        end
        s[#s + 1] = ']'
    elseif kind == 'table' then
        if as_key then error('JSON Error: Cannot encode table as key.') end
        s[#s + 1] = '{'
        for k, v in pairs(obj) do
            if #s > 1 then s[#s + 1] = ', ' end
            s[#s + 1] = JSON.stringify(tostring(k), true)
            s[#s + 1] = ':'
            s[#s + 1] = JSON.stringify(v)
        end
        s[#s + 1] = '}'
    elseif kind == 'string' then
        return '"' .. JSON.escape_str(obj) .. '"'
    elseif kind == 'number' then
        if as_key then return '"' .. tostring(obj) .. '"' end
        return tostring(obj)
    elseif kind == 'boolean' then
        return tostring(obj)
    elseif kind == 'nil' then
        return 'null'
    else
        error('JSON Error: Unjsonifiable type: ' .. kind .. '.')
    end
    return table.concat(s)
end

JSON.null = {}

function JSON.parse(str, pos, end_delim)
    pos = pos or 1
    if pos > #str then error('JSON Error: Reached unexpected end of input.') end
    pos = pos + #str:match('^%s*', pos)
    local first = str:sub(pos, pos)
    if first == '{' then
        local obj, delim_found = {}, true
        pos = pos + 1
        while true do
            local key
            key, pos = JSON.parse(str, pos, '}')
            if key == nil then return obj, pos end
            if not delim_found then error('JSON Error: Comma missing between object items.') end
            pos = JSON.skip_delim(str, pos, ':', true)
            ---@cast key -nil
            ---@diagnostic disable-next-line: need-check-nil
            obj[key], pos = JSON.parse(str, pos)
            pos, delim_found = JSON.skip_delim(str, pos, ',')
        end
    elseif first == '[' then
        local arr, delim_found = {}, true
        pos = pos + 1
        while true do
            local val
            val, pos = JSON.parse(str, pos, ']')
            if val == nil then return arr, pos end
            if not delim_found then error('JSON Error: Comma missing between array items.') end
            arr[#arr + 1] = val
            pos, delim_found = JSON.skip_delim(str, pos, ',')
        end
    elseif first == '"' then
        return JSON.parse_str_val(str, pos + 1)
    elseif first == '-' or first:match('%d') then
        return JSON.parse_num_val(str, pos)
    elseif first == end_delim then
        return nil, pos + 1
    else
        local literals = { ['true'] = true, ['false'] = false, ['null'] = JSON.null }
        for lit_str, lit_val in pairs(literals) do
            local lit_end = pos + #lit_str - 1
            if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
        end
        local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
        error('JSON Error: Invalid JSON syntax starting at ' .. pos_info_str)
    end
end

-- =============================================================================
-- CONFIGURATION & DATABASE DEFINITIONS (DB3000)
-- =============================================================================
CTFS.DB_ARG = {
    RBS70       = 3913,  -- RBS 70 NG MANPADS
    ExocetSSM   = 4532,  -- Coastal SSM Battery (MM.40 Blk III)
    SpyderSR    = 3010,  -- SPYDER-SR SAM Battery
    SpyderMR    = 4037,  -- SPYDER-MR SAM Battery
    Submarine   = 671,   -- Chang Bogo Type 209-1200
    Fighter     = 7227,  -- F-16AM Falcon MLU
    Fighter_A2A = 33847, -- F-16AM A2A Loadout
    Fighter_A2G = 33848, -- F-16AM A2G Strike Loadout
    Mine        = 3406   -- MDM-5 Naval Mine
}

CTFS.COORDS = {
    Stanley_Canopus    = { latitude = "-51.6894", longitude = "-57.7833" }, -- SR Spyder
    Stanley_Tumbledown = { latitude = "-51.6969", longitude = "-57.9631" }, -- MR Spyder
    Stanley_Port       = { latitude = "-51.6972", longitude = "-57.8897" }, -- RBS 70 NG
    Chokepoint1        = { latitude = "-51.4653", longitude = "-59.1361" }, -- Fanning Head (SSM & Mines)
    SubPatrol1         = { latitude = "-49.2500", longitude = "-57.5000" }, -- ARA Salta
    SubPatrol2         = { latitude = "-49.8000", longitude = "-55.2000" }, -- ARA San Luis
    Pleasant           = { latitude = "-51.8220", longitude = "-58.4460" }  -- Mount Pleasant Airport
}

-- =============================================================================
-- MASTER ORDER OF BATTLE & PURCHASE MODEL (MVC MODEL)
-- =============================================================================
CTFS.MODEL = {
    maxPoints = CTFS.MaxPoints,
    hoursPerPoint = CTFS.HoursPerPoint,
    debugMode = CTFS.DEBUG_MODE,
    categories = {
        { id = "default", label = "Standing Task Force" },
        { id = "escorts", label = "Escorts & Submarines" },
        { id = "support", label = "Support & Auxiliary" },
        { id = "airwing", label = "Carrier Air Wing" },
        { id = "raf",     label = "RAF" }
    },
    items = {
        -- Default Carrier Strike Group & Auxiliaries (0 pts)
        { id = "QE", type = "Ship", dbid = 1008, name = "HMS Queen Elizabeth", isDefault = true, pts = 0, qty = 1, spawnRP = "FLEET_SPAWN1", category = "default", group = "Task Force Warships & Surface Auxiliaries", role = "Carrier Strike Group (CSG) Flagship", upgradeCost = 4 },
        { id = "StAlbans", type = "Ship", dbid = 3199, name = "HMS St Albans", isDefault = true, pts = 0, qty = 1, spawnRP = "FLEET_SPAWN1", category = "default", group = "Task Force Warships & Surface Auxiliaries", role = "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost = 2 },
        { id = "Daring", type = "Ship", dbid = 3200, name = "HMS Daring", isDefault = true, pts = 0, qty = 1, spawnRP = "FLEET_SPAWN1", category = "default", group = "Task Force Warships & Surface Auxiliaries", role = "Type 45 Destroyer (1x Wildcat & 2x Peregrine)", upgradeCost = 2 },
        { id = "LymeBay", type = "Ship", dbid = 1451, name = "RFA Lyme Bay", isDefault = true, pts = 0, qty = 1, spawnRP = "FLEET_SPAWN1", category = "default", group = "Task Force Warships & Surface Auxiliaries", role = "Bay-class Landing Ship — Cargo: Battalion Heavy Equipment & Stores (Embarked: 1x Chinook & 4x Puma UAV)" },
        { id = "Tideforce", type = "Ship", dbid = 2581, name = "RFA Tideforce", isDefault = true, pts = 0, qty = 1, spawnRP = "FLEET_SPAWN1", category = "default", group = "Task Force Warships & Surface Auxiliaries", role = "Tide-class Tanker — Embarked: 1x Wildcat & 2x Malloy T150" },
        { id = "Medway", type = "Ship", dbid = 2805, name = "HMS Medway", isDefault = true, pts = 0, qty = 1, spawnRP = "FLEET_FALKLANDS", category = "default", group = "Falklands Forward Patrol Asset", role = "River-class Batch 2 OPV (Falklands Forward Patrol) — Embarked: 2x Peregrine UAV" },

        -- Default Carrier Airwing (0 pts)
        { id = "F35B_def", type = "Aircraft", dbid = 1095, name = "F-35B Lightning II", shortName = "F-35B Lightning II", squadron = "617 Sqn", isDefault = true, pts = 0, qty = 12, spawnRP = "HMS Queen Elizabeth", category = "default", group = "Carrier Air Wing (Embarkation)", role = "Carrier Strike Fighter (1st Sq. - 12x Aircraft)", loadoutid = 25647 },
        { id = "Wildcat_def", type = "Aircraft", dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", isDefault = true, pts = 0, qty = 2, spawnRP = "HMS Queen Elizabeth", category = "default", group = "Carrier Air Wing (Embarkation)", role = "Carrier ASW/Utility Helo (2x Aircraft)", loadoutid = 17706 },
        { id = "Merlin_def", type = "Aircraft", dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "820 NAS", isDefault = true, pts = 0, qty = 2, spawnRP = "HMS Queen Elizabeth", category = "default", group = "Carrier Air Wing (Embarkation)", role = "Carrier ASW Helicopter (2x Aircraft)", loadoutid = 8559 },
        { id = "Crowsnest_def", type = "Aircraft", dbid = 4110, name = "Merlin ASaC.5 Crowsnest", shortName = "Merlin ASaC.5 Crowsnest", squadron = "820 NAS", isDefault = true, pts = 0, qty = 2, spawnRP = "HMS Queen Elizabeth", category = "default", group = "Carrier Air Wing (Embarkation)", role = "Carrier AEW Helicopter (2x Aircraft)", loadoutid = 8559 },
        { id = "MerlinHC4_def", type = "Aircraft", dbid = 4273, name = "Merlin HC.4", shortName = "Merlin HC.4", squadron = "845 NAS", isDefault = true, pts = 0, qty = 2, spawnRP = "HMS Queen Elizabeth", category = "default", group = "Carrier Air Wing (Embarkation)", role = "Carrier Transport Helicopter (2x Aircraft)", loadoutid = 21903 },
        { id = "Mojave_def", type = "Aircraft", dbid = 5696, name = "Mojave UAV", shortName = "Mojave UAV", squadron = "700X NAS", isDefault = true, pts = 0, qty = 2, spawnRP = "HMS Queen Elizabeth", category = "default", group = "Carrier Air Wing (Embarkation)", role = "Carrier Strike/Recon UAV (2x Drones)", loadoutid = 30519 },

        -- Default RAF (0 pts)
        { id = "Poseidon_def", type = "Aircraft", dbid = 4940, name = "P-8 Poseidon MRA.1", shortName = "Poseidon MRA.1", squadron = "120 Sqn", isDefault = true, pts = 0, qty = 2, spawnRP = "W8V2DT-0HNODCG173JA6", category = "default", group = "RAF Theater Air Support", role = "Maritime Patrol (RAF Lossiemouth - 2x Aircraft)", loadoutid = 27683 },
        { id = "Voyager_def", type = "Aircraft", dbid = 8072, name = "Airbus Voyager KC.3", shortName = "Voyager KC.3", squadron = "10 Sqn", isDefault = true, pts = 0, qty = 4, spawnRP = "W8V2DT-0HNODCG173J98", category = "default", group = "RAF Theater Air Support", role = "Strategic Tanker (RAF Brize Norton - 4x Aircraft)", loadoutid = 10562 },
        { id = "Globemaster_def", type = "Aircraft", dbid = 4275, name = "C-17A Globemaster III", shortName = "Globemaster III", squadron = "99 Sqn", isDefault = true, pts = 0, qty = 4, spawnRP = "W8V2DT-0HNODCG173J98", category = "default", group = "RAF Theater Air Support", role = "Heavy Transport (RAF Brize Norton - 4x Aircraft)", loadoutid = 21908 },
        { id = "Atlas_def", type = "Aircraft", dbid = 1420, name = "A400M Atlas C.1", shortName = "Atlas C.1", squadron = "70 Sqn", isDefault = true, pts = 0, qty = 10, spawnRP = "W8V2DT-0HNODCG173J98", category = "default", group = "RAF Theater Air Support", role = "Tactical Transport (RAF Brize Norton - 10x Aircraft)", loadoutid = 13775 },
        { id = "Protector_def", type = "Aircraft", dbid = 4724, name = "Protector RG.1", shortName = "Protector RG.1", squadron = "31 Sqn", isDefault = true, pts = 0, qty = 1, spawnRP = "W8V2DT-0HNODCG173JC2", category = "default", group = "RAF Theater Air Support", role = "Strategic UAV (RAF Marham - 1x Drone)", loadoutid = 13989 },

        -- Escorts & Submarines
        { id = "Somerset", type = "Ship", dbid = 3199, name = "HMS Somerset", pts = 5, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "escorts", group = "Type 23 ASW Frigates", role = "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost = 2 },
        { id = "Sutherland", type = "Ship", dbid = 3199, name = "HMS Sutherland", pts = 5, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "escorts", group = "Type 23 ASW Frigates", role = "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost = 2 },
        { id = "Kent", type = "Ship", dbid = 3199, name = "HMS Kent", pts = 5, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "escorts", group = "Type 23 ASW Frigates", role = "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost = 2 },
        { id = "Portland", type = "Ship", dbid = 3199, name = "HMS Portland", pts = 5, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "escorts", group = "Type 23 ASW Frigates", role = "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost = 2 },
        { id = "Dauntless", type = "Ship", dbid = 3200, name = "HMS Dauntless", pts = 7, maxLimit = 1, spawnRP = "BASE_PORTSMOUTH", category = "escorts", group = "Type 45 Air Defense Destroyers", role = "Type 45 Destroyer (1x Wildcat & 2x Peregrine)", upgradeCost = 2 },
        { id = "Diamond", type = "Ship", dbid = 3438, name = "HMS Diamond", pts = 10, maxLimit = 1, spawnRP = "BASE_PORTSMOUTH", category = "escorts", group = "Type 45 Air Defense Destroyers", role = "Type 45 Destroyer (Sea Ceptor - 1x Wildcat & 2x Peregrine)", upgradeCost = 2 },
        { id = "Dragon", type = "Ship", dbid = 3200, name = "HMS Dragon", pts = 7, maxLimit = 1, spawnRP = "BASE_PORTSMOUTH", category = "escorts", group = "Type 45 Air Defense Destroyers", role = "Type 45 Destroyer (1x Wildcat & 2x Peregrine)", upgradeCost = 2 },
        { id = "Defender", type = "Ship", dbid = 3438, name = "HMS Defender", pts = 10, maxLimit = 1, spawnRP = "BASE_PORTSMOUTH", category = "escorts", group = "Type 45 Air Defense Destroyers", role = "Type 45 Destroyer (Sea Ceptor - 1x Wildcat & 2x Peregrine)", upgradeCost = 2 },
        { id = "Venturer", type = "Ship", dbid = 3271, name = "HMS Venturer", pts = 3, maxLimit = 1, spawnRP = "BASE_ROSYTH", category = "escorts", group = "Next-Generation Frigates (Type 26 & Type 31)", role = "Type 31 General Purpose Frigate (1x Wildcat & 2x Peregrine)", upgradeCost = 2 },
        { id = "Glasgow", type = "Ship", dbid = 2795, name = "HMS Glasgow", pts = 7, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "escorts", group = "Next-Generation Frigates (Type 26 & Type 31)", role = "Type 26 Advanced ASW Frigate (1x Wildcat, 1x Proteus & 2x Peregrine)", upgradeCost = 2 },
        { id = "Agamemnon", type = "Submarine", dbid = 725, name = "HMS Agamemnon", pts = 5, maxLimit = 1, spawnRP = "BASE_CLYDE", category = "escorts", group = "Subsurface Fleet (Astute-Class SSN)", role = "Astute-Class Nuclear Submarine" },
        { id = "Anson", type = "Submarine", dbid = 725, name = "HMS Anson", pts = 5, maxLimit = 1, spawnRP = "BASE_CLYDE", category = "escorts", group = "Subsurface Fleet (Astute-Class SSN)", role = "Astute-Class Nuclear Submarine" },

        -- Support & Auxiliary
        { id = "Tidespring", type = "Ship", dbid = 2581, name = "RFA Tidespring", pts = 2, maxLimit = 1, spawnRP = "BASE_PORTLAND", category = "support", group = "Tide-Class & Fleet Replenishment (AOR)", role = "Tide-class Tanker — Embarked: 1x Wildcat & 2x Malloy T150" },
        { id = "Tiderace", type = "Ship", dbid = 2581, name = "RFA Tiderace", pts = 2, maxLimit = 1, spawnRP = "BASE_PORTLAND", category = "support", group = "Tide-Class & Fleet Replenishment (AOR)", role = "Tide-class Tanker — Embarked: 1x Wildcat & 2x Malloy T150" },
        { id = "Tidesurge", type = "Ship", dbid = 2581, name = "RFA Tidesurge", pts = 2, maxLimit = 1, spawnRP = "BASE_PORTLAND", category = "support", group = "Tide-Class & Fleet Replenishment (AOR)", role = "Tide-class Tanker — Embarked: 1x Wildcat & 2x Malloy T150" },
        { id = "FortVictoria", type = "Ship", dbid = 406, name = "RFA Fort Victoria", pts = 2, maxLimit = 1, spawnRP = "BASE_PORTLAND", category = "support", group = "Tide-Class & Fleet Replenishment (AOR)", role = "AOR Fleet Replenishment (1x Merlin, 1x HC.4 & 1x Peregrine)" },
        { id = "MountsBay", type = "Ship", dbid = 1451, name = "RFA Mounts Bay", pts = 3, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "support", group = "Bay-Class Amphibious Landing Ships", role = "Bay-class Landing Ship — Cargo: Battalion Heavy Equipment & Stores (Embarked: 1x Chinook & 4x Puma UAV)" },
        { id = "CardiganBay", type = "Ship", dbid = 1451, name = "RFA Cardigan Bay", pts = 3, maxLimit = 1, spawnRP = "BASE_DEVONPORT", category = "support", group = "Bay-Class Amphibious Landing Ships", role = "Bay-class Landing Ship — Cargo: Battalion Heavy Equipment & Stores (Embarked: 1x Chinook & 4x Puma UAV)" },
        { id = "HurstPoint", type = "Ship", dbid = 2423, name = "MV Hurst Point", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "Point-Class Strategic Sealift (Ro-Ro)", role = "STUFT Strategic Ro-Ro Cargo" },
        { id = "Eddystone", type = "Ship", dbid = 2423, name = "MV Eddystone", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "Point-Class Strategic Sealift (Ro-Ro)", role = "STUFT Strategic Ro-Ro Cargo" },
        { id = "HartlandPoint", type = "Ship", dbid = 2423, name = "MV Hartland Point", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "Point-Class Strategic Sealift (Ro-Ro)", role = "STUFT Strategic Ro-Ro Cargo" },
        { id = "AnvilPoint", type = "Ship", dbid = 2423, name = "MV Anvil Point", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "Point-Class Strategic Sealift (Ro-Ro)", role = "STUFT Strategic Ro-Ro Cargo" },
        { id = "WaveKnight", type = "Ship", dbid = 1406, name = "RFA Wave Knight", pts = 1, maxLimit = 1, spawnRP = "BASE_PORTLAND", category = "support", group = "Wave-Class Fast Fleet Tankers", role = "Wave-class Fast Fleet Tanker" },
        { id = "WaveRuler", type = "Ship", dbid = 1406, name = "RFA Wave Ruler", pts = 1, maxLimit = 1, spawnRP = "BASE_PORTLAND", category = "support", group = "Wave-Class Fast Fleet Tankers", role = "Wave-class Fast Fleet Tanker" },
        { id = "Canberra", type = "Ship", dbid = 2024, name = "MV Canberra", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "STUFT Transports & Commercial Charters", role = "Chartered Troop Transport — Cargo: 2,000 Troop Capacity" },
        { id = "QueenVictoria", type = "Ship", dbid = 2024, name = "MV Queen Victoria", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "STUFT Transports & Commercial Charters", role = "Chartered Troop Transport — Cargo: 2,000 Troop Capacity" },
        { id = "LeanderFisher", type = "Ship", dbid = 144, name = "MV Leander Fisher", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "STUFT Transports & Commercial Charters", role = "Chartered Coastal Tanker" },
        { id = "FureVanguard", type = "Ship", dbid = 144, name = "MV Fure Vanguard", pts = 1, maxLimit = 1, spawnRP = "BASE_MARCHWOOD", category = "support", group = "STUFT Transports & Commercial Charters", role = "Chartered Coastal Tanker" },

        -- Carrier Air Wing
        { id = "F35B_add", type = "Aircraft", dbid = 1095, name = "F-35B Lightning II", shortName = "F-35B Lightning II", squadron = "809 NAS", pts = 20, maxLimit = 1, spawnQty = 12, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Carrier Strike & Naval Air Wing", role = "Carrier Strike Fighter (2nd Squadron - 12x Aircraft)", loadoutid = 25647 },
        { id = "Wildcat_add", type = "Aircraft", dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", pts = 1, maxLimit = 8, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Carrier Strike & Naval Air Wing", role = "Carrier ASW/Utility Helicopter", loadoutid = 17706 },
        { id = "Crowsnest_add", type = "Aircraft", dbid = 4110, name = "Merlin ASaC.5 Crowsnest", shortName = "Merlin ASaC.5 Crowsnest", squadron = "820 NAS", pts = 1, maxLimit = 4, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Carrier Strike & Naval Air Wing", role = "Carrier AEW Helicopter", loadoutid = 8559 },
        { id = "MerlinHC4_add", type = "Aircraft", dbid = 4273, name = "Merlin HC.4", shortName = "Merlin HC.4", squadron = "845 NAS", pts = 1, maxLimit = 6, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Carrier Strike & Naval Air Wing", role = "Carrier Commando Transport", loadoutid = 21903 },
        { id = "Mojave_add", type = "Aircraft", dbid = 5696, name = "Mojave UAV", shortName = "Mojave UAV", squadron = "700X NAS", pts = 1, maxLimit = 4, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Carrier Strike & Naval Air Wing", role = "Carrier Strike/Recon UAV", loadoutid = 30519 },
        { id = "Peregrine_add", type = "Aircraft", dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", pts = 1, maxLimit = 1, spawnQty = 4, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Carrier Strike & Naval Air Wing", role = "Carrier Recon UAV Flight (4x Drones)", loadoutid = 16924 },
        { id = "Apache_add_carrier", type = "Aircraft", dbid = 4842, name = "Apache AH.Mk.2", shortName = "Apache AH.Mk.2", squadron = "656 Sqn AAC", pts = 1, maxLimit = 6, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Joint Expeditionary Aviation (Army / Commando)", role = "Army Attack Helicopter (Carrier)", loadoutid = 30355 },
        { id = "Chinook_add_carrier", type = "Aircraft", dbid = 5293, name = "Chinook H-47", shortName = "Chinook H-47", squadron = "27 Sqn", pts = 1, maxLimit = 4, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Joint Expeditionary Aviation (Army / Commando)", role = "Heavy Transport Helicopter (Carrier)", loadoutid = 29485 },
        { id = "WildcatAH1_add", type = "Aircraft", dbid = 3373, name = "Wildcat AH1", shortName = "Wildcat AH1", squadron = "847 NAS", pts = 1, maxLimit = 4, spawnRP = "HMS Queen Elizabeth", category = "airwing", group = "Joint Expeditionary Aviation (Army / Commando)", role = "Army Tactical Utility (847 Sq.)", loadoutid = 17710 },

        -- RAF
        { id = "Wedgetail_add", type = "Aircraft", dbid = 4941, name = "E-7A Wedgetail AEW.1", shortName = "Wedgetail AEW.1", squadron = "8 Sqn", pts = 4, maxLimit = 1, spawnRP = "W8V2DT-0HNODCG173J98", category = "raf", group = "Intelligence, Surveillance & Reconnaissance (ISR)", role = "AEW&C (Brize Norton)", loadoutid = 27687 },
        { id = "RivetJoint_add", type = "Aircraft", dbid = 5834, name = "RC-135W Rivet Joint", shortName = "Rivet Joint", squadron = "51 Sqn", pts = 4, maxLimit = 1, spawnRP = "W8V2DT-0HNODCG173J98", category = "raf", group = "Intelligence, Surveillance & Reconnaissance (ISR)", role = "SIGINT/ESM (Brize Norton)", loadoutid = 8825 },
        { id = "Poseidon_add", type = "Aircraft", dbid = 4940, name = "P-8 Poseidon MRA.1", shortName = "Poseidon MRA.1", squadron = "120 Sqn", pts = 2, maxLimit = 4, spawnRP = "W8V2DT-0HNODCG173JA6", category = "raf", group = "Intelligence, Surveillance & Reconnaissance (ISR)", role = "Maritime Patrol (Lossiemouth)", loadoutid = 27683 },
        { id = "Protector_add", type = "Aircraft", dbid = 4724, name = "Protector RG.1", shortName = "Protector RG.1", squadron = "31 Sqn", pts = 1, maxLimit = 5, spawnRP = "W8V2DT-0HNODCG173JC2", category = "raf", group = "Intelligence, Surveillance & Reconnaissance (ISR)", role = "Strategic MALE UAV (Marham)", loadoutid = 13989 },
        { id = "Voyager_add", type = "Aircraft", dbid = 8072, name = "Airbus Voyager KC.3", shortName = "Voyager KC.3", squadron = "10 Sqn", pts = 1, maxLimit = 8, spawnRP = "W8V2DT-0HNODCG173J98", category = "raf", group = "Strategic Tankers & Air Transport", role = "Strategic Tanker (Brize Norton)", loadoutid = 10562 },
        { id = "Globemaster_add", type = "Aircraft", dbid = 4275, name = "C-17A Globemaster III", shortName = "Globemaster III", squadron = "99 Sqn", pts = 1, maxLimit = 4, spawnRP = "W8V2DT-0HNODCG173J98", category = "raf", group = "Strategic Tankers & Air Transport", role = "Strategic Transport (Brize Norton)", loadoutid = 21908 },
        { id = "Atlas_add", type = "Aircraft", dbid = 1420, name = "A400M Atlas C.1", shortName = "Atlas C.1", squadron = "70 Sqn", pts = 1, maxLimit = 10, spawnRP = "W8V2DT-0HNODCG173J98", category = "raf", group = "Strategic Tankers & Air Transport", role = "Tactical Transport (Brize Norton)", loadoutid = 13775 },
        { id = "Chinook_add_bay", type = "Aircraft", dbid = 5293, name = "Chinook H-47", shortName = "Chinook H-47", squadron = "27 Sqn", pts = 1, maxLimit = 6, spawnRP = "RFA Lyme Bay", category = "raf", group = "Forward Expeditionary Aviation (Bay-Class Embarked)", role = "Amphibious Heavy Lift (Bay-class)", loadoutid = 29485 },
        { id = "Apache_add_bay", type = "Aircraft", dbid = 4842, name = "Apache AH.Mk.2", shortName = "Apache AH.Mk.2", squadron = "656 Sqn AAC", pts = 1, maxLimit = 4, spawnRP = "RFA Lyme Bay", category = "raf", group = "Forward Expeditionary Aviation (Bay-Class Embarked)", role = "Amphibious Strike (Bay-class)", loadoutid = 30355 }
    }
}

-- Fast lookup map for server-side validation
local MODEL_MAP = {}
for _, item in ipairs(CTFS.MODEL.items) do
    MODEL_MAP[item.id] = item
    MODEL_MAP[item.name] = item
end

-- =============================================================================
-- EMBARKED SHIP AVIATION COMPLEMENTS (Helicopters & UAVs)
-- Automatically spawned and hosted aboard surface combatants and auxiliaries
-- =============================================================================
CTFS.SHIP_AIRCRAFT = {
    -- Type 23 Frigates (1x Merlin HM.2, 2x Camcopter S-100 Peregrine)
    ["HMS St Albans"]     = { { dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "814 NAS", loadoutid = 8559, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Somerset"]      = { { dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "814 NAS", loadoutid = 8559, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Sutherland"]    = { { dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "814 NAS", loadoutid = 8559, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Kent"]          = { { dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "814 NAS", loadoutid = 8559, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Portland"]      = { { dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "814 NAS", loadoutid = 8559, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },

    -- Type 45 Destroyers (1x Wildcat HMA.2, 2x Camcopter S-100 Peregrine)
    ["HMS Daring"]        = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Dauntless"]     = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Diamond"]       = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Dragon"]        = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["HMS Defender"]      = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },

    -- Type 31 General Purpose Frigate (1x Wildcat HMA.2, 2x Camcopter S-100 Peregrine)
    ["HMS Venturer"]      = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },

    -- Type 26 Advanced ASW Frigate (1x Wildcat HMA.2, 1x Proteus RWUAS, 2x Camcopter S-100 Peregrine)
    ["HMS Glasgow"]       = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 7662, name = "Proteus RWUAS", shortName = "Proteus RWUAS", squadron = "700X NAS", loadoutid = 34969, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },

    -- Bay-Class Amphibious LSD(A) (1x Chinook H-47, 4x RQ-20B Puma UAV)
    ["RFA Lyme Bay"]      = { { dbid = 5293, name = "Chinook H-47", shortName = "Chinook H-47", squadron = "27 Sqn", loadoutid = 29485, qty = 1 }, { dbid = 6787, name = "RQ-20B Puma AE II", shortName = "Puma UAV", squadron = "700X NAS", loadoutid = 29969, qty = 4 } },
    ["RFA Mounts Bay"]    = { { dbid = 5293, name = "Chinook H-47", shortName = "Chinook H-47", squadron = "27 Sqn", loadoutid = 29485, qty = 1 }, { dbid = 6787, name = "RQ-20B Puma AE II", shortName = "Puma UAV", squadron = "700X NAS", loadoutid = 29969, qty = 4 } },
    ["RFA Cardigan Bay"]  = { { dbid = 5293, name = "Chinook H-47", shortName = "Chinook H-47", squadron = "27 Sqn", loadoutid = 29485, qty = 1 }, { dbid = 6787, name = "RQ-20B Puma AE II", shortName = "Puma UAV", squadron = "700X NAS", loadoutid = 29969, qty = 4 } },

    -- Tide-Class Fast Fleet Replenishment Tankers (1x Wildcat HMA.2, 2x Malloy T150 Cargo Drones)
    ["RFA Tideforce"]     = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 7575, name = "Malloy T150 Cargo Drone", shortName = "Malloy T150", squadron = "700X NAS", loadoutid = 30885, qty = 2 } },
    ["RFA Tidespring"]    = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 7575, name = "Malloy T150 Cargo Drone", shortName = "Malloy T150", squadron = "700X NAS", loadoutid = 30885, qty = 2 } },
    ["RFA Tiderace"]      = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 7575, name = "Malloy T150 Cargo Drone", shortName = "Malloy T150", squadron = "700X NAS", loadoutid = 30885, qty = 2 } },
    ["RFA Tidesurge"]     = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 7575, name = "Malloy T150 Cargo Drone", shortName = "Malloy T150", squadron = "700X NAS", loadoutid = 30885, qty = 2 } },

    -- Wave-Class Fast Fleet Tankers (1x Wildcat HMA.2, 2x Camcopter S-100 Peregrine)
    ["RFA Wave Knight"]   = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },
    ["RFA Wave Ruler"]    = { { dbid = 6786, name = "Wildcat HMA.2", shortName = "Wildcat HMA.2", squadron = "815 NAS", loadoutid = 17706, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } },

    -- AOR Fleet Replenishment (1x Merlin HM.2, 1x Merlin HC.4, 1x Camcopter S-100 Peregrine)
    ["RFA Fort Victoria"] = { { dbid = 3336, name = "Merlin HM.2", shortName = "Merlin HM.2", squadron = "814 NAS", loadoutid = 8559, qty = 1 }, { dbid = 4273, name = "Merlin HC.4", shortName = "Merlin HC.4", squadron = "845 NAS", loadoutid = 21903, qty = 1 }, { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 1 } },

    -- River-Class Batch 2 OPV (2x Camcopter S-100 Peregrine)
    ["HMS Medway"]        = { { dbid = 6688, name = "Camcopter S-100 Peregrine", shortName = "Peregrine UAV", squadron = "700X NAS", loadoutid = 16924, qty = 2 } }
}

-- Authentic UK Naval Base Staging Reference Points
CTFS.BASE_STAGING_RPS = {
    Portsmouth = "BASE_PORTSMOUTH",
    Devonport  = "BASE_DEVONPORT",
    Rosyth     = "BASE_ROSYTH",
    Clyde      = "BASE_CLYDE",
    Portland   = "BASE_PORTLAND",
    Marchwood  = "BASE_MARCHWOOD"
}

-- Authentic Airbase Human Display Names for Uniform Aviation Naming
CTFS.AIRBASE_DISPLAY_NAMES = {
    ["W8V2DT-0HNODCG173JA6"] = "RAF Lossiemouth",
    ["W8V2DT-0HNODCG173J98"] = "RAF Brize Norton",
    ["W8V2DT-0HNODCG173JC2"] = "RAF Marham"
}

-- Standardized Aircraft Naming Generator: "<Host> <ShortName> (<Squadron>) #<Num>"
local function FormatAircraftName(hostName, shortName, squadron, curNum, totalNum)
    local baseStr = hostName .. " " .. shortName
    if squadron and squadron ~= "" then
        baseStr = baseStr .. " (" .. squadron .. ")"
    end
    if totalNum and totalNum > 1 then
        return baseStr .. " #" .. curNum
    else
        return baseStr
    end
end

-- Safe RP coordinate resolution with graceful fallbacks (RP -> FLEET_SPAWN1..5 -> coordinates)
local function ResolveSpawnCoords(targetRP, fallbackRP)
    local rp = nil
    if targetRP and targetRP ~= "" then
        pcall(function()
            rp = ScenEdit_GetReferencePoint({ side = "UK", name = targetRP })
        end)
    end
    if not rp and fallbackRP and fallbackRP ~= "" then
        pcall(function()
            rp = ScenEdit_GetReferencePoint({ side = "UK", name = fallbackRP })
        end)
    end
    if not rp then
        for s = 1, 5 do
            pcall(function()
                rp = ScenEdit_GetReferencePoint({ side = "UK", name = "FLEET_SPAWN" .. s })
            end)
            if rp then break end
        end
    end
    if rp then
        return rp.latitude, rp.longitude
    end
    return "-50.0000", "-50.0000"
end

-- =============================================================================
-- WEAPON MAGAZINE & VLS SILO CONFIGURATION ENGINES
-- =============================================================================
function CTFS.ConfigureShipVLS(unit, hasVlsUpgrade)
    if not unit then return end
    if unit.guid then
        local refreshed = ScenEdit_GetUnit({ guid = unit.guid })
        if refreshed then unit = refreshed end
    end
    if not unit.mounts then return end

    -- Full VLS upgrade (+2 pts) retains 100% full silos as spawned by CMO
    if hasVlsUpgrade then return end

    -- Peacetime loadout: reduce VLS silos to ~25% capacity.
    -- In CMO, ScenEdit_AddReloadsToUnit({ number = N, remove = true }) on a VLS mount
    -- operates in units of physical SILOS / CELLS (not individual quadpacked missiles).
    -- If 'number' were specified in raw missile count for a quadpacked mount (e.g. 18 CAMMs on
    -- a 6-cell mount), CMO would interpret '18' as 18 cells to remove, which exceeds the
    -- 6-cell capacity and empties the entire launcher to 0/24.
    --
    -- Calculation:
    --   1) Determine physical cell capacity ('cellCount') of the mount.
    --   2) Determine packing ratio ('multiple' = maxCap / cellCount, e.g. 4 for CAMM).
    --   3) Calculate target loaded cells: targetCells = math.max(1, math.floor(cellCount * 0.25 + 0.5)).
    --      - Sea Viper (48 cells, 1 Aster/cell): 12 cells kept (12 missiles) -> remove 36 cells.
    --      - Sea Ceptor on Type 45 (6 cells, 4 CAMM/cell): 2 cells kept (8 CAMMs) -> remove 4 cells.
    --      - Sea Ceptor on Type 23 (8 cells, 4 CAMM/cell): 2 cells kept (8 CAMMs) -> remove 6 cells.
    --      - Sea Ceptor on Type 26 (12 cells, 4 CAMM/cell): 3 cells kept (12 CAMMs) -> remove 9 cells.
    --      - Mk 41 on Type 26 (24 cells, 1 Tomahawk/cell): 6 cells kept (6 Tomahawks) -> remove 18 cells.
    local vlsKeywords = { "vls", "sylver", "cell", "silo", "gws", "ceptor", "vertical", "mk 41", "mk41", "aster", "camm" }

    for _, mount in pairs(unit.mounts) do
        local mName = (mount.mount_name or mount.name or ""):lower()
        local isVls = false
        for _, kw in ipairs(vlsKeywords) do
            if string.find(mName, kw, 1, true) then
                isVls = true
                break
            end
        end

        local weapons = mount.mount_weapons or mount.weapons
        if isVls and weapons then
            -- Determine physical cell capacity of the mount
            local cellCount = tonumber(mount.mount_capacity) or tonumber(mount.capacity)
            if not cellCount or cellCount <= 0 then
                local numStr = mName:match("(%d+)%s*cells?") or mName:match("%[(%d+)%s*cells?%]")
                if numStr then
                    cellCount = tonumber(numStr)
                end
            end

            for _, w in pairs(weapons) do
                local wpnDbid = tonumber(w.wpn_dbid)
                local maxCap = tonumber(w.wpn_maxcap) or tonumber(w.wpn_capacity) or tonumber(w.wpn_current) or 0
                local current = tonumber(w.wpn_current) or maxCap

                if wpnDbid and maxCap > 0 then
                    -- Determine quadpacking / multiple ratio
                    local multiple = 1
                    if cellCount and cellCount > 0 and maxCap >= cellCount then
                        multiple = math.floor(maxCap / cellCount)
                        if multiple < 1 then multiple = 1 end
                    else
                        multiple = 1
                        if not cellCount or cellCount <= 0 then
                            cellCount = maxCap
                        end
                    end

                    -- Calculate current cells and target cells
                    local currentCells = math.ceil(current / multiple)
                    local targetCells = math.max(1, math.floor(cellCount * 0.25 + 0.5))
                    local cellsToRemove = currentCells - targetCells

                    -- Safety clamp: cannot remove more than current loaded cells
                    if cellsToRemove > currentCells then
                        cellsToRemove = currentCells
                    end

                    if cellsToRemove > 0 then
                        local mountGuid = mount.mount_guid or mount.guid
                        pcall(function()
                            ScenEdit_AddReloadsToUnit({
                                side = unit.side,
                                guid = unit.guid,
                                unitname = unit.name,
                                mount_guid = mountGuid,
                                wpn_dbid = wpnDbid,
                                number = cellsToRemove,
                                remove = true
                            })
                        end)
                    end
                end
            end
        end
    end
end

function CTFS.ConfigureCarrierMagazines(carrierUnit, upgradeSteps)
    if not carrierUnit then return end
    if carrierUnit.guid then
        local refreshed = ScenEdit_GetUnit({ guid = carrierUnit.guid })
        if refreshed then carrierUnit = refreshed end
    end
    if not carrierUnit.magazines then return end

    local steps = tonumber(upgradeSteps) or 0
    if steps > 3 then steps = 3 end

    -- 0 steps = 25% fill (peacetime baseline)
    -- 1 step  = 50% fill (+4 pts)
    -- 2 steps = 75% fill (+8 pts)
    -- 3 steps = 100% fill (+12 pts, full capacity retained)
    local targetPercent = 25 + (steps * 25)
    if targetPercent >= 100 then return end

    for _, mag in pairs(carrierUnit.magazines) do
        local weapons = mag.mag_weapons or mag.weapons
        if weapons then
            for _, w in pairs(weapons) do
                local wpnDbid = tonumber(w.wpn_dbid)
                local maxCap = tonumber(w.wpn_maxcap) or tonumber(w.wpn_capacity) or tonumber(w.wpn_current) or 0
                local current = tonumber(w.wpn_current) or maxCap
                if wpnDbid and maxCap > 0 then
                    local targetQty = math.floor(maxCap * (targetPercent / 100))
                    local toRemove = current - targetQty
                    if toRemove > 0 then
                        pcall(function()
                            ScenEdit_AddWeaponToUnitMagazine({
                                guid = carrierUnit.guid,
                                mag_guid = mag.mag_guid or mag.guid,
                                wpn_dbid = wpnDbid,
                                number = toRemove,
                                remove = true
                            })
                        end)
                    end
                end
            end
        end
    end
end

-- =============================================================================
-- CRITICAL SPEC REQUIREMENT: CSS FORMATTING COLLISION ESCAPING
-- Matches AI-html-lua-reference.txt line 69-79
-- =============================================================================
local function EscapePercentsButKeep_s(str)
    -- Protect intended formatting slot
    str = string.gsub(str, 'value="%%s"', 'value="__FMT_S__"', 1)

    -- Escape literal CSS percentages (e.g. width: 100%; -> width: 100%%;)
    str = string.gsub(str, "%%", "%%%%")

    -- Restore formatting slot
    str = string.gsub(str, 'value="__FMT_S__"', 'value="%%s"', 1)
    return str
end

-- Safe local file reader supporting both scenario distribution (Attachments) and dev environments
local function ReadLocalFile(filename, debugLog)
    debugLog = debugLog or {}

    if not io or not io.open then
        table.insert(debugLog, "[SANDBOX RESTRICTION] 'io' or 'io.open' is NIL in this CMO sandbox environment.")
        return nil, debugLog
    end

    local scenFolder = rawget(_G, "_scenariofolder_") or ""
    if scenFolder ~= "" and not scenFolder:match("[\\/]$") then
        scenFolder = scenFolder .. "\\"
    end

    -- Extract bare filename if a subpath was passed
    local bareName = filename:match("([^\\/]+)$") or filename

    local candidates = {
        -- Scenario Attachments relative to _scenariofolder_
        scenFolder .. "Attachments\\CTFS\\" .. bareName,
        scenFolder .. "attachments\\CTFS\\" .. bareName,
        scenFolder .. "Attachments\\" .. bareName,
        scenFolder .. bareName,

        -- Relative to CMO root (Command - Modern Operations)
        "Attachments\\CTFS\\" .. bareName,
        "attachments\\CTFS\\" .. bareName,
        "Lua\\Development\\Global\\Falklands Systems\\CTFS\\" .. bareName,
        "Development\\Global\\Falklands Systems\\CTFS\\" .. bareName,
        "Global\\Falklands Systems\\CTFS\\" .. bareName,
        "Falklands Systems\\CTFS\\" .. bareName,
        "CTFS\\" .. bareName,
        bareName,

        -- Absolute development path fallback
        "d:\\SteamLibrary\\steamapps\\common\\Command - Modern Operations\\Lua\\Development\\Global\\Falklands Systems\\CTFS\\" ..
        bareName
    }

    local tested = {}
    for _, candidate in ipairs(candidates) do
        if candidate and candidate ~= "" and not tested[candidate] then
            tested[candidate] = true
            local f, err = io.open(candidate, "r")
            if f then
                local content = f:read("*all")
                f:close()
                table.insert(debugLog, "[SUCCESS] Found: " .. candidate .. " (" .. tostring(#content) .. " bytes)")
                return content, debugLog
            else
                local reason = tostring(err or "file not found")
                table.insert(debugLog, "[FAILED] " .. candidate .. " -> " .. reason)
            end
        end
    end

    return nil, debugLog
end

-- Spawns a randomized field of naval mines around a central coordinate
local function SpawnMinefield(side, dbid, centerLat, centerLon, mineCount, radiusNm)
    local numLat = tonumber(centerLat)
    local numLon = tonumber(centerLon)
    if not numLat or not numLon then return end

    for i = 1, mineCount do
        local latOffset = (math.random() - 0.5) * 2 * (radiusNm / 60)
        local lonOffset = (math.random() - 0.5) * 2 * (radiusNm / 60)
        ScenEdit_AddUnit({
            type = "Weapon",
            side = side,
            dbid = dbid,
            name = "MDM-5 Mine #" .. i,
            latitude = tostring(numLat + latOffset),
            longitude = tostring(numLon + lonOffset)
        })
    end
end

-- =============================================================================
-- SERVER-SIDE MATH VALIDATION & ANTI-SPOOFING VERIFICATION
-- Strictly verifies submitted units and upgrades against CTFS.MODEL
-- =============================================================================
function CTFS.VerifyAndCalculateOrder(selections)
    local verifiedUnits = {}
    local verifiedUpgrades = {}
    local totalCalculatedPoints = 0

    if not selections or type(selections) ~= "table" then
        return nil, "Invalid payload structure"
    end

    -- 1. Verify Requested Units
    local includedDefaults = {}
    if selections.units and type(selections.units) == "table" then
        for _, req in ipairs(selections.units) do
            local master = MODEL_MAP[req.id] or MODEL_MAP[req.name]
            if master then
                local qty = tonumber(req.qty) or 1
                if master.isDefault then
                    -- Defaults are mandatory, quantity locked, cost 0
                    if not includedDefaults[master.id] then
                        includedDefaults[master.id] = true
                        qty = master.qty or 1
                        table.insert(verifiedUnits, {
                            id = master.id,
                            name = master.name,
                            shortName = master.shortName,
                            squadron = master.squadron,
                            type = master.type,
                            dbid = master.dbid,
                            spawnRP = master.spawnRP,
                            loadoutid = master.loadoutid,
                            qty = qty,
                            pts = 0,
                            isDefault = true
                        })
                    end
                elseif qty > 0 then
                    -- Enforce max limit
                    local maxLimit = master.maxLimit or 1
                    if qty > maxLimit then qty = maxLimit end

                    local spawnCount = master.spawnQty or qty
                    local cost = (master.spawnQty and master.pts) or (qty * master.pts)
                    totalCalculatedPoints = totalCalculatedPoints + cost

                    table.insert(verifiedUnits, {
                        id = master.id,
                        name = master.name,
                        shortName = master.shortName,
                        squadron = master.squadron,
                        type = master.type,
                        dbid = master.dbid,
                        spawnRP = master.spawnRP,
                        loadoutid = master.loadoutid,
                        qty = spawnCount,
                        pts = master.pts,
                        isDefault = false
                    })
                end
            end
        end
    end

    -- Ensure all mandatory baseline default assets are included
    for _, master in ipairs(CTFS.MODEL.items) do
        if master.isDefault and not includedDefaults[master.id] then
            includedDefaults[master.id] = true
            table.insert(verifiedUnits, {
                id = master.id,
                name = master.name,
                shortName = master.shortName,
                squadron = master.squadron,
                type = master.type,
                dbid = master.dbid,
                spawnRP = master.spawnRP,
                loadoutid = master.loadoutid,
                qty = master.qty or 1,
                pts = 0,
                isDefault = true
            })
        end
    end

    -- 2. Verify Munition/VLS Upgrades
    if selections.upgrades and type(selections.upgrades) == "table" then
        for targetName, percent in pairs(selections.upgrades) do
            local master = MODEL_MAP[targetName]
            if master and master.upgradeCost then
                if master.name == "HMS Queen Elizabeth" then
                    local p = tonumber(percent) or 0
                    local steps = math.floor(p / 25)
                    if steps > 3 then steps = 3 end
                    if steps > 0 then
                        local upgradePoints = steps * master.upgradeCost
                        totalCalculatedPoints = totalCalculatedPoints + upgradePoints
                        verifiedUpgrades[master.name] = steps
                    end
                else
                    -- Surface Warship Full VLS Silos Upgrade (+2 pts)
                    if percent == true or (tonumber(percent) and tonumber(percent) > 0) then
                        totalCalculatedPoints = totalCalculatedPoints + master.upgradeCost
                        verifiedUpgrades[master.name] = true
                    end
                end
            end
        end
    end

    -- 3. Enforce Hard Budget Limit (100 Points)
    if totalCalculatedPoints > CTFS.MaxPoints then
        return nil, "Budget exceeded: " .. totalCalculatedPoints .. " points requested (Max: " .. CTFS.MaxPoints .. ")"
    end

    return {
        units = verifiedUnits,
        upgrades = verifiedUpgrades,
        totalPoints = totalCalculatedPoints,
        hoursDelay = totalCalculatedPoints * CTFS.HoursPerPoint
    }, nil
end

-- =============================================================================
-- TIME MANAGEMENT & SCENARIO CLOCK JUMP
-- =============================================================================
function CTFS.ExecuteTimeJump(pointsSpent)
    if pointsSpent > CTFS.MaxPoints then pointsSpent = CTFS.MaxPoints end
    local hoursToDelay = pointsSpent * CTFS.HoursPerPoint
    local currentTime = ScenEdit_CurrentTime()

    -- Advance epoch timestamp (seconds)
    local newTime = currentTime + (hoursToDelay * 3600)
    local dateStr = os.date("!%d.%m.%Y", newTime)
    local timeStr = os.date("!%H:%M:%S", newTime)

    ScenEdit_SetTime({ Date = dateStr, Time = timeStr })
    return hoursToDelay, dateStr, timeStr
end

-- =============================================================================
-- ARGENTINE ESCALATION MATRIX (argentine-boons.md)
-- =============================================================================
function CTFS.ApplyArgentineBoons(points)
    -- Phase 1: 10 - 25 pts (Early Warnings)
    if points >= 10 then
        ScenEdit_AddUnit({
            type = "Facility",
            side = "Argentina",
            dbid = CTFS.DB_ARG.SpyderSR,
            name = "SPYDER-SR Bty (Stanley Canopus)",
            latitude = CTFS.COORDS.Stanley_Canopus.latitude,
            longitude = CTFS.COORDS.Stanley_Canopus.longitude
        })
    end
    if points >= 20 then
        -- 2x F-16AM CAP Fighters at Mount Pleasant
        ScenEdit_AddUnit({
            type = "Aircraft",
            side = "Argentina",
            dbid = CTFS.DB_ARG.Fighter,
            loadoutid = CTFS.DB_ARG.Fighter_A2A,
            name = "ARG F-16AM CAP #1",
            latitude = CTFS.COORDS.Pleasant.latitude,
            longitude = CTFS.COORDS.Pleasant.longitude,
            altitude = 10000
        })
        ScenEdit_AddUnit({
            type = "Aircraft",
            side = "Argentina",
            dbid = CTFS.DB_ARG.Fighter,
            loadoutid = CTFS.DB_ARG.Fighter_A2A,
            name = "ARG F-16AM CAP #2",
            latitude = CTFS.COORDS.Pleasant.latitude,
            longitude = CTFS.COORDS.Pleasant.longitude,
            altitude = 10000
        })
    end

    -- Phase 2: 26 - 50 pts (Entrenchment)
    if points >= 30 then
        ScenEdit_AddUnit({
            type = "Facility",
            side = "Argentina",
            dbid = CTFS.DB_ARG.ExocetSSM,
            name = "Coastal Exocet SSM Bty (Fanning Head)",
            latitude = CTFS.COORDS.Chokepoint1.latitude,
            longitude = CTFS.COORDS.Chokepoint1.longitude
        })
    end
    if points >= 40 then
        SpawnMinefield("Argentina", CTFS.DB_ARG.Mine, CTFS.COORDS.Chokepoint1.latitude, CTFS.COORDS.Chokepoint1
            .longitude, 15, 2.0)
    end
    if points >= 50 then
        ScenEdit_SetSideOptions({ side = "Argentina", proficiency = "Veteran" })
    end

    -- Phase 3: 51 - 75 pts (Regional Support)
    if points >= 60 then
        ScenEdit_AddUnit({
            type = "Facility",
            side = "Argentina",
            dbid = CTFS.DB_ARG.SpyderMR,
            name = "SPYDER-MR Bty (Stanley Tumbledown)",
            latitude = CTFS.COORDS.Stanley_Tumbledown.latitude,
            longitude = CTFS.COORDS.Stanley_Tumbledown.longitude
        })
    end
    if points >= 70 then
        ScenEdit_AddUnit({
            type = "Submarine",
            side = "Argentina",
            dbid = CTFS.DB_ARG.Submarine,
            name = "ARA Salta (Type 209)",
            latitude = CTFS.COORDS.SubPatrol1.latitude,
            longitude = CTFS.COORDS.SubPatrol1.longitude
        })
    end
    if points >= 75 then
        ScenEdit_AddUnit({
            type = "Submarine",
            side = "Argentina",
            dbid = CTFS.DB_ARG.Submarine,
            name = "ARA San Luis (Type 209)",
            latitude = CTFS.COORDS.SubPatrol2.latitude,
            longitude = CTFS.COORDS.SubPatrol2.longitude
        })
    end

    -- Phase 4: 76 - 100 pts (Maximum Readiness)
    if points >= 80 then
        ScenEdit_AddUnit({
            type = "Aircraft",
            side = "Argentina",
            dbid = CTFS.DB_ARG.Fighter,
            loadoutid = CTFS.DB_ARG.Fighter_A2G,
            name = "ARG Mainland Strike Flight #1",
            latitude = CTFS.COORDS.Chokepoint1.latitude,
            longitude = tostring(tonumber(CTFS.COORDS.Chokepoint1.longitude) - 2.0),
            altitude = 5000
        })
        ScenEdit_AddUnit({
            type = "Aircraft",
            side = "Argentina",
            dbid = CTFS.DB_ARG.Fighter,
            loadoutid = CTFS.DB_ARG.Fighter_A2G,
            name = "ARG Mainland Strike Flight #2",
            latitude = CTFS.COORDS.Chokepoint1.latitude,
            longitude = tostring(tonumber(CTFS.COORDS.Chokepoint1.longitude) - 2.1),
            altitude = 5000
        })
    end
    if points >= 95 then
        ScenEdit_AddUnit({
            type = "Facility",
            side = "Argentina",
            dbid = CTFS.DB_ARG.RBS70,
            name = "RBS 70 NG MANPADS (Stanley Port)",
            latitude = CTFS.COORDS.Stanley_Port.latitude,
            longitude = CTFS.COORDS.Stanley_Port.longitude
        })
    end
    if points >= 99 then
        ScenEdit_SetSideOptions({ side = "Argentina", proficiency = "Ace" })
    end
end

-- =============================================================================
-- THEATRE OPERATIONAL ORDER (OPORD) HTML GENERATOR
-- Formats authentic British Admiralty / PJHQ Fleet Operational Orders
-- Rendered natively in the CMO modal dialog and incoming message log
-- =============================================================================
function CTFS.GenerateLaunchDispatchHTML(hoursDelayed, daysDelayed, departureDTG, totalPoints, unitCount)
    local template = [==[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incoming message</title>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding: 18px;
            background-color: #060911;
            color: #cbd5e1;
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, Helvetica, Arial, sans-serif;
        }
    </style>
    <script>
        try {
            window.resizeTo(1100, 800);
        } catch(e) {}
    </script>
</head>
<body>
<div style="background-color: #0a101d; color: #cbd5e1; font-family: 'Segoe UI', Arial, sans-serif; padding: 22px; border: 1px solid #1a273f; border-top: 3px solid #00d2ff; border-radius: 6px; width: 100%; max-width: 960px; margin: 0 auto; box-sizing: border-box; box-shadow: 0 8px 32px rgba(0,0,0,0.85);">

    <!-- Header Dispatch Banner -->
    <table style="width: 100%; border-bottom: 1px solid #1a273f; padding-bottom: 12px; margin-bottom: 16px;">
        <tr>
            <td style="vertical-align: top;">
                <div style="color: #00d2ff; font-size: 11px; font-weight: 800; letter-spacing: 2px; text-transform: uppercase;">MINISTRY OF DEFENCE &bull; PERMANENT JOINT HEADQUARTERS (PJHQ) NORTHWOOD</div>
                <div style="color: #ffffff; font-size: 17px; font-weight: 800; letter-spacing: 1.5px; margin-top: 4px;">ROYAL NAVY FLEET OPERATIONAL ORDER // OP RECORPORATE</div>
            </td>
            <td style="vertical-align: top; text-align: right;">
                <span style="background-color: rgba(200, 16, 46, 0.2); border: 1px solid #c8102e; color: #ff6b81; font-family: monospace; font-size: 11px; font-weight: 800; padding: 5px 12px; border-radius: 4px; letter-spacing: 1.5px; display: inline-block;">
                    TOP SECRET // COMMANDER EYES ONLY
                </span>
            </td>
        </tr>
    </table>

    <!-- Telemetry Strip -->
    <table style="width: 100%; border-collapse: collapse; margin-bottom: 16px; background-color: #0e1626; border: 1px solid #1a273f; border-radius: 4px;">
        <tr>
            <td style="padding: 9px 12px; border-right: 1px solid #1a273f; font-size: 11px; color: #8fa3bf;">
                <strong style="color: #00d2ff;">ORIGINATOR:</strong> CINCFLEET / NORTHWOOD
            </td>
            <td style="padding: 9px 12px; border-right: 1px solid #1a273f; font-size: 11px; color: #8fa3bf;">
                <strong style="color: #00d2ff;">ACTION TO:</strong> CTF 317 (FLAGSHIP HMS QUEEN ELIZABETH)
            </td>
            <td style="padding: 9px 12px; border-right: 1px solid #1a273f; font-size: 11px; color: #8fa3bf;">
                <strong style="color: #00d2ff;">DEPARTURE DTG:</strong> <span style="color: #ffffff; font-weight: bold;">{departureDTG}</span>
            </td>
            <td style="padding: 9px 12px; font-size: 11px; color: #8fa3bf;">
                <strong style="color: #00d2ff;">STAGING DELAY:</strong> <span style="color: #ffffff; font-weight: bold;">{daysDelayed} DAYS ({hoursDelayed} HRS)</span>
            </td>
        </tr>
    </table>

    <!-- 1. Situation & Mobilisation Report -->
    <div style="background-color: #0e1626; border: 1px solid #1a273f; border-left: 3px solid #00d2ff; padding: 14px 16px; margin-bottom: 14px; border-radius: 0 4px 4px 0;">
        <div style="color: #00d2ff; font-size: 12px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 6px;">
            1. SITUATION &amp; MOBILISATION REPORT
        </div>
        <p style="font-size: 13px; line-height: 1.55; margin: 0 0 8px 0; color: #cbd5e1;">
            Following an operational staging and mobilisation period ({daysDelayed} Days elapsed), Task Force 317 is formally released from home waters and cleared to commence theatre transit for the South Atlantic Joint Operations Area (JOA).
        </p>
        <p style="font-size: 13px; line-height: 1.55; margin: 0; color: #94a3b8;">
            <strong style="color: #00d2ff;">INTELLIGENCE ASSESSMENT:</strong> The operational delay required to marshal surface combatants, carrier strike squadrons, and sealift tonnage in UK ports has afforded Argentine Joint Forces crucial strategic breathing room to entrench and reinforce.
        </p>
    </div>

    <!-- 2. Theatre Forward Presence -->
    <div style="background-color: #0e1626; border: 1px solid #1a273f; border-left: 3px solid #00d2ff; padding: 14px 16px; margin-bottom: 14px; border-radius: 0 4px 4px 0;">
        <div style="color: #00d2ff; font-size: 12px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 6px;">
            2. THEATRE FORWARD PRESENCE
        </div>
        <p style="font-size: 13px; line-height: 1.55; margin: 0; color: #cbd5e1;">
            The River-class Offshore Patrol Vessel <strong style="color: #ffffff;">HMS Medway</strong> is currently forward-deployed in the Falklands sector. Being lightly armed and isolated, <em>Medway</em> has adopted strict emissions control (<strong style="color: #ffffff;">EMCON Alpha</strong>) and a clandestine surveillance posture.
        </p>
    </div>

    <!-- 3. Force Organisation, Escort Doctrine & Speed Discipline -->
    <div style="background-color: #0e1626; border: 1px solid #1a273f; border-left: 3px solid #00d2ff; padding: 14px 16px; margin-bottom: 14px; border-radius: 0 4px 4px 0;">
        <div style="color: #00d2ff; font-size: 12px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px;">
            3. FORCE ORGANISATION, ESCORT DOCTRINE &amp; SPEED DISCIPLINE
        </div>
        <p style="font-size: 13px; line-height: 1.55; margin: 0 0 10px 0; color: #cbd5e1;">
            Commander Task Force 317 must immediately assemble all deployed surface and subsurface units into structured operational groups:
        </p>
        <ul style="margin: 0; padding-left: 20px; font-size: 13px; line-height: 1.6; color: #cbd5e1;">
            <li style="margin-bottom: 6px;">
                <strong style="color: #00d2ff;">Speed Discipline &amp; Grouping:</strong> Carrier Strike Group must make its way towards the Area of Operations (AOO) at best possible speed whilst considering the trade-off between transit speed and fuel consumption. Slower auxiliary tankers, dry cargo, support, and amphibious ships need to be formed into separate formation(s) to prevent slowing capital ship manoeuvring.
            </li>
            <li style="margin-bottom: 6px;">
                <strong style="color: #00d2ff;">Dedicated Escort Coverage:</strong> Unarmed civilian transports (STUFT cruise liners, Ro-Ros), amphibious landing ships, and logistics vessels must be protected through contested sea lanes. Form independent auxiliary convoys and assign dedicated surface escort and RAF presence along the convoy route.
            </li>
            <li style="margin-bottom: 6px;">
                <strong style="color: #00d2ff;">Astute-Class SSNs:</strong> Fleet nuclear attack submarines are not bound by escort duties or fuel conservation. They can steam south at sustained high speeds to establish an advance screening and subsurface sea denial ahead of the main fleet, and begin building tactical situational awareness around the Falklands.
            </li>
            <li>
                <strong style="color: #00d2ff;">Fuel Conservation &amp; Replenishment:</strong> Distance from the United Kingdom to Ascension Island and onward to the Falklands exceeds 7,000 nautical miles. Fuel conservation needs to be managed from the start for both ships and aircraft making the transit. Each fleet formation and each flight heading out should be supported by an adequate allocation of fleet tankers (RFA Tide/Wave class) and RAF Voyager refuelling assets.
            </li>
        </ul>
    </div>

    <!-- 4. Midway Point (Ascension Island) -->
    <div style="background-color: #0e1626; border: 1px solid #1a273f; border-left: 3px solid #00d2ff; padding: 14px 16px; margin-bottom: 16px; border-radius: 0 4px 4px 0;">
        <div style="color: #00d2ff; font-size: 12px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 6px;">
            4. MIDWAY POINT (ASCENSION ISLAND)
        </div>
        <p style="font-size: 13px; line-height: 1.55; margin: 0 0 8px 0; color: #cbd5e1;">
            Excluding forward Falklands presence (HMS <em>Medway</em> and advance sprinting SSNs), all fleets and transiting aircraft must stop at <strong style="color: #ffffff;">Ascension Island (Wideawake Airfield / Anchorage)</strong> to refuel, load stores and troops, and reorganise for the final push towards the Falklands Theatre. Ascension is the last stop before the Area of Operations and the final opportunity to make ready for action.
        </p>
        <p style="font-size: 13px; line-height: 1.55; margin: 0; color: #94a3b8;">
            <strong style="color: #00d2ff;">OPERATIONAL NOTICE:</strong> Expect new orders and refined intelligence updates when the fleet assembles at Ascension Island.
        </p>
    </div>

    <!-- Footer Sign-off -->
    <div style="border-top: 1px solid #1a273f; padding-top: 10px; font-size: 11px; color: #64748b; text-align: center; letter-spacing: 1.5px; text-transform: uppercase;">
        ADMIRALTY SIGNAL // PERMANENT JOINT HEADQUARTERS // GOD SAVE THE KING // OUT
    </div>
</div>
</body>
</html>]==]

    template = template:gsub("{hoursDelayed}", tostring(hoursDelayed))
    template = template:gsub("{daysDelayed}", tostring(daysDelayed))
    template = template:gsub("{departureDTG}", tostring(departureDTG))
    template = template:gsub("{totalPoints}", tostring(totalPoints))
    template = template:gsub("{unitCount}", tostring(unitCount))
    return template
end

-- =============================================================================
-- UNIFIED ORDER EXECUTION ENGINE
-- Handles validation, clock advancement, boons, KV storage, and force spawning
-- =============================================================================
function CTFS.ProcessOrder(selections)
    -- 1. Anti-Spoofing Server-Side Math Verification
    local verified, err = CTFS.VerifyAndCalculateOrder(selections)
    if not verified then
        ScenEdit_MsgBox("CTFS Validation Error: " .. (err or "Invalid order"), 1)
        return false
    end

    -- 2. Time Jump & Escalation Matrix Execution
    local hoursDelayed, dateStr, timeStr = CTFS.ExecuteTimeJump(verified.totalPoints)
    CTFS.ApplyArgentineBoons(verified.totalPoints)

    -- 3. Persistent Global Key-Value Storage (ScenEdit_SetKeyValue)
    ScenEdit_SetKeyValue("CTFS_COMPLETED", "true")
    ScenEdit_SetKeyValue("CTFS_POINTS_SPENT", tostring(verified.totalPoints))
    ScenEdit_SetKeyValue("CTFS_HOURS_DELAYED", tostring(hoursDelayed))
    ScenEdit_SetKeyValue("CTFS_DEPARTURE_DATE", dateStr .. " " .. timeStr)
    ScenEdit_SetKeyValue("CTFS_TOTAL_UNITS", tostring(#verified.units))

    -- 4. Separate & Order Spawning Pipeline:
    -- Surface Ships & Submarines FIRST (Flagship Queen Elizabeth #1, Standing Fleet, then Purchased Ships)
    -- Fixed-Wing Aircraft & Staged Aviation SECOND
    local shipOrder = {}
    local airOrder = {}

    for _, item in ipairs(verified.units) do
        if item.type ~= "Aircraft" then
            table.insert(shipOrder, item)
        else
            table.insert(airOrder, item)
        end
    end

    -- Ensure HMS Queen Elizabeth spawns first so carrier airwing and group lead are anchored
    table.sort(shipOrder, function(a, b)
        if a.name == "HMS Queen Elizabeth" then return true end
        if b.name == "HMS Queen Elizabeth" then return false end
        if a.isDefault and not b.isDefault then return true end
        if not a.isDefault and b.isDefault then return false end
        return false
    end)

    -- 5. Force Spawning Pipeline: Ships & Submarines
    local spawnedUnits = {}
    local allAirToSpawn = {}

    for _, item in ipairs(shipOrder) do
        for i = 1, item.qty do
            local unitName = item.name
            if item.qty > 1 then unitName = unitName .. " #" .. i end

            -- Standing Task Force baseline ships (except Falklands forward presence) spawn at FLEET_SPAWN1.
            -- HMS Medway spawns at FLEET_FALKLANDS.
            -- Purchased ships spawn at their designated authentic naval base RP (with graceful fallback).
            local targetRP = (item.isDefault and item.name ~= "HMS Medway") and "FLEET_SPAWN1" or item.spawnRP
            local lat, lon = ResolveSpawnCoords(targetRP, "FLEET_SPAWN1")

            local newUnit = ScenEdit_AddUnit({
                type = item.type,
                side = "UK",
                dbid = item.dbid,
                name = unitName,
                latitude = lat,
                longitude = lon
            })

            if newUnit then
                spawnedUnits[unitName] = newUnit.guid
                spawnedUnits[item.name] = newUnit.guid

                -- 5a. Form Baseline Fleet into "Standing Task Force" Group (excluding forward Falklands assets)
                if item.isDefault and item.type == "Ship" and item.name ~= "HMS Medway" then
                    pcall(function()
                        ScenEdit_SetUnit({ guid = newUnit.guid, group = "Standing Task Force" })
                    end)
                end

                -- 5b. Stage Authentic Embarked Aviation for Unified Spawning Pipeline
                local embarkedList = CTFS.SHIP_AIRCRAFT[item.name]
                if embarkedList and type(embarkedList) == "table" then
                    for _, acDef in ipairs(embarkedList) do
                        table.insert(allAirToSpawn, {
                            hostName = item.name,
                            targetGuid = newUnit.guid,
                            spawnRP = item.name,
                            dbid = acDef.dbid,
                            shortName = acDef.shortName or acDef.name,
                            squadron = acDef.squadron,
                            loadoutid = acDef.loadoutid or 0,
                            qty = acDef.qty or 1
                        })
                    end
                end

                -- 5c. Configure Silos & Magazines (Enforce peacetime loadouts unless upgraded)
                if item.name == "HMS Queen Elizabeth" then
                    local qeSteps = verified.upgrades["HMS Queen Elizabeth"] or 0
                    CTFS.ConfigureCarrierMagazines(newUnit, qeSteps)
                elseif item.type == "Ship" and MODEL_MAP[item.name] and MODEL_MAP[item.name].upgradeCost then
                    local hasVls = (verified.upgrades[item.name] == true)
                    CTFS.ConfigureShipVLS(newUnit, hasVls)
                end
            end
        end
    end

    -- 6. Collect Staged Theater / Carrier Fixed-Wing Aviation & Naval Air Wing Additions
    for _, item in ipairs(airOrder) do
        local hostName = CTFS.AIRBASE_DISPLAY_NAMES[item.spawnRP] or item.spawnRP
        table.insert(allAirToSpawn, {
            hostName = hostName,
            spawnRP = item.spawnRP,
            dbid = item.dbid,
            shortName = item.shortName or item.name,
            squadron = item.squadron,
            loadoutid = item.loadoutid or 0,
            qty = item.qty
        })
    end

    -- Pre-calculate group totals across all staged aviation (Host + Aircraft Type + Squadron)
    -- This guarantees continuous and consistent #1..#N numbering across baseline and purchased additions
    local groupTotals = {}
    for _, entry in ipairs(allAirToSpawn) do
        local key = entry.hostName .. "::" .. entry.shortName .. "::" .. (entry.squadron or "")
        groupTotals[key] = (groupTotals[key] or 0) + entry.qty
    end

    local groupCounters = {}
    for _, entry in ipairs(allAirToSpawn) do
        local key = entry.hostName .. "::" .. entry.shortName .. "::" .. (entry.squadron or "")
        local totalNum = groupTotals[key]

        for aIdx = 1, entry.qty do
            local curNum = (groupCounters[key] or 0) + 1
            groupCounters[key] = curNum

            local unitName = FormatAircraftName(entry.hostName, entry.shortName, entry.squadron, curNum, totalNum)

            -- Match Base GUID (carrier, amphibious host, or mainland airbase)
            local baseGuid = entry.targetGuid or spawnedUnits[entry.spawnRP]
            if not baseGuid and entry.spawnRP then
                local existing = ScenEdit_GetUnit({ side = "UK", name = entry.spawnRP })
                if existing then
                    baseGuid = existing.guid
                elseif string.match(entry.spawnRP, "^W8V2DT-") then
                    baseGuid = entry.spawnRP
                end
            end

            local newUnit = nil
            if baseGuid then
                newUnit = ScenEdit_AddUnit({
                    type = "Aircraft",
                    side = "UK",
                    dbid = entry.dbid,
                    name = unitName,
                    base = baseGuid,
                    loadoutid = entry.loadoutid or 0,
                    TimeToReady_Minutes = 0
                })
            else
                -- Fallback coordinates if airbase/carrier not resolved
                local lat, lon = ResolveSpawnCoords(entry.spawnRP, "FLEET_SPAWN1")
                newUnit = ScenEdit_AddUnit({
                    type = "Aircraft",
                    side = "UK",
                    dbid = entry.dbid,
                    name = unitName,
                    latitude = lat,
                    longitude = lon,
                    loadoutid = entry.loadoutid or 0,
                    TimeToReady_Minutes = 0
                })
            end

            if newUnit then
                spawnedUnits[unitName] = newUnit.guid
            end
        end
    end

    local daysDelayed = string.format("%.1f", hoursDelayed / 24)
    local departureDTG = (dateStr or "2027-12-26") .. " " .. (timeStr or "08:00:00") .. "Z"
    local dispatchHTML = CTFS.GenerateLaunchDispatchHTML(hoursDelayed, daysDelayed, departureDTG, verified.totalPoints, #verified.units)

    -- Detect dynamic player side
    local playerSide = nil
    pcall(function()
        playerSide = ScenEdit_PlayerSide()
    end)
    if not playerSide or playerSide == "" then
        playerSide = "UK"
    end

    -- 1. Deliver guaranteed modal popup dialog into player view
    local modalShown = false
    pcall(function()
        if UI_CallAdvancedHTMLDialog then
            UI_CallAdvancedHTMLDialog("ROYAL NAVY FLEET OPERATIONAL ORDER", dispatchHTML, { "Acknowledge Orders" })
            modalShown = true
        end
    end)

    -- 2. Deliver operational dispatch via ScenEdit_SpecialMessage (preserves OPORD in Message Log & plays radio chime)
    local msgDelivered = false
    pcall(function()
        ScenEdit_SpecialMessage(playerSide, dispatchHTML)
        msgDelivered = true
    end)
    if not msgDelivered then
        pcall(function()
            ScenEdit_SpecialMessage("UK", dispatchHTML)
            msgDelivered = true
        end)
    end
    if not msgDelivered then
        pcall(function()
            ScenEdit_SpecialMessage("playerside", dispatchHTML)
            msgDelivered = true
        end)
    end

    -- Emergency Fallback: Plain text modal if HTML message delivery failed
    if not msgDelivered then
        pcall(function()
            ScenEdit_MsgBox(
                "ROYAL NAVY FLEET OPERATIONAL ORDER // OP RECORPORATE\n\n" ..
                "Task Force 317 Staging & Mobilisation Complete.\n" ..
                "Departure Delayed: " .. daysDelayed .. " Days (" .. hoursDelayed .. " Hours)\n" ..
                "Total Deployed Units: " .. #verified.units .. "\n\n" ..
                "Primary Directives:\n" ..
                "1. MIDWAY POINT: All fleets & flights (excl. forward Falklands assets) stage to Ascension Island to refuel, load stores & troops, and reorganise.\n" ..
                "2. SPEED DISCIPLINE: Keep slow auxiliaries in separate convoys with dedicated escorts to maintain capital ship mobility.\n" ..
                "3. FORWARD RECON & SEA DENIAL: Astute SSNs sprint south to establish screening cordon and subsurface sea denial ahead of main fleet.\n" ..
                "4. FORWARD PRESENCE: HMS Medway maintains EMCON Alpha and low-profile surveillance from safe standoff.",
                1)
        end)
    end
    return true
end

-- =============================================================================

-- =============================================================================
-- EMBEDDED UI HTML TEMPLATE (Zero-Dependency CMO Fallback)
-- =============================================================================
CTFS.HTML_TEMPLATE = [==[
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CTFS: Carrier Task Force Selector - Falklands 2027</title>
    <style>
        :root {
            --bg-base: #070a12;
            --bg-panel: #0d1322;
            --bg-card: #121a2d;
            --bg-card-hover: #18233c;
            --bg-selected: rgba(0, 180, 255, 0.12);
            --border-subtle: #1c273e;
            --border-bright: #293a5c;
            --border-active: #00d2ff;
            --text-primary: #f0f4f8;
            --text-muted: #8899b0;
            --text-dim: #54657e;
            --cyan: #00d2ff;
            --cyan-glow: rgba(0, 210, 255, 0.35);
            --amber: #ffb703;
            --amber-glow: rgba(255, 183, 3, 0.35);
            --red: #ff3344;
            --red-glow: rgba(255, 51, 68, 0.45);
            --green: #00e676;
            --green-glow: rgba(0, 230, 118, 0.25);
            --rn-blue: #00247d;
            --rn-red: #c8102e;
            --rn-gold: #d4af37;
            --rn-gold-glow: rgba(212, 175, 55, 0.35);
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--bg-base);
            color: var(--text-primary);
            padding: 24px;
            user-select: none;
            overflow-x: hidden;
        }

        /* Top Operational Telemetry Dashboard */
        .hud-dashboard {
            background: linear-gradient(180deg, rgba(16, 24, 40, 0.96) 0%, rgba(10, 15, 26, 0.96) 100%);
            border: 1px solid var(--border-bright);
            border-radius: 10px;
            padding: 22px 24px 20px;
            margin-bottom: 20px;
            box-shadow: 0 10px 35px rgba(0, 0, 0, 0.7), inset 0 1px 0 rgba(255, 255, 255, 0.08);
            position: relative;
            overflow: hidden;
        }

        /* British Naval Tri-Color Trim Accent */
        .hud-dashboard::before {
            content: "";
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #00247d 0%, #00247d 35%, #ffffff 35%, #ffffff 65%, #c8102e 65%, #c8102e 100%);
        }

        /* Ministry of Defence / Fleet Command Header */
        .mod-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
            padding-bottom: 14px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.07);
        }

        .mod-brand {
            display: flex;
            align-items: center;
            gap: 14px;
        }

        .rn-crest-svg {
            filter: drop-shadow(0 0 8px rgba(212, 175, 55, 0.35));
            flex-shrink: 0;
        }

        .mod-titles {
            display: flex;
            flex-direction: column;
            gap: 2px;
        }

        .mod-super {
            font-size: 0.7em;
            letter-spacing: 2px;
            color: var(--rn-gold);
            font-weight: 700;
            text-transform: uppercase;
        }

        .mod-main {
            font-size: 1.05em;
            font-weight: 800;
            letter-spacing: 1.5px;
            color: #ffffff;
            text-transform: uppercase;
            text-shadow: 0 0 10px rgba(0, 210, 255, 0.2);
        }

        .mod-flag-wrap {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .union-flag-svg {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
            border-radius: 4px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 16px;
            text-align: center;
            margin-bottom: 18px;
        }

        .stat-item {
            background: rgba(8, 12, 22, 0.7);
            border: 1px solid var(--border-subtle);
            border-radius: 6px;
            padding: 12px 10px;
            transition: all 0.3s ease;
        }

        .stat-label {
            font-size: 0.75em;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .stat-value {
            font-size: 1.6em;
            font-weight: 700;
            color: var(--cyan);
            text-shadow: 0 0 12px var(--cyan-glow);
            transition: color 0.3s, text-shadow 0.3s;
        }

        /* Timeline Track */
        .timeline-container {
            margin-bottom: 16px;
        }

        .timeline-header {
            display: flex;
            justify-content: space-between;
            font-size: 0.8em;
            color: var(--text-muted);
            margin-bottom: 6px;
            font-weight: 600;
            letter-spacing: 0.5px;
        }

        .timeline-label-left {
            color: var(--text-muted);
            font-size: 0.78em;
            font-weight: 600;
            letter-spacing: 1px;
        }

        .timeline-label-right {
            font-size: 0.78em;
            font-weight: 700;
            letter-spacing: 1px;
            color: var(--text-dim);
            transition: color 0.3s ease, text-shadow 0.3s ease;
        }

        .timeline-track {
            width: 100%;
            height: 12px;
            background: #0f1524;
            border-radius: 6px;
            overflow: hidden;
            border: 1px solid var(--border-bright);
            position: relative;
        }

        .timeline-fill {
            height: 100%;
            width: 0%;
            background: linear-gradient(90deg, var(--cyan) 0%, var(--amber) 70%, var(--red) 100%);
            border-radius: 6px;
            transition: width 0.3s ease, background-color 0.3s ease;
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.4);
        }

        /* Argentine Escalation Threat Feed */
        .threat-feed-title {
            font-size: 0.75em;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            color: var(--text-muted);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .threat-feed-title::after {
            content: "";
            flex: 1;
            height: 1px;
            background: var(--border-subtle);
        }

        .threat-pills {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
        }

        .threat-pill {
            font-size: 0.72em;
            font-weight: 600;
            letter-spacing: 0.5px;
            padding: 4px 10px;
            border-radius: 4px;
            border: 1px solid var(--border-subtle);
            background: rgba(12, 17, 28, 0.75);
            color: var(--text-dim);
            transition: all 0.3s;
        }

        .threat-pill.redacted {
            opacity: 0.7;
            font-style: italic;
            letter-spacing: 0.6px;
            border-style: dashed;
        }

        .threat-pill.triggered {
            border-color: var(--amber);
            border-style: solid;
            background: rgba(255, 183, 3, 0.15);
            color: #ffe082;
            box-shadow: 0 0 8px rgba(255, 183, 3, 0.25);
            font-style: normal;
            opacity: 1;
        }

        .threat-pill.critical {
            border-color: var(--red);
            border-style: solid;
            background: rgba(255, 51, 68, 0.22);
            color: #ff8a93;
            box-shadow: 0 0 12px rgba(255, 51, 68, 0.4);
            font-style: normal;
            opacity: 1;
        }

        /* Navigation Tabs */
        .tabs-nav {
            display: flex;
            border-bottom: 2px solid var(--border-subtle);
            margin-bottom: 20px;
            overflow-x: auto;
            gap: 6px;
        }

        .tab-btn {
            background: none;
            border: none;
            color: var(--text-muted);
            padding: 12px 18px;
            font-size: 0.9em;
            font-weight: 600;
            letter-spacing: 0.6px;
            cursor: pointer;
            border-bottom: 3px solid transparent;
            transition: all 0.2s ease;
            white-space: nowrap;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .tab-btn:hover {
            color: var(--text-primary);
            background: rgba(255, 255, 255, 0.04);
        }

        .tab-btn.active {
            color: var(--cyan);
            border-bottom-color: var(--cyan);
            text-shadow: 0 0 8px var(--cyan-glow);
            background: rgba(0, 210, 255, 0.05);
            border-radius: 4px 4px 0 0;
        }

        .tab-badge-svg {
            flex-shrink: 0;
            vertical-align: middle;
        }

        .tab-pane {
            display: none;
        }

        .tab-pane.active {
            display: block;
        }

        /* Unit Purchase Grid */
        .purchase-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(360px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        /* Sub-Category Class Dividers */
        .class-divider {
            grid-column: 1 / -1;
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 18px 0 6px;
            padding-top: 14px;
            border-top: 1px solid rgba(255, 255, 255, 0.08);
        }

        .class-divider:first-child {
            margin-top: 4px;
            padding-top: 0;
            border-top: none;
        }

        .class-divider-label {
            font-size: 0.76em;
            font-weight: 800;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--cyan);
            white-space: nowrap;
            display: flex;
            align-items: center;
            gap: 8px;
            text-shadow: 0 0 10px rgba(0, 210, 255, 0.35);
        }

        .tab-pane#tab-default .class-divider-label {
            color: var(--rn-gold);
            text-shadow: 0 0 10px rgba(212, 175, 55, 0.35);
        }

        .divider-diamond {
            font-size: 0.75em;
            opacity: 0.9;
        }

        .class-divider-line {
            flex: 1;
            height: 1px;
            background: linear-gradient(90deg, rgba(0, 210, 255, 0.35) 0%, rgba(0, 210, 255, 0.08) 70%, transparent 100%);
        }

        .tab-pane#tab-default .class-divider-line {
            background: linear-gradient(90deg, rgba(212, 175, 55, 0.45) 0%, rgba(212, 175, 55, 0.08) 70%, transparent 100%);
        }

        .unit-card {
            background: var(--bg-card);
            border: 1px solid var(--border-subtle);
            border-radius: 8px;
            padding: 16px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: border-color 0.2s, background-color 0.2s, box-shadow 0.2s;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .unit-card:hover {
            border-color: var(--border-bright);
            background: var(--bg-card-hover);
        }

        .unit-card.selected {
            border-color: var(--cyan);
            background: var(--bg-selected);
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.15);
        }

        .unit-card.default-asset {
            border-color: rgba(212, 175, 55, 0.35);
            background: rgba(212, 175, 55, 0.04);
        }

        .unit-card.default-asset:hover {
            border-color: rgba(212, 175, 55, 0.55);
            background: rgba(212, 175, 55, 0.07);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 10px;
            gap: 12px;
        }

        .card-visual {
            display: flex;
            align-items: center;
            gap: 12px;
            flex: 1;
            min-width: 0;
        }

        .unit-icon-box {
            width: 44px;
            height: 44px;
            background: rgba(8, 14, 26, 0.85);
            border: 1px solid var(--border-subtle);
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            color: #8da2be;
            transition: all 0.25s ease;
        }

        .unit-icon-box svg {
            width: 32px;
            height: 24px;
            display: block;
            transition: transform 0.25s ease, filter 0.25s ease;
        }

        .unit-card:hover .unit-icon-box {
            border-color: var(--border-bright);
            background: rgba(12, 20, 36, 0.95);
            color: #d8e4f2;
        }

        .unit-card:hover .unit-icon-box svg {
            transform: scale(1.06);
        }

        .unit-card.selected .unit-icon-box {
            border-color: var(--cyan);
            background: rgba(0, 210, 255, 0.12);
            color: var(--cyan);
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.25);
        }

        .unit-card.selected .unit-icon-box svg {
            filter: drop-shadow(0 0 4px var(--cyan-glow));
        }

        .unit-card.default-asset .unit-icon-box {
            border-color: rgba(212, 175, 55, 0.4);
            background: rgba(212, 175, 55, 0.1);
            color: #e5c158;
            box-shadow: 0 0 8px rgba(212, 175, 55, 0.2);
        }

        .unit-card.default-asset .unit-icon-box svg {
            filter: drop-shadow(0 0 4px rgba(212, 175, 55, 0.3));
        }

        .card-info {
            flex: 1;
            min-width: 0;
        }

        .unit-name {
            font-size: 1.05em;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.3px;
        }

        .unit-qty-tag {
            display: inline-block;
            font-size: 0.76em;
            font-weight: 700;
            padding: 1px 6px;
            border-radius: 4px;
            background: rgba(0, 210, 255, 0.18);
            color: var(--cyan);
            border: 1px solid rgba(0, 210, 255, 0.35);
            margin-left: 6px;
            vertical-align: middle;
            letter-spacing: 0.5px;
        }

        .unit-card.default-asset .unit-qty-tag {
            background: rgba(212, 175, 55, 0.15);
            color: #f3d474;
            border-color: rgba(212, 175, 55, 0.35);
        }

        .unit-role {
            font-size: 0.82em;
            color: var(--text-muted);
            margin-top: 3px;
            line-height: 1.35;
        }

        .unit-controls {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-shrink: 0;
        }

        .cost-badge {
            font-size: 0.78em;
            font-weight: 700;
            padding: 4px 8px;
            border-radius: 4px;
            border: 1px solid var(--border-subtle);
            background: rgba(0, 0, 0, 0.4);
            color: var(--text-muted);
            white-space: nowrap;
        }

        .unit-card.selected .cost-badge {
            border-color: var(--cyan);
            background: rgba(0, 210, 255, 0.2);
            color: #ffffff;
        }

        .unit-card.default-asset .cost-badge {
            border-color: rgba(212, 175, 55, 0.4);
            background: rgba(212, 175, 55, 0.12);
            color: #e5c158;
        }

        /* Checkbox & Spinner Controls */
        input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: var(--cyan);
        }

        input[type="number"] {
            width: 58px;
            background: #0d121c;
            color: #ffffff;
            border: 1px solid var(--border-bright);
            border-radius: 4px;
            padding: 6px 4px;
            text-align: center;
            font-weight: 700;
            font-size: 0.95em;
        }

        input[type="number"]:focus {
            outline: none;
            border-color: var(--cyan);
            box-shadow: 0 0 6px var(--cyan-glow);
        }

        /* Magazine / Munitions Fill Box */
        .upgrades-panel {
            margin-top: 14px;
            padding-top: 10px;
            border-top: 1px dashed var(--border-subtle);
        }

        .upgrades-header {
            font-size: 0.75em;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: var(--text-muted);
            margin-bottom: 6px;
        }

        .upgrades-row {
            display: flex;
            gap: 8px;
        }

        .upgrade-chip {
            display: flex;
            align-items: center;
            gap: 6px;
            background: rgba(10, 14, 22, 0.7);
            border: 1px solid var(--border-subtle);
            border-radius: 4px;
            padding: 5px 8px;
            font-size: 0.78em;
            font-weight: 600;
            color: var(--text-muted);
            cursor: pointer;
            transition: all 0.2s;
        }

        .upgrade-chip:hover {
            border-color: var(--border-bright);
            color: var(--text-primary);
        }

        .upgrade-chip input[type="checkbox"]:checked+span {
            color: var(--cyan);
            font-weight: 700;
        }

        /* Launch Execution Button */
        .launch-container {
            margin-top: 10px;
        }

        .launch-btn {
            width: 100%;
            background: linear-gradient(180deg, #c8102e 0%, #900a1d 100%);
            color: #ffffff;
            border: 1px solid #ff4d60;
            border-radius: 8px;
            padding: 16px 24px;
            cursor: pointer;
            box-shadow: 0 4px 20px rgba(200, 16, 46, 0.4), inset 0 1px 0 rgba(255, 255, 255, 0.2);
            transition: all 0.25s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 4px;
        }

        .launch-btn:hover {
            background: linear-gradient(180deg, #db1b3a 0%, #a80e23 100%);
            box-shadow: 0 6px 25px rgba(200, 16, 46, 0.6), inset 0 1px 0 rgba(255, 255, 255, 0.3);
            transform: translateY(-1px);
        }

        .launch-btn:active {
            transform: translateY(1px);
            box-shadow: 0 2px 10px rgba(200, 16, 46, 0.4);
        }

        .launch-btn .btn-main-title {
            font-size: 1.25em;
            font-weight: 800;
            letter-spacing: 2.5px;
            text-transform: uppercase;
        }

        .launch-btn .btn-sub-title {
            font-size: 0.76em;
            font-weight: 500;
            letter-spacing: 0.8px;
            opacity: 0.88;
            text-transform: none;
        }

        .launch-btn.launched {
            background: linear-gradient(180deg, #0d7a46 0%, #064e2b 100%) !important;
            border-color: #00e676 !important;
            box-shadow: 0 4px 20px rgba(0, 230, 118, 0.4) !important;
            cursor: default;
        }
    </style>
</head>

<body>

    <!-- BRIDGE 1 SYNCHRONIZATION: Form values serialized upon dialog closure -->
    <!-- Slot for Lua string.format injection (AI-html-lua-reference line 69-79) -->
    <input type="hidden" id="model_data" value="%s">
    <input type="hidden" id="ctfs_payload" name="ctfs_payload" value="">
    <input type="hidden" id="ctfs_points" name="ctfs_points" value="0">
    <input type="hidden" id="ctfs_hours" name="ctfs_hours" value="0">

    <!-- Top Telemetry HUD -->
    <div class="hud-dashboard">
        <!-- Ministry of Defence / Fleet Command Header -->
        <div class="mod-header">
            <div class="mod-brand">
                <!-- Royal Navy Naval Crown & Fouled Anchor SVG Crest -->
                <svg class="rn-crest-svg" viewBox="0 0 44 44" width="38" height="38">
                    <circle cx="22" cy="22" r="20" fill="#091122" stroke="#d4af37" stroke-width="1.6" />
                    <circle cx="22" cy="22" r="17" fill="none" stroke="rgba(212, 175, 55, 0.4)" stroke-dasharray="2 2"
                        stroke-width="0.8" />
                    <!-- Naval Crown -->
                    <path d="M14 13 L17 9 L22 12 L27 9 L30 13 Z" fill="#d4af37" />
                    <!-- Fouled Anchor -->
                    <circle cx="22" cy="14" r="2.2" stroke="#d4af37" stroke-width="1.6" fill="none" />
                    <path d="M22 14 L22 33 M17 18 L27 18 M15 29 C18 35 26 35 29 29" stroke="#d4af37" stroke-width="2"
                        stroke-linecap="round" fill="none" />
                    <path d="M19 19 Q25 21 21 27" stroke="rgba(212, 175, 55, 0.7)" stroke-width="1" fill="none" />
                </svg>
                <div class="mod-titles">
                    <div class="mod-super">MINISTRY OF DEFENCE &bull; FLEET COMMAND // NORTHWOOD</div>
                    <div class="mod-main">ROYAL NAVY CARRIER STRIKE GROUP (CSG) // TASK FORCE SELECTOR</div>
                </div>
            </div>
            <!-- Official Union Flag Ensign Badge -->
            <div class="mod-flag-wrap">
                <svg class="union-flag-svg" viewBox="0 0 60 36" width="52" height="31">
                    <clipPath id="uf-round">
                        <rect width="60" height="36" rx="4" />
                    </clipPath>
                    <g clip-path="url(#uf-round)">
                        <rect width="60" height="36" fill="#00247d" />
                        <path d="M0 0 L60 36 M60 0 L0 36" stroke="#ffffff" stroke-width="6" />
                        <path d="M0 0 L60 36 M60 0 L0 36" stroke="#c8102e" stroke-width="3" />
                        <path d="M30 0 L30 36 M0 18 L60 18" stroke="#ffffff" stroke-width="10" />
                        <path d="M30 0 L30 36 M0 18 L60 18" stroke="#c8102e" stroke-width="6" />
                    </g>
                    <rect width="60" height="36" rx="4" fill="none" stroke="rgba(212, 175, 55, 0.6)"
                        stroke-width="1.2" />
                </svg>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-item" id="stat-points-budget">
                <div class="stat-label">Points Budget</div>
                <div class="stat-value" id="ui-points">0 / 100</div>
            </div>
            <div class="stat-item">
                <div class="stat-label">Operation Start Delay</div>
                <div class="stat-value" id="ui-days">0.0 Days</div>
            </div>
            <div class="stat-item">
                <div class="stat-label">TF Ready to Sail (Z)</div>
                <div class="stat-value" id="ui-date">26 Dec 2027 08:00</div>
            </div>
        </div>

        <div class="timeline-container">
            <div class="timeline-header">
                <span class="timeline-label-left">IMMEDIATE LAUNCH</span>
                <span id="label-enemy-entrenches" class="timeline-label-right">ENEMY ENTRENCHES</span>
            </div>
            <div class="timeline-track">
                <div id="timeline-fill" class="timeline-fill"></div>
            </div>
        </div>

        <!-- Argentine Tactical Response Matrix Display -->
        <div class="threat-feed-title" id="threat-feed-title">Argentine Defensive Posture & Intelligence Feed</div>
        <div class="threat-pills">
            <div class="threat-pill" id="pill-10" data-pts="10" data-debug="10 pts: SPYDER-SR (Stanley)"
                data-intel="[INTEL GAP: Air Defense Alert - Stanley]">10 pts: SPYDER-SR (Stanley)</div>
            <div class="threat-pill" id="pill-20" data-pts="20" data-debug="20 pts: 2x F-16AM CAP (Pleasant)"
                data-intel="[CLASSIFIED: Combat Air Patrol Escalation]">20 pts: 2x F-16AM CAP (Pleasant)</div>
            <div class="threat-pill" id="pill-30" data-pts="30" data-debug="30 pts: Coastal Exocet SSM"
                data-intel="[INTEL GAP: Anti-Ship Coastal Alert]">30 pts: Coastal Exocet SSM</div>
            <div class="threat-pill" id="pill-40" data-pts="40" data-debug="40 pts: San Carlos Minefield (15x)"
                data-intel="[CLASSIFIED: Littoral Denial Activity]">40 pts: San Carlos Minefield (15x)</div>
            <div class="threat-pill" id="pill-50" data-pts="50" data-debug="50 pts: ARG Side -> Veteran"
                data-intel="[THEATER READINESS: Ground Forces Elevate to Veteran]">50 pts: ARG Side -> Veteran</div>
            <div class="threat-pill" id="pill-60" data-pts="60" data-debug="60 pts: SPYDER-MR (Tumbledown)"
                data-intel="[CLASSIFIED: Long-Range Radar & SAM Deployment]">60 pts: SPYDER-MR (Tumbledown)</div>
            <div class="threat-pill" id="pill-70" data-pts="70" data-debug="70 pts: ARA Salta Submarine"
                data-intel="[INTEL GAP: Subsurface Acoustic Anomaly]">70 pts: ARA Salta Submarine</div>
            <div class="threat-pill" id="pill-75" data-pts="75" data-debug="75 pts: ARA San Luis Submarine"
                data-intel="[CLASSIFIED: Subsurface Attack Vector Confirmed]">75 pts: ARA San Luis Submarine</div>
            <div class="threat-pill" id="pill-80" data-pts="80" data-debug="80 pts: 2x Mainland Strike F-16"
                data-intel="[INTEL GAP: Strike Aircraft Forward Redeployed]">80 pts: 2x Mainland Strike F-16</div>
            <div class="threat-pill" id="pill-95" data-pts="95" data-debug="95 pts: RBS 70 NG MANPADS"
                data-intel="[CLASSIFIED: Port Point Defense Hardened]">95 pts: RBS 70 NG MANPADS</div>
            <div class="threat-pill" id="pill-99" data-pts="99" data-debug="99 pts: ARG Side -> Ace"
                data-intel="[THEATER READINESS: Maximum War Footing (Ace)]">99 pts: ARG Side -> Ace</div>
        </div>
    </div>

    <!-- Category Tabs Navigation -->
    <div class="tabs-nav" id="tabs-header"></div>

    <!-- Category Tab Panels -->
    <div id="tabs-container"></div>

    <!-- Launch Execution Button -->
    <div class="launch-container">
        <button type="button" class="launch-btn" onclick="executeLaunch()">
            <span class="btn-main-title">LAUNCH OPERATION RECORPORATE</span>
            <span class="btn-sub-title" id="btn-sub-title" style="display: none;">You can safely close this window</span>
        </button>
    </div>

    <!-- Operational Orders Display (Full Widescreen View on Launch) -->
    <div id="orders-display" style="display: none; padding: 10px 0 30px 0; max-width: 960px; margin: 0 auto;"></div>

    <script>
        const MAX_POINTS = 100;
        const HOURS_PER_POINT = 5;
        const BASE_DATE = new Date("2027-12-26T08:00:00Z");

        // Stylized British Armed Forces Badges (Vector SVGs)
        const TAB_ICONS = {
            default: `<svg class="tab-badge-svg" viewBox="0 0 20 20" width="16" height="16" fill="none"><circle cx="10" cy="10" r="9" stroke="#d4af37" stroke-width="1.2" fill="rgba(0,36,125,0.35)"/><path d="M10 4v11M7 7h6M6 13c2 2.5 6 2.5 8 0" stroke="#d4af37" stroke-width="1.4" stroke-linecap="round"/><circle cx="10" cy="5" r="1.2" fill="#d4af37"/></svg>`,
            escorts: `<svg class="tab-badge-svg" viewBox="0 0 20 20" width="16" height="16" fill="none"><path d="M10 2l-6 3v5c0 4.4 2.6 8.5 6 9.8 3.4-1.3 6-5.4 6-9.8V5l-6-3z" stroke="currentColor" stroke-width="1.3" fill="rgba(0,210,255,0.12)"/><path d="M10 6v8M7 9h6" stroke="currentColor" stroke-width="1.3" stroke-linecap="round"/></svg>`,
            support: `<svg class="tab-badge-svg" viewBox="0 0 20 20" width="16" height="16" fill="none"><circle cx="10" cy="10" r="9" stroke="#00d2ff" stroke-width="1.2" fill="rgba(0,36,125,0.3)"/><path d="M10 4v11M7 7h6M6 13c2 2.5 6 2.5 8 0" stroke="#00d2ff" stroke-width="1.4" stroke-linecap="round"/><path d="M8 4l2-2 2 2" stroke="#00d2ff" stroke-width="1.2" stroke-linecap="round" stroke-linejoin="round"/></svg>`,
            airwing: `<svg class="tab-badge-svg" viewBox="0 0 20 20" width="16" height="16" fill="currentColor"><path d="M10 2c-.4 0-.8.3-.8.8v4.7l-6 3.5v1.5l6-2v4.5l-1.5 1.2v1l2.3-.7 2.3.7v-1l-1.5-1.2v-4.5l6 2v-1.5l-6-3.5V2.8c0-.5-.4-.8-.8-.8z"/></svg>`,
            raf: `<svg class="tab-badge-svg" viewBox="0 0 20 20" width="16" height="16"><circle cx="10" cy="10" r="9.5" fill="#00247d"/><circle cx="10" cy="10" r="6" fill="#ffffff"/><circle cx="10" cy="10" r="3" fill="#c8102e"/></svg>`
        };

        // Comprehensive Military Unit Silhouette SVGs
        const UNIT_SVGS = {
            carrier: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M2 17 L7 19 L32 19 L35 15 L32 11 L5 11 Z" fill="currentColor" fill-opacity="0.18"/><path d="M4 11 L31 11 M6 11 L2 17"/><path d="M2 17 L5 11 L8 9 L13 9"/><path d="M17 11 L17 7 L20 7 L20 11 M24 11 L24 6 L27 6 L27 11"/><line x1="18.5" y1="7" x2="18.5" y2="5"/><line x1="25.5" y1="6" x2="25.5" y2="4"/></svg>`,

            destroyer: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M2 16 L6 18 L31 18 L34 14 L28 13 L6 13 Z" fill="currentColor" fill-opacity="0.18"/><path d="M14 13 L17 6 L20 13 Z" fill="currentColor" fill-opacity="0.3"/><path d="M7 13 L9 13 L8 11 M8 11 L5 10"/><path d="M23 13 L23 9 L26 9 L26 13"/><line x1="24.5" y1="9" x2="24.5" y2="7"/></svg>`,

            frigate: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M3 16 L7 18 L31 18 L34 15 L28 13 L7 13 Z" fill="currentColor" fill-opacity="0.18"/><path d="M11 13 L13 8 L16 8 L17 13"/><line x1="14.5" y1="8" x2="14.5" y2="6"/><line x1="8" y1="13" x2="5" y2="11"/><path d="M20 13 L20 10 L23 10 L23 13 M24 13 L28 13 L28 15"/></svg>`,

            submarine: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M4 14 C4 11 8 10 16 10 L30 10 C33 10 34 12 34 13 C34 14 33 16 30 16 L16 16 C8 16 4 15 4 14 Z" fill="currentColor" fill-opacity="0.18"/><path d="M12 10 L14 5 L18 5 L19 10" fill="currentColor" fill-opacity="0.3"/><line x1="15" y1="7" x2="17" y2="7"/><path d="M30 10 L33 7 M30 16 L33 19 M34 13 L35 13"/></svg>`,

            amphibious: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M2 14 L5 18 L32 18 L34 15 L31 12 L17 12 L16 8 L9 8 L7 13 L3 13 Z" fill="currentColor" fill-opacity="0.18"/><line x1="16" y1="12" x2="31" y2="12"/><line x1="12" y1="8" x2="12" y2="5"/><path d="M20 12 L20 15 M27 12 L27 15"/></svg>`,

            tanker: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M2 15 L5 18 L32 18 L34 14 L28 13 L6 13 Z" fill="currentColor" fill-opacity="0.18"/><path d="M26 13 L26 8 L30 8 L30 13"/><line x1="28" y1="8" x2="28" y2="6"/><path d="M12 13 L14 7 L16 13 M18 13 L20 7 L22 13"/><line x1="13" y1="10" x2="15" y2="10"/><line x1="19" y1="10" x2="21" y2="10"/></svg>`,

            sealift: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M2 13 L5 18 L32 18 L34 14 L32 9 L25 9 L25 12 L6 12 Z" fill="currentColor" fill-opacity="0.18"/><path d="M26 9 L26 6 L30 6 L30 9"/><line x1="7" y1="14" x2="24" y2="14"/><line x1="12" y1="12" x2="12" y2="14"/><line x1="18" y1="12" x2="18" y2="14"/></svg>`,

            fighter: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M18 2 L19.5 7 L27 15 L24 16.5 L19.5 14 L19 21 L22 22.5 L21 23 L18 21.5 L15 23 L14 22.5 L17 21 L16.5 14 L12 16.5 L9 15 L16.5 7 Z" fill="currentColor" fill-opacity="0.18"/></svg>`,

            helo_asw: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M8 12 C8 8 13 8 19 9 L28 11 L31 9 L31 12 L27 13 L18 13 C12 13 8 15 8 12 Z" fill="currentColor" fill-opacity="0.18"/><line x1="14" y1="8" x2="14" y2="5"/><line x1="3" y1="5" x2="26" y2="5" stroke-width="1.5"/><line x1="31" y1="8" x2="31" y2="13"/><line x1="11" y1="14" x2="11" y2="16"/><line x1="17" y1="13" x2="17" y2="16"/></svg>`,

            helo_attack: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M7 11 L10 9 L15 9 L20 10 L28 12 L31 10 L31 13 L27 14 L17 14 L11 14 L7 12 Z" fill="currentColor" fill-opacity="0.18"/><circle cx="14" cy="4" r="1.6" fill="currentColor"/><line x1="14" y1="6" x2="14" y2="4"/><line x1="4" y1="6" x2="25" y2="6" stroke-width="1.5"/><line x1="7" y1="12" x2="5" y2="14"/><line x1="13" y1="12" x2="13" y2="15"/><line x1="31" y1="9" x2="31" y2="14"/></svg>`,

            helo_tandem: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M7 13 C7 10 9 10 12 10 L24 10 C27 10 29 11 29 14 L27 16 L9 16 Z" fill="currentColor" fill-opacity="0.18"/><path d="M9 10 L9 6"/><line x1="1" y1="6" x2="17" y2="6" stroke-width="1.4"/><path d="M26 10 L26 4"/><line x1="18" y1="4" x2="34" y2="4" stroke-width="1.4"/><path d="M12 15 L24 15"/></svg>`,

            helo_aew: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M8 11 C8 8 13 8 19 9 L28 11 L31 9 L31 12 L27 13 L18 13 C12 13 8 14 8 11 Z" fill="currentColor" fill-opacity="0.18"/><line x1="14" y1="8" x2="14" y2="5"/><line x1="3" y1="5" x2="26" y2="5" stroke-width="1.5"/><line x1="31" y1="8" x2="31" y2="13"/><circle cx="11" cy="15" r="3.2" stroke="currentColor" fill="currentColor" fill-opacity="0.3"/></svg>`,

            plane_aew: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M3 14 C3 12 6 12 12 12 L28 12 L33 7 L34 7 L32 14 L24 14 L12 14 C6 14 3 15 3 14 Z" fill="currentColor" fill-opacity="0.18"/><path d="M15 12 L16 8 L24 8 L25 12 Z" fill="currentColor" fill-opacity="0.3"/><line x1="15" y1="8" x2="25" y2="8" stroke-width="1.5"/><path d="M14 14 L12 17 L16 17 L17 14"/></svg>`,

            plane_elint: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M2 13 C2 12 4 11 10 11 L28 11 L33 6 L34 6 L32 13 L12 13 C6 13 2 14 2 13 Z" fill="currentColor" fill-opacity="0.18"/><path d="M2 13 C1 13 1 12 2 12 M6 13 C7 14 11 14 12 13" stroke-width="1.6"/><line x1="14" y1="13" x2="14" y2="16"/><line x1="18" y1="13" x2="18" y2="16"/><line x1="16" y1="11" x2="16" y2="9"/><line x1="22" y1="11" x2="22" y2="9"/></svg>`,

            plane_mpa: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M3 13 C3 11 6 11 12 11 L28 11 L33 6 L34 6 L32 13 L24 13 L12 13 C6 13 3 14 3 13 Z" fill="currentColor" fill-opacity="0.18"/><path d="M14 13 L14 16 L17 16 L17 13"/><path d="M10 13 C11 14.5 13 14.5 14 13" fill="currentColor"/><path d="M32 13 L35 13"/></svg>`,

            plane_tanker: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M3 13 C3 11 6 10 13 10 L28 10 L33 5 L34 5 L32 13 L12 13 C6 13 3 14 3 13 Z" fill="currentColor" fill-opacity="0.18"/><path d="M13 12 L13 16 L17 16 L17 12"/><line x1="20" y1="13" x2="24" y2="16"/><circle cx="24" cy="16" r="1.2" fill="currentColor"/></svg>`,

            plane_transport: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M3 12 C3 9 7 9 12 9 L28 9 L31 4 L33 4 L31 12 L27 15 L12 15 C6 15 3 14 3 12 Z" fill="currentColor" fill-opacity="0.18"/><line x1="29" y1="4" x2="35" y2="4" stroke-width="1.6"/><path d="M11 9 L11 12 M15 9 L15 12 M19 9 L19 12"/></svg>`,

            uav_drone: `<svg viewBox="0 0 36 24" fill="none" stroke="currentColor" stroke-width="1.3" stroke-linecap="round" stroke-linejoin="round"><path d="M18 4 L19 10 L33 11 L33 13 L19 12 L19 18 L23 21 L22 22 L18 20 L14 22 L13 21 L17 18 L17 12 L3 13 L3 11 L17 10 Z" fill="currentColor" fill-opacity="0.18"/><circle cx="18" cy="4" r="1.4" fill="currentColor"/></svg>`
        };

        // Resolves Specific Vector Silhouette for any Fleet Asset
        function getUnitIconSvg(item) {
            const name = (item.name || '').toLowerCase();
            const role = (item.role || '').toLowerCase();
            const type = item.type || '';
            const id = item.id || '';

            // 1. Submarines
            if (type === 'Submarine' || role.includes('submarine') || name.includes('astute') || name.includes('trafalgar')) {
                return UNIT_SVGS.submarine;
            }

            // 2. Aircraft (Drones, Helicopters, Fixed-Wing) - Checked BEFORE Ships!
            if (type === 'Aircraft' || (!type && (role.includes('aircraft') || role.includes('helo') || role.includes('helicopter') || role.includes('drone') || role.includes('uav')))) {
                // Drones / UAVs
                if (role.includes('uav') || role.includes('drone') || name.includes('protector') || name.includes('scaneagle') || name.includes('peregrine') || name.includes('camcopter') || name.includes('mojave') || name.includes('puma') || name.includes('malloy') || name.includes('proteus') || id.includes('mojave') || id.includes('puma') || id.includes('malloy') || id.includes('proteus')) {
                    return UNIT_SVGS.uav_drone;
                }
                // Helicopters
                if (name.includes('apache') || role.includes('attack helo') || role.includes('attack helicopter')) {
                    return UNIT_SVGS.helo_attack;
                }
                if (name.includes('chinook') || role.includes('heavy lift') || role.includes('tandem')) {
                    return UNIT_SVGS.helo_tandem;
                }
                if (name.includes('crowsnest') || role.includes('aew helo') || role.includes('aew helicopter') || name.includes('asac')) {
                    return UNIT_SVGS.helo_aew;
                }
                if (name.includes('merlin') || name.includes('wildcat') || role.includes('helo') || role.includes('helicopter') || role.includes('utility')) {
                    return UNIT_SVGS.helo_asw;
                }
                // Fixed-Wing Combat & ISR
                if (id.includes('F35') || name.includes('f-35') || role.includes('strike fighter') || role.includes('fighter')) {
                    return UNIT_SVGS.fighter;
                }
                if (name.includes('wedgetail') || name.includes('e-7') || role.includes('aew&c') || role.includes('airborne early warning')) {
                    return UNIT_SVGS.plane_aew;
                }
                if (name.includes('rivet') || name.includes('rc-135') || role.includes('sigint') || role.includes('esm') || role.includes('elint')) {
                    return UNIT_SVGS.plane_elint;
                }
                if (name.includes('poseidon') || name.includes('p-8') || role.includes('maritime patrol') || role.includes('mpa')) {
                    return UNIT_SVGS.plane_mpa;
                }
                // Aerial Tankers (Voyager KC.3)
                if (name.includes('voyager') || role.includes('strategic tanker') || role.includes('refueling') || (role.includes('tanker') && !role.includes('replenishment'))) {
                    return UNIT_SVGS.plane_tanker;
                }
                // Air Transports
                if (name.includes('globemaster') || name.includes('atlas') || name.includes('c-17') || name.includes('a400m') || role.includes('transport')) {
                    return UNIT_SVGS.plane_transport;
                }
                return UNIT_SVGS.fighter;
            }

            // 3. Surface Ships
            if (id === 'QE' || name.includes('queen elizabeth') || (role.includes('carrier') && !role.includes('aircraft carrier airwing')) || role.includes('flagship')) {
                return UNIT_SVGS.carrier;
            }
            if (role.includes('destroyer') || role.includes('type 45') || name.includes('daring') || name.includes('defender') || name.includes('dragon') || name.includes('dauntless') || name.includes('diamond')) {
                return UNIT_SVGS.destroyer;
            }
            if (role.includes('frigate') || role.includes('type 23') || role.includes('type 26') || role.includes('type 31') || role.includes('patrol') || role.includes('river') || name.includes('albans') || name.includes('somerset') || name.includes('glasgow') || name.includes('venturer') || name.includes('kent') || name.includes('portland') || name.includes('sutherland') || name.includes('medway')) {
                return UNIT_SVGS.frigate;
            }
            if (role.includes('bay-class') || name.includes('bay') || role.includes('landing ship')) {
                return UNIT_SVGS.amphibious;
            }
            if (role.includes('ro-ro') || role.includes('stuft') || name.includes('point') || role.includes('argus') || role.includes('raleigh') || role.includes('troop') || role.includes('liner') || name.includes('canberra') || name.includes('queen victoria')) {
                return UNIT_SVGS.sealift;
            }
            if (role.includes('tanker') || role.includes('aor') || name.includes('tide') || name.includes('fort victoria') || name.includes('wave') || name.includes('fisher')) {
                return UNIT_SVGS.tanker;
            }
            if (role.includes('cargo')) {
                return UNIT_SVGS.sealift;
            }

            // 4. Ultimate Fallbacks
            if (type === 'Aircraft') return UNIT_SVGS.fighter;
            return UNIT_SVGS.frigate;
        }

        // 1. Ingest Model Definition (AI-html-lua-reference MVC Pattern)
        let model = null;
        const injectedInput = document.getElementById('model_data');
        if (injectedInput && injectedInput.value && injectedInput.value !== '%s' && injectedInput.value.length > 10) {
            try {
                let rawVal = injectedInput.value;
                if (rawVal.indexOf('&quot;') !== -1) {
                    rawVal = rawVal.replace(/&quot;/g, '"');
                }
                model = JSON.parse(rawVal);
            } catch (err) {
                console.error("Failed to parse injected Lua model:", err);
            }
        }

        // Fallback mockup model for standalone browser preview / testing
        if (!model) {
            model = {
                maxPoints: 100,
                hoursPerPoint: 5,
                debugMode: true,
                categories: [
                    { id: "default", label: "Standing Task Force" },
                    { id: "escorts", label: "Escorts & Submarines" },
                    { id: "support", label: "Support & Auxiliary" },
                    { id: "airwing", label: "Carrier Air Wing" },
                    { id: "raf", label: "RAF" }
                ],
                items: [
                    // Default Carrier Strike Group & Auxiliaries (0 pts)
                    { id: "QE", type: "Ship", dbid: 1008, name: "HMS Queen Elizabeth", isDefault: true, pts: 0, qty: 1, spawnRP: "FLEET_SPAWN1", category: "default", group: "Task Force Warships & Surface Auxiliaries", role: "Carrier Strike Group (CSG) Flagship", upgradeCost: 4 },
                    { id: "StAlbans", type: "Ship", dbid: 3199, name: "HMS St Albans", isDefault: true, pts: 0, qty: 1, spawnRP: "FLEET_SPAWN1", category: "default", group: "Task Force Warships & Surface Auxiliaries", role: "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost: 2 },
                    { id: "Daring", type: "Ship", dbid: 3200, name: "HMS Daring", isDefault: true, pts: 0, qty: 1, spawnRP: "FLEET_SPAWN1", category: "default", group: "Task Force Warships & Surface Auxiliaries", role: "Type 45 Destroyer (1x Wildcat & 2x Peregrine)", upgradeCost: 2 },
                    { id: "LymeBay", type: "Ship", dbid: 1451, name: "RFA Lyme Bay", isDefault: true, pts: 0, qty: 1, spawnRP: "FLEET_SPAWN1", category: "default", group: "Task Force Warships & Surface Auxiliaries", role: "Bay-class Landing Ship — Cargo: Battalion Heavy Equipment & Stores (Embarked: 1x Chinook & 4x Puma UAV)" },
                    { id: "Tideforce", type: "Ship", dbid: 2581, name: "RFA Tideforce", isDefault: true, pts: 0, qty: 1, spawnRP: "FLEET_SPAWN1", category: "default", group: "Task Force Warships & Surface Auxiliaries", role: "Tide-class Tanker — Embarked: 1x Wildcat & 2x Malloy T150" },
                    { id: "Medway", type: "Ship", dbid: 2805, name: "HMS Medway", isDefault: true, pts: 0, qty: 1, spawnRP: "FLEET_FALKLANDS", category: "default", group: "Falklands Forward Patrol Asset", role: "River-class Batch 2 OPV (Falklands Forward Patrol) — Embarked: 2x Peregrine UAV" },

                    // Default Carrier Airwing (0 pts)
                    { id: "F35B_def", type: "Aircraft", dbid: 1095, name: "F-35B Lightning II", isDefault: true, pts: 0, qty: 12, spawnRP: "HMS Queen Elizabeth", category: "default", group: "Carrier Air Wing (Embarkation)", role: "Carrier Strike Fighter (1st Sq. - 12x Aircraft)", loadoutid: 25647 },
                    { id: "Wildcat_def", type: "Aircraft", dbid: 6786, name: "Wildcat HMA.2", isDefault: true, pts: 0, qty: 2, spawnRP: "HMS Queen Elizabeth", category: "default", group: "Carrier Air Wing (Embarkation)", role: "Carrier ASW/Utility Helo (2x Aircraft)", loadoutid: 17706 },
                    { id: "Merlin_def", type: "Aircraft", dbid: 3336, name: "Merlin HM.2", isDefault: true, pts: 0, qty: 2, spawnRP: "HMS Queen Elizabeth", category: "default", group: "Carrier Air Wing (Embarkation)", role: "Carrier ASW Helicopter (2x Aircraft)", loadoutid: 8559 },
                    { id: "Crowsnest_def", type: "Aircraft", dbid: 4110, name: "Merlin ASaC.5 Crowsnest", isDefault: true, pts: 0, qty: 2, spawnRP: "HMS Queen Elizabeth", category: "default", group: "Carrier Air Wing (Embarkation)", role: "Carrier AEW Helicopter (2x Aircraft)", loadoutid: 8559 },
                    { id: "MerlinHC4_def", type: "Aircraft", dbid: 4273, name: "Merlin HC.4", isDefault: true, pts: 0, qty: 2, spawnRP: "HMS Queen Elizabeth", category: "default", group: "Carrier Air Wing (Embarkation)", role: "Carrier Transport Helicopter (2x Aircraft)", loadoutid: 21903 },
                    { id: "Mojave_def", type: "Aircraft", dbid: 5696, name: "Mojave UAV", isDefault: true, pts: 0, qty: 2, spawnRP: "HMS Queen Elizabeth", category: "default", group: "Carrier Air Wing (Embarkation)", role: "Carrier Strike/Recon UAV (2x Drones)", loadoutid: 30519 },

                    // Default RAF (0 pts)
                    { id: "Poseidon_def", type: "Aircraft", dbid: 4940, name: "P-8 Poseidon MRA.1", isDefault: true, pts: 0, qty: 2, spawnRP: "W8V2DT-0HNODCG173JA6", category: "default", group: "RAF Theater Air Support", role: "Maritime Patrol (RAF Lossiemouth - 2x Aircraft)", loadoutid: 27683 },
                    { id: "Voyager_def", type: "Aircraft", dbid: 8072, name: "Airbus Voyager KC.3", isDefault: true, pts: 0, qty: 4, spawnRP: "W8V2DT-0HNODCG173J98", category: "default", group: "RAF Theater Air Support", role: "Strategic Tanker (RAF Brize Norton - 4x Aircraft)", loadoutid: 10562 },
                    { id: "Globemaster_def", type: "Aircraft", dbid: 4275, name: "C-17A Globemaster III", isDefault: true, pts: 0, qty: 4, spawnRP: "W8V2DT-0HNODCG173J98", category: "default", group: "RAF Theater Air Support", role: "Heavy Transport (RAF Brize Norton - 4x Aircraft)", loadoutid: 21908 },
                    { id: "Atlas_def", type: "Aircraft", dbid: 1420, name: "A400M Atlas C.1", isDefault: true, pts: 0, qty: 10, spawnRP: "W8V2DT-0HNODCG173J98", category: "default", group: "RAF Theater Air Support", role: "Tactical Transport (RAF Brize Norton - 10x Aircraft)", loadoutid: 13775 },
                    { id: "Protector_def", type: "Aircraft", dbid: 4724, name: "Protector RG.1", isDefault: true, pts: 0, qty: 1, spawnRP: "W8V2DT-0HNODCG173JC2", category: "default", group: "RAF Theater Air Support", role: "Strategic UAV (RAF Marham - 1x Drone)", loadoutid: 13989 },

                    // Escorts & Auxiliaries
                    { id: "Somerset", type: "Ship", dbid: 3199, name: "HMS Somerset", pts: 5, maxLimit: 1, spawnRP: "BASE_DEVONPORT", category: "escorts", group: "Type 23 ASW Frigates", role: "Type 23 ASW Frigate (1x Merlin & 2x Peregrine)", upgradeCost: 2 },
                    { id: "Defender", type: "Ship", dbid: 3438, name: "HMS Defender", pts: 10, maxLimit: 1, spawnRP: "BASE_PORTSMOUTH", category: "escorts", group: "Type 45 Air Defense Destroyers", role: "Type 45 Destroyer (Sea Ceptor - 1x Wildcat & 2x Peregrine)", upgradeCost: 2 },
                    { id: "Venturer", type: "Ship", dbid: 3271, name: "HMS Venturer", pts: 3, maxLimit: 1, spawnRP: "BASE_ROSYTH", category: "escorts", group: "Next-Generation Frigates (Type 26 & Type 31)", role: "Type 31 General Purpose Frigate (1x Wildcat & 2x Peregrine)", upgradeCost: 2 },
                    { id: "Glasgow", type: "Ship", dbid: 2795, name: "HMS Glasgow", pts: 7, maxLimit: 1, spawnRP: "BASE_DEVONPORT", category: "escorts", group: "Next-Generation Frigates (Type 26 & Type 31)", role: "Type 26 Advanced ASW Frigate (1x Wildcat, 1x Proteus & 2x Peregrine)", upgradeCost: 2 },
                    { id: "Anson", type: "Submarine", dbid: 725, name: "HMS Anson", pts: 5, maxLimit: 1, spawnRP: "BASE_CLYDE", category: "escorts", group: "Subsurface Fleet (Astute-Class SSN)", role: "Astute-Class Nuclear Submarine" },

                    { id: "MountsBay", type: "Ship", dbid: 1451, name: "RFA Mounts Bay", pts: 3, maxLimit: 1, spawnRP: "BASE_DEVONPORT", category: "support", group: "Bay-Class Amphibious Landing Ships", role: "Bay-class Landing Ship — Cargo: Battalion Heavy Equipment & Stores (Embarked: 1x Chinook & 4x Puma UAV)" },
                    { id: "CardiganBay", type: "Ship", dbid: 1451, name: "RFA Cardigan Bay", pts: 3, maxLimit: 1, spawnRP: "BASE_DEVONPORT", category: "support", group: "Bay-Class Amphibious Landing Ships", role: "Bay-class Landing Ship — Cargo: Battalion Heavy Equipment & Stores (Embarked: 1x Chinook & 4x Puma UAV)" },
                    { id: "FortVictoria", type: "Ship", dbid: 406, name: "RFA Fort Victoria", pts: 2, maxLimit: 1, spawnRP: "BASE_PORTLAND", category: "support", group: "Tide-Class & Fleet Replenishment (AOR)", role: "AOR Fleet Replenishment (1x Merlin, 1x HC.4 & 1x Peregrine)" },
                    { id: "HurstPoint", type: "Ship", dbid: 2423, name: "MV Hurst Point", pts: 1, maxLimit: 1, spawnRP: "BASE_MARCHWOOD", category: "support", group: "Point-Class Strategic Sealift (Ro-Ro)", role: "STUFT Strategic Ro-Ro Cargo" },
                    { id: "Canberra", type: "Ship", dbid: 2024, name: "MV Canberra", pts: 1, maxLimit: 1, spawnRP: "BASE_MARCHWOOD", category: "support", group: "STUFT Transports & Commercial Charters", role: "Chartered Troop Transport — Cargo: 2,000 Troop Capacity" },
                    { id: "QueenVictoria", type: "Ship", dbid: 2024, name: "MV Queen Victoria", pts: 1, maxLimit: 1, spawnRP: "BASE_MARCHWOOD", category: "support", group: "STUFT Transports & Commercial Charters", role: "Chartered Troop Transport — Cargo: 2,000 Troop Capacity" },

                    { id: "F35B_add", type: "Aircraft", dbid: 1095, name: "F-35B Lightning II", pts: 20, maxLimit: 1, spawnQty: 12, spawnRP: "HMS Queen Elizabeth", category: "airwing", group: "Carrier Strike & Naval Air Wing", role: "Carrier Strike Fighter (2nd Squadron - 12x Aircraft)", loadoutid: 25647 },
                    { id: "Mojave_add", type: "Aircraft", dbid: 5696, name: "Mojave UAV", pts: 1, maxLimit: 4, spawnRP: "HMS Queen Elizabeth", category: "airwing", group: "Carrier Strike & Naval Air Wing", role: "Carrier Strike/Recon UAV", loadoutid: 30519 },
                    { id: "Peregrine_add", type: "Aircraft", dbid: 6688, name: "Camcopter S-100 Peregrine", pts: 1, maxLimit: 1, spawnQty: 4, spawnRP: "HMS Queen Elizabeth", category: "airwing", group: "Carrier Strike & Naval Air Wing", role: "Carrier Recon UAV Flight (4x Drones)", loadoutid: 16924 },
                    { id: "Crowsnest_add", type: "Aircraft", dbid: 4110, name: "Merlin ASaC.5 Crowsnest", pts: 1, maxLimit: 2, spawnRP: "HMS Queen Elizabeth", category: "airwing", group: "Carrier Strike & Naval Air Wing", role: "Carrier AEW Helicopter", loadoutid: 8559 },

                    { id: "Wedgetail_add", type: "Aircraft", dbid: 4941, name: "E-7A Wedgetail AEW.1", pts: 4, maxLimit: 1, spawnRP: "W8V2DT-0HNODCG173J98", category: "raf", group: "Intelligence, Surveillance & Reconnaissance (ISR)", role: "AEW&C (Brize Norton)", loadoutid: 27687 },
                    { id: "Atlas_add", type: "Aircraft", dbid: 1420, name: "A400M Atlas C.1", pts: 1, maxLimit: 10, spawnRP: "W8V2DT-0HNODCG173J98", category: "raf", group: "Strategic Tankers & Air Transport", role: "Tactical Transport (Brize Norton)", loadoutid: 13775 }
                ]
            };
        }

        // 2. DOM Generation (MVC Pattern)
        const tabsHeader = document.getElementById('tabs-header');
        const tabsContainer = document.getElementById('tabs-container');

        // Build Tabs & Grid Containers
        model.categories.forEach((cat, index) => {
            const btn = document.createElement('button');
            btn.type = 'button';
            btn.className = `tab-btn ${index === 0 ? 'active' : ''}`;
            btn.innerHTML = `${TAB_ICONS[cat.id] || ''}<span>${cat.label}</span>`;
            btn.onclick = (e) => switchTab(e, `tab-${cat.id}`);
            tabsHeader.appendChild(btn);

            const tabPane = document.createElement('div');
            tabPane.id = `tab-${cat.id}`;
            tabPane.className = `tab-pane ${index === 0 ? 'active' : ''}`;

            const grid = document.createElement('div');
            grid.className = 'purchase-grid';
            tabPane.appendChild(grid);
            tabsContainer.appendChild(tabPane);
        });

        const lastGroupByCat = {};

        // Populate Cards
        model.items.forEach(item => {
            const grid = document.querySelector(`#tab-${item.category} .purchase-grid`);
            if (!grid) return;

            // Render Sub-Category Class Divider
            if (item.group && item.group !== lastGroupByCat[item.category]) {
                lastGroupByCat[item.category] = item.group;
                const divider = document.createElement('div');
                divider.className = 'class-divider';
                divider.innerHTML = `
                    <div class="class-divider-label">
                        <span class="divider-diamond">&#9670;</span>
                        <span>${item.group}</span>
                    </div>
                    <div class="class-divider-line"></div>
                `;
                grid.appendChild(divider);
            }

            const card = document.createElement('div');
            card.id = `card-${item.id}`;
            card.className = `unit-card ${item.isDefault ? 'default-asset selected' : ''}`;

            const header = document.createElement('div');
            header.className = 'card-header';

            // Visual Unit Identity (Stylized Vector Icon + Name & Role)
            const visual = document.createElement('div');
            visual.className = 'card-visual';

            const iconBox = document.createElement('div');
            iconBox.className = 'unit-icon-box';
            iconBox.innerHTML = getUnitIconSvg(item);
            visual.appendChild(iconBox);

            const info = document.createElement('div');
            info.className = 'card-info';

            const nameSpan = document.createElement('div');
            nameSpan.className = 'unit-name';
            const count = item.qty || item.spawnQty || 0;
            if (count > 1) {
                nameSpan.innerHTML = `${item.name} <span class="unit-qty-tag">${count}x</span>`;
            } else {
                nameSpan.innerText = item.name;
            }
            info.appendChild(nameSpan);

            const roleSpan = document.createElement('div');
            roleSpan.className = 'unit-role';
            roleSpan.innerText = item.role || item.type;
            info.appendChild(roleSpan);

            visual.appendChild(info);
            header.appendChild(visual);

            const controls = document.createElement('div');
            controls.className = 'unit-controls';

            const costBadge = document.createElement('span');
            costBadge.className = 'cost-badge';
            if (item.isDefault) {
                const count = item.qty || 1;
                costBadge.innerText = count > 1 ? `Baseline (${count}x)` : 'Baseline (1x)';
            } else if (item.spawnQty) {
                costBadge.innerText = `+${item.pts} pts (${item.spawnQty}x)`;
            } else if (item.maxLimit > 1) {
                costBadge.innerText = `+${item.pts} pt ea`;
            } else {
                costBadge.innerText = `+${item.pts} pts`;
            }
            controls.appendChild(costBadge);

            let inputEl;
            if (item.isDefault) {
                inputEl = document.createElement('input');
                inputEl.type = 'checkbox';
                inputEl.className = 'asset-input asset-checkbox';
                inputEl.checked = true;
                inputEl.disabled = true;
                inputEl.setAttribute('data-id', item.id);
                inputEl.setAttribute('data-pts', '0');
                controls.appendChild(inputEl);
            } else if (item.maxLimit > 1) {
                inputEl = document.createElement('input');
                inputEl.type = 'number';
                inputEl.className = 'asset-input asset-spinner';
                inputEl.min = '0';
                inputEl.max = item.maxLimit.toString();
                inputEl.value = '0';
                inputEl.setAttribute('data-id', item.id);
                inputEl.setAttribute('data-pts', item.pts.toString());
                inputEl.onchange = (e) => handleInputChange(e, card);
                controls.appendChild(inputEl);
            } else {
                inputEl = document.createElement('input');
                inputEl.type = 'checkbox';
                inputEl.className = 'asset-input asset-checkbox';
                inputEl.setAttribute('data-id', item.id);
                inputEl.setAttribute('data-pts', item.pts.toString());
                inputEl.onchange = (e) => handleInputChange(e, card);
                controls.appendChild(inputEl);
            }

            header.appendChild(controls);
            card.appendChild(header);

            // Munitions / VLS Fill Upgrades (Only for surface combatants/ships with explicit upgradeCost)
            if (item.upgradeCost && item.type === 'Ship') {
                const upgradeBox = document.createElement('div');
                upgradeBox.className = 'upgrades-panel';

                const upTitle = document.createElement('div');
                upTitle.className = 'upgrades-header';

                const upRow = document.createElement('div');
                upRow.className = 'upgrades-row';

                if (item.name === 'HMS Queen Elizabeth') {
                    upTitle.innerText = `Aviation Magazine Fill (+${item.upgradeCost} pts / +25%)`;
                    upgradeBox.appendChild(upTitle);

                    const stepLabels = ['+25% (50% Fill)', '+50% (75% Fill)', '+75% (100% Fill)'];
                    for (let step = 1; step <= 3; step++) {
                        const label = document.createElement('label');
                        label.className = 'upgrade-chip';

                        const cb = document.createElement('input');
                        cb.type = 'checkbox';
                        cb.className = 'mag-upgrade';
                        cb.setAttribute('data-target', item.name);
                        cb.setAttribute('data-pts', item.upgradeCost.toString());
                        cb.setAttribute('data-step-fill', '25');
                        cb.onchange = calculateTotals;

                        const txt = document.createElement('span');
                        txt.innerText = stepLabels[step - 1];

                        label.appendChild(cb);
                        label.appendChild(txt);
                        upRow.appendChild(label);
                    }
                } else {
                    upTitle.innerText = `Missile Silo Fill (Default: Peacetime 25%)`;
                    upgradeBox.appendChild(upTitle);

                    const label = document.createElement('label');
                    label.className = 'upgrade-chip';

                    const cb = document.createElement('input');
                    cb.type = 'checkbox';
                    cb.className = 'mag-upgrade';
                    cb.setAttribute('data-target', item.name);
                    cb.setAttribute('data-pts', item.upgradeCost.toString());
                    cb.setAttribute('data-fill', '100');
                    cb.onchange = calculateTotals;

                    const txt = document.createElement('span');
                    txt.innerText = `Full VLS Silos (+${item.upgradeCost} pts)`;

                    label.appendChild(cb);
                    label.appendChild(txt);
                    upRow.appendChild(label);
                }

                upgradeBox.appendChild(upRow);
                card.appendChild(upgradeBox);
            }

            grid.appendChild(card);
        });

        // Tab Switching
        function switchTab(evt, tabId) {
            document.querySelectorAll('.tab-pane').forEach(p => p.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            evt.currentTarget.classList.add('active');
        }

        // Input Change Handler
        function handleInputChange(e, card) {
            if (e.target.type === 'checkbox') {
                if (e.target.checked) {
                    card.classList.add('selected');
                } else {
                    card.classList.remove('selected');
                }
            } else if (e.target.type === 'number') {
                const val = parseInt(e.target.value) || 0;
                if (val > 0) {
                    card.classList.add('selected');
                } else {
                    card.classList.remove('selected');
                }
            }
            calculateTotals(e);
        }

        // Real-Time Total & Bridge 1 Hidden Inputs Synchronization
        function calculateTotals(e) {
            let pts = 0;

            // 1. Sum Checkboxes
            document.querySelectorAll('.asset-checkbox:checked').forEach(cb => {
                pts += parseInt(cb.getAttribute('data-pts')) || 0;
            });

            // 2. Sum Spinners
            document.querySelectorAll('.asset-spinner').forEach(sp => {
                const qty = parseInt(sp.value) || 0;
                pts += qty * (parseInt(sp.getAttribute('data-pts')) || 0);
            });

            // 3. Sum Munitions
            document.querySelectorAll('.mag-upgrade:checked').forEach(cb => {
                pts += parseInt(cb.getAttribute('data-pts')) || 0;
            });

            // Budget Exceeded Guard
            if (pts > MAX_POINTS) {
                alert("Maximum Task Force preparation budget exceeded!\nFurther delay makes the liberation attempt militarily and politically untenable.");
                if (e && e.target) {
                    if (e.target.type === 'checkbox') {
                        e.target.checked = false;
                        if (e.target.classList.contains('asset-input')) {
                            e.target.closest('.unit-card').classList.remove('selected');
                        }
                    } else if (e.target.type === 'number') {
                        e.target.value = (parseInt(e.target.value) - 1).toString();
                        if (parseInt(e.target.value) === 0) {
                            e.target.closest('.unit-card').classList.remove('selected');
                        }
                    }
                }
                return calculateTotals();
            }

            const hours = pts * HOURS_PER_POINT;
            const days = (hours / 24).toFixed(1);

            // Update Telemetry Header
            const pointsEl = document.getElementById('ui-points');
            if (pointsEl) pointsEl.innerText = `${pts} / ${MAX_POINTS}`;

            const pointsBlock = document.getElementById('stat-points-budget');
            if (pointsBlock) {
                pointsBlock.style.display = (model && model.debugMode) ? 'block' : 'none';
            }

            const daysEl = document.getElementById('ui-days');
            if (daysEl) daysEl.innerText = `${days} Days`;

            const newDate = new Date(BASE_DATE.getTime() + (hours * 60 * 60 * 1000));
            const day = newDate.getUTCDate().toString().padStart(2, '0');
            const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
            const month = months[newDate.getUTCMonth()];
            const year = newDate.getUTCFullYear();
            const hh = newDate.getUTCHours().toString().padStart(2, '0');
            const mm = newDate.getUTCMinutes().toString().padStart(2, '0');
            document.getElementById('ui-date').innerText = `${day} ${month} ${year} ${hh}:${mm} z`;

            // Update Timeline Fill
            const fill = document.getElementById('timeline-fill');
            fill.style.width = `${(pts / MAX_POINTS) * 100}%`;

            // Color Coding for Points
            if (pointsEl) {
                if (pts > 75) {
                    pointsEl.style.color = 'var(--red)';
                    pointsEl.style.textShadow = '0 0 12px var(--red-glow)';
                } else if (pts > 40) {
                    pointsEl.style.color = 'var(--amber)';
                    pointsEl.style.textShadow = '0 0 12px var(--amber-glow)';
                } else {
                    pointsEl.style.color = 'var(--cyan)';
                    pointsEl.style.textShadow = '0 0 12px var(--cyan-glow)';
                }
            }

            // Sync ENEMY ENTRENCHES label color with the timeline progress bar
            const entrenchLabel = document.getElementById('label-enemy-entrenches');
            if (entrenchLabel) {
                if (pts > 75) {
                    entrenchLabel.style.color = 'var(--red)';
                    entrenchLabel.style.textShadow = '0 0 12px var(--red-glow)';
                } else if (pts > 40) {
                    entrenchLabel.style.color = 'var(--amber)';
                    entrenchLabel.style.textShadow = '0 0 10px var(--amber-glow)';
                } else if (pts > 0) {
                    entrenchLabel.style.color = 'var(--cyan)';
                    entrenchLabel.style.textShadow = '0 0 8px var(--cyan-glow)';
                } else {
                    entrenchLabel.style.color = 'var(--text-dim)';
                    entrenchLabel.style.textShadow = 'none';
                }
            }

            // Update Threat Feed Title (Debug vs Operational Intelligence)
            const threatTitle = document.getElementById('threat-feed-title');
            if (threatTitle) {
                threatTitle.innerText = (model && model.debugMode)
                    ? "Argentine Intelligence & Defensive Escalation Matrix [DEBUG]"
                    : "Argentine Defensive Posture & Intelligence Feed";
            }

            // Update Argentine Threat Pills
            document.querySelectorAll('.threat-pill').forEach(pill => {
                const reqPts = parseInt(pill.getAttribute('data-pts'));
                const isTriggered = pts >= reqPts;

                if (isTriggered) {
                    if (reqPts >= 75) {
                        pill.className = 'threat-pill critical';
                    } else {
                        pill.className = 'threat-pill triggered';
                    }
                } else {
                    pill.className = 'threat-pill' + ((model && model.debugMode) ? '' : ' redacted');
                }

                if (model && model.debugMode) {
                    pill.innerText = pill.getAttribute('data-debug') || pill.innerText;
                } else {
                    pill.innerText = pill.getAttribute('data-intel') || pill.innerText;
                }
            });

            // BRIDGE 1: Continuous Hidden Input Synchronization
            // Scraped by Lua upon modal dialog closure
            const payload = compilePayload();
            document.getElementById('ctfs_payload').value = encodeURIComponent(JSON.stringify(payload));
            document.getElementById('ctfs_points').value = pts.toString();
            document.getElementById('ctfs_hours').value = hours.toString();
        }

        // Compiles Selected Forces into Structured Order Payload
        function compilePayload() {
            let payload = { totalPoints: 0, units: [], upgrades: {} };

            model.items.forEach(item => {
                const card = document.getElementById(`card-${item.id}`);
                if (!card) return;

                const input = card.querySelector('.asset-input');
                let qty = 0;

                if (item.isDefault) {
                    qty = item.qty || 1;
                } else if (input.type === 'checkbox' && input.checked) {
                    qty = item.spawnQty || 1;
                } else if (input.type === 'number') {
                    qty = parseInt(input.value) || 0;
                }

                if (qty > 0) {
                    const itemPoints = item.spawnQty ? item.pts : (qty * item.pts);
                    payload.units.push({
                        id: item.id,
                        type: item.type,
                        dbid: item.dbid,
                        name: item.name,
                        spawnRP: item.spawnRP,
                        qty: qty,
                        pts: item.pts,
                        loadoutid: item.loadoutid || null
                    });
                    payload.totalPoints += itemPoints;
                }
            });

            document.querySelectorAll('.mag-upgrade:checked').forEach(cb => {
                const target = cb.getAttribute('data-target');
                const stepFill = cb.getAttribute('data-step-fill');
                if (stepFill) {
                    payload.upgrades[target] = (payload.upgrades[target] || 0) + parseInt(stepFill);
                } else {
                    const fill = parseInt(cb.getAttribute('data-fill')) || 100;
                    payload.upgrades[target] = fill;
                }
                payload.totalPoints += parseInt(cb.getAttribute('data-pts')) || 0;
            });

            return payload;
        }

        // Execution Trigger (Supports Bridge 1 submission & Bridge 2 postMessage)
        function executeLaunch() {
            const payload = compilePayload();
            const encodedPayload = encodeURIComponent(JSON.stringify(payload));

            // Synchronize final hidden inputs
            document.getElementById('ctfs_payload').value = encodedPayload;
            document.getElementById('ctfs_points').value = payload.totalPoints.toString();
            document.getElementById('ctfs_hours').value = (payload.totalPoints * HOURS_PER_POINT).toString();

            // Calculate operational timing for Admiralty Orders
            const hoursDelayed = payload.totalPoints * HOURS_PER_POINT;
            const daysDelayed = (hoursDelayed / 24).toFixed(1);
            const depDate = new Date(BASE_DATE.getTime() + hoursDelayed * 3600 * 1000);
            const dd = String(depDate.getUTCDate()).padStart(2, '0');
            const mm = String(depDate.getUTCMonth() + 1).padStart(2, '0');
            const yyyy = depDate.getUTCFullYear();
            const hh = String(depDate.getUTCHours()).padStart(2, '0');
            const min = String(depDate.getUTCMinutes()).padStart(2, '0');
            const sec = String(depDate.getUTCSeconds()).padStart(2, '0');
            const departureDTG = `${dd}.${mm}.${yyyy} ${hh}:${min}:${sec}Z`;

            // Hide force selection interface elements
            const hud = document.querySelector('.hud-dashboard');
            const tabsHeader = document.getElementById('tabs-header');
            const tabsContainer = document.getElementById('tabs-container');
            const launchContainer = document.querySelector('.launch-container');

            if (tabsHeader) tabsHeader.style.display = 'none';
            if (tabsContainer) tabsContainer.style.display = 'none';
            if (launchContainer) launchContainer.style.display = 'none';

            if (hud) {
                const stats = hud.querySelector('.stats-grid');
                const timeline = hud.querySelector('.timeline-container');
                const threatTitle = document.getElementById('threat-feed-title');
                const threatPills = hud.querySelector('.threat-pills');
                if (stats) stats.style.display = 'none';
                if (timeline) timeline.style.display = 'none';
                if (threatTitle) threatTitle.style.display = 'none';
                if (threatPills) threatPills.style.display = 'none';
            }

            // Render Full Widescreen Admiralty Operational Orders directly in large window
            const ordersDisplay = document.getElementById('orders-display');
            if (ordersDisplay) {
                ordersDisplay.innerHTML = `
                    <div style="background-color: #0d1322; color: #cbd5e1; font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Tahoma, Geneva, Verdana, sans-serif; padding: 24px 28px; border-radius: 8px; border: 1px solid #1c273e; box-shadow: 0 10px 40px rgba(0, 0, 0, 0.7);">
                        
                        <!-- Header Banner -->
                        <table style="width: 100%; border-collapse: collapse; margin-bottom: 20px; border-bottom: 2px solid #00d2ff; padding-bottom: 14px;">
                            <tr>
                                <td style="vertical-align: top;">
                                    <div style="color: #00d2ff; font-size: 11px; font-weight: 800; letter-spacing: 2px; text-transform: uppercase;">MINISTRY OF DEFENCE &bull; PERMANENT JOINT HEADQUARTERS (PJHQ) NORTHWOOD</div>
                                    <div style="color: #ffffff; font-size: 20px; font-weight: 800; letter-spacing: 1.5px; margin-top: 5px;">ROYAL NAVY FLEET OPERATIONAL ORDER // OP RECORPORATE</div>
                                </td>
                                <td style="vertical-align: top; text-align: right;">
                                    <span style="background-color: rgba(200, 16, 46, 0.2); border: 1px solid #c8102e; color: #ff6b81; font-family: monospace; font-size: 11px; font-weight: 800; padding: 6px 14px; border-radius: 4px; letter-spacing: 1.5px; display: inline-block;">
                                        TOP SECRET // COMMANDER EYES ONLY
                                    </span>
                                </td>
                            </tr>
                        </table>

                        <!-- Telemetry Strip -->
                        <table style="width: 100%; border-collapse: collapse; margin-bottom: 18px; background-color: #070a12; border: 1px solid #1c273e; border-radius: 6px;">
                            <tr>
                                <td style="padding: 10px 14px; border-right: 1px solid #1c273e; font-size: 12px; color: #8899b0;">
                                    <strong style="color: #00d2ff;">ORIGINATOR:</strong> CINCFLEET / NORTHWOOD
                                </td>
                                <td style="padding: 10px 14px; border-right: 1px solid #1c273e; font-size: 12px; color: #8899b0;">
                                    <strong style="color: #00d2ff;">ACTION TO:</strong> CTF 317 (FLAGSHIP HMS QUEEN ELIZABETH)
                                </td>
                                <td style="padding: 10px 14px; border-right: 1px solid #1c273e; font-size: 12px; color: #8899b0;">
                                    <strong style="color: #00d2ff;">DEPARTURE DTG:</strong> <span style="color: #ffffff; font-weight: bold;">${departureDTG}</span>
                                </td>
                                <td style="padding: 10px 14px; font-size: 12px; color: #8899b0;">
                                    <strong style="color: #00d2ff;">STAGING DELAY:</strong> <span style="color: #ffffff; font-weight: bold;">${daysDelayed} DAYS (${hoursDelayed} HRS)</span>
                                </td>
                            </tr>
                        </table>

                        <!-- 1. Situation & Mobilisation Report -->
                        <div style="background-color: #070a12; border: 1px solid #1c273e; border-left: 4px solid #00d2ff; padding: 16px 18px; margin-bottom: 16px; border-radius: 0 6px 6px 0;">
                            <div style="color: #00d2ff; font-size: 13px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px;">
                                1. SITUATION &amp; MOBILISATION REPORT
                            </div>
                            <p style="font-size: 13.5px; line-height: 1.6; margin: 0 0 10px 0; color: #cbd5e1;">
                                Following an operational staging and mobilisation period (${daysDelayed} Days elapsed), Task Force 317 is formally released from home waters and cleared to commence theatre transit for the South Atlantic Joint Operations Area (JOA).
                            </p>
                            <p style="font-size: 13px; line-height: 1.6; margin: 0; color: #94a3b8;">
                                <strong style="color: #00d2ff;">INTELLIGENCE ASSESSMENT:</strong> The operational delay required to marshal surface combatants, carrier strike squadrons, and sealift tonnage in UK ports has afforded Argentine Joint Forces crucial strategic breathing room to entrench and reinforce.
                            </p>
                        </div>

                        <!-- 2. Theatre Forward Presence -->
                        <div style="background-color: #070a12; border: 1px solid #1c273e; border-left: 4px solid #00d2ff; padding: 16px 18px; margin-bottom: 16px; border-radius: 0 6px 6px 0;">
                            <div style="color: #00d2ff; font-size: 13px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px;">
                                2. THEATRE FORWARD PRESENCE
                            </div>
                            <p style="font-size: 13.5px; line-height: 1.6; margin: 0; color: #cbd5e1;">
                                The River-class Offshore Patrol Vessel <strong style="color: #ffffff;">HMS Medway</strong> is currently forward-deployed in the Falklands sector. Being lightly armed and isolated, <em>Medway</em> has adopted strict emissions control (<strong style="color: #ffffff;">EMCON Alpha</strong>) and a clandestine surveillance posture.
                            </p>
                        </div>

                        <!-- 3. Force Organisation, Escort Doctrine & Speed Discipline -->
                        <div style="background-color: #070a12; border: 1px solid #1c273e; border-left: 4px solid #00d2ff; padding: 16px 18px; margin-bottom: 16px; border-radius: 0 6px 6px 0;">
                            <div style="color: #00d2ff; font-size: 13px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 10px;">
                                3. FORCE ORGANISATION, ESCORT DOCTRINE &amp; SPEED DISCIPLINE
                            </div>
                            <p style="font-size: 13.5px; line-height: 1.6; margin: 0 0 10px 0; color: #cbd5e1;">
                                Commander Task Force 317 must immediately assemble all deployed surface and subsurface units into structured operational groups:
                            </p>
                            <ul style="margin: 0; padding-left: 22px; font-size: 13.5px; line-height: 1.65; color: #cbd5e1;">
                                <li style="margin-bottom: 8px;">
                                    <strong style="color: #00d2ff;">Speed Discipline &amp; Grouping:</strong> Carrier Strike Group must make its way towards the Area of Operations (AOO) at best possible speed whilst considering the trade-off between transit speed and fuel consumption. Slower auxiliary tankers, dry cargo, support, and amphibious ships need to be formed into separate formation(s) to prevent slowing capital ship manoeuvring.
                                </li>
                                <li style="margin-bottom: 8px;">
                                    <strong style="color: #00d2ff;">Dedicated Escort Coverage:</strong> Unarmed civilian transports (STUFT cruise liners, Ro-Ros), amphibious landing ships, and logistics vessels must be protected through contested sea lanes. Form independent auxiliary convoys and assign dedicated surface escort and RAF presence along the convoy route.
                                </li>
                                <li style="margin-bottom: 8px;">
                                    <strong style="color: #00d2ff;">Astute-Class SSNs:</strong> Fleet nuclear attack submarines are not bound by escort duties or fuel conservation. They can steam south at sustained high speeds to establish an advance screening and subsurface sea denial ahead of the main fleet, and begin building tactical situational awareness around the Falklands.
                                </li>
                                <li>
                                    <strong style="color: #00d2ff;">Fuel Conservation &amp; Replenishment:</strong> Distance from the United Kingdom to Ascension Island and onward to the Falklands exceeds 7,000 nautical miles. Fuel conservation needs to be managed from the start for both ships and aircraft making the transit. Each fleet formation and each flight heading out should be supported by an adequate allocation of fleet tankers (RFA Tide/Wave class) and RAF Voyager refuelling assets.
                                </li>
                            </ul>
                        </div>

                        <!-- 4. Midway Point (Ascension Island) -->
                        <div style="background-color: #070a12; border: 1px solid #1c273e; border-left: 4px solid #00d2ff; padding: 16px 18px; margin-bottom: 18px; border-radius: 0 6px 6px 0;">
                            <div style="color: #00d2ff; font-size: 13px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px;">
                                4. MIDWAY POINT (ASCENSION ISLAND)
                            </div>
                            <p style="font-size: 13.5px; line-height: 1.6; margin: 0 0 10px 0; color: #cbd5e1;">
                                Excluding forward Falklands presence (HMS <em>Medway</em> and advance sprinting SSNs), all fleets and transiting aircraft must stop at <strong style="color: #ffffff;">Ascension Island (Wideawake Airfield / Anchorage)</strong> to refuel, load stores and troops, and reorganise for the final push towards the Falklands Theatre. Ascension is the last stop before the Area of Operations and the final opportunity to make ready for action.
                            </p>
                            <p style="font-size: 13px; line-height: 1.6; margin: 0; color: #94a3b8;">
                                <strong style="color: #00d2ff;">OPERATIONAL NOTICE:</strong> Expect new orders and refined intelligence updates when the fleet assembles at Ascension Island.
                            </p>
                        </div>

                        <!-- Confirmation Banner -->
                        <div style="background: linear-gradient(180deg, #1b5e20 0%, #0d3813 100%); border: 1px solid #00e676; border-radius: 6px; padding: 16px 20px; text-align: center; margin-bottom: 14px; box-shadow: 0 4px 20px rgba(0, 230, 118, 0.25);">
                            <div style="color: #ffffff; font-size: 15px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase;">
                                ORDERS TRANSMITTED - TASK FORCE DEPLOYED
                            </div>
                            <div style="color: #a7f3d0; font-size: 12px; margin-top: 4px; font-weight: 600;">
                                You can safely close this window
                            </div>
                        </div>

                        <!-- Footer Sign-off -->
                        <div style="border-top: 1px solid #1c273e; padding-top: 12px; font-size: 11px; color: #64748b; text-align: center; letter-spacing: 1.5px; text-transform: uppercase;">
                            ADMIRALTY SIGNAL // PERMANENT JOINT HEADQUARTERS // GOD SAVE THE KING // OUT
                        </div>
                    </div>
                `;
                ordersDisplay.style.display = 'block';
                window.scrollTo({ top: 0, behavior: 'smooth' });
            }

            // BRIDGE 2: Asynchronous WebView2 IPC (defend-luzon reference pattern)
            if (window.chrome && window.chrome.webview) {
                window.chrome.webview.postMessage("DIALOG_OK" + "CTFS_ProcessUIResponse('" + encodedPayload + "')");
            } else {
                console.log("BRIDGE 2 POSTMESSAGE DISPATCH:", "DIALOG_OK" + "CTFS_ProcessUIResponse('" + encodedPayload + "')");
            }
        }

        // Initialize state on render
        calculateTotals();
    </script>
</body>

</html>
]==]

-- HTML PAYLOAD BUILDER & INJECTION
-- =============================================================================
local function PrepareHTMLPayload()
    local debugLog = {}
    local raw_html

    raw_html, debugLog = ReadLocalFile("ctfs_ui.html", debugLog)

    -- In CMO Sandbox, io is nil so ReadLocalFile returns nil.
    -- Fall back to the embedded zero-dependency HTML template:
    if not raw_html then
        raw_html = CTFS.HTML_TEMPLATE
    end

    if not raw_html then
        local diagHeader = "=== CTFS File Resolution Diagnostics ===\n"
            .. "type(io): " .. tostring(type(io)) .. "\n"
            .. "type(io.open): " .. tostring(io and type(io.open) or "N/A") .. "\n"
            .. "_scenariofolder_: " .. tostring(rawget(_G, "_scenariofolder_") or "<empty/nil>") .. "\n"
            .. "_scriptfolder_: " .. tostring(rawget(_G, "_scriptfolder_") or "<empty/nil>") .. "\n\n"
            .. "Attempted Paths (" .. tostring(#debugLog) .. "):\n"
            .. table.concat(debugLog, "\n")

        print(diagHeader)
        ScenEdit_MsgBox(diagHeader, 1)
        return nil
    end

    -- Serialize master model
    CTFS.MODEL.debugMode = CTFS.DEBUG_MODE
    local model_json = JSON.stringify(CTFS.MODEL)

    -- Safe injection: Escape CSS percentages while preserving value="%s" slot
    local escaped_html = EscapePercentsButKeep_s(raw_html)
    local safe_model_json = string.gsub(model_json, '"', '&quot;')

    -- Inject serialized model into template
    local formatted_html = string.format(escaped_html, safe_model_json)
    return formatted_html
end

-- Helper to decode URL-encoded JSON payloads from WebView2
local function UrlDecode(str)
    if not str then return "" end
    str = string.gsub(str, "+", " ")
    str = string.gsub(str, "%%(%x%x)", function(h)
        return string.char(tonumber(h, 16))
    end)
    return str
end

-- =============================================================================
-- BRIDGE 1: SYNCHRONOUS STATE MANAGEMENT (UI_CallAdvancedHTMLDialog)
-- Recommended for Scenario Start. Modal dialog that fully freezes simulation clock.
-- Pattern: "iran strike 2030.lua"
-- =============================================================================
function CTFS.OpenDialog()
    local htmlPayload = PrepareHTMLPayload()
    if not htmlPayload then return end

    -- Modal execution signature (AI-html-lua-reference line 16)
    local return_table = UI_CallAdvancedHTMLDialog("CTFS: Carrier Task Force Selector", htmlPayload,
        { "Launch Operation Recorporate", "Cancel" })

    if return_table and (return_table["pressed"] == "Launch Operation Recorporate" or return_table["pressed"] == "Launch Task Force") then
        -- Coerce and extract payload from hidden inputs
        local rawPayload = return_table["ctfs_payload"]
        if rawPayload and #rawPayload > 0 then
            -- Sanitize potential single quotes appended by CMO serialization
            rawPayload = string.gsub(rawPayload, "^'", "")
            rawPayload = string.gsub(rawPayload, "'$", "")

            if string.find(rawPayload, "%%") then
                rawPayload = UrlDecode(rawPayload)
            end

            local success, selections = pcall(JSON.parse, rawPayload)
            if success and selections then
                return CTFS.ProcessOrder(selections)
            else
                ScenEdit_MsgBox("CTFS Error: Failed to parse returned configuration data.", 1)
            end
        else
            ScenEdit_MsgBox("CTFS Error: No configuration payload received from dialog.", 1)
        end
    end
    return false
end

-- =============================================================================
-- BRIDGE 2: ASYNCHRONOUS IPC (ScenEdit_SpecialMessage)
-- Non-modal dashboard execution. Listens for postMessage("DIALOG_OK...")
-- Pattern: "defend-luzon-reference-library.lua"
-- =============================================================================
function CTFS.OpenUI()
    local htmlPayload = PrepareHTMLPayload()
    if not htmlPayload then return end

    -- Asynchronous execution signature (AI-html-lua-reference line 40-45)
    local playerSide = ScenEdit_PlayerSide()
    if not playerSide or playerSide == "" then playerSide = "UK" end
    ScenEdit_SpecialMessage(playerSide, htmlPayload)
end

-- Global callback handler triggered by Bridge 2 postMessage
function CTFS_ProcessUIResponse(jsonString)
    if not jsonString or type(jsonString) ~= "string" then
        ScenEdit_MsgBox("CTFS Error: Invalid response payload received.", 1)
        return
    end

    -- Sanitize potential single quotes if passed with enclosing quotes
    jsonString = string.gsub(jsonString, "^'", "")
    jsonString = string.gsub(jsonString, "'$", "")

    if string.find(jsonString, "%%") then
        jsonString = UrlDecode(jsonString)
    end

    local success, selections = pcall(JSON.parse, jsonString)

    if success and selections then
        CTFS.ProcessOrder(selections)
    else
        ScenEdit_MsgBox("CTFS Core Error: Failed to parse user selection payload.", 1)
    end
end

return CTFS
