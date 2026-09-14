-- CONFIGURATION
--[[
{name='Helsinki-Vantaa lentoasema (Helsinki-Vantaa airport)', guid='W8V2DT-0HNHJ3HMMI8EH'}


]]
-- CONFIGURATION
local sideName = "NATO"
local targetGroupName = "Jyväskylä-Tikkakoski lentoasema (Jyväskylä-Tikkakoski airport)"

-- FUNCTION: Toimiva vaurioituslogiikka
local function ApplyPercentDamageToUnit(unit_guid, percent)
    local u = ScenEdit_GetUnit({guid=unit_guid})
    if u and u.damage then
        -- Lasketaan jäljellä olevat pisteet
        local remaining_dp = u.damage.startdp * (1 - (percent / 100))
        
        -- Asetetaan vaurio
        ScenEdit_SetUnitDamage({
            guid = unit_guid, 
            dp = remaining_dp,
            fires = (percent > 60 and 1 or 0) -- Tulipalo vain jos vaurio > 60%
        })
        return true
    end
    return false
end

-- 1. Etsitään ryhmä manuaalisesti
local side = VP_GetSide({side = sideName})
local groupGuid = nil

for _, u in ipairs(side.units) do
    if u.name == targetGroupName then
        groupGuid = u.guid
        break
    end
end

-- 2. Jos ryhmä löytyi, vaurioitetaan jäsenet valikoiden
if groupGuid ~= nil then
    local groupObj = ScenEdit_GetUnit({guid = groupGuid})
    
    if groupObj.group ~= nil then
        local members = groupObj.group.unitlist
        print("--- Selective Damage Report: " .. targetGroupName .. " ---")
        
        for i, uGuid in ipairs(members) do
            local u = ScenEdit_GetUnit({guid = uGuid})
            
            -- MODIFIKAATIO: Joka neljäs yksikkö (i % 4 == 0) jätetään rauhaan
            if i % 4 == 0 then
                print(string.format("Unit: %s | STATUS: Intact (Missed)", u.name))
            else
                -- Muille arvotaan vaurio
                local rndPercent = math.random(5, 95)
                ApplyPercentDamageToUnit(uGuid, rndPercent)
                print(string.format("Unit: %s | STATUS: Damaged (%d%%)", u.name, rndPercent))
            end
        end
        print("--- Operation Complete ---")
    else
        print("ERROR: Target is not a group.")
    end
else
    print("ERROR: Could not find group '" .. targetGroupName .. "'")
end