-- {name='D661 Admiral Louzeau (Sadral)', guid='W8V2DT-0HNBG8GJFG09V'}


-- Input the GUID of the unit you want to follow
local unitGUID = 'W8V2DT-0HNBG8GJFG09V'

-- Retrieve the unit object
local unit = ScenEdit_GetUnit({guid = unitGUID})

if unit then
    -- Extract current coordinates
    local lat = unit.latitude
    local lon = unit.longitude
    local alt = 250000 -- Hardcoded altitude in meters

    -- Set the camera view using specific arguments (as per documentation)
    UI_SetCameraView(lat, lon, alt)
    
    print("Camera focused on unit at: " .. lat .. " / " .. lon)
else
    print("Error: Unit with GUID " .. unitGUID .. " not found.")
end