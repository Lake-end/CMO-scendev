local ac={
 {3971,19905},
 {2549,9952},
 {3977,19922},
 {3974,19913},
 {2428,9926}
}

local function r(a,b)return a+math.random()*(b-a)end

local function spawn(lat,lon)
 local e=ac[math.random(#ac)]
 local id,ld=e[1],e[2]
 local hdg=r(0,359)
 local alt=r(28000,39000)
 local name="FLT"..id.."_"..math.random(100,999)

 -- Spawn aircraft with altitude included
 local u=ScenEdit_AddUnit({
  side="Neutral",
  type="Aircraft",
  dbid=id,
  loadoutid=ld,
  name=name,
  latitude=lat,
  longitude=lon,
  altitude=alt
 })

 if u then
  -- Set heading + speed
  ScenEdit_SetUnit({
   guid=u.guid,
   newheading=hdg,
   newspeed=r(420,480)
  })

  -- Compute 1000 nm waypoint
  local d=1000/60
  local wplat = lat + math.cos(math.rad(hdg))*d
  local wplon = lon + math.sin(math.rad(hdg))*d

  -- Apply waypoint using supported course API
  ScenEdit_SetUnit({
   guid=u.guid,
   course={
    {lat=wplat, lon=wplon}
   }
  })
 end
end

-- Safe North Atlantic region
local lat1,lat2,lon1,lon2=30,45,-50,-30

for i=1,20 do
 spawn(r(lat1,lat2),r(lon1,lon2))
end

ScenEdit_SpecialMessage("Neutral","20 commercial flights spawned with working waypoints.")
