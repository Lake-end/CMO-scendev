-- ============================================================
--  LAKEEND.UTILS — Math, Geometry, Distance, Bearings
-- ============================================================

LAKEEND.UTILS = {}

-- Degrees to radians
function LAKEEND.UTILS.rad(deg)
    return deg * math.pi / 180
end

-- Radians to degrees
function LAKEEND.UTILS.deg(rad)
    return rad * 180 / math.pi
end

-- Haversine distance (km)
function LAKEEND.UTILS.distance(lat1, lon1, lat2, lon2)
    local R = 6371 -- Earth radius in km
    local dLat = LAKEEND.UTILS.rad(lat2 - lat1)
    local dLon = LAKEEND.UTILS.rad(lon2 - lon1)

    local a = math.sin(dLat/2)^2 +
              math.cos(LAKEEND.UTILS.rad(lat1)) *
              math.cos(LAKEEND.UTILS.rad(lat2)) *
              math.sin(dLon/2)^2

    local c = 2 * math.atan2(math.sqrt(a), math.sqrt(1-a))
    return R * c
end

-- Bearing from point A to B (degrees)
function LAKEEND.UTILS.bearing(lat1, lon1, lat2, lon2)
    local dLon = LAKEEND.UTILS.rad(lon2 - lon1)
    local y = math.sin(dLon) * math.cos(LAKEEND.UTILS.rad(lat2))
    local x = math.cos(LAKEEND.UTILS.rad(lat1)) * math.sin(LAKEEND.UTILS.rad(lat2)) -
              math.sin(LAKEEND.UTILS.rad(lat1)) * math.cos(LAKEEND.UTILS.rad(lat2)) * math.cos(dLon)
    return (LAKEEND.UTILS.deg(math.atan2(y, x)) + 360) % 360
end

-- Move a point by distance (km) and bearing (deg)
function LAKEEND.UTILS.project(lat, lon, bearing, distance)
    local R = 6371
    local br = LAKEEND.UTILS.rad(bearing)
    local d = distance / R

    local lat1 = LAKEEND.UTILS.rad(lat)
    local lon1 = LAKEEND.UTILS.rad(lon)

    local lat2 = math.asin(
        math.sin(lat1)*math.cos(d) +
        math.cos(lat1)*math.sin(d)*math.cos(br)
    )

    local lon2 = lon1 + math.atan2(
        math.sin(br)*math.sin(d)*math.cos(lat1),
        math.cos(d) - math.sin(lat1)*math.sin(lat2)
    )

    return LAKEEND.UTILS.deg(lat2), LAKEEND.UTILS.deg(lon2)
end
