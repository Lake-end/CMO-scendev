-- Count AUC (Active Unit Count) for all sides

-- ============================================================================
-- SCRIPT: Calculate Active Unit Count (AUC) for the entire scenario
-- ============================================================================

local totalAUC = 0
local sides = VP_GetSides()
local output = "--- Skenaarion Active Unit Count (AUC) ---\n"

-- Käydään läpi kaikki skenaarion osapuolet
for _, side in ipairs(sides) do
    local sideName = side.name
    local sideData = VP_GetSide({side = sideName})
    local sideUnitCount = 0
    
    -- Varmistetaan, että osapuolella on yksiköitä, ja lasketaan ne
    if sideData and sideData.units then
        for _, u_info in ipairs(sideData.units) do
            sideUnitCount = sideUnitCount + 1
        end
    end
    
    -- Lisätään osapuolen tulos raporttiin
    output = output .. "Osapuoli '" .. sideName .. "': " .. sideUnitCount .. " yksikköä\n"
    
    -- Lisätään kokonaismäärään
    totalAUC = totalAUC + sideUnitCount
end

output = output .. "------------------------------------------\n"
output = output .. "KOKONAIS AUC (Active Unit Count): " .. totalAUC

-- Tulostetaan loppuraportti konsoliin
print(output)