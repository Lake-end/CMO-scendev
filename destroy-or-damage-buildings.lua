-- Strike on Svalbard Satellite Station
local side = "NATO"

-- 1. DESTROYED BUILDINGS (Radomes)
local radomes = {
    'W8V2DT-0HNIL407TKDFJ', 'W8V2DT-0HNIL407TKDFN', 'W8V2DT-0HNIL407TKDFV',
    'W8V2DT-0HNIL407TKDFR', 'W8V2DT-0HNIL407TKDG7', 'W8V2DT-0HNIL407TKDG3',
    'W8V2DT-0HNIL407TKDH3', 'W8V2DT-0HNIL407TKDGB', 'W8V2DT-0HNIL407TKDGJ'
}

for _, id in ipairs(radomes) do
    ScenEdit_SetUnitDamage({guid=id, damage='destroyed'})
end

-- 2. DAMAGED BUILDINGS
-- Function to apply percentage-based damage
local function ApplyPercentDamage(unit_guid, percent, fires)
    local u = ScenEdit_GetUnit({guid=unit_guid})
    if u then
        -- Total damage points (startdp) * (1 - percent_decimal) = remaining points
        local remaining_dp = u.damage.startdp * (1 - (percent / 100))
        ScenEdit_SetUnitDamage({
            guid=unit_guid, 
            dp=remaining_dp, 
            fires=fires or 0
        })
    end
end

-- Uplink Relay: 54% dmg, 1 fire
ApplyPercentDamage('W8V2DT-0HNIOBJ2UA3UU', 54, 1)

-- Ops Building: 28% dmg, 3 fires (Major Fire!)
ApplyPercentDamage('W8V2DT-0HNBD41023MLR', 28, 3)

-- Transformer: 88% damage
ApplyPercentDamage('W8V2DT-0HNBD41023MSC', 88, 0)

print("SvalSat Attack Script Executed: Radomes destroyed and facilities crippled.")