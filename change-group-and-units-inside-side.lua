-- ========================================================
-- VISUAL INSPECTION & RECLASSIFICATION ENGINE V1.3
-- ========================================================
-- Varmistetaan satunnaisuuden siemennys kerran ajon alussa
math.randomseed(os.time())

-- 1. MÄÄRITELMÄTAULUKKO (Summa tasan 1.0 / 100%)
local sides = {
    {
        sideName = "side1", 
        chance = 0.10, 
        namePrefix = "Suspected shadow fleet", 
        mission = "Shadow Fleet Mission",
        intelMsg = "Vessel displays signs of ownership obfuscation, dark AIS history, or non-standard cargo transfers. Suspected sanctions-evading shadow tanker. Monitor closely for anomalous maneuvers, await further orders."
    },
    {
        sideName = "side2", 
        chance = 0.20, 
        namePrefix = "Suspicious behavior detected", 
        mission = "Suspicious Mission",
        intelMsg = "Vessel is lingering outside designated shipping lanes or possibly gathering electronic intelligence. Course history is erratic. Recommend maintaining close visual and radar contact, and prepare for potential boarding."
    },
    {
        sideName = "side3", 
        chance = 0.20, 
        namePrefix = "AI-flagged for inspection", 
        mission = "AI Flagged Mission",
        intelMsg = "NATO maritime predictive algorithms have flagged this vessel due to inconsistencies in hull draft, declared cargo, and recent port calls. Priority target for boarding or secondary inspection."
    },
    {
        sideName = "side4", 
        chance = 0.40, -- Tasoitettu 0.30 -> 0.40 jotta summa on tasan 1.0
        namePrefix = "Cleared for passage", 
        mission = "Cleared Mission",
        intelMsg = "Visual inspection and manifest verification complete. Standard commercial traffic. No hostile intent or contraband detected. Vessel cleared to proceed along planned shipping corridor."
    },
    {
        sideName = "side5", 
        chance = 0.10, 
        namePrefix = "Potential immediate threat", 
        mission = "Threat Mission",
        intelMsg = "CRITICAL: Armed personnel or specialized military-grade equipment observed on deck. Vessel is suspected of acting in direct violation of international law or regulations, suspected threat to safety of friendly infrastructure. Prepare defensive countermeasures immediately."
    }
}

-- 2. HETHERÄTTÄVÄN YKSIKÖN HAKU (Triggering Unit)
local targetUnit = ScenEdit_UnitX()

if targetUnit ~= nil then
    -- Otetaan alkuperäinen nimi ja GUID talteen
    local originalName = targetUnit.name
    local guid = targetUnit.guid
    
    -- 3. ARVOTAAN KATEGORIA (Painotettu satunnaisuus)
    local randomNumber = math.random()
    local cumulativeChance = 0
    local selectedCategory = nil
    
    for _, category in ipairs(sides) do
        cumulativeChance = cumulativeChance + category.chance
        if randomNumber <= cumulativeChance then
            selectedCategory = category
            break
        end
    end
    
    -- Varmistus: Jos pyöristysvirheen takia ei osumaa, valitaan "Cleared for passage" side (indeksi 4)
    if selectedCategory == nil then 
        selectedCategory = sides[4] 
    end

    -- 4. LUODAAN UUSI NIMI (esim. "Suspected shadow fleet 033")
    local randomShipNumber = string.format("%03d", math.random(1, 999))
    local newShipName = selectedCategory.namePrefix .. " " .. randomShipNumber

    -- 5. SUORITETAAN MUUTOKSET YKSIKÖLLE
    -- Vaihe A: Vaihdetaan puoli (Side) KÄYTTÄEN OIKEAA ERILLISTÄ FUNKTIOITA
    local sideChangeSuccess = ScenEdit_SetUnitSide({guid = guid, newside = selectedCategory.sideName})

    -- Vaihe B: Jos puolen vaihto onnistui, päivitetään nimi ja kytketään tehtävään
    if sideChangeSuccess then
        -- Vaihdetaan uusi nimi samalla toimivalla GUIDilla
        ScenEdit_SetUnit({guid = guid, name = newShipName})
        
        -- Liitetään alus kohdepuolen tehtävään käyttäen turvallista GUIDia
        local missionResult = ScenEdit_AssignUnitToMission(guid, selectedCategory.mission)
        
        -- 6. PISTEIDEN LISÄYS (NATO)
        local currentScore = ScenEdit_GetScore("NATO") or 0
        ScenEdit_SetScore("NATO", currentScore + 2, "Ship identified: " .. originalName)
        
        -- 7. RAPORTTI PELAAJALLE (Side NATO)
        local msgText = string.format(
            "Command, we have visually inspected the ship '%s' and have reclassified it as '%s'.\n\nINTEL ASSESSMENT:\n%s\n\nTake appropriate action.",
            originalName,
            newShipName,
            selectedCategory.intelMsg
        )
        ScenEdit_SpecialMessage("NATO", msgText)
        
        print("[Visual Inspection] Alkuperäinen alus '" .. originalName .. "' (GUID: " .. tostring(guid) .. ") siirretty onnistuneesti puolelle '" .. selectedCategory.sideName .. "' nimellä '" .. newShipName .. "'.")
        
        if not missionResult then
            print("[Visual Inspection VAROITUS] Aluksen siirto onnistui, mutta liittäminen tehtävään '" .. selectedCategory.mission .. "' epäonnistui! Tarkista tehtävän nimi puolella '" .. selectedCategory.sideName .. "'.")
        end
    else
        print("[Visual Inspection VIRHE] ScenEdit_SetUnitSide epäonnistui GUIDille: " .. tostring(guid) .. " (Yritetty kohdeside: " .. tostring(selectedCategory.sideName) .. ")")
    end
else
    print("[Visual Inspection VIRHE] ScenEdit_UnitX() palautti nil. Varmista että skriptiä kutsutaan eventin actionista!")
end