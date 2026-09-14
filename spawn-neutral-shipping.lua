local t={
 {488,"Feeder"},{489,"Feedermax"},{490,"Panamax"},
 {491,"Bulk"},{492,"Tanker"},{493,"ChemTanker"},
 {494,"Fishing"},{495,"Research"},{496,"RoRo"}
}

local function r(a,b)return a+math.random()*(b-a)end

local function s(lat,lon)
 local x=t[math.random(#t)]
 local u=ScenEdit_AddUnit({
  side="Neutral",type="Ship",dbid=x[1],
  name=x[2].." "..math.random(100,999),
  latitude=lat,longitude=lon
 })
 if u then
  ScenEdit_SetUnit({
   guid=u.guid,newheading=r(0,359),newspeed=r(5,18)
  })
 end
end

local R={
 {41,59,-52,-22,8},   -- North Atlantic
 {63,71,-4,9,5},       -- Norwegian Sea
 {69,77,22,53,5},      -- Barents Sea
 {66,74,-28,-7,4},     -- Greenland Sea

 -- *** Updated Baltic Sea region (safe offshore) ***
 {55.5,58.5,14,21,4},

 {36,41,-37,-27,3},    -- Azores
 {4,7,-53,-49,3}       -- French Guiana
}

for _,v in ipairs(R)do
 for i=1,v[5]do
  s(r(v[1],v[2]),r(v[3],v[4]))
 end
end

ScenEdit_SpecialMessage("Neutral","Neutral shipping population complete.")
