-- ============================================================
--  LAKEEND.DEBUG — Map Markers, Logs, Visual Cues
-- ============================================================

LAKEEND.DEBUG = {}

-- Place a map marker
function LAKEEND.DEBUG.marker(lat, lon, text)
    ScenEdit_AddMarker({
        latitude = lat,
        longitude = lon,
        text = text or "DEBUG"
    })
    LAKEEND.log("Marker placed: " .. text)
end

-- Mark a unit's position
function LAKEEND.DEBUG.markUnit(name)
    local u = ScenEdit_GetUnit({name=name})
    if not u then
        LAKEEND.warn("Cannot mark unit: " .. name)
        return
    end

    ScenEdit_AddMarker({
        latitude = u.latitude,
        longitude = u.longitude,
        text = "UNIT: " .. name
    })

    LAKEEND.log("Unit marked: " .. name)
end

-- Draw a circle (radius km)
function LAKEEND.DEBUG.circle(lat, lon, radius)
    ScenEdit_AddCircle({
        latitude = lat,
        longitude = lon,
        radius = radius
    })
    LAKEEND.log("Circle drawn at (" .. lat .. "," .. lon .. ") r=" .. radius)
end

-- Log a table (for debugging)
function LAKEEND.DEBUG.dump(tbl)
    for k,v in pairs(tbl) do
        print("[LAKEEND DEBUG] " .. tostring(k) .. " = " .. tostring(v))
    end
end
