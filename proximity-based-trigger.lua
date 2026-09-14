-- ========================================================
-- CUMULATIVE PROXIMITY CHECK: AIRCRAFT TO NEUTRAL SHIP
-- (Polling Event: Run every 15 seconds)
-- ========================================================
f
local thresholdNM = 2       -- Etäisyysraja (NM)
local requiredTicks = 8     -- Vaaditut osumat (8 * 15s = 120 sekuntia)

-- 1. Kerätään kaikki pelaajan aktiiviset lentolaitteet
local playerUnits = VP_GetSide({side = playerSide}).units
local activeAircraft = {}

for _, desc in ipairs(playerUnits) do
    local u = ScenEdit_GetUnit({guid = desc.guid})
        if u ~= nil and u.type == 'Aircraft' then
            table.insert(activeAircraft, u)
    end
end

-- 2. Kerätään kaikki neutraalit laivat
local neutralUnits = VP_GetSide({side = neutralSide}).units

for _, desc in ipairs(neutralUnits) do
    local ship = ScenEdit_GetUnit({guid = desc.guid})
    
    if ship ~= nil and ship.type == 'Ship' then
        -- Tarkistetaan onko laiva jo lopullisesti tunnistettu
        local isApproached = ScenEdit_GetKeyValue("Approached_" .. ship.guid)
        
        if isApproached ~= "Yes" then
            local aircraftInRange = false
            
            -- Mitataan etäisyys pelaajan koneisiin
            for _, ac in ipairs(activeAircraft) do
                local dist = Tool_Range(ac.guid, ship.guid)
                
                if dist <= thresholdNM then
                    aircraftInRange = true
                    break -- Yksikin kone riittää, ei tarvitse tarkistaa muita
                end
            end
            
            -- Jos kone on alueella, lisätään tick-laskuria
            if aircraftInRange then
                -- Luetaan nykyiset tickit (tai alustetaan nollaan, jos ei vielä olemassa)
                local currentTicks = tonumber(ScenEdit_GetKeyValue("Ticks_" .. ship.guid)) or 0
                currentTicks = currentTicks + 1
                
                -- Tallennetaan uusi arvo (pakotetaan stringiksi)
                ScenEdit_SetKeyValue("Ticks_" .. ship.guid, tostring(currentTicks))
                
                -- Tarkistetaan ylittyykö raja
                if currentTicks >= requiredTicks then
                    -- Merkitään valmiiksi, jottei tätä laivaa enää lasketa
                    ScenEdit_SetKeyValue("Approached_" .. ship.guid, "Yes")
                    
                    -- ==========================================
                    -- TUNNISTUS VALMIS - TÄHÄN HALUTTU TOIMINTO!
                    -- ==========================================
                    ScenEdit_SpecialMessage(playerSide, "Lentotiedustelu vahvistaa: Alus '" .. ship.name .. "' on ollut visuaalisessa seurannassa 2 minuutin ajan.")
                    print("[Proximity Check] Aluksen " .. ship.name .. " tunnistus valmis (8 ticks).")
                else
                    -- Voidaan tulostaa debug-tietoa edistymisestä logiin (valinnainen)
                    print("[Proximity Check] Seurataan alusta " .. ship.name .. " - Progress: " .. currentTicks .. "/" .. requiredTicks)
                end
            end
        end
    end
end