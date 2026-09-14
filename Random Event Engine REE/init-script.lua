-- ========================================================
-- INIT SCRIPT: RANDOM EVENT POOL GENERATOR V2.2 (Simple Logging)
-- ========================================================
-- APUFUNKTIO: Tulostaa CMO:n Lua-lokiin
local function LogEvent(msg)
    print("[Init Engine] " .. msg)
end

LogEvent("=== Skenaarion satunnaismoottori alustetaan ===")

local minEvents = 5
local maxEvents = 8
local totalEventsToPick = math.random(minEvents, maxEvents)

local minHour = 10
local maxHour = 150 -- Skenaarion kesto tunneissa

local allEvents = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
local selectedEvents = {}

-- Arvotaan uniikit tapahtumat
for i = 1, totalEventsToPick do
    if #allEvents > 0 then
        local randomIndex = math.random(1, #allEvents)
        table.insert(selectedEvents, allEvents[randomIndex])
        table.remove(allEvents, randomIndex)
    end
end

-- Rakennetaan aikataulu muodossa "ID:TUNTI|"
-- Koska tunnit ovat satunnaisia, tapahtumien järjestys sekoittuu automaattisesti aikajanalla
local eventString = ""
for _, eventID in ipairs(selectedEvents) do
    local triggerHour = math.random(minHour, maxHour)
    eventString = eventString .. eventID .. ":" .. triggerHour .. "|"
end

-- Tallennetaan KVS:ään
ScenEdit_SetKeyValue("MasterEventList", eventString)
ScenEdit_SetKeyValue("ScenarioHour", "0")

LogEvent("Alustus valmis. Arvottu " .. totalEventsToPick .. " tapahtumaa.")
LogEvent("Tapahtumajono (Queue): " .. eventString)