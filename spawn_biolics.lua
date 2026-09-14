local ids={354,92,688,687,355}
local function r(a,b)return a+math.random()*(b-a)end

local function spawn(lat,lon)
 local id=ids[math.random(#ids)]
 local u=ScenEdit_AddUnit({
  side="Nature",type="Submarine",dbid=id,
  name="NAT"..id.."_"..math.random(100,999),
  latitude=lat,longitude=lon
 })
 if u then
  ScenEdit_SetUnit({
   guid=u.guid,newheading=r(0,359),newspeed=r(1,8)
  })
 end
end

-- Safe deep North Atlantic region
local lat1,lat2,lon1,lon2=30,40,-45,-35

for i=1,30 do
 spawn(r(lat1,lat2),r(lon1,lon2))
end

ScenEdit_SpecialMessage("Nature","Wildlife (submarine DB entries) placed in North Atlantic.")
