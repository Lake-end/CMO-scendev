-- Scenario Lua init 1 script

math.randomseed(os.time())
math.random()

scenarioZuluOffset = 0

-- =================
-- Core Functions --
-- =================

function RunScript(fileName)
	local scriptFilePath = scenarioScriptFilePath..fileName..'.lua'
	print ('Attempting to execute '..scriptFilePath)
	if ScenEdit_RunScript(scriptFilePath) then
		print ('Success!')
	end
end

function LuaReset()
	print ('Resetting...')
	ScenEdit_ClearKeyValue("")
	print ('KeyValues cleared.')
	RunScript('Game_LuaInit')
end

function NormalizeString(value, defaultIfNil)
	-- If value is nil and a default is provided, use the default
	-- Use "TRUE" or "FALSE"
	if value == nil then
		if defaultIfNil ~= nil then
			value = defaultIfNil
		else
			return nil
		end
	end

	-- Force to string
	value = tostring(value)

	-- Trim leading/trailing whitespace
	value = value:match("^%s*(.-)%s*$")

	-- Remove surrounding single or double quotes
	value = value:gsub("^['\"]+", ""):gsub("['\"]+$", "")

	-- Normalize case
	value = string.upper(value)

	return value
end

function ConvertStringToBoolean(stringName)
	if stringName == nil then
		return false
	end

	stringName = string.upper(tostring(stringName))

	if stringName == 'TRUE' or stringName == '1' then
		return true
	end

	return false
end

function FindInTable(t, value)
	for i, v in ipairs(t) do
		if v == value then
			return i
		end
	end
	return nil
end

function IsInList(list, value)
	for _, v in ipairs(list) do
		if v == value then
			return true
		end
	end
	return false
end

function IsInListTable(list, checkTableFor, value)
	for _,v in ipairs(list) do
		if v[checkTableFor] == value then
			return true
		end
	end
	return false
end

function FindInListTable(list, checkTableFor, value)
	for _,v in ipairs(list) do
		if v[checkTableFor] == value then
			return v
		end
	end
	return nil
end

function shuffleTable(tableName)
	local n = #tableName
	for i = n, 2, -1 do
		local j = math.random(i)
		tableName[i], tableName[j] = tableName[j], tableName[i]
	end
end

function IsValidDBID(unit, allowedDBIDs)
	for _, allowedDbid in ipairs(allowedDBIDs) do
		if unit.dbid == allowedDbid then
			return true
		end
	end
	return false
end

function PrintUnitsOnSide(side)
	local sideUnits = VP_GetSide({side=side}).units
	local unitList = {} -- Create a new blank Lua table to hold the units without duplicates

	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type ~= 'Group' and not unitList[unit.dbid] then
			-- Only add the unit if it is not a Group and not already in the list
			unitList[unit.dbid] = {type=unit.type, name=unit.classname}
		end
	end

	-- Print the unitList table
	for dbid,data in pairs(unitList) do
		print("["..dbid.."] = {type='"..data.type.."', name='"..data.name.."'},")
	end
end

function PrintUnitsOnSide_ByType(side, unitType)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == unitType then
			print(unit)
		end
	end
end

function PrintUnitsInRange_ByDBID(side, dbid, centerPointGUID, maxRange)
	local unitList = {}
	local sideUnits = VP_GetSide({side=side}).units

	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == dbid then
			local range = Tool_Range(centerPointGUID, unit.guid)
			if range <= maxRange then
				table.insert(unitList, unit.guid)
			end
		end
	end

	print('local unitList = {')
	for _, guid in ipairs(unitList) do
		print("	'"..guid.."',")
	end
	print('}')
end

function RoundNumber(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function RoundNumberUp(num, roundTo)
	roundTo = roundTo or 1  -- Default to rounding up to the nearest whole number if no roundTo value is provided
	return math.ceil(num / roundTo) * roundTo
end

function GetRandomRoundedNumber(min, max, roundTo)
	local randomNum = math.random(min, max)
	return math.floor((randomNum + roundTo / 2) / roundTo) * roundTo
end

function randomGaussian(mean, standardDeviation)
	-- Box-Muller transform to get a normally distributed random value
	local u1, u2
	repeat
		u1 = math.random()
	until u1 ~= 0
	repeat
		u2 = math.random()
	until u2 ~= 0
	
	local z = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
	return mean + z * standardDeviation
end

function RangeBearing(fromHere, toHere)
	local range = Tool_Range(fromHere, toHere)
	local bearing = Tool_Bearing(fromHere, toHere)
	return range, bearing
end

function CheckRangeToUnit(selectedUnit, targetUnit, maxRange)
	ScenEdit_GetUnit({guid=selectedUnit.guid})
	local range = Tool_Range(selectedUnit.guid, targetUnit.guid)
	return range <= maxRange
end

function CheckRangeToCoordinates(selectedUnit, targetLat, targetLon, maxRange)
	ScenEdit_GetUnit({guid=selectedUnit.guid})
	local targetPosition = {latitude=targetLat, longitude=targetLon}
	local range = Tool_Range(selectedUnit.guid, targetPosition)
	return range <= maxRange
end

function CheckMinRangeToCoordinates(positionLat, positionLon, targetLat, targetLon, minRange)
	local position = {latitude=positionLat, longitude=positionLon}
	local targetPosition = {latitude=targetLat, longitude=targetLon}
	local range = Tool_Range(position, targetPosition)
	return range >= minRange  -- Note: Use '>=' to check if the range is above the minimum range
end

function ConvertDecimalToCoord(latitude, longitude)
	-- Convert latitude and longitude to numbers if they are strings
	latitude = tonumber(latitude)
	longitude = tonumber(longitude)

	-- Determine if latitude is North or South
	local latDirection = "N"
	if latitude < 0 then
		latDirection = "S"
		latitude = math.abs(latitude)
	end

	-- Determine if longitude is East or West
	local lonDirection = "E"
	if longitude < 0 then
		lonDirection = "W"
		longitude = math.abs(longitude)
	end

	-- Separate degrees, minutes, and seconds for latitude
	local latDegrees = math.floor(latitude)
	local latMinutesFull = (latitude - latDegrees) * 60
	local latMinutes = math.floor(latMinutesFull)
	local latSeconds = math.floor((latMinutesFull - latMinutes) * 60) -- Rounded to no decimals

	-- Separate degrees, minutes, and seconds for longitude
	local lonDegrees = math.floor(longitude)
	local lonMinutesFull = (longitude - lonDegrees) * 60
	local lonMinutes = math.floor(lonMinutesFull)
	local lonSeconds = math.floor((lonMinutesFull - lonMinutes) * 60) -- Rounded to no decimals
	
	-- Format the result as degrees, minutes, and rounded seconds with direction
	local formattedLatitude = string.format("%d° %d' %d\" %s", latDegrees, latMinutes, latSeconds, latDirection)
	local formattedLongitude = string.format("%d° %d' %d\" %s", lonDegrees, lonMinutes, lonSeconds, lonDirection)
	
	return formattedLatitude, formattedLongitude
end

function RandomPosition(latitudeMin, latitudeMax, longitudeMin, longitudeMax)
	local lat_var = math.random(1,(10^13)) -- random number between 1 and 10^13
	local lon_var = math.random(1,(10^13)) -- random number between 1 and 10^13
	local pos_lat = math.random(latitudeMin, latitudeMax) + (lat_var/(10^13)) -- latitude; 
	local pos_lon = math.random(longitudeMin, longitudeMax) + (lon_var/(10^13)) -- longitude; 
	return {latitude=pos_lat, longitude=pos_lon}
end

function CircularRandomPosition(latitude, longitude, radius)
	local randomisationCircle = World_GetCircleFromPoint({
		latitude=latitude,
		longitude=longitude,
		radius=(math.random(0, radius*10)/10),
		numpoints = 72})
	local randomisedPoint = randomisationCircle[math.random(1,#randomisationCircle)]
	return randomisedPoint
end

function JitterPosition(guid, latitudeMin, latitudeMax, longitudeMin, longitudeMax, overWater)
	if overWater == nil then overWater = false end
	local newPos = RandomPosition(latitudeMin, latitudeMax, longitudeMin, longitudeMax)
	if OverWater(newPos.latitude, newPos.longitude) == overWater then
		ScenEdit_SetUnit({
			guid=unit.guid,
			latitude=newPos.latitude,
			longitude=newPos.longitude
		})
	end
end

function CircularJitterPosition(guid, radius, overWater)
	if overWater == nil then overWater = false end
	local newPos = CircularRandomPosition(unit.latitude, unit.longitude, radius)
	if OverWater(newPos.latitude, newPos.longitude) == overWater then
		ScenEdit_SetUnit({
			guid=unit.guid,
			latitude=newPos.latitude,
			longitude=newPos.longitude
		})
	end
end

function AddCircleOfReferencePoints(refPointside, refPointName, circle, highlightedBoolean)
	local circle = World_GetCircleFromPoint({latitude=circle.latitude, longitude=circle.longitude, radius=circle.radius, numpoints=circle.numpoints})
	for k,v in ipairs(circle) do
		ScenEdit_AddReferencePoint({side=refPointside, name=refPointName..k, latitude=v.latitude, longitude=v.longitude, highlighted=highlightedBoolean})
	end
end

function AddReferencePointAtBearingDistance(side, originPosition, bearing, distance, newReferencePointName, highlighted)
	local newPosition = World_GetPointFromBearing({latitude=originPosition.latitude, longitude=originPosition.longitude, bearing=bearing, distance=distance})
	local newReferencePoint = ScenEdit_AddReferencePoint({side=side, name=newReferencePointName, latitude=newPosition.latitude, longitude=newPosition.longitude, highlighted=highlighted})
end

function AddReferencePointAtBearingDistanceFromUnit(side, unitGUID, referencePointName, relativeToUnitHeadingBoolean, bearing, distance, bearingType, highlightedBoolean)
	local unit = ScenEdit_GetUnit({guid = unitGUID})
	local refPointBearing
	local refPointPosition

	-- Determine if the reference point bearing is relative to the unit heading
	if relativeToUnitHeadingBoolean then
		refPointBearing = unit.heading + bearing
	else
		refPointBearing = bearing
	end

	-- Add the reference point relative to the unit
	ScenEdit_AddReferencePoint({side=side, name=referencePointName, relativeTo=unitGUID, bearing=refPointBearing, distance=distance, bearingtype=bearingType, highlighted=highlightedBoolean})
end

function AddReferencePointAtUnitLocation(side, dbid, referencePointName, highlighted)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == dbid then
			ScenEdit_AddReferencePoint({side=side, name=referencePointName, latitude=unit.latitude, longitude=unit.longitude, highlighted=highlighted})
		end
	end
end

function DeleteReferencePoints_BySide(side)
	local sideRefPoints = VP_GetSide({side=side}).rps
	for k,v in ipairs(sideRefPoints) do
		ScenEdit_DeleteReferencePoint({guid=v.guid})
	end
end

function DeleteReferencePoints_ByName(side, referencePointName, numberOfReferencePoints)
	for i = 1,numberOfReferencePoints do
		ScenEdit_DeleteReferencePoint({side=side, name=referencePointName..' '..i})
	end
end

function HighlightReferencePoints_BySide(side, boolean)
	local sideRefPoints = VP_GetSide({side=side}).rps
	for k,v in ipairs(sideRefPoints) do
		ScenEdit_SetReferencePoint({side=side, guid=v.guid, highlighted=boolean})
	end
end

function SetReferencePointAtBearingDistance(side, originPosition, bearing, distance, ReferencePointName, highlighted)
	local newPosition = World_GetPointFromBearing({latitude=originPosition.latitude, longitude=originPosition.longitude, bearing=bearing, distance=distance})
	local newReferencePoint = ScenEdit_SetReferencePoint({side=side, name=ReferencePointName, latitude=newPosition.latitude, longitude=newPosition.longitude, highlighted=highlighted})
end

function SetReferencePointAtBearingDistanceFromUnit(side, unitGUID, referencePointName, relativeToUnitHeadingBoolean, bearing, distance, bearingType)
	local unit = ScenEdit_GetUnit({guid = unitGUID})
	local refPointBearing
	local refPointPosition

	-- Determine if the reference point bearing is relative to the unit heading
	if relativeToUnitHeadingBoolean then
		refPointBearing = unit.heading + bearing
	else
		refPointBearing = bearing
	end

	-- Get the new position of the reference point relative to the unit
	-- This is a temporary solution until distance/bearing issue with SetReferencePoint is fixed
	refPointPosition = World_GetPointFromBearing({latitude=unit.latitude, longitude=unit.longitude, bearing=refPointBearing, distance=distance})

	-- Set the reference point to the new position
	ScenEdit_SetReferencePoint({side=side, name=referencePointName, latitude=refPointPosition.latitude, longitude=refPointPosition.longitude, bearingtype=bearingType})
end

function GoToLatitudeLongitude(latitude, longitude, msg)
	local msg = msg
	if not msg then
		msg = 'Jumped to:<BR>Latitude: '..latitude..'<BR>Longitude: '..longitude
	end
	ScenEdit_SpecialMessage('playerside', msg, {latitude=latitude, longitude=longitude}, true)
end

function GoToReferencePoint(side, name)
	local refPoint = ScenEdit_GetReferencePoint({side=side, name=name})
	local msg = 'Jumped to Reference Point: '..refPoint.name..'<BR>Latitude: '..refPoint.latitude..'<BR>Longitude: '..refPoint.longitude
	Tool_GoToLatitudeLongitude(refPoint.latitude, refPoint.longitude, msg)
end

function BugMessage(eventName, description)
	ScenEdit_MsgBox('An issue occured with '..eventName..'.\n\n'..description..'\n\nThis will not affect system stability but may affect scenario balance.\n\nPlease report this to the scenario thread on the Matrix Games forum or to the Steam Workshop page.', 0)
end

function ChangeScore(side,amt,reason)
	local newScore = ScenEdit_GetScore(side) + amt
	ScenEdit_SetScore(side,newScore,reason)
	print (side..' score changed to '..newScore)
	return newScore
end

function OverWater(latitude, longitude)
	local pointElevation = World_GetElevation({
		latitude = latitude,
		longitude = longitude})
	if pointElevation < 0 then
		return true
	else
		return false
	end
end

function ChanceOfAppearance(guid, unitChance)
	local chance = math.random(1,100)
	if chance <= unitChance then
		ScenEdit_DeleteUnit({guid=guid})
	end
end

function GetRandomBoolean(chance)
	if math.random(1,100) <= chance then
		return true
	else
		return false
	end
end

-- ===========================
-- Communications Functions --
-- ===========================

function RadioSoundEffect()
	local fileName = 'radioChirp'..math.random(1,8)..'.mp3'
	ScenEdit_PlaySound(fileName)
end

function DTG(TimeVar)
	if TimeVar == nil then
		TimeVar = ScenEdit_CurrentTime()
	end
	local msgtime = os.date("!%d%H%M" .. "Z" .. " " .. "%b %y", TimeVar)
	local msgtime = string.upper(msgtime)
	return msgtime
end

function RegisterMessage(messageString)
	local counter = 0
	for int1 = 1, 10 do
		local storedMessage = ScenEdit_GetKeyValue('storedMessage_'..int1)
		if storedMessage ~= nil then
			counter = counter + 1
		end
	end

	if counter == 10 then
		for int2 = 1, 10 do
			local shiftedMessage = ScenEdit_GetKeyValue('storedMessage_'..int2)
			local shiftedMessageSlot = int2 - 1
			ScenEdit_SetKeyValue('storedMessage_'..shiftedMessageSlot, shiftedMessage)
		end
		messageNumber = 10
	elseif counter <= 9 then
		messageNumber = counter + 1
	elseif counter == 0 then
		messageNumber = 1
	end
	ScenEdit_SetKeyValue('storedMessage_'..messageNumber, messageString)	
end

function ReplayMessages()
	for i = 10,1,-1 do
		local message = ScenEdit_GetKeyValue('storedMessage_'..i)
		if message ~= nil and message ~= '' then
			ScenEdit_SpecialMessage('playerside', message)
		end
	end
end

function RadioMessage(band, frequency, theMessage, location)
	assert(theMessage, 'RadioMessage(): No message passed!')

	-- Generate the radio message body with formatted text
	local formattedMessage = '<P><I>"'..theMessage..'"</I></P> '
	local DTG = DTG()
	local theRadioMessage = '<P>'..DTG..'<BR>'..band..'<BR>'..frequency..'</P>'..formattedMessage

	-- Send the message with or without location information
	if location ~= nil then
		ScenEdit_SpecialMessage('playerside', theRadioMessage, {latitude=location.latitude, longitude=location.longitude})
	else
		ScenEdit_SpecialMessage('playerside', theRadioMessage)
	end

	-- Register the message and play sound
	RegisterMessage(theRadioMessage)
	RadioSoundEffect()
end

function Signal(precedence, time, code, sender, recipient, classification, subject, body)
	-- Precedence -- Flash (Z), Immediate (O), Priority (P), Routine (R), Flash Override (Y)
	-- From -- e.g. MET FLT OPS
	-- To -- e.g. SSN 21 SEAWOLF
	-- Classification -- Unclas +/- SBU / FOUO / NOFORN (Restricted), Confidential, Secret, Top Secret
	-- Body
	local msg_time
	if time == nil then
		msg_time = DTG()
	else
		msg_time = time
	end
	local signal_string = string.upper('<P><FONT face=Courier New>'
		..precedence.. ' <BR>'
		..code..' '..msg_time.. ' <BR>' ..
		'FM '..sender..' <BR>' .. 
		'TO '..recipient..' <BR>'
		..classification..' <BR>' ..
		'SUBJ: '..subject..'</P>' ..
		'<P>'..body..'</P>'
	)
	return signal_string
end

function TelexMessageToPlayer(precedence, time, code, sender, recipient, classification, subject, body, location)
	local theMessage = Signal(precedence, time, code, sender, recipient, classification, subject, body)
	if location ~= nil then
		ScenEdit_SpecialMessage('playerside', theMessage, {latitude=location.latitude, longitude=location.longitude})
	else
		ScenEdit_SpecialMessage('playerside', theMessage)
	end
	ScenEdit_PlaySound('telex.mp3')
	RegisterMessage(theMessage)
end

-- ====================
-- Weather Functions --
-- ====================

function RandomTemperature(meanMinTemp, meanMaxTemp, absoluteMinTemp, absoluteMaxTemp, outlierChance, outlierTemp, normalTemp)
	-- Randomly choose mean temperature within given ranges
	local meanTemp = meanMinTemp + (meanMaxTemp - meanMinTemp) * math.random()

	-- Determine if temperature is an outlier
	local outlierBoolean = (math.random(100) <= outlierChance)

	-- Choose appropriate deviation based on outlier condition
	local tempDeviation = outlierBoolean and outlierTemp or normalTemp

	-- Generate raw Gaussian-distributed temperature
	local tempVariability = randomGaussian(meanTemp, tempDeviation)

	-- Clamp values to absolute min and max
	local newTemp = math.floor(math.max(absoluteMinTemp, math.min(tempVariability, absoluteMaxTemp)) + 0.5)

	return newTemp
end

function RandomUndercloud(meanMinUndercloud, meanMaxUndercloud, absoluteMinUndercloud, absoluteMaxUndercloud, outlierChance, outlierUndercloud, normalUndercloud)
	-- Randomly choose mean undercloud within given ranges
	local meanUndercloud = meanMinUndercloud + (meanMaxUndercloud - meanMinUndercloud) * math.random()

	-- Determine if undercloud coverage is an outlier
	local outlierBoolean = (math.random(100) <= outlierChance)

	-- Choose appropriate deviation based on outlier condition
	local undercloudDeviation = outlierBoolean and outlierUndercloud or normalUndercloud

	-- Generate raw Gaussian-distributed undercloud coverage
	local undercloudVariability = randomGaussian(meanUndercloud, undercloudDeviation)

	-- Clamp values to absolute min and max (both presumably between 0 and 1)
	local newUndercloud = math.floor(math.max(absoluteMinUndercloud, math.min(undercloudVariability, absoluteMaxUndercloud)))/10

	return newUndercloud
end

function RandomRainfall(meanMinRainfall, meanMaxRainfall, absoluteMinRainfall, absoluteMaxRainfall, outlierChance, outlierRainfall, normalRainfall, undercloud)
	-- Randomly choose mean rainfall within given ranges
	local meanRainfall = meanMinRainfall + (meanMaxRainfall - meanMinRainfall) * math.random()

	-- Determine if rainfall is an outlier
	local outlierBoolean = (math.random(100) <= outlierChance)

	-- Choose appropriate deviation based on outlier condition
	local rainfallDeviation = outlierBoolean and outlierRainfall or normalRainfall

	-- Generate raw Gaussian-distributed rainfall
	local rainfallVariability = randomGaussian(meanRainfall, rainfallDeviation)

	-- Clamp values to absolute min and max
	local newRainfall = math.floor(math.max(absoluteMinRainfall, math.min(rainfallVariability, absoluteMaxRainfall)) + 0.5)

	if undercloud <= 0.2 then
		newRainfall = 0 -- No rain if undercloud is too low
	end

	return newRainfall
end

function RandomSeastate(meanMinSeastate, meanMaxSeastate, absoluteMinSeastate, absoluteMaxSeastate, outlierChance, outlierSeastate, normalSeastate)
	-- Randomly choose mean seastate within given ranges
	local meanSeastate = meanMinSeastate + (meanMaxSeastate - meanMinSeastate) * math.random()

	-- Determine if seastate is an outlier
	local outlierBoolean = (math.random(100) <= outlierChance)

	-- Choose appropriate deviation based on outlier condition
	local seastateDeviation = outlierBoolean and outlierSeastate or normalSeastate

	-- Generate raw Gaussian-distributed seastate
	local seastateVariability = randomGaussian(meanSeastate, seastateDeviation)

	-- Clamp values to absolute min and max
	local newSeastate = math.floor(math.max(absoluteMinSeastate, math.min(seastateVariability, absoluteMaxSeastate)) + 0.5)

	return newSeastate
end

function ForecastTemperature(currentTemp, latitude, longitude, intervalMultiplier, minTemp, maxTemp)
	-- Temperature variability is set by time of day
	-- intervalMultiplier is used to adjust temperature change for frequency of event execution
	-- Use lower value (1) for more frequent execution and higher (2-3) for less frequent
	local timeOfDay = ScenEdit_GetTimeOfDay({latitude=latitude, longitude=longitude})
	local tempVariability
	if timeOfDay.TOD == 'dawn' then
		tempVariability = math.random(0,1) * intervalMultiplier
	elseif timeOfDay.TOD == 'day' then
		tempVariability = math.random(0,2) * intervalMultiplier
	elseif timeOfDay.TOD == 'dusk' then
		tempVariability = math.random(-1,0) * intervalMultiplier
	else -- Time of Day = Night
		tempVariability = math.random(-2,0) * intervalMultiplier
	end

	-- Calculate new temperature and enforce min/max limits
	local newTemp = currentTemp + tempVariability
	newTemp = math.max(minTemp, math.min(newTemp, maxTemp)) -- Sets temperature within min/max temperature range

	return newTemp
end

function ForecastUndercloud(currentUndercloud, chanceOfClouds, cloudVariabilityChance, maxUndercloud)
	local newUndercloud
	if math.random(1,100) <= chanceOfClouds then
		newUndercloud = math.max(0, math.min(currentUndercloud + math.random(0,3)/10, maxUndercloud)) -- Increase undercloud
	else
		if math.random(1,100) <= cloudVariabilityChance then
			newUndercloud = math.max(0, math.min(currentUndercloud + math.random(-3,0)/10, maxUndercloud)) -- Decrease undercloud
		else
			newUndercloud = currentUndercloud
		end
	end

	return newUndercloud
end

function ForecastRainfall(currentRainfall, chanceOfRain, undercloud, rainfallVariabilityChance, maxRainfall)
	local newRainfall
	if math.random(1,100) <= chanceOfRain then
		newRainfall = math.max(0, math.min(currentRainfall + math.random(0,3), maxRainfall)) -- Increase rainfall
		if undercloud <= 0.2 then
			newRainfall = 0 -- No rain if cloud cover is too low
		end
	else
		if math.random(1,100) <= rainfallVariabilityChance then
			newRainfall = math.max(0, math.min(currentRainfall + math.random(-3,0), maxRainfall)) -- Decrease rainfall
		else
			newRainfall = currentRainfall
		end
	end

	return newRainfall
end

function ForecastSeastate(currentSeastate, chanceOfWind, windVariabilityChance, maxSeastate)
	local newSeastate
	if math.random(1,100) <= chanceOfWind then
		newSeastate = math.max(0, math.min(currentSeastate + math.random(0,2), maxSeastate)) -- Increase seastate/wind
	else
		if math.random(1,100) <= windVariabilityChance then
			newSeastate = math.max(0, math.min(currentSeastate + math.random(-2,0), maxSeastate)) -- Decrease seastate/wind
		else
			newSeastate = currentSeastate
		end
	end

	return newSeastate
end

function GlobalWeatherDrift(latitude, longitude, intervalMultiplier, minTemp, maxTemp, chanceOfClouds, cloudVariabilityChance, maxUndercloud, chanceOfRain, rainfallVariabilityChance, maxRainfall, chanceOfWind, windVariabilityChance, maxSeastate)
	-- Latitude and Longitude should be set to the approximate center of scenarios Operations 
	-- chanceOfClouds, chanceOfRain, and chanceOfWind are the chances for the weather effect to increase
	-- cloudVariabilityChance, rainfallVariabilityChance, and windVariabilityChance are the chance of the weather effect to remain the same or decrease if it does not increase
	-- minTemp, maxTemp, maxUndercloud, maxRainfall, and maxSeastate set the minimum and maximum for their weather effect

	-- Get the current weather to use as a baseline and set new weather conditions
	local weatherBaseline = ScenEdit_GetWeather()
	local newTemp = ForecastTemperature(weatherBaseline.temp, latitude, longitude, intervalMultiplier, minTemp, maxTemp)
	local newUndercloud = ForecastUndercloud(weatherBaseline.undercloud, chanceOfClouds, cloudVariabilityChance, maxUndercloud)
	local newRainfall = ForecastRainfall(weatherBaseline.rainfall, chanceOfRain, newUndercloud, rainfallVariabilityChance, maxRainfall)
	local newSeastate = ForecastSeastate(weatherBaseline.seastate, chanceOfWind, windVariabilityChance, maxSeastate)

	-- Update global weather conditions
	ScenEdit_SetWeather(
		newTemp, -- temp
		newRainfall, -- rainfall
		newUndercloud, -- undercloud
		newSeastate -- seastate
	)
end

function CustomEnviromentalZoneWeatherDrift(ListOfCustomEnvironmentZones)
	-- Latitude and Longitude should be set to the approximate center of scenarios Operations 
	-- chanceOfClouds, chanceOfRain, and chanceOfWind are the chances for the weather effect to increase
	-- cloudVariabilityChance, rainfallVariabilityChance, and windVariabilityChance are the chance of the weather effect to remain the same or decrease if it does not increase
	-- minTemp, maxTemp, maxUndercloud, maxRainfall, and maxSeastate set the minimum and maximum for their weather effect

	-- Check for Custom Environment Zones on the Nature side then iterate through the ListOfCustomEnvironmentZones
	-- ListOfCustomEnvironmentZones links zone to the specific zone variables
	local side = VP_GetSide({name='Nature'})
	for _,zone in ipairs(ListOfCustomEnvironmentZones) do
		-- Get zone weather to use as a baseline and set new weather conditions
		local currentZone = side:getcustomenvironmentzone(zone.guid)
		local weatherBaseline = currentZone.weatherprofile
		local newTemp = ForecastTemperature(weatherBaseline.temp, zone.latitude, zone.longitude, zone.intervalMultiplier, zone.minTemp, zone.maxTemp)
		local newUndercloud = ForecastUndercloud(weatherBaseline.undercloud, zone.chanceOfClouds, zone.cloudVariabilityChance, zone.maxUndercloud)
		local newRainfall = ForecastRainfall(weatherBaseline.rainfall, zone.chanceOfRain, newUndercloud, zone.rainfallVariabilityChance, zone.maxRainfall)
		local newSeastate = ForecastSeastate(weatherBaseline.seastate, zone.chanceOfWind, zone.windVariabilityChance, zone.maxSeastate)

		-- Update zone weather conditions
		currentZone.weatherprofile = {
			temp = newTemp,
			rainfall = newRainfall,
			undercloud = newUndercloud,
			seastate = newSeastate
		}
	end
end

function SetCustomEnviromentalZoneWeather(ListOfCustomEnvironmentZones)
	-- Used to inject weather generated outside of function into Custom Environment Zones
	-- Example Usage - Forcast weather report before setting weather or set random weather conditions

	-- Check for Custom Environment Zones on the Nature side then iterate through the ListOfCustomEnvironmentZones
	-- ListOfCustomEnvironmentZones links zone to the specific zone variables
	local side = VP_GetSide({name='Nature'})
	for _,zone in ipairs(ListOfCustomEnvironmentZones) do
		-- Get zone GUID and set new weather conditions
		local currentZone = side:getcustomenvironmentzone(zone.guid)
		local newTemp = zone.temp
		local newUndercloud = zone.undercloud
		local newRainfall = zone.rainfall
		local newSeastate = zone.seastate

		-- Update weather conditions
		currentZone.weatherprofile = {
			temp = newTemp,
			rainfall = newRainfall,
			undercloud = newUndercloud,
			seastate = newSeastate
		}
	end
end

-- ===========================
-- Weather Report Functions --
-- ===========================

function GenerateRainDescriptor(rain)
	local result 
	if rain == 0 then  result = 'NO'
		elseif rain < 5 then  result = 'VERY LIGHT'
		elseif rain < 11 then  result = 'LIGHT'
		elseif rain < 20 then  result = 'MODERATE'
		elseif rain < 30 then  result = 'HEAVY'
		elseif rain < 40 then  result = 'VERY HEAVY'
		else  result = 'EXTREME'
	end
	return result
end

function GenerateCloudDescriptor(cloud)
	local result
	if cloud == 0 then  result = 'CLEAR SKIES'
		elseif cloud < 0.2 then result = 'LIGHT LOW CLOUDS'
		elseif cloud < 0.3 then result = 'LIGHT MIDDLE CLOUDS'
		elseif cloud < 0.4 then result = 'LIGHT HIGH CLOUDS'
		elseif cloud < 0.5 then result = 'MODERATE LOW CLOUDS'
		elseif cloud < 0.6 then result = 'MODERATE MIDDLE CLOUDS'
		elseif cloud < 0.7 then result = 'MODERATE HIGH CLOUDS'
		elseif cloud < 0.8 then result = 'MODERATE MIDDLE CLOUDS AND LIGHT HIGH CLOUDS'
		elseif cloud < 0.9 then result = 'SOLID MIDDLE CLOUDS AND MODERATE HIGH CLOUDS'
		elseif cloud < 1.0 then result = 'THIN FOG AND SOLID CLOUD COVER'
		else result = 'THICK FOG AND SOLID CLOUD COVER'
	end
	return result
end

function ConvertTempCtoF(temp)
	local result = RoundNumber((temp*1.8) + 32,0)
	return result
end

function WeatherReport(globalWeatherRegion, weatherUpdateBoolean, timeToNextUpdateInSeconds)
	-- Get the current global weather and generate descriptions
	local weather = ScenEdit_GetWeather()
	local globalUndercloud = GenerateCloudDescriptor(weather.undercloud)
	local globalRainfall = GenerateRainDescriptor(weather.rainfall)
	local globalSeastate = weather.seastate
	local globalTempC = weather.temp
	local globalTempF = ConvertTempCtoF(weather.temp)

	-- Add global weather to weather report message
	local message = globalWeatherRegion..': '..globalUndercloud..'. '..globalRainfall..' PRECIPITATION. SEA STATE '..globalSeastate..'. AVERAGE TEMPERATURE '..globalTempC..'C / '..globalTempF..'F.<BR><BR>'

	-- Check for Custom Environment Zones on the Nature side and append each CEZs weather to weather report message
	-- If there are no CEZs then only global weather will be reported
	local side = VP_GetSide({name='Nature'})
	if side and side.customenvironmentzones then
		for _,zone in ipairs(side.customenvironmentzones) do
			-- Get the current weather in CEZ and generate descriptions
			local currentZone = side:getcustomenvironmentzone(zone.guid)
			local weatherBaseline = currentZone.weatherprofile
			local zoneUndercloud = GenerateCloudDescriptor(weatherBaseline.undercloud)
			local zoneRainfall = GenerateRainDescriptor(weatherBaseline.rainfall)
			local zoneSeastate = weatherBaseline.seastate
			local zoneTempC = weatherBaseline.temp
			local zoneTempF = ConvertTempCtoF(weatherBaseline.temp)

			-- Add CEZ weather to the weather report message
			message = message..zone.description..': '..zoneUndercloud..'. '..zoneRainfall..' PRECIPITATION. SEA STATE '..zoneSeastate..'. AVERAGE TEMPERATURE '.. zoneTempC..'C / '..zoneTempF..'F.<BR><BR>'
		end
	end

	-- Optionally  append next weather update to the weather report message
	-- Use true automated messages
	-- Use false for player special actions to retrieve current weather
	if weatherUpdateBoolean == true then
		local nextUpdate
		if timeToNextUpdateInSeconds == nil then 
			nextUpdate = 'NEXT UPDATE AT ' .. DTG(ScenEdit_CurrentTime() + 10800) -- Default: Current Time + 10,800 seconds (3 hours)
		else
			nextUpdate = 'NEXT UPDATE AT ' .. DTG(ScenEdit_CurrentTime() + timeToNextUpdateInSeconds)
		end
		message = message..nextUpdate
	end

	-- Send the weather report to the player
	TelexMessageToPlayer(
		'ROUTINE',
		nil,
		'R',
		'METOPS',
		'ALL STATIONS',
		'UNCLAS',
		'WEATHER REPORT',
		message,
		nil
	)
end

function WeatherForecast(globalWeatherRegion, globalUndercloudForecast, globalRainfallForecast, globalSeastateForecast, globalMinTempForecast, globalMaxTempForecast, ListOfCustomEnvironmentZones, weatherUpdateBoolean, timeToNextUpdateInSeconds)
	-- Get the current global weather and generate descriptions
	local globalundercloud = GenerateCloudDescriptor(globalUndercloudForecast)
	local globalrainfall = GenerateRainDescriptor(globalRainfallForecast)
	local globalSeastate = globalSeastateForecast
	local globalMinTempC = globalMinTempForecast
	local globalMaxTempC = globalMaxTempForecast
	local globalMinTempF = ConvertTempCtoF(globalMinTempForecast)
	local globalMaxTempF = ConvertTempCtoF(globalMaxTempForecast)

	-- Add global weather to weather report message
	local message = globalWeatherRegion..': '..globalundercloud..'. '..globalrainfall..' PRECIPITATION. SEA STATE '..globalSeastate..'. AVERAGE LOW '..globalMinTempC..'C / '..globalMinTempF..'F AND An AVERAGE HIGH OF '..globalMaxTempC..'C / '..globalMaxTempF..'F.<BR><BR>'

	-- Check for Custom Environment Zones on the Nature side then iterate through the ListOfCustomEnvironmentZones
	-- ListOfCustomEnvironmentZones links zone to the specific zone variables
	-- If there are no CEZs then only global weather will be reported
	local side = VP_GetSide({name='Nature'})
	if side and side.customenvironmentzones then
		for _,zone in ipairs(ListOfCustomEnvironmentZones) do
			-- Get the current weather in CEZ and generate descriptions
			local zoneUndercloud = GenerateCloudDescriptor(zone.undercloud)
			local zoneRainfall = GenerateRainDescriptor(zone.rainfall)
			local zoneSeastate = zone.seastate
			local zoneMinTempC = zone.minTemp
			local zoneMaxTempC = zone.maxTemp
			local zoneMinTempF = ConvertTempCtoF(zone.minTemp)
			local zoneMaxTempF = ConvertTempCtoF(zone.maxTemp)

			-- Add CEZ weather to the weather report message
			message = message..zone.description..': '..zoneUndercloud..'. '..zoneRainfall..' PRECIPITATION. SEA STATE '..zoneSeastate..'. AVERAGE LOW '..zoneMinTempC..'C / '..zoneMinTempF..'F AND An AVERAGE HIGH OF '..zoneMaxTempC..'C / '..zoneMaxTempF..'F.<BR><BR>'
		end
	end

	-- Optionally  append next weather update to the weather report message
	-- Use true automated messages
	-- Use false for player special actions to retrieve current weather
	if weatherUpdateBoolean == true then
		local nextUpdate
		if timeToNextUpdateInSeconds == nil then 
			nextUpdate = 'NEXT UPDATE AT ' .. DTG(ScenEdit_CurrentTime() + 10800) -- Default: Current Time + 10,800 seconds (3 hours)
		else
			nextUpdate = 'NEXT UPDATE AT ' .. DTG(ScenEdit_CurrentTime() + timeToNextUpdateInSeconds)
		end
		message = message..nextUpdate
	end

	-- Send the weather report to the player
	TelexMessageToPlayer(
		'ROUTINE',
		nil,
		'R',
		'METOPS',
		'ALL STATIONS',
		'UNCLAS',
		'WEATHER FORECAST',
		message,
		nil
	)
end

function TimeIs(timeVar)
	if timeVar == nil then timeVar = ScenEdit_CurrentTime() end
	local timeStampTable = os.date("!*t",timeVar)
	local timeTable = {day = timeStampTable.day, 
		hour = timeStampTable.hour, 
		minute = timeStampTable.min}
	return timeTable
end

function WeatherReportIsDue(reportInterval)
	local result = false
	local hourZulu = TimeIs().hour
	local hourLocal = hourZulu + scenarioZuluOffset
	if hourLocal % reportInterval == 0 then
		result = true
	end

	return result
end

-- ==========================
-- Downed Pilot Generation --
-- ==========================

function DetermineTypeOfPilotSurvivor(latitude, longitude, survivalChance)
	local survivorType = 'Facility'
	local survivorDBID = 2046 -- Stranded Personnel (1x)

	local survived = PilotSurvives(survivalChance)

	if OverWater(latitude, longitude) then
		survivorType = 'Ship'
		if survived then
			local liferaftOptions = {3725, 4877} -- 1.8m Life Raft Single Person [Aircrew Survival Raft]; Person in Water, Alive
			survivorDBID = liferaftOptions[math.random(#liferaftOptions)]
		else
			survivorDBID = 4878 -- Person in Water, Deceased
		end
	else
		if not survived then
			survivorDBID = 2441 -- Stranded Personnel (1x), Immobile
		end
	end

	return {type=survivorType, dbid=survivorDBID}
end

function PlacePilotSurvivor(side, latitude, longitude, survivalChance)
	local randomPosition = CircularRandomPosition(latitude, longitude, 2)
	local survivorData = DetermineTypeOfPilotSurvivor(randomPosition.latitude, randomPosition.longitude, survivalChance)
	local survivor = ScenEdit_AddUnit({
		side=side,
		type=survivorData.type,
		dbid=survivorData.dbid,
		name='Downed Aircrew',
		latitude=randomPosition.latitude,
		longitude=randomPosition.longitude
	})

	table.insert(SurvivorList, survivor)
end

function RandomBailoutString()
	local damagePrefixes = {
		"I've lost control!",
		"They got me!",
		"Taking hits!",
		"I'm hit!",
		"Flight controls are gone!",
		"Taking heavy fire!",
		"...",
	}

	local bailoutSuffixes = {
		"Going in!",
		"Going down!",
		"Eject, eject, eject!!!",
		"I can't hold it together!",
		"Bailing out!",
		"...",
	}

	local result = damagePrefixes[math.random(1,#damagePrefixes)]..' '..bailoutSuffixes[math.random(1,#bailoutSuffixes)]
	return result
end

function BailoutMessage(name, latitude, longitude)
	local theMessage = RandomBailoutString()
	RadioMessage('VHF', '243 MHz', theMessage, {latitude=latitude, longitude=longitude})
end

function PilotSurvives(survivalChance)
	if math.random(1,100) <= survivalChance then
		return true
	else
		return false
	end
end

function GenerateDownPilot(DestroyedUnitName, side, latitude, longitude, survivalChance, numberOfCrew)
	for i = 1,numberOfCrew do
		if PilotSurvives(survivalChance) then
			PlacePilotSurvivor(side, latitude, longitude, survivalChance)
		end
	end

	BailoutMessage(DestroyedUnitName, latitude, longitude)
end

-- ==========================
-- Ship Suvivor Generation --
-- ==========================

function DetermineTypeOfLifeRaft()
	local survivorTypeOptions = {
		{dbid=2552, name='Life Raft [10m]'}, -- Civilian Life Raft [10m]
		{dbid=2553, name='Life Raft [5m]'} -- Life Raft [5m]
	}

	local survivorType = survivorTypeOptions[math.random(#survivorTypeOptions)]
	return {dbid=survivorType.dbid, name=survivorType.name}
end

function DetermineTypeOfPersonInWater()
	local survivorTypeOptions = {
		{dbid=4877, name='Person in Water (Alive)'}, -- Person in Water, Alive
		{dbid=4878, name='Person in Water (Deceased)'} -- Person in Water, Deceased
	}

	local survivorType = survivorTypeOptions[math.random(#survivorTypeOptions)]
	return {dbid=survivorType.dbid, name=survivorType.name}
end

function PlaceShipSurvivor(side, latitude, longitude, survivorType)
	local randomPosition = CircularRandomPosition(latitude, longitude, 2)
	local survivorData

	if survivorType == 'Life Raft' then
		survivorData = DetermineTypeOfLifeRaft()
	else
		survivorData = DetermineTypeOfPersonInWater()
	end

	local survivor = ScenEdit_AddUnit({
		side=side,
		type='Ship',
		dbid=survivorData.dbid,
		name=survivorData.name,
		latitude=randomPosition.latitude,
		longitude=randomPosition.longitude
	})

	table.insert(SurvivorList, survivor)
end

function AbandonShipMessage(name, latitude, longitude, numberOfCrew)
	local shipName = string.upper(name)
	local shipLatitude, shipLongitude = ConvertDecimalToCoord(latitude, longitude)
	local messageChance = math.random(1,100)
	local radioBand
	local radioFrequencyOptions
	local radioFrequency
	local theMessage

	if messageChance <= 50 then -- Radio Mayday message
		radioBand = 'HF'
		radioFrequencyOptions = {'4125 KHz', '6215 KHz', '8291 KHz', '12290 KHz'}
		radioFrequency = radioFrequencyOptions[math.random(#radioFrequencyOptions)]
		theMessage = 'MAYDAY, MAYDAY, MAYDAY.<BR>THIS IS ' .. shipName .. ', ' .. shipName .. ', ' .. shipName .. '.<BR>MAYDAY ' .. shipName .. '. <BR>MY POSITION IS ' .. shipLatitude .. ', ' .. shipLongitude .. '.<BR>WE ARE SINKING.<BR>I REQUIRE IMMEDIATE ASSISTANCE.<BR>WE HAVE ' .. numberOfCrew .. ' PERSONS ON BOARD.<BR>WE ARE ABANDONING THE SHIP.<BR>OVER.'
	else -- EPIRB beacon message
		radioBand = 'VHF'
		radioFrequencyOptions = {'1021', '1023', '1082', '1083'}
		radioFrequency = 'CHANNEL '..radioFrequencyOptions[math.random(#radioFrequencyOptions)]
		theMessage = 'THIS IS THE RCC.<BR><BR>AN EPIRB DISTRESS MESSAGE HAS BEEN RECEIVED FROM THE ' .. shipName .. '.<BR><BR>REPORTED POSITION IS ' .. shipLatitude .. ', ' .. shipLongitude .. '.'
	end

	RadioMessage(radioBand, radioFrequency, theMessage, {latitude=latitude, longitude=longitude})
end

function GenerateShipSurvivors(DestroyedUnitName, side, latitude, longitude, numberOfCrew)
	for i = 1,math.random(10,20) do -- Randomize the number of life raft survivors
		PlaceShipSurvivor(side, latitude, longitude, 'Life Raft')
	end

	for i = 1,math.random(10,30) do -- Randomize the number of person in water survivors
		PlaceShipSurvivor(side, latitude, longitude, 'Person in Water')
	end

	AbandonShipMessage(DestroyedUnitName, latitude, longitude, numberOfCrew)
end

-- ==============================
-- Search and Rescue Functions --
-- ==============================

function GenerateListOfSurvivorUnits(side)
	local unitsList = {}
	local sideUnits = VP_GetSide({side=side}).units

	-- List of possible survivor units to be recovered
	local SurvivorUnitList = {
		{type='Facility', dbid=2046}, -- Stranded Personnel
		{type='Facility', dbid=2046}, -- Stranded Personnel, Immobile
		{type='Ship', dbid=3725}, -- 1.8m Life Raft Single Person [Aircrew Survival Raft]
		{type='Ship', dbid=2552}, -- Civilian Life Raft [10m]
		{type='Ship', dbid=2553}, -- Life Raft [5m]
		{type='Ship', dbid=4877}, -- Person in Water, Alive
		{type='Ship', dbid=4878}, -- Person in Water, Deceased
	}

	for _,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})

		for _,survivor in ipairs(SurvivorUnitList) do
			if unit.type == survivor.type and unit.dbid == survivor.dbid then
				table.insert(unitsList, unit)
				break
			end
		end
	end

	return unitsList
end

function UnitIsCapableOfRescue(unit)
	local UnitList = nil

	if unit.type == 'Aircraft' then
		UnitList = RescueCapableUnits.Aircraft
	elseif unit.type == 'Ship' then
		UnitList = RescueCapableUnits.Ship
	elseif unit.type == 'Submarine' then
		UnitList = RescueCapableUnits.Submarine
	elseif unit.type == 'Facility' then
		UnitList = RescueCapableUnits.Facility
	end

	if not UnitList then return false end

	for _,dbid in ipairs(UnitList) do
		if unit.dbid == dbid then
			return true
		end
	end

	return false
end

function GenerateListOfRescueUnits()
	local unitsList = {}
	local playerSide = ScenEdit_PlayerSide()
	local sideUnits = VP_GetSide({side=playerSide}).units
	for _,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if UnitIsCapableOfRescue(unit) then
			table.insert(unitsList, unit)
		end
	end

	return unitsList
end

function GetListOfRescueUnitsNearSurvivors(survivorGUID, maximumRescueDistance)
	local unitsList = {}
	local survivorUnit = ScenEdit_GetUnit({guid=survivorGUID})

	if survivorUnit then
		for _,v in ipairs(RescueCapableUnitList) do
			local rescuerUnit = ScenEdit_GetUnit({guid=v.guid})

			if rescuerUnit and Tool_Range(survivorGUID, rescuerUnit.guid) <= maximumRescueDistance then 
				table.insert(unitsList, rescuerUnit)
			end
		end
	end

	return unitsList
end

function ReturnUnitAltitudeAGL(guid)
	local unit = ScenEdit_GetUnit({guid=guid})
	local altitudeAboveSeaLevel, terrainElevation = unit.altitude, World_GetElevation({latitude=unit.latitude, longitude=unit.longitude})
	if terrainElevation < 0 then terrainElevation = 0 end
	local altitudeAboveGround = altitudeAboveSeaLevel - terrainElevation
	return altitudeAboveGround
end

function RescuerIsCloseEnoughToRescueSurvivor(survivorGUID, rescuerGUID, maximumRescueDistance)
	if survivorGUID and rescuerGUID then
		local rangeNMi = Tool_Range(survivorGUID, rescuerGUID)
		if rangeNMi < maximumRescueDistance then
			return true
		else
			return false
		end
	else
		return false
	end
end

function AirUnitIsWithinRescueParams(survivorGUID, rescuerGUID)
	local unit = ScenEdit_GetUnit({guid=rescuerGUID})
	local unitAltitude = ReturnUnitAltitudeAGL(rescuerGUID)
	if RescuerIsCloseEnoughToRescueSurvivor(survivorGUID, rescuerGUID, 1) and unitAltitude <= 75 and unit.speed <= 0 then
		return true
	else
		return false
	end
end

function ShipOrSubmarineIsWithinRescueParams(survivorGUID, rescuerGUID)
	local unit = ScenEdit_GetUnit({guid=rescuerGUID})
	if RescuerIsCloseEnoughToRescueSurvivor(survivorGUID, rescuerGUID, 1) and unit.altitude >= -20 and unit.speed <= 6 then
		return true
	else
		return false
	end
end

function UnitIsEligibleToRescue(survivorGUID, rescuerGUID)
	local unit = ScenEdit_GetUnit({guid=rescuerGUID})
	if unit then
		if unit.type == 'Ship' or unit.type == 'Submarine' then
			return ShipOrSubmarineIsWithinRescueParams(survivorGUID, unit.guid)
		elseif unit.type == 'Aircraft' then
			return AirUnitIsWithinRescueParams(survivorGUID, unit.guid)
		elseif unit.type == 'Facility' then
			return true
		end
	end

	return false
end

function PerformRescue(survivorGUID, rescuerGUID)
	local rescuedUnit = ScenEdit_GetUnit({guid=survivorGUID})
	local rescuer = ScenEdit_GetUnit({guid=rescuerGUID})
	local playerSide = ScenEdit_PlayerSide()

	for i = #SurvivorList, 1, -1 do
		if SurvivorList[i].guid == survivorGUID then
			table.remove(SurvivorList, i)
			break
		end
	end

	ScenEdit_DeleteUnit({guid=survivorGUID})
	ChangeScore(playerSide, 50, rescuedUnit.name..' was rescued.')
	local theMessage = "We've rescued "..rescuedUnit.name.."."
	RadioMessage('VHF', '282.8 MHz', theMessage, {latitude=rescuedUnit.latitude, longitude=rescuedUnit.longitude})
end

function AttemptRescue(rescueChance)
	local rescuePerformed = {}

	for _,survivor in ipairs(SurvivorList) do
		if ScenEdit_GetUnit({guid=survivor.guid}) then
			local ListOfRescueUnitsNearSurvivors = GetListOfRescueUnitsNearSurvivors(survivor.guid, 1)
			for _,nearbyUnit in ipairs(ListOfRescueUnitsNearSurvivors) do
				if not rescuePerformed[nearbyUnit.guid] then
					if UnitIsEligibleToRescue(survivor.guid, nearbyUnit.guid) and math.random(1,100) <= rescueChance then
						PerformRescue(survivor.guid, nearbyUnit.guid)
						rescuePerformed[nearbyUnit.guid] = true
					end
				end
			end
		end
	end
end

-- ====================
-- Survivor Captured --
-- ====================

function SurvivorCaptured(evasionChance)
	local playerSide = ScenEdit_PlayerSide()
	for _,survivor in ipairs(SurvivorList) do
		if survivor.type == 'Facility' and survivor.dbid == 2046 and math.random(1,100) >= evasionChance then -- Only checks for Downed Pilots on land, can be modified for other survivor types if required
			for i = #SurvivorList, 1, -1 do
				if SurvivorList[i].guid == survivor.guid then
					table.remove(SurvivorList, i)
					break
				end
			end

			ScenEdit_DeleteUnit({guid=survivor.guid})
			ChangeScore(playerSide, -50, survivor.name..' was captured before being rescued.')
			local theMessage = survivor.name..' is no longer responding to radio communications. Presumed captured at '..DTG()
			RadioMessage('VHF', '282.8 MHz', theMessage, {latitude=survivor.latitude, longitude=survivor.longitude})
		end
	end
end

-- ============================
-- Survivor Dies by Exposure --
-- ============================

function SurvivorDiesByExposure(exposureDuration, survivalChance, addDeceasedUnitBoolean)
	for _, survivor in ipairs(SurvivorList) do
		if survivor.type == 'Ship' and survivor.dbid == 4877 then -- Only checks for Person in Water (Alive), can be modified for other survivor types if required
			local unit = ScenEdit_GetUnit({guid=survivor.guid})

			-- Check if unit has been in water for longer then exposure duration and random chance of survival
			-- These settings can be customized for your scenario environment and time of year
			-- Example, lower exposure duration and chance of survival for cold environments or higher duration and chance for tropical
			if unit.timeunderway >= exposureDuration and math.random(1,100) >= survivalChance then
				if addDeceasedUnitBoolean then
					-- Replace Person in Water (Alive) with Person in Water (Deceased)
					ScenEdit_DeleteUnit({guid=unit.guid})
					ScenEdit_AddUnit({
						side='Survivors',
						type='Ship',
						dbid=4878,
						name='Person in Water',
						latitude=unit.latitude,
						longitude=unit.longitude
					})

					-- Remove survivor from the list after replacement
					for i = #SurvivorList, 1, -1 do
						if SurvivorList[i].guid == survivor.guid then
							table.remove(SurvivorList, i)
							break
						end
					end
				else
					-- Delete the survivor unit and remove it from the survivor list
					for i = #SurvivorList, 1, -1 do
						if SurvivorList[i].guid == survivor.guid then
							table.remove(SurvivorList, i)
							break
						end
					end

					ScenEdit_DeleteUnit({guid=unit.guid})
				end
			end
		end
	end
end

-- ======================================
-- Add, Delete, Replace Unit Functions --
-- ======================================

function AddAircraft(side, num1, num2, dbid, name, base, loadoutID, TimeToReady)
	for i = num1,num2 do
		local unit = ScenEdit_AddUnit({side=side, type='Aircraft', dbid=dbid, name=name..i, base=base, loadoutid=3, TimeToReady_Minutes=0})
		ScenEdit_SetLoadout({unitname=unit.guid, loadoutid=loadoutID, TimeToReady_Minutes=TimeToReady, IgnoreMagazines=true})
	end
end

function unitExistsAtLocation(unitList, latitude, longitude)
	for _,v in ipairs(unitList) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.latitude == latitude and unit.longitude == longitude then
			return true
		end
	end
	return false
end

function GetRandomPositionList(side, positionRefPointName, numOfPositions, checkExisting, chanceOfAppearance, minNumberOfSelectedPostions, maxNumberOfSelectedPositions)
	local errorCount = 0
	local sideUnits = checkExisting and VP_GetSide({side=side}).units or nil

	::redoPosition::
	local positionList = {}

	-- Build list of valid positions
	for i = 1, numOfPositions do
		local position = ScenEdit_GetReferencePoint({side=side, name=positionRefPointName..' '..i})
		if not checkExisting or not unitExistsAtLocation(sideUnits, position.latitude, position.longitude) then
			table.insert(positionList, position)
		end
	end

	-- Shuffle position list to randomize selection order
	for i = #positionList, 2, -1 do
		local j = math.random(1, i)
		positionList[i], positionList[j] = positionList[j], positionList[i]
	end

	local selectedPositions = {}

	-- Roll for appearance in randomized order
	for _, position in ipairs(positionList) do
		if math.random(1,100) <= chanceOfAppearance then
			table.insert(selectedPositions, position)
		end
	end

	if #selectedPositions < minNumberOfSelectedPostions then
		errorCount = errorCount + 1
		if errorCount >= 500 then
			print('Minimum number of positions not met after max retries. Aborting placement.')
			return
		end

		goto redoPosition
	end

	-- Trim if over max
	if #selectedPositions > maxNumberOfSelectedPositions then
		for i = #selectedPositions, maxNumberOfSelectedPositions + 1, -1 do
			table.remove(selectedPositions, i)
		end
	end

	return selectedPositions
end

function AddRandomFacility_FixedPosition(side, positionList, randomUnitList, chanceOfDetection)
	for _,position in ipairs(positionList) do
		local randomUnit = randomUnitList[math.random(1, #randomUnitList)]
		local unitDetected = math.random(1,100) <= chanceOfDetection

		local newUnit = ScenEdit_AddUnit({
			side=side,
			type='Facility',
			dbid=randomUnit.dbid,
			name=randomUnit.name,
			latitude=position.latitude,
			longitude=position.longitude,
			autodetectable=unitDetected
		})
	end
end

function AddRandomFacility_RandomPosition(side, numOfUnits, chanceOfAppearance, randomUnitList, centerpoint, radius, chanceOfDetection)
	for i = 1,numOfUnits do
		if math.random(1, 100) <= chanceOfAppearance then
			local errorCount = 0
			local randomUnit = randomUnitList[math.random(1, #randomUnitList)]
			::redoPosition::
			local position = CircularRandomPosition(centerpoint.latitude, centerpoint.longitude, radius)
			local unitDetected = math.random(1, 100) <= chanceOfDetection

			if OverWater(position.latitude, position.longitude) then
				errorCount = errorCount + 1
				if errorCount <= 500 then
					goto redoPosition
				else
					BugMessage('function AddRandomFacility_RandomPosition', 'Unable to place random unit on '..side..' after 500 attempts!')
					break
				end
			end

			local newUnit = ScenEdit_AddUnit({
				side=side,
				type='Facility',
				dbid=randomUnit.dbid,
				name=randomUnit.name,
				latitude=position.latitude,
				longitude=position.longitude,
				autodetectable=unitDetected
			})
		end
	end
end

function AddUnitType_RandomPosition(side, numOfUnits, chanceOfAppearance, unitType, unit, centerpoint, CheckRangeBetweenUnitsBoolean, minRangeBetweenUnits, chanceOfDetection, unitHeading, unitSpeed, unitGroup, mission)
	for i = 1,numOfUnits do
		if math.random(1,100) <= chanceOfAppearance then
			local errorCount = 0
			local positionErrorCount = 0

			-- Get unit position
			::redoUnitPosition::  -- New label for retrying position due to range check failure
			local position = CircularRandomPosition(centerpoint.latitude, centerpoint.longitude, centerpoint.radius)
			local isValidPosition = true  -- Assume position is valid until proven otherwise

			if (unitType == 'Facility' and OverWater(position.latitude, position.longitude)) or ((unitType == 'Ship' or unitType == 'Submarine') and not OverWater(position.latitude, position.longitude)) then
				errorCount = errorCount + 1
				if errorCount <= 500 then
					goto redoUnitPosition
				else
					BugMessage('function AddRandomUnits_RandomPosition', 'Unable to place random unit on '..side..' after 500 attempts!')
					break
				end
			end

			-- Retrieve all units of the same side, then check range to all units of same type
			if CheckRangeBetweenUnitsBoolean == true then
				local sideUnits = VP_GetSide({side=side}).units
				for k, v in ipairs(sideUnits) do
					local targetUnit = ScenEdit_GetUnit({guid=v.guid})  -- Get details for each unit
					if targetUnit.type == unitType then  -- Check only units of the same type
						if not CheckMinRangeToCoordinates(position.latitude, position.longitude, targetUnit.latitude, targetUnit.longitude, minRangeBetweenUnits) then
							isValidPosition = false
							positionErrorCount = positionErrorCount + 1
							if positionErrorCount > 500 then
								BugMessage('function AddUnitType_RandomPosition', 'Unable to place random '..side..' '..unitType..' after 500 attempts!')
								break
							end
							goto redoUnitPosition
						end
					end
				end
			end

			local unitDetected = math.random(1,100) <= chanceOfDetection

			if isValidPosition then
				local newUnit = ScenEdit_AddUnit({
					side=side,
					type=unitType,
					dbid=unit.dbid,
					name=unit.name,
					latitude=position.latitude,
					longitude=position.longitude,
					heading=unitHeading,
					speed=unitSpeed,
					manualspeed=unitSpeed,
					autodetectable=unitDetected
				})

				if unitGroup ~= nil then
					newUnit.group = unitGroup
				end

				if mission ~= nil then
					ScenEdit_AssignUnitToMission(newUnit.guid, mission)
				end
			end
		end
	end
end

function AddUnitAtBearingDistanceFromPosition(originPosition, bearing, distance, newUnitType, newUnitSide, newUnitDBID, newUnitName, newUnitLoadoutID, newUnitSpeed, newUnitAltitude, newUnitHeading, newUnitGroup)
	local newUnitPosition = World_GetPointFromBearing({
		latitude=originPosition.latitude,
		longitude=originPosition.longitude,
		bearing=bearing,
		distance=distance,
	})

	local newUnit = nil

	if newUnitType == 'Aircraft' then
		newUnit = ScenEdit_AddUnit({
			side=newUnitSide,
			type='Aircraft',
			dbid=newUnitDBID,
			name=newUnitName,
			loadoutid=newUnitLoadoutID,
			latitude=newUnitPosition.latitude,
			longitude=newUnitPosition.longitude,
			speed=newUnitSpeed,
			altitude=newUnitAltitude,
			heading=newUnitHeading
		})
	elseif newUnitType == 'Weapon' then
		newUnit = ScenEdit_AddUnit({
			side=newUnitSide,
			type='Weapon',
			dbid=newUnitDBID,
			name=newUnitName,
			latitude=newUnitPosition.latitude,
			longitude=newUnitPosition.longitude,
			altitude=newUnitAltitude,
			heading=newUnitHeading
		})
	else
		newUnit = ScenEdit_AddUnit({
			side=newUnitSide,
			type=newUnitType,
			dbid=newUnitDBID,
			name=newUnitName,
			latitude=newUnitPosition.latitude,
			longitude=newUnitPosition.longitude,
			speed=newUnitSpeed,
			heading=newUnitHeading
		})
	end

	if newUnitGroup ~= nil then
		newUnit.group = newUnitGroup
	end

	return newUnit
end

function AddUnitAtBearingDistanceFromUnit(refUnitGUID, bearing, distance, newUnitType, newUnitSide, newUnitDBID, newUnitName, newUnitLoadoutID, newUnitSpeed, newUnitAltitude, newUnitHeading, newUnitGroup)
	local originPosition = ScenEdit_GetUnit({guid=refUnitGUID})
	local newUnitPosition = World_GetPointFromBearing({
		latitude=originPosition.latitude,
		longitude=originPosition.longitude,
		bearing=bearing,
		distance=distance,
	})

	local newUnit = nil

	if newUnitType == 'Aircraft' then
		newUnit = ScenEdit_AddUnit({
			type='Aircraft',
			side=newUnitSide,
			dbid=newUnitDBID,
			name=newUnitName,
			loadoutid=newUnitLoadoutID,
			latitude=newUnitPosition.latitude,
			longitude=newUnitPosition.longitude,
			speed=newUnitSpeed,
			altitude=newUnitAltitude,
			heading=newUnitHeading
		})
	elseif newUnitType == 'Weapon' then
		newUnit = ScenEdit_AddUnit({
			type='Weapon',
			side=newUnitSide,
			dbid=newUnitDBID,
			name=newUnitName,
			latitude=newUnitPosition.latitude,
			longitude=newUnitPosition.longitude,
			altitude=newUnitAltitude,
			heading=newUnitHeading
		})
	else
		newUnit = ScenEdit_AddUnit({
			type=newUnitType,
			side=newUnitSide,
			dbid=newUnitDBID,
			name=newUnitName,
			latitude=newUnitPosition.latitude,
			longitude=newUnitPosition.longitude,
			speed=newUnitSpeed,
			heading=newUnitHeading
		})
	end

	if newUnitGroup ~= nil then
		newUnit.group = newUnitGroup
	end

	return newUnit
end

function AddWeaponSalvo(targetGUID, centerPoint, numWeapons, weaponSide, weaponDBID, weaponName, weaponAltitude, salvoSpacing)
	local position = CircularRandomPosition(centerPoint.latitude, centerPoint.longitude, centerPoint.maxRange)
	local target = ScenEdit_GetContact({side=weaponSide, guid=targetGUID})
	local bearing = Tool_Bearing({latitude=position.latitude, longitude=position.longitude}, {latitude=target.latitude, longitude=target.longitude})
	local weaponSpacing = 0 + salvoSpacing
	local salvoSize = numWeapons - 1 -- subtract one for the first weapon in the savlo

	-- Add first weapon in salvo
	local firstWeaponInSalvo = ScenEdit_AddUnit({
		side=weaponSide,
		type='Weapon',
		dbid=weaponDBID,
		name=weaponName,
		latitude=position.latitude,
		longitude=position.longitude,
		altitude=weaponAltitude,
		heading=bearing
	})

	firstWeaponInSalvo.target = {guid=targetGUID}

	-- Add the rest of the weapons in the salvo
	for i = 1,salvoSize do
		local newFalseWeapon = AddUnitAtBearingDistanceFromUnit(
			firstWeaponInSalvo.guid,
			270,
			weaponSpacing,
			'Weapon',
			weaponSide,
			weaponDBID,
			weaponName,
			nil,
			nil,
			weaponAltitude,
			bearing,
			nil
		)

		newFalseWeapon.target = {guid=targetGUID}
		weaponSpacing = weaponSpacing + salvoSpacing
	end
end

function DeleteAllUnitsOnSide(side)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		ScenEdit_DeleteUnit({guid=v.guid})
	end
end

function DeleteAllUnitsOnSide_ByType(side, type)
	local sideUnits = VP_GetSide({side=side}).units
	for _,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == type then
			ScenEdit_DeleteUnit({guid=unit.guid})
		end
	end
end

function DeleteAllUnitsOnSide_ByDBID(side, dbid)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == dbid then
			ScenEdit_DeleteUnit({guid=unit.guid})
		end
	end
end

function DeletePercentageOfUnitsOnSide_ByDBID_(side, dbid, percentage)
	local sideUnits = VP_GetSide({side=side}).units
	local dbidUnits = {}

	-- Collect all units with the specified DBID
	for k, v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == dbid then
			table.insert(dbidUnits, unit)
		end
	end

	-- Determine the number of units to delete based on the percentage
	local numToDelete = math.floor(#dbidUnits * (percentage / 100))

	-- Shuffle the dbidUnits table to randomize selection
	for i = #dbidUnits, 2, -1 do
		local j = math.random(1, i)
		dbidUnits[i], dbidUnits[j] = dbidUnits[j], dbidUnits[i]
	end

	-- Delete the specified number of units
	for i = 1, numToDelete do
		ScenEdit_DeleteUnit({guid=dbidUnits[i].guid})
	end
end

function DeletePercentageOfUnits_ByList(unitList, percentage)
	-- Determine the number of units to delete based on the percentage
	local numToDelete = math.floor(#unitList * (percentage / 100))

	-- Shuffle the unitList table to randomize selection
	for i = #unitList, 2, -1 do
		local j = math.random(1, i)
		unitList[i], unitList[j] = unitList[j], unitList[i]
	end

	-- Delete the specified number of units
	for i = 1, numToDelete do
		ScenEdit_DeleteUnit({guid=unitList[i]})
	end
end

function DeletePercentageOfUnits_ByMission(side, mission, percentage)
	local UnitsAssignedToMissionList = {}
	local mission = ScenEdit_GetMission(side, mission)
	if (mission ~= nil) and mission.unitlist ~= nil then
		for k,v in ipairs(mission.unitlist) do
			table.insert(UnitsAssignedToMissionList, unit.guid)
		end
	end

	DeletePercentageOfUnits_ByList(UnitsAssignedToMissionList, percentage)
end

function DeleteUnits_ByName(side, num1, num2, name)
	for i = num1,num2 do
		local unit = ScenEdit_GetUnit({side=side, name=name..i})
		if unit then
			ScenEdit_DeleteUnit({guid=unit.guid})
		end
	end
end

function DeleteUnitX_ByType(unitType)
	local theUnit = ScenEdit_UnitX()
	if theUnit.type == unitType then
		ScenEdit_DeleteUnit({guid=theUnit.guid})
	end
end

function DeleteUnitX_ByDBID(unitDBID)
	local theUnit = ScenEdit_UnitX()
	if theUnit.dbid == unitDBID then
		ScenEdit_DeleteUnit({guid=theUnit.guid})
	end
end

function KillUnitX_ByType(unitType)
	local theUnit = ScenEdit_UnitX()
	if theUnit.type == unitType then
		ScenEdit_KillUnit({guid=theUnit.guid})
	end
end

function KillUnitX_ByDBID(unitDBID)
	local theUnit = ScenEdit_UnitX()
	if theUnit.dbid == unitDBID then
		ScenEdit_KillUnit({guid=theUnit.guid})
	end
end

function DeleteAirborneAircraft(side, dbid, airborneTime, eventName)
	local sideUnits = VP_GetSide({side=side}).units
	local existingAircraftDBID = false

	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == dbid then
			existingAircraftDBID = true
			if unit.airbornetime_v >= airborneTime then
				ScenEdit_DeleteUnit({guid=unit.guid})
			end
		end
	end

	if eventName ~= nil then
		if not existingAircraftDBID then
			ScenEdit_SetEvent(eventName, {isActive=false})
		end
	end
end

function ReplaceUnitsOnSide(side)
	local AircraftList = {}

	local sideUnits = VP_GetSide({side=side}).units
	for _,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			table.insert(AircraftList, unit)
			ScenEdit_DeleteUnit({guid=unit.guid})
		end
	end

	-- Rebuild sideUnits after aircraft have been deleted, then replace non-aircraft units
	local sideUnits = VP_GetSide({side=side}).units
	for _,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Facility' or unit.type == 'Ship' or unit.type == 'Submarine' then
			ScenEdit_DeleteUnit({guid=unit.guid})

			local newUnit = ScenEdit_AddUnit({
				side=unit.side,
				type=unit.type,
				dbid=unit.dbid,
				name=unit.name,
				latitude=unit.latitude,
				longitude=unit.longitude
			})

			if unit.group ~= nil then
				newUnit.group = unit.group.name
			end

			if unit.mission ~= nil then
				ScenEdit_AssignUnitToMission(unit.name, unit.mission.name)
			end
		end
	end

	-- Replace aircraft
	for _,aircraft in ipairs(AircraftList) do
		ScenEdit_AddUnit({
			side=side,
			type='Aircraft',
			dbid=aircraft.dbid,
			name=aircraft.name,
			loadoutid=aircraft.loadoutdbid,
			base=aircraft.base.name,
			TimeToReady_Minutes=0
		})

		if aircraft.mission ~= nil then
			ScenEdit_AssignUnitToMission(aircraft.name, aircraft.mission.name)
		end
	end
end

function ReplaceUnitsOnSide_ByDBID(side, oldDBID, newDBID, newName)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == oldDBID then
			ScenEdit_DeleteUnit({guid=unit.guid})
			ScenEdit_AddUnit({type=unit.type, side=unit.side, dbid=newDBID, name=newName, latitude=unit.latitude, longitude=unit.longitude})
		end
	end
end

function ReplaceUnitsOnSide_ByName(side, oldName, newDBID, newName)
	local unit = ScenEdit_GetUnit({side=side, name=oldName})
	ScenEdit_DeleteUnit({side=side, name=oldName})
	local newUnit = ScenEdit_AddUnit({
		type=unit.type,
		side=side,
		dbid=newDBID,
		name=newName,
		latitude=unit.latitude,
		longitude=unit.longitude,
		heading=unit.heading,
		speed=unit.speed,
		course=unit.course
	})

	if unit.group ~= nil then
		newUnit.group = unit.group.name
	end

	if unit.mission ~= nil then
		ScenEdit_AssignUnitToMission(newName, unit.mission.name)
	end
end

function ReplaceUnit_ByList(unitList)
	for _,unit in ipairs(unitList) do
		local UnitInfo = ScenEdit_GetUnit({guid=unit.guid})
		ScenEdit_DeleteUnit({guid=unit.guid})
		local newUnit = ScenEdit_AddUnit({type=UnitInfo.type, side=UnitInfo.side, dbid=unit.dbid, name=unit.name, latitude=UnitInfo.latitude, longitude=UnitInfo.longitude})

		if unit.group ~= nil then
			newUnit.group = UnitInfo.group.name
		end
	end
end

function ReplaceAircraft_ByDBID(side, oldDBID, newDBID, loadoutID, TimeToReady)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == oldDBID then
			ScenEdit_DeleteUnit({guid=unit.guid})
			ScenEdit_AddUnit({
				side=side,
				type='Aircraft',
				dbid=newDBID,
				name=unit.name,
				loadoutid=loadoutID,
				base=unit.base.name,
				TimeToReady_Minutes=TimeToReady
			})

			if unit.mission ~= nil then
				ScenEdit_AssignUnitToMission(unit.name, unit.mission.name)
			end
		end
	end
end

function ReplaceAircraft_ByName(side, num1, num2, dbid, name, loadoutID, TimeToReady)
	for i = num1,num2 do
		local unit = ScenEdit_GetUnit({Side=side, Name=name..i})
		if unit ~= nil then
			ScenEdit_DeleteUnit({guid=unit.guid})
			ScenEdit_AddUnit({
				side=side,
				type='Aircraft',
				dbid=dbid,
				name=unit.name,
				loadoutid=loadoutID,
				base=unit.base.name,
				TimeToReady_Minutes=TimeToReady
			})

			if unit.mission ~= nil then
				ScenEdit_AssignUnitToMission(unit.name, unit.mission.name)
			end
		end
	end
end

function ReplaceAirborneAircraft_ByName(side, num1, num2, dbid, name, loadoutID)
	for i = num1,num2 do
		local unit = ScenEdit_GetUnit({Side=side, Name=name..i})
		if unit ~= nil then
			ScenEdit_DeleteUnit({guid=unit.guid})
			local newUnit = ScenEdit_AddUnit({
				side=side,
				type='Aircraft',
				dbid=dbid,
				name=unit.name,
				loadoutid=loadoutID,
				latitude=unit.latitude,
				longitude=unit.longitude,
				altitude=unit.altitude,
				heading=unit.heading,
			})

			if unit.group ~= nil then
				newUnit.group = unit.group.name
			end

			if unit.mission ~= nil then
				ScenEdit_AssignUnitToMission(unit.name, unit.mission.name)
			end
		end
	end
end

function GetReplaceChanceFromList(replacableUnits, dbid)
	for _, unitEntry in ipairs(replacableUnits) do
		if unitEntry.dbid == dbid then
			return unitEntry.replaceChance
		end
	end
	return nil -- Return nil if the dbid was not found in the list
end

function RandomReplaceFacility(side, mode, unitsToReplaceList, chance, replaceChance, radius, unitList, chanceOfDetection)
	local sideUnits = VP_GetSide({side=side}).units

	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if IsInListTable(unitsToReplaceList, 'dbid', unit.dbid) then -- Check if unit's dbid is in replaceable list
			if math.random(1,100) <= chance then
				local position
				local errorCount = 0
				local ReplaceUnit

				if mode == 'Replace' then
					ReplaceUnit = true
				elseif mode == 'Add' then
					ReplaceUnit = false
				elseif mode == 'Random' then
					-- Get the replaceChance for the unit from the unitsToReplaceList, or use the default
					local replaceValue = GetReplaceChanceFromList(unitsToReplaceList, unit.dbid) or replaceChance

					-- Determine if this unit should be replaced
					local unitReplaceChance = (replaceValue == 'Random') and math.random(1,100) or replaceValue
					ReplaceUnit = math.random(1,100) <= unitReplaceChance
				end

				if ReplaceUnit then
					-- Replace the old unit directly
					position = ScenEdit_GetUnit({guid=unit.guid})
					ScenEdit_DeleteUnit({guid=unit.guid})
				else
					-- Add a new unit nearby
					local centerPoint = ScenEdit_GetUnit({guid=unit.guid})

					::redoPosition::
					position = CircularRandomPosition(centerPoint.latitude, centerPoint.longitude, radius)

					if OverWater(position.latitude, position.longitude) then
						errorCount = errorCount + 1
						if errorCount <= 500 then
							goto redoPosition
						else
							BugMessage('RandomReplaceFacility', 'Unable to place random unit on '..side..' after 500 attempts!')
							break
						end
					end
				end

				-- Add a new randomly selected unit
				local randomType = unitList[math.random(1, #unitList)]
				local unitDetected = math.random(1, 100) <= chanceOfDetection
				local newUnit = ScenEdit_AddUnit({
					side=side,
					type='Facility',
					dbid=randomType.dbid,
					name=randomType.name,
					latitude=position.latitude,
					longitude=position.longitude,
					autodetectable=unitDetected
				})
			end
		end
	end
end

function ChangeUnitSide_ByList(unitList, oldSide, newSide)
	for k,v in ipairs(unitList) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		ScenEdit_SetUnitSide({side=oldSide, guid=unit.guid, newside=newSide})
	end
end

function ChangeUnitSide(oldSide, newSide)
	local sideUnits = VP_GetSide({side=oldSide}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Group' then
			ScenEdit_SetUnitSide({side=oldSide, guid=unit.guid, newside=newSide})
		end
	end
	ChangeUnitSide_ByList(sideUnits, oldSide, newSide)
end

function ChangeUnitSide_ByName(oldSide, newSide, num1, num2, name)
	for i = num1, num2 do
		local unit = ScenEdit_GetUnit({side=oldSide, name=name..i})
		ScenEdit_SetUnitSide({side=oldSide, guid=unit.guid, newside=newSide})
	end
end

function RotateUnitAroundCenterpoint(centerPoint, unitGUID, unitRotation)
	local bearing = Tool_Bearing({latitude=centerPoint.latitude, longitude=centerPoint.longitude}, unitGUID)
	local distance = Tool_Range({latitude=centerPoint.latitude, longitude=centerPoint.longitude}, unitGUID)
	local newBearing = bearing + unitRotation
	local newPostion = World_GetPointFromBearing({latitude=centerPoint.latitude, longitude=centerPoint.longitude, bearing=newBearing, distance=distance})
	ScenEdit_SetUnit({guid=unitGUID, latitude=newPostion.latitude, longitude=newPostion.longitude})
end

-- ===================================
-- Modify Unit Properties Functions --
-- ===================================

function SetAircraftLoadouts(side, num1, num2, name, loadoutid, TimeToReady, IgnoreMagazinesBoolean)
	for i = num1,num2 do
		local unit = ScenEdit_GetUnit({side=side, name=name..i})
		if unit then
			ScenEdit_SetLoadout({name=unit.name, loadoutID=loadoutid, TimeToReady_Minutes=TimeToReady, IgnoreMagazines=IgnoreMagazinesBoolean})
		end
	end
end

function RandomizeAircraftLoadouts(chance, loadoutID1, loadoutID2)
	if math.random(1,100) <= chance then 
		return loadoutID1
	else
		return loadoutID2
	end
end

function SetAircraftTimeToReady_BySide(side, TimeToReady)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			ScenEdit_SetLoadout({unitname=unit.guid, TimeToReady_Minutes=TimeToReady})
		end
	end
end

function SetAircraftTimeToReady_ByMission(side, mission, TimeToReady)
	local mission = ScenEdit_GetMission(side, mission)
	if (mission ~= nil) and mission.unitlist ~= nil then
		for _,aircraft in ipairs(mission.unitlist) do
			ScenEdit_SetLoadout({unitname=aircraft, TimeToReady_Minutes=TimeToReady})
		end
	end
end

function SetAircraftTimeToReady_ByBaseAndDBID(baseGUID, dbid, TimeToReady)
	local base = ScenEdit_GetUnit({guid=baseGUID})
	for i,aircraftGUID in ipairs(base.assignedUnits.Aircraft) do
		local aircraft = ScenEdit_GetUnit({guid=aircraftGUID})
		if aircraft.dbid == dbid then
			ScenEdit_SetLoadout({unitname=aircraft.guid, TimeToReady_Minutes=TimeToReady})
		end
	end
end

function SetAircraftTimeToReady(side, num1, num2, name, TimeToReady)
	for i = num1,num2 do
		local unit = ScenEdit_GetUnit({side=side, name=name..i})
		if unit then
			ScenEdit_SetLoadout({unitname=unit.guid, TimeToReady_Minutes=TimeToReady})
		end
	end
end

function RandomizeAircraftTimeToReady_BySide(side, minTimeToReady, maxTimeToReady, roundTo)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			ScenEdit_SetLoadout({unitname=unit.guid, TimeToReady_Minutes=GetRandomRoundedNumber(minTimeToReady, maxTimeToReady, roundTo)})
		end
	end
end

function SetAircraftReadiness_BySide(side, chance)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			if math.random(1,100) <= chance then
				-- Set aircraft to Maintenance [Unavailable]
				ScenEdit_SetLoadout({unitname=unit.guid, LoadoutID=4, TimeToReady_Minutes=0})
			else
				-- Set aircraft to Reserve [Available] if aircraft was set to Maintenance [Unavailable]
				if unit.loadoutdbid == 4 then
					ScenEdit_SetLoadout({unitname=unit.guid, LoadoutID=3, TimeToReady_Minutes=0})
				end
			end
		end
	end
end

function RandomizeAircraftReadiness_ByBaseAndDBID(baseGUID, dbid, chance)
	local base = ScenEdit_GetUnit({guid=baseGUID})
	for i,aircraftGUID in ipairs(base.assignedUnits.Aircraft) do
		local aircraft = ScenEdit_GetUnit({guid=aircraftGUID})
		if aircraft.dbid == dbid then
			if math.random(1,100) <= chance then
				ScenEdit_SetLoadout({unitname=aircraft.guid, LoadoutID=4, TimeToReady_Minutes=0})
			end
		end
	end
end

function ResetAircraftTimeToReady_BySide(side)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			TimeToReady = unit.readytime_v / 60
			ScenEdit_SetLoadout({unitname=unit.guid, TimeToReady_Minutes=TimeToReady})
		end
	end
end

function RebaseUnits_ByName(side, num1, num2, name, newBase)
	for i = num1, num2 do
		local unit = ScenEdit_GetUnit({side=side, name=name..i})
		if unit then
			ScenEdit_HostUnitToParent({HostedUnitNameOrID=unit.guid, SelectedHostNameOrID=newBase})
		end
	end
end

function SetUnitsAutodetectable_BySide(side, boolean)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({name=v.guid})
		ScenEdit_SetUnit({guid=unit.guid, autodetectable=boolean})
	end
end

function SetUnitsAutodetectable_ByType(side, type, boolean)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({name=v.guid})
		if unit.type == type then
			ScenEdit_SetUnit({guid=unit.guid, autodetectable=boolean})
		end
	end
end

function SetUnitsAutodetectable_ByDBID(side, dbid, boolean)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({name=v.guid})
		if unit.dbid == dbid then
			ScenEdit_SetUnit({guid=unit.guid, autodetectable=boolean})
		end
	end
end

function RandomizeUnitsAutodetectable_ByDBID(side, dbid, chance, boolean)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({name=v.guid})
		if unit.dbid == dbid then
			if math.random(1,100) <= chance then
				ScenEdit_SetUnit({guid=unit.guid, autodetectable=boolean})
			end
		end
	end
end

function UpdateUnitMounts(unitGUID, mode, numOfMounts, mountDBID, mountArc)
	local modeString = string.lower(mode)
	local unit = ScenEdit_GetUnit({guid=unitGUID})
	if modeString == 'add' then
		for i = 1,numOfMounts do
			ScenEdit_UpdateUnit({guid=unit.guid, mode='add_mount', dbid=mountDBID, arc_mount=mountArc})
		end
	elseif modeString == 'remove' then
		for i = 1,numOfMounts do
			ScenEdit_UpdateUnit({guid=unit.guid, mode='remove_mount', dbid=mountDBID})
		end
	else
		print("Invalid mode: " .. tostring(mode) .. ". Use 'Add' or 'Remove'.")
	end
end

function UpdateUnitMounts_BySide(side, unitDBID, mode, numOfMounts, mountDBID, mountArc)
	local modeString = string.lower(mode)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == unitDBID then
			if modeString == 'add' then
				for i = 1,numOfMounts do
					ScenEdit_UpdateUnit({guid=unit.guid, mode='add_mount', dbid=mountDBID, arc_mount=mountArc})
				end
			elseif modeString == 'remove' then
				for i = 1,numOfMounts do
					ScenEdit_UpdateUnit({guid=unit.guid, mode='remove_mount', dbid=mountDBID})
				end
			else
				print("Invalid mode: " .. tostring(mode) .. ". Use 'Add' or 'Remove'.")
			end
		end
	end
end

function UpdateUnitMunitions_BySide(side, unitDBID, wpnDBID, numWeapons, removeBoolean)
	local sideUnits = VP_GetSide({side=side}).units
	for _, v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == unitDBID then
			ScenEdit_AddReloadsToUnit({guid=unit.guid, wpn_dbid=wpnDBID, number=numWeapons, remove=removeBoolean})
		end
	end
end

function UpdateUnitMagazines_BySide(side, unitDBID, wpnDBID, numWeapons, removeBoolean)
	local sideUnits = VP_GetSide({side=side}).units
	for _, v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.dbid == unitDBID then
			ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid=wpnDBID, number=numWeapons, remove=removeBoolean})
		end
	end
end

-- ===============================
-- Doctrine and EMCON Functions --
-- ===============================

function SetUnitProficiency_ByList(unitList, unitProficiency)
	for k,v in ipairs(unitList) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type ~= 'Group' then
			ScenEdit_SetUnit({guid=v.guid, proficiency=unitProficiency})
		end
	end
end

function RandomizeUnitProficiency(unitGUID, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
	local chance = math.random(1,100)
	local proficiency

	if chance <= chanceNovice then 
		proficiency = 0 -- Novice
	elseif chance <= chanceCadet then 
		proficiency = 1 -- Cadet
	elseif chance <= chanceRegular then 
		proficiency = 2 -- Regular
	elseif chance <= chanceVeteran then 
		proficiency = 3 -- Veteran
	else 
		proficiency = 4 -- Ace
	end

	ScenEdit_SetUnit({guid=unitGUID, proficiency=proficiency})
end

function RandomizeMultipleUnitProficiency(side, num1, num2, name, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
	for i = num1, num2 do
		local unit = ScenEdit_GetUnit({side=side, name=name..i})
		if unit then
			RandomizeUnitProficiency(unit.guid, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
		end
	end
end

function RandomizeUnitProficiency_BySide(side, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit and unit.type ~= 'Group' then
			RandomizeUnitProficiency(unit.guid, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
		end
	end
end

function RandomizeUnitProficiency_ByList(unitList, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
	for k,v in ipairs(unitList) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit and unit.type ~= 'Group' then
			RandomizeUnitProficiency(unit.guid, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
		end
	end
end

function SetUnitDoctrineWCS_BySide(side, air, land, subsurface, surface)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({name=v.name})
		ScenEdit_SetDoctrine({guid=unit.guid}, {
			weapon_control_status_air=air,
			weapon_control_status_land=land,
			weapon_control_status_subsurface=subsurface,
			weapon_control_status_surface=surface
		})
	end
end

function SetUnitDoctrineWCS_ByList(unitList, air, land, subsurface, surface)
	for k,v in ipairs(unitList) do
		local unit = ScenEdit_GetUnit({name=v.name})
		ScenEdit_SetDoctrine({guid=unit.guid}, {
			weapon_control_status_air=air,
			weapon_control_status_land=land,
			weapon_control_status_subsurface=subsurface,
			weapon_control_status_surface=surface
		})
	end
end

function SetUnitEMCON_BySide(side)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({name=v.guid})
		ScenEdit_SetEMCON('Unit', unit.guid, 'Radar=passive')
	end
end

function SetUnitsEMCON_ByDBID(side, unitDBIDs, chance)
	-- Convert the list of DBIDs into a table for faster lookup
	local dbidLookup = {}
	for _, dbidInfo in ipairs(unitDBIDs) do
		dbidLookup[dbidInfo.dbid] = true
	end

	-- Get all units on the specified side
	local sideUnits = VP_GetSide({side=side}).units
	for _, v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		-- Check if this unit's DBID is in the lookup table
		if dbidLookup[unit.dbid] then
			-- Evaluate the chance for each unit individually
			if chance == 0 then
				-- If chance is explicitly set to 0, set to passive regardless of the roll
				ScenEdit_SetEMCON('unit', unit.guid, 'Radar=Passive')
				ScenEdit_SetDoctrine({side=side, guid=unit.guid}, {weapon_control_status_air='2'}) -- WCS Weapons HOLD
			else
				if math.random(1,100) <= chance then
					-- If the roll is less than or equal to the chance, activate radar
					ScenEdit_SetEMCON('unit', unit.guid, 'Radar=Active')
					ScenEdit_SetDoctrine({side=side, guid=unit.guid}, {weapon_control_status_air='Inherit'})
				else
					-- Otherwise, set to passive
					ScenEdit_SetEMCON('unit', unit.guid, 'Radar=Passive')
					ScenEdit_SetDoctrine({side=side, guid=unit.guid}, {weapon_control_status_air='2'}) -- WCS Weapons HOLD
				end
			end
		end
	end
end

-- ===========================
-- Modify Mission Functions --
-- ===========================

function SetSideMissionStatus(side, status)
	local sideMissions = VP_GetSide({side=side}).missions
	for k,v in ipairs(sideMissions) do
		local mission = ScenEdit_GetMission(side, v.guid)
		ScenEdit_SetMission(side, mission.guid, {isactive=status})
	end
end

function DeleteAllMissionsOnSide(side)
	local sideMissions = VP_GetSide({side=side}).missions
	for k,v in ipairs(sideMissions) do
		local mission = ScenEdit_GetMission(side, v.guid)
		ScenEdit_DeleteMission(side, mission.guid)
	end
end

function AssignUnitsToMission(side, num1, num2, name, mission, escortBoolean)
	for i = num1,num2 do
		local unit = ScenEdit_GetUnit({side=side, name=name..i})
		if unit ~= nil then
			ScenEdit_AssignUnitToMission(unit.guid, mission, escortBoolean)
		end
	end
end

function ChangeUnitsMission(side, oldMission, newMission)
	local mission = ScenEdit_GetMission(side, oldMission)
	if (mission ~= nil) and mission.unitlist ~= nil then
		for _,unit in ipairs(mission.unitlist) do
			ScenEdit_AssignUnitToMission(unit, newMission)
		end
	end
end

function SetMaxFlightsForStrikeMission(side, missionName, percentage, roundTo)
	local numUnits = 0
	-- Get number of units assigned to mission
	local mission = ScenEdit_GetMission(side, missionName)
	if (mission ~= nil) and mission.unitlist ~= nil then
		for _,unit in ipairs(mission.unitlist) do
			numUnits = numUnits + 1
		end
	end

	-- Set the maximum number of flights for the mission
	local percentage = percentage / 100
	local flightSize = numUnits * percentage
	
	-- Round flightSize to the nearest multiple of roundTo
	local MaxFlights = math.floor((flightSize + roundTo / 2) / roundTo) * roundTo

	ScenEdit_SetMission(side, missionName, {StrikeMax=MaxFlights})
end

-- =================
-- Misc Functions --
-- =================

function AttackContactType(side, attackerID, contactName, weaponDBID, numWeapons)
	local contacts = ScenEdit_GetContacts(side)
	for _, contact in pairs(contacts) do
		if contact.name == contactName then
			-- If the specified contact type is found, insert its GUID into the AttackContact function
			ScenEdit_AttackContact(attackerID, contact.guid, {mode=1, weapon=weaponDBID, qty=numWeapons})
		end
	end
end

function SetSideAircraftToRTB(side)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			ScenEdit_SetUnit({guid=unit.guid, rtb=true})
		end
	end
end

function SetSideAircraftToRTB(side)
	local sideUnits = VP_GetSide({side=side}).units
	for k,v in ipairs(sideUnits) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			unit:RTB(true)
		end
	end
end

function TeleportAircraftToBase_BySide(side)
	local units = VP_GetSide({side=side}).units
	for k,v in ipairs(units) do
		local unit = ScenEdit_GetUnit({guid=v.guid})
		if unit.type == 'Aircraft' then
			ScenEdit_HostUnitToParent({HostedUnitNameOrID=unit.guid, SelectedHostNameOrID=unit.base.guid})
		end
	end
end

function SetUnitAtBearingDistanceFromUnit(ReferenceUnitGUID, unitGUID, bearing, distance, unitSpeed, unitHeading, stationType)
	local ReferenceUnit = ScenEdit_GetUnit({guid=ReferenceUnitGUID})
	local UnitPosition = World_GetPointFromBearing({
		latitude=ReferenceUnit.latitude,
		longitude=ReferenceUnit.longitude,
		bearing=bearing,
		distance=distance,
	})

	local Unit = ScenEdit_SetUnit({
		guid=unitGUID,
		latitude=UnitPosition.latitude,
		longitude=UnitPosition.longitude,
		speed=unitSpeed,
		heading=unitHeading
	})

	Unit.formation = {type=stationType, bearing=bearing, distance=distance}
end

function SetGroupFormation(groupLeaderGUID, unitList)
	local GroupLeader = ScenEdit_GetUnit({guid=groupLeaderGUID})
	for _,unit in ipairs(unitList) do
		local UnitPosition = World_GetPointFromBearing({
			latitude=GroupLeader.latitude,
			longitude=GroupLeader.longitude,
			bearing=unit.bearing,
			distance=unit.distance,
		})

		local SetUnit = ScenEdit_SetUnit({
			guid=unit.guid,
			latitude=UnitPosition.latitude,
			longitude=UnitPosition.longitude,
			speed=GroupLeader.speed,
			heading=GroupLeader.heading
		})

		SetUnit.formation = {type=unit.stationType, bearing=unit.bearing, distance=unit.distance}
	end
end

-- =========================
-- KnightHawk75 Refuel Unit Functions
-- =========================

function khRefuelUnit(myunit)
	local newfuel = myunit.fuel
	for i,v in pairs(newfuel) do
		v.current = v.max
		myunit.fuel = newfuel
	end
	newfuel = nil;
end

function khRefuelSide(thesidename,unittype,subtype)
	if unittype ==nil then unittype="All" end;
	if subtype ==nil then subtype="All" end;
	local a = VP_GetSide({Side =thesidename}) 
	for i,v in pairs(a.units) do
		local myunit;
		myunit = ScenEdit_GetUnit({name=v.name, guid=v.guid})
		if myunit ~=nil then
			if unittype ~="All" and subtype ~= "All" then
				if myunit.type == unittype and myunit.subtype == subtype then
					khRefuelUnit(myunit);
				end
			elseif unittype ~= "All" and subtype =="All" then
				if myunit.type == unittype then
					khRefuelUnit(myunit);
				end
			elseif unittype == "All" and subtype ~="All" then
				if myunit.subtype == subtype then
					khRefuelUnit(myunit);
				end
			else --either ==All or both ==ALL
				if myunit.type ~= "Weapon" then
					khRefuelUnit(myunit);
				end
			end
		end
		myunit = nil;
	end
	local a = nil;
end


-- Scenario Lua init 2 script
math.randomseed(os.time())
math.random()

-- =============
-- Key Values --
-- =============

-- =========================
-- Enable Search and Rescue
-- =========================

function SearchAndRescueEnabled(boolValue)
	if boolValue == nil then
		return ConvertStringToBoolean(ScenEdit_GetKeyValue('SearchAndRescueEnabled'))
	elseif boolValue == true then
		ScenEdit_SetKeyValue('SearchAndRescueEnabled','true')
		return true
	elseif boolValue == false then
		ScenEdit_SetKeyValue('SearchAndRescueEnabled','false')
		return false
	else
		return nil
	end
end

-- =========================
-- Hostilities Have Commenced
-- =========================

function HostilitiesHaveCommenced(boolValue)
	if boolValue == nil then
		return ConvertStringToBoolean(ScenEdit_GetKeyValue('HostilitiesHaveCommenced'))
	elseif boolValue == true then
		ScenEdit_SetKeyValue('HostilitiesHaveCommenced','true')
		return true
	elseif boolValue == false then
		ScenEdit_SetKeyValue('HostilitiesHaveCommenced','false')
		return false
	else
		return nil
	end
end

-- =========================
-- Iran Use Hypothetical Loadouts
-- =========================

function IranUseHypotheticalLoadouts(boolValue)
	if boolValue == nil then
		return ConvertStringToBoolean(ScenEdit_GetKeyValue('IranUseHypotheticalLoadouts'))
	elseif boolValue == true then
		ScenEdit_SetKeyValue('IranUseHypotheticalLoadouts','true')
		return true
	elseif boolValue == false then
		ScenEdit_SetKeyValue('IranUseHypotheticalLoadouts','false')
		return false
	else
		return nil
	end
end

-- =========================
-- Israel US Missiles Strikes Approved
-- =========================

function IsraelMissileStrikesApproved(boolValue)
	if boolValue == nil then
		return ConvertStringToBoolean(ScenEdit_GetKeyValue('MissileStrikesApproved'))
	elseif boolValue == true then
		ScenEdit_SetKeyValue('MissileStrikesApproved','true')
		return true
	elseif boolValue == false then
		ScenEdit_SetKeyValue('MissileStrikesApproved','false')
		return false
	else
		return nil
	end
end

-- =========================
-- Scenario Year
-- =========================

function ScenarioYear(year)
	if year == nil then
		return ScenEdit_GetKeyValue('ScenarioYearKey')
	elseif year == 'early2020' then
		ScenEdit_SetKeyValue('ScenarioYearKey', 'early2020')
		return 'early2020'
	elseif year == 'mid2020' then
		ScenEdit_SetKeyValue('ScenarioYearKey', 'mid2020')
		return 'mid2020'
	elseif year == 'late2020' then
		ScenEdit_SetKeyValue('ScenarioYearKey', 'late2020')
		return 'late2020'
	else
		return nil
	end
end

-- =========================
-- Use Random Variables
-- =========================

function UseRandomVariables(boolValue)
	if boolValue == nil then
		return ConvertStringToBoolean(ScenEdit_GetKeyValue('UseRandomVariables'))
	elseif boolValue == true then
		ScenEdit_SetKeyValue('UseRandomVariables','true')
		return true
	elseif boolValue == false then
		ScenEdit_SetKeyValue('UseRandomVariables','false')
		return false
	else
		return nil
	end
end

-- =========================
-- Use Realistic Variables
-- =========================

function UseRealisticVariables(boolValue)
	if boolValue == nil then
		return ConvertStringToBoolean(ScenEdit_GetKeyValue('UseRealisticVariables'))
	elseif boolValue == true then
		ScenEdit_SetKeyValue('UseRealisticVariables','true')
		return true
	elseif boolValue == false then
		ScenEdit_SetKeyValue('UseRealisticVariables','false')
		return false
	else
		return nil
	end
end

-- ===========================
-- Scenario Setup Functions --
-- ===========================

-- =========================
-- Israel Side Setup
-- =========================

function IsraelSideSetup(side)
	if ScenarioYear() == 'mid2020' or ScenarioYear() == 'late2020' then
		DeleteAllUnitsOnSide_ByDBID(side, 3447) -- Delete F-35I Adir, 2018
		RebaseUnits_ByName(side, 1, 20, '200 Sqd. #', 'Hatzor AB') -- Rebase 20 x Heron UAV [Shoval] (200 Sqd.) from Palmachim AB to Hatzor AB

		if ScenarioYear() == 'mid2020' then
			AddAircraft(side, 1, 24, 4700, '116 Sqd. #', 'Nevatim AB', 3, 0) -- Add 24 x F-35i Adir, 2025 (116 Sqd.) to Nevatim AB
			AddAircraft(side, 1, 24, 4700, '140 Sqd. #', 'Nevatim AB', 3, 0) -- Add 24 x F-35i Adir, 2025 (140 Sqd.) to Nevatim AB
			AddAircraft(side, 6, 6, 5625, '122 Sqd. #', 'Nevatim AB', 8633, 0) -- Add 1 x Gulfstream G550 Oron (122 Sqd.) to Nevatim AB
		elseif ScenarioYear() == 'late2020' then
			ScenEdit_SetSpecialAction({side=side, ActionNameOrID='Request Early KC-46A Pegasus Tanker Delivery', isactive=false})
			ScenEdit_SetSpecialAction({side=side, ActionNameOrID='Request Additional KC-46A Pegasus Tankers', isactive=true})

			DeleteAllUnitsOnSide_ByDBID(side, 6035) -- Delete F-15A Baz
			DeleteAllUnitsOnSide_ByDBID(side, 4819) -- Delete F-15C Akef-2000
			DeleteAllUnitsOnSide_ByDBID(side, 2955) -- Delete Gulfstream G550 Nahshon-Shavit
			DeleteAllUnitsOnSide_ByDBID(side, 2700) -- Delete KC-707 Saknayee

			AddAircraft(side, 1, 24, 7703, '106 Sqd. #', 'Tel Nof AB', 3, 0) -- Add 24 x F-15IA Raam (133 Sqd.) to Tel Nof AB
			AddAircraft(side, 1, 24, 7703, '133 Sqd. #', 'Tel Nof AB', 3, 0) -- Add 24 x F-15IA Raam (133 Sqd.) to Tel Nof AB
			AddAircraft(side, 1, 24, 4700, '116 Sqd. #', 'Nevatim AB', 3, 0) -- Add 24 x F-35I Adir, 2025 (116 Sqd.) to Nevatim AB
			AddAircraft(side, 1, 24, 4700, '117 Sqd. #', 'Nevatim AB', 3, 0) -- Add 24 x F-35I Adir, 2025 (117 Sqd.) to Nevatim AB
			AddAircraft(side, 1, 24, 4700, '140 Sqd. #', 'Nevatim AB', 3, 0) -- Add 24 x F-35I Adir, 2025 (140 Sqd.) to Nevatim AB
			AddAircraft(side, 3, 3, 676, '122 Sqd. #', 'Nevatim AB', 8633, 0) -- Add 1 x Gulfstream G550 Nahshon-Eitam (122 Sqd.) to Nevatim AB
			AddAircraft(side, 4, 6, 2955, '122 Sqd. #', 'Nevatim AB', 15776, 0) -- Add 3 x Gulfstream G550 Nahshon-Shavit (122 Sqd.) to Nevatim AB
			AddAircraft(side, 7, 7, 5625, '122 Sqd. #', 'Nevatim AB', 8633, 0) -- Add 1 x Gulfstream G550 Oron (122 Sqd.) to Nevatim AB
			AddAircraft(side, 1, 8, 5514, '120 Sqd. #', 'Nevatim AB', 18313, 0) -- Add 8 x KC-46A Pegasus (120 Sqd.) to Nevatim AB
		end
	end
end

-- =========================
-- United States Side Setup
-- =========================

function UnitedStatesSideSetup(side)
	if ScenarioYear() == 'early2020' then
		ScenEdit_DeleteUnit({guid='TTZL89-0HNJJMUH21KN0'}) -- Muwaffaq Salti AB
	elseif ScenarioYear() == 'mid2020' or ScenarioYear() == 'late2020' then
		DeleteAllUnitsOnSide_ByDBID(side, 7749) -- Delete E-8C Joint STARS
		DeleteAllUnitsOnSide_ByDBID(side, 7704) -- Delete KC-10A Extender

		if ScenarioYear() == 'mid2020' then
			DeleteUnits_ByName(side, 23, 28, 'SHELL ') -- Delete 6 x KC-135R Stratotanker at Al Udeid AB

			-- Disable F/A-18E/F Super Hornet AIM-260 JATM loadouts
			ScenEdit_SetLoadoutAvailable({loadoutDBID=34520, available=false}) -- A/A: AIM-260 JATM, AN/ASG-34 IRST, Heavy
			ScenEdit_SetLoadoutAvailable({loadoutDBID=34519, available=false}) -- A/A: AIM-260 JATM, AN/ASG-34 IRST, Light
			ScenEdit_SetLoadoutAvailable({loadoutDBID=34521, available=false}) -- A/A: AIM-260 JATM, AN/ASG-34 IRST, Standard CAP
			ScenEdit_SetLoadoutAvailable({loadoutDBID=34523, available=false}) -- A/A: AIM-260 JATM, ATFLIR [FLIR], AN/ASG-34 IRST, Heavy
			ScenEdit_SetLoadoutAvailable({loadoutDBID=34522, available=false}) -- A/A: AIM-260 JATM, ATFLIR [FLIR], AN/ASG-34 IRST, Light
			ScenEdit_SetLoadoutAvailable({loadoutDBID=34524, available=false}) -- A/A: AIM-260 JATM, ATFLIR [FLIR], AN/ASG-34 IRST, Standard CAP
		elseif ScenarioYear() == 'late2020' then
			DeleteAllUnitsOnSide_ByDBID(side, 7739) -- Delete E-3G Sentry
			DeleteAllUnitsOnSide_ByDBID(side, 6621) -- Delete KC-135R Stratotanker

			AddAircraft(side, 11, 22, 6620, 'EXXON', 'Al Udeid AB', 32851, 3) -- Add 12 x KC-46A Pegasus to Al Udeid AB

			ReplaceUnitsOnSide_ByName(side, 'USS Cole (DDG-67)', 3343, 'USS Zumwalt (DDG-1000)')
			ReplaceUnitsOnSide_ByName(side, 'USS Georgia (SSGN-729)', 668, 'USS Arizona (SSN-803)')

			-- Set up USS Arizona weapons, remove Tomahawks and add LRHW
			local ssgn = ScenEdit_GetUnit({side=side, name='USS Arizona (SSN-803)'})
			for _, magazine in ipairs(ssgn.magazines) do
				if magazine.mag_dbid == 1993 then
					ScenEdit_AddWeaponToUnitMagazine({guid=ssgn.guid, mag_guid=magazine.mag_guid, wpn_dbid=4071, number=8, remove=true})
				end
			end

			for _, mount in ipairs(ssgn.mounts) do
				if mount.mount_dbid == 2527 then
					ScenEdit_AddReloadsToUnit({guid=ssgn.guid, wpn_dbid=4071, number=28, remove=true})
					ScenEdit_AddReloadsToUnit({guid=ssgn.guid, wpn_dbid=4394, number=12})
				end
			end
		end
	end
end

-- =========================
-- Iran Set Ready Times
-- =========================

function IranSideSetup(minTimeToReady, maxTimeToReady)
	if ScenarioYear() == 'early2020' or ScenarioYear() == 'mid2020' then
		local facility = ScenEdit_GetUnit({name='Natanz South Fuel Enrichment Plant', guid='TTZL89-0HNJASQR2312F'})
		for _, guid in ipairs(facility.group.unitlist) do
			ScenEdit_DeleteUnit({guid=guid})
		end
	else
		local facility = ScenEdit_GetUnit({name='Natanz Fuel Enrichment Plant', guid='Z8XE7U-0HME15HRR73KJ'})
		for _, guid in ipairs(facility.group.unitlist) do
			ScenEdit_DeleteUnit({guid=guid})
		end
	end

	local AircraftList = {
		{defaultDBID=1346, num1=1, num2=6, name='11 TFS', replaceUnit=true, newDBID=6728, loadoutID_1=5281, loadoutID_2=33011}, -- MiG-29 Fulcrum A, default
		{defaultDBID=1346, num1=1, num2=12, name='22 TFS', replaceUnit=true, newDBID=6728, loadoutID_1=5281, loadoutID_2=33011}, -- MiG-29 Fulcrum A, default
		{defaultDBID=6997, num1=1, num2=12, name='41 TFS', replaceUnit=false, loadoutID_1=4691, loadoutID_2=32342}, -- F-5E Tiger II, default
		{defaultDBID=6998, num1=1, num2=12, name='43 TFS', replaceUnit=false, loadoutID_1=4691, loadoutID_2=32342}, -- F-5F Tiger II, default
		{defaultDBID=6997, num1=1, num2=6, name='141 TFS', replaceUnit=false, loadoutID_1=4691, loadoutID_2=32342}, -- F-5E Tiger II
	}

	for _,aircraftData in ipairs(AircraftList) do
		-- Retrieve the first unit of the squadron by name
		local unit = ScenEdit_GetUnit({side='Iran', name=aircraftData.name..' #1'})
		local AircraftLoadout

		-- Proceed only if the unit exists and matches the default DBID
		if unit and unit.dbid == aircraftData.defaultDBID then
			-- Roll for randomization based on placement or upgrade chance
			if IranUseHypotheticalLoadouts() then
				AircraftLoadout = RandomizeAircraftLoadouts(IranUnitPlacementOrUpgradeChance, aircraftData.loadoutID_1, aircraftData.loadoutID_2)
				if aircraftData.replaceUnit then
					-- Replace unit with UseHypotheticalLoadouts enabled: replace with new DBID and random loadout
					ReplaceAircraft_ByName('Iran', aircraftData.num1, aircraftData.num2, aircraftData.newDBID, aircraftData.name..' #', AircraftLoadout, 0)
				else
					-- Non-replace unit: roll random loadout
					SetAircraftLoadouts('Iran', aircraftData.num1, aircraftData.num2, aircraftData.name..' #', AircraftLoadout, 0, true)
				end
			else
				SetAircraftLoadouts('Iran', aircraftData.num1, aircraftData.num2, aircraftData.name..' #', aircraftData.loadoutID_1, 0, true)
			end
		end
	end

	-- Set squadron - class variables for each Iranian fighter squadron
	-- Variables are used for the Intel update message
	local IranFighterSquadrons = {
		{name='11 TFS', base='Tehran (1st TAB)'},
		{name='22 TFS', base='Tabriz (2nd TAB)'},
		{name='31 TFS', base='Hamadan (3rd TAB)'},
		{name='32 TFS', base='Hamadan (3rd TAB)'}, -- Optional Su-35 Squadron
		{name='41 TFS', base='Dezful (4th TAB)'},
		{name='43 TFS', base='Dezful (4th TAB)'},
		{name='51 TFS', base='Omidiyeh (5th TAB)'},
		{name='52 TFS', base='Omidiyeh (5th TAB)'},
		{name='53 TFS', base='Omidiyeh (5th TAB)'},
		{name='64 TFS', base='Bushehr (6th TAB)'},
		{name='74 TFS', base='Bushehr (6th TAB)'}, -- Optional Su-35 Squadron
		{name='81 TFS', base='Esfahan (8th TAB)'},
		{name='82 TFS', base='Esfahan (8th TAB)'},
		{name='83 TFS', base='Esfahan (8th TAB)'},
		{name='91 TFS', base='Bandar Abbas (9th TAB)'},
		{name='101 TFS', base='Chabahar (10th TAB)'},
		{name='141 TFS', base='Mashhad (14th TAB)'},
	}

	-- Stable output order
	local IranAirForceBases = {
		'Tehran (1st TAB)',
		'Tabriz (2nd TAB)',
		'Hamadan (3rd TAB)',
		'Dezful (4th TAB)',
		'Omidiyeh (5th TAB)',
		'Bushehr (6th TAB)',
		'Esfahan (8th TAB)',
		'Bandar Abbas (9th TAB)',
		'Chabahar (10th TAB)',
		'Mashhad (14th TAB)',
	}

	-- baseName -> array of <li>...</li>
	local BaseToLis = {}

	for _, sqn in ipairs(IranFighterSquadrons) do
		local aircraft = ScenEdit_GetUnit({side='Iran', name=sqn.name..' #1'})
		if aircraft then
			local li = '<li>'..sqn.name..' - '..aircraft.classname..'.</li>'

			if BaseToLis[sqn.base] == nil then
				BaseToLis[sqn.base] = {}
			end
			table.insert(BaseToLis[sqn.base], li)
		end
	end

	-- Build final HTML
	local htmlString = 'Air Bases<br><br>'

	for _, baseName in ipairs(IranAirForceBases) do
		local lis = BaseToLis[baseName]
		if lis ~= nil and #lis > 0 then
			htmlString = htmlString .. baseName .. '<br><ul>'
			for _, li in ipairs(lis) do
				htmlString = htmlString .. li
			end
			htmlString = htmlString .. '</ul><br>'
		end
	end

	-- Save + also set a global for immediate use
	ScenEdit_SetKeyValue('IranFighterSquadronsHtml', htmlString)
	_G.IranFighterSquadronsHtml = htmlString

	ScenEdit_SetMission('Iran', 'CAP Center East', {isactive=true})
	ScenEdit_SetMission('Iran', 'CAP Center West 1', {isactive=true})
	ScenEdit_SetMission('Iran', 'CAP Center West 2', {isactive=true})
	ScenEdit_SetMission('Iran', 'CAP North', {isactive=true})
	ScenEdit_SetMission('Iran', 'CAP South', {isactive=true})
	ScenEdit_SetMission('Iran', 'CAP Southeast', {isactive=true})
	ScenEdit_SetMission('Iran', 'CAP Southwest', {isactive=true})

	SetAircraftTimeToReady_ByMission('Iran', 'CAP Center East', GetRandomRoundedNumber(min, max, 5))
	SetAircraftTimeToReady_ByMission('Iran', 'CAP Center West 1', GetRandomRoundedNumber(min, max, 5))
	SetAircraftTimeToReady_ByMission('Iran', 'CAP Center West 2', GetRandomRoundedNumber(min, max, 5))
	SetAircraftTimeToReady_ByMission('Iran', 'CAP North', GetRandomRoundedNumber(min, max, 5))
	SetAircraftTimeToReady_ByMission('Iran', 'CAP South', GetRandomRoundedNumber(min, max, 5))
	SetAircraftTimeToReady_ByMission('Iran', 'CAP Southeast', GetRandomRoundedNumber(min, max, 5))
	SetAircraftTimeToReady_ByMission('Iran', 'CAP Southwest', GetRandomRoundedNumber(min, max, 5))

	if ScenarioYear() == 'mid2020' or ScenarioYear() == 'late2020' then
		ScenEdit_AddUnit({side='Iran', type='Facility', dbid=2611, name='Radar (Ghadir OTH-B)', latitude=38.7566944, longitude=44.9559444, autodetectable=true})
		ScenEdit_AddUnit({side='Iran', type='Facility', dbid=2611, name='Radar (Ghadir OTH-B)', latitude=27.8642167, longitude=51.6122972, autodetectable=true})
		ScenEdit_AddUnit({side='Iran', type='Facility', dbid=2611, name='Radar (Ghadir OTH-B)', latitude=26.3968611, longitude=57.1426111, autodetectable=true})
		ScenEdit_AddUnit({side='Iran', type='Facility', dbid=2611, name='Radar (Ghadir OTH-B)', latitude=33.5245361, longitude=46.3257833, autodetectable=true})
		ScenEdit_AddUnit({side='Iran', type='Facility', dbid=2611, name='Radar (Ghadir OTH-B)', latitude=32.1905250, longitude=55.6077889, autodetectable=true})
		ScenEdit_AddUnit({side='Iran', type='Facility', dbid=2612, name='Radar (Sepehr OTH-B)', latitude=36.8428000, longitude=50.3843583, autodetectable=true})
	end
end

-- =========================
-- Side Setup
-- =========================

function SideSetup(side)
	if side == 'Israel' then
		IsraelSideSetup(side)
		SetAircraftReadiness_BySide(side, 0)

		-- Delete unneeded sides and units
		ScenEdit_RemoveSide({name='Task Force 50'})
		ScenEdit_RemoveSide({name='United States'})
		ScenEdit_RemoveSide({name='United States-Israel'})

		-- Set Iranian aircraft loadouts and ready times
		IranSideSetup(120, 240)
	elseif side == 'United States' then
		UnitedStatesSideSetup(side)
		SetAircraftReadiness_BySide(side, 0)

		-- Delete unneeded sides
		ScenEdit_RemoveSide({name='Israel'})
		ScenEdit_RemoveSide({name='Syria'})
		ScenEdit_RemoveSide({name='United States-Israel'})

		-- Set Iranian aircraft loadouts and ready times
		IranSideSetup(0, 90)
	else -- United States-Israel
		-- Change unit sides first before executing side setup
		ChangeUnitSide('Israel', 'United States-Israel')
		ChangeUnitSide('United States', 'United States-Israel')
	
		IsraelSideSetup(side)
		UnitedStatesSideSetup(side)

		SetAircraftReadiness_BySide(side, 0)
		ScenEdit_AssignUnitToMission('TU 50.1.2', 'DESRON Patrol')

		-- Delete unneeded sides
		ScenEdit_RemoveSide({name='Israel'})
		ScenEdit_RemoveSide({name='United States'})

		-- Set Iranian aircraft loadouts and ready times
		IranSideSetup(0, 120)
	end
end

-- ==============================
-- Scenario Specific Functions --
-- ==============================

-- =========================
-- Serialiation Functions --
-- =========================

function serialize(dataTable)
	local serializedValueString = "{"
	for _, guid in ipairs(dataTable) do
		serializedValueString = serializedValueString .. '"' .. tostring(guid) .. '",'
	end
	serializedValueString = serializedValueString:sub(1, -2) .. "}" -- remove last comma and add closing bracket
	return serializedValueString
end

function deserialize(serializedDataString)
	local t = {}
	serializedDataString = serializedDataString:sub(2, -2) -- remove the curly braces
	for guid in serializedDataString:gmatch('"([^"]+)"') do
		table.insert(t, guid)
	end
	return t
end

function storeData(dataTable, keyStoreString)
	local serializedDataString = serialize(dataTable)
	print(serializedDataString)
	ScenEdit_SetKeyValue(keyStoreString, serializedDataString)
end

function retrieveData(keyStoreString)
	local serializedDataString = ScenEdit_GetKeyValue(keyStoreString)
	print(serializedDataString)
	if serializedDataString then
		return deserialize(serializedDataString)
	else
		return {}
	end
end

function setGlobalFromKeyStore(globalVarNameString, keyStoreString)
	local serializedDataString = ScenEdit_GetKeyValue(keyStoreString)
	print(serializedDataString)
	if serializedDataString then
		_G[globalVarNameString] = deserialize(serializedDataString)
	else
		_G[globalVarNameString] = {}
	end
end

-- =========================
-- Random Replace Aircraft
-- =========================

function SelectedAircraftOptions(optionsList, selection)
	local result = {}

	for _, aircraft in ipairs(optionsList) do
		if selection.UseHypotheticalOnly then
			if aircraft.isHypothetical == true then
				table.insert(result, aircraft)
			end
		else
			if (selection.UseExport or not aircraft.isExport) and (selection.UseHypothetical or not aircraft.isHypothetical) then
				table.insert(result, aircraft)
			end
		end
	end

	return result
end

function SelectRandomAircraft(aircraftList)
	if #aircraftList == 0 then return nil, nil end

	local selectedAircraft = aircraftList[math.random(1, #aircraftList)]
	local loadoutID = nil

	if selectedAircraft.loadouts then
		loadoutID = selectedAircraft.loadouts[math.random(1, #selectedAircraft.loadouts)].loadoutID
	else
		loadoutID = selectedAircraft.loadoutID
	end

	return selectedAircraft.dbid, loadoutID
end

function RandomReplaceAircraft(side, listOfAircraftToReplace, chance, aircraftList, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce, TimeToReady)
	for _,v in ipairs(listOfAircraftToReplace) do
		if math.random(1,100) <= chance then
			local AircraftDBID, AircraftLoadout = SelectRandomAircraft(aircraftList)
			ReplaceAircraft_ByName(side, v.num1, v.num2, AircraftDBID, v.name, AircraftLoadout, TimeToReady) -- Aircraft replaced by name allows for mix of aircraft types
			RandomizeMultipleUnitProficiency(side, v.num1, v.num2, v.name, chanceNovice, chanceCadet, chanceRegular, chanceVeteran, chanceAce)
		end
	end
end

-- =========================
-- Random Replace Aircraft
-- =========================

function SelectedAirDefenseOptions(optionsList, selection)
	local result = {}

	for _, sam in ipairs(optionsList) do
		local samType = sam.type

		if samType == "Domestic" and selection.UseIranDomestic then
			table.insert(result, sam)
		elseif samType == "Outdated" and selection.UseIranOutdated then
			table.insert(result, sam)
		elseif samType == "China" and selection.UseChina then
			table.insert(result, sam)
		elseif samType == "Russia" and selection.UseRussia then
			table.insert(result, sam)
		end
	end

	return result
end

-- =========================
-- Select Random Callsign
-- =========================

function RandomCallsign(callsignList)
	local index = math.random(1, #callsignList)
	local pickedCallsign = callsignList[index]

	table.remove(callsignList, index)

	return pickedCallsign
end

-- =========================
-- Add Carrier Aircraft
-- =========================

function AddCarrierAircraft(carrierGuid, carrierName, sideName, configType, squadronData)
	if not squadronData then
		print('Error: Squadron data is invalid.')
		return
	end

	local selectedConfig = airwingConfigs[configType]
	if not selectedConfig then
		print('Error: Invalid airwing configuration selected.')
		return
	end

	-- index -> { name, modex }
	local idxLookup = {}
	for _, sqn in ipairs(squadronData) do
		if sqn.index and sqn.name and sqn.modex then
			idxLookup[sqn.index] = { name = sqn.name, modex = sqn.modex }
		end
	end

	for i, entry in ipairs(selectedConfig) do
		local idx = entry.index
		if not idx then
			print('Warning: Config entry #' .. i .. ' has no index; skipping.')
		else
			local sqn = idxLookup[idx]
			if not sqn then
				print('Warning: No squadron for index ' .. idx .. ' on ' .. carrierName .. '; skipping.')
			elseif not entry.dbid or not entry.count or entry.count <= 0 then
				print('Warning: Incomplete config for index ' .. idx .. ' on ' .. carrierName .. '; skipping.')
			else
				local modexStart = sqn.modex
				local modexEnd = modexStart + entry.count - 1
				AddAircraft(
					sideName,
					modexStart,
					modexEnd,
					entry.dbid,
					sqn.name,
					carrierName,
					3,
					0
				)
			end
		end
	end
end

function AddCarrierTankerDetachment(carrierGuid, carrierName, sideName, squadronData)
	-- Find index 7 squadron slot (tanker det) from carrierList data
	local sqn = nil
	for _, s in ipairs(squadronData) do
		if s.index == 7 then
			sqn = s
			break
		end
	end

	if not sqn then
		print('Warning: No index 7 squadron found for ' .. carrierName .. '; skipping MQ-25.')
		return
	end

	local count = 5
	local modexStart = sqn.modex
	local modexEnd = modexStart + count - 1

	AddAircraft(
		sideName,
		modexStart,
		modexEnd,
		7563,
		sqn.name,
		carrierName,
		23125,
		0
	)
end

-- =========================
-- Add Carriers With Aircraft
-- =========================

function AddCarrierWithAirwing(sideName, numCarriersConfig1, numCarriersConfig2, numCarriersConfig3)
	local numCarriers = { numCarriersConfig1, numCarriersConfig2, numCarriersConfig3 }

	for configType = 1, 3 do
		local count = 0
		local i = 1
		while i <= #carrierList do
			if count >= (numCarriers[configType] or 0) then
				break
			end

			local carrier = carrierList[i]
			local addedCarrier = ScenEdit_AddUnit({
				type='Ship',
				name=carrier.name,
				dbid=carrier.dbid,
				side='Task Force 50',
				latitude=carrier.latitude,
				longitude=carrier.longitude,
				heading=270,
				speed=15,
				group='TU 50.1.1'
			})

			if addedCarrier then
				print('Added: ' .. carrier.name .. ' (Config ' .. configType .. ')')
				AddCarrierAircraft(addedCarrier.guid, carrier.name, sideName, configType, carrier.squadronData)

				if ScenarioYear == 'late2020' then
					AddCarrierTankerDetachment(addedCarrier.guid, carrier.name, sideName, carrier.squadronData)
				end

				table.remove(carrierList, i)
				count = count + 1
			else
				i = i + 1
			end
		end
	end
end

-- ====================
-- Scenario Features --
-- ====================

-- =======================
-- Automatic FARP Setup --
-- =======================

function LandingConditionsAreMet(aircraft, minAltitude, landingSpeed)
	local aircraftAltitude = ReturnUnitAltitudeAGL(aircraft.guid)
	if aircraft.unitstate ~= 'RTB' and aircraft.unitstate ~= 'RTB_Manual' then
		if not OverWater(aircraft.latitude, aircraft.longitude) and aircraftAltitude <= minAltitude and aircraft.speed <= landingSpeed and aircraft.airbornetime_v >= 300 then
			return true
		end
	end
	return false
end

function AddForwardRefuelingPoint(aircraft, TimeToReady)
	local FARP = ScenEdit_AddUnit({
		side=aircraft.side,
		type='Facility',
		dbid=1594,
		name='FARP',
		latitude=aircraft.latitude,
		longitude=aircraft.longitude,
		heading=0
	})
 
	ScenEdit_HostUnitToParent({HostedUnitNameOrID=aircraft.guid, SelectedHostNameOrID=FARP.guid})
	ScenEdit_SetLoadout({unitname=aircraft.guid, TimeToReady_Minutes=TimeToReady, IgnoreMagazines=true})
	ScenEdit_SetUnit({guid=aircraft.guid, course={}})
end

function SetupForwardRefuelingPoint()
	local PlayerSide = ScenEdit_PlayerSide()
	for _, aircraft in ipairs(CargoAircraftList) do
		local aircraftData = ScenEdit_GetUnit({side=PlayerSide, name=aircraft.name})
		if aircraftData then
			if LandingConditionsAreMet(aircraftData, aircraft.minAltitude, aircraft.landingSpeed) then
				AddForwardRefuelingPoint(aircraftData, aircraft.TimeToReady)
			end
		end
	end
end

-- =========================
-- Conduct Missile Strike on Selected Contacts
-- =========================

function ConductMissileStrikeOnSelectedContacts(firingUnitGUID, numMissilesAvailable, missileDBID, specialActionName, updateGlobalVariablesBoolean, numMissilesAvailableKey)
	local PlayerSide = ScenEdit_PlayerSide()
	local firingUnit = ScenEdit_GetUnit({guid=firingUnitGUID})

	-- Input the number of missiles to fire at each selected contact
	local numMissilesFired = ScenEdit_InputBox('Enter the number of missiles you want to fire at each selected contact(s). Remaining missiles on the '..firingUnit.name..': '..numMissilesAvailable..'.')

	-- Convert input to a number and validate
	numMissilesFired = tonumber(numMissilesFired)
	if not numMissilesFired or numMissilesFired <= 0 then
		ScenEdit_MsgBox('Invalid number of missiles entered. Please enter a valid number.', 0)
		return
	end

	-- Check if there are valid contacts selected
	local selectedUnits = ScenEdit_SelectedUnits()
	if not selectedUnits.contacts or #selectedUnits.contacts == 0 then
		ScenEdit_MsgBox('Please select valid contacts before performing this special action.', 0)
		return
	end

	-- Calculate the total number of missiles needed
	local totalMissilesFired = numMissilesFired * #selectedUnits.contacts
	if totalMissilesFired > numMissilesAvailable then
		ScenEdit_MsgBox('You do not have enough missiles. You are trying to fire a total of '..totalMissilesFired..' missiles, but only '..numMissilesAvailable..' are available.', 0)
		return
	end

	-- Fire missiles at the selected contacts
	for _,target in ipairs(selectedUnits.contacts) do
		ScenEdit_AttackContact(firingUnit.guid, target.guid, {mode=1, weapon=missileDBID, qty=numMissilesFired})
	end

	-- Update the number of available missiles
	numMissilesAvailable = numMissilesAvailable - totalMissilesFired

	-- Update global variable if desired
	-- This only updates the global variable key value
	-- Set the global variable to the new key value outside of this function
	if updateGlobalVariablesBoolean then
		ScenEdit_SetKeyValue(numMissilesAvailableKey, tostring(numMissilesAvailable))
	end

	-- Turn off special action if the number of available missiles equals 0
	if numMissilesAvailable == 0 then
		ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameOrID=specialActionName, isactive=false})
	end
end

-- ==================
-- Scenario Events --
-- ==================

-- =========================
-- Scenario Setup
-- =========================

function ScenarioSetup()
	local PlayerSide = ScenEdit_PlayerSide()

	ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameorID='Ready All Aircraft', isactive=false})

	-- Turn side specific actions on/off 
	if PlayerSide == 'Israel' then
		ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameOrID='Request Additional KC-46A Pegasus Tankers', isactive=false})
		ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameorID='Request Early KC-46A Pegasus Tanker Delivery', isactive=false})
		ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameorID='Request to Overfly Jordanian Airspace', isactive=false})
		ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameorID='Request US Missile Strikes', isactive=false})
		ScenEdit_SetSpecialAction({side=PlayerSide, ActionNameorID='Request US Tanker Support', isactive=false})
	elseif PlayerSide == 'United States' then
		-- Placeholder
	elseif PlayerSide == 'United States-Israel' then
		-- Placeholder
	end
end

-- =========================
-- Iran Initiates Hostilities
-- =========================

function IranInitiatesHostilities()
	local PlayerSide = ScenEdit_PlayerSide()
	ScenEdit_SetSidePosture('Iran', PlayerSide, 'H')
	ScenEdit_SetEMCON('Side', 'Iran', 'Radar=Active')

	ScenEdit_SetMission('Iran', 'CAP Center East', {CheckOPA=true})
	ScenEdit_SetMission('Iran', 'CAP Center West', {CheckOPA=true})
	ScenEdit_SetMission('Iran', 'CAP North', {CheckOPA=true})
	ScenEdit_SetMission('Iran', 'CAP South', {CheckOPA=true})
	ScenEdit_SetMission('Iran', 'CAP Southeast', {CheckOPA=true})
	ScenEdit_SetMission('Iran', 'CAP Southwest', {CheckOPA=true})
	ScenEdit_SetMission('Iran', 'QRA Long Range', {isactive=true})
	ScenEdit_SetMission('Iran', 'QRA Short Range', {isactive=true})
	SetSideMissionStatus('Civilian', false)

	ScenEdit_SetEvent('Iran Detects Unknown Aircraft', {isActive=false})
	ScenEdit_SetEvent('Iran Initiates Hostilities', {isActive=false})
	ScenEdit_SetEvent('Syria Detects Unknown Aircraft', {isActive=false})
end

-- Scenario Lua init 3 script

math.randomseed(os.time())
math.random()

-- ======================
-- Scenario Setup Menu --
-- ======================

function ScenarioSetupMenu()
	local htmlMenu = [=[
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<title>Scenario Setup Menu</title>
				<style>
					:root {
						--tabs-h: 52px;
						--marker-scale: 0.8;
						--airbase-marker-scale: 0.7;
						--naval-marker-scale: 0.8;
						--marker-label-scale: 0.8;
						--marker-label-font: 0.85rem;
						--marker-label-padding: 4px;
					}

					html, body {
						margin: 0;
						height: 100%;
						overflow: hidden;
						background: #1c1c1c;
					}

					/* ------------- */
					/* Category Tabs */
					/* ------------- */

					.tab-container {
						position: absolute;
						width: 100vw;
						background-color: #1c1c1c;
						display: flex;
						border: 2px solid #007bff;
						border-radius: 0px;
						box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.5);
						box-sizing: border-box;
						z-index: 1000;
					}

					.tab-button {
						flex: 1;
						padding: 12px;
						text-align: center;
						font-size: 1.2rem;
						font-weight: bold;
						color: lightgrey;
						background: none;
						border: none;
						cursor: pointer;
						text-transform: uppercase;
						transition: all 0.2s ease-in-out;
					}

					.tab-button:hover {
						background-color: rgba(0, 123, 255, 0.2);
					}

					.tab-button.active {
						background-color: #007bff;
						color: white;
					}

					.tab-content {
						position: absolute;
						left: 50px;
						display: none;
						color: lightgrey;
						padding: 20px;
						margin-top: 50px;
					}

					#scenario-settings.tab-content {
						position: absolute;
						top: var(--tabs-h);
						left: 0;
						right: 0;
						bottom: 0;
						margin: 0;
						padding: 0;
						overflow-y: auto;
						overflow-x: hidden;
						color: lightgrey;
					}

					#briefing.tab-content {
						position: absolute;
						top: var(--tabs-h);
						left: 0;
						right: 0;
						bottom: 0;
						margin: 0;
						padding: 0;
						overflow-y: auto;
						overflow-x: hidden;
						color: lightgrey;
					}

					#operations-map.tab-content {
						position: absolute;
						color: #00bfff;
						width: 100vw;
						top: var(--tabs-h);
						left: 0;
						right: 0;
						bottom: 0;
						margin: 0;
						padding: 0;
						overflow: hidden;
					}

					#summary.tab-content {
						overflow-y: auto;
						height: calc(100vh - var(--tabs-h));
					}

					#unit-cards.tab-content {
						position: absolute;
						color: #00bfff;
						top: var(--tabs-h);
						left: 0;
						right: 0;
						bottom: 0;
						margin: 0;
						padding-left: 0;
						flex-direction: column;
					}

					.tab-content h2 {
						font-size: 2.0rem;
						font-weight: bold;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.tab-content h3 {
						font-size: 1.75rem;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.tab-content p {
						font-size: 1.25rem;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						display: flex;
						justify-content: space-between;
						padding: 5px 10px;
						margin: 5px 0;
					}

					.tab-content li {
						font-size: 1.25rem;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.tab-content { display: none; }

					.tab-content.active { display: block; }

					.panel-content {
						font-size: 1rem;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						padding: 10px;
					}

					.setup-menu {
						background-color: #3e3e3e;
					}

					/* -------------- */
					/* Filter Toolbar */
					/* -------------- */

					.filter-toolbar {
						display: flex;
						gap: 20px;
						align-items: center;
						justify-content: center;
						flex-wrap: wrap;
						margin-top: -15px;
						margin-left: 8px;
						margin-bottom: 10px;
						padding: 10px;
						background-color: #3e3e3e;
						border: 2px solid #007bff;
						font-size: 1.2rem;
						font-weight: bold;
						color: lightgrey;
						text-align: center;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						width: calc(100vw - 40px);
					}

					.filter-toolbar strong {
						margin-right: 4px;
					}

					.filter-toolbar label {
						display: flex;
						align-items: center;
						gap: 6px;
						cursor: pointer;
					}

					.filter-toolbar button {
						background: #007bff;
						border: none;
						color: white;
						cursor: pointer;
						padding: 6px 10px;
						border-radius: 4px;
						font-weight: bold;
						text-transform: uppercase;
					}

					.filter-toolbar button:hover {
						background: #0056b3;
					}

					.is-hidden {
						display: none !important;
					}

					/* Hidden due to Year/Command gating */
					.is-hidden-gated {
						display: none !important;
					}

					/* -------------- */
					/* Scenario Setup */
					/* -------------- */

					.setup-options-container {
						width: calc(100vw - 40px);
						max-width: 980px;
						margin: 20px auto;
						padding: 0px 20px 20px 20px;
						box-sizing: border-box;
						font-family: "Share Tech Mono", monospace;
						color: lightgrey;
					}

					.setup-options-container b {
						color: #E0E0E0;
					}

					.setup-options-container h2 {
						font-size: 1.2rem;
						text-align: center;
						text-transform: uppercase;
						font-weight: bold;
						color: lightgrey;
						padding-bottom: 0px;
						margin-top: 0px;
						margin-bottom: 0px;
					}

					.setup-options-table {
						width: 100%;
						border-collapse: collapse;
						margin: auto;
						overflow: hidden;
					}

					.setup-options-table th,
					.setup-options-table td {
						border: 2px solid #007bff;
						padding: 10px;
						text-align: left;
						font-size: 1rem;
						color: lightgrey;
					}

					.setup-options-table th {
						background-color: rgba(0, 123, 255, 0.3);
						color: lightgrey;
						font-weight: bold;
						text-transform: uppercase;
					}

					.setup-options-table tr:nth-child(even) {
						background-color: rgba(0, 0, 0, 0.25);
					}

					.setup-options-table tr:hover {
						background-color: rgba(0, 123, 255, 0.18);
						transition: background 0.2s ease-in-out;
					}

					.setup-options-container p,
					.setup-options-container li,
					.setup-options-container span,
					.setup-options-container label {
						text-transform: none;
						font-size: 1rem;
						line-height: 1.35;
						font-family: "Share Tech Mono", monospace;
					}

					.setup-options-container p {
						display: block;
						justify-content: unset;
						padding: 0;
						margin: 6px 0;
					}

					.setup-options-container ul {
						margin: 2px 0 10px 32px;
						padding: 0;
					}

					.setup-options-select {
						width: auto;
						font-size: 1rem;
						font-family: "Share Tech Mono", monospace;
						background: rgba(28, 28, 28, 1.0);
						color: lightgrey;
						border: 1px solid rgba(0, 123, 255, 0.65);
						padding: 4px 6px;
						border-radius: 4px;
						box-sizing: border-box;
					}

					.setup-options-disabled {
						color: grey;
					}

					.setup-options-radio {
						margin-bottom: 10px;
						display: flex;
						align-items: flex-start;
						gap: 8px;
					}

					.setup-options-radio-description {
						display: flex;
						flex-direction: column;
					}

					.setup-options-radio input[type="radio"] {
						margin-top: 3px;
					}

					.setup-options-radio span {
						display: block;
					}

					.setup-options-radio.disabled {
						opacity: 1.0;
						pointer-events: none;
					}

					.setup-options-radio.disabled span,
					.setup-options-radio.disabled b,
					.setup-options-radio.disabled input[type="checkbox"] {
						color: grey;
						cursor: not-allowed;
					}

					.setup-options-radio details summary {
						font-size: 1.75rem;
						font-weight: bold;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						padding-bottom: 5px;
						cursor: pointer;
					}

					body.sar-disabled [data-sar="csar"] {
						display: none !important;
					}

					.sub-options-hidden {
						display: none;
					}

					/* ----------------- */
					/* Scenario Briefing */
					/* ----------------- */

					.briefing-container {
						width: calc(100vw - 40px);
						max-width: 980px;
						margin: 20px auto;
						padding: 0px 20px 20px 20px;
						box-sizing: border-box;
						font-family: "Share Tech Mono", monospace;
						color: lightgrey;
						line-height: 1.25;
					}

					.briefing-container h1 {
						font-size: 24px;
					}

					.briefing-container h2 {
						font-size: 1.25rem;
					}

					.briefing-container h1,
					.briefing-container h2 {
						margin: 18px 0 8px 0;
						padding: 0;
						text-transform: none;
					}

					.briefing-container p {
						display: block;
						padding: 0;
						margin: 10px 0;
						justify-content: unset;
						text-transform: none;
					}

					.briefing-container ul {
						margin: 6px 0 12px 0;
						padding-left: 22px;
						text-transform: none;
					}

					.briefing-container ul.nodot {
						list-style-type: none;
						padding: 0px;
					}

					.briefing-container li {
						text-transform: none;
					}

					/* ---------- */
					/* Unit Cards */
					/* ---------- */

					.unit-cards-header { 
						flex: 0 0 auto;
					}

					.unit-cards-scroll {
						flex: 1 1 auto;
						overflow-y: auto;
						display: flex;
						justify-content: center;
					}

					.unit-cards-container {
						height: calc(90vh - var(--tabs-h) + 20px);
						width: min(95vw, 2200px);
						display: grid;
						grid-template-columns: repeat(auto-fit, 420px);
						flex-wrap: wrap;
						gap: 15px;
						justify-content: flex-start;
						padding: 15px 0;
					}

					.unit-card {
						position: relative;
						border: 2px solid #007bff;
						border-radius: 8px;
						padding: 10px;
						background-color: rgba(28, 28, 28, 1.0);
						color: lightgrey;
						width: 400px;
						height: 580px;
						text-align: center;
						margin-bottom: 15px;
						box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.5);
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						padding: 10px;
						cursor: pointer;
						flex: 1 1 auto;
						max-width: 400px;
						min-width: 400px;
					}

					.unit-card-front,
					.unit-card-back {
						display: flex;
						flex-direction: column;
						justify-content: space-between;
					}

					.unit-card-back {
						display: none;
					}

					.unit-card-image-container {
						width: 400px;
						height: 225px;
						overflow: hidden;
					}

					.unit-card-image {
						width: 100%;
						height: auto;
						display: block;
					}

					.unit-card-info {
						padding: 10px;
					}

					.unit-card-name {
						font-size: 1.2rem;
						font-weight: bold;
						color: lightgrey;
						margin: 0;
						text-align: center;
						margin: 0px 0 10px 0;
					}

					.unit-card-description {
						font-size: 1.0rem !important;
						margin-bottom: 8px;
						color: lightgrey !important;
						text-align: left;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.unit-card-divider {
						border: 0;
						height: 1px;
						background: #007bff;
					}

					.unit-card-details-front {
						list-style-type: none;
						text-align: left;
						padding: 4px 10px;
					}

					.unit-card-front ul {
						margin-top: 4px;
						margin-bottom: 4px;
					}

					.unit-card-details-front li {
						font-size: 1.0rem !important;
						margin-bottom: 8px;
						color: lightgrey !important;
						text-align: left;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.unit-card-details-back {
						list-style-type: none;
						text-align: left;
						padding: 0px 10px;
						margin-top: 0px;
					}

					.unit-card-back ul {
						padding-left: 20px;
						margin-top: 8px;
						margin-right: -10px;
						margin-bottom: 8px;
						margin-left: 0;
					}

					.unit-card-details-back li {
						font-size: 1.0rem !important;
						margin-bottom: 5px;
						color: lightgrey !important;
						text-align: left;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.unit-card-back-scrunch li {
						font-size: 1.0rem !important;
						margin-bottom: 3px;
						color: lightgrey !important;
						text-align: left;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.unit-footer {
						font-size: 0.8rem;
						color: #00bfff;
						margin-top: 10px;
					}

					/* Adjust for medium screens to show 3 cards per row */
					@media (max-width: 1400px) {
						.unit-card {
							flex: 1 1 calc(33.33% - 15px); /* 3 cards per row */
						}
					}

					/* Adjust for small screens to show 2 cards per row */
					@media (max-width: 1000px) {
						.unit-card {
							flex: 1 1 calc(50% - 15px); /* 2 cards per row */
						}
					}

					/* Adjust for very small screens (phones) to show 1 card per row */
					@media (max-width: 600px) {
						.unit-card {
							flex: 1 1 100%; /* 1 card per row */
						}
					}

					/* -------------- */
					/* Operations Map */
					/* -------------- */

					.map-container {
						position: relative;
						inset: 0;
						width: 100%;
						height: 100%;
						display: block;
						background-size: cover;
						background-position: center;
					}

					#leafletOperationsMap {
						width: 100%;
						height: 100%;
						z-index: 900;
					}

					/* --------------------------------- */
					/* Operations Map Markers and Labels */
					/* --------------------------------- */

					.airbase-marker {
						transform-origin: center center;
					}

					.facility-marker {
						transform-origin: center center;
					}

					.naval-marker {
						transform-origin: center center;
					}

					.marker-label,
					.red-marker-label {
						font-size: var(--marker-label-font, 1rem);
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						text-align: center;
						white-space: nowrap;
						display: inline-flex;
						align-items: center;
						justify-content: center;
						line-height: 1.2;
					}

					/* Style the INNER box so padding/border don't change iconSize */
					.marker-label > div,
					.red-marker-label > div {
						padding: var(--marker-label-padding);
						background-color: #1c1c1c;
						border-radius: var(--marker-label-border-radius, 6px);
					}

					/* Blue label inner styling */
					.marker-label > div {
						color: #00bfff;
						border: 2px solid #007bff;
						box-shadow: 0px 0px 8px rgba(0, 123, 255, 0.5);
					}

					/* Red label inner styling */
					.red-marker-label > div {
						color: #ff4d4d;
						border: 2px solid #ff0000;
						box-shadow: 0px 0px 8px rgba(255, 0, 0, 0.5);
					}

					/* --------------------------- */
					/* Operations Map Popup Window */
					/* --------------------------- */

					.popup-window-container {
						position: fixed;
						top: 0;
						left: 0;
						width: 100vw;
						height: 100vh;
						background-color: rgba(0, 0, 0, 0.85);
						display: none;
						justify-content: center;
						align-items: center;
						z-index: 999;
					}

					.popup-window-content {
						background-color: #2c2c2c;
						border: 2px solid #007bff;
						border-radius: 0px;
						height: 85vh;
						width: 100vw;
						max-width: 1600px;
						margin-top: 50px;
						display: flex;
						box-shadow: 0 0 20px rgba(0, 123, 255, 0.7);
						position: relative;
					}

					.popup-window-container-left {
						position: fixed;
						top: 0;
						left: 0;
						width: 100vw;
						height: 100vh;
						background-color: rgba(0, 0, 0, 0.85);
						display: none;
						justify-content: center;
						align-items: center;
						z-index: 999;
					}

					.popup-window-content-left {
						background-color: #2c2c2c;
						border: 2px solid #007bff;
						border-radius: 0px;
						height: 85vh;
						width: 400px;
						margin-top: 50px;
						display: flex;
						flex-direction: column;
						box-shadow: 0 0 20px rgba(0, 123, 255, 0.7);
						position: relative;
					}

					.popup-window-header {
						position: absolute;
						width: 100%;
						text-align: center;
						padding-top: 10px;
						padding-bottom: 10px;
						background-color: #2c2c2c;
						border-bottom: 2px solid #007bff;
						z-index: 1;
					}

					.popup-window-header h2 {
						margin: 0;
						font-size: 1.6em;
						font-family: "Share Tech Mono", monospace;
						color: lightgrey;
					}

					.popup-window-left {
						width: min(350px, 20vw);
						min-width: 350px;
						margin-top: 30px;
						padding: 20px;
						border-right: 2px solid #007bff;
						overflow-y: auto;
					}

					.popup-window-left-summary {
						width: 400px;
						margin-top: 30px;
						padding-top: 20px;
						overflow-y: auto;
						display: flex;
						justify-content: center;
						align-items: flex-start;
					}

					.popup-window-right {
						flex-grow: 1;
						margin-top: 15px;
						padding: 20px;
						padding-top: 50px;
						overflow-y: auto;
						display: flex;
						flex-direction: column;
						align-items: stretch;
						align-content: flex-start;
						gap: 20px;
					}

					.popup-window-right-facility {
						flex-grow: 1;
						margin-top: 15px;
						padding: 20px;
						padding-top: 50px;
						overflow-y: auto;
						display: flex;
						flex-direction: column;
						align-content: flex-start;
					}

					.popup-window-right-top-segment {
						display: grid;
						grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
						align-content: flex-start;
						gap: 20px;
						margin: 0;
						padding: 0;
						border: none;
						background: none;
					}

					.popup-window-right-bottom-segment {
						display: grid;
						grid-template-columns: repeat(auto-fit, minmax(340px, 1fr));
						align-content: flex-start;
						gap: 20px;
						margin: 0;
						padding: 0;
						border: none;
						background: none;
					}

					/* ------------------- */
					/* Popup Options Table */
					/* ------------------- */

					.popup-window-table {
						width: 100%;
						border-collapse: collapse;
						margin: auto;
						overflow: hidden;
						font-family: "Share Tech Mono", monospace;
						font-size: 1rem;
						color: lightgrey;
					}

					.popup-window-table th,
					.popup-window-table td {
						border: 2px solid #007bff;
						padding: 10px;
						text-align: left;
						font-size: 1rem;
						color: lightgrey;
					}

					.popup-window-table th {
						background-color: rgba(0, 123, 255, 0.3);
						color: #00bfff;
						font-weight: bold;
						text-transform: uppercase;
					}

					.popup-window-table tr:nth-child(even) {
						background-color: rgba(0, 0, 0, 0.25);
					}

					.popup-window-table tr:hover {
						background-color: rgba(0, 123, 255, 0.18);
						transition: background 0.2s ease-in-out;
					}

					.popup-window-table td {
						vertical-align: top;
					}

					.popup-window-table td:nth-child(1) {
						width: 350px;
					}

					.popup-window-table td:nth-child(2) {
						width: auto;
					}

					.popup-window-table select {
						width: auto;
						font-family: "Share Tech Mono", monospace;
						background: rgba(28, 28, 28, 1.0);
						color: lightgrey;
						border: 1px solid rgba(0, 123, 255, 0.65);
						padding: 4px 6px;
						border-radius: 4px;
						box-sizing: border-box;
					}

					.popup-window-table-header {
						font-size: 18px;
						font-weight: bold;
						color: lightgrey;
						margin-left: 10px
					}

					.popup-window-table-list {
						list-style-type: none;
						margin: 2px 0 10px 10px;
						padding: 0;
					}

					.popup-window-table-list li {
						font-size: 1rem;
					}

					.popup-window-radio {
						margin-bottom: 10px;
						display: flex;
						align-items: flex-start;
						gap: 8px;
					}

					.popup-window-radio input[type="radio"] {
						margin-top: 3px;
						margin-left: 10px;
					}

					.popup-window-radio span {
						display: block;
					}

					.popup-window-table-options {
						min-height: var(--ship-options-min-height, 260px);
						display: grid;
						align-content: start;
						row-gap: 8px;
					}

					.popup-window-table-options-subblock {
						height: 300px;
						margin-top: 10px;
						padding: 10px;
						display: none;
					}

					.popup-window-table-options-subblock p {
						margin-top: 0px;
						margin-bottom: 8px;
					}

					.popup-window-button-container {
						display: flex;
						width: 350px;
						align-items: center;
						gap: 20px;
						background-color: rgba(0, 0, 0, 0.4);
						border: 1px solid #007bff;
						padding: 10px;
						border-radius: 6px;
					}

					.popup-window-button-container img {
						width: 100px;
						height: auto;
						border: 1px solid #007bff;
						margin-left: 10px;
					}

					.deploy-button {
						background-color: #007bff;
						color: white;
						border: none;
						padding: 10px 20px;
						margin-right: 10px;
						cursor: pointer;
						font-weight: bold;
						border-radius: 4px;
						transition: background-color 0.15s, box-shadow 0.15s;
					}

					.deploy-button:hover {
						background-color: #0056b3;
						box-shadow: none;
					}

					.deploy-button:active {
						background-color: #3399ff;
						box-shadow: 0px 0px 10px #66ccff;
						transition: background-color 0.1s, box-shadow 0.1s, background-color 0.05s linear 0s;
					}

					.undeploy-button {
						background-color: #ff1a1a;
						color: white;
						border: none;
						padding: 10px 20px;
						margin-right: 10px;
						margin-top: 10px;
						cursor: pointer;
						font-weight: bold;
						border-radius: 4px;
						transition: background-color 0.15s, box-shadow 0.15s;
					}

					.undeploy-button:hover {
						background-color: #b30000;
						box-shadow: none;
					}

					.undeploy-button:active {
						background-color: #ff4d4d;
						box-shadow: 0px 0px 10px #ff8080;
						transition: background-color 0.1s, box-shadow 0.1s, background-color 0.05s linear 0s;
					}

					.close-button {
						position: absolute;
						top: 12px;
						right: 10px;
						background-color: #ff4d4d;
						color: white;
						font-weight: bold;
						border: none;
						cursor: pointer;
						border-radius: 4px;
						padding: 5px 10px;
						transition: background 0.2s;
						z-index: 1000;
					}

					.close-button:hover {
						background-color: #ff1a1a;
					}

					p.unit-name {
						display: inline-block;
						background-color: #007bff;
						color: white;
						border: none;
						padding: 10px 20px;
						margin: 0 10px 0 0;
						font-weight: bold;
						border-radius: 4px;
						font-size: 1rem;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					/* ------------------------ */
					/* Air Base Summary Styling */
					/* ------------------------ */

					.operations-summary-table {
						background: rgba(0, 0, 0, 0.4);
						border: 2px solid #007bff;
						padding: 10px;
						margin: 15px 0;
						border-radius: 8px;
						box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.5);
					}

					.operations-summary-table h3 {
						font-size: 1.5rem;
						color: lightgrey;
						text-align: center;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						padding-bottom: 5px;
						margin-bottom: 10px;
					}

					.operations-summary-table p {
						font-size: 1rem;
						font-weight: bold;
						color: lightgray;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						display: flex;
						justify-content: space-between;
						padding: 5px 10px;
						margin: 5px 0;
						background: rgba(0, 0, 0, 0.2);
						border-radius: 4px;
						border: 1px solid #007bff;
						align-items: flex-end;
					}

					/* ---------------- */
					/* Popup Unit Cards */
					/* ---------------- */

					.unit-card-popup-container {
						position: fixed;
						top: 0;
						left: 0;
						width: 100vw;
						height: 100vh;
						background: rgba(0, 0, 0, 0.3);
						display: none;
						justify-content: center;
						align-items: center;
						z-index: 2000;
					}

					.unit-card-popup-content {
						padding: 20px;
						max-width: 90%;
						max-height: 90%;
						display: flex;
						flex-direction: column;
						gap: 20px;
						overflow-y: auto;
						border: none;
						background: none;
					}

					.unit-card-popup-summary {
						font-size: 1.2rem;
						font-weight: bold;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						text-align: center;
						margin-bottom: 15px;
					}

					.unit-card-popup-cards {
						display: grid;
						grid-template-columns: repeat(1, 1fr);
						gap: 20px;
						justify-content: center;
						justify-items: center;
						overflow-y: auto;
						overflow-x: hidden;
					}

					.close-card-popup {
						position: absolute;
						top: 8px;
						right: 8px;
						background: #ff4d4d;
						color: white;
						border: none;
						padding: 5px 10px;
						font-weight: bold;
						font-size: 0.8rem;
						cursor: pointer;
						border-radius: 4px;
						z-index: 2100;
					}

					.close-card-popup:hover {
						background: #ff1a1a;
					}

					.close-card-popup-multiunit {
						position: absolute;
						top: 8px;
						right: 8px;
						background: #ff4d4d;
						color: white;
						font-weight: bold;
						border: none;
						cursor: pointer;
						border-radius: 4px;
						padding: 5px 10px;
						font-size: 0.9rem;
						display: none;
						z-index: 2100;
					}

					.unit-card-popup-container.multi-unit .unit-card-popup-content {
						border: 2px solid #007bff;
						background-color: #2c2c2c;
						border-radius: 0px;
						padding: 20px 20px 10px 20px;
						box-shadow: 0 0 20px rgba(0, 123, 255, 0.7);
						position: relative;
					}

					.unit-card-popup-container.multi-unit .unit-card-popup-cards {
						grid-template-columns: repeat(3, 1fr);
					}

					.unit-card-popup-container.multi-unit .close-card-popup-multiunit {
						display: block;
					}

					.popup-card-trigger {
						border: 1px solid #007bff;
						transition: filter 0.15s ease, box-shadow 0.15s ease, border-color 0.15s ease;
					}

					.popup-card-trigger:hover {
						filter: brightness(1.2);
						border-color: #66ccff;
					}

					.popup-card-trigger:active {
						filter: brightness(1.3);
						border-color: #00bfff;
						box-shadow: 0 0 8px rgba(0, 191, 255, 0.7);
					}

					.unit-card-popup-cards::-webkit-scrollbar {
						display: none;
					}

					.unit-card-popup-title {
						font-size: 1.4rem;
						font-weight: bold;
						color: lightgrey;
						text-align: center;
						margin: 0 0 10px 0;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.unit-card-popup-list {
						font-size: 1rem;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						list-style-type: disc;
						padding-left: 20px;
						margin: 0 0 15px 0;
						text-align: left;
					}

					/* ---------------- */
					/* Facility Details */
					/* ---------------- */

					.facility-image-container {
						width: 800px;
						overflow: hidden;
					}

					.facility-image {
						width: 100%;
						height: auto;
						display: block;
					}

					.facility-info {
						font-size: 1rem;
						font-weight: bold;
						color: lightgray;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
					}

					.facility-description, 
					.facility-details li {
						width: 800px;
						text-align: left;
					}

					.facility-details {
						list-style-type: none;
						padding: 10px;
						text-align: left;
					}

					/* ----------------- */
					/* Summary Tab Table */
					/* ----------------- */

					.summary-container {
						display: flex;
						flex-wrap: wrap;
						gap: 40px;
						margin-bottom: 50px;
					}

					.summary-table {
						width: 450px;
						background: rgba(0, 0, 0, 0.4);
						border: 2px solid #007bff;
						padding: 10px;
						margin: 15px 0;
						border-radius: 8px;
						box-shadow: 0px 0px 10px rgba(0, 123, 255, 0.5);
					}

					.summary-table h2 {
						font-size: 2.0rem;
						font-weight: bold;
						color: lightgrey;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						text-align: center;
						margin-top: 0;
						margin-bottom: 10px;
					}

					.summary-table h3 {
						font-size: 1.5rem;
						color: lightgray;
						text-align: center;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						padding-bottom: 5px;
						margin-bottom: 10px;
					}

					.summary-table p {
						font-size: 1rem;
						font-weight: bold;
						color: lightgray;
						font-family: "Share Tech Mono", monospace;
						text-transform: uppercase;
						display: flex;
						justify-content: space-between;
						padding: 5px 10px;
						margin: 5px 0;
						background: rgba(0, 0, 0, 0.2);
						border-radius: 4px;
						border: 1px solid #007bff;
					}

					.divider-line {
						border: 0;
						height: 2px;
						background: #007bff;
						margin: 5px 0 5px 0;
					}
				</style>

				<!-- Leaflet CSS -->
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.css"/>
			</head>
			<body>
				<!-- Tab Navigation -->
				<div class="tab-container">
					<button class="tab-button active" onclick="showTab('scenario-settings', this)">Scenario Settings</button>
					<button class="tab-button" onclick="showTab('briefing', this)">Briefing</button>
					<button class="tab-button" onclick="showTab('operations-map', this)">Operations Map</button>
					<button class="tab-button" onclick="showTab('summary', this)">Summary</button>
					<button class="tab-button" onclick="showTab('unit-cards', this)">Unit Cards</button>
				</div>

				<!-- Scenario Setup Tab -->
				<div id="scenario-settings" class="tab-content active">
					<div class="setup-options-container">
						<table class="setup-options-table">
							<tr>
								<td>
									<p>
										<span><b>Scenario Year:</b></span>
										<span>
											<select name="scenario_year" class="setup-options-select">
												<option value="early2020">Early 2020s (2018-2022)</option>
												<option value="mid2020">Mid 2020s (2023-2027)</option>
												<option value="late2020">Late 2020s/Early 2030s (2028-2032)</option>
											</select>

											<input type="hidden" id="scenario_year_hidden" name="scenario_year_hidden" value="early2020">
										</span>
									</p>
								</td>
							</tr>
							<tr>
								<td>
									<p><h2>Event Chances</h2></p>
									<hr class="glowing-line">
									<label class="setup-options-radio">
										<input type="radio" name="scenario_event_chances" value="realistic" checked>
										<span><b>Realistic:</b> The success/failure chance for events and special actions are Kushan's estimate of how likely they would be.</span>
									</label>
									<label class="setup-options-radio">
										<input type="radio" name="scenario_event_chances" value="random">
										<span><b>Random:</b> The success chance for events and special actions are randomized.</span>
									</label>
									<label class="setup-options-radio">
										<input type="radio" name="scenario_event_chances" value="remove_random">
										<span><b>Remove Randomization:</b> Remove randomization for events and special actions. There will be a 100% chance of player special actions being successful. Conducting cyber actions will not reduce the success chance of successive actions.</span>
									</label>
								</td>
							</tr>
							<tr data-side="usa, usa-israel">
								<td>
									<p><h2>Basing Rights/Access</h2></p>
									<hr class="glowing-line">
									<p>
										<span><b>Enforce Basing Rights/Access:</b></span>
										<span>
											<select name="enable_basing_rights_access" class="setup-options-select">
												<option value="enable_basing_rights_false">No</option>
												<option value="enable_basing_rights_true" selected>Yes</option>
											</select>
										</span>
									</p>
									<p>When enabled, host-nation basing access will be randomized based on Scenario Year and Event Chances. Availability is randomized whenever one of those settings are changed. Bases not listed below are always available.</p>
									<div>
										<label class="setup-options-radio">
											<input type="checkbox" data-basing-country="saudi_arabia" data-basing-base-id="usa_air_base_1_menu" checked>
											<span><b>Saudi Arabia:</b> Prince Sultan AB</span>
										</label>
										<label class="setup-options-radio">
											<input type="checkbox" data-basing-country="qatar" data-basing-base-id="usa_air_base_2_menu" checked>
											<span><b>Qatar:</b> Al Udeid AB</span>
										</label>
										<label class="setup-options-radio">
											<input type="checkbox" data-basing-country="united_arab_emirates" data-basing-base-id="usa_air_base_3_menu" checked>
											<span><b>United Arab Emirates:</b> Al Dhafra AB</span>
										</label>
										<label class="setup-options-radio">
											<input type="checkbox" data-basing-country="kuwait" data-basing-base-id="usa_air_base_5_menu" checked>
											<span><b>Kuwait:</b> Ali Al Salem AB</span>
										</label>
										<label class="setup-options-radio" data-year="mid2020, late2020">
											<input type="checkbox" data-basing-country="jordan" data-basing-base-id="usa_air_base_6_menu" checked>
											<span><b>Jordan:</b> Muwaffaq Salti AB</span>
										</label>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<p><h2>Search and Rescue</h2></p>
									<hr class="glowing-line">
									<span><b>Enable Search and Rescue:</b></span>
									<span>
										<select name="enable_search_and_rescue" class="setup-options-select">
											<option value="enable_search_and_rescue_true">Yes</option>
											<option value="enable_search_and_rescue_false" selected>No</option>			
											<!-- Add more options here -->
										</select>
									</span>
									<p>When aircraft are destroyed there is a chance downed aircrew will be generated at its location. Rescuing the downed aircrew will reward points.</p>
								</td>
							</tr>
							<tr>
								<td>
									<p><h2>Fuel Usage</h2></p>
									<hr class="glowing-line">
									<label class="setup-options-radio">
										<input type="radio" name="player_fuel_usage" value="default" checked>
										<span><b>Default:</b> Default Command fuel usage.</span>
									</label>
									<label class="setup-options-radio">
										<input type="radio" name="player_fuel_usage" value="unlimited">
										<span><b>Unlimited:</b>  Aircraft will still use fuel but will be periodically refueled via in-game event. No tankers will be needed.</span>
									</label>
								</td>
							</tr>
							<tr>
								<td>
									<p><h2>Iranian Air Force</h2></p>
									<hr class="glowing-line">
									<span><b>Add Su-35 Squadrons:</b></span>
									<span>
										<select name="iran_add_su_35_squadrons" class="setup-options-select" data-reveal-target="iran_add_su35_options" data-reveal-when="iran_add_su_35_squadrons_true">
											<option value="iran_add_su_35_squadrons_false">No</option>
											<option value="iran_add_su_35_squadrons_true">Yes</option>
											<!-- Add more options here -->
										</select>
									</span>
									<br>
									<p>Adds twenty-four Su-35s from the rumored 2022 deal between Russia and Iran to Hamadan and Shiraz air bases.</p>
									<div id="iran_add_su35_options">
										<br>
										<span>Aircraft Options:</span>
										<br>
										<label>
											<input type="checkbox" name="iran_export_su_35" value="true" checked>
											Export Aircraft and Weapons.
										</label><br>
									</div>
									<hr class="glowing-line">
									<span><b>Upgrade F-4, F-5, and MiG-21 Squadrons:</b></span>
									<span>
										<select name="iran_upgrade_legacy_aircraft" class="setup-options-select" data-reveal-target="iran_upgrade_legacy_aircraft_options" data-reveal-when="iran_upgrade_legacy_aircraft_true">
											<option value="iran_upgrade_legacy_aircraft_true">Yes</option>
											<option value="iran_upgrade_legacy_aircraft_false" selected>No</option>
											<!-- Add more options here -->
										</select>
									</span>
									<div id="iran_upgrade_legacy_aircraft_options">
										<br>
										<span>Select Available Aircraft:</span>
										<div class="checkbox-group" data-group="iran_legacy_aircraft" data-fallback="first">
											<label><input type="checkbox" class="upgrade-option" name="iran_legacy_aircraft_export" value="true" checked> Export Aircraft and Weapons.</label><br>
											<label><input type="checkbox" class="upgrade-option" name="iran_legacy_aircraft_hypothetical" value="true"> Existing & Hypothetical Aircraft.</label><br>
											<label><input type="checkbox" class="none-option" name='iran_legacy_aircraft_hypothetical_only' value="true"> Only Hypothetical Aircraft.</label>
										</div>
									</div>
									<hr class="glowing-line">
									<span><b>Upgrade F-14 and MiG-29 Squadrons:</b></span>
									<span>
										<select name="iran_upgrade_modern_aircraft" class="setup-options-select" data-reveal-target="iran_upgrade_modern_aircraft_options" data-reveal-when="iran_upgrade_modern_aircraft_true">
											<option value="iran_upgrade_modern_aircraft_true">Yes</option>
											<option value="iran_upgrade_modern_aircraft_false" selected>No</option>		
											<!-- Add more options here -->
										</select>
									</span>
									<div id="iran_upgrade_modern_aircraft_options">
										<br>
										<span>Select Available Aircraft:</span>
										<div class="checkbox-group" data-group="iran_modern_aircraft" data-fallback="first">
											<label><input type="checkbox" class="upgrade-option" name="iran_modern_aircraft_export" value="true" checked> Export Aircraft and Weapons.</label><br>
											<label><input type="checkbox" class="upgrade-option" name="iran_modern_aircraft_hypothetical" value="true"> Existing & Hypothetical Aircraft.</label><br>
											<label><input type="checkbox" class="none-option" name='iran_modern_aircraft_hypothetical_only' value="true"> Only Hypothetical Aircraft.</label>
										</div>
									</div>
									<hr class="glowing-line">
									<span><b>Use Hypothetical Loadouts:</b></span>
									<span>
										<select name="iran_use_hypothetical_loadouts" class="setup-options-select">
											<option value="iran_use_hypothetical_loadouts_true">Yes</option>
											<option value="iran_use_hypothetical_loadouts_false" selected>No</option>
											<!-- Add more options here -->
										</select>
									</span>
									<p>Iranian aircraft that are not upgraded will have their loadouts randomized. This setting determines if they can use hypothetical loadouts.</p>
									<hr class="glowing-line">
									<details>
										<summary><b>Glossary</b> <i>(Click to Expand/Collapse)</i></summary>
										<p><b>Use Export Aircraft & Weapons:</b> Only export aircraft and weapons will be available.</p>
										<p><b>Use Hypothetical Aircraft & Weapons:</b> Determines if hypothetical aircraft and loadouts are available.<br>
										Example 1: If Su-57 Felons or F-14E Super Tomcats are available to replace existing Iranian aircraft.<br>
										Example 2: MiG-29's with Fakour-90's [Mod. AIM-54A/MIM-23 HAWK].</p>
										<p><b>Aircraft Upgrade Options:</b> Possible aircraft depends on what combination of the "Use Export" and "Use Hypothetical Aircraft" settings is selected.</p>
										<table class="options-table">
											<thead>
												<tr>
													<th>Settings</th>
													<th>Aircraft Pool</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td><b>Export: ON<br>Hypothetical: OFF</b></td>
													<td>Export variants of the Su-35S and J-10C.</td>
												</tr>
												<tr>
													<td><b>Export: OFF<br>Hypothetical: OFF</b></td>
													<td>Non-export variants of the Su-35S and J-10C.</td>
												</tr>
												<tr>
													<td><b>Export: ON<br>Hypothetical: ON</b></td>
													<td>Export variants of the Su-35S and J-10C variants and hypothetical Su-57 and F-14E Super Tomcat-21.</td>
												</tr>
												<tr>
													<td><b>Export: OFF<br>Hypothetical: ON</b></td>
													<td>Non-export Su-35S and J-10C variants and hypothetical Su-57 and F-14E Super Tomcat-21.</td>
												</tr>
												<tr>
													<td><b>Hypothetical Only: ON</b></td>
													<td>Hypothetical Su-57 and F-14E Super Tomcat-21 only.</td>
												</tr>
											</tbody>
										</table>
									</details>
								</td>
							</tr>
							<tr>
								<td>
									<p><h2>Iranian Air Defenses</h2></p>
									<hr class="glowing-line">
									<span><b>Amount of Random AAA:</b></span>
									<span>
										<select name="iran_amount_of_random_aaa" class="setup-options-select">
											<option value="iran_amount_of_random_aaa_sparse">Sparse</option>
											<option value="iran_amount_of_random_aaa_moderate" selected>Moderate</option>
											<option value="iran_amount_of_random_aaa_dense">Dense</option>
											<option value="iran_amount_of_random_aaa_random">Random</option>
											<!-- Add more options here -->
										</select>
									</span>
									<br><br>
									<span><b>Amount of Natanz AAA:</b></span>
									<span>
										<select name="iran_amount_of_natanz_aaa" class="setup-options-select">
											<option value="iran_amount_of_natanz_aaa_sparse" selected>Sparse</option>
											<option value="iran_amount_of_natanz_aaa_moderate">Moderate</option>
											<option value="iran_amount_of_natanz_aaa_dense">Dense</option>
											<option value="iran_amount_of_natanz_aaa_very_dense">Very Dense</option>
											<option value="iran_amount_of_natanz_aaa_random">Random</option>
											<!-- Add more options here -->
										</select>
									</span>
									<p><i>Designer Note: Imagery from May 2022 indicates that most of the AAA around the Natanz facility has been removed. Correspondingly by default there is a very low amount of AAA placed during scenario setup.</i></p>
									<hr class="glowing-line">
									<span><b>Amount of Random SAMs:</b></span>
									<span>
										<select name="iran_amount_of_air_defenses" class="setup-options-select">
											<option value="iran_amount_of_air_defenses_sparse">Sparse</option>
											<option value="iran_amount_of_air_defenses_moderate" selected>Moderate</option>
											<option value="iran_amount_of_air_defenses_dense">Dense</option>
											<option value="iran_amount_of_air_defenses_random">Random</option>
											<!-- Add more options here -->
										</select>
									</span>
									<br><br>
									<span><b>Randomize/Upgrade Preplaced SAMs:</b></span>
									<span>
										<select name="iran_upgrade_preplaced_air_defenses" class="setup-options-select">
											<option value="iran_upgrade_preplaced_air_defenses_false" selected>No</option>
											<option value="iran_upgrade_preplaced_air_defenses_true">Yes</option>
											<!-- Add more options here -->
										</select>
									</span>
									<br><br>
									<span>Select Available SAM Systems:
									<br>
									<div class="checkbox-group" data-group="iran_air_defenses" data-fallback="first-two">
										<label><input type="checkbox" class="upgrade-option" name="iran_air_defenses_domestic" value="true" checked> Iran (Modern)</label><br>
										<label><input type="checkbox" class="upgrade-option" name="iran_air_defenses_outdated" value="true" checked> Iran (Outdated)</label><br>
										<label><input type="checkbox" class="upgrade-option" name="iran_air_defenses_china" value="true"> China</label><br>
										<label><input type="checkbox" class="upgrade-option" name="iran_air_defenses_russia" value="true"> Russia</label><br>
									</div>
									<hr class="glowing-line">
									<span><b>Randomize/Upgrade Radars:</b></span>
									<span>
										<select name="iran_upgrade_radars" class="setup-options-select" data-reveal-target="iran_upgrade_radars_options" data-reveal-when="iran_upgrade_radars_true">
											<option value="iran_upgrade_radars_false" selected>No</option>
											<option value="iran_upgrade_radars_true">Yes</option>
											<!-- Add more options here -->
										</select>
									</span>
									<div id="iran_upgrade_radars_options">
										<br>
										<span>Select Available Radars:</span>
										<br>
										<div class="checkbox-group" data-group="iran_radars" data-fallback="first-two">
											<label><input type="checkbox" class="upgrade-option" name="iran_radar_domestic" value="true" checked> Iran (Modern)</label><br>
											<label><input type="checkbox" class="upgrade-option" name="iran_radar_outdated" value="true" checked> Iran (Outdated)</label><br>
											<label><input type="checkbox" class="upgrade-option" name="iran_radar_china" value="true"> China</label><br>
											<label><input type="checkbox" class="upgrade-option" name="iran_radar_russia" value="true"> Russia</label><br>
										</div>
									</div>
									<hr class="glowing-line">
									<details>
										<summary><b>Glossary</b> <i>(Click to Expand/Collapse)</i></summary>
										<ul>
											<li><b>Iran (Modern):</b> Allows "modern" Iranian systems.</li>
											<li><b>Iran (Outdated):</b> Allows older Iranian systems.</li>
											<li><b>China:</b> Allows modern Chinese systems.</li>
											<li><b>Russia:</b> Allows modern Russianm systems.</li>
										</ul>
									</details>
								</td>
							</tr>
							<tr data-side="israel, usa-israel">
								<td>
									<p><h2>Syrian IADS</h2></p>
									<hr class="glowing-line">
									<span><b>Remove Syria IADS:</b></span>
									<span>
										<select name="remove_syria_iads" class="setup-options-select">
											<option value="remove_syria_iads_true">Yes</option>
											<option value="remove_syria_iads_false">No</option>			
											<!-- Add more options here -->
										</select>
									</span>
									<p><i>Designer Note: In real world operations, the Syrian IADS as proven to be completely ineffective against IAF operations. However, it may complicate yours.</i></p>
								</td>
							</tr>
						</table>
					</div>
				</div>

				<!-- Briefing Tab -->
				<div id="briefing" class="tab-content">
					<div class="briefing-container">
						<h1>Situation</h1>
						<p data-side="israel">A month ago, Iran's leader overturned the fatwa against the acquisition, development, and use of nuclear weapons. The next day, indications surfaced of a nuclear detonation in a remote part of the country and confirmed shortly after by the Iranian government. With the United States distracted by domestic and other international issues they will not act directly, so it will be up to us alone to deal with the situation. It's unlikely we'll be able to completely destroy the Iranian nuclear program, short of conducting a nuclear strike ourselves, but we can try to delay their acquisition of additional nuclear devices.</p>
						<p data-side="israel">Iran has undoubtedly raised its own alert status. Despite the risks, this strike is of utmost importance to the survival of our country and thus must be carried out.</p>

						<p data-side="usa, usa-israel">Negotiations on Iran's nuclear program have completely broken down. Iran announced it will not sign any agreement that limits its nuclear or ballistic missile programs. This was followed by Iran's leader overturning the fatwa against the acquisition, development, and use of nuclear weapons. A nuclear armed Iran would be an intolerable situation. If we do not act it will have global repercussions. It would pose an extreme threat not only to our forces and allied nations in the region, but all over the world. It's unlikely we'll be able to completely destroy the Iranian nuclear program, short of conducting a nuclear strike ourselves, but we can try to further delay their acquisition of nuclear devices.</p>

						<h1>Enemy Forces</h1>
						<p>The Iranian Air Force consists mostly of American fighters from the 1960s and 1970s; F-4 Phantoms, F-14 Tomcats, and F-5 Freedom Fighters. They also have a single squadron of MiG-29s based in Tehran. Of these, the F-14's based at Esfahan are the most dangerous. The Phoenix / Fakour-90 (Max Range: 81 nm) these aircraft are armed with is the longest-range missile in the Iranian inventory. The F-14's and F-4's can both be armed with the semi-active radar homing Sparrow III missile. It has a shorter range (Max Range: 16 nm) than the Phoenix but is more effective against fighter-sized aircraft.</p>
						<p>Iranian air defenses consist of Soviet era radars and SAM systems, some Chinese copies, American made I-HAWK SAMs from the same time period, and new Iranian domestic systems. The two most advanced, and dangerous, SAM systems in the Iranian inventory are the SA-20 [S-300OPMU-2] and the Iranian Bavar-373. At least one battalion of SA-20s is likely deployed near Bandar Abbas and Esfahan. The others are most likely concentrated around Tehran.</p>
						<p>Each of the nuclear sites has a network of preconstructed AAA and SAM sites. We are waiting for additional satellite imagery to determine what, if anything, occupies these positions.</p>
						<ul class="nodot">
							<li><b>Arak Heavy Water Plant: </b>AAA - 64, SAM - 6.</li>
							<li><b>Esfahan Uranium Conversion Facility: </b>AAA - 60, SAM - 0.</li>
							<li><b>Fordow Fuel Enrichment Plant: </b>AAA - 22, SAM - 7.</li>
							<li><b>Natanz Fuel Enrichment Plant: </b>AAA - 172, SAM - 11.</li>
						</ul>
						<h2>Air Bases:</h2>
						<ul>
							<li><b>Tehran (1st TAB)</b>
								<ul>
									<li>11 TFS - MiG-29 Fulcrum A.</li>
								</ul>
							</li>
							<li><b>Tabriz (2nd TAB)</b>
								<ul>
									<li>22 TFS - MiG-29 Fulcrum A.</li>
								</ul>
							</li>
							<li><b>Hamadan (3rd TAB)</b>
								<ul>
									<li>31 TFS - F-4E Phantom II.</li>
								</ul>
							</li>
							<li><b>Dezful (4th TAB)</b>
								<ul>
									<li>41 TFS - F-5E Tiger II.</li>
									<li>43 TFS - F-5F Tiger II.</li>
								</ul>
							</li>
							<li><b>Omidiyeh (5th TAB)</b>
								<ul>
									<li>51 TFS - F-7N Fishcan [MiG-21 Copy].</li>
									<li>52 TFS - F-7N Fishcan [MiG-21 Copy].</li>
									<li>53 TFS - F-7N Fishcan [MiG-21 Copy].</li>
								</ul>
							</li>
							<li><b>Bushehr (6th TAB)</b>
								<ul>
									<li>64 TFS - F-4D Phantom II.</li>
								</ul>
							</li>
							<li><b>Esfahan (8th TAB)</b>
								<ul>
									<li>81 TFS -  F-14A Tomcat.</li>
									<li>82 TFS -  F-14A Tomcat.</li>
									<li>83 TFS -  F-14A Tomcat.</li>
								</ul>
							</li>
							<li><b>Bandar Abbas (9th TAB)</b>
								<ul>
									<li>91 TFS - F-4E Phantom II.</li>
								</ul>
							</li>
							<li><b>Chabahar (10th TAB)</b>
								<ul>
									<li>101 TFS - F-4D Phantom II.</li>
								</ul>
							</li>
							<li><b>Mashhad (14th TAB)</b>
								<ul>
									<li>141 TFS - F-5E Tiger II.</li>
								</ul>
							</li>
						</ul>

						<p><i>Designer Note: The aircraft displayed above do not reflect upgrade selections made during scenario setup. You will receive an intel update message shortly after the scenario starts with the actual aircraft used by each squadron. This message can be replayed via special actions.</i></p>

						<h1>Friendly Forces</h1>
						<p data-side="usa-israel"><b>United States:</b></p>
						<p data-side="usa, usa-israel">In addition to the USAF reconnaissance and refueling squadrons assigned to the Ninth Air Force - fighter, bomber, and refueling squadrons in CONUS and Europe have been alerted and are standing by for deployment to the region.</p>
						<p data-side="usa, usa-israel">The US Navy has deployed four destroyers to the Arabian Sea. The carriers USS Harry S. Truman (CVN-75), USS Abraham Lincoln (CVN-72), USS George H.W. Bush (CVN-77), and USS Gerald R. Ford (CVN-78) have also been alerted for possible deployment.</p>

						<p data-side="usa-israel"><b>Israel:</b></p>
						<p data-side="israel, usa-israel">The entirety of the IAF front line fighter inventory will be available to you. Of these, the F-15Is, F-16Is, and F-35Is are the most advanced. The F-15I can carry the GBU-28C/B Deep Throat laser guided bomb. It's a 4700lb penetrator, ideal for use against underground facilities.</p>
						<p data-side="israel, usa-israel">A wing of Jericho III IRBMs with conventional warheads has also been made available.</p>

						<h1>Mission</h1>
						<p>There are four primary Iranian nuclear sites related to the development of nuclear weapons; Arak Heavy Water Plant, Esfahan Uranium Conversion Facility, Fordow Fuel Enrichment Plant, and the Natanz Fuel Enrichment Plant.</p>
						<ul>
							<li><b>Arak Heavy Water Plant:</b> Produces heavy water for use in nuclear reactors. Heavy water is used as a neutron moderator in certain types of nuclear reactors that can produce weapons-grade plutonium as a byproduct. It is part of the larger Arak Nuclear Complex, along with the neighboring IR-40 reactor.</li>
							<li><b>Esfahan Uranium Conversion Facility:</b> Located southeast of Esfahãn city, it is Iran's largest nuclear scientific center. Converts raw uranium ore into uranium hexafluoride (UF6) gas, which is then used in the uranium enrichment process.</li>
							<li><b>Fordow Fuel Enrichment Plant:</b> Underground facility near Qom, Iran. It is Iran's second uranium enrichment facility that is capable of producing weapons-grade uranium.</li>
							<li data-year="early2020, mid2020"><b>Natanz Fuel Enrichment Plant:</b> The primary Iranian uranium enrichment site. It houses thousands of centrifuges that enrich uranium to various levels, including weapons-grade levels. According to Iranian authorities, the underground facility is 40-50 meters (130-160 feet) underground and is protected by a concrete shield with a thickness of approximately 7.6 meters (25 feet), for safety reasons and to protect it from possible air attack.</li>
							<li data-year="late2020"><b>Natanz Fuel Enrichment Plant:</b> The original Natanz Fuel Enrichment Plant was destroyed by US and Israeli strikes in 2025. The new plant began construction in the mid 2020s and was recently completed. It is located under the mountains south of the old Natanz facility.</li>
						</ul>
						<p data-side="israel">With the available resources, it is recommended that you attack the Natanz, Arak, and/or Esfahan facilities.</p>
						<p>DO NOT under any circumstances damage the nuclear reactors at the Arak and Esfahan facilities.</p>
					</div>
				</div>

				<!-- Operations Map Tab -->
				<div id="operations-map" class="tab-content">
					<!-- Main Operations Map -->
					<div class="map-container" id="mapContainer">
						<!-- Leaflet map will render here -->
						<div id="leafletOperationsMap"></div>
					</div>

					<!-- Prince Sultan Air Base Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_1_menu">
						<div class="popup-window-content">
							<div class="popup-window-header">
								<h2>Prince Sultan Air Base</h2>
								<button class="close-button" onclick="closePopupWindow('usa_air_base_1_menu')">X</button>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_1_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_1_f15c">0</span></p>
									<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_1_f15e">0</span></p>
									<p data-year="late2020"><strong>F-15EX Strike Eagle:</strong> <span id="usa_air_base_1_f15ex">0</span></p>
									<p><strong>F-16C Viper:</strong> <span id="usa_air_base_1_f16c">0</span></p>
									<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_1_f22a">0</span></p>
									<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_1_f35a">0</span></p>
									<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_1_fqxx">0</span></p>
									<p data-year="late2020"><strong>E-2D Hawkeye:</strong> <span id="usa_air_base_1_e2d">0</span></p>
									<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_1_e3g">0</span></p>
									<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_1_e7a">0</span></p>
									<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_1_ea18g">0</span></p>
									<p data-year="late2020"><strong>EA-37B Dragon:</strong> <span id="usa_air_base_1_ea37b">0</span></p>
									<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_1_ec130h">0</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_1_kc10a">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_1_kc46a">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_1_kc135r">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_1_c17a">0</span></p>
									<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_1_hc130">0</span></p>
									<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_1_mc130">0</span></p>
									<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_1_hh60g">0</span></p>
									<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_1_hh60w">0</span></p>
									<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_1_mq9a">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_1_lucasARM">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_1_lucasEOIR">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="F-15C Eagle" class="popup-card-trigger" data-unit-id="f15c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'f15c', 12)">Deploy F-15C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'f15c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="F-15E Strike Eagle" class="popup-card-trigger" data-unit-id="f15e">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'f15e', 12)">Deploy F-15E Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'f15e', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="F-15EX Eagle II" class="popup-card-trigger" data-unit-id="f15ex">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'f15ex', 12)">Deploy F-15EX Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'f15ex', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="F-16C Viper" class="popup-card-trigger" data-unit-id="f16c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'f16c', 12)">Deploy F-16C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'f16c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/iioBDP1.jpeg" alt="F-22A Raptor" class="popup-card-trigger" data-unit-id="f22a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'f22a', 12)">Deploy F-22A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'f22a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/yWZYfgP.jpeg" alt="F-35A Lightning II" class="popup-card-trigger" data-unit-id="f35a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'f35a', 12)">Deploy F-35A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'f35a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="FQ-XX CCA" class="popup-card-trigger" data-unit-id="fqxx">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'fqxx', 12)">Deploy FQ-XX Expeditionary Fighter Drone Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'fqxx', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/8Pn8jBY.jpeg" alt="E-2D Advanced Hawkeye" class="popup-card-trigger" data-unit-id="e2d">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'e2d', 5)">Deploy E-2D Expeditionary Airborne Command and Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'e2d', 5)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/fCxxDEN.jpeg" alt="E-3G Sentry" class="popup-card-trigger" data-unit-id="e3g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'e3g', 4)">Deploy E-3G Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'e3g', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/uTD6DkO.jpeg" alt="E-7A Wedgetail" class="popup-card-trigger" data-unit-id="e7a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'e7a', 4)">Deploy E-7A Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'e7a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="EA-18G Growler" class="popup-card-trigger" data-unit-id="ea18g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'ea18g', 7)">Deploy EA-18G Expeditionary Electronic Attack Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'ea18g', 7)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/LP3QSu8.jpeg" alt="EA-37B Compass Call" class="popup-card-trigger" data-unit-id="ea37b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'ea37b', 4)">Deploy EA-37B Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'ea37b', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/VxkMYYf.jpeg" alt="EC-130H Compass Call" class="popup-card-trigger" data-unit-id="ec130h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'ec130h', 4)">Deploy EC-130H Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'ec130h', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'c17a', 4)">Deploy C-17A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60g"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60G Credible Hawk"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 1, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 1, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60w"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60W Jolly Green II"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 1, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 1, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i1cuBxO.jpeg" alt="MQ-9A Reaper" class="popup-card-trigger" data-unit-id="mq9a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'mq9a', 12)">Deploy MQ-9A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'mq9a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS ARM" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'lucasARM', 1)">Deploy LUCAS (ARM) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'lucasARM', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS EO/IR" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 1, 'lucasEOIR', 1)">Deploy LUCAS (EO/IR) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 1, 'lucasEOIR', 1)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Hidden Inputs for Lua Export -->
						<input type="hidden" id="usa_air_base_1_f15c_input" name="usa_air_base_1_f15c" value="0">
						<input type="hidden" id="usa_air_base_1_f15e_input" name="usa_air_base_1_f15e" value="0">
						<input type="hidden" id="usa_air_base_1_f15ex_input" name="usa_air_base_1_f15ex" value="0">
						<input type="hidden" id="usa_air_base_1_f16c_input" name="usa_air_base_1_f16c" value="0">
						<input type="hidden" id="usa_air_base_1_f22a_input" name="usa_air_base_1_f22a" value="0">
						<input type="hidden" id="usa_air_base_1_f35a_input" name="usa_air_base_1_f35a" value="0">
						<input type="hidden" id="usa_air_base_1_fqxx_input" name="usa_air_base_1_fqxx" value="0">
						<input type="hidden" id="usa_air_base_1_e2d_input" name="usa_air_base_1_e2d" value="0">
						<input type="hidden" id="usa_air_base_1_e3g_input" name="usa_air_base_1_e3g" value="0">
						<input type="hidden" id="usa_air_base_1_e7a_input" name="usa_air_base_1_e7a" value="0">
						<input type="hidden" id="usa_air_base_1_ea18g_input" name="usa_air_base_1_ea18g" value="0">
						<input type="hidden" id="usa_air_base_1_ea37b_input" name="usa_air_base_1_ea37b" value="0">
						<input type="hidden" id="usa_air_base_1_ec130h_input" name="usa_air_base_1_ec130h" value="0">
						<input type="hidden" id="usa_air_base_1_kc10a_input" name="usa_air_base_1_kc10a" value="0">
						<input type="hidden" id="usa_air_base_1_kc46a_input" name="usa_air_base_1_kc46a" value="0">
						<input type="hidden" id="usa_air_base_1_kc135r_input" name="usa_air_base_1_kc135r" value="0">
						<input type="hidden" id="usa_air_base_1_c17a_input" name="usa_air_base_1_c17a" value="0">
						<input type="hidden" id="usa_air_base_1_rescuesqn_input" name="usa_air_base_1_rescuesqn" value="0">
						<input type="hidden" id="usa_air_base_1_mq9a_input" name="usa_air_base_1_mq9a" value="0">
						<input type="hidden" id="usa_air_base_1_lucasARM_input" name="usa_air_base_1_lucasARM" value="0">
						<input type="hidden" id="usa_air_base_1_lucasEOIR_input" name="usa_air_base_1_lucasEOIR" value="0">
					</div>

					<!-- Al Udeid Air Base Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_2_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_2_menu')">X</button>
							<div class="popup-window-header">
								<h2>Al Udeid Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_2_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_2_f15c">0</span></p>
									<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_2_f15e">0</span></p>
									<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_2_f15ex">0</span></p>
									<p><strong>F-16C Viper:</strong> <span id="usa_air_base_2_f16c">0</span></p>
									<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_2_f22a">0</span></p>
									<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_2_f35a">0</span></p>
									<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_2_fqxx">0</span></p>
									<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_2_b1b">0</span></p>
									<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_2_b1r">0</span></p>
									<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_2_b52h">0</span></p>
									<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_2_b52j">0</span></p>
									<p data-year="early2020"><strong>E-8C Joint STARS:</strong> <span>1</span></p>
									<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_2_ea18g">0</span></p>
									<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="usa_air_base_2_ea37b">0</span></p>
									<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_2_ec130h">0</span></p>
									<p><strong>RC-135W Rivet Joint:</strong> <span>2</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_2_kc10a">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_2_kc46a_summary">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_2_kc135r_summary">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_2_c17a">0</span></p>
									<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_2_hc130">0</span></p>
									<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_2_mc130">0</span></p>
									<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_2_hh60g">0</span></p>
									<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_2_hh60w">0</span></p>
									<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_2_mq9a">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_2_lucasARM">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_2_lucasEOIR">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="F-15C" class="popup-card-trigger" data-unit-id="f15c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'f15c', 12)">Deploy F-15C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'f15c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="F-15E Strike Eagle" class="popup-card-trigger" data-unit-id="f15e">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'f15e', 12)">Deploy F-15E Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'f15e', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="F-15EX Eagle II" class="popup-card-trigger" data-unit-id="f15ex">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'f15ex', 12)">Deploy F-15EX Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'f15ex', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="F-16C Viper" class="popup-card-trigger" data-unit-id="f16c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'f16c', 12)">Deploy F-16C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'f16c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/iioBDP1.jpeg" alt="F-22A Raptor" class="popup-card-trigger" data-unit-id="f22a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'f22a', 12)">Deploy F-22A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'f22a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/yWZYfgP.jpeg" alt="F-35A Lightning II" class="popup-card-trigger" data-unit-id="f35a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'f35a', 12)">Deploy F-35A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'f35a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="FQ-XX CCA" class="popup-card-trigger" data-unit-id="fqxx">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'fqxx', 12)">Deploy FQ-XX Expeditionary Fighter Drone Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'fqxx', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZeZL1YF.jpeg" alt="B-1B Lancer" class="popup-card-trigger" data-unit-id="b1b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'b1b', 6)">Deploy B-1B Lancer Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'b1b', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/HE1v8rU.jpeg" alt="B-1R Lancer" class="popup-card-trigger" data-unit-id="b1r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'b1r', 6)">Deploy B-1R Lancer Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'b1r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52H BUFF" class="popup-card-trigger" data-unit-id="b52h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'b52h', 6)">Deploy B-52H BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'b52h', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52J BUFF" class="popup-card-trigger" data-unit-id="b52h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'b52j', 6)">Deploy B-52J BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'b52j', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="EA-18G Growler" class="popup-card-trigger" data-unit-id="ea18g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'ea18g', 7)">Deploy EA-18G Expeditionary Electronic Attack Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'ea18g', 7)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/LP3QSu8.jpeg" alt="EA-37B" class="popup-card-trigger" data-unit-id="ea37b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'ea37b', 4)">Deploy EA-37B Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'ea37b', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/VxkMYYf.jpeg" alt="EC-130H Compass Call" class="popup-card-trigger" data-unit-id="ec130h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'ec130h', 4)">Deploy EC-130H Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'ec130h', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R Stratotanker" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'c17a', 4)">Deploy C-17A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60g"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60G Credible Hawk"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 2, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 2, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60w"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60W Jolly Green II"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 2, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 2, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i1cuBxO.jpeg" alt="MQ-9A Reaper" class="popup-card-trigger" data-unit-id="mq9a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'mq9a', 12)">Deploy MQ-9A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'mq9a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS ARM" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'lucasARM', 1)">Deploy LUCAS (ARM) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'lucasARM', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS EO/IR" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 2, 'lucasEOIR', 1)">Deploy LUCAS (EO/IR) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 2, 'lucasEOIR', 1)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Hidden Inputs for Lua Export -->
						<input type="hidden" id="usa_air_base_2_f15c_input" name="usa_air_base_2_f15c" value="0">
						<input type="hidden" id="usa_air_base_2_f15e_input" name="usa_air_base_2_f15e" value="0">
						<input type="hidden" id="usa_air_base_2_f15ex_input" name="usa_air_base_2_f15ex" value="0">
						<input type="hidden" id="usa_air_base_2_f16c_input" name="usa_air_base_2_f16c" value="0">
						<input type="hidden" id="usa_air_base_2_f22a_input" name="usa_air_base_2_f22a" value="0">
						<input type="hidden" id="usa_air_base_2_f35a_input" name="usa_air_base_2_f35a" value="0">
						<input type="hidden" id="usa_air_base_2_fqxx_input" name="usa_air_base_2_fqxx" value="0">
						<input type="hidden" id="usa_air_base_2_b1b_input" name="usa_air_base_2_b1b" value="0">
						<input type="hidden" id="usa_air_base_2_b1r_input" name="usa_air_base_2_b1r" value="0">
						<input type="hidden" id="usa_air_base_2_b52h_input" name="usa_air_base_2_b52h" value="0">
						<input type="hidden" id="usa_air_base_2_b52j_input" name="usa_air_base_2_b52j" value="0">
						<input type="hidden" id="usa_air_base_2_ea18g_input" name="usa_air_base_2_ea18g" value="0">
						<input type="hidden" id="usa_air_base_2_ea37b_input" name="usa_air_base_2_ea37b" value="0">
						<input type="hidden" id="usa_air_base_2_ec130h_input" name="usa_air_base_2_ec130h" value="0">
						<input type="hidden" id="usa_air_base_2_kc10a_input" name="usa_air_base_2_kc10a" value="0">
						<input type="hidden" id="usa_air_base_2_kc46a_input" name="usa_air_base_2_kc46a" value="0">
						<input type="hidden" id="usa_air_base_2_kc135r_input" name="usa_air_base_2_kc135r" value="0">
						<input type="hidden" id="usa_air_base_2_c17a_input" name="usa_air_base_2_c17a" value="0">
						<input type="hidden" id="usa_air_base_2_rescuesqn_input" name="usa_air_base_2_rescuesqn" value="0">
						<input type="hidden" id="usa_air_base_2_mq9a_input" name="usa_air_base_2_mq9a" value="0">
						<input type="hidden" id="usa_air_base_2_lucasARM_input" name="usa_air_base_2_lucasARM" value="0">
						<input type="hidden" id="usa_air_base_2_lucasEOIR_input" name="usa_air_base_2_lucasEOIR" value="0">
					</div>

					<!-- Al Dhafra Air Base Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_3_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_3_menu')">X</button>
							<div class="popup-window-header">
								<h2>Al Dhafra Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_3_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_3_f15c">0</span></p>
									<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_3_f15e">0</span></p>
									<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_3_f15ex">0</span></p>
									<p><strong>F-16C Viper:</strong> <span id="usa_air_base_3_f16c">0</span></p>
									<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_3_f22a">0</span></p>
									<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_3_f35a">0</span></p>
									<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_3_fqxx">0</span></p>
									<p data-year="late2020"><strong>E-2D Advanced Hawkeye:</strong> <span id="usa_air_base_3_e2d">0</span></p>
									<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_3_e3g">0</span></p>
									<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_3_e7a">0</span></p>
									<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_3_ea18g">0</span></p>
									<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="usa_air_base_3_ea37b">0</span></p>
									<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_3_ec130h">0</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_3_kc10a_summary">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_3_kc46a">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_3_kc135r">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_3_c17a">0</span></p>
									<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_5_hc130">0</span></p>
									<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_5_mc130">0</span></p>
									<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_5_hh60g">0</span></p>
									<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_5_hh60w">0</span></p>
									<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_3_mq9a">0</span></p>
									<p><strong>RQ-4B Global Hawk:</strong> <span id="usa_air_base_3_rq4b">0</span></p>
									<p><strong>RQ-170 Sentinel:</strong> <span id="usa_air_base_3_rq170a">0</span></p>
									<p><strong>RQ-180:</strong> <span id="usa_air_base_3_rq180">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_3_lucasARM">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_3_lucasEOIR">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="F-15C Eagle" class="popup-card-trigger" data-unit-id="f15c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'f15c', 12)">Deploy F-15C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'f15c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="F-15E Strike Eagle" class="popup-card-trigger" data-unit-id="f15e">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'f15e', 12)">Deploy F-15E Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'f15e', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="F-15EX Eagle II" class="popup-card-trigger" data-unit-id="f15ex">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'f15ex', 12)">Deploy F-15EX Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'f15ex', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="F-16C Viper" class="popup-card-trigger" data-unit-id="f16c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'f16c', 12)">Deploy F-16C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'f16c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/iioBDP1.jpeg" alt="F-22A Raptor" class="popup-card-trigger" data-unit-id="f22a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'f22a', 12)">Deploy F-22A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'f22a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/yWZYfgP.jpeg" alt="F-35A Lightning II" class="popup-card-trigger" data-unit-id="f35a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'f35a', 12)">Deploy F-35A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'f35a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="FQ-XX CCA" class="popup-card-trigger" data-unit-id="fqxx">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'fqxx', 12)">Deploy FQ-XX Expeditionary Fighter Drone Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'fqxx', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/8Pn8jBY.jpeg" alt="E-2D Advanced Hawkeye" class="popup-card-trigger" data-unit-id="e2d">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'e2d', 5)">Deploy E-2D Expeditionary Airborne Command and Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'e2d', 5)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/fCxxDEN.jpeg" alt="E-3G Sentry" class="popup-card-trigger" data-unit-id="e3g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'e3g', 4)">Deploy E-3G Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'e3g', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/uTD6DkO.jpeg" alt="E-7A Wedgetail" class="popup-card-trigger" data-unit-id="e7a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'e7a', 4)">Deploy E-7A Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'e7a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="EA-18G Growler" class="popup-card-trigger" data-unit-id="ea18g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'ea18g', 7)">Deploy EA-18G Expeditionary Electronic Attack Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'ea18g', 7)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/LP3QSu8.jpeg" alt="EA-37B Compass Call" class="popup-card-trigger" data-unit-id="ea37b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'ea37b', 4)">Deploy EA-37B Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'ea37b', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/VxkMYYf.jpeg" alt="EC-130H Compass Call" class="popup-card-trigger" data-unit-id="ec130h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'ec130h', 4)">Deploy EC-130H Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'ec130h', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R Stratotanker" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'c17a', 4)">Deploy C-17A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60g"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60G Credible Hawk"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 3, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 3, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60w"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60W Jolly Green II"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 3, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 3, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i1cuBxO.jpeg" alt="MQ-9A Reaper" class="popup-card-trigger" data-unit-id="mq9a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'mq9a', 12)">Deploy MQ-9A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'mq9a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/5PCrcrA.jpeg" alt="RQ-4B Global Hawk" class="popup-card-trigger" data-unit-id="rq4b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'rq4b', 4)">Deploy RQ-4B Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'rq4b', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/fydkIae.jpeg" alt="RQ-170A Sentinel" class="popup-card-trigger" data-unit-id="rq170a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'rq170a', 4)">Deploy RQ-170A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'rq170a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/AKS4p90.jpeg" alt="RQ-180" class="popup-card-trigger" data-unit-id="rq180">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'rq180', 4)">Deploy RQ-180 Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'rq180', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS ARM" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'lucasARM', 1)">Deploy LUCAS (ARM) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'lucasARM', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS EO/IR" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 3, 'lucasEOIR', 1)">Deploy LUCAS (EO/IR) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 3, 'lucasEOIR', 1)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_3_f15c_input" name="usa_air_base_3_f15c" value="0">
							<input type="hidden" id="usa_air_base_3_f15e_input" name="usa_air_base_3_f15e" value="0">
							<input type="hidden" id="usa_air_base_3_f15ex_input" name="usa_air_base_3_f15ex" value="0">
							<input type="hidden" id="usa_air_base_3_f16c_input" name="usa_air_base_3_f16c" value="0">
							<input type="hidden" id="usa_air_base_3_f22a_input" name="usa_air_base_3_f22a" value="0">
							<input type="hidden" id="usa_air_base_3_f35a_input" name="usa_air_base_3_f35a" value="0">
							<input type="hidden" id="usa_air_base_3_fqxx_input" name="usa_air_base_3_fqxx" value="0">
							<input type="hidden" id="usa_air_base_3_e2d_input" name="usa_air_base_3_e2d" value="0">
							<input type="hidden" id="usa_air_base_3_e3g_input" name="usa_air_base_3_e3g" value="0">
							<input type="hidden" id="usa_air_base_3_e7a_input" name="usa_air_base_3_e7a" value="0">
							<input type="hidden" id="usa_air_base_3_ea18g_input" name="usa_air_base_3_ea18g" value="0">
							<input type="hidden" id="usa_air_base_3_ea37b_input" name="usa_air_base_3_ea37b" value="0">
							<input type="hidden" id="usa_air_base_3_ec130h_input" name="usa_air_base_3_ec130h" value="0">
							<input type="hidden" id="usa_air_base_3_kc10a_input" name="usa_air_base_3_kc10a" value="0">
							<input type="hidden" id="usa_air_base_3_kc46a_input" name="usa_air_base_3_kc46a" value="0">
							<input type="hidden" id="usa_air_base_3_kc135r_input" name="usa_air_base_3_kc135r" value="0">
							<input type="hidden" id="usa_air_base_3_c17a_input" name="usa_air_base_3_c17a" value="0">
							<input type="hidden" id="usa_air_base_3_rescuesqn_input" name="usa_air_base_3_rescuesqn" value="0">
							<input type="hidden" id="usa_air_base_3_mq9a_input" name="usa_air_base_3_mq9a" value="0">
							<input type="hidden" id="usa_air_base_3_rq4b_input" name="usa_air_base_3_rq4b" value="0">
							<input type="hidden" id="usa_air_base_3_rq170a_input" name="usa_air_base_3_rq170a" value="0">
							<input type="hidden" id="usa_air_base_3_rq180_input" name="usa_air_base_3_rq180" value="0">
							<input type="hidden" id="usa_air_base_3_lucasARM_input" name="usa_air_base_3_lucasARM" value="0">
							<input type="hidden" id="usa_air_base_3_lucasEOIR_input" name="usa_air_base_3_lucasEOIR" value="0">
						</div>
					</div>

					<!-- Diego Garcia Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_4_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_4_menu')">X</button>
							<div class="popup-window-header">
								<h2>Diego Garcia</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_4_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_4_b1b">0</span></p>
									<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_4_b1r">0</span></p>
									<p><strong>B-2A Spirit:</strong> <span id="usa_air_base_4_b2a">0</span></p>
									<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="usa_air_base_4_b21a">0</span></p>
									<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="usa_air_base_4_b21r">0</span></p>
									<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_4_b52h">0</span></p>
									<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_4_b52j">0</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_4_kc10a">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_4_kc46a">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_4_kc135r">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_4_c17a">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZeZL1YF.jpeg" alt="B-1B Lancer" class="popup-card-trigger" data-unit-id="b1b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b1b', 6)">Deploy B-1B Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b1b', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/HE1v8rU.jpeg" alt="B-1R Lancer" class="popup-card-trigger" data-unit-id="b1r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b1r', 6)">Deploy B-1R Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b1r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/uaKNwW0.jpeg" alt="B-2A Spirit" class="popup-card-trigger" data-unit-id="b2a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b2a', 3)">Deploy B-2A Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b2a', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="B-21A Raider" class="popup-card-trigger" data-unit-id="b21a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b21a', 3)">Deploy B-21A Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b21a', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="B-21R Raider" class="popup-card-trigger" data-unit-id="b21r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b21r', 3)">Deploy B-21R Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b21r', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52H BUFF" class="popup-card-trigger" data-unit-id="b52h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b52h', 6)">Deploy B-52H BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b52h', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52J BUFF" class="popup-card-trigger" data-unit-id="b52j">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'b52j', 6)">Deploy B-52J BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'b52j', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R Stratotanker" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 4, 'c17a', 4)">Deploy C-17A Globemaster III Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 4, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_4_b1b_input" name="usa_air_base_4_b1b" value="0">
							<input type="hidden" id="usa_air_base_4_b1r_input" name="usa_air_base_4_b1r" value="0">
							<input type="hidden" id="usa_air_base_4_b2a_input" name="usa_air_base_4_b2a" value="0">
							<input type="hidden" id="usa_air_base_4_b21a_input" name="usa_air_base_4_b21a" value="0">
							<input type="hidden" id="usa_air_base_4_b21r_input" name="usa_air_base_4_b21r" value="0">
							<input type="hidden" id="usa_air_base_4_b52h_input" name="usa_air_base_4_b52h" value="0">
							<input type="hidden" id="usa_air_base_4_b52j_input" name="usa_air_base_4_b52j" value="0">
							<input type="hidden" id="usa_air_base_4_kc10a_input" name="usa_air_base_4_kc10a" value="0">
							<input type="hidden" id="usa_air_base_4_kc46a_input" name="usa_air_base_4_kc46a" value="0">
							<input type="hidden" id="usa_air_base_4_kc135r_input" name="usa_air_base_4_kc135r" value="0">
							<input type="hidden" id="usa_air_base_4_c17a_input" name="usa_air_base_4_c17a" value="0">
						</div>
					</div>

					<!-- Ali Al Salem Air Base Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_5_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_5_menu')">X</button>
							<div class="popup-window-header">
								<h2>Ali Al Salem Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_5_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_5_f15c">0</span></p>
									<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_5_f15e">0</span></p>
									<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_5_f15ex">0</span></p>
									<p><strong>F-16C Viper:</strong> <span id="usa_air_base_5_f16c">0</span></p>
									<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_5_fqxx">0</span></p>
									<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_5_ea18g">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_5_c17a">0</span></p>
									<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_5_hc130">0</span></p>
									<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_5_mc130">0</span></p>
									<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_5_hh60g">0</span></p>
									<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_5_hh60w">0</span></p>
									<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_5_mq9a">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_5_lucasARM">0</span></p>
									<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_5_lucasEOIR">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="F-15C Eagle" class="popup-card-trigger" data-unit-id="f15c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'f15c', 12)">Deploy F-15C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'f15c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="F-15E Strike Eagle" class="popup-card-trigger" data-unit-id="f15e">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'f15e', 12)">Deploy F-15E Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'f15e', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="F-15EX Eagle II" class="popup-card-trigger" data-unit-id="f15ex">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'f15ex', 12)">Deploy F-15EX Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'f15ex', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="F-16C Viper" class="popup-card-trigger" data-unit-id="f16c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'f16c', 12)">Deploy F-16C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'f16c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="FQ-XX CCA" class="popup-card-trigger" data-unit-id="fqxx">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'fqxx', 12)">Deploy FQ-XX Expeditionary Fighter Drone Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'fqxx', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="EA-18G Growler" class="popup-card-trigger" data-unit-id="ea18g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'ea18g', 7)">Deploy EA-18G Expeditionary Electronic Attack Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'ea18g', 7)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'c17a', 4)">Deploy C-17A Globemaster III Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60g"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60G Credible Hawk"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 5, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 5, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60w"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60W Jolly Green II"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 5, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 5, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i1cuBxO.jpeg" alt="MQ-9A Reaper" class="popup-card-trigger" data-unit-id="mq9a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'mq9a', 12)">Deploy MQ-9A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'mq9a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS ARM" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'lucasARM', 1)">Deploy LUCAS (ARM) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'lucasARM', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS EO/IR" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 5, 'lucasEOIR', 1)">Deploy LUCAS (EO/IR) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 5, 'lucasEOIR', 1)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_5_f15c_input" name="usa_air_base_5_f15c" value="0">
							<input type="hidden" id="usa_air_base_5_f15e_input" name="usa_air_base_5_f15e" value="0">
							<input type="hidden" id="usa_air_base_5_f15ex_input" name="usa_air_base_5_f15ex" value="0">
							<input type="hidden" id="usa_air_base_5_f16c_input" name="usa_air_base_5_f16c" value="0">
							<input type="hidden" id="usa_air_base_5_fqxx_input" name="usa_air_base_5_fqxx" value="0">
							<input type="hidden" id="usa_air_base_5_ea18g_input" name="usa_air_base_5_ea18g" value="0">
							<input type="hidden" id="usa_air_base_5_c17a_input" name="usa_air_base_5_c17a" value="0">
							<input type="hidden" id="usa_air_base_5_rescuesqn_input" name="usa_air_base_5_rescuesqn" value="0">
							<input type="hidden" id="usa_air_base_5_mq9a_input" name="usa_air_base_5_mq9a" value="0">
							<input type="hidden" id="usa_air_base_5_lucasARM_input" name="usa_air_base_5_lucasARM" value="0">
							<input type="hidden" id="usa_air_base_5_lucasEOIR_input" name="usa_air_base_5_lucasEOIR" value="0">
						</div>
					</div>

					<!-- Muwaffaq Salti Air Base Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_6_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_6_menu')">X</button>
							<div class="popup-window-header">
								<h2>Muwaffaq Salti Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_6_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_6_f15c">0</span></p>
									<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_6_f15e">0</span></p>
									<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_6_f15ex">0</span></p>
									<p><strong>F-16C Viper:</strong> <span id="usa_air_base_6_f16c">0</span></p>
									<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_6_f22a">0</span></p>
									<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_6_f35a">0</span></p>
									<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_6_fqxx">0</span></p>
									<p data-year="late2020"><strong>E-2D Advanced Hawkeye:</strong> <span id="usa_air_base_6_e2d">0</span></p>
									<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_6_ea18g">0</span></p>
									<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="usa_air_base_6_ea37b">0</span></p>
									<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_6_ec130h">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_6_c17a">0</span></p>
									<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_6_hc130">0</span></p>
									<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_6_mc130">0</span></p>
									<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_6_hh60g">0</span></p>
									<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_6_hh60w">0</span></p>
									<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_6_mq9a">0</span></p>
									<p><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_6_lucasARM">0</span></p>
									<p><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_6_lucasEOIR">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="F-15C Eagle" class="popup-card-trigger" data-unit-id="f15c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'f15c', 12)">Deploy F-15C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'f15c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="F-15E Strike Eagle" class="popup-card-trigger" data-unit-id="f15e">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'f15e', 12)">Deploy F-15E Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'f15e', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="F-15EX Eagle II" class="popup-card-trigger" data-unit-id="f15ex">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'f15ex', 12)">Deploy F-15EX Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'f15ex', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="F-16C Viper" class="popup-card-trigger" data-unit-id="f16c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'f16c', 12)">Deploy F-16C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'f16c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/iioBDP1.jpeg" alt="F-22A Raptor" class="popup-card-trigger" data-unit-id="f22a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'f22a', 12)">Deploy F-22A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'f22a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/yWZYfgP.jpeg" alt="F-35A Lightning II" class="popup-card-trigger" data-unit-id="f35a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'f35a', 12)">Deploy F-35A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'f35a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="FQ-XX CCA" class="popup-card-trigger" data-unit-id="fqxx">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'fqxx', 12)">Deploy FQ-XX Expeditionary Fighter Drone Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'fqxx', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/8Pn8jBY.jpeg" alt="E-2D Hawkeye" class="popup-card-trigger" data-unit-id="e2d">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'e2d', 5)">Deploy E-2D Expeditionary Airborne Command and Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'e2d', 5)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="EA-18G Growler" class="popup-card-trigger" data-unit-id="ea18g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'ea18g', 7)">Deploy EA-18G Expeditionary Electronic Attack Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'ea18g', 7)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/LP3QSu8.jpeg" alt="EA-37B" class="popup-card-trigger" data-unit-id="ea37b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'ea37b', 4)">Deploy EA-37B Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'ea37b', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/VxkMYYf.jpeg" alt="EC-130H Compass Call" class="popup-card-trigger" data-unit-id="ec130h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'ec130h', 4)">Deploy EC-130H Expeditionary Electronic Combat Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'ec130h', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'c17a', 4)">Deploy C-17A Globemaster III Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60g"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60G Credible Hawk"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 6, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 6, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60w"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60W Jolly Green II"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 6, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 6, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i1cuBxO.jpeg" alt="MQ-9A Reaper" class="popup-card-trigger" data-unit-id="mq9a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'mq9a', 12)">Deploy MQ-9A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'mq9a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS ARM" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'lucasARM', 1)">Deploy LUCAS (ARM) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'lucasARM', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="LUCAS EO/IR" class="popup-card-trigger" data-unit-id="lucas">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 6, 'lucasEOIR', 1)">Deploy LUCAS (EO/IR) Battery</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 6, 'lucasEOIR', 1)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_6_f15c_input" name="usa_air_base_6_f15c" value="0">
							<input type="hidden" id="usa_air_base_6_f15e_input" name="usa_air_base_6_f15e" value="0">
							<input type="hidden" id="usa_air_base_6_f15ex_input" name="usa_air_base_6_f15ex" value="0">
							<input type="hidden" id="usa_air_base_6_f16c_input" name="usa_air_base_6_f16c" value="0">
							<input type="hidden" id="usa_air_base_6_f22a_input" name="usa_air_base_6_f22a" value="0">
							<input type="hidden" id="usa_air_base_6_f35a_input" name="usa_air_base_6_f35a" value="0">
							<input type="hidden" id="usa_air_base_6_fqxx_input" name="usa_air_base_6_fqxx" value="0">
							<input type="hidden" id="usa_air_base_6_e2d_input" name="usa_air_base_6_e2d" value="0">
							<input type="hidden" id="usa_air_base_6_ea18g_input" name="usa_air_base_6_ea18g" value="0">
							<input type="hidden" id="usa_air_base_6_ea37b_input" name="usa_air_base_6_ea37b" value="0">
							<input type="hidden" id="usa_air_base_6_ec130h_input" name="usa_air_base_6_ec130h" value="0">
							<input type="hidden" id="usa_air_base_6_c17a_input" name="usa_air_base_6_c17a" value="0">
							<input type="hidden" id="usa_air_base_6_rescuesqn_input" name="usa_air_base_6_rescuesqn" value="0">
							<input type="hidden" id="usa_air_base_6_mq9a_input" name="usa_air_base_6_mq9a" value="0">
							<input type="hidden" id="usa_air_base_6_lucasARM_input" name="usa_air_base_6_lucasARM" value="0">
							<input type="hidden" id="usa_air_base_6_lucasEOIR_input" name="usa_air_base_6_lucasEOIR" value="0">
						</div>
					</div>

					<!-- Ben Gurion Airport Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_7_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_7_menu')">X</button>
							<div class="popup-window-header">
								<h2>Ben Gurion Airport</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_7_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p data-year="late2020"><strong>E-2D Hawkeye:</strong> <span id="usa_air_base_7_e2d">0</span></p>
									<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_7_e3g">0</span></p>
									<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_7_e7a">0</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_7_kc10a">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_7_kc46a">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_7_kc135r">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_7_c17a">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/8Pn8jBY.jpeg" alt="E-2D Advanced Hawkeye" class="popup-card-trigger" data-unit-id="e2d">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'e2d', 5)">Deploy E-2D Expeditionary Airborne Command and Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'e2d', 5)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/fCxxDEN.jpeg" alt="E-3G Sentry" class="popup-card-trigger" data-unit-id="e3g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'e3g', 4)">Deploy E-3G Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'e3g', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/uTD6DkO.jpeg" alt="E-7A Wedgetail" class="popup-card-trigger" data-unit-id="e7a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'e7a', 4)">Deploy E-7A Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'e7a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R Stratotanker" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 7, 'c17a', 4)">Deploy C-17A Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 7, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_7_e2d_input" name="usa_air_base_7_e2d" value="0">
							<input type="hidden" id="usa_air_base_7_e3g_input" name="usa_air_base_7_e3g" value="0">
							<input type="hidden" id="usa_air_base_7_e7a_input" name="usa_air_base_7_e7a" value="0">
							<input type="hidden" id="usa_air_base_7_kc10a_input" name="usa_air_base_7_kc10a" value="0">
							<input type="hidden" id="usa_air_base_7_kc46a_input" name="usa_air_base_7_kc46a" value="0">
							<input type="hidden" id="usa_air_base_7_kc135r_input" name="usa_air_base_7_kc135r" value="0">
							<input type="hidden" id="usa_air_base_7_c17a_input" name="usa_air_base_7_c17a" value="0">
						</div>
					</div>

					<!-- Ovda Air Base Menu -->
					<!--Treated as USA air base even though it belongs to the IAF -->
					<div class="popup-window-container" id="usa_air_base_8_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_8_menu')">X</button>
							<div class="popup-window-header">
								<h2>Ovda Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_8_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_8_f15c">0</span></p>
									<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_8_f15e">0</span></p>
									<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_8_f15ex">0</span></p>
									<p><strong>F-16C Viper:</strong> <span id="usa_air_base_8_f16c">0</span></p>
									<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_8_f22a">0</span></p>
									<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_8_f35a">0</span></p>
									<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_8_fqxx">0</span></p>
									<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_8_ea18g">0</span></p>
									<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_8_hc130">0</span></p>
									<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_8_mc130">0</span></p>
									<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_8_hh60g">0</span></p>
									<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_8_hh60w">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="F-15C Eagle" class="popup-card-trigger" data-unit-id="f15c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'f15c', 12)">Deploy F-15C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'f15c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="F-15E Strike Eagle" class="popup-card-trigger" data-unit-id="f15e">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'f15e', 12)">Deploy F-15E Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'f15e', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="F-15EX Eagle II" class="popup-card-trigger" data-unit-id="f15ex">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'f15ex', 12)">Deploy F-15EX Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'f15ex', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="F-16C Viper" class="popup-card-trigger" data-unit-id="f16c">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'f16c', 12)">Deploy F-16C Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'f16c', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/iioBDP1.jpeg" alt="F-22A Raptor" class="popup-card-trigger" data-unit-id="f22a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'f22a', 12)">Deploy F-22A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'f22a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/yWZYfgP.jpeg" alt="F-35A Lightning II" class="popup-card-trigger" data-unit-id="f35a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'f35a', 12)">Deploy F-35A Expeditionary Fighter Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'f35a', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="FQ-XX CCA" class="popup-card-trigger" data-unit-id="fqxx">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'fqxx', 12)">Deploy FQ-XX Expeditionary Fighter Drone Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'fqxx', 12)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="EA-18G Growler" class="popup-card-trigger" data-unit-id="ea18g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 8, 'ea18g', 7)">Deploy EA-18G Expeditionary Electronic Attack Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 8, 'ea18g', 7)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60g"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60G Credible Hawk"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 8, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 8, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020" data-sar="csar">
										<img
											src="https://i.imgur.com/KQSiA7r.jpeg"
											alt="Rescue Squadron"
											class="popup-card-trigger"
											data-unit-id="hc130j,mc130j,hh60w"
											data-summary-title="USAF Rescue Squadron"
											data-summary-details="4 x HC-130J Combat King II; 4 x MC-130J Commando II; 8 x HH-60W Jolly Green II"
										>
										<div>
											<button class="deploy-button" onclick="deployMultipleAircraft('usa', 8, 'rescuesqn', 1)">Deploy USAF Rescue Squadron</button>
											<button class="undeploy-button" onclick="undeployMultipleAircraft('usa', 8, 'rescuesqn', 1)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_8_f15c_input" name="usa_air_base_8_f15c" value="0">
							<input type="hidden" id="usa_air_base_8_f15e_input" name="usa_air_base_8_f15e" value="0">
							<input type="hidden" id="usa_air_base_8_f15ex_input" name="usa_air_base_8_f15ex" value="0">
							<input type="hidden" id="usa_air_base_8_f16c_input" name="usa_air_base_8_f16c" value="0">
							<input type="hidden" id="usa_air_base_8_f22a_input" name="usa_air_base_8_f22a" value="0">
							<input type="hidden" id="usa_air_base_8_f35a_input" name="usa_air_base_8_f35a" value="0">
							<input type="hidden" id="usa_air_base_8_fqxx_input" name="usa_air_base_8_fqxx" value="0">
							<input type="hidden" id="usa_air_base_8_ea18g_input" name="usa_air_base_8_ea18g" value="0">
							<input type="hidden" id="usa_air_base_8_rescuesqn_input" name="usa_air_base_8_rescuesqn" value="0">
						</div>
					</div>

					<!-- Off Map Bases (Western Europe and CONUS) Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_9_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_9_menu')">X</button>
							<div class="popup-window-header">
								<h2>Off Map Bases (Western Europe and CONUS)</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_9_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_9_b1b">0</span></p>
									<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_9_b1r">0</span></p>
									<p><strong>B-2A Spirit:</strong> <span id="usa_air_base_9_b2a">0</span></p>
									<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="usa_air_base_9_b21a">0</span></p>
									<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="usa_air_base_9_b21r">0</span></p>
									<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_9_b52h">0</span></p>
									<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_9_b52j">0</span></p>
									<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_9_e3g">0</span></p>
									<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_9_e7a">0</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_9_kc10a">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_9_kc46a">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_9_kc135r">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_9_c17a">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZeZL1YF.jpeg" alt="B-1B Lancer" class="popup-card-trigger" data-unit-id="b1b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b1b', 6)">Deploy B-1B Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b1b', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/HE1v8rU.jpeg" alt="B-1R Lancer" class="popup-card-trigger" data-unit-id="b1r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b1r', 6)">Deploy B-1R Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b1r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/uaKNwW0.jpeg" alt="B-2A Spirit" class="popup-card-trigger" data-unit-id="b2a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b2a', 3)">Deploy B-2A Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b2a', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="B-21A Raider" class="popup-card-trigger" data-unit-id="b21a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b21a', 3)">Deploy B-21A Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b21a', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="B-21R Raider" class="popup-card-trigger" data-unit-id="b21r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b21r', 3)">Deploy B-21R Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b21r', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52H BUFF" class="popup-card-trigger" data-unit-id="b52h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b52h', 6)">Deploy B-52H BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b52h', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52J BUFF" class="popup-card-trigger" data-unit-id="b52j">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'b52j', 6)">Deploy B-52J BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'b52j', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/fCxxDEN.jpeg" alt="E-3G Sentry" class="popup-card-trigger" data-unit-id="e3g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'e3g', 4)">Deploy E-3G Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'e3g', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/uTD6DkO.jpeg" alt="E-7A Wedgetail" class="popup-card-trigger" data-unit-id="e7a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'e7a', 4)">Deploy E-7A Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'e7a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R Stratotanker" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 9, 'c17a', 4)">Deploy C-17A Globemaster III Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 9, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_9_b1b_input" name="usa_air_base_9_b1b" value="0">
							<input type="hidden" id="usa_air_base_9_b1r_input" name="usa_air_base_9_b1r" value="0">
							<input type="hidden" id="usa_air_base_9_b2a_input" name="usa_air_base_9_b2a" value="0">
							<input type="hidden" id="usa_air_base_9_b21a_input" name="usa_air_base_9_b21a" value="0">
							<input type="hidden" id="usa_air_base_9_b21r_input" name="usa_air_base_9_b21r" value="0">
							<input type="hidden" id="usa_air_base_9_b52h_input" name="usa_air_base_9_b52h" value="0">
							<input type="hidden" id="usa_air_base_9_b52j_input" name="usa_air_base_9_b52j" value="0">
							<input type="hidden" id="usa_air_base_9_e3g_input" name="usa_air_base_9_e3g" value="0">
							<input type="hidden" id="usa_air_base_9_e7a_input" name="usa_air_base_9_e7a" value="0">
							<input type="hidden" id="usa_air_base_9_kc10a_input" name="usa_air_base_9_kc10a" value="0">
							<input type="hidden" id="usa_air_base_9_kc46a_input" name="usa_air_base_9_kc46a" value="0">
							<input type="hidden" id="usa_air_base_9_kc135r_input" name="usa_air_base_9_kc135r" value="0">
							<input type="hidden" id="usa_air_base_9_c17a_input" name="usa_air_base_9_c17a" value="0">
						</div>
					</div>

					<!-- Off Map Bases (Northern Europe) Deployment Menu -->
					<div class="popup-window-container" id="usa_air_base_10_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_air_base_10_menu')">X</button>
							<div class="popup-window-header">
								<h2>Off Map Bases (Western Europe and CONUS)</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Air Base Capacity</h3>
									<p><strong>Used Capacity:</strong> <span id="usa_air_base_10_total_capacity"></span></p>
									<h3>Total Aircraft by Type</h3>
									<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_10_b1b">0</span></p>
									<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_10_b1r">0</span></p>
									<p><strong>B-2A Spirit:</strong> <span id="usa_air_base_10_b2a">0</span></p>
									<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="usa_air_base_10_b21a">0</span></p>
									<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="usa_air_base_10_b21r">0</span></p>
									<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_10_b52h">0</span></p>
									<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_10_b52j">0</span></p>
									<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_10_e3g">0</span></p>
									<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_10_e7a">0</span></p>
									<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_10_kc10a">0</span></p>
									<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_10_kc46a">0</span></p>
									<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_10_kc135r">0</span></p>
									<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_10_c17a">0</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/ZeZL1YF.jpeg" alt="B-1B Lancer" class="popup-card-trigger" data-unit-id="b1b">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b1b', 6)">Deploy B-1B Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b1b', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/HE1v8rU.jpeg" alt="B-1R Lancer" class="popup-card-trigger" data-unit-id="b1r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b1r', 6)">Deploy B-1R Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b1r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/uaKNwW0.jpeg" alt="B-2A Spirit" class="popup-card-trigger" data-unit-id="b2a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b2a', 3)">Deploy B-2A Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b2a', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="B-21A Raider" class="popup-card-trigger" data-unit-id="b21a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b21a', 3)">Deploy B-21A Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b21a', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="B-21R Raider" class="popup-card-trigger" data-unit-id="b21r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b21r', 3)">Deploy B-21R Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b21r', 3)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52H BUFF" class="popup-card-trigger" data-unit-id="b52h">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b52h', 6)">Deploy B-52H BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b52h', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="B-52J BUFF" class="popup-card-trigger" data-unit-id="b52j">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'b52j', 6)">Deploy B-52J BUFF Expeditionary Bomber Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'b52j', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/fCxxDEN.jpeg" alt="E-3G Sentry" class="popup-card-trigger" data-unit-id="e3g">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'e3g', 4)">Deploy E-3G Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'e3g', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/uTD6DkO.jpeg" alt="E-7A Wedgetail" class="popup-card-trigger" data-unit-id="e7a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'e7a', 4)">Deploy E-7A Expeditionary Airborne Air Control Squadron</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'e7a', 4)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="KC-10A" class="popup-card-trigger" data-unit-id="kc10a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'kc10a', 6)">Deploy KC-10A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'kc10a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'kc46a', 6)">Deploy KC-46A Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'kc46a', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="KC-135R Stratotanker" class="popup-card-trigger" data-unit-id="kc135r">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'kc135r', 6)">Deploy KC-135R Tanker Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'kc135r', 6)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="C-17A Globemaster III" class="popup-card-trigger" data-unit-id="c17a">
										<div>
											<button class="deploy-button" onclick="deployAircraft('usa', 10, 'c17a', 4)">Deploy C-17A Globemaster III Detachment</button>
											<button class="undeploy-button" onclick="undeployAircraft('usa', 10, 'c17a', 4)">Undeploy</button>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_air_base_10_b1b_input" name="usa_air_base_10_b1b" value="0">
							<input type="hidden" id="usa_air_base_10_b1r_input" name="usa_air_base_10_b1r" value="0">
							<input type="hidden" id="usa_air_base_10_b2a_input" name="usa_air_base_10_b2a" value="0">
							<input type="hidden" id="usa_air_base_10_b21a_input" name="usa_air_base_10_b21a" value="0">
							<input type="hidden" id="usa_air_base_10_b21r_input" name="usa_air_base_10_b21r" value="0">
							<input type="hidden" id="usa_air_base_10_b52h_input" name="usa_air_base_10_b52h" value="0">
							<input type="hidden" id="usa_air_base_10_b52j_input" name="usa_air_base_10_b52j" value="0">
							<input type="hidden" id="usa_air_base_10_e3g_input" name="usa_air_base_10_e3g" value="0">
							<input type="hidden" id="usa_air_base_10_e7a_input" name="usa_air_base_10_e7a" value="0">
							<input type="hidden" id="usa_air_base_10_kc10a_input" name="usa_air_base_10_kc10a" value="0">
							<input type="hidden" id="usa_air_base_10_kc46a_input" name="usa_air_base_10_kc46a" value="0">
							<input type="hidden" id="usa_air_base_10_kc135r_input" name="usa_air_base_10_kc135r" value="0">
							<input type="hidden" id="usa_air_base_10_c17a_input" name="usa_air_base_10_c17a" value="0">
						</div>
					</div>

					<!-- United States Fifth Fleet Deployment Menu -->
					<div class="popup-window-container" id="usa_naval_deployment_area_1_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('usa_naval_deployment_area_1_menu')">X</button>
							<div class="popup-window-header">
								<h2>United States Fifth Fleet</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Ship Deployments</h3>
									<p><strong>Nimitz/Ford-class CVN<br>(Early 2020's Air Wing):</strong> <span id="usa_naval_deployment_1_carriers_early2020">0</span></p>
									<p><strong>Nimitz/Ford-class CVN<br>(Mid 2020's Air Wing):</strong> <span id="usa_naval_deployment_1_carriers_mid2020">0</span></p>
									<p data-year="late2020"><strong>Nimitz/Ford-class CVN<br>(Late 2020's Air Wing):</strong> <span id="usa_naval_deployment_1_carriers_late2020">0</span></p>
									<p data-year="early2020, mid2020"><strong>Arleigh Burke-class DDG<br>(Flight I):</strong> <span>1</span></p>
									<p><strong>Arleigh Burke-class DDG<br>(Flight IIA):</strong> <span>3</span></p>
									<p data-year="late2020"><strong>Zumwalt-class DDG:</strong> <span>1</span></p>
									<p><strong>Virginia-class SSN (Block IV):</strong> <span>1</span></p>
									<p data-year="late2020"><strong>Virginia-class SSN (Block V):</strong> <span>1</span></p>
									<p data-year="early2020, mid2020"><strong>Ohio-class SSGN:</strong> <span>1</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img
											src="https://i.imgur.com/9mjFvaX.jpeg"
											alt="Early 2020's Carrier Air Wing"
											class="popup-card-trigger"
											data-unit-id="fa18e, ea18g, e2d, mh60r, mh60s"
											data-summary-title="Early 2020's Carrier Air Wing"
											data-summary-details="48 x F/A-18E/F Super Hornets; 7 x EA-18g Growlers; 5 x E-2D Advanced Hawkeyes; 8 x MH-60R Seahawk (If CSAR is enabled); 5 x MH-60S Seahawk (If CSAR is enabled)"
										>
										<div>
											<button class="deploy-button" onclick="deployShip('usa', 1, 'carriers', 'early2020', 1)">Deploy Carrier (Early 2020's Air Wing)</button>
											<button class="undeploy-button" onclick="undeployShip('usa', 1, 'carriers', 'early2020', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img
											src="https://i.imgur.com/9lV8DJD.jpeg"
											alt="Mid 2020's Carrier Air Wing"
											class="popup-card-trigger"
											data-unit-id="fa18e, f35c, ea18g, e2d, mh60r, mh60s"
											data-summary-title=""="Mid 2020's Carrier Air Wing"
											data-summary-details="36 x F/A-18E/F Super Hornets; 10 x F-35C Lightning II; 7 x EA-18g Growlers; 5 x E-2D Advanced Hawkeyes; 8 x MH-60R Seahawk (If CSAR is enabled); 5 x MH-60S Seahawk (If CSAR is enabled)"
										>
										<div>
											<button class="deploy-button" onclick="deployShip('usa', 1, 'carriers', 'mid2020', 1)">Deploy Carrier (Mid 2020's Air Wing)</button>
											<button class="undeploy-button" onclick="undeployShip('usa', 1, 'carriers', 'mid2020', 1)">Undeploy</button>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img
											src="https://i.imgur.com/5oi1rx7.jpeg"
											alt="Late 2020's Carrier Air Wing"
											class="popup-card-trigger"
											data-unit-id="fa18e, f35c, ea18g, e2d, mh60r, mh60s, mq25a"
											data-summary-title="Late 2020's Carrier Air Wing"
											data-summary-details="28 x F/A-18E/F Super Hornets; 20 x F-35C Lightning II; 7 x EA-18g Growlers; 5 x E-2D Advanced Hawkeyes; 8 x MH-60R Seahawk (If CSAR is enabled); 5 x MH-60S Seahawk (If CSAR is enabled); 8 x MQ-25A Stingray"
										>
										<div>
											<button class="deploy-button" onclick="deployShip('usa', 1, 'carriers', 'late2020', 1)">Deploy Carrier (Late 2020's Air Wing)</button>
											<button class="undeploy-button" onclick="undeployShip('usa', 1, 'carriers', 'late2020', 1)">Undeploy</button>
										</div>
									</div>
								</div>

								<div class="popup-window-right-bottom-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/koC3kKG.jpeg" alt="Arleigh Burke-class DDG" class="popup-card-trigger" data-unit-id="ddg-arleighburke">
										<div>
											<p class="unit-name">Arleigh Burke-class DDG</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/hbOdO0V.jpeg" alt="Zumwalt-class DDG" class="popup-card-trigger" data-unit-id="ddg-zumwalt">
										<div>
											<p class="unit-name">Zumwalt-class DDG</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/vVcBF89.jpeg" alt="Virginia-class SSN" class="popup-card-trigger" data-unit-id="ssn-virginia">
										<div>
											<p class="unit-name">Virginia-class SSN</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/KmX2QtP.jpeg" alt="Ohio-class SSGN" class="popup-card-trigger" data-unit-id="ssgn-ohio">
										<div>
											<p class="unit-name">Ohio-class SSGN</p>
										</div>
									</div>
								</div>
							</div>

							<!-- Hidden Inputs for Lua Export -->
							<input type="hidden" id="usa_naval_deployment_1_carriers_early2020_input" name="usa_naval_deployment_1_carriers_early2020" value="0">
							<input type="hidden" id="usa_naval_deployment_1_carriers_mid2020_input" name="usa_naval_deployment_1_carriers_mid2020" value="0">
							<input type="hidden" id="usa_naval_deployment_1_carriers_late2020_input" name="usa_naval_deployment_1_carriers_late2020" value="0">
						</div>
					</div>

					<!-- Ramat David Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_1_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_1_menu')">X</button>
							<div class="popup-window-header">
								<h2>Ramat David Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-16CG Barak:</strong> <span>16</span></p>
									<p><strong>F-16D Barak:</strong> <span>16</span></p>
									<p><strong>F-16DG Barak:</strong> <span>16</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/MEIqG4t.jpeg" alt="F-16C Barak" class="popup-card-trigger" data-unit-id="f16c-barak">
										<div>
											<p class="unit-name">F-16C Barak</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/MEIqG4t.jpeg" alt="F-16D Barak" class="popup-card-trigger" data-unit-id="f16d-barak">
										<div>
											<p class="unit-name">F-16D Barak</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Palmachim Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_2_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_2_menu')">X</button>
							<div class="popup-window-header">
								<h2>Palmachim Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p><strong>Hermes 900 Kohav:</strong> <span>40</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/KLSt2gW.jpeg" alt="Hermes 900 Kohav" class="popup-card-trigger" data-unit-id="hermes900-kohav">
										<div>
											<p class="unit-name">Hermes 900 Kohav</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Tel Nof Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_3_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_3_menu')">X</button>
							<div class="popup-window-header">
								<h2>Tel Nof Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p data-year="early2020, mid2020"><strong>F-15A Baz:</strong> <span>20</span></p>
									<p data-year="early2020, mid2020"><strong>F-15C Akef-2000:</strong> <span>20</span></p>
									<p data-year="late2020"><strong>F-15IA Ra'am:</strong> <span>48</span></p>
									<p><strong>Heron TP Eitan:</strong> <span>20</span></p>
									<p data-year="early2020, mid2020" data-sar="csar"><strong>CH-53C Yasur:</strong> <span>8</span></p>
									<p data-year="late2020" data-sar="csar"><strong>CH-53K King Stallion:</strong> <span>8</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/DD8jks3.jpeg" alt="F-15A Baz" class="popup-card-trigger" data-unit-id="f15a-baz">
										<div>
											<p class="unit-name">F-15A Baz</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/DD8jks3.jpeg" alt="F-15C Akef-2000" class="popup-card-trigger" data-unit-id="f15c-akef">
										<div>
											<p class="unit-name">F-15C Akef-2000</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/kb7s5Sp.jpeg" alt="F-15IA Ra'am" class="popup-card-trigger" data-unit-id="f15ia-raam">
										<div>
											<p class="unit-name">F-15IA Ra'am</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/q4MCBwQ.jpeg" alt="Heron TP Eitan" class="popup-card-trigger" data-unit-id="herontp-eitan">
										<div>
											<p class="unit-name">Heron TP Eitan</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020" data-sar="csar">
										<img src="https://i.imgur.com/C1kcPX3.jpeg" alt="CH-53C Yasur" class="popup-card-trigger" data-unit-id="ch53c-yasur">
										<div>
											<p class="unit-name">CH-53C Yasur</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020" data-sar="csar">
										<img src="https://i.imgur.com/gyF9PK6.jpeg" alt="CH-53K King Stallion" class="popup-card-trigger" data-unit-id="ch53k-king-stallion">
										<div>
											<p class="unit-name">CH-53C Yasur</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Hatzerim Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_4_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_4_menu')">X</button>
							<div class="popup-window-header">
								<h2>Hatzerim Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-15I Ra'am:</strong> <span>24</span></p>
									<p><strong>F-16I Sufa:</strong> <span>24</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/kb7s5Sp.jpeg" alt="F-15I Ra'am" class="popup-card-trigger" data-unit-id="f15i-raam">
										<div>
											<p class="unit-name">F-15I Ra'am</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/j2ZkIQ1.jpeg" alt="F-16I Sufa" class="popup-card-trigger" data-unit-id="f16i-sufa">
										<div>
											<p class="unit-name">F-16I Sufa</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Nevatim Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_5_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_5_menu')">X</button>
							<div class="popup-window-header">
								<h2>Nevatim Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p data-year="early2020"><strong>F-35I Adir:</strong> <span>24</span></p>
									<p data-year="mid2020"><strong>F-35I Adir:</strong> <span>48</span></p>
									<p data-year="late2020"><strong>F-35I Adir:</strong> <span>72</span></p>
									<p data-year="early2020, mid2020"><strong>Gulfstream G550 Eitam:</strong> <span>2</span></p>
									<p data-year="late2020"><strong>Gulfstream G550 Eitam:</strong> <span>3</span></p>
									<p><strong>Gulfstream G550 Shavit:</strong> <span>3</span></p>
									<p data-year="mid2020, late2020"><strong>Gulfstream G550 Oron:</strong> <span>1</span></p>
									<p data-year="late2020"><strong>KC-46A Pegasus:</strong> <span>8</span></p>
									<p><strong>KC-130H Qarnaf:</strong> <span>7</span></p>
									<p data-year="early2020, mid2020"><strong>KC-707 Saknayee:</strong> <span>8</span></p>
									<p data-sar="csar"><strong>C-130J-30 Shimshon:</strong> <span>4</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/XaJTgTM.jpeg" alt="F-35I Adir" class="popup-card-trigger" data-unit-id="f35i-adir">
										<div>
											<p class="unit-name">F-35I Adir</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/xbIbDmD.jpeg" alt="Gulfstream G550 Eitam" class="popup-card-trigger" data-unit-id="g550-eitam">
										<div>
											<p class="unit-name">Gulfstream G550 Eitam</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/QVdMsQI.jpeg" alt="Gulfstream G550 Shavit" class="popup-card-trigger" data-unit-id="g550-shavit">
										<div>
											<p class="unit-name">Gulfstream G550 Shavit</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/W4p4E7A.jpeg" alt="Gulfstream G550 Oron" class="popup-card-trigger" data-unit-id="g550-oron">
										<div>
											<p class="unit-name">Gulfstream G550 Oron</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="late2020">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="KC-46A Pegasus" class="popup-card-trigger" data-unit-id="kc46a">
										<div>
											<p class="unit-name">KC-46A Pegasus</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/DxNdYKL.jpeg" alt="KC-130H Qarnaf" class="popup-card-trigger" data-unit-id="kc130-qarnaf">
										<div>
											<p class="unit-name">KC-130H Qarnaf</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-year="early2020, mid2020">
										<img src="https://i.imgur.com/xyKGerO.jpeg" alt="KC-707 Saknayee" class="popup-card-trigger" data-unit-id="kc707-saknayee">
										<div>
											<p class="unit-name">KC-707 Saknayee</p>
										</div>
									</div>
									<div class="popup-window-button-container" data-sar="csar">
										<img src="https://i.imgur.com/CRJJtvL.jpeg" alt="C-130J-30 Shimshon" class="popup-card-trigger" data-unit-id="c130-shimshon">
										<div>
											<p class="unit-name">C-130J-30 Shimshon</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Ramon Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_6_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_6_menu')">X</button>
							<div class="popup-window-header">
								<h2>Ramon Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p><strong>F-16I Sufa:</strong> <span>72</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/j2ZkIQ1.jpeg" alt="F-16I Sufa" class="popup-card-trigger" data-unit-id="f16i-sufa">
										<div>
											<p class="unit-name">F-16I Sufa</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Hatzor Air Base Menu -->
					<div class="popup-window-container" id="israel_air_base_7_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('israel_air_base_7_menu')">X</button>
							<div class="popup-window-header">
								<h2>Hatzor Air Base</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<h3>Total Aircraft by Type</h3>
									<p data-year="mid2020, late2020"><strong>Hermes 900 Kohav:</strong> <span>40</span></p>
									<p><strong>Heron Shoval:</strong> <span>20</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right">
								<div class="popup-window-right-top-segment">
									<div class="popup-window-button-container" data-year="mid2020, late2020">
										<img src="https://i.imgur.com/KLSt2gW.jpeg" alt="Hermes 900 Kohav" class="popup-card-trigger" data-unit-id="hermes900-kohav">
										<div>
											<p class="unit-name">Hermes 900 Kohav</p>
										</div>
									</div>
									<div class="popup-window-button-container">
										<img src="https://i.imgur.com/Z8XPv5t.jpeg" alt="Heron Shoval" class="popup-card-trigger" data-unit-id="heron-shoval">
										<div>
											<p class="unit-name">Heron Shoval</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Sdot Micha Menu -->
					<div class="popup-window-container-left" id="israel_base_1_menu">
						<div class="popup-window-content-left">
							<button class="close-button" onclick="closePopupWindow('israel_base_1_menu')">X</button>
							<div class="popup-window-header">
								<h2>Sdot Micha</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left-summary">
								<!-- Base Status Display -->
								<div class="operations-summary-table operations-summary-table-left">
									<p><strong>Jericho 3 [1000kg HE]:</strong> <span>24</span></p>
								</div>
							</div>
						</div>
					</div>

					<!-- Arak Heavy Water Production Plant -->
					<div class="popup-window-container" id="iran_facility_1_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('iran_facility_1_menu')">X</button>
							<div class="popup-window-header">
								<h2>Arak Heavy Water Production Plant</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<p><strong>Building (Small):</strong> <span>17</span></p>
									<p><strong>Building (Medium):</strong> <span>14</span></p>
									<p><strong>Building (Large):</strong> <span>3</span></p>
									<p><strong>Diesel Tank (40k Liter):</strong> <span>3</span></p>
									<p><strong>Guard Post:</strong> <span>3</span></p>
									<p><strong>Mast:</strong> <span>1</span></p>
									<p><strong>Pipeline - Overhead:</strong> <span>6</span></p>
									<p><strong>Watchtower:</strong> <span>8</span></p>
									<p><strong>Water Tower (750k Liter):</strong> <span>11</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right-facility">
								<div class="facility-image-container">
									<img src="https://i.imgur.com/t9dxFjB.jpeg" alt="Unit Image" class="facility-image">
								</div>
								<div class="facility-info">
									<p class="facility-description">Produces heavy water for use in nuclear reactors. Heavy water is used as a neutron moderator in certain types of nuclear reactors that can produce weapons-grade plutonium as a byproduct. It is part of the larger Arak Nuclear Complex, along with the neighboring IR-40 reactor.</p>
									<ul class="facility-details">
										<li><strong>Type:</strong> Surface.</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<!-- Esfahãn Uranium Conversion Facility -->
					<div class="popup-window-container" id="iran_facility_2_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('iran_facility_2_menu')">X</button>
							<div class="popup-window-header">
								<h2>Esfahãn Uranium Conversion Facility</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<p><strong>Building (Small):</strong> <span>35</span></p>
									<p><strong>Building (Medium):</strong> <span>22</span></p>
									<p><strong>Building (Large):</strong> <span>44</span></p>
									<p><strong>Chimney:</strong> <span>1</span></p>
									<p><strong>Electric Sub Station:</strong> <span>1</span></p>
									<p><strong>Guard Post:</strong> <span>3</span></p>
									<p><strong>Pipeline - Overhead:</strong> <span>26</span></p>
									<p><strong>Reactor:</strong> <span>1</span></p>
									<p><strong>Tunnel Entrance:</strong> <span>4</span></p>
									<p><strong>Underground Hardened Bunker:</strong> <span>4</span></p>
									<p><strong>Watch Tower:</strong> <span>11</span></p>
									<p><strong>Water Tower (750k Liter):</strong> <span>1</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right-facility">
								<div class="facility-image-container">
									<img src="https://i.imgur.com/n4EMFKr.jpeg" alt="Unit Image" class="facility-image">
								</div>
								<div class="facility-info">
									<p class="facility-description">LLocated southeast of Esfahãn city, it is Iran's largest nuclear scientific center. Converts raw uranium ore into uranium hexafluoride (UF6) gas, which is then used in the uranium enrichment process.</p>
									<ul class="facility-details">
										<li><strong>Type:</strong> Surface.</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<!-- Fordow Fuel Enrichment Plant -->
					<div class="popup-window-container" id="iran_facility_3_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('iran_facility_3_menu')">X</button>
							<div class="popup-window-header">
								<h2>Fordow Fuel Enrichment Plant</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<p><strong>Building (Small):</strong> <span>1</span></p>
									<p><strong>Building (Large):</strong> <span>1</span></p>
									<p><strong>Guard Post:</strong> <span>2</span></p>
									<p><strong>Tunnel Entrance:</strong> <span>5</span></p>
									<p><strong>Underground Hardened Bunker:</strong> <span>9</span></p>
									<p><strong>Watch Tower:</strong> <span>14</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right-facility">
								<div class="facility-image-container">
									<img src="https://i.imgur.com/kCyXbEk.jpeg" alt="Unit Image" class="facility-image">
								</div>
								<div class="facility-info">
									<p class="facility-description"> Underground facility near Qom, Iran. It is Iran's second uranium enrichment facility that is capable of producing weapons-grade uranium.</p>
									<ul class="facility-details">
										<li><strong>Type:</strong> Underground (Mountain).</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<!-- Natanz Fuel Enrichment Plant -->
					<div class="popup-window-container" id="iran_facility_4_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('iran_facility_4_menu')">X</button>
							<div class="popup-window-header">
								<h2>Natanz Fuel Enrichment Plant</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<p><strong>Building (Small):</strong> <span>9</span></p>
									<p><strong>Building (Medium):</strong> <span>17</span></p>
									<p><strong>Building (Large):</strong> <span>16</span></p>
									<p><strong>Electric Sub Station:</strong> <span>2</span></p>
									<p><strong>Power Transmission Line:</strong> <span>20</span></p>
									<p><strong>Tunnel Entrance:</strong> <span>2</span></p>
									<p><strong>Underground Hardened Bunker:</strong> <span>8</span></p>
									<p><strong>Watch Tower:</strong> <span>20</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right-facility">
								<div class="facility-image-container">
									<img src="https://i.imgur.com/EbQgoqU.jpeg" alt="Unit Image" class="facility-image">
								</div>
								<div class="facility-info">
									<p class="facility-description">The primary Iranian uranium enrichment site. It houses thousands of centrifuges that enrich uranium to various levels, including weapons-grade levels. According to Iranian authorities, the underground facility is 40-50 meters (130-160 feet) underground and is protected by a concrete shield with a thickness of approximately 7.6 meters (25 feet), for safety reasons and to protect it from possible air attack.</p>
									<ul class="facility-details">
										<li><strong>Type:</strong> Surface & Underground.</li>
									</ul>
								</div>
							</div>
						</div>
					</div>

					<!-- Natanz Fuel Enrichment Plant -->
					<div class="popup-window-container" id="iran_facility_5_menu">
						<div class="popup-window-content">
							<button class="close-button" onclick="closePopupWindow('iran_facility_5_menu')">X</button>
							<div class="popup-window-header">
								<h2>Natanz Fuel Enrichment Plant</h2>
							</div>

							<!-- Summary Table (Left) -->
							<div class="popup-window-left">
								<!-- Base Status Display -->
								<div class="operations-summary-table">
									<p><strong>Tunnel Entrance:</strong> <span>7</span></p>
									<p><strong>Underground Hardened Bunker:</strong> <span>12</span></p>
									<p><strong>Watch Tower:</strong> <span>2</span></p>
								</div>
							</div>

							<!-- Deployment Options (Right) -->
							<div class="popup-window-right-facility">
								<div class="facility-image-container">
									<img src="https://i.imgur.com/WSUaBpF.jpeg" alt="Unit Image" class="facility-image">
								</div>
								<div class="facility-info">
									<p class="facility-description">The original Natanz Fuel Enrichment Plant was destroyed by US and Israeli strikes in 2025. The new plant began construction in the mid 2020s and was recently completed. It is located under the mountains south of the old Natanz facility.</p>
									<ul class="facility-details">
										<li><strong>Type:</strong> Underground (Mountain).</li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

				<!-- Popup Unit Card Overlay -->
				<div class="unit-card-popup-container" id="unitCardPopup" style="display:none;">
					<div class="unit-card-popup-content">
						<button class="close-card-popup-multiunit" onclick="closeUnitCardPopup()">X</button>
						<div id="unitCardSummary" class="unit-card-popup-summary"></div>
						<div id="unitCardContent" class="unit-card-popup-cards"></div>
					</div>
				</div>

				<!-- Summary Tab -->
				<div id="summary" class="tab-content">
					<p>The totals shown here include aircraft that are permanently forward deployed and player deployed.</p>
					<h2>Order of Battle</h2>
					<div class="summary-container" data-side="usa, usa-israel">
						<!-- Total USAF Aircraft -->
						<div class="summary-table">
							<h2>Total USAF Aircraft</h2>
							<p><strong>F-15C Eagle:</strong> <span id="total_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="total_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="total_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="total_f16c">0</span></p>
							<p><strong>F-22A Raptor:</strong> <span id="total_f22a">0</span></p>
							<p><strong>F-35A Lightning II:</strong> <span id="total_f35a">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="total_fqxx">0</span></p>
							<p><strong>B-1B Lancer:</strong> <span id="total_b1b">0</span></p>
							<p><strong>B-1R Lancer:</strong> <span id="total_b1r">0</span></p>
							<p><strong>B-2A Spirit:</strong> <span id="total_b2a">0</span></p>
							<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="total_b21a">0</span></p>
							<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="total_b21r">0</span></p>
							<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="total_b52h">0</span></p>
							<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="total_b52j">0</span></p>
							<p data-year="late2020"><strong>E-2D Advanced Hawkeye:</strong> <span id="total_e2d">0</span></p>
							<p><strong>E-3G Sentry:</strong> <span id="total_e3g">0</span></p>
							<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="total_e7a">0</span></p>
							<p data-year="early2020"><strong>E-8C Joint STARS:</strong> <span>1</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="total_ea18g">0</span></p>
							<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="total_ea37b">0</span></p>
							<p><strong>EC-130H Compass Call:</strong> <span id="total_ec130h">0</span></p>
							<p><strong>RC-135W Rivet Joint:</strong> <span>2</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="total_kc10a_summary">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="total_kc46a_summary">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="total_kc135r_summary">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="total_c17a">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="total_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="total_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="total_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="total_hh60w">0</span></p>
							<p><strong>MQ-9A Reaper:</strong> <span id="total_mq9a">0</span></p>
							<p><strong>RQ-4B Global Hawk:</strong> <span id="total_rq4b">0</span></p>
							<p><strong>RQ-170A Sentinel:</strong> <span id="total_rq170a">0</span></p>
							<p><strong>RQ-180:</strong> <span id="total_rq180">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="total_lucasARM">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="total_lucasEOIR">0</span></p>
						</div>

						<!-- IAF Aircraft -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Total IAF Aircraft</h2>
							<p data-year="early2020, mid2020"><strong>F-15A Baz:</strong> <span>20</span></p>
							<p data-year="early2020, mid2020"><strong>F-15C Akef-2000:</strong> <span>20</span></p>
							<p><strong>F-15I Ra'am:</strong> <span>24</span></p>
							<p data-year="late2020"><strong>F-15IA Ra'am:</strong> <span>48</span></p>
							<p><strong>F-16CG Barak:</strong> <span>16</span></p>
							<p><strong>F-16D Barak:</strong> <span>16</span></p>
							<p><strong>F-16DG Barak:</strong> <span>16</span></p>
							<p><strong>F-16I Sufa:</strong> <span>96</span></p>
							<p data-year="early2020"><strong>F-35I Adir:</strong> <span>24</span></p>
							<p data-year="mid2020"><strong>F-35I Adir:</strong> <span>48</span></p>
							<p data-year="late2020"><strong>F-35I Adir:</strong> <span>72</span></p>
							<p data-year="early2020, mid2020"><strong>Gulfstream G550 Eitam:</strong> <span>2</span></p>
							<p data-year="late2020"><strong>Gulfstream G550 Eitam:</strong> <span>3</span></p>
							<p><strong>Gulfstream G550 Shavit:</strong> <span>3</span></p>
							<p data-year="mid2020, late2020"><strong>Gulfstream G550 Oron:</strong> <span>1</span></p>
							<p data-year="late2020"><strong>KC-46A Pegasus:</strong> <span>8</span></p>
							<p><strong>KC-130H Qarnaf:</strong> <span>7</span></p>
							<p data-year="early2020, mid2020"><strong>KC-707 Saknayee:</strong> <span>8</span></p>
							<p><strong>Hermes 900 Kohav:</strong> <span>40</span></p>
							<p><strong>Heron Shoval:</strong> <span>20</span></p>
							<p><strong>Heron TP Eitan:</strong> <span>20</span></p>
						</div>

						<!-- Total Naval Deployments -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Total Naval Deployments</h2>
							<p><strong>Carriers Deployed:</strong> <span id="usa_total_carriers">0</span></p>
							<p><strong>Carriers (Early 2020's Air Wing):</strong> <span id="usa_total_carriers_early2020">0</span></p>
							<p><strong>Carriers (Mid 2020's Air Wing):</strong> <span id="usa_total_carriers_mid2020">0</span></p>
						</div>
					</div>

					<h2>Air Base Deployment Summary</h2>
					<div class="summary-container">
						<!-- Prince Sultan Air Base Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Prince Sultan Air Base</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_1_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_1_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_1_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Strike Eagle:</strong> <span id="usa_air_base_1_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="usa_air_base_1_f16c">0</span></p>
							<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_1_f22a">0</span></p>
							<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_1_f35a">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_1_fqxx">0</span></p>
							<p data-year="late2020"><strong>E-2D Hawkeye:</strong> <span id="usa_air_base_1_e2d">0</span></p>
							<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_1_e3g">0</span></p>
							<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_1_e7a">0</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_1_ea18g">0</span></p>
							<p data-year="late2020"><strong>EA-37B Dragon:</strong> <span id="usa_air_base_1_ea37b">0</span></p>
							<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_1_ec130h">0</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_1_kc10a">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_1_kc46a">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_1_kc135r">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_1_c17a">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_1_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_1_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_1_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_1_hh60w">0</span></p>
							<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_1_mq9a">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_1_lucasARM">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_1_lucasEOIR">0</span></p>
						</div>

						<!-- Al Udeid Air Base Summary -->
						<div class="summary-table" data-side="usa, usa-israel" id="summary_usa_air_base_2">
							<h2>Al Udeid Air Base</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_2_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_2_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_2_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_2_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="usa_air_base_2_f16c">0</span></p>
							<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_2_f22a">0</span></p>
							<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_2_f35a">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_2_fqxx">0</span></p>
							<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_2_b1b">0</span></p>
							<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_2_b1r">0</span></p>
							<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_2_b52h">0</span></p>
							<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_2_b52j">0</span></p>
							<p data-year="early2020"><strong>E-8C Joint STARS:</strong> <span>1</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_2_ea18g">0</span></p>
							<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="usa_air_base_2_ea37b">0</span></p>
							<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_2_ec130h">0</span></p>
							<p><strong>RC-135W Rivet Joint:</strong> <span>2</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_2_kc10a">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_2_kc46a_summary">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_2_kc135r_summary">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_2_c17a">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_2_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_2_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_2_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_2_hh60w">0</span></p>
							<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_2_mq9a">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_2_lucasARM">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_2_lucasEOIR">0</span></p>
						</div>

						<!-- Al Dhafra Air Base Summary -->
						<div class="summary-table" data-side="usa, usa-israel" id="summary_usa_air_base_3">
							<h2>Al Dhafra Air Base</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_3_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_3_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_3_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_3_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="usa_air_base_3_f16c">0</span></p>
							<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_3_f22a">0</span></p>
							<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_3_f35a">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_3_fqxx">0</span></p>
							<p data-year="late2020"><strong>E-2D Advanced Hawkeye:</strong> <span id="usa_air_base_3_e2d">0</span></p>
							<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_3_e3g">0</span></p>
							<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_3_e7a">0</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_3_ea18g">0</span></p>
							<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="usa_air_base_3_ea37b">0</span></p>
							<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_3_ec130h">0</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_3_kc10a_summary">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_3_kc46a">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_3_kc135r">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_3_c17a">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_5_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_5_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_5_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_5_hh60w">0</span></p>
							<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_3_mq9a">0</span></p>
							<p><strong>RQ-4B Global Hawk:</strong> <span id="usa_air_base_3_rq4b">0</span></p>
							<p><strong>RQ-170 Sentinel:</strong> <span id="usa_air_base_3_rq170a">0</span></p>
							<p><strong>RQ-180:</strong> <span id="usa_air_base_3_rq180">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_3_lucasARM">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_3_lucasEOIR">0</span></p>
						</div>

						<!-- Diego Garcia Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Diego Garcia</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_4_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_4_b1b">0</span></p>
							<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_4_b1r">0</span></p>
							<p><strong>B-2A Spirit:</strong> <span id="usa_air_base_4_b2a">0</span></p>
							<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="usa_air_base_4_b21a">0</span></p>
							<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="usa_air_base_4_b21r">0</span></p>
							<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_4_b52h">0</span></p>
							<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_4_b52j">0</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_4_kc10a">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_4_kc46a">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_4_kc135r">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_4_c17a">0</span></p>
						</div>

						<!-- Ali Al Salem Air Base Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Ali Al Salem Air Base</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_5_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_5_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_5_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_5_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="usa_air_base_5_f16c">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_5_fqxx">0</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_5_ea18g">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_5_c17a">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_5_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_5_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_5_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_5_hh60w">0</span></p>
							<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_5_mq9a">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_5_lucasARM">0</span></p>
							<p data-year="mid2020, late2020"><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_5_lucasEOIR">0</span></p>
						</div>

						<!-- Muwaffaq Salti Air Base Summary -->
						<div class="summary-table" data-year="mid2020, late2020" data-side="usa, usa-israel">
							<h2>Muwaffaq Salti Air Base</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_6_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_6_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_6_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_6_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="usa_air_base_6_f16c">0</span></p>
							<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_6_f22a">0</span></p>
							<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_6_f35a">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_6_fqxx">0</span></p>
							<p data-year="late2020"><strong>E-2D Advanced Hawkeye:</strong> <span id="usa_air_base_6_e2d">0</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_6_ea18g">0</span></p>
							<p data-year="late2020"><strong>EA-37B Compass Call:</strong> <span id="usa_air_base_6_ea37b">0</span></p>
							<p><strong>EC-130H Compass Call:</strong> <span id="usa_air_base_6_ec130h">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_6_c17a">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_6_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_6_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_6_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_6_hh60w">0</span></p>
							<p><strong>MQ-9 Reaper:</strong> <span id="usa_air_base_6_mq9a">0</span></p>
							<p><strong>Low-Cost Uncrewed Combat<br>Attack System (ARM) Battery:</strong> <span id="usa_air_base_6_lucasARM">0</span></p>
							<p><strong>Low-Cost Uncrewed Combat<br>Attack System (EO/IR) Battery:</strong> <span id="usa_air_base_6_lucasEOIR">0</span></p>
						</div>

						<!-- Ben Gurion Airport Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Ben Gurion Airport</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_7_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p data-year="late2020"><strong>E-2D Hawkeye:</strong> <span id="usa_air_base_7_e2d">0</span></p>
							<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_7_e3g">0</span></p>
							<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_7_e7a">0</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_7_kc10a">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_7_kc46a">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_7_kc135r">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_7_c17a">0</span></p>
						</div>

						<!-- Ovda Air Base Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Ovda Air Base</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_8_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15C Eagle:</strong> <span id="usa_air_base_8_f15c">0</span></p>
							<p><strong>F-15E Strike Eagle:</strong> <span id="usa_air_base_8_f15e">0</span></p>
							<p data-year="late2020"><strong>F-15EX Eagle II:</strong> <span id="usa_air_base_8_f15ex">0</span></p>
							<p><strong>F-16C Viper:</strong> <span id="usa_air_base_8_f16c">0</span></p>
							<p><strong>F-22A Raptor:</strong> <span id="usa_air_base_8_f22a">0</span></p>
							<p><strong>F-35A Lightning II:</strong> <span id="usa_air_base_8_f35a">0</span></p>
							<p data-year="late2020"><strong>FQ-XX CCA:</strong> <span id="usa_air_base_8_fqxx">0</span></p>
							<p><strong>EA-18G Growler:</strong> <span id="usa_air_base_8_ea18g">0</span></p>
							<p data-sar="csar"><strong>HC-130 Combat King:</strong> <span id="usa_air_base_8_hc130">0</span></p>
							<p data-sar="csar"><strong>MC-130 Commando II:</strong> <span id="usa_air_base_8_mc130">0</span></p>
							<p data-year="early2020" data-sar="csar"><strong>HH-60G Pave Hawk:</strong> <span id="usa_air_base_8_hh60g">0</span></p>
							<p data-year="mid2020, late2020" data-sar="csar"><strong>HH-60W Jolly Green II:</strong> <span id="usa_air_base_8_hh60w">0</span></p>
						</div>

						<!-- Off Map Bases (Western Europe and CONUS) Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Off Map Bases (Western Europe and CONUS)</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_9_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_9_b1b">0</span></p>
							<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_9_b1r">0</span></p>
							<p><strong>B-2A Spirit:</strong> <span id="usa_air_base_9_b2a">0</span></p>
							<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="usa_air_base_9_b21a">0</span></p>
							<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="usa_air_base_9_b21r">0</span></p>
							<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_9_b52h">0</span></p>
							<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_9_b52j">0</span></p>
							<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_9_e3g">0</span></p>
							<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_9_e7a">0</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_9_kc10a">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_9_kc46a">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_9_kc135r">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_9_c17a">0</span></p>
						</div>

						<!-- Off Map Bases (Northern Europe) Summary -->
						<div class="summary-table" data-side="usa, usa-israel">
							<h2>Off Map Bases (Northern Europe)</h2>
							<hr class="divider-line">
							<h3>Air Base Capacity</h3>
							<p><strong>Used Capacity:</strong> <span id="usa_air_base_10_total_capacity"></span></p>
							<h3>Total Aircraft by Type</h3>
							<p><strong>B-1B Lancer:</strong> <span id="usa_air_base_10_b1b">0</span></p>
							<p><strong>B-1R Lancer:</strong> <span id="usa_air_base_10_b1r">0</span></p>
							<p><strong>B-2A Spirit:</strong> <span id="usa_air_base_10_b2a">0</span></p>
							<p data-year="late2020"><strong>B-21A Raider:</strong> <span id="usa_air_base_10_b21a">0</span></p>
							<p data-year="late2020"><strong>B-21R Raider:</strong> <span id="usa_air_base_10_b21r">0</span></p>
							<p data-year="early2020, mid2020"><strong>B-52H BUFF:</strong> <span id="usa_air_base_10_b52h">0</span></p>
							<p data-year="late2020"><strong>B-52J BUFF:</strong> <span id="usa_air_base_10_b52j">0</span></p>
							<p><strong>E-3G Sentry:</strong> <span id="usa_air_base_10_e3g">0</span></p>
							<p data-year="late2020"><strong>E-7A Wedgetail:</strong> <span id="usa_air_base_10_e7a">0</span></p>
							<p data-year="early2020"><strong>KC-10A Extender:</strong> <span id="usa_air_base_10_kc10a">0</span></p>
							<p data-year="mid2020, late2020"><strong>KC-46A Pegasus:</strong> <span id="usa_air_base_10_kc46a">0</span></p>
							<p><strong>KC-135R Stratotanker:</strong> <span id="usa_air_base_10_kc135r">0</span></p>
							<p><strong>C-17A Globemaster III:</strong> <span id="usa_air_base_10_c17a">0</span></p>
						</div>

						<!-- Ramat David Air Base Menu -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Ramat David Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-16CG Barak:</strong> <span>16</span></p>
							<p><strong>F-16D Barak:</strong> <span>16</span></p>
							<p><strong>F-16DG Barak:</strong> <span>16</span></p>
						</div>

						<!-- Palmachim Air Base Menu -->
						<div class="summary-table" data-year="early2020" data-side="israel, usa-israel">
							<h2>Palmachim Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p><strong>Hermes 900 Kohav:</strong> <span>40</span></p>
						</div>

						<!-- Tel Nof Air Base Menu -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Tel Nof Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p data-year="early2020, mid2020"><strong>F-15A Baz:</strong> <span>20</span></p>
							<p data-year="early2020, mid2020"><strong>F-15C Akef-2000:</strong> <span>20</span></p>
							<p data-year="late2020"><strong>F-15IA Ra'am:</strong> <span>48</span></p>
							<p><strong>Heron TP Eitan:</strong> <span>20</span></p>
							<p data-year="early2020, mid2020" data-sar="csar"><strong>CH-53C Yasur:</strong> <span>8</span></p>
							<p data-year="late2020" data-sar="csar"><strong>CH-53K King Stallion:</strong> <span>8</span></p>
						</div>

						<!-- Hatzerim Air Base Menu -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Hatzerim Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-15I Ra'am:</strong> <span>24</span></p>
							<p><strong>F-16I Sufa:</strong> <span>24</span></p>
						</div>

						<!-- Nevatim Air Base Menu -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Nevatim Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p data-year="early2020"><strong>F-35I Adir:</strong> <span>24</span></p>
							<p data-year="mid2020"><strong>F-35I Adir:</strong> <span>48</span></p>
							<p data-year="late2020"><strong>F-35I Adir:</strong> <span>72</span></p>
							<p data-year="early2020, mid2020"><strong>Gulfstream G550 Eitam:</strong> <span>2</span></p>
							<p data-year="late2020"><strong>Gulfstream G550 Eitam:</strong> <span>3</span></p>
							<p><strong>Gulfstream G550 Shavit:</strong> <span>3</span></p>
							<p data-year="mid2020, late2020"><strong>Gulfstream G550 Oron:</strong> <span>1</span></p>
							<p data-year="late2020"><strong>KC-46A Pegasus:</strong> <span>8</span></p>
							<p><strong>KC-130H Qarnaf:</strong> <span>7</span></p>
							<p data-year="early2020, mid2020"><strong>KC-707 Saknayee:</strong> <span>8</span></p>
							<p data-sar="csar"><strong>C-130J-30 Shimshon:</strong> <span>4</span></p>
						</div>

						<!-- Ramon Air Base Menu -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Ramon Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p><strong>F-16I Sufa:</strong> <span>72</span></p>
						</div>

						<!-- Hatzor Air Base Menu -->
						<div class="summary-table" data-side="israel, usa-israel">
							<h2>Hatzor Air Base</h2>
							<hr class="divider-line">
							<h3>Total Aircraft by Type</h3>
							<p data-year="mid2020, late2020"><strong>Hermes 900 Kohav:</strong> <span>40</span></p>
							<p><strong>Heron Shoval:</strong> <span>20</span></p>
						</div>
					</div>
				</div>

				<!-- Unit Card Tab -->
				<div id="unit-cards" class="tab-content">
					<div class="unit-cards-header">
						<div id="unit-card-filters"></div>
					</div>

					<div class="unit-cards-scroll">
						<div class="unit-cards-container" id="unit-cards">
							<!-- F-15A Baz Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15a-baz" data-year="early2020, mid2020" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15A Baz</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/DD8jks3.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15A Baz is a twin-engine, all-weather tactical fighter designed to gain and maintain air superiority. Unlike most F-15A's, the Israeli Air Force variant has a limited strike capability.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Fighter, fourth generation</li>
											<li><strong>Role:</strong> Air Superiority</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15A Baz</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-63 (Search/FCR),<br>Max Range: 95 nm</li>
												<li>AN/ALR-56A TEWS (RWR), Max Range: 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-7F Sparrow III</li>
												<li>AIM-9L Sidewinder</li>
												<li>AIM-120C-7 AMRAAM</li>
												<li>Python 3</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-15C Akef-2000 Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15c-akef" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15C Akef-2000</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/DD8jks3.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15A Akef is a twin-engine, all-weather tactical fighter designed to gain and maintain air superiority. Unlike most F-15C's, the Israeli Air Force variant has a limited strike capability.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Fighter, fourth generation</li>
											<li><strong>Role:</strong> Air Superiority</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15C Akef-2000</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-63 (Search/FCR),<br>Max Range: 100 nm</li>
												<li>AN/ALQ-128 EEWS (RWR), Max Range: 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-7P Sparrow III</li>
												<li>AIM-120C-7 AMRAAM</li>
												<li>Python 4</li>
												<li>Python 5</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-15C Eagle Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15c" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15C Eagle</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/giICQuN.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15C Eagle is a twin-engine, all-weather tactical fighter designed to gain and maintain air superiority. It is among the most successful modern fighters, with over 100 aerial combat victories.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Fighter, fourth generation</li>
											<li><strong>Role:</strong> Air Superiority</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15C Eagle</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-70 (Search/FCR),<br>Max Range: 100 nm</li>
												<li>AN/ALQ-128 EEWS (RWR), Max Range: 120 nm</li>
												<li>AN/ALQ-135 TEWS Upgrade (DECM)</li>
												<li>AN/ALR-56C TEWS (RWR), Max Range 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-9X-3 Sidewinder Blk II+</li>
												<li>AIM-120D AMRAAM</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-15E Strike Eagle Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15e" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15E Strike Eagle</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/wj6OLmY.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15E Strike Eagle is a all-weather multirole strike aircraft derived from the F-15C Eagle. The F-15E was designed in the 1980s for long-range range, high-speed interdiction without relying on escort or electronic warfare aircraft.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15E Strike Eagle</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-82(V)1 AESA (Search/FCR),<br>Max Range: 220 nm</li>
												<li>AN/ALQ-128 EEWS (RWR), Max Range: 120 nm</li>
												<li>AN/ALQ-135 TEWS Upgrade (DECM)</li>
												<li>AN/ALR-56C TEWS (RWR), Max Range 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120D AMRAAM</li>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>BLU-116/B [2000lb, Penetrator]</li>
												<li>BLU-122/B [4700lb, Penetrator]</li>
												<li>GBU-39/B SDB</li>
												<li>GBU-53/B StormBreaker</li>
												<li>GBU-72/B [5000lb Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-15EX Strike Eagle Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15ex" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15EX Eagle II</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/GPLw07S.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15EX Eagle II is a multirole fighter derived from the F-15E Strike Eagle. It resulted from USAF studies to recapitalize the tactical aviation fleet that was aging due to curtailed modernization, particularly the truncated F-22 production, from post-Cold War budget cuts.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15EX Eagle II</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-82(V)1 AESA (Search/FCR),<br>Max Range: 220 nm</li>
												<li>AN/ALQ-250 EPAWSS DECM (DECM)</li>
												<li>AN/ALQ-250 EPAWSS ESM (RWR),<br>Max Range: 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120D AMRAAM</li>
												<li>AIM-260 JATM</li>
												<li>AGM-158A JASSM</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-15I Ra'am Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15i-raam" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15I Ra'am</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/kb7s5Sp.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15I Ra'am is an all-weather multirole strike aircraft derived from the McDonnel Douglas F-15E Strike Eagle. The F-15I has different avionics systems to meet Israeli requirements.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15I Ra'am</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-70 (Search/FCR),<br>Max Range: 100 nm</li>
												<li>SPS-2100 (DECM)</li>
												<li>SPS-3000 (RWR), Max Range 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-7M Sparrow III</li>
												<li>AIM-9L-1 Sidewinder</li>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120C-7 AMRAAM</li>
												<li>Python 4</li>
												<li>Python 5</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>BLU-122/B [4700lb, Penetrator]</li>
												<li>GBU-39/B SDB</li>
												<li>Golden Horizon [Blue Sparrow] ALBM</li>
												<li>Rampage</li>
												<li>Rocks [Black Sparrow] ALBM</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-15IA Ra'am Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f15ia-raam" data-year="late2020" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-15IA Ra'am</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/kb7s5Sp.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-15IA is a customized version of the F-15EX Eagle II for the Israeli Air Force. It features enhanced processing capabilities and avionics tailored to Israeli requirements.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-15IA Ra'am</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-82(V)1 AESA (Search/FCR),<br>Max Range: 220 nm</li>
												<li>AN/ALQ-250 EPAWSS (DECM)</li>
												<li>AN/ALQ-250 EPAWSS (RWR), Max Range 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-7M Sparrow III</li>
												<li>AIM-9L-1 Sidewinder</li>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120C-7 AMRAAM</li>
												<li>Python 4</li>
												<li>Python 5</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>BLU-122/B [4700lb, Penetrator]</li>
												<li>GBU-39/B SDB</li>
												<li>Golden Horizon [Blue Sparrow] ALBM</li>
												<li>Rampage</li>
												<li>Rocks [Black Sparrow] ALBM</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-16C Viper Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f16c" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-16C Viper</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/ZNiPvcx.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-16 Fighting Falcon is a single-engine supersonic multirole fighter aircraft. Designed as an air superiority day fighter, it has evolved into a successful all-weather multirole aircraft.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-16C Viper</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-68(V)9 CCIP (Search/FCR),<br>Max Range: 60 nm</li>
												<li>AN/ALR-56M (RWR), Max Range: 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120D AMRAAM</li>
												<li>AGM-158A JASSM</li>
												<li>AGM-88C HARM</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>GBU-39/B SDB</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-16C Barak Blk 30/40 Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f16c-barak" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-16C Barak Blk 30/40</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/MEIqG4t.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-16 Fighting Falcon is a single-engine supersonic multirole fighter aircraft. The Israeli Air Force has upgraded its older F-16C/D's with new avionics to bring them closer to their I (Sufa) models (itself an upgrade of the Block 52+ F-16D).</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 1 </li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-16C Barak Blk 30/40</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-68(V)1 (Search/FCR),<br>Max Range: 60 nm</li>
												<li>AN/ALR-74 (RWR), Max Range: 120 nm</li>
												<li>EL/L-8240 (DECM)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>Python 3</li>
												<li>Python 5</li>
												<li>AGM-88A HARM</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>MPR-500 [500lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-16D Barak Blk 30/40 Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f16d-barak" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-16D Barak Blk 30/40</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/MEIqG4t.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-16 Fighting Falcon is a single-engine supersonic multirole fighter aircraft. The Israeli Air Force has upgraded its older F-16C/D's with new avionics to bring them closer to their I (Sufa) models (itself an upgrade of the Block 52+ F-16D).</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-16D Barak Blk 30/40</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-68(V)1 (Search/FCR),<br>Max Range: 60 nm</li>
												<li>AN/ALR-56M (RWR),<br>Max Range: 120 nm (Blk 30 Only)</li>
												<li>AN/ALR-74 (RWR),<br>Max Range: 120 nm (Blk 40 Only)</li>
												<li>EL/L-8240 (DECM)</li>
												<li>SPS 3000 (RWR),<br>Max Range: 120 nm (Blk 30 Only)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>Python 5</li>
												<li>AGM-88A HARM</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>Delilah-AL</li>
												<li>MPR-500 [500lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-16I Sufa Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f16i-sufa" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-16I Sufa</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/j2ZkIQ1.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-16I is a two-seat variant of the Block 52+ developed for the Israeli Air Force. One major deviation of the F-16I from the Block 52 is that approximately 50% of the avionics were replaced by Israeli-developed avionics.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-16I Sufa</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-68(V)9 (Search/FCR),<br>Max Range: 80 nm</li>
												<li>AN/ALR-56M (RWR), Max Range: 120 nm</li>
												<li>EL/L-8240 (DECM)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>Python 3 (F-16C Only)</li>
												<li>Python 5</li>
												<li>AGM-88A HARM</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>MPR-500 [500lb, Penetrator]</li>
												<li>Delilah-AL (F-16D Only)</li>
												<li>Spice 1000 GPS/EO [Mk83] (F-16D Blk 40 Only)</li>
												<li>Spice 2000 GPS/EO [Mk84] (F-16D Blk 40 Only)</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F/A-18E/F Super Hornet Blk II/III Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="fa18e" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F/A-18E/F Super Hornet</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/9mjFvaX.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F/A-18E/F Super Hornet are a series of supersonic twin-engine, carrier-capable, multirole fighter aircraft derived from the F/A-18 Hornet.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 1/2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F/A-18E/F Super Hornet</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-79 AESA (Search/FRC),<br>Max Range: 120 nm</li>
												<li>AN/ALQ-214(V)4 IDECM (DECM)</li>
												<li>AN/ALR-67(V)3 (RWR), Max Range: 120 nm</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120D AMRAAM</li>
												<li data-year="mid2020, late2020">AIM-174B Gunslinger</li>
												<li data-year="late2020">AIM-260 JATM</li>
												<li>AGM-84K SLAMER-ATA</li>
												<li>AGM-88C HARM</li>
												<li>AGM-88E AARGM</li>
												<li data-year="mid2020, late2020">AGM-88G AARGM-ER</li>
												<li>AGM-154 JSOW</li>
												<li>BLU-109A/B [2000lb, Penetrator]</li>
												<li>BLU-116/B [2000lb, Penetrator]</li>
												<li data-year="mid2020, late2020">GBU-53/B StormBreaker</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-22A Raptor Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f22a" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-22A Raptor</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/iioBDP1.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-22 Raptor is a twin-engine, all-weather, supersonic stealth fighter aircraft. The aircraft was designed as an air superiority fighter but also incorporates limited ground attack, electronic warfare, and signals intelligence capabilities.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fifth generation</li>
											<li><strong>Role:</strong> Air Superiority, limited strike capability</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-22A Raptor</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-77(V)1 AESA (Search/FCR),<br>Max Range: 220 nm</li>
												<li>AN/APG-77(V)1 OECM (OECM)</li>
												<li>AN/AAR-56 PMAWS (MAWS)</li>
												<li>AN/ALR-94 (ELINT)</li>
												<li data-year="late2020">TacIRST IRDS (IRST)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X-2 Sidewinder</li>
												<li>AIM-9X-3 Sidewinder</li>
												<li>AIM-120D AMRAAM</li>
												<li>GBU-39/B SDB</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-35A Lightning II Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f35a" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-35A Lightning II</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/yWZYfgP.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-35A Lightning II is the land-based variant of a family of single-seat, single-engine, supersonic stealth fighters. Is is designed for both air superiority and strike missions, and is capable of providing electronic warfare, surveillance, and reconnaissance.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fifth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-35A Lightning II</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li data-year="early2020">AN/APG-81 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li data-year="mid2020, late2020">AN/APG-85 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li data-year="early2020">AN/APG-81 OECM (OECM)</li>
												<li data-year="mid2020, late2020">AN/APG-85 OECM (OECM)</li>
												<li data-year="early2020">AN/AAQ-37 EO-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li data-year="mid2020, late2020">AN/AAQ-37 NG-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li data-year="early2020">AN/AAQ-37 EO-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li data-year="mid2020, late2020">AN/AAQ-37 NG-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li>AN/AAQ-40 EOTS (IRST),<br>Max Range: 20 / 100 nm</li>
												<li>AN/ASQ-239 Barracuda (ELINT)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li data-year="mid2020, late2020">AIM-9X-2 Sidewinder Blk II</li>
												<li>AIM-120D AMRAAM</li>
												<li data-year="late2020">AIM-260 JATM</li>
												<li data-year="late2020">AGM-88G AARGM-ER</li>
												<li>AGM-154 JSOW</li>
												<li data-year="late2020">AGM-158A JASSM</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li data-year="mid2020, late2020">GBU-53/B StormBreaker</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-35C Lightning II Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f35c" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-35C Lightning II</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/5oi1rx7.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-35C Lightning II is the carrier-based variant of a family of single-seat, single-engine, supersonic stealth fighters. Is is designed for both air superiority and strike missions, and is capable of providing electronic warfare, surveillance, and reconnaissance.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fifth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-35C Lightning II</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li data-year="early2020">AN/APG-81 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li data-year="mid2020, late2020">AN/APG-85 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li data-year="early2020">AN/APG-81 OECM (OECM)</li>
												<li data-year="mid2020, late2020">AN/APG-85 OECM (OECM)</li>
												<li data-year="early2020">AN/AAQ-37 EO-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li data-year="mid2020, late2020">AN/AAQ-37 NG-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li data-year="early2020">AN/AAQ-37 EO-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li data-year="mid2020, late2020">AN/AAQ-37 NG-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li>AN/AAQ-40 EOTS (IRST),<br>Max Range: 20 / 100 nm</li>
												<li>AN/ASQ-239 Barracuda (ELINT)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-9X Sidewinder</li>
												<li>AIM-120D AMRAAM</li>
												<li data-year="late2020">AIM-260 JATM</li>
												<li data-year="late2020">AGM-88G AARGM-ER</li>
												<li>AGM-154 JSOW</li>
												<li>BLU-109A/B [2000lb, Penetrator]</li>
												<li data-year="mid2020, late2020">GBU-53/B StormBreaker</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- F-35I Adir Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="f35i-adir" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">F-35I Adir</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/XaJTgTM.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The F-35I Adir is an F-35A with unique Israeli modifications. The US initially refused to allow such changes before permitting Israel to integrate its own electronic warfare systems, including sensors and countermeasures.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack), fourth generation</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 1</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">F-35I Adir</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-81 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li>AN/APG-81 OECM (OECM)</li>
												<li>AN/AAQ-37 EO-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li>AN/AAQ-37 EO-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li>AN/AAQ-40 EOTS (IRST),<br>Max Range: 20 / 100 nm</li>
												<li>AN/ASQ-239 Barracude (ELINT)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-120C-7 AMRAAM</li>
												<li data-year="mid2020, late2020">Python 5</li>
												<li>BLU-109A/B [2000lb, Penetrator]</li>
												<li>GBU-39/B SDB</li>
												<li data-year="mid2020, late2020">MPR-500 [500lb, Penetrator]</li>
												<li>Rampage</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- FQ-XX CCA Card -->
							<div class="unit-card" data-categories="fighters" onclick="toggleCard(this)" data-unit-id="fqxx" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">FQ-XX CCA</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/ul0aGva.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The FQ-XX represents upcoming uncrewed, jet-powered aircraft designed to operate alongside manned fighters. These "loyal wingmen" will leverage AI to collaborate with and take direction from human pilots. They will be capable of various missions, including air-to-air and air-to-ground combat, electronic warfare, and ISR.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Multirole (Fighter/Attack)</li>
											<li><strong>Role:</strong> Air Superiority, Strike, Suppression of Enemy Air Defenses</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">FQ-XX CCA</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-68(V)9 CCIP (Search/FCR),<br>Max Range: 60 nm</li>
												<li>AN/AAQ-40 EOTS (IRST),<br>Max Range: 20 / 100 nm</li>
												<li>AN/ASQ-239 Barracuda (ELINT)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-120D AMRAAM</li>
												<li>AIM-260 JATM</li>
												<li>AGM-88E AARGM</li>
												<li>AGM-88G AARGM-ER</li>
												<li>AGM-154 JSOW</li>
												<li>GBU-53/B StormBreaker</li>
												<li>Generic OECM Pod [Advanced]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-1B Lancer Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b1b" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-1B Lancer</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/ZeZL1YF.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The B-1 Lancer is a supersonic variable-sweep wing heavy bomber.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike</li>
											<li><strong>Crew:</strong> 4</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-1B Lancer</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-83 SABR-GS AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li>AN/ALQ-153 (MAWS)</li>
												<li>AN/ALQ-161 ECM (OECM/DECM)</li>
												<li>AN/ALQ-161 RWR (RWR)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li data-year="late2020">AGM-183A ARRW</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-1R Lancer Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b1r" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-1R Lancer</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/HE1v8rU.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The B-1R was a 2004 proposed upgrade of existing B-1B aircraft. The B-1R (R for "regional") would be fitted with advanced radars, air-to-air missiles, and new Pratt & Whitney F119 engines.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike, Air Superiority</li>
											<li><strong>Crew:</strong> 4</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-1R Lancer</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-83 SABR-GS AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li>AN/ALQ-153 (MAWS)</li>
												<li>AN/ALQ-161 ECM (OECM/DECM)</li>
												<li>AN/ALQ-161 RWR (RWR)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-120D AMRAAM</li>
												<li data-year="late2020">AIM-260 JATM</li>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-2A Spirit Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b2a" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-2A Spirit</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/uaKNwW0.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The B-2 Spirit, also known as the Stealth Bomber, is a heavy strategic bomber, featuring low-observable stealth technology designed to penetrate dense anti-aircraft defenses.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-2A Spirit</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APQ-181 AESA (Search/FCR),<br>Max Range: 100 nm</li>
												<li>AN/APR-50 DMS (ELINT)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li data-year="mid2020, late2020">AGM-158B-2 JASSM-ER</li>
												<li data-year="late2020">AGM-158D JASSM-D</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>BLU-122/B [4700lb, Penetrator]</li>
												<li>GBU-57A/B MOP [5300lb HE HTP]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-21A Raider Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b21a" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-21A Raider</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The B-21 Raider is a next-generation, stealth bomber being developed for the U.S. Air Force. It's designed to be long-range, highly survivable, and capable of carrying both conventional and nuclear munitions. The B-21 is intended to replace the aging B-1 and B-2 bombers in the early 2030s.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-21A Raider</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-81 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li>AN/APG-81 OECM (OECM)</li>
												<li>AN/AAQ-37 EO-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li>AN/AAQ-37 EO-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li>AN/ASQ-239 Barracuda (ELINT)</li>
												<li>AN/USQ-113(V)3 (COMINT)</li>
												<li>AN/USQ-113(V)3 (Comms Jammer)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li>AGM-158B-2 JASSM-ER</li>
												<li>AGM-183A ARRW</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>BLU-113A/B [4700lb, Penetrator]</li>
												<li>BLU-122/B [4700lb, Penetrator]</li>
												<li>GBU-57A/B MOP [5300lb HE HTP]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-21R Raider Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b21r" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-21R Raider</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/6H0cM5J.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The B-21 Raider is a next-generation, stealth bomber being developed for the U.S. Air Force. It's designed to be long-range, highly survivable, and capable of carrying both conventional and nuclear munitions. The B-21 is intended to replace the aging B-1 and B-2 bombers in the early 2030s.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-21R Raider</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-81 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li>AN/APG-81 OECM (OECM)</li>
												<li>AN/AAQ-37 EO-DAS (FC),<br>Max Range: 20 / 60 nm</li>
												<li>AN/AAQ-37 EO-DAS MAWS (MAWS),<br>Max Range: 30 / 5 nm</li>
												<li>AN/ASQ-239 Barracuda (ELINT)</li>
												<li>AN/USQ-113(V)3 (COMINT)</li>
												<li>AN/USQ-113(V)3 (Comms Jammer)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul class="unit-card-back-scrunch">
												<li>AIM-120D AMRAAM</li>
												<li>AIM-174B Gunslinger</li>
												<li>AIM-260 JATM</li>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li>AGM-158B-2 JASSM-ER</li>
												<li>AGM-183A ARRW</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
												<li>BLU-113A/B [4700lb, Penetrator]</li>
												<li>BLU-122/B [4700lb, Penetrator]</li>
												<li>GBU-57A/B MOP [5300lb HE HTP]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-52H BUFF Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b52h" data-year="early2020, mid2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-52H BUFF</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Boeing B-52 Stratofortress is a long-range, subsonic, jet-powered strategic bomber. The bomber can carry up to 70,000 pounds (32,000 kg) of weapons and has a typical combat range of around 8,800 miles (14,200 km) without aerial refueling.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-52H BUFF</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APQ-166 (Search), Max Range: 150 nm</li>
												<li>AN/AAQ-6 FLIR, Max Range: 10 / 15 nm</li>
												<li>AN/AVQ-22 LLTV, Max Range: 6 / 15 nm</li>
												<li>AN/ALR-20A (RWR), Max Range: 120 nm</li>
												<li>AN/ALR-46(V) (RWR), Max Range: 120 nm</li>
												<li>AN/ALT-16A (OECM/DECM)</li>
												<li>AN/ALT-28 (OECM)</li>
												<li>AN/ALT-32H (OECM)</li>
												<li>AN/ALT-32L (OECM)</li>
												<li>AN/ALQ-172(V)2 (DECM)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>ADM-160B MALD</li>
												<li>ADM-160C MALD-J [Stand-In OECM]</li>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- B-52J BUFF Card -->
							<div class="unit-card" data-categories="bombers" onclick="toggleCard(this)" data-unit-id="b52j" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">B-52J BUFF</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/MYkg7CP.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Boeing B-52 Stratofortress is a long-range, subsonic, jet-powered strategic bomber. The bomber can carry up to 70,000 pounds (32,000 kg) of weapons and has a typical combat range of around 8,800 miles (14,200 km) without aerial refueling.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Bomber</li>
											<li><strong>Role:</strong> Strike</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">B-52J BUFF</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APQ-188 BMRS (Search), Max Range: 120 nm</li>
												<li>AN/ALR-20A (RWR), Max Range: 120 nm</li>
												<li>AN/ALR-46(V) (RWR), Max Range: 120 nm</li>
												<li>AN/ALT-16A (OECM/DECM)</li>
												<li>AN/ALT-28 (OECM)</li>
												<li>AN/ALT-32H (OECM)</li>
												<li>AN/ALT-32L (OECM)</li>
												<li>AN/ALQ-172(V)2 (DECM)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>ADM-160B MALD</li>
												<li>ADM-160C MALD-J [Stand-In OECM]</li>
												<li>AGM-158A JASSM</li>
												<li>AGM-158B JASSM-ER</li>
												<li>AGM-158D JASSM-D</li>
												<li>AGM-183A ARRW</li>
												<li>BLU-109/B [2000lb, Penetrator]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- E-2D Advanced Hawkeye Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="e2d" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">E-2D Advanced Hawkeye</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/8Pn8jBY.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The E-2 Hawkeye is an all-weather, carrier-capable tactical airborne early warning (AEW) aircraft.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Airborne Early Warning</li>
											<li><strong>Role:</strong> Airborne Surveillance, Command and Control</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">E-2D Advanced Hawkeye</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APY-9 (Search), Max Range: 350 nm</li>
												<li>AN/ALQ-217 (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- E-3G Sentry Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="e3g" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">E-3G Sentry</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/fCxxDEN.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The E-3 Sentry is an airborne early warning and control (AEW&C) aircraft. Derived from the Boeing 707 airliner, it provides all-weather surveillance, command, control, and communications.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Airborne Early Warning</li>
											<li><strong>Role:</strong> Airborne Surveillance, Command and Control</li>
											<li><strong>Crew:</strong> 17</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">E-3G Sentry</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APY-2 RSIP (Search), Max Range: 350 nm</li>
												<li>AN/AYR-2 (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- E-7A Wedgetail Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="e7a" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">E-7A Wedgetail</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/uTD6DkO.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The E-7A Wedgetail is a twin-engine airborne early warning and control aircraft based on the Boeing 737 Next Generation design. It has a fixed, active electronically scanned array radar antenna instead of a rotating one as with the 707-based Boeing E-3 Sentry.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Airborne Early Warning</li>
											<li><strong>Role:</strong> Airborne Surveillance, Command and Control</li>
											<li><strong>Crew:</strong> 10</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">E-7A Wedgetail</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>MESA (Search), Max Range: 350 nm</li>
												<li>AN/AAR-54 (MAWS), Max Range: 25 / 5 nm</li>
												<li>AN/AAQ-24(V) DIRCM (IRCM)</li>
												<li>EL/ALR-2001 Odyssey (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- E-8C Joint STARS Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="e8c" data-year="early2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">E-8C Joint STARS</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/mJ5TC91.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The E-8 Joint Surveillance Target Attack Radar System (Joint STARS) is an airborne ground surveillance, battle management, command and control aircraft. It tracks ground vehicles and some aircraft, collects imagery, and relays tactical pictures to ground and air theater commanders.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Surveillance</li>
											<li><strong>Role:</strong> Ground Surveillance, Battle Management, Command and Control</li>
											<li><strong>Crew:</strong> 15</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">E-8C Joint STARS</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APY-7 AESA (Search), Max Range: 135 nm</li>
												<li>Generic ESM [Advanced] (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- EA-18G Growler Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="ea18g" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">EA-18G Growler</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/9lV8DJD.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The EA-18G Growler is a carrier-based electronic warfare aircraft. The Growler's flight performance is similar to that of the F/A-18E/F it is based on. This attribute enables the Growler to perform escort jamming and suppression of enemy air defenses, as well as traditional standoff jamming missions.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Electronic Warfare</li>
											<li><strong>Role:</strong> Electronic Warfare, Suppression of Enemy Air Defenses</li>
											<li><strong>Crew:</strong> 2</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">EA-18G Growler</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-79 AESA (Search/FRC),<br>Max Range: 120 nm</li>
												<li>AN/ALQ-218 (ELINT)</li>
												<li>AN/USQ-113(V)3 (COMINT)</li>
												<li>AN/USQ-113(V)3 (Comms Jammer)</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>AIM-120D AMRAAM</li>
												<li>AGM-88C HARM</li>
												<li>AGM-88E AARGM</li>
												<li data-year="mid2020, late2020">AGM-88G AARGM-ER</li>
												<li data-year="early2020">AN/ALQ-99F-V ECM Pod</li>
												<li data-year="mid2020">AN/ALQ-249(V)1 NGJ-MB ECM Pod</li>
												<li data-year="late2020">AN/ALQ-249(V)1 NGJ-MBX ECM Pod</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- EA-37B Compass Call Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="ea37b" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">EA-37B Compass Call</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/LP3QSu8.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The EA-37B Compass Call is a new electronic warfare aircraft for the U.S. Air Force, replacing the older EC-130H Compass Call. It is based on the Gulfstream G550 business jet and is designed to disrupt adversary communications, information processing, and navigation systems.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type/Role:</strong> Electronic Warfare</li>
											<li><strong>Crew:</strong> 13</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">EA-37B Compass Call</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/ALR-63 (ELINT)</li>
												<li>AN/ALQ-173(V) (OECM/DECM)</li>
												<li>AN/ALQ-175 (DECM)</li>
												<li>Generic Comms Jammer</li>
												<li>Generic Infrared Line Scanner (IRLS),<br>Max Range: 5 / 5 nm</li>
												<li>Generic IR Camera,<br>Max Range: 20 / 30 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- EC-130H Compass Call Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="ec130h" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">EC-130H Compass Call</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/VxkMYYf.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The EC-130H Compass Call is an electronic attack aircraft. Based on the C-130 Hercules, the aircraft is heavily modified to disrupt enemy command and control communications, attack early warning and acquisition radars, perform offensive counterinformation operations, and carry out other kinds of electronic attacks.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type/Role:</strong> Electronic Warfare</li>
											<li><strong>Crew:</strong> 13</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">EC-130H Compass Call</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/ALR-63 (ELINT)</li>
												<li>AN/ALQ-173(V) (OECM/DECM)</li>
												<li>AN/ALQ-175 (DECM)</li>
												<li>Generic Comms Jammer</li>
												<li>Generic FLIR (FLIR),<br>Max Range: 15 / 30 nm</li>
												<li>Generic Infrared Line Scanner (IRLS),<br>Max Range: 5 / 5 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Gulfstream G550 Eitam Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="g550-eitam" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Gulfstream G550 Eitam</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/xbIbDmD.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Nashom Eitam is based on the Gulfstream G550 business jet. It has been modified to fullfill the airborne early warning roll for the Israeli Air Force.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Airborne Early Warning</li>
											<li><strong>Role:</strong> Airborne Surveillance, Command and Control</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Gulfstream G550 Eitam</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Phalcon AEWR (Search), Max Range: 350 nm</li>
												<li>Generic ESM [Advanced] (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Gulfstream G550 Shavit Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="g550-shavit" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Gulfstream G550 Shavit</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/QVdMsQI.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Nashom Shavit is an airborne SIGINT platform based on the Gulfstream G550 business jet.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Reconnaissance</li>
											<li><strong>Role:</strong> Signals Intelligence (SIGINT)</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Gulfstream G550 Shavit</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Generic ESM [Advanced] (ELINT)</li>
												<li>Generic SIGINT (ELINT/COMINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Gulfstream G550 Oron Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="g550-oron" data-year="mid2020, late2020" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Gulfstream G550 Oron</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/W4p4E7A.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Oron is a wide-area persistant surveillance and multisensor aircraft based on the Gulfstream G550 for the Israeli Air Force. It combines the functionality of the Nashom Eitam and Shavit.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Airborne Early Warning</li>
											<li><strong>Role:</strong> Airborne Surveillance, Command and Control, Signals Intelligence (SIGINT)</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Gulfstream G550 Oron</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Phalcon AEWR (Search), Max Range: 350 nm</li>
												<li>Generic ESM [Advanced] (ELINT)</li>
												<li>Generic SIGINT (ELINT/COMINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- RC-135W Rivet Joint Card -->
							<div class="unit-card" data-categories="electronic" onclick="toggleCard(this)" data-unit-id="rc135w" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">RC-135W Rivet Joint</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/wjmewb9.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The RC-135V/W is an airborne SIGINT platform. Its sensor suite allows the mission crew to detect, identify and geolocate signals throughout the electromagnetic spectrum.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Reconnaissance</li>
											<li><strong>Role:</strong> Signals Intelligence (SIGINT)</li>
											<li><strong>Crew:</strong> 27</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">RC-135W Rivet Joint</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Generic COMINT</li>
												<li>Generic ESM [Advanced]</li>
												<li>Generic SIGINT (ELINT/COMINT)</li>
												<li>Generic IR Camera, Max Range: 20 / 30 nm</li>
												<li>Generic TV Camera, Max Range: 20 / 30 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- KC-10A Extender Card -->
							<div class="unit-card" data-categories="tankers" onclick="toggleCard(this)" data-unit-id="kc10a" data-year="early2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">KC-10A Extender</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/KatrE1F.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The KC-10A Extender is a tanker and cargo aircraft based on the the three-engine DC-10 airliner.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Tanker</li>
											<li><strong>Role:</strong> Aerial Refueling, Transport</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">KC-10A Extender</h3>
									<ul class="unit-card-details-back">
										<!-- Placeholder -->
									</ul>
								</div>
							</div>

							<!-- KC-46A Pegasus Card -->
							<div class="unit-card" data-categories="tankers" onclick="toggleCard(this)" data-unit-id="kc46a" data-year="mid2020, late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">KC-46A Pegasus</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/7miACe7.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The KC-46 Pegasus is an aerial refueling and strategic military transport aircraft based on the Boeing 767 airliner.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li data-side="usa"><strong>Country:</strong> United States (Air Force)</li>
											<li data-side="israel, usa-israel"><strong>Country:</strong> United States & Israel (Air Force)</li>
											<li><strong>Type:</strong> Tanker</li>
											<li><strong>Role:</strong> Aerial Refueling, Transport</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">KC-46A Pegasus</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAR-54 (MAWS), Max Range: 25 / 5 nm</li>
												<li>AN/AAQ-24(V) DIRCM (IRCM)</li>
												<li>AN/ALR-69A (RWR), Max Range: 120 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- KC-130H Qarnaf Card -->
							<div class="unit-card" data-categories="tankers" onclick="toggleCard(this)" data-unit-id="kc130-qarnaf" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">KC-130H Qarnaf</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/DxNdYKL.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The KC-130H Qarnaf is a multi-role, tactical tanker/trasnport aircraft used for air-to-air refueling, troop and cargo transport, and other missions.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Tanker</li>
											<li><strong>Role:</strong> Aerial Refueling, Transport</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">KC-130H Qarnaf</h3>
									<ul class="unit-card-details-back">
										<li>
											<!-- Placeholder -->
										<li>
									</ul>
								</div>
							</div>

							<!-- KC-135R Stratotanker Card -->
							<div class="unit-card" data-categories="tankers" onclick="toggleCard(this)" data-unit-id="kc135r" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">KC-135R Stratotanker</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/geNGO78.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The KC-135 Stratotanker is an aerial refueling tanker aircraft that was developed from the Boeing 367-80 prototype, alongside the Boeing 707 airliner.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Tanker</li>
											<li><strong>Role:</strong> Aerial Refueling, Transport</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">KC-135R Stratotanker</h3>
									<ul class="unit-card-details-back">
										<!-- Placeholder -->
									</ul>
								</div>
							</div>

							<!-- KC-707 Saknayee Card -->
							<div class="unit-card" data-categories="tankers" onclick="toggleCard(this)" data-unit-id="kc707-saknayee" data-year="early2020, mid2020" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">KC-707 Saknayee</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/xyKGerO.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The KC-707 is a tanker version of the Boeng 707 airliner. While similar to the KC-135 used by the USAF, it differs structurally and stores fuel in removable tanks in the cargo hold contrasting to the KC-135s specialized stores in the wings and lower fuselage.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Tanker</li>
											<li><strong>Role:</strong> Aerial Refueling, Transport</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">KC-707 Saknayee</h3>
									<ul class="unit-card-details-back">
										<!-- Placeholder -->
									</ul>
								</div>
							</div>

							<!-- C-17A Globemaster III Card -->
							<div class="unit-card" data-categories="cargo" onclick="toggleCard(this)" data-unit-id="c17a" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">C-17A Globemaster III</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/lRUmomt.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The C-17A Globemaster III is a large military transport aircraft.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type/Role:</strong> Transport</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">C-17A Globemaster III</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAR-54 (MAWS), Max Range: 25 / 5 nm</li>
												<li>AN/AAQ-24(V) DIRCM (IRCM)</li>
												<li>Generic Night Vision Goggles,<br>Max Range: 10 / 15</li>
											</ul>
											<strong>Munitions:</strong>
											<ul>
												<li>Rapid Dragon Weapon Pallet<br>[9x AGM-158B JASSM-ER]</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>

							<!-- C-130J-30 Shimshon Card -->
							<div class="unit-card" data-categories="cargo" onclick="toggleCard(this)" data-unit-id="c130-shimshon" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">C-130J-30 Shimshon</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/CRJJtvL.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The C-130J Shimson (Super Hercules) is a four-engine turboprop military transport aircraft. The C-130J is a comprehensive update of the C-130 Hercules, with new engines, flight deck, and other systems.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front"><li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type/Role:</strong> Transport</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">C-130J-30 Shimshon</h3>
									<ul class="unit-card-details-back">
										<li>
											<!-- Placeholder -->
										<li>
									</ul>
								</div>
							</div>

							<!-- CH-53C Yasur 2025 Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="ch53c-yasur" data-year="early2020, mid2020" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">CH-53C Yasur</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/C1kcPX3.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The CH-53 Yas'ur is a family of heavy-lift transport helicopters.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Transport</li>
											<li><strong>Role:</strong> Search and Rescue, Transport</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">CH-53C Yasur</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>EL/M-2160 (MAWS), Max Range: 25 / 5 nm</li>
												<li>Generic RWR (RWR), Max Range: 120 nm</li>
												<li>Mini-MUSIC DIRCM (IRCM)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- CH-53K King Stallion Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="ch53k-king-stallion" data-year="late2020" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">CH-53K King Stallion</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/gyF9PK6.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The CH-53K King Stallion is an evolution of the long-running CH-53 series of helicopters. It features three up-rated 7,500 shp (5,590 kW) engines, new composite rotor blades, and a wider aircraft cabin than its predecessors.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Transport</li>
											<li><strong>Role:</strong> Search and Rescue, Transport</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">CH-53K King Stallion</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAQ-29A (FLIR), Max Range: 20 / 45 nm</li>
												<li>AM/APR-39A(V)2 (RWR), Max Range 120 nm</li>
												<li>EL/M-2160 (MAWS), Max Range: 25 / 5 nm</li>
												<li>Mini-MUSIC DIRCM (IRCM)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- HC-130J Combat King II Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="hc130j" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">HC-130J Combat King II</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/KQSiA7r.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The HC-130 is a search and rescue version of the C-130 Hercules. It provides on scene CSAR command and control, airdrop pararescue forces and equipment, and provides aerial refueling to extend the range and endurance of combat search and rescue helicopters.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Search and Rescue</li>
											<li><strong>Role:</strong> Command and Control, Airdrop, Aerial Refueling</li>
											<li><strong>Crew:</strong> 11</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">HC-130J Combat King II</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAQ-24(V) DIRCM (IRCM)</li>
												<li>AN/AAR-54 (MAWS), Max Range: 25 / 5 nm</li>
												<li>Generic LLTV (LLTV),<br>Max Range: 10 / 30 nm</li>
												<li>Generic IR Camera, Max Range: 20 / 30 nm</li>
												<li>Generic RWR (RWR), Max Range: 120 nm</li>
												<li>Generic DECM [Advanced] (DECM)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- MC-130J Commando II Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="mc130j" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">MC-130J Commando II</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/MJFVdjg.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Commando II flies clandestine, or low visibility, single or multiship, low-level infiltration, exfiltration and resupply of special operations forces, by airdrop or airland and air refueling missions for special operations helicopters and tiltrotor aircraft, intruding politically sensitive or hostile territories.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Tanker, Transport</li>
											<li><strong>Role:</strong> Aerial Refueling, Transport</li>
											<li><strong>Crew:</strong> 5</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">MC-130J Commando II</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAS-52 MTS-A (IR),<br>Max Range: 20 / 100 nm</li>
												<li>AN/AAQ-24 DIRCM (IRCM)</li>
												<li>AN/AAR-47(V) (MAWS), Max Range: 20 / 5 nm</li>
												<li>AN/ALQ-251 RCFM (DECM)</li>
												<li>AN/ALQ-251 RCFM (RWR), Max Range: 120 nm</li>
												<li>AN/ALR-56M (RWR), Max Range: 120 nm</li>
											</ul>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Rapid Dragon Weapons Pallet<br>[6x AGM-158B JASSM-ER]</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- HH-60G Credible Hawk Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="hh60g" data-year="early2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">HH-60G Credible Hawk</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/yOUmAux.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The HH-60G Credible Hawk is a search and rescue version of the UH-60 Black Hawk medium-lift utility helicopter. It's core mission is the recovery of personnel under hostile conditions, day or night. Because of its versatility it often performs peacetime humanitarian and disaster relief activies.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type/Role:</strong> Search and Rescue</li>
											<li><strong>Crew:</strong> 4</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">HH-60G Credible Hawk</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAQ-16 AESOP (IR Camera),<br>Max Range: 15 / 15 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- HH-60W Jolly Green II Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="hh60w" data-year="mid2020, late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">HH-60W Jolly Green II</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/9VGlRz6.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">Combat rescue helicopter variant of the UH-60M for the U.S. Air Force to replace the HH-60G Pave Hawk. It's core mission is the recovery of personnel under hostile conditions, day or night. Because of its versatility it often performs peacetime humanitarian and disaster relief activies.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type/Role:</strong> Search and Rescue</li>
											<li><strong>Crew:</strong> 4</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">HH-60W Jolly Green II</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APN-239 [RDR 1400C] (Search),<br>Max Range: 80 nm</li>
												<li>AN/AAQ-16 AESOP (IR Camera),<br>Max Range: 15 / 15 nm</li>
												<li>AN/ALQ-144 (IRCM)</li>
												<li>AN/APR-39(V)1 (RWR), Max Range: 120 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- MH-60R Seahawk Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="mh60r" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">MH-60R Seahawk</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/mIeramt.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The MH-60R Seahawk is a multi-mission helicopter, primarily used for anti-submarine and anti-surface warfare, but also capable of other maritime missions. </p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type/Role:</strong> Search and Rescue</li>
											<li><strong>Crew:</strong> 4</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">MH-60R Seahawk</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APS-153(V) MMR (Search),<br>Max Range: 200nm</li>
												<li>AN/AAR-47(V)2 (MAWS),<br>Max Range: 25 / 5 nm</li>
												<li>AN/AAS-44C(V) (IRST),<br>Max Range: 15 / 30 nm</li>
												<li>AN/ALQ-210 (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- MH-60S Seahawk Card -->
							<div class="unit-card" data-categories="rescue" onclick="toggleCard(this)" data-unit-id="mh60s" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">MH-60S Seahawk</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/2oDYUL4.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The MH-60S Seahawk is a multi-mission naval helicopter, used for tasks like vertical replenishment, combat search and rescue, special warfare support, and airborne mine countermeasures.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type/Role:</strong> Search and Rescue</li>
											<li><strong>Crew:</strong> 3</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">MH-60S Seahawk</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/AAR-47(V)2 (MAWS),<br>Max Range: 25 / 5 nm</li>
												<li>AN/AAS-44C(V) (IR),<br>Max Range: 15 / 30 nm</li>
												<li>AN/APR-39A(V)2 (RWR), Max Range: 120 nm</li>
												<li>AN/ALQ-144A(V)6 (IRCM)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Hermes 900 Kohav Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="hermes900-kohav" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Hermes 900 Kohav</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/KLSt2gW.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Hermes 900 Kochav is a medium-size, multi-payload, medium-altitude long-endurance unmanned aerial vehicle (UAV) designed for persistent over-the-horizon operations.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Hermes 900 Kohav</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Generic FLR (FLIR), Max Range: 20 / 45 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Heron Shoval Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="heron-shoval" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Heron Shoval</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/Z8XPv5t.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Heron Shoval is a medium-size, medium-altitude long-endurance unmanned aerial vehicle (UAV).</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Heron UAV Shoval</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Generic FLR (FLIR), Max Range: 20 / 45 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Heron TP Eitan Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="herontp-eitan" data-side="israel, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Heron TP Eitan</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/q4MCBwQ.jpeg" alt="Unit Image" class="unit-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Heron TP Eitan is a medium-size, medium-altitude long-endurance unmanned aerial vehicle (UAV).</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> Israel (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Heron TP Eitan</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>Generic FLR (FLIR), Max Range: 20 / 45 nm</li>
												<li>Generic ESM [Advanced] (ELINT)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- MQ-9A Reaper Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="mq9a" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">MQ-9A Reaper</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/i1cuBxO.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The MQ-9 Reaper is an unmanned aerial vehicle. It is the first hunter-killer UAV designed for long-endurance, high-altitude surveillance.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">MQ-9A Reaper</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APY-8 Lynx (Search), Max Range: 45 nm</li>
												<li>AN/DAS-1 MTS-B [EO]</li>
												<li>AN/DAS-1 MTS-B [IR]</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- MQ-25A Stingray Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="mq25a" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">MQ-25A Stingray</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/htxs4Wl.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The MQ-25A Stingray is a carrier-based unmanned aircraft. The Stingray's primary mission is to extend the range of the carrier air wing by providing unmanned aerial refueling capabilities.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Aerial Refueling</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">MQ-25A Stingray</h3>
									<ul class="unit-card-details-back">
										<!-- Placeholder -->
									</ul>
								</div>
							</div>

							<!-- RQ-4B Global Hawk Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="rq4b" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">RQ-4B Global Hawk</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/5PCrcrA.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The RQ-4 Global Hawk is a high-altitude, remotely-piloted surveillance aircraft introduced in 2001. It provides a broad overview and systematic surveillance using high-resolution synthetic aperture radar (SAR) and electro-optical/infrared (EO/IR) sensors with long loiter times over target areas.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">RQ-4B Global Hawk</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/ZPY-2 MP-RTIP AESA, Max Range: 200 nm</li>
												<li>AN/ALR-90 (RWR), Max Range: 120 nm</li>
												<li>AN/APR-49 (RWR), Max Range: 120 nm</li>
												<li>AN/AVR-3 (LWR), Max Range: 10 nm</li>
												<li>ASIP (ELINT), Max Range: 500 nm</li>
												<li>Generic IR Camera, Max Range: 20 / 30 nm</li>
												<li>Generic TV Camera, Max Range: 20 / 30 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- RQ-170 Sentinel Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="rq170a" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">RQ-170A Sentinel</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/fydkIae.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The RQ-170 Sentinel, is an unmanned aerial vehicle (UAV) operated by the United States Air Force (USAF) for the Central Intelligence Agency (CIA). While the USAF has released few details on the UAV's design or capabilities, defense analysts believe that it is a stealth aircraft fitted with aerial reconnaissance equipment.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">RQ-170A Sentinel</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APY-8 Lynx (Search), Max Range: 45 nm</li>
												<li>Generic IR Camera,<br>Max Range: 20 / 30 nm</li>
												<li>Generic TV Camera,<br>Max Range: 20 / 30 nm</li>
												<li>Generic SIGINT (ELINT/COMINT),<br>Max Range: 500 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- RQ-180 Card -->
							<div class="unit-card" data-categories="uav" onclick="toggleCard(this)" data-unit-id="rq180" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">RQ-180</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/AKS4p90.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The RQ-180 is a stealth unmanned aerial vehicle (UAV) surveillance aircraft intended for contested airspace. As of 2019, there had been no images or statements released but evidence points to the existence of the RQ-180 and its use in regular front-line service.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Air Force)</li>
											<li><strong>Type:</strong> Unmanned Aerial Vehicle</li>
											<li><strong>Role:</strong> Reconnaissance, Electronic Intelligence</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">RQ-180</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<ul>
												<li>AN/APG-81 AESA (Search/FCR),<br>Max Range: 200 nm</li>
												<li>Generic DECM [Advanced] (DECM)</li>
												<li>Generic IRCM (IRCM)</li>
												<li>Generic IR Camera, Max Range: 20 / 30 nm</li>
												<li>Generic TV Camera, Max Range: 20 / 30 nm</li>
												<li>Generic SIGINT (ELINT/COMINT),<br>Max Range: 500 nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Arleigh Burke-class DDG Card -->
							<div class="unit-card" data-categories="ships" onclick="toggleCard(this)" data-unit-id="ddg-arleighburke" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Arleigh Burke-class DDG</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/koC3kKG.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Arleigh Burke-class destroyer is a class of guided-missile destroyers (DDG) centered around the AEGIS combat system and SPY series of multifunction passive electronically scanned array radars.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Guided-Missile Destroyer (DDG)</li>
											<li><strong>Role:</strong> Anti-Air Warfare, Anti-Surface Warfare, Anti-Submarine Warfare, Tactical Land Strike</li>
											<li><strong>Crew:</strong> 315</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Arleigh Burke-class DDG</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Munitions:</strong>
											<ul>
												<li>32 x RGM-109E Tomahawk Blk IV TACTOM</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Zumwalt-class DDG Card -->
							<div class="unit-card" data-categories="ships" onclick="toggleCard(this)" data-unit-id="ddg-zumwalt" data-year="late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Zumwalt-class DDG</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/hbOdO0V.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Zumwalt-class destroyer is a class of stealth guided-missile destroyers (DDG). Originally designed primarily for naval gunfire support with secondary anti-air and surface warfare roles. In the mid-2020s they were repurposed for long-range strike by having their advanced gun systems removed and replaced with hypersonic missiles.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Guided-Missile Destroyer (DDG)</li>
											<li><strong>Role:</strong> Tactical Land Strike</li>
											<li><strong>Crew:</strong> 186</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Zumwalt-class DDG</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Munitions:</strong>
											<ul>
												<li>12 x Long-Range Hypersonic Weapon (LRHW)</li>
												<li>56 x RGM-109E Tomahawk Blk IV TACTOM</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Virginia-class SSN Card -->
							<div class="unit-card" data-categories="submarines" onclick="toggleCard(this)" data-unit-id="ssn-virginia" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Virginia-class SSN</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/vVcBF89.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Virginia-class submarine is a class of nuclear powered attack submarine with cruise missile capability. The class is designed for a broad spectrum of open-ocean and littoral missions, including anti-submarine warfare and intelligence gathering operations.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Nuclear Powered Attack Submarine (SSN)</li>
											<li><strong>Role:</strong> Anti-Surface Warfare, Anti-Submarine Warfare, Tactical Land Strike</li>
											<li><strong>Crew:</strong> 145</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Virginia-class SSN</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Munitions:</strong>
											<br><br>
											<strong>Flight III/IV</strong>
											<ul>
												<li>12 x UGM-109J Tomahawk Blk V TACTOM</li>
											</ul>
											<strong data-year="late2020">Flight V</strong>
											<ul data-year="late2020">
												<li>12 x Long-Range Hypersonic Weapon (LRHW)</li>
												<li>12 x UGM-109J Tomahawk Blk Va MST</li>
											</ul>
											<strong data-year="late2020">Flight VI</strong>
											<ul data-year="late2020">
												<li>18 x Long-Range Hypersonic Weapon (LRHW)</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Ohio-class SSGN Card -->
							<div class="unit-card" data-categories="submarines" onclick="toggleCard(this)" data-unit-id="ssgn-ohio" data-year="early2020, mid2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Ohio-class SSGN</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/KmX2QtP.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Ohio-class submarine is a class of four ballistic missile submarines converted into nuclear powered guided missile attack submarines capable of conducting conventional land attack and special operations.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States (Navy)</li>
											<li><strong>Type:</strong> Nuclear Powered Guided Missile Attack Submarine</li>
											<li><strong>Role:</strong> Tactical Land Strike</li>
											<li><strong>Crew:</strong> 155</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Ohio-class SSGN</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Munitions:</strong>
											<ul>
												<li>154 x UGM-109J Tomahawk Blk V TACTOM</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>

							<!-- Low-cost Unmanned Combat Attack System (LUCAS) Card -->
							<div class="unit-card" data-categories="owa" onclick="toggleCard(this)" data-unit-id="lucas" data-year="mid2020, late2020" data-side="usa, usa-israel">
								<!-- Card Front -->
								<div class="unit-card-front">
									<h3 class="unit-card-name">Low-cost Unmanned Combat<br>Attack System (LUCAS)</h3>
									<div class="unit-card-image-container">
										<img src="https://i.imgur.com/i5gMkWP.jpeg" alt="Unit Image" class="unit-card-image">
									</div>
									<div class="unit-card-info">
										<p class="unit-card-description">The Low-cost Unmanned Combat Attack System (LUCAS) is a U.S. one-way attack drone, reverse-engineered from the Iranian Shahed-136. It features a delta wing, operates autonomously, and is designed for modular, mass-produced, expendable strikes.</p>
										<hr class="unit-card-divider">
										<ul class="unit-card-details-front">
											<li><strong>Country:</strong> United States</li>
											<li><strong>Type:</strong> One-Way Attack Drone</li>
											<li><strong>Role:</strong> Tactical Land Strike, SEAD</li>
											<li><strong>Range:</strong> 1350nm</li>
											<li><strong>Warhead:</strong> 90kg HE</li>
										</ul>
									</div>
								</div>

								<!-- Card Back -->
								<div class="unit-card-back">
									<h3 class="unit-card-name">Low-cost Unmanned Combat<br>Attack System (LUCAS)</h3>
									<ul class="unit-card-details-back">
										<li>
											<strong>Sensors/EW:</strong>
											<br><br>
											<strong>ARM</strong>
											<ul>
												<li>Passive Radar Seeker, Max Range: 10nm</li>
											</ul>
											<strong>EO/IR</strong>
											<ul>
												<li>EO Seeker, Max Range: 10nm</li>
												<li>IR Seeker, Max Range: 10nm</li>
											</ul>
										<li>
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>

				<input type="hidden" id="player_side_hidden" value="%s">

				<!-- Leaflet Initialization -->
				<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.js"></script>

				<script>
					// -------------------------- //
					// Show Category Tab Contents //
					// -------------------------- //

					function showTab(tabId, btn) {
						// Hide all tab contents
						document.querySelectorAll(".tab-content").forEach(tab => tab.classList.remove("active"));

						// Remove active class from all buttons
						document.querySelectorAll(".tab-button").forEach(button => button.classList.remove("active"));

						// Show the selected tab
						const activeTab = document.getElementById(tabId);
						if (activeTab) {
							activeTab.classList.add("active");
						}

						// Set the clicked button as active
						if (btn) {
							btn.classList.add("active");
						}



						// Close any open deployment popups when leaving the Operations Map tab
						if (tabId !== "operations-map") {
							document.querySelectorAll('#operations-map .popup-window-container').forEach(popup => {
								popup.style.display = 'none';
							});
							if (typeof closeUnitCardPopup === 'function') {
								closeUnitCardPopup();
							}
						}
						// Initialize or refresh Leaflet when opening the operations map
						if (tabId === "operations-map") {
							if (typeof initOperationsLeafletMap === "function") {
								if (!window.operationsLeafletMap) {
									initOperationsLeafletMap();
								} else {
									// Fix sizing after becoming visible
									setTimeout(function () {
										window.operationsLeafletMap.invalidateSize();

										// Re-apply label zoom visibility after map becomes visible
										if (typeof updateOperationsLabelVisibility === 'function') {
											setTimeout(updateOperationsLabelVisibility, 0);
										}
									}, 0);
								}
							}
						}
					}

					// ------------------------- //
					// Sub-Options Reveal/Hide   //
					// ------------------------- //

					function initializeSubOptionReveal() {
						function applyReveal(selectEl) {
							const targetId = selectEl.dataset.revealTarget;
							if (!targetId) return;

							const target = document.getElementById(targetId);
							if (!target) return;

							const revealWhen = selectEl.dataset.revealWhen;
							const shouldShow = (selectEl.value === revealWhen);

							target.classList.toggle('sub-options-hidden', !shouldShow);
						}

						document.querySelectorAll('select[data-reveal-target]').forEach(selectEl => {
							// Hook change
							selectEl.addEventListener('change', () => applyReveal(selectEl));

							// Apply once on load (so defaults start hidden/shown correctly)
							applyReveal(selectEl);
						});
					}

					// ------------------------- //
					// Enforce Minimum Selection //
					// ------------------------- //

					document.querySelectorAll('.checkbox-group').forEach(group => {
						const upgradeOptions = group.querySelectorAll('.upgrade-option');
						const noneOption = group.querySelector('.none-option');
						const fallbackType = group.dataset.fallback || 'first'; // Default fallback

						// Utility: Ensure at least one checkbox is checked
						function enforceMinimumSelection() {
							const anyChecked = [...upgradeOptions].some(opt => opt.checked) || (noneOption && noneOption.checked);
							if (!anyChecked) {
								if (fallbackType === 'first-two') {
									if (upgradeOptions.length >= 2) {
										upgradeOptions[0].checked = true;
										upgradeOptions[1].checked = true;
									} else if (upgradeOptions.length === 1) {
										upgradeOptions[0].checked = true;
									} else if (noneOption) {
										noneOption.checked = true;
									}
								} else if (fallbackType === 'custom') {
									const customFallbacks = group.querySelectorAll('.default-option');
									if (customFallbacks.length > 0) {
										customFallbacks.forEach(cb => cb.checked = true);
									} else if (upgradeOptions.length > 0) {
										upgradeOptions[0].checked = true;
									} else if (noneOption) {
										noneOption.checked = true;
									}
								} else {
									// Default: check first upgrade
									if (upgradeOptions.length > 0) {
										upgradeOptions[0].checked = true;
									} else if (noneOption) {
										noneOption.checked = true;
									}
								}
							}
						}

						if (noneOption) {
							noneOption.addEventListener('change', () => {
								if (noneOption.checked) {
									upgradeOptions.forEach(opt => opt.checked = false);
								}
								enforceMinimumSelection();
							});

							upgradeOptions.forEach(opt => {
								opt.addEventListener('change', () => {
									if (opt.checked) {
										noneOption.checked = false;
									}
									enforceMinimumSelection();
								});
							});
						} else {
							upgradeOptions.forEach(opt => {
								opt.addEventListener('change', enforceMinimumSelection);
							});
						}

						enforceMinimumSelection(); // Initial run
					});

					// --------------------- //
					// Scenario Setup Gating //
					// --------------------- //

					function setMenuControlsDisabled(menu, disabled) {
						menu.querySelectorAll('select, input, textarea, button').forEach(ctrl => {
							// Close button must always work
							if (ctrl.classList.contains('close-button')) return;
							ctrl.disabled = disabled;
						});
					}

					// Year Gating

					const scenarioYearOrder = {
						early2020: 1,
						mid2020: 2,
						late2020: 3
					};

					function getSelectedScenarioYear() {
						const yearSelect = document.querySelector('select[name="scenario_year"]');
						return yearSelect ? yearSelect.value : 'early2020';
					}

					function yearAllows(el, selectedYear) {
						const yearListRaw = el.dataset.year || '';
						if (!yearListRaw) return true; // No gating means always available
						const years = yearListRaw.split(',').map(s => s.trim()).filter(Boolean);
						return years.includes(selectedYear);
					}

					function markerYearAllows(yearListRaw, selectedYear) {
						if (!yearListRaw) return true; // No gating means always available
						const years = String(yearListRaw)
							.split(',')
							.map(s => s.trim())
							.filter(Boolean);
						return years.includes(selectedYear);
					}

					function applyYearGating(selectedYear) {
						// Option block gating
						document.querySelectorAll('.enable-gating').forEach(el => {
							const yearOk = yearAllows(el, selectedYear);

							// YEAR: always hide
							if (!yearOk) {
								el.style.display = 'none';

								// Reset any selects inside hidden actions so stale choices don't persist
								el.querySelectorAll('select').forEach(sel => {
									const hasBlankOption = Array.from(sel.options).some(opt => opt.value === '');
									if (hasBlankOption) sel.value = '';
								});

								// Reset repositionable markers (YEAR ONLY)
								const positionSelect = el.querySelector('.task-group-position-select');
								if (positionSelect) {
									const markerKey = positionSelect.getAttribute('data-marker-key');
									if (markerKey) {
										resetMarkerToDefaultPosition(markerKey);
									}
								}

								return;
							}

							// If year Ok, don't decide final visibility here (command gating may still hide/disable)
							el.style.display = '';
						});

						// Sub-options with data-year
						document.querySelectorAll('[data-year]').forEach(el => {
							// Avoid double-handling .enable-gating; already handled above
							if (el.classList.contains('enable-gating')) return;
							el.style.display = yearAllows(el, selectedYear) ? '' : 'none';
						});

						// If year gating hid a checked radio, restore valid default
						document.querySelectorAll('.popup-window-table-options-subblock').forEach(subblock => {
							if (subblock.style.display === 'none') return;

							const radios = Array.from(subblock.querySelectorAll('input[type="radio"]'));
							const groups = {};
							radios.forEach(r => {
								if (!r.name) return;
								groups[r.name] = groups[r.name] || [];
								groups[r.name].push(r);
							});

							Object.keys(groups).forEach(name => {
								const group = groups[name];

								function isRadioVisible(r) {
									const label = r.closest('label') || r.parentElement;
									if (!label) return true;
									return !(label.style.display === 'none' || label.closest('[style*="display: none"]'));
								}

								const checked = group.find(r => r.checked);
								if (checked && isRadioVisible(checked)) return;

								const preferred = group.find(r => r.hasAttribute('checked') && isRadioVisible(r));
								const firstVisible = group.find(r => isRadioVisible(r));

								if (preferred) {
									preferred.checked = true;
								} else if (firstVisible) {
									firstVisible.checked = true;
								}
							});
						});

						// menu gating
						document.querySelectorAll('.popup-window-container').forEach(menu => {
							const yearOk = yearAllows(menu, selectedYear);

							// YEAR: always blocks opening
							const menuYearGated = !yearOk;
							menu.dataset.menuGated = menuYearGated ? 'true' : 'false';

							// If it's open and becomes year-gated, close it
							if (menuYearGated && menu.style.display === 'flex') {
								menu.style.display = 'none';
							}
						});
					}

					// Side Gating

					function getSelectedSide() {
						// Preferred: hidden input populated by Lua
						const hidden = document.getElementById('player_side_hidden');
						const v = (hidden && hidden.value != null) ? String(hidden.value).trim() : '';

						// When opened in a normal browser, this field may still be the Lua placeholder ("%s").
						// Treat that the same as unset and fall back to the default side.
						if (!v || v === '%s') return 'usa-israel'; // default side

						return v;
					}

					function sideAllows(el, selectedSide) {
						const sideListRaw = el.dataset.side || '';
						if (!sideListRaw) return true; // No side gating means always available

						const allowed = sideListRaw
							.split(',')
							.map(s => s.trim())
							.filter(Boolean);

						if (allowed.length === 0) return true;

						// STRICT: exact match only
						return allowed.includes(selectedSide);
					}

					function applySideGating(selectedYear, selectedSide) {
						// Scenario Option Blocks
						document.querySelectorAll('.enable-gating').forEach(el => {

							// If year already disallowed it, don't touch it
							if (!yearAllows(el, selectedYear)) return;

							const sideOk = sideAllows(el, selectedSide);

							if (!sideOk) {
								el.style.display = 'none';

								// Reset selects to avoid stale state
								el.querySelectorAll('select').forEach(sel => {
									const hasBlankOption = Array.from(sel.options).some(opt => opt.value === '');
									if (hasBlankOption) sel.value = '';
								});

								// Reset repositionable markers (SIDE behaves like YEAR)
								const positionSelect = el.querySelector('.task-group-position-select');
								if (positionSelect) {
									const markerKey = positionSelect.getAttribute('data-marker-key');
									if (markerKey) {
										resetMarkerToDefaultPosition(markerKey);
									}
								}

								return;
							}

							// Side OK: visibility left for command gating
							el.style.display = '';
						});

						// Generic data-side elements
						document.querySelectorAll('[data-side]').forEach(el => {

							// Avoid double-processing enable-gating blocks
							if (el.classList.contains('enable-gating')) return;

							// Respect year gating first
							if (!yearAllows(el, selectedYear)) return;

							el.style.display = sideAllows(el, selectedSide) ? '' : 'none';
						});

						// Popup window
						document.querySelectorAll('.popup-window-container').forEach(menu => {

							// If year-gated, side is irrelevant
							if (!yearAllows(menu, selectedYear)) {
								menu.dataset.menuSideGated = 'false';
								return;
							}

							const sideOk = sideAllows(menu, selectedSide);
							const menuSideGated = !sideOk;

							// SIDE: always blocks opening
							menu.dataset.menuSideGated = menuSideGated ? 'true' : 'false';

							// Close if currently open
							if (menuSideGated && menu.style.display === 'flex') {
								menu.style.display = 'none';
							}
						});

						// Operations map markers + labels
						if (typeof applyOperationsMarkerGating === 'function') {
							applyOperationsMarkerGating(selectedYear, selectedSide);
						}
					}

					function applySideGatingToTabButtons(selectedSide) {
						const tabButtons = document.querySelectorAll('.tab-button');
						if (!tabButtons.length) return;

						tabButtons.forEach(btn => {
							// Most common patterns:
							// - onclick="openTab(event, 'operationsTab')"
							// - data-tab="operationsTab"
							//
							// We'll support both without requiring you to change markup.

							let tabId = btn.getAttribute('data-tab');

							if (!tabId) {
								const onclick = btn.getAttribute('onclick') || '';
								const match = onclick.match(/openTab\s*\(\s*event\s*,\s*['"]([^'"]+)['"]\s*\)/);
								if (match) tabId = match[1];
							}

							if (!tabId) return; // can't resolve; leave visible

							const panel = document.getElementById(tabId);
							if (!panel) return;

							// If the panel is side-gated, hide the button.
							// NOTE: this uses sideAllows() which checks panel.dataset.side
							const sideOk = sideAllows(panel, selectedSide);

							btn.style.display = sideOk ? '' : 'none';
						});

						// If the currently active tab button is hidden, switch to the first visible one.
						const activeBtn = document.querySelector('.tab-button.active');
						if (activeBtn && activeBtn.style.display === 'none') {
							const firstVisibleBtn = Array.from(tabButtons).find(b => b.style.display !== 'none');
							if (firstVisibleBtn) {
								// Trigger the existing tab switching logic
								firstVisibleBtn.click();
							}
						}
					}

					// Command Level Gating

					function getSelectedCommandLevel() {
						const selected = document.querySelector('input[name="player_command_level"]:checked');
						return selected ? selected.value : 'operations_officer';
					}

					function applyCommandLevelGating(selectedYear, selectedCommandLevel) {
						// Option block gating
						// Default command behavior: HIDE
						// To force "disable" behavior on a specific block, set: data-command-gate="disable"

						document.querySelectorAll('.enable-gating').forEach(el => {
							// If year already hid it, don't touch it
							if (!yearAllows(el, selectedYear)) return;

							const allowedCommandLevels = (el.dataset.commandLevels || '')
								.split(',')
								.map(s => s.trim())
								.filter(Boolean);

							const commandGateMode = (el.dataset.commandGate || 'hide').trim();
							const commandOk = (allowedCommandLevels.length === 0) || allowedCommandLevels.includes(selectedCommandLevel);

							// COMMAND: hide blocks
							if (!commandOk && commandGateMode === 'hide') {
								el.style.display = 'none';
								return;
							}

							el.style.display = '';

							// COMMAND: disable blocks
							if (!commandOk && commandGateMode === 'disable') {
								el.querySelectorAll('select, input, textarea, button').forEach(ctrl => {
									ctrl.disabled = true;
								});
							} else {
								el.querySelectorAll('select, input, textarea, button').forEach(ctrl => {
									ctrl.disabled = false;
								});
							}

							// Marker sync if visible (yearOk only; command gating does not reset markers here)
							const positionSelect = el.querySelector('.task-group-position-select');
							if (positionSelect) {
								const markerKey = positionSelect.getAttribute('data-marker-key');
								if (markerKey) {
									const desired = operationsMarkerPositionState[markerKey] || positionSelect.value;
									if (desired) {
										positionSelect.value = desired;
										setOperationsMarkerPosition(markerKey, desired);
									}
								}
							}
						});

						// Menu Gating

						document.querySelectorAll('.popup-window-container').forEach(menu => {
							// If year-gated, don't do command gating (year already blocks opening)
							if (!yearAllows(menu, selectedYear)) {
								menu.dataset.menuCommandGated = 'false';
								// Still ensure controls are enabled for next time if needed
								setMenuControlsDisabled(menu, false);
								return;
							}

							const allowedCommandLevels = (menu.dataset.commandLevels || '')
								.split(',')
								.map(s => s.trim())
								.filter(Boolean);

							// Command gate mode for MENUS:
							// - default: disable
							// - hide: blocks opening (used for TG 60.1)
							const commandGateMode = (menu.dataset.commandGate || 'disable').trim();
							const commandOk = (allowedCommandLevels.length === 0) || allowedCommandLevels.includes(selectedCommandLevel);

							// COMMAND: hide mode blocks opening
							const menuCommandGated = (!commandOk && commandGateMode === 'hide');
							menu.dataset.menuCommandGated = menuCommandGated ? 'true' : 'false';

							// If command-gated (hide mode) and open, close it
							if (menuCommandGated && menu.style.display === 'flex') {
								menu.style.display = 'none';
							}

							// COMMAND: disable mode disables controls but allows opening
							const shouldDisableControls = (!commandOk && commandGateMode === 'disable');
							setMenuControlsDisabled(menu, shouldDisableControls);

							// Marker reset: ONLY when command-gate is "hide"
							// (Because "hide" implies the player shouldn't be able to set/retain this choice)
							if (!commandOk && commandGateMode === 'hide') {
								const positionSelect = menu.querySelector('select.task-group-position-select[data-marker-key]');
								if (positionSelect) {
									const markerKey = positionSelect.getAttribute('data-marker-key');
									if (markerKey) {
										positionSelect.value = '1';
										delete operationsMarkerPositionState[markerKey];
										resetMarkerToDefaultPosition(markerKey);
									}
								}
							}
						});
					}

					function updateScenarioSetupHiddenFields() {
						const scenarioYearHidden = document.getElementById('scenario_year_hidden');
						const commandLevelHidden = document.getElementById('command_level_hidden');
						const playerSideHidden = document.getElementById('player_side_hidden');

						if (scenarioYearHidden) scenarioYearHidden.value = getSelectedScenarioYear();
						if (commandLevelHidden) commandLevelHidden.value = getSelectedCommandLevel();

						// Side is authoritative from Lua, but keep it mirrored like the others
						if (playerSideHidden) playerSideHidden.value = getSelectedSide();
					}

					function getSelectedSearchAndRescueEnabled() {
						const sel = document.querySelector('select[name="enable_search_and_rescue"]');
						return sel && sel.value === 'enable_search_and_rescue_true';
					}

					function resetMultipleAircraftIfDisabled(side) {
						side = side || 'usa';

						if (getSelectedSearchAndRescueEnabled()) {
							return;
						}

						for (let base = 1; base <= 10; base++) {
							if (!airBases[base]) continue;

							let deployedGroups = getDeployedAircraftCount(base, 'rescuesqn');
							if (deployedGroups <= 0) continue;

							let releasedCapacity = deployedGroups * getMultipleAircraftOccupiedSpace('rescuesqn');
							let componentCounts = getMultipleAircraftComponentCounts('rescuesqn', deployedGroups);

							airBases[base].usedCapacity = Math.max(0, airBases[base].usedCapacity - releasedCapacity);
							airBases[base].deployed.rescuesqn = 0;

							Object.keys(componentCounts).forEach(componentType => {
								let currentCount = airBases[base].deployed[componentType] || 0;
								airBases[base].deployed[componentType] = Math.max(0, currentCount - componentCounts[componentType]);
							});

							let inputElement = document.getElementById(`${side}_air_base_${base}_rescuesqn_input`);
							if (inputElement) {
								inputElement.value = 0;
							}
						}
					}

					function applySearchAndRescueRowGating() {
						// SAR on/off must take precedence over all other gating:
						// - If SAR is OFF => always hide CSAR rows
						// - If SAR is ON  => CSAR rows can appear, but still subject to year/side/command gating
						const enabled = getSelectedSearchAndRescueEnabled();
						document.body.classList.toggle('sar-disabled', !enabled);

						if (!enabled) {
							resetMultipleAircraftIfDisabled('usa');
							updateAircraftCounters('usa');
							updateTotalAircraftCounters();
						}
					}

					function applyGating() {
						updateScenarioSetupHiddenFields();

						const selectedYear = getSelectedScenarioYear();
						const selectedSide = getSelectedSide();
						const selectedCommandLevel = getSelectedCommandLevel();

						// Reset and rebuild all year-dependent deployment state
						applyYearBasedDeploymentConfig(selectedYear);

						// Apply UI gating, the order matters:
						// 1) Year gating establishes what's available
						// 2) Side gating hides within what's year-valid
						// 3) Command gating hides/disables within what's year + side valid
						// 4) Search and Rescue display/hides availabe CSAR forces
						applyYearGating(selectedYear);
						applySideGating(selectedYear, selectedSide);
						applySideGatingToTabButtons(selectedSide);
						applyCommandLevelGating(selectedYear, selectedCommandLevel);
						applySearchAndRescueRowGating();

						if (typeof applyOperationsMarkerGating === 'function') {
							applyOperationsMarkerGating(selectedYear, selectedSide);
						}

						// Keep unit cards in sync
						if (typeof applyUnitCardGating === 'function') {
							applyUnitCardGating();
						}
					}

					// ---------------- //
					// Category Filters //
					// ---------------- //

					// Safe storage wrapper: falls back to no-ops if localStorage isn't available
					const safeStorage = (() => {
						try {
							const t = '__test__';
							window.localStorage.setItem(t, t);
							window.localStorage.removeItem(t);
							return {
							get:  k => window.localStorage.getItem(k),
							set:  (k,v) => window.localStorage.setItem(k, v),
							};
						} catch {
							return { get: () => null, set: () => {} };
						}
					})();

					function setupCategoryFilter({ toolbarId, containerSelector, cardSelector = '.unit-card', categories, rememberKey = null }) {
						const toolbar = document.getElementById(toolbarId);
						const container = document.querySelector(containerSelector);
						if (!toolbar || !container) return;

						// Prevent re-initializing on tab switches
						if (toolbar.dataset.inited === '1') return;
						toolbar.dataset.inited = '1';

						// Build toolbar UI
						toolbar.classList.add('filter-toolbar');
						toolbar.innerHTML = `
						${categories.map(c => `
							<label>
							<input type="checkbox" value="${c.value}">
							${c.label}
							</label>
						`).join('')}
						<button type="button" data-action="all">All</button>
						<button type="button" data-action="none">None</button>
						`;

						const inputs = [...toolbar.querySelectorAll('input[type="checkbox"]')];
						const cards  = [...container.querySelectorAll(cardSelector)];

						// Restore or default all-on
						if (rememberKey) {
							const saved = rememberKey ? safeStorage.get(rememberKey) : null;
							if (saved) {
								const on = new Set(JSON.parse(saved));
								inputs.forEach(i => i.checked = on.has(i.value));
							} else {
								inputs.forEach(i => i.checked = true);
							}
						} else {
							inputs.forEach(i => i.checked = true);
						}

						function apply() {
							const active = inputs.filter(i => i.checked).map(i => i.value.toLowerCase());

							cards.forEach(card => {
								const raw = (card.dataset.categories || '').toLowerCase();
								const cardCats = raw.split(',').map(s => s.trim()).filter(Boolean);
								const match = active.length > 0 && cardCats.some(c => active.includes(c)); // <-- key change
								if (card.classList.contains('is-hidden-gated')) {
									card.classList.add('is-hidden');
								} else {
									card.classList.toggle('is-hidden', !match);
								}
							});

							if (rememberKey) safeStorage.set(rememberKey, JSON.stringify(active));
						}

						window.applyUnitCardCategoryFilter = apply;

						toolbar.addEventListener('change', e => {
							if (e.target.matches('input[type="checkbox"]')) apply();
						});
						toolbar.addEventListener('click', e => {
							if (e.target.matches('button[data-action="all"]'))  { inputs.forEach(i => i.checked = true);  apply(); }
							if (e.target.matches('button[data-action="none"]')) { inputs.forEach(i => i.checked = false); apply(); }
						});

						apply();
					}

					// ---------------------- //
					// Unit Card Setup Gating //
					// ---------------------- //

					function applyUnitCardGating() {
						const selectedYear = getSelectedScenarioYear();
						const selectedCommandLevel = getSelectedCommandLevel();

						applyYearBasedDeploymentConfig(selectedYear);

						function yearAllows(el) {
							const yearListRaw = el.dataset.year || '';
							if (!yearListRaw) return true; // No gating means always available
							const years = yearListRaw.split(',').map(s => s.trim()).filter(Boolean);
							return years.includes(selectedYear);
						}

						function commandAllows(el) {
							const cmdListRaw = el.dataset.commandLevels || '';
							if (!cmdListRaw) return true; // No gating means always available
							const cmds = cmdListRaw.split(',').map(s => s.trim()).filter(Boolean);
							return cmds.includes(selectedCommandLevel);
						}

						document.querySelectorAll('.unit-card').forEach(card => {
							const allow = yearAllows(card) && commandAllows(card);
							card.classList.toggle('is-hidden-gated', !allow);
						});

						if (typeof window.applyUnitCardCategoryFilter === 'function') {
							window.applyUnitCardCategoryFilter();
						}
					}

					function initializeUnitCardGating() {
						const yearSelect = document.querySelector('select[name="scenario_year"]');
						if (yearSelect) {
							yearSelect.addEventListener('change', applyUnitCardGating);
						}

						document.querySelectorAll('input[name="player_command_level"]').forEach(radio => {
							radio.addEventListener('change', applyUnitCardGating);
						});

						applyUnitCardGating();
					}

					// ---------------------------- //
					// Initialize Unit Info Filters //
					// ---------------------------- //

					document.addEventListener('DOMContentLoaded', () => {
						setupCategoryFilter({
							toolbarId: 'unit-card-filters',
							containerSelector: '#unit-cards',
							categories: [
								{ value: 'fighters', label: 'Fighters' },
								{ value: 'bombers', label: 'Bombers' },
								{ value: 'electronic', label: 'Electronic' },
								{ value: 'tankers', label: 'Tankers' },
								{ value: 'cargo', label: 'Cargo' },
								{ value: 'rescue', label: 'Rescue' },
								{ value: 'uav', label: 'UAV' },
								{ value: 'ships', label: 'Ships' },
								{ value: 'submarines', label: 'Submarines' },
								{ value: 'owa', label: 'One-Way Attack Drones' }
							],
						});
					});

					// --------------- //
					// Flip Unit Cards //
					// --------------- //

					function toggleCard(card) {
						let front = card.querySelector(".unit-card-front");
						let back = card.querySelector(".unit-card-back");

						if (front.style.display === "none") {
							front.style.display = "flex";
							back.style.display = "none";
						} else {
							front.style.display = "none";
							back.style.display = "flex";
						}
					}

					// ------------------------------- //
					// Leaflet Operations Map (Base)  //
					// ------------------------------- //

					function updateOperationsLabelVisibility() {
						if (!operationsLeafletMap) return;

						const zoom = operationsLeafletMap.getZoom();

						// Each label controls its own visibility via labelZoom
						operationsAllLabelMarkers.forEach(labelMarker => {
							const el = labelMarker.getElement && labelMarker.getElement();
							if (!el) return;

							const threshold = (typeof labelMarker._labelZoom === 'number')
								? labelMarker._labelZoom
								: LABEL_ZOOM_THRESHOLD;

							el.style.display = (zoom >= threshold) ? '' : 'none';
						});
					}

					let operationsLeafletMap = null;

					function initOperationsLeafletMap() {
						if (operationsLeafletMap) {
							return; // already initialized
						}

						const mapDiv = document.getElementById("leafletOperationsMap");
						if (!mapDiv || typeof L === "undefined") {
							return;
						}

						operationsLeafletMap = L.map("leafletOperationsMap").setView([17.0, 55.0], 4);

						// Add map markers
						addOperationsMarkers(operationsLeafletMap);
						initializeTaskGroupPositionSelectors();

						// Add map layers
						const darkTheme = L.tileLayer("https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png", {
							maxZoom: 19,
							attribution: "© OpenStreetMap © CARTO"
						}).addTo(operationsLeafletMap);

						const openTopoMap = L.tileLayer("https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png", {
							maxZoom: 17,
							attribution: "© OpenTopoMap"
						});

						const esriWorldTopo = L.tileLayer("https://{s}.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}", {
							attribution: "Tiles © Esri",
							subdomains: ["server", "services"]
						});

						const esriSatellite = L.tileLayer("https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}", {
							maxZoom: 21,
							attribution: "Tiles © Esri"
						});

						const baseMaps = {
							"Dark Theme": darkTheme,
							"OpenTopoMap": openTopoMap,
							"World Topo": esriWorldTopo,
							"Satellite": esriSatellite
						};

						L.control.layers(baseMaps).addTo(operationsLeafletMap);

						// Zoom-based label visibility
						operationsLeafletMap.on("zoomend", updateOperationsLabelVisibility);
						updateOperationsLabelVisibility();
					}

					// =========================
					// Marker sizing from CSS
					// =========================

					function getCssScale(varName, defaultValue) {
						const styles = getComputedStyle(document.documentElement);
						const value = parseFloat(styles.getPropertyValue(varName));
						return isNaN(value) ? defaultValue : value;
					}

					const labelScale = getCssScale('--marker-label-scale', 1);

					const BASE_AIRBASE_ICON_SIZE = 24;
					const BASE_FACILITY_ICON_SIZE = 24;
					const BASE_NAVAL_ICON_SIZE = 24;

					const BASE_LABEL_WIDTH = 200;
					const BASE_LABEL_HEIGHT_1 = 20;
					const BASE_LABEL_HEIGHT_2 = 40;

					const LABEL_ZOOM_THRESHOLD = 6;

					const airbaseScale = getCssScale('--airbase-marker-scale', 1);
					const facilityScale = getCssScale('--marker-scale', 1);
					const navalScale = getCssScale('--naval-marker-scale', 1);

					// =========================
					// Operations Markers
					// =========================

					const blueAirbaseIcon = L.icon({
						iconUrl: 'https://i.imgur.com/JI8hR76.png',
						iconSize: [
							BASE_AIRBASE_ICON_SIZE * airbaseScale,
							BASE_AIRBASE_ICON_SIZE * airbaseScale
						],
						iconAnchor: [
							(BASE_AIRBASE_ICON_SIZE * airbaseScale) / 2,
							(BASE_AIRBASE_ICON_SIZE * airbaseScale) / 2
						],
						className: 'airbase-marker'
					});

					const blueNavalIcon = L.icon({
						iconUrl: 'https://i.imgur.com/DW6fIpL.png',
						iconSize: [
							BASE_NAVAL_ICON_SIZE * navalScale,
							BASE_NAVAL_ICON_SIZE * navalScale
						],
						iconAnchor: [
							(BASE_NAVAL_ICON_SIZE * navalScale) / 2,
							(BASE_NAVAL_ICON_SIZE * navalScale) / 2
						],
						className: 'naval-marker'
					});

					const blueFacilityIcon = L.icon({
						iconUrl: 'https://i.imgur.com/v2lp6j9.png',
						iconSize: [
							BASE_NAVAL_ICON_SIZE * navalScale,
							BASE_NAVAL_ICON_SIZE * navalScale
						],
						iconAnchor: [
							(BASE_NAVAL_ICON_SIZE * navalScale) / 2,
							(BASE_NAVAL_ICON_SIZE * navalScale) / 2
						],
						className: 'naval-marker'
					});

					const redFacilityIcon = L.icon({
						iconUrl: 'https://i.imgur.com/fJruYJC.png',
						iconSize: [
							BASE_FACILITY_ICON_SIZE * facilityScale,
							BASE_FACILITY_ICON_SIZE * facilityScale
						],
						iconAnchor: [
							(BASE_FACILITY_ICON_SIZE * facilityScale) / 2,
							(BASE_FACILITY_ICON_SIZE * facilityScale) / 2
						],
						className: 'facility-marker'
					});

					const markerIcons = {
						Blue: {
							Airbase: blueAirbaseIcon,
							Naval: blueNavalIcon,
							Facility: blueFacilityIcon
						},
						Red: {
							// Airbase: redAirbaseIcon,
							// Naval: redNavalIcon,
							Facility: redFacilityIcon
						}
					};

					// Blue Map Markers
					const blueMarkers = [
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Prince Sultan AB',
							country: 'saudi_arabia',
							menuId: 'usa_air_base_1_menu',
							lat: 24.063351902608,
							lng: 47.580664139576,
							labelHtml: 'Prince Sultan AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Al Udeid AB',
							country: 'qatar',
							menuId: 'usa_air_base_2_menu',
							lat: 25.119130532031,
							lng: 51.314319142992,
							labelHtml: 'Al Udeid AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Al Dhafra AB',
							country: 'united_arab_emirates',
							menuId: 'usa_air_base_3_menu',
							lat: 24.24900543992,
							lng: 54.546681229128,
							labelHtml: 'Al Dhafra AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Diego Garcia',
							menuId: 'usa_air_base_4_menu',
							lat: -7.313392313432,
							lng: 72.411255471434,
							labelHtml: 'Diego Garcia',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Ali Al Salem AB',
							country: 'kuwait',
							menuId: 'usa_air_base_5_menu',
							lat: 29.34678477555,
							lng: 47.520697107668,
							labelHtml: 'Ali Al Salem AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Muwaffaq Salti AB',
							country: 'jordan',
							year: 'mid2020, late2020',
							menuId: 'usa_air_base_6_menu',
							lat: 31.83355895566,
							lng: 36.783437900513,
							labelHtml: 'Muwaffaq Salti AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Ben Gurion Airport',
							menuId: 'usa_air_base_7_menu',
							lat: 32.015667,
							lng: 34.879200,
							labelHtml: 'Ben Gurion<br>Airport',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Ovda AB',
							menuId: 'usa_air_base_8_menu',
							lat: 29.9390948816713,
							lng: 34.935193970593,
							labelHtml: 'Ovda AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Off Map Bases (Western Europe and CONUS)',
							menuId: 'usa_air_base_9_menu',
							lat: 37.1748750,
							lng: -5.6160194,
							labelHtml: 'Off Map Bases<br>(Western Europe<br>and CONUS)',
							lines: 3,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Airbase',
							name: 'Off Map Bases (Northern Europe)',
							menuId: 'usa_air_base_10_menu',
							lat: 46.0310889,
							lng: 12.5964806,
							labelHtml: 'Off Map Bases<br>(Northern Europe)',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'usa, usa-israel',
							markerType: 'Naval',
							name: 'US Naval Task Force',
							menuId: 'usa_naval_deployment_area_1_menu',
							lat: 22.047298378685,
							lng: 63.949255501948,
							labelHtml: 'US Naval Task Force',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Ramat David AB',
							menuId: 'israel_air_base_1_menu',
							lat: 32.666717706051,
							lng: 35.183896699612,
							labelHtml: 'Ramat David AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Palmachim AB',
							year: 'early2020',
							menuId: 'israel_air_base_2_menu',
							lat: 31.901951958935,
							lng: 34.692966332895,
							labelHtml: 'Palmachim AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Tel Nof AB',
							menuId: 'israel_air_base_3_menu',
							lat: 31.837759632281,
							lng: 34.82685876794,
							labelHtml: 'Tel Nof AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Hatzerim AB',
							menuId: 'israel_air_base_4_menu',
							lat: 31.228431114214,
							lng: 34.665895095402,
							labelHtml: 'Hatzerim AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Nevatim AB',
							menuId: 'israel_air_base_5_menu',
							lat: 31.207935910511,
							lng: 35.010089416984,
							labelHtml: 'Nevatim AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Ramon AB',
							menuId: 'israel_air_base_6_menu',
							lat: 30.774539483725,
							lng: 34.667370063936,
							labelHtml: 'Ramon AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Airbase',
							name: 'Hatzor AB',
							menuId: 'israel_air_base_7_menu',
							lat: 31.762228073423,
							lng: 34.728230978347,
							labelHtml: 'Hatzor AB',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
						{
							side: 'israel, usa-israel',
							markerType: 'Facility',
							name: 'Sdot Micha',
							menuId: 'israel_base_1_menu',
							lat: 31.744829093527,
							lng: 34.92407001124,
							labelHtml: 'Sdot Micha',
							lines: 1,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 9
						},
					];

					// Red Map Markers
					const redMarkers = [
						{
							markerType: 'Facility',
							name: 'Arak Heavy Water Production Plant',
							menuId: 'iran_facility_1_menu',
							lat: 34.371170887378,
							lng: 49.245668318533,
							labelHtml: 'Arak Heavy Water<br>Production Plant',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							markerType: 'Facility',
							name: 'Esfahãn Uranium Conversion Facility',
							menuId: 'iran_facility_2_menu',
							lat: 32.575264558019,
							lng: 51.827000629228,
							labelHtml: 'Esfahãn Uranium<br>Conversion Facility',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							markerType: 'Facility',
							name: 'Fordow Fuel Enrichment Plant',
							menuId: 'iran_facility_3_menu',
							lat: 34.883536281834,
							lng: 50.99976994326,
							labelHtml: 'Fordow Fuel<br>Enrichment Plant',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							markerType: 'Facility',
							name: 'Natanz Fuel Enrichment Plant',
							year: 'early2020, mid2020',
							menuId: 'iran_facility_4_menu',
							lat: 33.724532187706,
							lng: 51.726234823496,
							labelHtml: 'Natanz Fuel<br>Enrichment Plant',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
						{
							markerType: 'Facility',
							name: 'Natanz Fuel Enrichment Plant',
							year: 'late2020',
							menuId: 'iran_facility_5_menu',
							lat: 33.7047996890971,
							lng: 51.7122118042208,
							labelHtml: 'Natanz Fuel<br>Enrichment Plant',
							lines: 2,
							labelOffsetX: 100,
							labelOffsetY: -12,
							labelZoom: 7
						},
					];

					const operationsMarkerRegistry = {};
					const operationsLabelRegistry = {};
					const operationsMarkerDefinitionRegistry = {};
					const operationsMarkerPositionState = {};
					const operationsAllLabelMarkers = [];
					const operationsMarkerLayers = [];

					function markerSideAllows(sideListRaw, selectedSide) {
						// No sides field = always visible (optional; you can make this false if you want strict-everywhere)
						if (!sideListRaw) return true;

						const allowed = String(sideListRaw)
							.split(',')
							.map(s => s.trim())
							.filter(Boolean);

						if (allowed.length === 0) return true;

						// STRICT: exact match only
						return allowed.includes(selectedSide);
					}

					// ---------------------------------- //
					// Enforce Basing Rights / Access (JS) //
					// ---------------------------------- //

					// Note: UI for this will be added later. All functions below are defensive:
					// if the dropdown/checkboxes don't exist yet, they safely no-op and default to "all allowed".

					const BASING_ELIGIBLE_SIDES = new Set(['usa', 'usa-israel']);

					// Per-year country access chances (0-100). Keys should be normalized (see normalizeCountryKey()).
					// If a country key is missing, it defaults to 100 (always allowed).
					let basingRightsChances = {
						early2020: {
							saudi_arabia: { realistic: 65 },
							qatar: { realistic: 60 },
							united_arab_emirates: { realistic: 75 },
							kuwait: { realistic: 70 }
						},
						mid2020: {
							saudi_arabia: { realistic: 65 },
							qatar: { realistic: 60 },
							united_arab_emirates: { realistic: 75 },
							kuwait: { realistic: 70 },
							jordan: { realistic: 75 }
						},
						late2020: {
							saudi_arabia: { realistic: 80 },
							qatar: { realistic: 65 },
							united_arab_emirates: { realistic: 85 },
							kuwait: { realistic: 80 },
							jordan: { realistic: 85 }
						}
					};

					const basingAccessState = {
						enforceOn: false,
						manualInit: false,
						lastRollSignature: null,
						countryAccess: Object.create(null)
					};

					function normalizeCountryKey(countryRaw) {
						if (!countryRaw) return '';
						return String(countryRaw)
							.trim()
							.toLowerCase()
							.replace(/&/g, 'and')
							.replace(/[\.\,\'\"\(\)\[\]]/g, '')
							.replace(/\s+/g, '_');
					}

					function getSelectedScenarioEventChances() {
						const checked = document.querySelector('input[name="scenario_event_chances"]:checked');
						return checked ? checked.value : 'realistic';
					}

					function getSelectedEnforceBasingRightsAccessEnabled() {
						// Will be added in HTML later. Expected values:
						// - 'enable_basing_rights_true'  (enforced ON)
						// - 'enable_basing_rights_false' (enforced OFF)
						const sel = document.querySelector('select[name="enable_basing_rights_access"]');
						if (!sel) return false;
						return sel.value === 'enable_basing_rights_true';
					}

					function setBasingRightsCheckboxesDisabled(disabled) {
						// Only bases with a country field will have checkboxes (per design).
						const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country]');
						boxes.forEach(cb => {
							cb.disabled = !!disabled;
							const label = cb.closest('label.setup-options-radio');
							if (label) {
								label.classList.toggle('disabled', !!disabled);
							}
						});
					}

					function checkAllBasingRightsCheckboxes() {
						// Per design: when Enforce is OFF, default to all checked.
						const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country]');
						boxes.forEach(cb => {
							cb.checked = true;
						});
					}

					function getManualBasingRightsSelectionMap() {
						// Returns a map of baseId -> true/false for the manual filter mode.
						// baseId is expected to match marker.def.menuId (recommended) or marker.def.markerKey.
						const out = Object.create(null);

						const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country][data-basing-base-id]');
						if (boxes.length === 0) return out;

						boxes.forEach(cb => {
							const baseId = cb.getAttribute('data-basing-base-id');
							if (!baseId) return;
							out[baseId] = !!cb.checked;
						});

						return out;
					}

					function rollCountryAccessChance(selectedYear, countryKey, eventChanceMode) {
						// Returns true if basing is granted for the countryKey
						if (!countryKey) return true;

						if (eventChanceMode === 'remove_random') return true;

						let chance = 100;

						if (eventChanceMode === 'random') {
							// Chance itself is randomized 0-100
							chance = Math.floor(Math.random() * 101);
						} else {
							// Realistic: use table per year
							const yearTable = basingRightsChances[selectedYear] || {};
							const entry = yearTable[countryKey] || {};
							if (typeof entry.realistic === 'number') chance = entry.realistic;
						}

						// 1..100 roll vs chance
						const roll = Math.floor(Math.random() * 100) + 1;
						return roll <= chance;
					}

					function rebuildBasingAccessStateIfNeeded(selectedYear, selectedSide) {
						// Only applies for eligible sides and only when Enforce is ON.
						if (!BASING_ELIGIBLE_SIDES.has(selectedSide)) {
							// If side isn't eligible, treat as fully allowed and leave UI alone.
							basingAccessState.enforceOn = false;
							basingAccessState.lastRollSignature = null;
							basingAccessState.countryAccess = Object.create(null);

							// If manual basing selection changed, reset all player deployments so nothing remains deployed to a now-denied base.
							const currentAllowedMap = getManualBasingRightsSelectionMap();
							if (!basingAccessState.lastAllowedMap) {
								basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
							} else if (!shallowEqualObject(basingAccessState.lastAllowedMap, currentAllowedMap)) {
								basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
								resetAllPlayerDeployments();

								// Refresh all counters/summaries after reset
								if (typeof updateAircraftCounters === 'function') updateAircraftCounters();
								if (typeof updateTotalAircraftCounters === 'function') updateTotalAircraftCounters();
								if (typeof updateAircraftSummaryCounters === 'function') updateAircraftSummaryCounters();
								if (typeof updateShipCounters === 'function') updateShipCounters();
								if (typeof updateTotalShipCounters === 'function') updateTotalShipCounters();
							} else {
								basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
							}

							return;
						}
						const prevEnforceOn = basingAccessState.enforceOn;

						const enforceOn = getSelectedEnforceBasingRightsAccessEnabled();
						basingAccessState.enforceOn = enforceOn;

						if (!enforceOn) {
							// Manual mode:
							// - When turning Enforce OFF, default to all checked (most players want everything available)
							// - After that, DO NOT auto-recheck on every rerender; allow manual filtering to persist
							setBasingRightsCheckboxesDisabled(false);

							if (prevEnforceOn || !basingAccessState.manualInit) {
								checkAllBasingRightsCheckboxes();
								basingAccessState.manualInit = true;
							}

							// Manual mode: reflect current checkbox state into forward-deployed aircraft + export inputs
							if (typeof applyBasingAccessToForwardDeployedAircraft === 'function') {
								applyBasingAccessToForwardDeployedAircraft(selectedYear, selectedSide);
							}

							basingAccessState.lastRollSignature = null;
							basingAccessState.countryAccess = Object.create(null);

							// If manual basing selection changed, reset all player deployments so nothing remains deployed to a now-denied base.
							const currentAllowedMap = getManualBasingRightsSelectionMap();
							if (!basingAccessState.lastAllowedMap) {
								basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
							} else if (!shallowEqualObject(basingAccessState.lastAllowedMap, currentAllowedMap)) {
								basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
								resetAllPlayerDeployments();

								// Refresh all counters/summaries after reset
								if (typeof updateAircraftCounters === 'function') updateAircraftCounters();
								if (typeof updateTotalAircraftCounters === 'function') updateTotalAircraftCounters();
								if (typeof updateAircraftSummaryCounters === 'function') updateAircraftSummaryCounters();
								if (typeof updateShipCounters === 'function') updateShipCounters();
								if (typeof updateTotalShipCounters === 'function') updateTotalShipCounters();
							} else {
								basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
							}

							return;
						}

						// Enforced mode: lock checkboxes and compute access
						setBasingRightsCheckboxesDisabled(true);

						const mode = getSelectedScenarioEventChances();
						const sig = `${selectedYear}|${mode}`;

						if (basingAccessState.lastRollSignature === sig) return;
						basingAccessState.lastRollSignature = sig;

						// Compute countryAccess based on markers currently registered (so you don't maintain a separate country list)
						const countryAccess = Object.create(null);

						if (operationsMarkerLayers && operationsMarkerLayers.length > 0) {
							operationsMarkerLayers.forEach(entry => {
								// Only gate airbases that define a country
								if (entry.markerType !== 'Airbase') return;
								if (!entry.countryKey) return;

								// Roll once per country
								if (countryAccess[entry.countryKey] === undefined) {
									countryAccess[entry.countryKey] = rollCountryAccessChance(selectedYear, entry.countryKey, mode);
								}
							});
						} else {
							// Ops map not initialized yet: derive the country list from the basing checkboxes so rolls still occur immediately.
							const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country][data-basing-base-id]');
							boxes.forEach(cb => {
								const countryKey = normalizeCountryKey(cb.getAttribute('data-basing-country'));
								if (!countryKey) return;
								if (countryAccess[countryKey] === undefined) {
									countryAccess[countryKey] = rollCountryAccessChance(selectedYear, countryKey, mode);
								}
							});
						}

						basingAccessState.countryAccess = countryAccess;

						// Reflect computed results back into checkboxes (if/when they exist)
						const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country][data-basing-base-id]');
						boxes.forEach(cb => {
							const countryKey = normalizeCountryKey(cb.getAttribute('data-basing-country'));
							if (!countryKey) return;
							cb.checked = (countryAccess[countryKey] !== false);
						});
						// Apply basing access changes to forward-deployed aircraft + export inputs
						if (typeof applyBasingAccessToForwardDeployedAircraft === 'function') {
							applyBasingAccessToForwardDeployedAircraft(selectedYear, selectedSide);
						}

						// If basing access (checkbox state) changed, reset all player deployments.
						// This prevents aircraft remaining deployed at bases that are no longer available.
						const currentAllowedMap = getManualBasingRightsSelectionMap();
						if (!basingAccessState.lastAllowedMap) {
							basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
						} else if (!shallowEqualObject(basingAccessState.lastAllowedMap, currentAllowedMap)) {
							basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
							resetAllPlayerDeployments();

							// Refresh all counters/summaries after reset
							if (typeof updateAircraftCounters === 'function') updateAircraftCounters();
							if (typeof updateTotalAircraftCounters === 'function') updateTotalAircraftCounters();
							if (typeof updateAircraftSummaryCounters === 'function') updateAircraftSummaryCounters();
							if (typeof updateShipCounters === 'function') updateShipCounters();
							if (typeof updateTotalShipCounters === 'function') updateTotalShipCounters();
						} else {
							basingAccessState.lastAllowedMap = Object.assign({}, currentAllowedMap);
						}
					}

					function markerBasingAllows(entry, selectedYear, selectedSide) {
						// Non-eligible sides: basing system does not apply
						if (!BASING_ELIGIBLE_SIDES.has(selectedSide)) return true;

						// Only applies to Airbase markers with a country
						if (entry.markerType !== 'Airbase') return true;
						if (!entry.countryKey) return true;

						// Enforced mode uses countryAccess
						if (basingAccessState.enforceOn) {
							return (basingAccessState.countryAccess[entry.countryKey] !== false);
						}

						// Manual mode uses checkbox selection map (default allow if no checkbox wiring yet)
						const manual = getManualBasingRightsSelectionMap();
						if (!entry.baseId) return true;
						if (manual[entry.baseId] === undefined) return true;
						return manual[entry.baseId] === true;
					}

					function getBasingAllowedForBaseMenuId(baseMenuId) {
						// Bases without a checkbox (no country field) are always allowed.
						if (!baseMenuId) return true;
						const cb = document.querySelector(`input[type="checkbox"][data-basing-base-id="${baseMenuId}"]`);
						if (!cb) return true;
						return !!cb.checked;
					}

					function ensureBasingAllowedHiddenInputs() {
						// Creates hidden inputs (one per basing checkbox) so Lua can read base rights as individual values.
						const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country][data-basing-base-id]');
						boxes.forEach(cb => {
							const baseMenuId = cb.getAttribute('data-basing-base-id');
							if (!baseMenuId) return;

							const m = baseMenuId.match(/usa_air_base_(\d+)_menu/i);
							if (!m) return;

							const baseNum = m[1];
							const id = `usa_air_base_${baseNum}_basing_allowed_input`;

							let hidden = document.getElementById(id);
							const nameKey = `usa_air_base_${baseNum}_basing_allowed`;

							if (hidden) {
								hidden.name = nameKey;
							}

							if (!hidden) {
								hidden = document.createElement('input');
								hidden.type = 'hidden';
								hidden.id = id;
								hidden.name = nameKey;
								cb.insertAdjacentElement('afterend', hidden);
							}
						});
					}

					function updateBasingAllowedHiddenInputs() {
						ensureBasingAllowedHiddenInputs();

						const boxes = document.querySelectorAll('input[type="checkbox"][data-basing-country][data-basing-base-id]');
						boxes.forEach(cb => {
							const baseMenuId = cb.getAttribute('data-basing-base-id');
							if (!baseMenuId) return;

							const m = baseMenuId.match(/usa_air_base_(\d+)_menu/i);
							if (!m) return;

							const baseNum = m[1];
							const id = `usa_air_base_${baseNum}_basing_allowed_input`;
							const hidden = document.getElementById(id);
							if (!hidden) return;

							hidden.value = cb.checked ? 'true' : 'false';
						});
					}

					
					function updateBasingSummaryTablesVisibility() {
						const udeid = document.getElementById('summary_usa_air_base_2');
						const dhafra = document.getElementById('summary_usa_air_base_3');
						if (!udeid && !dhafra) return;

						const selectedSide = (typeof getSelectedSide === 'function') ? getSelectedSide() : '';
						// If basing system is not applicable, keep these visible.
						if (!BASING_ELIGIBLE_SIDES || !BASING_ELIGIBLE_SIDES.has || !BASING_ELIGIBLE_SIDES.has(selectedSide)) {
							if (udeid) udeid.style.display = '';
							if (dhafra) dhafra.style.display = '';
							return;
						}

						const allowUdeid = getBasingAllowedForBaseMenuId('usa_air_base_2_menu');
						const allowDhafra = getBasingAllowedForBaseMenuId('usa_air_base_3_menu');

						if (udeid) udeid.style.display = allowUdeid ? '' : 'none';
						if (dhafra) dhafra.style.display = allowDhafra ? '' : 'none';
					}

					function applyBasingAccessToForwardDeployedAircraft(selectedYear, selectedSide) {
						// Only applies for eligible sides; other sides always keep forward-deployed baseline as-is.
						if (!BASING_ELIGIBLE_SIDES.has(selectedSide)) {
							forwardDeployedAircraft = JSON.parse(JSON.stringify(forwardDeployedAircraftBaseline || {}));
							updateBasingSummaryTablesVisibility();
							return;
						}

						// Rebuild from baseline each time so toggling basing back ON restores counts correctly.
						forwardDeployedAircraft = JSON.parse(JSON.stringify(forwardDeployedAircraftBaseline || {}));

						// If the base is not allowed, zero out its forward-deployed counts (affects summary tables only).
						const deniedUdeid = !getBasingAllowedForBaseMenuId('usa_air_base_2_menu'); // Al Udeid
						const deniedDhafra = !getBasingAllowedForBaseMenuId('usa_air_base_3_menu'); // Al Dhafra

						if (deniedUdeid && forwardDeployedAircraft[2]) forwardDeployedAircraft[2] = {};
						if (deniedDhafra && forwardDeployedAircraft[3]) forwardDeployedAircraft[3] = {};

						// Refresh summary counters that include forward-deployed aircraft
						if (typeof updateAircraftSummaryCounters === 'function') {
							updateAircraftSummaryCounters(getSelectedSide());
						}

						updateBasingAllowedHiddenInputs();

						updateBasingSummaryTablesVisibility();
					}

					function applyOperationsMarkerGating(selectedYear, selectedSide) {
						// Update basing access state (rerolls only when Enforce is ON and year/event-chances changed)
						if (typeof rebuildBasingAccessStateIfNeeded === 'function') {
							rebuildBasingAccessStateIfNeeded(selectedYear, selectedSide);
						}

						if (!operationsLeafletMap) return;

						operationsMarkerLayers.forEach(entry => {
							const yearOk = markerYearAllows(entry.yearListRaw, selectedYear);
							const sideOk = markerSideAllows(entry.sideListRaw, selectedSide);
							const basingOk = (typeof markerBasingAllows === 'function') ? markerBasingAllows(entry, selectedYear, selectedSide) : true;

							const allow = sideOk && yearOk && basingOk;

							const markerOnMap = operationsLeafletMap.hasLayer(entry.marker);
							const labelOnMap = operationsLeafletMap.hasLayer(entry.labelMarker);

							if (allow) {
								if (!markerOnMap) entry.marker.addTo(operationsLeafletMap);
								if (!labelOnMap) entry.labelMarker.addTo(operationsLeafletMap);
							} else {
								if (markerOnMap) operationsLeafletMap.removeLayer(entry.marker);
								if (labelOnMap) operationsLeafletMap.removeLayer(entry.labelMarker);
							}
						});

						// Ensure label zoom rules apply after marker gating toggles visibility.
						// Some label DOM nodes don't exist until the next tick.
						if (typeof updateOperationsLabelVisibility === 'function') {
							setTimeout(updateOperationsLabelVisibility, 0);
						}
					}

					function addOperationsMarkers(map) {
						// Clear any previous marker layer references (in case of re-init)
						operationsMarkerLayers.length = 0;
						operationsAllLabelMarkers.length = 0;

						function getMarkerLatLng(m) {
							if (m.positions && m.positions[1] && typeof m.positions[1].lat === 'number' && typeof m.positions[1].lng === 'number') {
								return [m.positions[1].lat, m.positions[1].lng];
							}
							if (typeof m.lat === 'number' && typeof m.lng === 'number') {
								return [m.lat, m.lng];
							}
							return null;
						}

						function addMarkerList(markers, sideName) {
							markers.forEach(m => {
								const markerLatLng = getMarkerLatLng(m);
								if (!markerLatLng) return;

								const markerType = m.markerType || (sideName === 'Red' ? 'Facility' : 'Airbase');
								const icon = (markerIcons[sideName] && markerIcons[sideName][markerType]) ? markerIcons[sideName][markerType] : null;

								// Create marker (do not automatically add; side gating may hide it)
								const marker = L.marker(markerLatLng, { icon: icon });

								if (m.menuId) {
									marker.on('click', function () {
										openPopupWindow(m.menuId);
									});
								}

								// Label marker
								const labelWidth = BASE_LABEL_WIDTH * labelScale;
								const lines = m.lines || 1;
								const baseHeight = (lines === 2 ? BASE_LABEL_HEIGHT_2 : BASE_LABEL_HEIGHT_1);
								const labelHeight = baseHeight * labelScale;

								const offsetX = (typeof m.labelOffsetX === 'number') ? m.labelOffsetX : 0;
								const offsetY = (typeof m.labelOffsetY === 'number') ? m.labelOffsetY : 0;

								const labelClass = (sideName === 'Red') ? 'red-marker-label' : 'marker-label';

								const labelIcon = L.divIcon({
									className: labelClass,
									html: `<div>${m.labelHtml}</div>`,
									iconSize: [labelWidth, labelHeight],
									iconAnchor: [offsetX * labelScale, offsetY],
									interactive: false
								});

								const labelMarker = L.marker(markerLatLng, {
									icon: labelIcon,
									interactive: false
								});

								// Per-marker zoom gate for labels (defaults to LABEL_ZOOM_THRESHOLD if not set)
								labelMarker._labelZoom = (typeof m.labelZoom === 'number') ? m.labelZoom : LABEL_ZOOM_THRESHOLD;
								operationsAllLabelMarkers.push(labelMarker);

								// Register repositionable markers
								if (m.markerKey) {
									operationsMarkerRegistry[m.markerKey] = marker;
									operationsLabelRegistry[m.markerKey] = labelMarker;
									operationsMarkerDefinitionRegistry[m.markerKey] = m;
								}

								// Store for side show/hide control
								operationsMarkerLayers.push({
									def: m,
									marker,
									labelMarker,
									markerLatLng,
									markerType: markerType,
									countryKey: normalizeCountryKey(m.country),
									baseId: m.menuId || m.markerKey || '',
									sideListRaw: m.side || '',
									yearListRaw: m.year || ''
								});
							});
						}

						addMarkerList(blueMarkers, 'Blue');
						addMarkerList(redMarkers, 'Red');

						// Apply initial side visibility after everything is created
						applyOperationsMarkerGating(getSelectedScenarioYear(), getSelectedSide());

						if (typeof applyBasingAccessToForwardDeployedAircraft === 'function') {
							applyBasingAccessToForwardDeployedAircraft(getSelectedScenarioYear(), getSelectedSide());
						}
					}

					function setOperationsMarkerPosition(markerKey, positionValue) {
						if (!operationsLeafletMap) return;

						const def = operationsMarkerDefinitionRegistry[markerKey];
						if (!def || !def.positions) return;

						const pos = def.positions[positionValue];
						if (!pos || typeof pos.lat !== 'number' || typeof pos.lng !== 'number') return;

						operationsMarkerPositionState[markerKey] = String(positionValue);

						const marker = operationsMarkerRegistry[markerKey];
						if (marker) {
							marker.setLatLng([pos.lat, pos.lng]);
						}

						const labelMarker = operationsLabelRegistry[markerKey];
						if (labelMarker) {
							labelMarker.setLatLng([pos.lat, pos.lng]);
						}
					}

					function resetMarkerToDefaultPosition(markerKey) {
						const def = operationsMarkerDefinitionRegistry[markerKey];
						if (!def || !def.positions || !def.positions[1]) return;

						const pos = def.positions[1];

						const marker = operationsMarkerRegistry[markerKey];
						if (marker) {
							marker.setLatLng([pos.lat, pos.lng]);
						}

						const labelMarker = operationsLabelRegistry[markerKey];
						if (labelMarker) {
							labelMarker.setLatLng([pos.lat, pos.lng]);
						}
					}

					function initializeTaskGroupPositionSelectors() {
						// Hook all selectors that are meant to move markers
						document.querySelectorAll('select.task-group-position-select[data-marker-key]').forEach(select => {
							const markerKey = select.getAttribute('data-marker-key');
							if (!markerKey) return;

							// Apply current/default selection on init
							setOperationsMarkerPosition(markerKey, select.value);

							select.addEventListener('change', () => {
								setOperationsMarkerPosition(markerKey, select.value);
							});
						});
					}

					// -------------------- //
					// Toggle Popup Windows //
					// -------------------- //

					function openPopupWindow(menuId) {
						const el = document.getElementById(menuId);
						if (!el) return;

						// Year-gated menus should not open
						if (el.dataset.menuGated === 'true') return;

						// Side-gated menus should not open
						if (el.dataset.menuSideGated === 'true') return;

						// Command-gated menus (hide-mode) should not open
						if (el.dataset.menuCommandGated === 'true') return;

						el.style.display = 'flex';
					}

					function closePopupWindow(menuId) {
						document.getElementById(menuId).style.display = 'none';
					}

					// ---------------------------- //
					// Year-Based Deployment Config //
					// ---------------------------- //

					function resetAllPlayerDeployments() {
						// Reset all player-driven deployments back to 0
						Object.keys(airBases).forEach(base => {
							['fighters', 'hale', 'owa'].forEach(cat => {
								if (!airBases[base][cat]) return;
								Object.keys(airBases[base][cat]).forEach(key => {
									if (key === 'aircraft' || key === 'max') return;
									airBases[base][cat][key] = 0;
								});
								airBases[base][cat].aircraft = 0;
							});
						});
					}

					function shallowEqualObject(a, b) {
						if (a === b) return true;
						if (!a || !b) return false;
						const aKeys = Object.keys(a);
						const bKeys = Object.keys(b);
						if (aKeys.length !== bKeys.length) return false;
						for (const k of aKeys) {
							if (a[k] !== b[k]) return false;
						}
						return true;
					}

					let lastScenarioYearApplied = null;

					function applyYearBasedDeploymentConfig(selectedYear) {
						// Only reset/apply when the year actually changes
						if (lastScenarioYearApplied === selectedYear) return;
						lastScenarioYearApplied = selectedYear;

						resetAllPlayerDeployments();

						// Apply year-based aircraft type limits (this replaces aircraftTypes for the selected year)
						setAircraftTypesForYear(selectedYear);

						// Apply year-based predeployed (forward deployed) aircraft baseline
						forwardDeployedAircraftBaseline = JSON.parse(JSON.stringify(forwardDeployedAircraftByYear[selectedYear] || {}));

						// Working copy that can be zeroed out by basing access
						forwardDeployedAircraft = JSON.parse(JSON.stringify(forwardDeployedAircraftBaseline));

						// Apply basing access to forward-deployed counts immediately
						if (typeof applyBasingAccessToForwardDeployedAircraft === 'function') {
							applyBasingAccessToForwardDeployedAircraft(selectedYear, getSelectedSide());
						}

						// Refresh all counters/summaries after reset + baseline apply
						if (typeof updateAircraftCounters === 'function') updateAircraftCounters();
						if (typeof updateTotalAircraftCounters === 'function') updateTotalAircraftCounters();
						if (typeof updateAircraftSummaryCounters === 'function') updateAircraftSummaryCounters();
						if (typeof updateShipCounters === 'function') updateShipCounters();
						if (typeof updateTotalShipCounters === 'function') updateTotalShipCounters();
					}

					function applyBasingRightsDeploymentReset() {
						const selectedYear = getSelectedScenarioYear();

						resetAllPlayerDeployments();
						setAircraftTypesForYear(selectedYear);

						forwardDeployedAircraftBaseline = JSON.parse(JSON.stringify(forwardDeployedAircraftByYear[selectedYear] || {}));
						forwardDeployedAircraft = JSON.parse(JSON.stringify(forwardDeployedAircraftBaseline));

						if (typeof applyBasingAccessToForwardDeployedAircraft === 'function') {
							applyBasingAccessToForwardDeployedAircraft(selectedYear, getSelectedSide());
						}

						if (typeof resetMultipleAircraftIfDisabled === 'function') {
							resetMultipleAircraftIfDisabled('usa');
						}

						if (typeof updateAircraftCounters === 'function') updateAircraftCounters('usa');
						if (typeof updateTotalAircraftCounters === 'function') updateTotalAircraftCounters();
						if (typeof updateShipCounters === 'function') updateShipCounters();
						if (typeof updateTotalShipCounters === 'function') updateTotalShipCounters();
					}

					function initializeOptionsGating() {
						const yearSelect = document.querySelector('select[name="scenario_year"]');
						if (yearSelect) {
							yearSelect.addEventListener('change', applyGating);
						}

						document.querySelectorAll('input[name="player_command_level"]').forEach(radio => {
							radio.addEventListener('change', applyGating);
						});

						const sarSelect = document.querySelector('select[name="enable_search_and_rescue"]');
						if (sarSelect) {
							sarSelect.addEventListener('change', applyGating);
						}

						// Event chances affects basing access ONLY when Enforce Basing Rights is ON
						document.querySelectorAll('input[name="scenario_event_chances"]').forEach(radio => {
							radio.addEventListener('change', () => {
								if (typeof getSelectedEnforceBasingRightsAccessEnabled === 'function' && getSelectedEnforceBasingRightsAccessEnabled()) {
									applyBasingRightsDeploymentReset();

									if (typeof applyOperationsMarkerGating === 'function') {
										applyOperationsMarkerGating(getSelectedScenarioYear(), getSelectedSide());
									}
								}
							});
						});

						// Enforce basing selector
						const basingSelect = document.querySelector('select[name="enable_basing_rights_access"]');
						if (basingSelect) {
							basingSelect.addEventListener('change', () => {
								applyBasingRightsDeploymentReset();

								if (typeof applyOperationsMarkerGating === 'function') {
									applyOperationsMarkerGating(getSelectedScenarioYear(), getSelectedSide());
								}
							});
						}

						// Manual basing filter (checkboxes)
						document.querySelectorAll('input[type="checkbox"][data-basing-country][data-basing-base-id]').forEach(cb => {
							cb.addEventListener('change', () => {
								applyBasingRightsDeploymentReset();

								if (typeof applyOperationsMarkerGating === 'function') {
									applyOperationsMarkerGating(getSelectedScenarioYear(), getSelectedSide());
								}
							});
						});

						applyGating();

						if (typeof applyBasingAccessToForwardDeployedAircraft === 'function') {
							applyBasingAccessToForwardDeployedAircraft(getSelectedScenarioYear(), getSelectedSide());
						}
					}

					// ------------------------ //
					// Initialize Air Base Data //
					// ------------------------ //

					// =========================
					// Air Base Parking Capacity
					// =========================

					// maxCapacity - total parking capacity of the base
					// startingUsedCapacity - parking occupied by forward-deployed aircraft
					// usedCapacity - parking consumed by aircraft deployed during setup (player deployments)

					// totalUsedCapacity = startingUsedCapacity + usedCapacity
					// remainingCapacity = maxCapacity - totalUsedCapacity

					// Command aircraft parking occupancy reference:
					// Small Aircraft - 10
					// Medium Aircraft - 20
					// Large Aircraft - 30
					// Very Large Aircraft - 40
					
					let airBases = {
						1: { name: 'Prince Sultan Air Base', maxCapacity: 3800, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} },
						2: { name: 'Al Udeid Air Base', maxCapacity: 3800, startingUsedCapacity: { early2020: 840, mid2020: 600, late2020: 600 }, usedCapacity: 0, deployed: {} },
						3: { name: 'Al Dhafra Air Base', maxCapacity: 3800, startingUsedCapacity: { early2020: 480, mid2020: 480, late2020: 480 }, usedCapacity: 0, deployed: {} },
						4: { name: 'Diego Garcia', maxCapacity: 3750, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} },
						5: { name: 'Ali Al Salem Air Base', maxCapacity: 3760, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} },
						6: { name: 'Muwaffaq Salti Air Base', maxCapacity: 3760, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} },
						7: { name: 'Ben Gurion Airport', maxCapacity: 960, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} }, // Capacity for ~24 x Very Large Aircraft
						8: { name: 'Ovda Air Base', maxCapacity: 3760, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} },
						9: { name: 'Off Map Air Bases (Western Europe and CONUS)', maxCapacity: 5360, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} },
						10: { name: 'Off Map Air Bases (Northern Europe)', maxCapacity: 5360, startingUsedCapacity: { early2020: 0, mid2020: 0, late2020: 0 }, usedCapacity: 0, deployed: {} }
					};

					let aircraftTypes = {
						f15c: { name: 'F-15C', occupiedSpace: 30, deployed: 0, max: { early2020: 72, mid2020: 48, late2020: 48 } },
						f15e: { name: 'F-15E', occupiedSpace: 30, deployed: 0, max: 72 },
						f15ex: { name: 'F-15EX', occupiedSpace: 30, deployed: 0, max: { early2020: 0, mid2020: 24, late2020: 72 } },
						f16c: { name: 'F-16C', occupiedSpace: 20, deployed: 0, max: 144 },
						f22a: { name: 'F-22A', occupiedSpace: 30, deployed: 0, max: { early2020: 48, mid2020: 48, late2020: 48 } },
						f35a: { name: 'F-35A', occupiedSpace: 20, deployed: 0, max: { early2020: 48, mid2020: 72, late2020: 96 } },
						fqxx: { name: 'FQ-XX', occupiedSpace: 10, deployed: 0, max: 144 },

						b1b: { name: 'B-1B', occupiedSpace: 40, deployed: 0, max: { early2020: 18, mid2020: 18, late2020: 18 }, sharedCapGroup: 'b1' },
						b1r: { name: 'B-1R', occupiedSpace: 40, deployed: 0, max: { early2020: 18, mid2020: 18, late2020: 18 }, sharedCapGroup: 'b1' },
						b2a: { name: 'B-2A', occupiedSpace: 40, deployed: 0, max: 9 },
						b21a: { name: 'B-21A', occupiedSpace: 40, deployed: 0, max: { early2020: 0, mid2020: 0, late2020: 12 }, sharedCapGroup: 'b21' },
						b21r: { name: 'B-21R', occupiedSpace: 40, deployed: 0, max: { early2020: 0, mid2020: 0, late2020: 12 }, sharedCapGroup: 'b21' },
						b52h: { name: 'B-52H', occupiedSpace: 40, deployed: 0, max: { early2020: 24, mid2020: 24, late2020: 0 }, sharedCapGroup: 'b52' },
						b52j: { name: 'B-52J', occupiedSpace: 40, deployed: 0, max: { early2020: 0, mid2020: 0, late2020: 24 }, sharedCapGroup: 'b52' },

						e2d: { name: 'E-2D', occupiedSpace: 30, deployed: 0, max: { early2020: 0, mid2020: 0, late2020: 10 } },
						e3g: { name: 'E-3G', occupiedSpace: 40, deployed: 0, max: { early2020: 4, mid2020: 4, late2020: 4 }, sharedCapGroup: 'aew' },
						e7a: { name: 'E-7A', occupiedSpace: 40, deployed: 0, max: { early2020: 0, mid2020: 0, late2020: 4 }, sharedCapGroup: 'aew' },
						ea18g: { name: 'EA-18G', occupiedSpace: 30, deployed: 0, max: { early2020: 35, mid2020: 35, late2020: 35 } },
						ea37b: { name: 'EA-37B', occupiedSpace: 40, deployed: 0, max: { early2020: 0, mid2020: 0, late2020: 8 }, sharedCapGroup: 'ecs' },
						ec130h: { name: 'EC-130H', occupiedSpace: 40, deployed: 0, max: { early2020: 8, mid2020: 8, late2020: 8 }, sharedCapGroup: 'ecs' },

						kc10a: { name: 'KC-10A', occupiedSpace: 40, deployed: 0, max: { early2020: 24, mid2020: 0, late2020: 0 } },
						kc46a: { name: 'KC-46A', occupiedSpace: 40, deployed: 0, max: { early2020: 0, mid2020: 24, late2020: 48 } },
						kc135r: { name: 'KC-135R', occupiedSpace: 40, deployed: 0, max: 72 },
						c17a: { name: 'C-17A', occupiedSpace: 40, deployed: 0, max: 24 },

						mq9a: { name: 'MQ-9A', occupiedSpace: 10, deployed: 0, max: { early2020: 48, mid2020: 48, late2020: 48 } },
						rq4b: { name: 'RQ-4B', occupiedSpace: 40, deployed: 0, max: { early2020: 4, mid2020: 4, late2020: 4 } },
						rq170a: { name: 'RQ-170A', occupiedSpace: 10, deployed: 0, max: { early2020: 4, mid2020: 4, late2020: 4 } },
						rq180: { name: 'RQ-180', occupiedSpace: 40, deployed: 0, max: { early2020: 4, mid2020: 4, late2020: 4 } },
						lucasARM: { name: 'LUCAS (ARM)', occupiedSpace: 0, deployed: 0, max: { early2020: 0, mid2020: 3, late2020: 12 }, sharedCapGroup: 'owa' },
						lucasEOIR: { name: 'LUCAS (EO/IR)', occupiedSpace: 0, deployed: 0, max: { early2020: 0, mid2020: 3, late2020: 12 }, sharedCapGroup: 'owa' }
					};

					let multipleAircraftTypes = {
						rescuesqn: {
							name: 'Rescue Squadron',
							max: { early2020: 2, mid2020: 2, late2020: 2 },
							aircraft: {
								early2020: {
									hc130: { name: 'HC-130', occupiedSpace: 40, perGroup: 4 },
									mc130: { name: 'MC-130', occupiedSpace: 40, perGroup: 4 },
									hh60g: { name: 'HH-60G', occupiedSpace: 20, perGroup: 8 }
								},
								mid2020: {
									hc130: { name: 'HC-130', occupiedSpace: 40, perGroup: 4 },
									mc130: { name: 'MC-130', occupiedSpace: 40, perGroup: 4 },
									hh60w: { name: 'HH-60W', occupiedSpace: 20, perGroup: 8 }
								},
								late2020: {
									hc130: { name: 'HC-130', occupiedSpace: 40, perGroup: 4 },
									mc130: { name: 'MC-130', occupiedSpace: 40, perGroup: 4 },
									hh60w: { name: 'HH-60W', occupiedSpace: 20, perGroup: 8 }
								}
							}
						}
					};

					let sharedCaps = {
						b1: { max: 18 },
						b21: { max: 12 },
						b52: { max: 24 },
						aew: { max: 4 },
						ecs: { max: 8 },
						owa: { max: { early2020: 0, mid2020: 3, late2020: 12 } }
					};

					// Active aircraft type limits table for the currently selected year
					let activeAircraftTypeLimits = {};

					function setAircraftTypesForYear(selectedYear) {
						activeAircraftTypeLimits = JSON.parse(JSON.stringify(aircraftTypeLimits[selectedYear] || {}));
					}

					let forwardDeployedAircraftByYear = {
						early2020: {
							2: { kc135r: 18 }, // Al Udeid
							3: { kc10a: 12 }, // Al Dhafra
						},
						mid2020: {
							2: { kc135r: 12 }, // Al Udeid
						},
						late2020: {
							2: { kc46a: 12 }, // Al Udeid
						}
					};

					let forwardDeployedAircraftBaseline = JSON.parse(JSON.stringify(forwardDeployedAircraftByYear.early2020));

					let forwardDeployedAircraft = JSON.parse(JSON.stringify(forwardDeployedAircraftBaseline));

					let navalDeploymentAreas = {
						1: { 
							ships: { 
								carriers: { deployed: 0, max: 4, early2020: 0, mid2020: 0, late2020: 0 },
							}
						}
					};

					let shipTypes = { 
						carriers: { name: 'Carrier', deployed: 0, max: 4, early2020: 0, mid2020: 0, late2020: 0 },
					};

					// ----------------------------- //
					// Aircraft Deployment Functions //
					// ----------------------------- //

					function getStartingUsedCapacity(base, selectedYear) {
						let year = selectedYear || getSelectedScenarioYear();
						return airBases[base]?.startingUsedCapacity?.[year] || 0;
					}

					function getTotalUsedCapacity(base, selectedYear) {
						if (!airBases[base]) return 0;
						return getStartingUsedCapacity(base, selectedYear) + (airBases[base].usedCapacity || 0);
					}

					function getRemainingCapacity(base, selectedYear) {
						if (!airBases[base]) return 0;
						return airBases[base].maxCapacity - getTotalUsedCapacity(base, selectedYear);
					}

					function getDeployedAircraftCount(base, type) {
						return airBases[base]?.deployed?.[type] || 0;
					}

					function getTotalDeployedOfType(type) {
						let total = 0;

						for (let b = 1; b <= 10; b++) {
							if (!airBases[b]) continue;
							total += getDeployedAircraftCount(b, type);
						}

						return total;
					}

					function getSharedCapMax(sharedGroup, selectedYear) {
						let year = selectedYear || getSelectedScenarioYear();
						let sharedCap = sharedCaps[sharedGroup];

						if (!sharedCap) return 0;

						if (typeof sharedCap.max === 'object' && sharedCap.max !== null) {
							return sharedCap.max[year] || 0;
						}

						return sharedCap.max || 0;
					}

					function getAircraftMax(type, selectedYear) {
						let year = selectedYear || getSelectedScenarioYear();
						let typeData = aircraftTypes[type];

						if (!typeData) return 0;

						if (typeof typeData.max === 'object') {
							return typeData.max[year] || 0;
						}

						return typeData.max || 0;
					}

					function getAircraftLimitData(type, selectedYear) {
						let year = selectedYear || getSelectedScenarioYear();
						let typeData = aircraftTypes[type];

						if (!typeData) return null;

						return {
							name: typeData.name,
							max: getAircraftMax(type, year),
							sharedCapGroup: typeData.sharedCapGroup || null
						};
					}

					function resetAircraftTypeDeployments() {
						Object.keys(aircraftTypes).forEach(type => {
							aircraftTypes[type].deployed = 0;
						});
					}

					function resetAirBaseUsedCapacity() {
						Object.keys(airBases).forEach(base => {
							airBases[base].usedCapacity = 0;
							airBases[base].deployed = {};
						});
					}

					function deployAircraft(side, base, type, count) {
						side = side || 'usa';

						if (!airBases[base]) {
							alert('Invalid airbase!');
							return;
						}

						let typeData = aircraftTypes[type];
						let typeLimitData = getAircraftLimitData(type);

						if (!typeData || !typeLimitData) {
							alert('Invalid aircraft type!');
							return;
						}

						if (typeLimitData.max <= 0) {
							alert(`You cannot deploy anymore ${typeLimitData.name}'s! No more are available.`);
							return;
						}

						let sharedGroup = typeLimitData.sharedCapGroup;

						if (sharedGroup && sharedCaps[sharedGroup]) {
							let combinedTotal = 0;

							Object.keys(aircraftTypes).forEach(variant => {
								if (aircraftTypes[variant].sharedCapGroup === sharedGroup) {
									combinedTotal += getTotalDeployedOfType(variant);
								}
							});

							let remainingShared = getSharedCapMax(sharedGroup) - combinedTotal;

							if (count > remainingShared) {
								alert(`You cannot deploy anymore ${typeLimitData.name}'s! No more are available.`);
								return;
							}
						}

						if (getTotalDeployedOfType(type) + count > typeLimitData.max) {
							alert(`You cannot deploy anymore ${typeLimitData.name}'s! No more are available.`);
							return;
						}

						let requiredCapacity = (typeData.occupiedSpace || 0) * count;

						if (requiredCapacity > getRemainingCapacity(base)) {
							alert('Air base at maximum capacity!');
							return;
						}

						airBases[base].usedCapacity += requiredCapacity;
						airBases[base].deployed[type] = (airBases[base].deployed[type] || 0) + count;

						let inputElement = document.getElementById(`${side}_air_base_${base}_${type}_input`);
						if (inputElement) {
							inputElement.value = airBases[base].deployed[type];
						}

						updateAircraftCounters(side);
						updateTotalAircraftCounters();
						updateAircraftSummaryCounters(side);
					}

					function undeployAircraft(side, base, type, count) {
						side = side || 'usa';

						if (!airBases[base]) {
							alert('Invalid airbase!');
							return;
						}

						let typeLimitData = getAircraftLimitData(type);
						let typeName = typeLimitData?.name || aircraftTypes[type]?.name || type;

						let deployedCount = getDeployedAircraftCount(base, type);

						if (deployedCount < count) {
							alert(`Cannot remove more ${typeName} than currently deployed!`);
							return;
						}

						let releasedCapacity = (aircraftTypes[type]?.occupiedSpace || 0) * count;

						airBases[base].usedCapacity = Math.max(0, airBases[base].usedCapacity - releasedCapacity);
						airBases[base].deployed[type] = deployedCount - count;

						let inputElement = document.getElementById(`${side}_air_base_${base}_${type}_input`);

						if (inputElement) {
							inputElement.value = airBases[base].deployed[type];
						}

						updateAircraftCounters(side);
						updateTotalAircraftCounters();
						updateAircraftSummaryCounters(side);
					}

					function getMultipleAircraftTypeMax(type, selectedYear) {
						let year = selectedYear || getSelectedScenarioYear();
						let typeData = multipleAircraftTypes[type];

						if (!typeData) {
							return 0;
						}

						if (typeof typeData.max === 'object' && typeData.max !== null) {
							return typeData.max[year] || 0;
						}

						return typeData.max || 0;
					}

					function getMultipleAircraftConfig(type, selectedYear) {
						let year = selectedYear || getSelectedScenarioYear();
						return multipleAircraftTypes[type]?.aircraft?.[year] || {};
					}

					function getMultipleAircraftOccupiedSpace(type, selectedYear) {
						let config = getMultipleAircraftConfig(type, selectedYear);
						let totalOccupiedSpace = 0;

						Object.keys(config).forEach(componentType => {
							let component = config[componentType];
							totalOccupiedSpace += (component.occupiedSpace || 0) * (component.perGroup || 0);
						});

						return totalOccupiedSpace;
					}

					function getMultipleAircraftComponentCounts(type, groupCount, selectedYear) {
						let config = getMultipleAircraftConfig(type, selectedYear);
						let componentCounts = {};

						Object.keys(config).forEach(componentType => {
							let component = config[componentType];
							componentCounts[componentType] = groupCount * (component.perGroup || 0);
						});

						return componentCounts;
					}

					function getTotalDeployedMultipleAircraftType(type) {
						let total = 0;

						for (let base = 1; base <= 10; base++) {
							if (!airBases[base]) continue;
							total += getDeployedAircraftCount(base, type);
						}

						return total;
					}

					function deployMultipleAircraft(side, base, type, count) {
						side = side || 'usa';

						if (!airBases[base]) {
							alert('Invalid airbase!');
							return;
						}

						if (!multipleAircraftTypes[type]) {
							alert('Invalid grouped aircraft type!');
							return;
						}

						if (type === 'rescuesqn' && !getSelectedSearchAndRescueEnabled()) {
							alert('Search and Rescue is currently disabled!');
							return;
						}

						let maxAllowed = getMultipleAircraftTypeMax(type);
						let typeName = multipleAircraftTypes[type].name || type;

						if (maxAllowed <= 0) {
							alert(`You cannot deploy anymore ${typeName}'s! No more aircraft are available.`);
							return;
						}

						if (getTotalDeployedMultipleAircraftType(type) + count > maxAllowed) {
							alert(`You cannot deploy anymore ${typeName}'s! No more aircraft are available.`);
							return;
						}

						let requiredCapacity = getMultipleAircraftOccupiedSpace(type) * count;
						if (requiredCapacity > getRemainingCapacity(base)) {
							alert('Air base at maximum capacity!');
							return;
						}

						let componentCounts = getMultipleAircraftComponentCounts(type, count);

						airBases[base].usedCapacity += requiredCapacity;
						airBases[base].deployed[type] = (airBases[base].deployed[type] || 0) + count;

						Object.keys(componentCounts).forEach(componentType => {
							airBases[base].deployed[componentType] = (airBases[base].deployed[componentType] || 0) + componentCounts[componentType];
						});

						let inputElement = document.getElementById(`${side}_air_base_${base}_${type}_input`);
						if (inputElement) {
							inputElement.value = airBases[base].deployed[type];
						}

						updateAircraftCounters(side);
						updateTotalAircraftCounters();
					}

					function undeployMultipleAircraft(side, base, type, count) {
						side = side || 'usa';

						if (!airBases[base]) {
							alert('Invalid airbase!');
							return;
						}

						if (!multipleAircraftTypes[type]) {
							alert('Invalid grouped aircraft type!');
							return;
						}

						let typeName = multipleAircraftTypes[type].name || type;
						let deployedCount = getDeployedAircraftCount(base, type);

						if (deployedCount < count) {
							alert(`Cannot remove more ${typeName} than currently deployed!`);
							return;
						}

						let releasedCapacity = getMultipleAircraftOccupiedSpace(type) * count;
						let componentCounts = getMultipleAircraftComponentCounts(type, count);

						airBases[base].usedCapacity = Math.max(0, airBases[base].usedCapacity - releasedCapacity);
						airBases[base].deployed[type] = deployedCount - count;

						Object.keys(componentCounts).forEach(componentType => {
							let currentCount = airBases[base].deployed[componentType] || 0;
							airBases[base].deployed[componentType] = Math.max(0, currentCount - componentCounts[componentType]);
						});

						let inputElement = document.getElementById(`${side}_air_base_${base}_${type}_input`);
						if (inputElement) {
							inputElement.value = airBases[base].deployed[type];
						}

						updateAircraftCounters(side);
						updateTotalAircraftCounters();
					}

					function setAircraftTypesForYear(selectedYear) {
						resetAircraftTypeDeployments();
						resetAirBaseUsedCapacity();
					}

					function updateAircraftCounters(side) {
						side = side || 'usa';

						const smallAircraft = ['fqxx', 'mq9a', 'rq170a', 'hh60g', 'hh60w'];
						const mediumAircraft = ['f16c', 'f35a'];
						const largeAircraft = ['f15c', 'f15e', 'f15ex', 'f22a', 'ea18g', 'hc130', 'mc130'];
						const veryLargeAircraft = ['b1b', 'b1r', 'b2a', 'b21a', 'b21r', 'b52h', 'b52j', 'e2d', 'e3g', 'e7a', 'ea37b', 'ec130h', 'kc10a', 'kc46a', 'kc135r', 'c17a', 'rq4b', 'rq180'];
						const groupedAircraftTypes = ['rescuesqn'];
						const owaAircraftTypes = ['lucasARM', 'lucasEOIR'];
						const allTypes = [...smallAircraft, ...mediumAircraft, ...largeAircraft, ...veryLargeAircraft, ...groupedAircraftTypes, ...owaAircraftTypes];

						for (let base = 1; base <= 10; base++) {
							if (!airBases[base]) continue;

							document.querySelectorAll(`#${side}_air_base_${base}_total_capacity`).forEach(el => {
								el.innerText = `${getTotalUsedCapacity(base)} / ${airBases[base].maxCapacity}`;
							});

							allTypes.forEach(type => {
								let count = getDeployedAircraftCount(base, type);

								document.querySelectorAll(`#${side}_air_base_${base}_${type}`).forEach(el => {
									el.innerText = count;
								});

								document.querySelectorAll(`#${side}_air_base_${base}_${type}_input`).forEach(el => {
									el.value = count;
								});
							});
						}
					}

					function updateTotalAircraftCounters() {
						let totalAircraft = {
							f15c: 0, f15e: 0, f15ex: 0, f16c: 0, f22a: 0, f35a: 0, fqxx: 0, ea18g: 0,
							b1b: 0, b1r: 0, b2a: 0, b21a: 0, b21r: 0, b52h: 0, b52j: 0,
							e2d: 0, e3g: 0, e7a: 0, ea37b: 0, ec130h: 0,
							kc10a: 0, kc46a: 0, kc135r: 0, c17a: 0,
							rescuesqn: 0, hc130: 0, mc130: 0, hh60g: 0, hh60w: 0,
							mq9a: 0, rq4b: 0, rq170a: 0, rq180: 0, lucasARM: 0, lucasEOIR: 0
						};

						for (let base = 1; base <= 10; base++) {
							if (!airBases[base]) continue;

							for (let type in totalAircraft) {
								totalAircraft[type] += getDeployedAircraftCount(base, type);
							}
						}

						for (let type in totalAircraft) {
							let element =
								document.getElementById(`total_${type}`) ||
								document.getElementById(`total_${type}_summary`);

							if (!element) continue;

							if (type === 'rescuesqn') {
								let maxValue = getMultipleAircraftTypeMax(type);
								element.innerText = maxValue ? `${totalAircraft[type]} / ${maxValue}` : `${totalAircraft[type]}`;
								continue;
							}

							let maxValue = activeAircraftTypeLimits[type]?.max;
							element.innerText = maxValue ? `${totalAircraft[type]} / ${maxValue}` : `${totalAircraft[type]}`;
						}
					}

					function updateAircraftSummaryCounters(side) {
						side = side || 'usa';
						let selectedYear = getSelectedScenarioYear();

						let totalAircraft = {
							kc10a: 0,
							kc46a: 0,
							kc135r: 0,
						};

						for (let base = 1; base <= 10; base++) {
							if (!airBases[base]) continue;

							let totalUsedCapacity = getTotalUsedCapacity(base, selectedYear);
							let usedCapacityElement = document.getElementById(`${side}_air_base_${base}_total_capacity`);
							if (usedCapacityElement) {
								usedCapacityElement.textContent = `${totalUsedCapacity} / ${airBases[base].maxCapacity}`;
							}

							let remainingCapacityInput = document.getElementById(`${side}_air_base_${base}_remaining_capacity_input`);
							if (remainingCapacityInput) {
								remainingCapacityInput.value = getRemainingCapacity(base, selectedYear);
							}

							['kc10a', 'kc46a', 'kc135r'].forEach(type => {
								let deployedCount = getDeployedAircraftCount(base, type);
								let forwardDeployedCount = forwardDeployedAircraft[base]?.[type] || 0;
								let totalCount = deployedCount + forwardDeployedCount;

								document.querySelectorAll(`#${side}_air_base_${base}_${type}_summary`).forEach(el => {
									el.innerText = totalCount;
								});

								totalAircraft[type] += totalCount;
							});
						}

						Object.keys(totalAircraft).forEach(type => {
							let element = document.getElementById(`total_${type}_summary`);
							if (element) {
								element.innerText = totalAircraft[type];
							}
						});
					}

					// ------------------------- //
					// Ship Deployment Functions //
					// ------------------------- //

					function deployShip(side, area, category, type, count) {
						let areaData = navalDeploymentAreas[area];
						let shipData = shipTypes[category];

						if (!areaData || !shipData) {
							console.error("Invalid deployment area or ship type.");
							return;
						}

						if ((areaData.ships[category].deployed + count) > shipData.max) {
							alert(`Cannot deploy more than ${shipData.max} ${shipData.name}.`);
							return;
						}

						areaData.ships[category].deployed += count;
						areaData.ships[category][type] = (areaData.ships[category][type] || 0) + count;

						// usa_naval_deployment_{area}_{category}_{type}
						let displayElement = document.getElementById(`${side}_naval_deployment_${area}_${category}_${type}`);
						let inputElement = document.getElementById(`${side}_naval_deployment_${area}_${category}_${type}_input`);
						let totalDisplay = document.getElementById(`${side}_naval_deployment_${area}_${category}_total`);

						if (displayElement) displayElement.innerText = areaData.ships[category][type];
						if (inputElement) inputElement.value = areaData.ships[category][type];
						if (totalDisplay) totalDisplay.innerText = `${areaData.ships[category].deployed} / ${shipData.max}`;

						updateShipCounters(side);
						updateTotalShipCounters(side);
					}

					function undeployShip(side, area, category, type, count) {
						let areaData = navalDeploymentAreas[area];
						let shipData = shipTypes[category];

						if (!areaData || !shipData) {
							console.error("Invalid deployment area or ship type.");
							return;
						}

						let currentCount = areaData.ships[category][type] || 0;

						if (currentCount < count) {
							alert(`Cannot undeploy more ${shipData.name} (${type}) than currently deployed.`);
							return;
						}

						areaData.ships[category][type] -= count;
						areaData.ships[category].deployed -= count;

						if (areaData.ships[category][type] === 0) {
							delete areaData.ships[category][type];
						}

						let displayElement = document.getElementById(`${side}_naval_deployment_${area}_${category}_${type}`);
						let inputElement = document.getElementById(`${side}_naval_deployment_${area}_${category}_${type}_input`);
						let totalDisplay = document.getElementById(`${side}_naval_deployment_${area}_${category}_total`);

						if (displayElement) displayElement.innerText = areaData.ships[category][type] || 0;
						if (inputElement) inputElement.value = areaData.ships[category][type] || 0;
						if (totalDisplay) totalDisplay.innerText = `${areaData.ships[category].deployed} / ${shipData.max}`;

						updateShipCounters(side);
						updateTotalShipCounters(side);
					}

					function updateShipCounters(side) {
						// Default to 'usa' if nothing is passed
						side = side || 'usa';

						for (let area in navalDeploymentAreas) {
							for (let category in navalDeploymentAreas[area].ships) {
								let categoryData = navalDeploymentAreas[area].ships[category];

								// Check if the ship type exists before updating
								if (!shipTypes[category]) {
									console.warn(`Warning: Ship type '${category}' not found in shipTypes. Skipping...`);
									continue;
								}

								// Update total deployed for each ship category (e.g., carriers)
								document.querySelectorAll(`#${side}_naval_deployment_${area}_${category}_total`).forEach(el => {
									el.innerText = `${categoryData.deployed} / ${shipTypes[category].max}`;
								});

								// Update individual ship variants
								for (let variant in shipTypes[category]) {
									if (variant === "name" || variant === "deployed" || variant === "max") continue;

									let count = categoryData[variant] || 0;

									// Update visible counter
									document.querySelectorAll(`#${side}_naval_deployment_${area}_${category}_${variant}`).forEach(el => {
										el.innerText = count;
									});

									// Update hidden input for Lua export
									document.querySelectorAll(`#${side}_naval_deployment_${area}_${category}_${variant}_input`).forEach(el => {
										el.value = count;
									});
								}
							}
						}
					}

					function updateTotalShipCounters(side) {
						// Default to 'usa' if nothing is passed
						side = side || 'usa';

						// Calculate total ships across all areas and types
						let totalShips = {};

						for (let category in shipTypes) {
							totalShips[category] = { deployed: 0 };

							for (let variant in shipTypes[category]) {
								if (variant !== "name" && variant !== "deployed" && variant !== "max") {
									totalShips[category][variant] = 0;
								}
							}
						}

						for (let area in navalDeploymentAreas) {
							for (let category in navalDeploymentAreas[area].ships) {
								let categoryData = navalDeploymentAreas[area].ships[category];

								if (!totalShips[category]) continue;

								totalShips[category].deployed += categoryData.deployed;

								for (let variant in categoryData) {
									if (variant !== "deployed" && variant !== "max") {
										totalShips[category][variant] += categoryData[variant] || 0;
									}
								}
							}
						}

						// Update the total ship section on the Summary Tab
						for (let category in totalShips) {
							let totalElement = document.getElementById(`${side}_total_${category}`);
							if (totalElement) {
								let maxValue = shipTypes[category]?.max;
								totalElement.innerText = maxValue
									? `${totalShips[category].deployed} / ${maxValue}`
									: `${totalShips[category].deployed}`;
							}

							// Update individual ship variant counters
							for (let variant in totalShips[category]) {
								if (variant !== "deployed") {
									let variantElement = document.getElementById(`${side}_total_${category}_${variant}`);
									if (variantElement) {
										variantElement.innerText = totalShips[category][variant];
									}
								}
							}
						}
					}

					// -------------------------- //
					// Ship Toggle Block Selector //
					// -------------------------- //

					function setupVariantBlockToggleFromRadio(radioGroupName, blockSelector) {
						const radios = document.querySelectorAll(`input[name="${radioGroupName}"]`);
						const blocks = document.querySelectorAll(blockSelector);

						function applySelection(selectedValue) {
							blocks.forEach(block => {
								const targetShip = block.getAttribute('data-ship-id');
								block.style.display = (selectedValue === targetShip) ? 'block' : 'none';
							});
						}

						radios.forEach(radio => {
							radio.addEventListener('change', function () {
								applySelection(this.value);
							});
						});

						const checkedRadio = document.querySelector(`input[name="${radioGroupName}"]:checked`);
						if (checkedRadio) {
							applySelection(checkedRadio.value);
						} else {
							blocks.forEach(block => block.style.display = 'none');
						}
					}

					function setupVariantBlockToggleFromSelect(containerId, selectName, blockSelector, dataAttributeName) {
						const container = document.getElementById(containerId);
						if (!container) return;

						const select = container.querySelector(`select[name="${selectName}"]`);
						const blocks = container.querySelectorAll(blockSelector);
						const attrName = dataAttributeName || 'data-ship-key';

						function ensureDefaultRadioChecked(block) {
							const radios = block.querySelectorAll('input[type="radio"]');
							if (!radios.length) return;

							const anyChecked = Array.from(radios).some(r => r.checked);
							if (anyChecked) return;

							const preferred = Array.from(radios).find(r => r.hasAttribute('checked'));
							(preferred || radios[0]).checked = true;
						}

						function applySelection() {
							const selectedValue = select ? select.value : '';

							blocks.forEach(block => {
								const targetValue = block.getAttribute(attrName);
								const shouldShow = (selectedValue && selectedValue === targetValue);

								block.style.display = shouldShow ? 'block' : 'none';

								if (shouldShow) {
									ensureDefaultRadioChecked(block);
								}
							});
						}

						if (select) {
							select.addEventListener('change', applySelection);
						}

						applySelection();
					}

					// ------------------------- //
					// Unit Card Popup Functions //
					// ------------------------- //

					function openUnitCardPopup(trigger) {
						const ids = trigger.dataset.unitId.split(",").map(id => id.trim());
						const summaryTitle = trigger.dataset.summaryTitle || "";
						const summaryDetails = trigger.dataset.summaryDetails || "";
						const popup = document.getElementById("unitCardPopup");
						const summary = document.getElementById("unitCardSummary");
						const content = document.getElementById("unitCardContent");

						// Clear previous content
						summary.innerHTML = "";
						content.innerHTML = "";

						// If a summary is provided, display it and mark as multi-unit
						if (summaryTitle || summaryDetails) {
							popup.classList.add("multi-unit");

							// Build header
							if (summaryTitle) {
							const header = document.createElement("h3");
							header.className = "unit-card-popup-title";
							header.innerText = summaryTitle;
							summary.appendChild(header);
							}

							// Build list
							if (summaryDetails) {
							const ul = document.createElement("ul");
							ul.className = "unit-card-popup-list";
							summaryDetails.split(";").forEach(item => {
								const li = document.createElement("li");
								li.innerText = item.trim();
								ul.appendChild(li);
							});
							summary.appendChild(ul);
							}
						} else {
							popup.classList.remove("multi-unit");
						}

						// Clone each matching unit card into the popup
						ids.forEach(id => {
							const card = document.querySelector(`.unit-card[data-unit-id="${id}"]`);
							if (card) {
							const clone = card.cloneNode(true);

							// Rebind flip handler
							clone.onclick = function () { toggleCard(clone); };

							// Only add per-card close button if NOT multi-unit
							if (!popup.classList.contains("multi-unit")) {
								const closeBtn = document.createElement("button");
								closeBtn.innerText = "X";
								closeBtn.className = "close-card-popup";
								closeBtn.onclick = function (e) {
								e.stopPropagation();
								closeUnitCardPopup();
								};
								clone.style.position = "relative";
								clone.appendChild(closeBtn);
							}

							content.appendChild(clone);
							}
						});

						// Anchor popup to the right-side operations panel
						const panelContainer = trigger.closest('.popup-window-container');
						const panelContent = panelContainer ? panelContainer.querySelector('.popup-window-content') : null;
						const anchorEl = panelContent || panelContainer || document.body; // fallback
						const rect = anchorEl.getBoundingClientRect();

						Object.assign(popup.style, {
							position: 'fixed',
							left: rect.left + 'px',
							top: rect.top + 'px',
							width: rect.width + 'px',
							height: rect.height + 'px',
							display: 'flex',
							justifyContent: 'center',
							alignItems: 'center'
						});
					}

					function closeUnitCardPopup() {
						const popup = document.getElementById("unitCardPopup");
						popup.style.display = "none";

						// Clean up contents so old cards/summary don't persist
						document.getElementById("unitCardSummary").innerHTML = "";
						document.getElementById("unitCardContent").innerHTML = "";
					}

						// Attach event listeners to all trigger images
					document.addEventListener("DOMContentLoaded", () => {
						initializeSubOptionReveal();
						document.querySelectorAll(".popup-card-trigger").forEach(img => {
							img.addEventListener("click", () => openUnitCardPopup(img));
						});
					});

					// Ensure counters are updated on load
					window.onload = function() {
						initializeOptionsGating();
						if (typeof updateBasingAllowedHiddenInputs === 'function') updateBasingAllowedHiddenInputs();
						initializeUnitCardGating();
						updateAircraftCounters();
						updateTotalAircraftCounters();
						updateShipCounters();
						updateTotalShipCounters();
					}
				</script>
			</body>
		</html>
	]=]

	local function EscapePercentsButKeep_s(str)
		-- Protect ONLY the intended injection slot: value="%s"
		-- (So the JS sentinel '%s' becomes a literal after escaping)
		str = str:gsub('value="%%s"', 'value="__FMT_S__"', 1)

		-- Escape every remaining % so CSS/text like "40%" won't break format()
		str = str:gsub("%%", "%%%%")

		-- Restore the intended token
		str = str:gsub('value="__FMT_S__"', 'value="%%s"', 1)

		return str
	end

	local PlayerSide = ScenEdit_PlayerSide()
	local SideKey = 'usa-israel' -- default fallback

	if PlayerSide == 'United States' then
		SideKey = 'usa'
	elseif PlayerSide == 'Israel' then
		SideKey = 'israel'
	elseif PlayerSide == 'United States-Israel' then
		SideKey = 'usa-israel'
	end

	local html_safe = EscapePercentsButKeep_s(htmlMenu)
	local htmlString = string.format(html_safe, SideKey)
	local form = UI_CallAdvancedHTMLDialog('Title', htmlString, {'Done'})
	if form['pressed'] and form['pressed'] == 'Done' then

		-- =========================
		-- Scenario Year
		-- =========================

		-- Changes done during scenario initialization
		local SelectedOption = string.gsub(form['scenario_year'], "%'", "")
		if SelectedOption == 'early2020' then
			ScenarioYear('early2020')
			ScenEdit_SetTime({DateFormat='DDMMYYYY', Date='06.07.2020', StartDate='06.07.2020'})
		elseif SelectedOption == 'mid2020' then
			ScenarioYear('mid2020')
			ScenEdit_SetTime({DateFormat='DDMMYYYY', Date='06.07.2025', StartDate='06.07.2025'})
		else
			ScenarioYear('late2020')
			ScenEdit_SetTime({DateFormat='DDMMYYYY', Date='06.07.2030', StartDate='06.07.2030'})
		end

		-- =========================
		-- Scenario Event and Special Action Chances
		-- =========================

		local GlobalVariables

		local SelectedOption = string.gsub(form['scenario_event_chances'], "%'", "")
		if SelectedOption == 'realistic' then
			UseRealisticVariables(true)

			GlobalVariables = {
				{variable='PlayerCyberChance', value=70, persist=true, key='PlayerCyberChanceKey'},
				{variable='PlayerCyberIncrement', value=20, persist=true, key='PlayerCyberIncrementKey'},

				-- Variables only needed upon scenario initialization
				{variable='IranUnitPlacementOrUpgradeChance', value=60, persist=false},
			}
		elseif SelectedOption == 'random' then -- Random
			UseRandomVariables(true)
			UseRealisticVariables(false)

			GlobalVariables = {
				{variable='PlayerCyberChance', value=GetRandomRoundedNumber(0, 100, 5), persist=true, key='PlayerCyberChanceKey'},
				{variable='PlayerCyberIncrement', value=GetRandomRoundedNumber(0, 100, 5), persist=true, key='PlayerCyberIncrementKey'},

				-- Variables only needed upon scenario initialization
				{variable='IranUnitPlacementOrUpgradeChance', value=GetRandomRoundedNumber(0, 100, 5), persist=false},
			}
		else -- Remove Randomization
			UseRandomVariables(false)
			UseRealisticVariables(false)

			GlobalVariables = {
				{variable='PlayerCyberChance', value=100, persist=true, key='PlayerCyberChanceKey'},
				{variable='PlayerCyberIncrement', value=0, persist=true, key='PlayerCyberIncrementKey'},

				-- Variables only needed upon scenario initialization
				{variable='IranUnitPlacementOrUpgradeChance', value=100, persist=false},
			}
		end

		for _, v in ipairs(GlobalVariables) do
			_G[v.variable] = v.value
			if v.persist then
				ScenEdit_SetKeyValue(v.key, tostring(v.value))
			end
		end

		-- =========================
		-- Enable Search and Rescue
		-- =========================

		local SelectedOption = string.gsub(form['enable_search_and_rescue'], "%'", "")
		if SelectedOption == 'enable_search_and_rescue_true' then
			SearchAndRescueEnabled(true)

			ScenEdit_SetEvent('Attempt CSAR', {isActive=true})
			ScenEdit_SetEvent('Setup Forward Refueling Point', {isActive=true})
		
			local ch53DBID = 4732 -- CH-53C Sea Stallion [Yasur 2025]
			local ch53LoadoutID = 33393

			if ScenarioYear() ~= 'early2020' then
				ch53DBID = 5336 -- CH-53K King Stallion
				ch53LoadoutID = 33394
			end

			if PlayerSide == 'Israel' or PlayerSide == 'United States-Israel' then
				AddAircraft(PlayerSide, 1, 8, ch53DBID, 'Unit 669 #', 'Tel Nof AB', ch53LoadoutID, 0) -- Add 8 x CH-53C Sea Stallion [Yasur 2025] or CH-53K King Stallion
				AddAircraft(PlayerSide, 1, 4, 7076, '103 Sqd. #', 'Nevatim AB', 30210, 0) -- Add 4 x C-130J-30 Hercules [Shimshon]
			end

			CargoAircraftList = {
				-- Landing altitude 10 ft higher then min to account for terrain elevation
				{name='103 Sqd. #1', minAltitude=510, landingSpeed=210, TimeToReady=30},
				{name='103 Sqd. #2', minAltitude=510, landingSpeed=210, TimeToReady=30},
				{name='103 Sqd. #3', minAltitude=510, landingSpeed=210, TimeToReady=30},
				{name='103 Sqd. #4', minAltitude=510, landingSpeed=210, TimeToReady=30},
	
				{name='ASHER 31', minAltitude=210, landingSpeed=140, TimeToReady=30},
				{name='ASHER 32', minAltitude=210, landingSpeed=140, TimeToReady=30},
				{name='ASHER 33', minAltitude=210, landingSpeed=140, TimeToReady=30},
				{name='ASHER 34', minAltitude=210, landingSpeed=140, TimeToReady=30},
	
				{name='BROKE 31', minAltitude=210, landingSpeed=140, TimeToReady=30},
				{name='BROKE 32', minAltitude=210, landingSpeed=140, TimeToReady=30},
				{name='BROKE 33', minAltitude=210, landingSpeed=140, TimeToReady=30},
				{name='BROKE 34', minAltitude=210, landingSpeed=140, TimeToReady=30},
			}

			RescueCapableUnits = {
				Aircraft = {
					4732, -- CH-53C Sea Stallion [Yasur 2025]
					5336, -- CH-53K King Stallion
					4365, -- HH-60G Credible Hawk
					4366, -- HH-60W Jolly Green II
					5338, -- MH-60R Seahawk
					5337 -- MH-60S Seahawk
					-- Add or remove aircraft entries as required
				},
				Ship = {
					-- Add or remove ship entries as required
				},
				Submarine = {
					-- Add or remove submarine entries as required
				},
				Facility = {
					-- Add or remove facility entries as required
				}
			}
		else
			SearchAndRescueEnabled(false)
		end

		-- =========================
		-- Fuel Usage
		-- =========================

		local SelectedOption = string.gsub(form['player_fuel_usage'], "%'", "")
		if SelectedOption == 'unlimited' then -- Unlimited fuel for player aircraft
			ScenEdit_SetEvent('Refuel Player Aircraft', {isActive=true})
		end

		-- =========================
		-- Add Additional Su-35 Squadrons
		-- =========================

		local SelectedOption = string.gsub(form['iran_add_su_35_squadrons'], "%'", "")
		if SelectedOption == 'iran_add_su_35_squadrons_true' then
			local UseExportAircraft = string.gsub(form["iran_export_su_35"] or "", "%'", "") == "true"
			if UseExportAircraft then
				AddAircraft('Iran', 1, 12, 6614, '32nd TFS #', 'Hamadan (3rd TAB)', 11076, 0) -- Add 12x Su-35S Flanker M, Iran
				AddAircraft('Iran', 1, 12, 6614, '74th TFS #', 'Shiraz (7th TAB)', 11076, 0) -- Add 12x Su-35S Flanker M, Iran
			else
				-- Add random loadout selection
				AddAircraft('Iran', 1, 12, 6645, '32nd TFS #', 'Hamadan (3rd TAB)', 31826, 0) -- Add 12x Su-35S Flanker M, Russia
				AddAircraft('Iran', 1, 12, 6645, '74th TFS #', 'Shiraz (7th TAB)', 31826, 0) -- Add 12x Su-35S Flanker M, Russia
			end

			AssignUnitsToMission('Iran', 1, 4, '32nd TFS #', 'CAP South', false)
			AssignUnitsToMission('Iran', 5, 8, '32nd TFS #', 'CAP Southwest', false)
			AssignUnitsToMission('Iran', 9, 12, '32nd TFS #', 'QRA Short Range', false)

			AssignUnitsToMission('Iran', 1, 6, '74th TFS #', 'CAP Center West 1', false)
			AssignUnitsToMission('Iran', 7, 12, '74th TFS #', 'QRA Short Range', false)
		end

		-- =========================
		-- Upgrade Iran Legacy Aircraft
		-- =========================

		local SelectedOption = string.gsub(form['iran_upgrade_legacy_aircraft'], "%'", "")
		if SelectedOption == 'iran_upgrade_legacy_aircraft_true' then
			local SelectedAircraft = SelectedAircraftOptions(IranAircraft, {
				UseExport = string.gsub(form["iran_legacy_aircraft_export"] or "", "%'", "") == "true",
				UseHypothetical = string.gsub(form["iran_legacy_aircraft_hypothetical"] or "", "%'", "") == "true",
				UseHypotheticalOnly = string.gsub(form["iran_legacy_aircraft_hypothetical_only"] or "", "%'", "") == "true",
			})

			RandomReplaceAircraft(
				'Iran',
				IranAircraftToUpgrade_1,
				IranUnitPlacementOrUpgradeChance,
				SelectedAircraft,
				20, 50, 80, 90, 100,
				0
			)
		end

		-- =========================
		-- Upgrade Iran Modern Aircraft
		-- =========================

		local SelectedOption = string.gsub(form['iran_upgrade_modern_aircraft'], "%'", "")
		if SelectedOption == 'iran_upgrade_modern_aircraft_true' then
			local SelectedAircraft = SelectedAircraftOptions(IranAircraft, {
				UseExport = string.gsub(form["iran_modern_aircraft_export"] or "", "%'", "") == "true",
				UseHypothetical = string.gsub(form["iran_modern_aircraft_hypothetical"] or "", "%'", "") == "true",
				UseHypotheticalOnly = string.gsub(form["iran_modern_aircraft_hypothetical_only"] or "", "%'", "") == "true",
			})

			RandomReplaceAircraft(
				'Iran',
				IranAircraftToUpgrade_2,
				IranUnitPlacementOrUpgradeChance,
				SelectedAircraft,
				20, 50, 80, 90, 100,
				0
			)
		end

		-- =========================
		-- Use Hypothetical Loadouts
		-- =========================

		local SelectedOption = string.gsub(form['iran_use_hypothetical_loadouts'], "%'", "")
		if SelectedOption == 'iran_use_hypothetical_loadouts_true' then
			IranUseHypotheticalLoadouts(true)
		else
			IranUseHypotheticalLoadouts(false)
		end

		-- =========================
		-- Iranian AAA
		-- =========================

		---- Place AAA at fixed sites ----

		local Multiplier
		local NatanzMultiplier

		local SelectedDensity = string.gsub(form['iran_amount_of_random_aaa'], "%'", "")
		if SelectedDensity == 'iran_amount_of_random_aaa_sparse' then
			Multiplier = 0.4
		elseif SelectedDensity == 'iran_amount_of_random_aaa_moderate' then
			Multiplier = 0.7
		elseif SelectedDensity == 'iran_amount_of_random_aaa_dense' then
			Multiplier = 1
		else -- Random
			Multiplier = math.random(1,100)/100
		end

		local SelectedNatanzDensity = string.gsub(form['iran_amount_of_natanz_aaa'], "%'", "")
		if SelectedNatanzDensity == 'iran_amount_of_natanz_aaa_sparse' then
			NatanzMultiplier = 0.1
		elseif SelectedNatanzDensity == 'iran_amount_of_natanz_aaa_moderate' then
			NatanzMultiplier = 0.4
		elseif SelectedNatanzDensity == 'iran_amount_of_natanz_aaa_dense' then
			NatanzMultiplier = 0.7
		elseif SelectedNatanzDensity == 'iran_amount_of_natanz_aaa_very_dense' then
			NatanzMultiplier = 1
		else -- Random
			NatanzMultiplier = math.random(1,100)/100
		end

		local NumberOfArakPositions = RoundNumber(64 * Multiplier, 0)
		local NumberOfEsfahanPositions = RoundNumber(60 * Multiplier, 0)
		local NumberOfFordowPositions = RoundNumber(22 * Multiplier, 0)
		local NumberOfNatanzPositions = RoundNumber(172 * NatanzMultiplier, 0)

		local ArakPositionList = GetRandomPositionList('Iran', 'Arak AAA Site', 64, false, 100, NumberOfArakPositions, NumberOfArakPositions)
		local EsfahanPositionList = GetRandomPositionList('Iran', 'Esfahãn AAA Site', 60, false, 100, NumberOfEsfahanPositions, NumberOfEsfahanPositions)
		local FordowPositionList = GetRandomPositionList('Iran', 'Fordow AAA Site', 22, false, 100, NumberOfFordowPositions, NumberOfFordowPositions)
		local NatanzPositionList = GetRandomPositionList('Iran', 'Natanz AAA Site', 172, false, 100, NumberOfNatanzPositions, NumberOfNatanzPositions)

		AddRandomFacility_FixedPosition('Iran', ArakPositionList, IranAAA, 95)
		AddRandomFacility_FixedPosition('Iran', EsfahanPositionList, IranAAA, 95)
		AddRandomFacility_FixedPosition('Iran', FordowPositionList, IranAAA, 95)
		AddRandomFacility_FixedPosition('Iran', NatanzPositionList, IranAAA, 95)

		---- Delete reference points when no longer needed ----

		-- DeleteReferencePoints_ByName('Iran', 'Arak AAA Site', 64)
		-- DeleteReferencePoints_ByName('Iran', 'Esfahãn AAA Site', 60)
		-- DeleteReferencePoints_ByName('Iran', 'Fordow AAA Site', 22)
		-- DeleteReferencePoints_ByName('Iran', 'Natanz AAA Site', 172)

		-- =========================
		-- Iranian SAMs
		-- =========================

		---- Determine available SAM types ----

		local SelectedHIAD = SelectedAirDefenseOptions(IranHIAD, {
			UseIranDomestic = string.gsub(form["iran_air_defenses_domestic"] or "", "%'", "") == "true",
			UseIranOutdated = string.gsub(form["iran_air_defenses_outdated"] or "", "%'", "") == "true",
			UseChina = string.gsub(form["iran_air_defenses_china"] or "", "%'", "") == "true",
			UseRussia = string.gsub(form["iran_air_defenses_russia"] or "", "%'", "") == "true"
		})

		local SelectedMEAD = SelectedAirDefenseOptions(IranMEAD, {
			UseIranDomestic = string.gsub(form["iran_air_defenses_domestic"] or "", "%'", "") == "true",
			UseIranOutdated = string.gsub(form["iran_air_defenses_outdated"] or "", "%'", "") == "true",
			UseChina = string.gsub(form["iran_air_defenses_china"] or "", "%'", "") == "true",
			UseRussia = string.gsub(form["iran_air_defenses_russia"] or "", "%'", "") == "true"
		})

		local SelectedSHORAD = SelectedAirDefenseOptions(IranSHORAD, {
			UseIranDomestic = string.gsub(form["iran_air_defenses_domestic"] or "", "%'", "") == "true",
			UseIranOutdated = string.gsub(form["iran_air_defenses_outdated"] or "", "%'", "") == "true",
			UseRussia = string.gsub(form["iran_air_defenses_russia"] or "", "%'", "") == "true"
		})

		IranADConfig = {
			sparse = {
				Arak={HIAD=2, MEAD=1, SHORAD={min=2, max=4}},
				Esfahan={HIAD=0, MEAD=0, SHORAD={min=2, max=4}},
				Fordow={HIAD=3, MEAD=2, SHORAD={min=2, max=4}},
				Natanz={HIAD=4, MEAD=2, SHORAD={min=2, max=4}}
			},
			moderate = {
				Arak={HIAD=4, MEAD=2, SHORAD={min=3, max=6}},
				Esfahan={HIAD=0, MEAD=0, SHORAD={min=3, max=6}},
				Fordow={HIAD=5, MEAD=3, SHORAD={min=3, max=6}},
				Natanz={HIAD=8, MEAD=4, SHORAD={min=3, max=6}}
			},
			dense = {
				Arak={HIAD=6, MEAD=3, SHORAD={min=4, max=8}},
				Esfahan={HIAD=0, MEAD=0, SHORAD={min=4, max=8}},
				Fordow={HIAD=7, MEAD=4, SHORAD={min=4, max=8}},
				Natanz={HIAD=11, MEAD=5, SHORAD={min=4, max=8}}
			}
		}

		local ADConfig

		local SelectedDensity = string.gsub(form['iran_amount_of_air_defenses'], "%'", "")
		if SelectedDensity == 'iran_amount_of_air_defenses_sparse' then
			ADConfig = IranADConfig.sparse
		elseif SelectedDensity == 'iran_amount_of_air_defenses_moderate' then
			ADConfig = IranADConfig.moderate
		elseif SelectedDensity == 'iran_amount_of_air_defenses_dense' then
			ADConfig = IranADConfig.dense
		else
			local RandomIndex = math.random(1,3)
			ADConfig = (RandomIndex == 1 and IranADConfig.sparse) or (RandomIndex == 2 and IranADConfig.moderate) or IranADConfig.dense
		end

		local ADSites = {
			{name='Arak', positions=6, config=ADConfig.Arak},
			{name='Esfahãn', positions=5, config=ADConfig.Esfahan},
			{name='Fordow', positions=7, config=ADConfig.Fordow},
			{name='Natanz', positions=11, config=ADConfig.Natanz}
		}

		for _, site in ipairs(ADSites) do
			---- Place HIAD (Long-Range SAMs) ----
			if site.config.HIAD > 0 then
				local HIADPositions = GetRandomPositionList(
					'Iran',
					site.name .. ' AD Site',
					site.positions,
					false,
					100,
					site.config.HIAD,
					site.config.HIAD
				)

				AddRandomFacility_FixedPosition('Iran', HIADPositions, SelectedHIAD, 95)
			end

			---- Place MEAD (Medium-Range SAMs) ----

			if site.config.MEAD > 0 then
				local MEADPositions = GetRandomPositionList(
					'Iran',
					site.name .. ' AD Site',
					site.positions,
					true,
					100,
					0,
					site.config.MEAD
				)

				AddRandomFacility_FixedPosition('Iran', MEADPositions, SelectedMEAD, 95)

				local RemainingMEAD = site.config.MEAD - #MEADPositions
				if RemainingMEAD > 0 then
					local AvailablePoints = {}

					for i = 1, site.positions do
						table.insert(AvailablePoints, site.name .. ' AD Site ' .. i)
					end

					for i = #AvailablePoints, 2, -1 do
						local j = math.random(1, i)
						AvailablePoints[i], AvailablePoints[j] = AvailablePoints[j], AvailablePoints[i]
					end

					for i = 1, RemainingMEAD do
						local CenterPoint = ScenEdit_GetReferencePoint({side='Iran', name=AvailablePoints[i]})
						local randomUnit = SelectedMEAD[math.random(1, #SelectedMEAD)]

						AddUnitType_RandomPosition(
							'Iran',
							1,
							100,
							'Facility',
							randomUnit,
							{latitude=CenterPoint.latitude, longitude=CenterPoint.longitude, radius=1.0},
							true,
							0.25,
							95,
							0,
							0,
							nil,
							nil
						)
					end
				end
			end
		end

		---- Delete reference points when no longer needed ----

		-- DeleteReferencePoints_ByName('Iran', 'Arak AD Site', 6)
		-- DeleteReferencePoints_ByName('Iran', 'Fordow AD Site', 7)
		-- DeleteReferencePoints_ByName('Iran', 'Natanz AD Site', 11)

		---- Randomize/Upgrade preplaced SAM sites ----

		local UpgradePreplacedAD = string.gsub(form['iran_upgrade_preplaced_air_defenses'], "%'", "")
		if UpgradePreplacedAD == 'iran_upgrade_preplaced_air_defenses_true' then
			RandomReplaceFacility('Iran', 'Replace', IranSAMsToUpgrade, IranUnitPlacementOrUpgradeChance, 0, 0, SelectedHIAD, 100)
		end

		---- Place SHORAD (Short-Range Air Defenses) ----

		for _, site in ipairs(ADSites) do
			local shoradMin = site.config.SHORAD.min
			local shoradMax = site.config.SHORAD.max
			local numSHORAD = math.random(shoradMin, shoradMax)
			local centerpoint = ScenEdit_GetReferencePoint({side='Iran', name=site.name})

			AddRandomFacility_RandomPosition(
				'Iran',
				numSHORAD,
				100,
				SelectedSHORAD,
				{latitude=centerpoint.latitude, longitude=centerpoint.longitude},
				1,
				95
			)
		end

		-- =========================
		-- Iranian Early Warning Radars
		-- =========================

		local Option = string.gsub(form['iran_upgrade_radars'], "%'", "")
		if Option == 'iran_upgrade_radars_true' then
			local SelectedRadars = SelectedAirDefenseOptions(IranRadars, {
				UseIranDomestic = string.gsub(form["iran_radar_domestic"] or "", "%'", "") == "true",
				UseIranOutdated = string.gsub(form["iran_radar_outdated"] or "", "%'", "") == "true",
				UseChina = string.gsub(form["iran_radar_china"] or "", "%'", "") == "true",
				UseRussia = string.gsub(form["iran_radar_russia"] or "", "%'", "") == "true"
			})

			RandomReplaceFacility('Iran', 'Random', IranRadarsToUpgrade, IranUnitPlacementOrUpgradeChance, 50, 0.25, SelectedRadars, 95)
		end

		-- =========================
		-- Syrian IADS
		-- =========================

		local SelectedOption = string.gsub(form['remove_syria_iads'], "%'", "")
		if SelectedOption == 'remove_syria_iads_true' or PlayerSide == 'United States' then
			ScenEdit_RemoveSide({name='Syria'})
			ScenEdit_SetEvent('Syria Detects Unknown Aircraft', {isActive=false})
		end

		-- =========================
		-- Side Setup
		-- =========================

		SideSetup(PlayerSide)

		if PlayerSide == 'Israel' then
			ScenEdit_SpecialMessage(PlayerSide, '[LOADDOC]IranStrike_Israel_Gameplay_Notes.html[/LOADDOC]')
		elseif PlayerSide == 'United States' then
			ScenEdit_SpecialMessage(PlayerSide, '[LOADDOC]IranStrike_USA_Gameplay_Notes.html[/LOADDOC]')
		else
			ScenEdit_SpecialMessage(PlayerSide, '[LOADDOC]IranStrike_USA-Israel_Gameplay_Notes.html[/LOADDOC]')
		end

		-- =========================
		-- Add USA Aircraft
		-- =========================

		if PlayerSide == 'United States' or PlayerSide == 'United States-Israel' then

			-- =========================
			-- Add USAF Aircraft
			-- =========================

			local EagleCallsigns = {
				'ATARI', 'BADGER', 'BANDIT', 'BARNEY', 'BEACH', 'BILLY', 'BOLO', 'BORON', 'BROODY', 'BUD', 'CAESAR', 'CANNON', 'CASIO', 'CATFISH', 'CHESDA', 'CHOSEN', 'CHUGGS', 'CRAZY', 'DAGGER', 'DANNO', 'DEMO', 'DEMON', 'DILL', 'DISCO', 'DORY', 'EAGLE', 'FRATE', 'FREIGHT', 'GARTH', 'GATOR', 'GIANT', 'GUINESS', 'GUMBY', 'GUNSHOT', 'HATMAN', 'HAVOC', 'HAWK', 'HENDO', 'HOSER', 'HOG', 'HOSER', 'HOWDY', 'JAGS', 'JAVA', 'JAZZ', 'JETHRO', 'JUDGE', 'JUGGS', 'JUICE', 'JUNGLE', 'JUNKER', 'KNIGHT', 'LETHAL', 'LIPS', 'LOBSTA', 'LUCKY', 'LUNAR', 'MACE', 'MACH', 'MAD DOG', 'MAGOO', 'MASTA', 'MISER', 'MOCK', 'MONSTER', 'MONTY', 'MOON', 'MOTLEY', 'MOSUE', 'MYTEE', 'NAIL', 'NASTY', 'NOMAD', 'NOMEX', 'OBI', 'PINBALL', 'PIRATE', 'PLATE', 'POLECAT', 'PSYCHO', 'PYTHON', 'PYRO', 'RATTLER', 'REBEL', 'REHEAT', 'REX', 'RIPPA', 'RIPPER', 'ROOSTER', 'RUDY', 'RUGG', 'SAVAGE', 'SCANDAL', 'SCOUT', 'SHARK', 'SHOCK', 'SHOTGUN', 'SINNER', 'SKULL', 'SLAM', 'SLAY', 'SNAKE', 'SNIFF', 'SNIP', 'SPUNK', 'STRIKE', 'TACO', 'TRILL', 'TROJAN', 'VIPER', 'VOODOO', 'WHICKED', 'WHISKEY', 'WICKED', 'WIDGET', 'ZEKE', 'ZESTY', 'ZORBA'
			}

			local StrikeEagleCallsigns = {
				'ADLER', 'ANIMAL', 'ARGUS', 'ATARI', 'ATTACK', 'BADGER', 'BALLAD', 'BARLEY', 'BLACK', 'BONES', 'BOOT', 'BRAT', 'BREW', 'BUCK', 'BUD', 'BURGER', 'BUTLER', 'CANDOR', 'CARSON', 'CARVER', 'CASINO', 'CHEETAH', 'CHICO', 'CHIEF', 'CIDER', 'COWBOY', 'CRANE', 'DALLAS', 'DEMO', 'EAGLE', 'EVENT', 'FADE', 'FALCON', 'FANGO', 'GATES', 'GOATEE', 'GRUMPY', 'GUINNESS', 'GUNDOG', 'GYPSY', 'HAMMER', 'HOAX', 'HOKIE', 'HOWELR', 'JACKYL', 'JESTER', 'JUNGLE', 'KNIGHT', 'KONG', 'LANCER', 'LIME', 'LION', 'MAD', 'METEOR', 'MIG', 'MOHAWK', 'MOSS', 'MUGGER', 'OLDS', 'ORCA', 'PUEBLO', 'PYRO', 'RACK', 'RAIDER', 'RAMROD', 'RATCH', 'REAPER', 'RED DOG', 'REHEAT', 'RESIST', 'RICO', 'RINGO', 'ROCK', 'ROCKET', 'RUCKUS', 'RUMBLE', 'SABRE', 'SALTY', 'SAPPER', 'SCOUT', 'SEIGE', 'SHIFTY', 'SHOOTER', 'SIEGE', 'SKEET', 'SOCK', 'SONIC', 'STAKE', 'STING', 'STORM', 'STOUT', 'STRIKE', 'SWANK', 'TACKY', 'TEEPEE', 'TERN', 'TREK', 'TRICKY', 'VEDA', 'VESTY', 'WACO', 'WAPPO', 'YOWL', 'ZIPGUN',
			}

			local ViperCallsigns = {
				'BANSHEE', 'BARON', 'BLACK', 'BRONCO', 'BOOKIE', 'CASH', 'CHEROKEE', 'CHICO', 'CITY', 'CLAW', 'CLUB', 'COCHISE', 'CORAL', 'DECK', 'DEFIANT', 'DIXIE', 'DRAGON', 'DUSTY', 'GAMBLER', 'GOMER', 'GRUMP', 'HAMMER', 'HORSE', 'JACKPOT', 'KICK', 'LUCKY', 'MINGO', 'POKER', 'POPPYA', 'RAMBO', 'REBEL', 'RENO', 'ROCK', 'ROYAL', 'RUBBENS', 'RUDE', 'SLOT', 'SOMBRERO', 'SOUPY', 'SPADE', 'SPIKE', 'TABOR', 'TOMMY', 'VEGAS', 'VENOM', 'WEE BEE'
			}

			local RaptorCallsigns = {
				'ACCURA', 'AIRGUN', 'BANDIT', 'BANK', 'BANYAN', 'BIKER', 'BOBCAT', 'BUDDHA', 'BUGSY', 'BULL', 'BUZZY', 'CADE', 'CAJUN', 'CANDOR', 'CAPE', 'CAVE', 'CHAMP', 'CHAPS', 'CHOCK', 'CLAW', 'COACH', 'COBALT', 'COBRA', 'COLONEL', 'CONAN', 'COOP', 'COUPON', 'DEFT', 'DEVIL', 'DEVO', 'DICE', 'DIDDY', 'DODGE', 'DOGWOOD', 'DOOM', 'DRAGON', 'DUFF', 'FANG', 'FEUD', 'FIDDLE', 'FIRE', 'FIRST', 'FLASH', 'FOCUS', 'FRANK', 'FURY', 'FUZZY', 'GATE', 'GAUCHO', 'GHOST', 'GINZU', 'GROUCH', 'HALL', 'HARM', 'HEAT', 'HOBIE', 'HOCUS', 'HOOPER', 'HOTDOG', 'HUNGRY', 'HUSKY', 'HYPO', 'ICEMAN', 'JAKE', 'JAWS', 'JEDI', 'JEEP', 'JOKER', 'JUGGLE', 'KANG', 'KEVLAR', 'KEY', 'KICK', 'KITE', 'KIWI', 'KNIGHT', 'LION', 'MACE', 'MADD DOG', 'MAGIC', 'MAMBA', 'MAUL', 'MICRO', 'MIDAS', 'MILO', 'MONSTER', 'NICE', 'NICKEL', 'NOBLE', 'OXEN', 'PECOS', 'PINTO', 'PISTOL', 'POKE', 'POKER', 'POPPY', 'PSYCHO', 'RACK', 'RAGS', 'RAMBO', 'RAPID', 'RAPTOR', 'RASTER', 'RATS', 'REBEL', 'RECAP', 'RIDER', 'RINGO', 'RISKEY', 'ROACH', 'ROCKET', 'ROCKY', 'RODEO', 'ROGUE', 'ROUGE', 'RUBY', 'RUCKUS', 'RUMBLE', 'RUST', 'SALTY', 'SAVAGE', 'SCOUT', 'SCUBA', 'SINNER', 'SLUG', 'SMART', 'SNIPER', 'SOCKS', 'SPAD', 'SPEEDO', 'SPUR', 'STEER', 'STOMP', 'STUMP', 'TACO', 'TANG', 'THREAD', 'TOBY', 'TONTO', 'TOP DOG', 'TOPDOG', 'TOTEM', 'TRAP', 'TRIGGER', 'TRITON', 'TROJAN', 'VANDAL', 'VAPOR', 'VEGAS', 'VELCRO', 'VICE', 'VIKING', 'VIPER', 'VOODOO', 'WASP', 'WOLF', 'YAMAHA', 'YODA', 
			}

			local LightningCallsigns = {
				'AIRGUN', 'ASGARD', 'AXE', 'BAND', 'BANSHEE', 'BEAK', 'BEER', 'BONSI', 'CAJUN', 'CASTLE', 'CHAIN', 'CHARIOT', 'COLD', 'COLT', 'CORVETTE', 'DAGGER', 'FUJIN', 'FREYJA', 'GAINER', 'GATOR', 'GREEN', 'GRUMPY', 'HARLEY', 'HELLA', 'ICEMAN', 'IGUANA', 'JASPER', 'JEDI', 'LORD', 'NIKE', 'NORSE', 'PHANTOM', 'POWER', 'RACE', 'RAGNAR', 'RAM', 'RIM', 'ROMAN', 'RUDE', 'SHIELD', 'SPIDER', 'SPIKE', 'TUNE', 'VALKYRIE', 'VALOR', 'VENOM', 'VIKING', 'VIPER', 'WHISKEY', 'WIDOW', 'YUCCA', 
			}

			local LancerCallsigns = {
				'BAT', 'BONE', 'CHISEL', 'DARK', 'DRAGON', 'EAGLE', 'FELON', 'FOIL', 'FURY', 'HAWK', 'HYPER', 'KISKA', 'NITER', 'OCCULT', 'PESKY', 'PILOT', 'PUMA', 'PYOTE', 'RAMA', 'RAMBO', 'RAZOR', 'REAPER', 'SLAM', 'SLAYER', 'SLIP', 'SPIDER', 'STRAT', 'TEX', 'THUNDER', 'TIGER', 'TIMON', 'TITUS', 'TRAVEL', 'VAMPIRE', 'YARD', 
			}
			
			local SpiritCallsigns = {
				'ARBY', 'BATT', 'BEAVER', 'BLURB', 'BROCK', 'BUNCH', 'CARLO', 'CHAOS', 'DARTH', 'DEATH', 'FLOYD', 'FURY', 'GELD', 'GEOD', 'GERT', 'GHOST', 'HAMMER', 'JUICY', 'KONG', 'LINDY', 'MANDY', 'MISTY', 'MUDDY', 'PERCO', 'REAPER', 'ROCKY', 'SARO', 'SLAYER', 'SPIRIT', 'TIGER', 'TORCH', 'WONDA', 'ZETA'
			}

			local BUFFCallsigns = {
				'BETH', 'BREW', 'BRIG', 'BUFF', 'CAPOA', 'CASE', 'CASINO', 'CHAOS', 'CHIEF', 'CHILL', 'CLAW', 'COMAL', 'CONNER', 'CREOLE', 'DEMO', 'DEUCE', 'DOOM', 'DUECE', 'ELGIN', 'FEAR', 'FORAY', 'FROST', 'GORGON', 'GEMLIN', 'GRIM', 'HAMMER', 'HATE', 'HAVOC', 'HORSE', 'ICER', 'IDOL', 'JAMBO', 'JENNY', 'LEMAY', 'LISA', 'LOBO', 'MACK', 'MIGHTEE', 'NOBLE', 'NODE', 'NOSTER', 'PLUNDER', 'QUIZ', 'ROGUE', 'SKULL', 'SLAYER', 'STORM', 'TRIBE', 'TYSON', 'VENGER', 'WARBIRD', 'ZEUS', 'ZOOM'
			}

			local HawkeyeCallsigns = {
				'BERET', 'FIREBIRD', 'GOLDEN HAWK', 'NIGHTHAWK', 'SEABAT', 'SLUG', 'STEELJAW', 'WOLF'
			}

			local GrowlerCallsigns = {
				'GARDUA', 'LANCER', 'RAMPAGE', 'RAVEN', 'SCORPION', 
			}

			local CompassCallCallsigns = {
				'AXIOS', 'BAT', 'BETA', 'BOOKSHELF', 'CHISUM', 'COMBO', 'CREECH', 'DEWEY', 'DOZER', 'FAZE', 'FLITE', 'GROUT', 'HEWY', 'HIND', 'HULK', 'JOHN', 'LANG', 'LOUIE', 'MURK', 'OX', 'PABLO', 'PAGUS', 'RILEY', 'SHOE', 'STALK', 'STEP', 'TOXIC', 'TRIM', 'TRON', 'TULLY', 'VOLT', 'ZAPPER'
			}

			local TransportCallsigns = {
				'AMOR', 'ANZAC', 'CADDO', 'CARP', 'COHO', 'GEORGE', 'GRUP', 'HARD', 'HIRE', 'HUSKY', 'IMPACT', 'KITSAP', 'MOOSE', 'NANCY', 'RALEIGH', 'RAWLY', 'ROUGE', 'SKAGIT', 'SONIC', 'STORK', 'SWAM', 'TICA', 'TONG', 'TRUCK'
			}

			local PredatorCallsigns = {
				'ANGRY BIRD', 'APEX', 'COBRA', 'GHOST', 'HELLHOUND', 'HUNTER', 'MARAUDER', 'PIGEON', 'PREDATOR', 'PYTHON', 'REAPER', 'SUNSET', 'TIGER', 'WARRIOR', 'WILDCAT'
			}


			local AirBases = {
				{side='usa', number=1, name='Prince Sultan AB'},
				{side='usa', number=2, name='Al Udeid AB'},
				{side='usa', number=3, name='Al Dhafra AB'},
				{side='usa', number=4, name='Diego Garcia'},
				{side='usa', number=5, name='Ali Al Salem AB'},
				{side='usa', number=6, name='Muwaffaq Salti AB'},
				{side='usa', number=7, name='Ben Gurion Airport'},
				{side='usa', number=8, name='Ovda AB'},
				{side='usa', number=9, name='Off Map Bases (Western Europe and CONUS)'},
				{side='usa', number=10, name='Off Map Bases (Northern Europe)'},
				
			}

			local kc46aFlightNum
			local kc135rFlightNum = 29

			local f15eDBID = 3222 -- F-15E Strike Eagle - United States, 2018
			local fa18eDBID = 3829 -- F/A-18E Super Hornet Blk II - United States, 2019
			local fa18fDBID = 3828 -- F/A-18F Super Hornet Blk II - United States, 2019
			local f22aDBID = 5952 -- F-22A Raptor - United States, 2021
			local f35aDBID = 3498 -- F-35A Lightning II - United States, 2018
			local f35cDBID = 824 -- F-35C Lightning II - United States, 2019
			local b1bDBID = 7738 -- B-1B Lancer - United States, 2019
			local b1rDBID = 7785 -- B-1R Lancer - United States, 2019
			local b2aDBID = 4326 -- B-2A Spirit - United States, 2023, Blk 30
			local e2dDBID = 4293 -- E-2D Advanced Hawkeye - United States, 2021
			local ea18gDBID = 343 -- EA-18G Growler - United States, 2015
			local RescueSqn = 1
			local hc130DBID = 7803 -- HC-130J Combat King II - United States, 2023
			local mc130DBID = 5630 -- MC-130J Commando II - United States, 2022
			local hh60DBID = 7825 -- HH-60G Pave Hawk - United States, 2020
			local hh60LoadoutID = 35507

			if ScenarioYear() == 'mid2020' then
				kc46aFlightNum = 11
				kc135rFlightNum = 23

				f15eDBID = 5456 -- F-15E Strike Eagle - United States, 2022
				fa18eDBID = 5258 -- F/A-18E Super Hornet Blk II - United States, 2025
				fa18fDBID = 5257 -- F/A-18F Super Hornet Blk II - United States, 2025
				f35aDBID = 3497 -- F-35A Lightning II - United States, 2026, Blk 4 Lot 15+
				f35cDBID = 4873 -- F-35C Lightning II - United States, 2026, Blk 4 Lot 15+
				b1bDBID = 4909 -- B-1B Lancer - United States, 2026
				b1rDBID = 5830 -- B-1R Lancer - United States, 2024
				b2aDBID = 7744 -- B-2A Spirit - United States, 2025, Blk 30
				e2dDBID = 7114 -- E-2D Advanced Hawkeye - United States, 2023
				ea18gDBID = 4518 -- EA-18G Growler - United States, 2025
				hc130DBID = 7804 -- HC-130J Combat King II - United States, 2026
				hh60DBID = 4366 -- HH-60W Jolly Green II - United States, 2022
				hh60LoadoutID = 35878
			elseif ScenarioYear() == 'late2020' then
				kc46aFlightNum = 23
				kc135rFlightNum = 11

				f15eDBID = 7819 -- F-15E Strike Eagle - United States, 2025
				fa18eDBID = 7281 -- F/A-18E Super Hornet Blk III - United States, 2024
				fa18fDBID = 7283 -- F/A-18F Super Hornet Blk III - United States, 2024
				f22aDBID = 4875 -- F-22A Raptor - United States, 2027
				f35aDBID = 3835 -- F-35A Lightning II - United States, 2026, Blk 4 Lot 17+
				f35cDBID = 4874 -- F-35C Lightning II - United States, 2026, Blk 4 Lot 17+
				b1bDBID = 6426 -- B-1B Lancer - United States, 2026, ARRW
				b2aDBID = 5450 -- B-2A Spirit - United States, 2030, Blk 30
				e2dDBID = 6992 -- E-2D Advanced Hawkeye - United States, 2029
				ea18gDBID = 7572 -- EA-18G Growler - United States, 2027
				hc130DBID = 7805 -- HC-130J Combat King II - United States, 2030
				mc130DBID = 7821 -- MC-130J Commando II - United States, 2030
				hh60DBID = 7862 -- HH-60W Jolly Green II - United States, 2030
				hh60LoadoutID = 35878
			end

			local AircraftTypes = {
				{input='f15c', type='Fighter', numAicraft=12, dbid=7799, callsign=EagleCallsigns},
				{input='f15e', type='Fighter', numAicraft=12, dbid=f15eDBID, callsign=StrikeEagleCallsigns},
				{input='f15ex', type='Fighter', numAicraft=12, dbid=4771, callsign=EagleCallsigns},
				{input='f16c', type='Fighter', numAicraft=12, dbid=5640, callsign=ViperCallsigns},
				{input='f22a', type='Fighter', numAicraft=12, dbid=f22aDBID, callsign=RaptorCallsigns},
				{input='f35a', type='Fighter', numAicraft=12, dbid=f35aDBID, callsign=LightningCallsigns},
				{input='fqxx', type='CCA', numAicraft=12, dbid=4773},
				{input='b1b', type='Bomber', numAicraft=6, dbid=b1bDBID, callsign=LancerCallsigns},
				{input='b1r', type='Bomber', numAicraft=6, dbid=b1rDBID, callsign=LancerCallsigns},
				{input='b2a', type='Bomber', numAicraft=3, dbid=b2aDBID, callsign=SpiritCallsigns},
				{input='b21a', type='Bomber', numAicraft=3, dbid=6158},
				{input='b21r', type='Bomber', numAicraft=3, dbid=6748},
				{input='b52h', type='Bomber', numAicraft=6, dbid=4893, callsign=BUFFCallsigns},
				{input='b52j', type='Bomber', numAicraft=6, dbid=5386, callsign=BUFFCallsigns},
				{input='e2d', type='AEW', numAicraft=5, dbid=e2dDBID, callsign=HawkeyeCallsigns, loadoutid=14629},
				{input='e3g', type='AEW', numAicraft=4, dbid=7739, callsign='SENTRY', loadoutid=8076},
				{input='e7a', type='AEW', numAicraft=4, dbid=5436, callsign='SENTRY', loadoutid=8086},
				{input='ea18g', type='Electronic Warfare', numAicraft=7, dbid=ea18gDBID, callsign=GrowlerCallsigns},
				{input='ea37', type='Electronic Warfare', numAicraft=4, dbid=4883, callsign=CompassCallCallsigns, loadoutid=27372},
				{input='ec130h', type='Electronic Warfare', numAicraft=4, dbid=4911, callsign=CompassCallCallsigns, loadoutid=14471},
				{input='kc10a', type='Tanker', numAicraft=6, flightNum=23, dbid=7704, callsign='TEXACO', loadoutid=8989},
				{input='kc46a', type='Tanker', numAicraft=6, flightNum=kc46aFlightNum, dbid=6620, callsign='EXXON', loadoutid=32851},
				{input='kc135r', type='Tanker', numAicraft=6, flightNum=kc135rFlightNum, dbid=7712, callsign='SHELL', loadoutid=32850},
				{input='c17a', type='Transport', numAicraft=4, callsign=TransportCallsigns},
				{input='rescuesqn', type='Rescue', numAicraft=1},
				{input='mq9a', type='UAV', numAicraft=12, dbid=5595, callsign=PredatorCallsigns},
				{input='rq4b', type='UAV', numAicraft=4, dbid=2848, callsign='HAWK', loadoutid=13988},
				{input='rq170a', type='UAV', numAicraft=4, dbid=2787, callsign='SENTINEL', loadoutid=13408},
				{input='rq180', type='UAV', numAicraft=4, dbid=4328, callsign='WRAITH', loadoutid=22066},
				{input='lucasARM', type='OWA', numAicraft=1, dbid=4462},
				{input='lucasEOIR', type='OWA', numAicraft=1, dbid=4464}
			}

			for _, base in ipairs(AirBases) do
				local basingAllowedString = NormalizeString(form[base.side..'_air_base_'..base.number..'_basing_allowed'], "TRUE")
				local basingAllowed = ConvertStringToBoolean(basingAllowedString)

				if basingAllowed then
					-- Deploy aircraft if basing is allowed
					for _, aircraft in ipairs(AircraftTypes) do
						local numSquadrons = (tonumber(form[base.side..'_air_base_'..base.number..'_'..aircraft.input]) or 0) / aircraft.numAicraft
						for i = 1, numSquadrons do
							local Callsign
							if aircraft.type == 'Fighter' then
								Callsign = RandomCallsign(aircraft.callsign)
								AddAircraft(PlayerSide, 11, 22, aircraft.dbid, Callsign..' ', base.name, 3, 0)
							elseif  aircraft.type == 'CCA' then
								if math.random(1,100) <= 70 then
									if #ViperCallsigns > 0 then
										Callsign = RandomCallsign(ViperCallsigns)
									else
										Callsign = RandomCallsign(EagleCallsigns)
									end
								else
									if #EagleCallsigns > 0 then
										Callsign = RandomCallsign(EagleCallsigns)
									else
										Callsign = RandomCallsign(ViperCallsigns)
									end
								end

								AddAircraft(PlayerSide, 11, 22, aircraft.dbid, Callsign..' ', base.name, 3, 0)
							elseif aircraft.type == 'Bomber' then
								if aircraft.input == 'b21a' or aircraft.input == 'b21r' then
									if math.random(1,100) <= 70 then
										if #LancerCallsigns > 0 then
											Callsign = RandomCallsign(LancerCallsigns)
										else
											Callsign = RandomCallsign(SpiritCallsigns)
										end
									else
										if #SpiritCallsigns > 0 then
											Callsign = RandomCallsign(SpiritCallsigns)
										else
											Callsign = RandomCallsign(LancerCallsigns)
										end
									end
								else
									Callsign = RandomCallsign(aircraft.callsign)
								end

								AddAircraft(PlayerSide, 11, 16, aircraft.dbid, Callsign..' ', base.name, 3, 0)
							elseif  aircraft.type == 'AEW' then
								local NumAircraft_1 = 11
								local NumAircraft_2 = 14

								if aircraft.input == 'e2d' then
									Callsign = RandomCallsign(aircraft.callsign)
									NumAircraft_1 = 600
									NumAircraft_2 = 604
								else
									Callsign = aircraft.callsign
								end

								AddAircraft(PlayerSide, NumAircraft_1, NumAircraft_2, aircraft.dbid, Callsign..' ', base.name, aircraft.loadoutid, 0)
							elseif  aircraft.type == 'Electronic Warfare' then
								local NumAircraft_1 = 11
								local NumAircraft_2 = 14
								Callsign = RandomCallsign(aircraft.callsign)
								local LoadoutID = aircraft.loadoutid

								if aircraft.input == 'ea18g' then
									NumAircraft_1 = 500
									NumAircraft_2 = 506
									LoadoutID = 3
								end

								AddAircraft(PlayerSide, NumAircraft_1, NumAircraft_2, aircraft.dbid, Callsign..' ', base.name, LoadoutID, 0)
							elseif aircraft.type == 'Tanker' then
								local numTankers = aircraft.flightNum + 5
								AddAircraft(PlayerSide, aircraft.flightNum, numTankers, aircraft.dbid, aircraft.callsign..' ', base.name, aircraft.loadoutid, 0)
								aircraft.flightNum = numTankers + 1
							elseif aircraft.type == 'Transport' then
								Callsign = RandomCallsign(aircraft.callsign)
								AddAircraft(PlayerSide, 11, 14, 7775, Callsign..' ', base.name, 29992, 0)
							elseif aircraft.type == 'Rescue' then
								if RescueSqn == 1 then
									AddAircraft(PlayerSide, 11, 14, hc130DBID, 'CROWN ', base.name, 33383, 0) -- Add 4 x HC-130J Combat King II
									AddAircraft(PlayerSide, 21, 28, hh60DBID, 'JOLLY ', base.name, hh60LoadoutID, 0) -- Add 8 x HH-60G Pave Hawk or HH-60W Jolly Green II
									AddAircraft(PlayerSide, 31, 34, mc130DBID, 'ASHER ', base.name, 8364, 0) -- Add 4 x MC-130J Commando II
									RescueSqn = 2
								elseif RescueSqn == 2 then
									AddAircraft(PlayerSide, 11, 14, hc130DBID, 'KING ', base.name, 33383, 0) -- Add 4 x HC-130J Combat King II
									AddAircraft(PlayerSide, 21, 28, hh60DBID, 'PEDRO ', base.name, hh60LoadoutID, 0) -- Add 8 x HH-60G Pave Hawk or HH-60W Jolly Green II
									AddAircraft(PlayerSide, 11, 14, mc130DBID, 'BROKE ', base.name, 8364, 0) -- Add 4 x MC-130J Commando II
								end
							elseif aircraft.type == 'UAV' then
								local NumAircraft = 11 + (aircraft.numAicraft - 1)
								local LoadoutID = aircraft.loadoutid or 3

								if aircraft.input == 'mq9a' then
									Callsign = RandomCallsign(aircraft.callsign)
								else
									Callsign = aircraft.callsign
								end

								AddAircraft(PlayerSide, 11, NumAircraft, aircraft.dbid, Callsign..' ', base.name, LoadoutID, 0)
							elseif aircraft.type == 'OWA' then
								local baseGUID = ScenEdit_GetUnit({side=PlayerSide, name=base.name}).guid

								for i =1,3 do
									ScenEdit_UpdateUnit({guid=baseGUID, mode='add_mount', dbid=aircraft.dbid, arc_mount={'360'}})
								end
							end
						end
					end
				else
					-- Delete air base if basing is not allowed
					ScenEdit_DeleteUnit({side=PlayerSide, name=base.name})
				end
			end

			-- =========================
			-- Add US Navy Carriers and Aircraft
			-- =========================

			carrierList={
				[1] = {
					name='USS Harry S. Truman (CVN-75)',
					dbid=3556,
					latitude=22.0,
					longitude=64.0,
					squadronData={
						{index=1, name='RIPPER ', modex=100},
						{index=2, name='TAPROOM ', modex=200},
						{index=3, name='SUNLINER ', modex=300},
						{index=4, name='GUNSTAR ', modex=400},
						{index=5, name='MILESTONE ', modex=500},
						{index=6, name='CLOSEOUT ', modex=600},
						{index=7, name='BAT DET. 1', modex=700}
					}
				},
				[2] = {
					name='USS Abraham Lincoln (CVN-72)',
					dbid=3553,
					latitude=21.9784960054684,
					longitude=63.9725262250931,
					squadronData={
						{index=1, name='DEALER ', modex=100},
						{index=2, name='CAMELOT ', modex=200},
						{index=3, name='KNIGHT ', modex=300},
						{index=4, name='UGLY ', modex=400},
						{index=5, name='MAGIC ', modex=500},
						{index=6, name='BANGER ', modex=600},
						{index=7, name='ELEVEN DET. 1', modex=700}
					}
				},
				[3] = {
					name='USS Gerald R. Ford (CVN-78)',
					dbid=3559,
					latitude=22.04345135009,
					longitude=64.0269106066446,
					squadronData={
						{index=1, name='LION ', modex=200},
						{index=2, name='BULL ', modex=100},
						{index=3, name='FELIX ', modex=300},
						{index=4, name='WAR PARTY ', modex=400},
						{index=5, name='GRIM ', modex=500},
						{index=6, name='BEAR ', modex=600},
						{index=7, name='BAT DET. 2', modex=700}
					}
				},
				[4] = {
					name='USS Carl Vinson (CVN-70)',
					dbid=3551,
					latitude=21.9677422627239,
					longitude=64.0412075587112,
					squadronData={
						{index=1, name='BULLET ', modex=100},
						{index=2, name='STING ', modex=200},
						{index=3, name='JURY ', modex=300},
						{index=4, name='HAWK ', modex=400},
						{index=5, name='IRON ', modex=500},
						{index=6, name='BLACK EAGLE ', modex=600},
						{index=7, name='ELEVEN DET. 2', modex=700}
					}
				}
			}

			airwingConfigs={
				[1] = {
					{index=1, dbid=fa18fDBID, count=12}, -- 12x F/A-18F Super Hornet
					{index=2, dbid=fa18eDBID, count=12}, -- 12x F/A-18E Super Hornet
					{index=3, dbid=fa18eDBID, count=12}, -- 12x F/A-18E Super Hornet
					{index=4, dbid=fa18eDBID, count=12}, -- 12x F/A-18E Super Hornet
					{index=5, dbid=ea18gDBID, count=7}, -- 7x EA-18G Growler
					{index=6, dbid=e2dDBID, count=5}, -- 5x E-2D Advanced Hawkeye
					-- MQ-25A Detachment added separately depending on year
				},
				[2] = {
					{index=1, dbid=fa18fDBID, count=12}, -- 12x F/A-18F Super Hornet
					{index=2, dbid=fa18eDBID, count=12}, -- 12x F/A-18E Super Hornet
					{index=3, dbid=f35cDBID, count=10}, -- 10x F-35C Lightning II
					{index=4, dbid=fa18eDBID, count=12}, -- 12x F/A-18E Super Hornet
					{index=5, dbid=ea18gDBID, count=7}, -- 7x EA-18G Growler
					{index=6, dbid=e2dDBID, count=5}, -- 5x E-2D Advanced Hawkeye
					-- MQ-25A Detachment added separately depending on year
				},
				[3] = {
					{index=1, dbid=fa18fDBID, count=14}, -- 14x F/A-18F Super Hornet
					{index=2, dbid=fa18eDBID, count=14}, -- 14x F/A-18E Super Hornet
					{index=3, dbid=f35cDBID, count=20}, -- 20x F-35C Lightning II
					-- Index 4 intentionally skipped
					{index=5, dbid=ea18gDBID, count=7}, -- 7x EA-18G Growler
					{index=6, dbid=e2dDBID, count=5}, -- 5x E-2D Advanced Hawkeye
					-- MQ-25A Detachment added separately depending on year
				}
			}

			-- Extract the number of carriers from the HTML form input
			local NumCarriersEarly2020 = tonumber(form['usa_naval_deployment_1_carriers_early2020']) or 0
			local NumCarriersMid2020 = tonumber(form['usa_naval_deployment_1_carriers_mid2020']) or 0
			local NumCarriersLate2020 = tonumber(form['usa_naval_deployment_1_carriers_late2020']) or 0

			-- Deploy the carrier with the selected airwing configuration
			AddCarrierWithAirwing(PlayerSide, NumCarriersEarly2020, NumCarriersMid2020, NumCarriersLate2020)
			ScenEdit_AssignUnitToMission('TU 50.1.1', 'CSG Patrol')

			if SearchAndRescueEnabled() then
				local ShipList = {
					{side='Task Force 50', name='USS Harry S. Truman (CVN-75)', modexStart=610, modexEnd=614, squadronName='SLAYER ', aircraftDBID=5337, loadoutid=25707}, -- 5x MH-60S Seahawk
					{side=PlayerSide, name='USS Cole (DDG-67)', modexStart=700, modexEnd=700, squadronName='WARRIOR ', aircraftDBID=5338, loadoutid=27986}, -- 1x MH-60R Seahawk
					{side=PlayerSide, name='USS Bainbridge (DDG-96)', modexStart=701, modexEnd=701, squadronName='WARRIOR ', aircraftDBID=5338, loadoutid=27986}, -- 1x MH-60R Seahawk
					{side=PlayerSide, name='USS Gravely (DDG-107)', modexStart=702, modexEnd=702, squadronName='WARRIOR ', aircraftDBID=5338, loadoutid=27986}, -- 1x MH-60R Seahawk
					{side=PlayerSide, name='USS Jason Dunham (DDG-109)', modexStart=703, modexEnd=703, squadronName='WARRIOR ', aircraftDBID=5338, loadoutid=27986}, -- 1x MH-60R Seahawk
				}

				for _, ship in ipairs(ShipList) do
					if ScenEdit_GetUnit({side=ship.side, name=ship.name}) ~= nil then
						AddAircraft(PlayerSide, ship.modexStart, ship.modexEnd, ship.aircraftDBID, ship.squadronName, ship.name, ship.loadoutid, 0)
					end
				end
			end
		end
	end
end


-- Scenario Lua init 4 script

math.randomseed(os.time())
math.random()
-- Tool_EmulateNoConsole()

function CivilianAirTraffic()
	local missionList = {}

	local airports = {
		{name='Tehran (1st TAB)', guid='Z8XE7U-0HMDTJ2EVCSEM'},
		{name='Tabriz (2nd TAB)', guid='Z8XE7U-0HMDTJ2EVCKPQ'},
		{name='Dezful (4th TAB)', guid='Z8XE7U-0HMDTJ2EVC1HT'},
		{name='Shiraz (7th TAB)', guid='Z8XE7U-0HMDTJ2EVCI6B'},
		{name='Esfahãn (8th TAB)', guid='Z8XE7U-0HMDTJ2EVC6E4'},
		{name='Bandar Abbas (9th TAB)', guid='Z8XE7U-0HMDTJ2EVBOME'},
		{name='Chabahar (10th TAB)', guid='Z8XE7U-0HMDTJ2EVBUCE'},
		{name='Mashhad (14th TAB)', guid='Z8XE7U-0HMDTJ2EVCE99'},
	}

	local aircraft = {
		{dbid=2426, ferryRange=4500, loadoutid=9923}, -- Airbus A.310-300
		{dbid=2545, ferryRange=3600, loadoutid=9958}, -- Airbus A.319-100
		{dbid=2548, ferryRange=3200, loadoutid=9954}, -- Airbus A.320-200
		{dbid=2549, ferryRange=3000, loadoutid=9952}, -- Airbus A.321-200
		{dbid=2428, ferryRange=7250, loadoutid=9926}, -- Airbus A.330-200
		{dbid=2593, ferryRange=715, loadoutid=10128}, -- ATR-72-200
		{dbid=2591, ferryRange=715, loadoutid=10125}, -- ATR-72-500
		{dbid=5499, ferryRange=715, loadoutid=30083}, -- ATR-72-600
		{dbid=3966, ferryRange=1960, loadoutid=19891}, -- Boeing 737-400
		{dbid=4021, ferryRange=1325, loadoutid=20041}, -- F.100 [Tay 650]
		{dbid=4055, ferryRange=2050, loadoutid=20158}, -- MD-82
		{dbid=4056, ferryRange=2500, loadoutid=20160}, -- MD-83
	}

	local function ReturnFerryRangeFromGUID(aircraftGUID)
		local result
		local unit = ScenEdit_GetUnit({guid = aircraftGUID})
		for k, v in ipairs(aircraft) do
			if unit.dbid == v.dbid then
				result = v.ferryRange
			end
		end
		return result
	end

	local function ReturnFerryRangeFromDBID(aircraftDBID)
		local result
		for k, v in ipairs(aircraft) do
			if aircraftDBID == v.dbid then
				result = v.ferryRange
			end
		end
		return result
	end

	local function GenerateListOfPossibleDestinations_GUID(aircraftGUID)
		local unit = ScenEdit_GetUnit({guid = aircraftGUID})
		local safeRange = ReturnFerryRangeFromGUID(aircraftGUID) * 0.8
		local result = {}
		for k, v in ipairs(airports) do
			local tripDistance = Tool_Range(aircraftGUID, v.guid)
			if tripDistance < safeRange then
				local tableEntry = {name = v.name, guid = v.guid, range = tripDistance}
				table.insert(result, tableEntry)
			end
		end
		return result
	end

	local function GenerateListOfPossibleDestinations_ByRange(safeRange, aircraftGUID)
		local unit = ScenEdit_GetUnit({guid=aircraftGUID})
		local result = {}
		for k, v in ipairs(airports) do
			local tripDistance = Tool_Range(aircraftGUID, v.guid)
			if tripDistance < safeRange then
				local tableEntry = {name=v.name, guid=v.guid, range=tripDistance}
				table.insert(result, tableEntry)
			end
		end
		return result
	end

	local function SortListOfAirportsByRange(airportTable)
		local rangeTable, result = {}, {}
		for k, v in ipairs(airportTable) do
			table.insert(rangeTable, v.range)
		end
		table.sort(rangeTable)
		for i = #rangeTable, 1, -1 do
			rangeValue = rangeTable[i]
			for key, value in ipairs(airportTable) do
				if value.range == rangeValue then
					table.insert(result, value)
				end
			end
		end
		return result
	end

	local function ChooseOneOfFurthestDestinations(airportTable)
		local airportTable = SortListOfAirportsByRange(airportTable)
		local tableLength = #airportTable
		if tableLength > 3 then
			tableLength = 3
		end
		local result = airportTable[math.random(1, tableLength)]
		return result
	end

	local function ThisFerryMissionExists(missionName)
		local result = false
		for k, v in ipairs(missionList) do
			if v == missionName then
				return true
			end
		end
		return false
	end

	local function AddMissionToList(missionName)
		table.insert(missionList, missionName)
	end

	local function GenerateFerryMission(destinationName)
		local mission
		if ThisFerryMissionExists(destinationName) then
			mission = ScenEdit_GetMission('Civilian', destinationName)
		else
			mission = ScenEdit_AddMission('Civilian', destinationName, 'ferry', {destination=destinationName})
			ScenEdit_SetMission('Civilian', mission.guid, {FerryBehavior='Cycle', flightSize=1})
			AddMissionToList(mission.name)
		end
		return mission
	end

	local function CreateMissionAndAssignAircraft_Random(aircraftGUID)
		local airportTable = GenerateListOfPossibleDestinations_GUID(aircraftGUID)
		local destinationName = ChooseOneOfFurthestDestinations(airportTable).name
		Tool_EmulateNoConsole()
		GenerateFerryMission(destinationName)
		ScenEdit_AssignUnitToMission(aircraftGUID, destinationName)
	end

	local function CreateMissionAndAssignAircraft(aircraftGUID, destinationName)
		Tool_EmulateNoConsole()
		local mission = GenerateFerryMission(destinationName)
		ScenEdit_AssignUnitToMission(aircraftGUID, destinationName)
		return mission
	end

	local function RandomAirline()
		local airline = {'IRA', 'IRC', 'IZG', 'IRK', 'IRQ', 'IRM', 'TBZ', 'TBM', 'CPN', 'IRG', 'SHI', 'VRH', 'FPI', 'PRS', 'QFZ'}
		return string.upper(airline[math.random(1,#airline)])
	end

	local function GenerateRandomAircraftName()
		local result
		local flightNumber = math.random(10,2000)
		result = RandomAirline()..flightNumber
		return result
	end

	local function ReturnRandomAircraftEntry()
		return aircraft[math.random(1, #aircraft)]
	end

	local function NameIsADuplicate(nameString)
		Tool_EmulateNoConsole()
		local unit = ScenEdit_GetUnit({side='Civilian', name=nameString})
		if unit == nil then
			return true
		else
			return false
		end
	end

	local function RandomiseReadyTime(aircraftGUID)
		local unit = ScenEdit_GetUnit({guid=aircraftGUID})
		ScenEdit_SetUnit({
				unitName=unit.guid,
				TimeToReady_Minutes=math.random(0,60)
			})
	end

	local function RandomiseTransponder(aircraftGUID)
		local unit = ScenEdit_GetUnit({guid=aircraftGUID})
		setAutodetectable = math.random(1,100)
		if setAutodetectable <= 95 then
			ScenEdit_SetUnit({
				unitName=unit.guid,
				autodetectable=true
			})
		end
	end

	local function GenerateAircraft()
		local error_Count = 0
		::redoGenerateAircraft::
		local aircraft = ReturnRandomAircraftEntry()
		local homebase = nil
		local homebaseList = airports

		homebase = homebaseList[math.random(1, #homebaseList)]

		local destination, destinationList

		local safeRange = ReturnFerryRangeFromDBID(aircraft.dbid)
		destinationList = GenerateListOfPossibleDestinations_ByRange(safeRange, homebase.guid)
		destination = ChooseOneOfFurthestDestinations(destinationList)

		local unit =
			ScenEdit_AddUnit({
				side='Civilian',
				type='Aircraft',
				dbid=aircraft.dbid,
				name=GenerateRandomAircraftName(),
				base=homebase.name,
				loadoutid=aircraft.loadoutid
			})

		RandomiseReadyTime(unit.guid)
		RandomiseTransponder(unit.guid)

		CreateMissionAndAssignAircraft(unit.name, destination.name)

		local result = ScenEdit_GetUnit({guid=unit.guid})
		return result
	end

	for i = 1,20 do
		GenerateAircraft()
	end
end


-- Scenario Lua init 5 script

ScenEdit_RunScript('DeveloperMode.lua')

math.randomseed(os.time())
math.random()

-- =====================================
-- Set and Restore Scenario Variables --
-- =====================================

-- =========================
-- Set Variables on Scenario Load
-- =========================

function InitializeGlobalVariables()
	local GlobalVariables = {
		{name='PlayerNumbeOfUnitsDestroyed', value=0, persist=true},
		{name='PlayerCyberChance', value=0, persist=true},
		{name='PlayerCyberChanceDecrement', value=0, persist=true},

		{name='IranNumberOfAircraftDetected', value=0, persist=true},
		{name='IranResetCommandAndControlCounter', value=0, persist=true},
		{name='IranResetCommandAndControlChance', value=30, persist=true},
		{name='IranResetCommandAndControlTime', value=60, persist=true},
		{name='IranResetCommunicationsCounter', value=0, persist=true},
		{name='IranResetCommunicationsChance', value=30, persist=true},
		{name='IranResetCommunicationsTime', value=60, persist=true},
		{name='IranResetSensorsCounter', value=0, persist=true},
		{name='IranResetSensorsChance', value=30, persist=true},
		{name='IranResetSensorsTime', value=60, persist=true},

		{name='SyriaNumberOfAircraftDetected', value=0, persist=true}
	}

	for _, var in ipairs(GlobalVariables) do
		_G[var.name] = var.value
		if var.persist then
			ScenEdit_SetKeyValue(var.name, tostring(var.value))
		end
	end

	-- =========================
	-- Initialize Tables
	-- =========================

	IranDisruptedCommandAndControlUnitList = {}
	IranDisruptedCommunicationsUnitList = {}
	IranFalseContactsList = {}

	storeData(IranDisruptedCommandAndControlUnitList, 'IranDisruptedCommandAndControlUnitListKey')
	storeData(IranDisruptedCommunicationsUnitList, 'IranDisruptedCommunicationsUnitListKey')
	storeData(IranFalseContactsList, 'IranFalseContactsListKey')

	-- =========================
	-- Tables that are only needed during scenario setup
	-- =========================

	IranAircraftToUpgrade_1 = {
		{num1=1, num2=12, name='31 TFS #'}, -- F-4E Phantom II
		{num1=1, num2=12, name='41 TFS #'}, -- F-5E Tiger II
		{num1=1, num2=12, name='43 TFS #'}, -- F-5F Tiger II
		{num1=1, num2=6, name='51 TFS #'}, -- F-7N Fishcan [MiG-21 Copy]
		{num1=1, num2=6, name='52 TFS #'}, -- F-7N Fishcan [MiG-21 Copy]
		{num1=1, num2=6, name='53 TFS #'}, -- F-7N Fishcan [MiG-21 Copy]
		{num1=1, num2=12, name='64 TFS #'}, -- F-4D Phantom II
		{num1=1, num2=12, name='91 TFS #'}, -- F-4E Phantom II
		{num1=1, num2=12, name='101 TFS #'}, -- F-4D Phantom II
		{num1=1, num2=6, name='141 TFS #'}, -- F-5E Tiger II
	}

	IranAircraftToUpgrade_2 = {
		{num1=1, num2=6, name='11 TFS #'}, -- MiG-29A Fulcrum
		{num1=1, num2=12, name='22 TFS #'}, -- MiG-29A Fulcrum
		{num1=1, num2=12, name='81 TFS #'}, -- F-14A Tomcat
		{num1=1, num2=12, name='82 TFS #'}, -- F-14A Tomcat
		{num1=1, num2=12, name='83 TFS #'}, -- F-14A Tomcat
	}

	IranAircraft = {
		-- Su-35S Flanker M - Iran, 2023
		{isExport=true, isHypothetical=false, dbid=6614, loadoutID=11076},

		-- Su-35S Flanker M - Russia, 2022 with AA-13 Arrow [R-37M]
		{isExport=false, isHypothetical=false, dbid=6645, loadoutID=31826},

		-- J-10CE Firebird - Pakistan, 2022
		{isExport=true, isHypothetical=false, dbid=5521, loadouts={
				{loadoutID=23219, chance=60}, -- PL-12
				{loadoutID=30510, chance=100} -- PL-15E
			},
		},

		-- J-10C Firebird - China, 2019 with PL-15
		{isExport=false, isHypothetical=false, dbid=5259, loadouts={
				{loadoutID=23219, chance=60}, -- PL-12
				{loadoutID=25177, chance=100} -- PL-15
			},
		},

		-- Su-57 Felon - Russia
		{isExport=false, isHypothetical=true, dbid=2232, loadouts={
				{loadoutID=1770, chance=60},
				{loadoutID=1779, chance=100}
			},
		},

		-- F-14E Super Tomcat-21
		{isExport=false, isHypothetical=true, dbid=4174, loadouts={
				{loadoutID=21126, chance=60},
				{loadoutID=21130, chance=100}
			},
		},

		-- F-14E Super Tomcat-21 Blk III
		{isExport=false, isHypothetical=true, dbid=5836, loadoutID=31040}
	}

	IranAAA = {
		{dbid=1815, name='AAA (100mm KS-19)', shouldRemoveMounts=true, mounts=5, numMountsToRemove=3, MountDBID=2074},
		{dbid=1814, name='AAA (100mm KS-19)', shouldRemoveMounts=true, mounts=5, numMountsToRemove=3, MountDBID=2073},
		{dbid=3750, name='AAA (57mm Bahman)', shouldRemoveMounts=true, mounts=4, numMountsToRemove=3, MountDBID=3884},
		{dbid=3749, name='AAA (57mm ZSU-57)', shouldRemoveMounts=true, mounts=4, numMountsToRemove=3, MountDBID=177},
		{dbid=2395, name='AAA (23mm ZSU-23 [BTR-60])', shouldRemoveMounts=true, mounts=2, numMountsToRemove=1, MountDBID=2650},
		{dbid=909, name='AAA (23mm ZSU-23 [Shilka])', shouldRemoveMounts=true, mounts=2, numMountsToRemove=1, MountDBID=329},
		{dbid=911, name='AAA (23mm ZU-23)', shouldRemoveMounts=true, mounts=2, numMountsToRemove=1, MountDBID=1032},
		{dbid=3738, name='AAA (23mm ZU-23)', shouldRemoveMounts=true, mounts=4, numMountsToRemove=1, MountDBID=3868},
		{dbid=912, name='AAA (35mm Twin Oerlikon)', shouldRemoveMounts=true, mounts=2, numMountsToRemove=1, MountDBID=97},
		{dbid=910, name='AAA (35mm Twin Oerlikon)', shouldRemoveMounts=true, mounts=3, numMountsToRemove=1, MountDBID=2397},
	}

	IranSAMsToUpgrade = {
		{dbid=902}, -- SAM Bn (HQ-2b)
		{dbid=3813}, -- SAM Bty (Mersad [I-HAWK Copy]), 3x Launchers
		{dbid=3238}, -- SAM Bty (Mersad [I-HAWK Copy]), 6x Launchers
	}

	IranHIAD = {
		{type='China', dbid=3280, name='SAM Bn (HQ-9)'}, -- SAM Bn (HQ-9B)
		{type='China', dbid=4387, name='SAM Bn (HQ-9)'}, -- SAM Bn (HQ-9B), Type 780 TAR
		{type='China', dbid=1277, name='SAM Bn (HQ-12)'}, -- SAM Bn (HQ-12)
		{type='China', dbid=3281, name='SAM Bn (HQ-22)'}, -- SAM Bn (HQ-22)
		{type='Domestic', dbid=3013, name='SAM Bn (SA-20 Gargoyle)'}, -- SAM Bn (SA-20b Gargoyle [S-300PMU-2 Favorit])
		{type='Russia', dbid=3216, name='SAM Bn (SA-21 Growler)'}, -- SAM Bn (SA-21a/b Growler [S-400 Triumf]), Turkey
		{type='Outdated', dbid=3756, name='SAM Bty (Sayyad-1)'}, -- SAM Bn (Sayyad-1A [Mod. HQ-2 Copy])
		{type='Domestic', dbid=4549, name='SAM Bty (Arman)'}, -- SAM Bty (Arman), Joshan FCR
		{type='Domestic', dbid=4550, name='SAM Bty (Arman)'}, -- SAM Bty (Arman), Najim-804 AESA
		{type='Domestic', dbid=3229, name='SAM Bty (Bavar-373)'}, -- SAM Bty (Bavar-373)
		{type='Domestic', dbid=3780, name='SAM Bty (Joshan)'}, -- SAM Bty (Joshan [Khordad-15 Mod])
		{type='Domestic', dbid=3744, name='SAM Bty (Karrar)'}, -- SAM Bty (Karrar)
		{type='Domestic', dbid=3783, name='SAM Bty (Khordad-15)'}, -- SAM Bty (Khordad-15 [Talash Mod])
		{type='Domestic', dbid=4591, name='SAM Bty (Mersad-16'}, -- SAM Bty (Mersad-16 [I-HAWK Mod])
		{type='Domestic', dbid=4586, name='SAM Bty (Talash-2)'}, -- SAM Bn (Talash-2)
		{type='Domestic', dbid=3782, name='SAM Bty (Talash-3)'}, -- SAM Bn (Talash-3 [SA-5C Mod])
		{type='Domestic', dbid=4587, name='SAM Bty (Talash-4)'}, -- SAM Bn (Talash-4)
		{type='Outdated', dbid=476, name='SAM Grp (SA-5 Gammon)'}, -- SAM Grp (SA-5c Gammon [S-200M Vega M])
	}

	IranMEAD = {
		{type='Outdated', dbid=902, name='SAM Bn (HQ-2)'}, -- SAM Bn (HQ-2b)
		{type='China', dbid=1277, name='SAM Bn (HQ-12)'}, -- SAM Bn (HQ-12)
		{type='Domestic', dbid=3324, name='SAM Bn (Khordad-3)'}, -- SAM Bn (Khordad-3 [Raad Mod])
		{type='Domestic', dbid=3323, name='SAM Bty (Khordad-3)'}, -- SAM Bty (Khordad-3 [Raad Mod])
		{type='Outdated', dbid=3813, name='SAM Bty (Mersad)'}, -- SAM Bty (Mersad [I-HAWK Copy]), 3x Launchers
		{type='Outdated', dbid=3238, name='SAM Bty (Mersad)'}, -- SAM Bty (Mersad [I-HAWK Copy]), 6x Launchers
		{type='Domestic', dbid=4591, name='SAM Bty (Mersad-16'}, -- SAM Bty (Mersad-16 [I-HAWK Mod])
		{type='Domestic', dbid=4588, name='SAM Bty (Raad-1)'}, -- SAM Bty (Raad-1)
		{type='Domestic', dbid=3786, name='SAM Bty (Raad-2)'}, -- SAM Bty (Raad-2)
		{type='Domestic', dbid=3753, name='SAM Bty (Tabas)'}, -- SAM Bty (Tabas [Raad Mod])
		{type='Domestic', dbid=3237, name='SAM Bty (Talash-1)'}, -- SAM Bn (Talash-1)
		{type='Russia', dbid=2276, name='SAM Plt (SA-27 Grizzly)'}, -- SAM Plt (SA-27 Grizzly [9K317M Buk-M3])
	}

	IranSHORAD = {
		{type='Outdated', dbid=901, name='SAM Bn (SA-6 Gainful)', shouldRemoveMounts=false}, -- SAM Bn (SA-6a Gainful [2K12E Kvadrat])
		{type='Domestic', dbid=4590, name='SAM Bty (9 Dey)', shouldRemoveMounts=false}, -- 9 Dey (Khordad-3 Mod)
		{type='Domestic', dbid=4488, name='SAM Plt (Azarakhsh)', shouldRemoveMounts=false}, -- SAM Plt (Azarakhsh)
		{type='Domestic', dbid=3784, name='SAM Plt (Dezful)', shouldRemoveMounts=false}, -- SAM Plt (Dezful [Mod. 9K330 Tor-M1K Copy])
		{type='Domestic', dbid=481, name='SAM Plt (SA-15 Gauntlet)', shouldRemoveMounts=false}, -- SAM Plt (SA-15b Gauntlet [9K330 Tor-M1K])
		{type='Russia', dbid=3757, name='SAM Plt (SA-17 Grizzly)', shouldRemoveMounts=false}, -- SAM Plt (SA-17 Grizzly [9K317E Buk-M2E])
		{type='Domestic', dbid=3758, name='SAM Plt (SA-22 Greyhound)', shouldRemoveMounts=false}, -- SAM Plt (SA-22 Greyhound [Pantsir-S1E])
		{type='Russia', dbid=3250, name='SAM Plt (SA-22 Greyhound)', shouldRemoveMounts=false}, -- SAM Plt (SA-22 Greyhound [Pantsir-SM])
		{type='Domestic', dbid=3815, name='SAM Plt (Zoubin)', shouldRemoveMounts=false}, -- SAM Plt (Zoubin)
	}

	IranRadarsToUpgrade ={
		{dbid=1047, replaceChance=70}, -- Radar (AN/TPS-70)
		{dbid=1227, replaceChance=30}, -- Radar (China JY-14 Great Wall)
		{dbid=1342, replaceChance=70}, -- Radar (Spoon Rest D [P-18])
	}

	IranRadars = {
		{type='Outdated', dbid=4214, name='Radar (AN/FPS-88)'}, -- Radar (AN/FPS-88)
		{type='Outdated', dbid=4212, name='Radar (AN/FPS-100)'}, -- Radar (AN/FPS-100)
		{type='Outdated', dbid=4215, name='Radar (AN/TPS-43)'}, -- Radar (AN/TPS-43)
		{type='Outdated', dbid=1047, name='Radar (AN/TPS-70)'}, -- Radar (AN/TPS-70)
		{type='Iran', dbid=3325, name='Radar (Bashir)'}, -- Radar (Bashir [Raad Mod])
		{type='Russia', dbid=439, name='Radar (Big Bird C)'}, -- Radar (Big Bird C [64N6])
		{type='Russia', dbid=2443, name='Radar (Big Bird D)'}, -- Radar (Big Bird D [91N6])
		{type='Iran', dbid=1849, name='Radar (Box Spring)'}, -- Radar (Box Spring [1L119 Nebo SVU])
		{type='Russia', dbid=3131, name='Radar (Cheese Board)'}, -- Radar (Cheese Board [96L6])
		{type='Russia', dbid=2735, name='Radar (Cheese Board)'}, -- Radar (Cheese Board [96L6E])
		{type='Outdated', dbid=1227, name='Radar (China JY-14 Great Wall)'}, -- Radar (China JY-14 Great Wall)
		{type='China', dbid=2537, name='Radar (China JY-26)'}, -- Radar (China JY-26)
		{type='China', dbid=3419, name='Radar (China JY-27A Wide Mat)'}, -- Radar (China JY-27A Wide Mat)
		{type='Outdated', dbid=1005, name='Radar (China Type 408C)'}, -- Radar (China Type 408C)
		{type='China', dbid=3599, name='Radar (China YLC-2V High Guard)'}, -- Radar (China YLC-2V [High Guard])
		{type='China', dbid=2538, name='Radar (China YLC-8B)'}, -- Radar (China YLC-8B)
		{type='China', dbid=3819, name='Radar (China YLC-8E)'}, -- Radar (China YLC-8E)
		{type='Iran', dbid=4106, name='Radar (Gamma-DE)'}, -- Radar (67N6E Gamma-DE [Falaq])
		{type='Iran', dbid=3930, name='Radar (Flat Face E)'}, -- Radar (Flat Face E [39N6E Kasta 2E2])
		{type='Iran', dbid=3236, name='Radar (Najm-802 PESA)'}, -- Radar (Najm-802 PESA)
		{type='Iran', dbid=3519, name='Radar (Prima)'}, -- Radar (Prima [P-18-2])
		{type='Russia', dbid=2257, name='Radar (Protivnik-GE)'}, -- Radar (59N6 Protivnik-GE)
		{type='Iran', dbid=3418, name='Radar (Quds)'}, -- Radar (Quds [Vostok E])
		{type='Outdated', dbid=1342, name='Radar (Spoon Rest D)'}, -- Radar (Spoon Rest D [P-18])
		{type='Russia', dbid=1847, name='Radar (Tall Rack [Nebo M, L-Band])'}, -- Radar (Tall Rack [55Zh6M Nebo M, RLM-D L-Band])
		{type='Russia', dbid=1846, name='Radar (Tall Rack [Nebo M, VHF-Band])'}, -- Radar (Tall Rack [55Zh6M Nebo M, RLM-M VHF-Band]) 
		{type='Russia', dbid=1848, name='Radar (Tall Rack [Nebo M, S-Band])'}, -- Radar (Tall Rack [55Zh6M Nebo M, RLM-S S-Band])
		{type='Russia', dbid=1616, name='Radar (Tall Rack [Nebo U])'}, -- Radar (Tall Rack [55Zh6U Nebo U])
		{type='Russia', dbid=3869, name='Radar (Tall Rack [Nebo UME])'}, -- Radar (Tall Rack [55Zh6UME Nebo UME])
		{type='Outdated', dbid=4216, name='Radar (Type 88 Green Ginger)'}, -- Radar (Type 88 Green Ginger)
	}
end

-- =========================
-- Restore Variables on Scenario Reload
-- =========================

function RestoreGlobalVariables()
	local GlobalVariables = {
		{name='PlayerNumbeOfUnitsDestroyed'},
		{name='PlayerCyberChance'},
		{name='PlayerCyberChanceDecrement'},

		{name='IranFighterSquadronsHtml'},
		{name='IranNumberOfAircraftDetected'},
		{name='IranResetCommandAndControlCounter'},
		{name='IranResetCommandAndControlChance'},
		{name='IranResetCommandAndControlTime'},
		{name='IranResetCommunicationsCounter'},
		{name='IranResetCommunicationsChance'},
		{name='IranResetCommunicationsTime'},
		{name='IranResetSensorsCounter'},
		{name='IranResetSensorsChance'},
		{name='IranResetSensorsTime'},

		{name='SyriaNumberOfAircraftDetected'},

		{name='GlobalMinTemp'},
		{name='GlobalMaxTemp'},
	}

	-- Restore the values from the key store
	for _, var in ipairs(GlobalVariables) do
		local value = ScenEdit_GetKeyValue(var.name)

		-- Check if the value is numeric to convert it
		if tonumber(value) then
			_G[var.name] = tonumber(value)
		else
			_G[var.name] = value
		end
	end

	IranDisruptedCommandAndControlUnitList = {}
	IranDisruptedCommunicationsUnitList = {}
	IranFalseContactsList = {}

	setGlobalFromKeyStore('IranDisruptedCommandAndControlUnitList', 'IranDisruptedCommandAndControlUnitListKey')
	setGlobalFromKeyStore('IranDisruptedCommunicationsUnitList', 'IranDisruptedCommunicationsUnitListKey')
	setGlobalFromKeyStore('IranFalseContactsList', 'IranFalseContactsListKey')

	if SearchAndRescueEnabled() then
		CargoAircraftList = {
			-- Landing altitude 10 ft higher then min to account for terrain elevation
			{name='103 Sqd. #1', minAltitude=510, landingSpeed=210, TimeToReady=30},
			{name='103 Sqd. #2', minAltitude=510, landingSpeed=210, TimeToReady=30},
			{name='103 Sqd. #3', minAltitude=510, landingSpeed=210, TimeToReady=30},
			{name='103 Sqd. #4', minAltitude=510, landingSpeed=210, TimeToReady=30},

			{name='ASHER 31', minAltitude=210, landingSpeed=140, TimeToReady=30},
			{name='ASHER 32', minAltitude=210, landingSpeed=140, TimeToReady=30},
			{name='ASHER 33', minAltitude=210, landingSpeed=140, TimeToReady=30},
			{name='ASHER 34', minAltitude=210, landingSpeed=140, TimeToReady=30},

			{name='BROKE 31', minAltitude=210, landingSpeed=140, TimeToReady=30},
			{name='BROKE 32', minAltitude=210, landingSpeed=140, TimeToReady=30},
			{name='BROKE 33', minAltitude=210, landingSpeed=140, TimeToReady=30},
			{name='BROKE 34', minAltitude=210, landingSpeed=140, TimeToReady=30},
		}

		RescueCapableUnits = {
			Aircraft = {
				4732, -- CH-53C Sea Stallion [Yasur 2025]
				5336, -- CH-53K King Stallion
				4365, -- HH-60G Credible Hawk
				4366, -- HH-60W Jolly Green II
				5338, -- MH-60R Seahawk
				5337 -- MH-60S Seahawk
				-- Add or remove aircraft entries as required
			},
			Ship = {
				-- Add or remove ship entries as required
			},
			Submarine = {
				-- Add or remove submarine entries as required
			},
			Facility = {
				-- Add or remove facility entries as required
			}
		}

		RescueCapableUnitsList = GenerateListOfRescueUnits() -- Name must match the name used in the GetListOfRescueUnitsNearSurvivors function, Initialize at scenario setup and reload
		SurvivorList = GenerateListOfSurvivorUnits('Survivors') -- Name must match thise used in the CSAR functions, Initialize at scenario setup and reload
	end
end

-- =========================
-- Set Player Camera
-- =========================

function SetPlayerCamera(side)
	if side == 'Israel' then
		UI_SetCameraView(32, 47.5, 1500000)
	elseif side == 'United States' then
		UI_SetCameraView(29, 55, 8000000)
	else -- United States-Israel
		UI_SetCameraView(29, 55, 8000000)
	end
end

-- =========================
-- Randomize Weather
-- =========================

function RandomizeWeather()
	-- Randomize min/max temperature
	local variablesList = {
		{name='GlobalMinTemp', value=RandomTemperature(21, 24, 18, 28, 30, 4, 2)},
		{name='GlobalMaxTemp', value=RandomTemperature(31, 35, 28, 38, 30, 4, 2)},
	}

	for _, var in ipairs(variablesList) do
		_G[var.name] = var.value
		ScenEdit_SetKeyValue(var.name, tostring(var.value))
	end

	-- Randomize current global weather conditions
	local GlobalTemp = RandomTemperature(30, 34, 28, 35, 30, 4, 2)
	local GlobalUnderCloud = RandomUndercloud(0, 4, 0, 10, 30, 4, 2)
	local GlobalRainfall = RandomRainfall(0, 0, 0, 10, 30, 4, 2, GlobalUnderCloud)
	local GlobalSeastate = RandomSeastate(2, 3, 0, 3, 30, 4, 2)

	-- Update global weather conditions
	ScenEdit_SetWeather(
		GlobalTemp, -- temp
		GlobalRainfall, -- rainfall
		GlobalUnderCloud, -- undercloud
		GlobalSeastate -- seastate
	)
end

-- ==========================
-- Scenario Initialization --
-- ==========================

function ThisIsFirstLoad(booleanValue)
	local result
	if booleanValue == nil then
		result = ScenEdit_GetKeyValue('firstLoad')
		if result == '' or result == nil then result = true end
		if result == 'false' then result = false end
	else
		if booleanValue == true then
			ScenEdit_ClearKeyValue('firstLoad')
			result = true
		elseif booleanValue == false then
			ScenEdit_SetKeyValue('firstLoad','false')
			result = false
		end
	end
	return result
end

if ThisIsFirstLoad() then
	local PlayerSide = ScenEdit_PlayerSide()
	SetPlayerCamera(PlayerSide)
	if inDevelopment then -- Ask to do stuff
		userInput = string.upper(ScenEdit_MsgBox('Initialize variables?', 1))
		if userInput == 'OK' then
			InitializeGlobalVariables()
		end

		userInput = string.upper(ScenEdit_MsgBox('Execute scenario setup?', 1))
		if userInput == 'OK' then
			ScenarioSetupMenu()
		end

		userInput = string.upper(ScenEdit_MsgBox('Setup CSAR units?', 1))
		if userInput == 'OK' then
			if SearchAndRescueEnabled() then
				RescueCapableUnitsList = GenerateListOfRescueUnits() -- Name must match the name used in the GetListOfRescueUnitsNearSurvivors function, Initialize at scenario setup and reload
				SurvivorList = {} -- Name must match thise used in the CSAR functions, Initialize at scenario setup and reloaded
			end
		end

		userInput = string.upper(ScenEdit_MsgBox('Randomize weather?', 1))
		if userInput == 'OK' then
			RandomizeWeather()
		end

		userInput = string.upper(ScenEdit_MsgBox('Setup civilian air traffic?', 1))
		if userInput == 'OK' then
			CivilianAirTraffic()
		end

		userInput = string.upper(ScenEdit_MsgBox('Set firstLoad key value to false?', 1))
		if userInput == 'OK' then
			ThisIsFirstLoad(false)
		end
	else -- Don't give the option and just do it
		InitializeGlobalVariables()
		ScenarioSetupMenu()

		if SearchAndRescueEnabled() then
			RescueCapableUnitsList = GenerateListOfRescueUnits() -- Name must match the name used in the GetListOfRescueUnitsNearSurvivors function, Initialize at scenario setup and reload
			SurvivorList = {} -- Name must match thise used in the CSAR functions, Initialize at scenario setup and reloaded
		end

		RandomizeWeather()
		CivilianAirTraffic()
		ThisIsFirstLoad(false)
	end
else
	local PlayerSide = ScenEdit_PlayerSide()
	SetPlayerCamera(PlayerSide)
	RestoreGlobalVariables()
end

-- Scenario Lua init 6 script

math.randomseed(os.time())
math.random()

-- =========================
-- Cyber Attack Functions --
-- =========================

-- =========================
-- Aircraft DBIDs to be Disrupted
-- =========================

function AircraftToBeDisrupted(side)
	local sideUnits, result = VP_GetSide({side=side}).units, {}
	local affectedDBIDs = {
		229, -- F-4D Phantom II
		3896, -- F-4E Phantom II
		6997, -- F-5E Tiger II
		6998, -- F-5F Tiger II
		1354, -- F-7N Fishcan
		1312, -- F-14A Tomcat
		4174, -- F-14E Tomcat
		5836, -- F-14E Tomcat
		5259, -- J-10C Firebird
		5521, -- J-10C Firebird
		1346, -- MiG-29 Fulcrum A
		6728, -- MiG-29 Fulcrum A
		6614, -- Su-35S Flanker M
		6645, -- Su-35S Flanker M
		2232, -- Su-57 Felon
		2423, -- Boeing 707 Tanker
		1660, -- Boeing 747 Tanker
	}

	for _,entry in ipairs (sideUnits) do
		local unit = ScenEdit_GetUnit({guid=entry.guid})
		for k,v in ipairs(affectedDBIDs) do
			if unit.dbid == v then
				table.insert(result,unit)
				break
			end
		end
	end
	return result
end

-- =========================
-- IADS Unit DBIDs to be Disrupted
-- =========================

function FacilitiesToBeDisrupted(side)
	local sideUnits, result = VP_GetSide({side=side}).units, {}
	local affectedDBIDs = {
		1815, -- AAA Bty (100mm KS-19 Auto [Sair])
		1814, -- AAA Bty (100mm KS-19 x 4, Fire Can FCR)
		3750, -- AAA Bty (57mm Bahman x 4)
		3749, -- AAA Bty (57mm ZSU-57-2 x 4)
		2395, -- AAA Plt/2 (23mm ZSU-23-2 BTR-60 x 2)
		909, -- AAA Plt/2 (23mm ZSU-23-4 Shilka x 2)
		911, -- AAA Plt/3 (23mm ZU-23-2 x 2)
		3738, -- AAA Plt/3 (23mm ZU-23-8, Mesbah-1 x 2)
		912, -- AAA Sec (35mm Twin Oerlikon x 2)
		910, -- AAA Sec (35mm Twin Oerlikon x 2, Skyguard FCR)
		2257, -- Radar (59N6 Protivnik-GE)
		4106, -- Radar (67N6E Gamma-DE [Falaq])
		1047, -- Radar (AN/TPS-70)
		3325, -- Radar (Bashir)
		439, -- Radar (Big Bird C [64N6])
		2443, -- Radar (Big Bird D [91N6])
		1849, -- Radar (Box Spring [1L119 Nebo SVU])
		3131, -- Radar (Cheese Board [96L6])
		2735, -- Radar (Cheese Board [96L6E])
		1227, -- Radar (China JY-14 Great Wall)
		2537, -- Radar (China JY-26)
		3419, -- Radar (China JY-27A Wide Mat)
		1005, -- Radar (China Type 408C)
		3599, -- Radar (China YLC-2V [High Guard])
		2538, -- Radar (China YLC-8B)
		3819, -- Radar (China YLC-8E)
		2611, -- Radar (Ghadir OTH-B)
		3930, -- Radar (Flat Face E [39N6E Kasta 2E2])
		1242, -- Radar (HFR)
		1065, -- Radar (LRR)
		3236, -- Radar (Najm-802 PESA)
		3519, -- Radar (Prima [P-18-2])
		3418, -- Radar (Quds [Vostok E])
		3321, -- Radar (Rezonans-NE OTH)
		2612, -- Radar (Sepehr OTH-B)
		1342, -- Radar (Spoon Rest D [P-18])
		1847, -- Radar (Tall Rack [55Zh6M Nebo M, RLM-D L-Band])
		1846, -- Radar (Tall Rack [55Zh6M Nebo M, RLM-M VHF-Band])
		1848, -- Radar (Tall Rack [55Zh6M Nebo M, RLM-S S-Band])
		1616, -- Radar (Tall Rack [55Zh6U Nebo U])
		3869, -- Radar (Tall Rack [55Zh6UME Nebo UME])
		902, -- SAM Bn (HQ-2b)
		3280, -- SAM Bn (HQ-9B)
		4387, -- SAM Bn (HQ-9B)
		1277, -- SAM Bn (HQ-12)
		3281, -- SAM Bn (HQ-22)
		3324, -- SAM Bn (Khordad 3 [Raad Mod])
		901, -- SAM Bn (SA-6a Gainful [2K12E Kvadrat])
		3013, -- SAM Bn (SA-20b Gargoyle [S-300PMU-2 Favorit])
		3756, -- SAM Bn (Sayyad-1A [Mod. HQ-2 Copy])
		4590, -- SAM Bty (9 Dey [Khordad-3 Mod])
		4549, -- SAM Bty (Arman) -- Joshan FCR
		4550, -- SAM Bty (Arman) -- Najim-804 AESA
		3229, -- SAM Bty (Bavar-373)
		3780, -- SAM Bty (Joshan [Khordad-15 Mod])
		3744, -- SAM Bty (Karrar)
		3323, -- SAM Bty (Khordad-3 [Raad Mod])
		3783, -- SAM Bty (Khordad-15 [Talash Mod])
		3813, -- SAM Bty (Mersad [I-HAWK Copy]), -- 3x Launchers
		3238, -- SAM Bty (Mersad [I-HAWK Copy]), -- 6x Launchers
		4588, -- SAM Bty (Raad-1)
		3786, -- SAM Bty (Raad-2)
		3753, -- SAM Bty (Tabas [Raad Mod])
		3237, -- SAM Bn (Talash-1)
		4586, -- SAM Bn (Talash-2)
		3782, -- SAM Bn (Talash-3 [SA-5C Mod])
		4587, -- SAM Bn (Talash-4)
		476, -- SAM Grp (SA-5c Gammon [S-200M Vega M])
		4488, -- SAM Plt (Azarakhsh)
		3784, -- SAM Plt (Dezful [Mod. 9K330 Tor-M1K Copy])
		481, -- SAM Plt (SA-15b Gauntlet [9K330 Tor-M1K])
		3757, -- SAM Plt (SA-17 Grizzly [9K317E Buk-M2E])
		3758, -- SAM Plt (SA-22 Greyhound [Pantsir-S1E])
		2276, -- SAM Plt (SA-27 Grizzly [9K317M Buk-M3])
		3815, -- SAM Plt (Zoubin)
	}

	for _,entry in ipairs (sideUnits) do
		local unit = ScenEdit_GetUnit({guid=entry.guid})
		for k,v in ipairs(affectedDBIDs) do
			if unit.dbid == v then
				table.insert(result,unit)
				break
			end
		end
	end
	return result
end

-- =========================
-- Attack Command and Control Network
-- =========================

function AttackSideCommandAndControlNetwork(targetSide, targetUnitList, chance, insertIntoTableBoolean, disruptedUnitList)
	for _,v in ipairs(targetUnitList) do
		if math.random(1,100) <= chance then
			local unit = ScenEdit_GetUnit({guid=v.guid})
			RandomizeUnitProficiency(unit.guid, 40, 100, 0, 0, 0)
			ScenEdit_SetUnit({guid=unit.guid, autodetectable=true})
			if insertIntoTableBoolean then
				table.insert(disruptedUnitList, unit.guid)
			end
		end
	end

	ScenEdit_SetEvent('Reset '..targetSide..' Command and Control Network', {isActive=true})
end

-- =========================
-- Reset Command and Control Network
-- =========================

function ResetUnitCommandAndControl(disruptedUnitList, chance)
	for _,guid in ipairs(disruptedUnitList) do
		if math.random(1,100) <= chance then
			local unit = ScenEdit_GetUnit({guid=guid})
			RandomizeUnitProficiency(unit.guid, 20, 50, 100, 0, 0)
			if unit.type == 'Aircraft' then
				ScenEdit_SetUnit({guid=unit.guid, autodetectable=false})
			end

			local position = FindInTable(disruptedUnitList, guid)
			if position then
				table.remove(disruptedUnitList, position)
			end
		end
	end
end

function ResetSideCommandAndControlNetwork(targetSide, resetCounter, resetTime, resetChance, resetThreshold, disruptedUnitList, chanceIncrement, resetTimeIncrement, updateGlobalVariablesBoolean, resetCounterKey, resetChanceKey, resetTimeKey)
	-- Increment the counter
	resetCounter = resetCounter + 1

	-- Check if it's time to reset side command and control network
	if resetCounter == resetTime then
		-- Get the current unit reset chance
		local unitResetChance = tonumber(resetChance)

		-- If resetTime reaches or is below the resetThreshold, set unitResetChance to 100
		if resetTime <= resetThreshold then
			unitResetChance = 100
			ScenEdit_SetEvent('Reset '..targetSide..' Command and Control Network', {isActive=false})
		end

		-- Reset units
		ResetUnitCommandAndControl(disruptedUnitList, unitResetChance)

		-- Increment the chance for the next phase
		if unitResetChance < 100 then
			resetChance = math.min(unitResetChance + chanceIncrement, 100)
		end

		-- Decrement resetTime by resetTimeIncrement
		resetTime = resetTime - resetTimeIncrement

		-- Reset the counter for the next cycle
		resetCounter = 0

		-- Store the updated values back to their respective keys
		-- This only updates the global variable key values
		-- Set the global variables to the new key value outside of this function
		if updateGlobalVariablesBoolean then
			ScenEdit_SetKeyValue(resetCounterKey, tostring(resetCounter))
			ScenEdit_SetKeyValue(resetChanceKey, tostring(resetChance))
			ScenEdit_SetKeyValue(resetTimeKey, tostring(resetTime))
		end
	end
end

-- =========================
-- Attack Communications Network
-- =========================

function AttackSideCommunicationsNetwork(targetSide, targetUnitList, chance, insertIntoTableBoolean, disruptedUnitList)
	for _,v in ipairs (targetUnitList) do
		if math.random(1,100) <= chance then
			local unit = ScenEdit_GetUnit({guid=v.guid})
			ScenEdit_SetUnit({guid=unit.guid, outofcomms=true})
			ScenEdit_SetEMCON('Unit', unit.guid, 'Radar=Active')

			if insertIntoTableBoolean then
				table.insert(disruptedUnitList, unit.guid)
			end
		end
	end

	ScenEdit_SetEvent('Reset '..targetSide..' Communications Network', {isActive=true})
end

-- =========================
-- Reset Communications Network
-- =========================

function ResetUnitCommunications(disruptedUnitList, chance)
	for _,guid in ipairs(disruptedUnitList) do
		if math.random(1,100) <= chance then
			local unit = ScenEdit_GetUnit({guid=guid})
			ScenEdit_SetUnit({guid=unit.guid, outofcomms=false})

			local position = FindInTable(disruptedUnitList, guid)
			if position then
				table.remove(disruptedUnitList, position)
			end
		end
	end
end

function ResetSideCommunicationsNetwork(targetSide, resetCounter, resetTime, resetChance, resetThreshold, disruptedUnitList, chanceIncrement, resetTimeIncrement, updateGlobalVariablesBoolean, resetCounterKey, resetChanceKey, resetTimeKey)
	-- Increment the counter
	resetCounter = (resetCounter or 0) + 1

	-- Check if it's time to reset communications
	if resetCounter == resetTime then
		-- Get the current chance for resetting
		local unitResetChance = resetChance

		-- If resetTime reaches or is below the resetThreshold, set unitResetChance to 100
		if resetTime <= resetThreshold then
			unitResetChance = 100
			ScenEdit_SetEvent('Reset '..targetSide..' Communications Network', {isActive=false})
		end

		-- Reset units
		ResetUnitCommunications(disruptedUnitList, unitResetChance)

		-- Increment the chance for the next phase
		if unitResetChance < 100 then
			resetChance = math.min(unitResetChance + chanceIncrement, 100)
		end

		-- Decrement resetTime by resetTimeIncrement
		resetTime = resetTime - resetTimeIncrement

		-- Reset the counter for the next cycle
		resetCounter = 0

		-- Store the updated values back to their respective keys
		-- This only updates the global variable key values
		-- Set the global variables to the new key value outside of this function
		if updateGlobalVariablesBoolean then
			ScenEdit_SetKeyValue(resetCounterKey, tostring(resetCounter))
			ScenEdit_SetKeyValue(resetChanceKey, tostring(resetChance))
			ScenEdit_SetKeyValue(resetTimeKey, tostring(resetTime))
		end
	end
end

-- =========================
-- Attack Sensor Network Network
-- =========================

function AttackSideSensorNetwork_FalseContacts(targetSide, numFalseContacts, chance, centerPoint, falseContactSide, falseContactDBID, falseContactLoadoutID, falseContactAltitude, falseContactHeading, falseContactMission, insertIntoTableBoolean, falseContactUnitList)
	for i = 1,numFalseContacts do
		if math.random(1,100) <= chance then
			local position = CircularRandomPosition(centerPoint.latitude, centerPoint.longitude, centerPoint.maxRange)
			local newFalseContact = ScenEdit_AddUnit({
				side=falseContactSide,
				type='Aircraft',
				dbid=falseContactDBID,
				name='False Contact',
				loadoutid=falseContactLoadoutID,
				latitude=position.latitude,
				longitude=position.longitude,
				altitude=falseContactAltitude,
				heading=falseContactHeading
			})

			ScenEdit_AssignUnitToMission (newFalseContact.guid, falseContactMission) 

			if insertIntoTableBoolean == true then
				table.insert(falseContactUnitList, newFalseContact.guid)
			end
		end
	end

	ScenEdit_SetEvent('Reset '..targetSide..' Sensor Network', {isActive=true})
end

function AttackSideSensorNetwork_FalseMissileStrike(targetGUID, chance, centerPoint, numWeapons, weaponSide, weaponDBID, weaponName, weaponAltitude, salvoSpacing)
	if math.random(1,100) <= chance then
		AddWeaponSalvo(targetGUID, centerPoint, numWeapons, weaponSide, weaponDBID, weaponName, weaponAltitude, salvoSpacing)
	end
end

-- =========================
-- Reset Sensor Network False Contacts
-- =========================

function ResetSensorNetwork(disruptedUnitList, chance)
	for _,guid in ipairs(disruptedUnitList) do
		if math.random(1,100) <= chance then
			local unit = ScenEdit_GetUnit({guid=guid})
			ScenEdit_DeleteUnit({guid=unit.guid})

			local position = FindInTable(disruptedUnitList, guid)
			if position then
				table.remove(disruptedUnitList, position)
			end
		end
	end
end

function ResetSideSensorNetwork(targetSide, resetCounter, resetTime, resetChance, resetThreshold, disruptedUnitList, chanceIncrement, resetTimeIncrement, updateGlobalVariablesBoolean, resetCounterKey, resetChanceKey, resetTimeKey)
	-- Increment the counter
	resetCounter = (resetCounter or 0) + 1

	-- Check if it's time to reset sensor network
	if resetCounter == resetTime then
		-- Get the current chance for resetting
		local unitResetChance = resetChance

		-- If resetTime reaches or is below the resetThreshold, set unitResetChance to 100
		if resetTime <= resetThreshold then
			unitResetChance = 100
			ScenEdit_SetEvent('Reset '..targetSide..' Sensor Network', {isActive=false})
		end

		-- Reset units
		ResetSensorNetwork(disruptedUnitList, unitResetChance)

		-- Increment the chance for the next phase
		if unitResetChance < 100 then
			resetChance = math.min(unitResetChance + chanceIncrement, 100)
		end

		-- Decrement resetTime by resetIncrement
		resetTime = resetTime - resetIncrement

		-- Reset the counter for the next cycle
		resetCounter = 0

		-- Store the updated values back to their respective keys
		-- This only updates the global variable key values
		-- Set the global variables to the new key value outside of this function
		if updateGlobalVariablesBoolean then
			ScenEdit_SetKeyValue(resetCounterKey, tostring(resetCounter))
			ScenEdit_SetKeyValue(resetChanceKey, tostring(resetChance))
			ScenEdit_SetKeyValue(resetTimeKey, tostring(resetTime))
		end
	end
end

-- ===================
-- Cyber Operations --
-- ===================

-- =========================
-- Conduct Cyberattack Against Iranian Command and Control Network
-- =========================

function PlayerAttackIranianCommandAndControlNetwork()
	local TargetAircraftList = AircraftToBeDisrupted('Iran')
	local TargetFacilityList = FacilitiesToBeDisrupted('Iran')
	AttackSideCommandAndControlNetwork('Iran', TargetAircraftList, PlayerCyberChance, true, IranDisruptedCommandAndControlUnitList)
	AttackSideCommandAndControlNetwork('Iran', TargetFacilityList, PlayerCyberChance, true, IranDisruptedCommandAndControlUnitList)

	-- Increment cyber chance by increment
	PlayerCyberChance = PlayerCyberChance - PlayerCyberChanceDecrement
	ScenEdit_SetKeyValue('PlayerCyberChanceKey', PlayerCyberChance)

	-- Serialize and store disrupted unit list
	storeData(IranDisruptedCommandAndControlUnitList, 'IranDisruptedCommandAndControlUnitListKey')
end

-- =========================
-- Conduct Cyberattack Against Iranian Communications Network
-- =========================

function PlayerAttackIranianCommunicationsNetwork()
	local TargetFacilityList = FacilitiesToBeDisrupted('Iran')
	AttackSideCommunicationsNetwork('Iran', TargetFacilityList, PlayerCyberChance, true, IranDisruptedCommunicationsUnitList)

	-- Increment cyber chance by increment
	PlayerCyberChance = PlayerCyberChance - PlayerCyberChanceDecrement
	ScenEdit_SetKeyValue('PlayerCyberChanceKey', PlayerCyberChance)

	-- Serialize and store disrupted unit list
	storeData(IranDisruptedCommunicationsUnitList, 'IranDisruptedCommunicationsUnitListKey')
end

-- =========================
-- Conduct Cyberattack Against Iranian Sensor Network (False Contacts)
-- =========================

function PlayerAttackIranianSensorNetwork_FalseContacts(centerPoint, initialFalseContactHeading)
	AttackSideSensorNetwork_FalseContacts('Iran', math.random(30,60), PlayerCyberChance, centerPoint, 'Decoys-False Contacts', 4921, 5857, '25000 ft', initialFalseContactHeading, 'False Contacts Patrol', true, IranFalseContactsList)

	-- Increment cyber chance by increment
	PlayerCyberChance = PlayerCyberChance - PlayerCyberChanceDecrement
	ScenEdit_SetKeyValue('PlayerCyberChanceKey', PlayerCyberChance)

	-- Serialize and store false contact unit list
	storeData(IranFalseContactsList, 'IranFalseContactsListKey')
end

-- =========================
-- Conduct Cyberattack Against Iranian Sensor Network (False Missile Strike)
-- =========================

function PlayerCyberAttackIranianSensors_FalseMissileStrike(targetGUID, centerPoint)
	AttackSideSensorNetwork_FalseMissileStrike(targetGUID, PlayerCyberChance, centerPoint, 24, 'Decoys-False Contacts', 2441, 'False Contact', '10000 ft', 0.1)

	-- Increment cyber chance by increment
	PlayerCyberChance = PlayerCyberChance - PlayerCyberChanceDecrement/4
	ScenEdit_SetKeyValue('PlayerCyberChanceKey', PlayerCyberChance)
end

-- ==========================
-- Cyber Operations Center --
-- ==========================

function CyberOperationsCenter()
	local msg = [[
		<!DOCTYPE html>
		<html>
			<head>
				<meta charset="UTF-8">
				<meta name="viewport" content="width=device-width, initial-scale=1.0">
				<title>Cyber Operations Console</title>
				<style>
					body{
						font-family: 'Consolas', 'Lucida Console', monospace;
						background-color: #000000; /* Black background */
						color: #C0C0C0; /* Light gray text */
						text-align: justify;
					}

					.container{
						font-family: 'Consolas', 'Lucida Console', monospace; /* Apply font to container content */
						background-color: #000000; /* Black background */
						margin: auto;
						border-radius: 8px;
					}

					h1{
						font-size:large;
						text-align: center;
					}

					table{
						border-collapse: collapse;
						margin: auto;
						padding: 25px;
					}

					th, td{
						border: 1px solid white;
						text-align: left;
						padding: 8px;
					}

					td {
						width: 500px;
					}

					ul {
						list-style-type: none;
					}

					select {
						font-family: 'Consolas', 'Lucida Console', monospace; /* Apply font to select */
						background-color: #000000; /* Black background */
						color: #F0F0F0; /* Lighter gray text */
						padding: 5px; /* Add padding for consistent spacing */
						border: 1px solid #C0C0C0; /* Add a border to match the light gray color scheme */
					}

					#hidden {
						display: none;
					}

					:checked + #hidden {
						display: block;
					}

					.hidden {
						display: none;
					}

					/* Show Direction Dropdown when "False Contacts" or "Missile Strike" is selected */
					#cyber_attack_1_false_contacts:checked ~ #cyber_attack_1_position_selector,
					#cyber_attack_1_missile_strike:checked ~ #cyber_attack_1_position_selector,
					#cyber_attack_2_false_contacts:checked ~ #cyber_attack_2_position_selector,
					#cyber_attack_2_missile_strike:checked ~ #cyber_attack_2_position_selector {
						display: block;
					}

					/* Show Target Selector when "Missile Strike" is selected */
					#cyber_attack_1_missile_strike:checked ~ #cyber_attack_1_missile_target_selector,
					#cyber_attack_2_missile_strike:checked ~ #cyber_attack_2_missile_target_selector {
						display: block;
					}

					.target-row {
						display: flex;
						justify-content: space-around; /* Align dropdowns horizontally */
						gap: 10px; /* Add spacing between dropdowns */
					}

					label {
						margin-right: 5px; /* Space between label and dropdown */
					}
				</style>
			</head>
			<body>
				<div class="outer-container">
					<div class="container">
						<h1>Cyber Operations Center</h1>
						<table>
							<tr>
								<td>
									<p><b>Cyber Operations Rules:</b></p>
									<input type="checkbox" id="cyber_operations_rules" style="display:none;">
									<div id="hidden">
										<p>You may conduct up to two cyber-attack methods simultaneously. You will need to reopen this menu if you wish to conduct additional actions.</p>
										<p>Each action will reduce the effectiveness of subsequent actions. If you are using the default "Realistic" event chances scenario option, the first cyber action has a high chance of success. The second attack will have a moderate chance of success. Additional cyber actions will have a low to no chance of success. Experience will vary if using the "Random" event chance scenario option. If you selected "Remove Randomization" you may conduct as many actions as you wish with a high chance of success.</p>
										<p>Most effects will last for a limited period of time. Depending on the action, recovery from the effect may not be instantaneous. It may take several hours for Iranian units to fully recover. Each effect has its own recovery check event. After each recovery check phase, the time to the next phase decreases and the chance of unit recovering increases.</p>
										<p>Cyber-attack method targets/effects:</p>
										<ul>
											<li><b>Iranian Command and Control Network:</b> Affected units will have their proficiency reduced and position and movements revealed. Aircraft positions and movement will only be known for a limited period of time. However, fixed facilities will always remain known.</li>
											<li><b>Iranian Air Defenses:</b> Affected units will have their communications disrupted, no longer sending or receiving information to/from other units.</li>
											<li><b>Iranian Sensor Network (False Contacts):</b> Creates 30-60 false contacts (decoys) and orders them to fly around Iranian airspace. In addition to lasting for a limited period of time, false contacts will be deleted if they are identified.</li>
											<li><b>Iranian Sensor Network (False Missile Strike):</b> Creates 24 false missiles (decoys) targeted at the selected target(s). False missiles will be deleted if they are identified or when they approach within 5 nautical miles of their target. You can target the Arak Heavy Water Plant, Esfahan Uranium Conversion Facility, Fordow Fuel Enrichment Plant and Natanz Fuel Enrichment Plant. Each selected target will reduce the success chance of subsequent actions by a quarter of the normal value.</li>
										</ul>
										<p>Most effects are not cumulative. Running the same attack method more than once will not increase the chances of success or the effects. The exception to this rule is the attack sensor network actions. Executing these actions multiple times does have the potential to create additional false contacts.</p>
										<p>False Contact Starting/Launch Positions:</p>
										<ul>
											<li><b>West:</b> False contacts will be created over central Iraq. Will fly into Iranian airspace from the West.</li>
											<li><b>Southwest:</b> False contacts will be created over Kuwait-Saudi Arabia-Iraq border region. Will fly into Iranian airspace from the Southwest.</li>
											<li><b>South:</b> False contacts will be created over Qatar, Saudi Arabia, and the Persian Gulf. Will fly into Iranian airspace from the South.</li>
											<li><b>Southeast:</b> False contacts will be created over the Gulf of Oman. They will fly into Iranian airspace from the Southeast.</li>
										</ul>
									</div>
									<label for="cyber_operations_rules">Show/Hide</label>
								</td>
							</tr>
							<tr>
								<td>
									<p><b>Cyber Attack 1</b></p>
									<!-- Radio Buttons for Cyber Attack Methods -->
									<input type="radio" name="cyber_attack_1" id="cyber_attack_1_none" value="None" checked>
									<label for="cyber_attack_1_none">None</label><br>

									<input type="radio" name="cyber_attack_1" id="cyber_attack_1_c2" value="C2">
									<label for="cyber_attack_1_c2">Iranian Command and Control Network</label><br>

									<input type="radio" name="cyber_attack_1" id="cyber_attack_1_air_defenses" value="IADS">
									<label for="cyber_attack_1_air_defenses">Iranian Air Defenses Network</label><br>

									<input type="radio" name="cyber_attack_1" id="cyber_attack_1_false_contacts" value="False_Contacts">
									<label for="cyber_attack_1_false_contacts">Iranian Sensor Network (False Contacts)</label><br>

									<input type="radio" name="cyber_attack_1" id="cyber_attack_1_missile_strike" value="Missile_Strike">
									<label for="cyber_attack_1_missile_strike">Iranian Sensor Network (False Missile Strike)</label><br>

									<!-- Position Selector for False Contacts -->
									<div id="cyber_attack_1_position_selector" class="hidden">
										<p>False Contact(s) Starting/Launch Position</p>
										<select name="cyber_attack_1_position">
											<option value="West">West</option>
											<option value="Southwest">Southwest</option>
											<option value="South">South</option>
											<option value="Southeast">Southeast</option>
										</select>
									</div>

									<!-- Target Selector for False Missile Strike -->
									<div id="cyber_attack_1_missile_target_selector" class="hidden">
										<p>Target Selection for False Missile Strike</p>
										<div class="target-row">
											<label for="missile_strike_1_target_arak">Arak:</label>
											<select id="missile_strike_1_target_arak" name="missile_strike_1_arak">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>

											<label for="missile_strike_1_target_esfahan">Esfahan:</label>
											<select id="missile_strike_1_target_esfahan" name="missile_strike_1_esfahan">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>

											<label for="missile_strike_1_target_fordow">Fordow:</label>
											<select id="missile_strike_1_target_fordow" name="missile_strike_1_fordow">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>

											<label for="missile_strike_1_target_natanz">Natanz:</label>
											<select id="missile_strike_1_target_natanz" name="missile_strike_1_natanz">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td>
									<p><b>Cyber Attack 2</b></p>
									<!-- Radio Buttons for Cyber Attack Methods -->
									<input type="radio" name="cyber_attack_2" id="cyber_attack_2_none" value="None" checked>
									<label for="cyber_attack_2_none">None</label><br>

									<input type="radio" name="cyber_attack_2" id="cyber_attack_2_c2" value="C2">
									<label for="cyber_attack_2_c2">Iranian Command and Control Network</label><br>

									<input type="radio" name="cyber_attack_2" id="cyber_attack_2_air_defenses" value="IADS">
									<label for="cyber_attack_2_air_defenses">Iranian Air Defenses Network</label><br>

									<input type="radio" name="cyber_attack_2" id="cyber_attack_2_false_contacts" value="False_Contacts">
									<label for="cyber_attack_2_false_contacts">Iranian Sensor Network (False Contacts)</label><br>

									<input type="radio" name="cyber_attack_2" id="cyber_attack_2_missile_strike" value="Missile_Strike">
									<label for="cyber_attack_2_missile_strike">Iranian Sensor Network (False Missile Strike)</label><br>

									<!-- Position Selector for False Contacts -->
									<div id="cyber_attack_2_position_selector" class="hidden">
										<p>False Contact(s) Starting/Launch Position</p>
										<select name="cyber_attack_2_position">
											<option value="West">West</option>
											<option value="Southwest">Southwest</option>
											<option value="South">South</option>
											<option value="Southeast">Southeast</option>
										</select>
									</div>

									<!-- Target Selector for False Missile Strike -->
									<div id="cyber_attack_2_missile_target_selector" class="hidden">
										<p>Target Selection for False Missile Strike</p>
										<div class="target-row">
											<label for="missile_strike_2_target_arak">Arak:</label>
											<select id="missile_strike_2_target_arak" name="missile_strike_2_arak">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>

											<label for="missile_strike_2_target_esfahan">Esfahan:</label>
											<select id="missile_strike_2_target_esfahan" name="missile_strike_2_esfahan">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>

											<label for="missile_strike_2_target_fordow">Fordow:</label>
											<select id="missile_strike_2_target_fordow" name="missile_strike_2_fordow">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>

											<label for="missile_strike_2_target_natanz">Natanz:</label>
											<select id="missile_strike_2_target_natanz" name="missile_strike_2_natanz">
												<option value="No">No</option>
												<option value="Yes">Yes</option>
											</select>
										</div>
									</div>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</body>
		</html>
	]]

	local form = UI_CallAdvancedHTMLDialog('Title', msg, {'Done'})
	if form['pressed'] and form['pressed'] == 'Done' then
		if PlayerCyberChance > 0 then
			local cyberAction_01 = string.gsub(form['cyber_attack_1'], "%'", "")
			if cyberAction_01 == 'C2' then
				PlayerAttackIranianCommandAndControlNetwork()
			elseif cyberAction_01 == 'IADS' then
				PlayerAttackIranianCommunicationsNetwork()
			elseif cyberAction_01 == 'False_Contacts' then
				local position = {}
				local decoyHeading = 0

				local positionInput = string.gsub(form['cyber_attack_1_position'], "%'", "")
				if positionInput == 'West' then
					position = {latitude=33.0, longitude=43.0, maxRange=100}
					decoyHeading = 90
				elseif positionInput == 'Southwest' then
					position = {latitude=29.0, longitude=45.0, maxRange=100}
					decoyHeading = 45
				elseif positionInput == 'South' then
					position = {latitude=25.0, longitude=50.0, maxRange=100}
					decoyHeading = 0
				elseif positionInput == 'Southeast' then
					position = {latitude=23.0, longitude=57.0, maxRange=100}
					decoyHeading = 315
				end

				PlayerAttackIranianSensorNetwork_FalseContacts(position, decoyHeading)
			elseif cyberAction_01 == 'Missile_Strike' then
				local targetList = {}
				local centerPoint = {}

				local targetOptions = {
					{form='missile_strike_1_arak', unitName='Arak Heavy Water Production Plant'},
					{form='missile_strike_1_esfahan', unitName='Esfahãn Uranium Conversion Facility'},
					{form='missile_strike_1_fordow', unitName='Fordow Fuel Enrichment Plant'},
					{form='missile_strike_1_natanz', unitName='Natanz Fuel Enrichment Plant'}
				}

				for _,target in ipairs(targetOptions) do
					local targetInput = string.gsub(form[target.form], "%'", "")
					if targetInput == 'Yes' then
						local targetData = ScenEdit_GetContact({side='Decoys-False Contacts', name=target.unitName})
						table.insert(targetList, targetData.guid)
					end
				end

				local positionInput = string.gsub(form['cyber_attack_1_position'], "%'", "")
				if positionInput  == 'West' then
					position = {latitude=33.0, longitude=43.0, maxRange=0}
				elseif positionInput  == 'Southwest' then
					position = {latitude=29.0, longitude=45.0, maxRange=0}
				elseif positionInput  == 'South' then
					position = {latitude=25.0, longitude=50.0, maxRange=0}
				elseif positionInput  == 'Southeast' then
					position = {latitude=23.0, longitude=57.0, maxRange=0}
				end

				for _,target in ipairs(targetList) do
					PlayerCyberAttackIranianSensors_FalseMissileStrike(target, position)
				end
			end

			local cyberAction_02 = string.gsub(form['cyber_attack_2'], "%'", "")
			if cyberAction_02 == 'C2' then
				PlayerAttackIranianCommandAndControlNetwork()
			elseif cyberAction_02 == 'IADS' then
				PlayerAttackIranianCommunicationsNetwork()
			elseif cyberAction_02 == 'False_Contacts' then
				local position = {}
				local decoyHeading = 0

				local positionInput = string.gsub(form['cyber_attack_2_position'], "%'", "")
				if positionInput == 'West' then
					position = {latitude=33.0, longitude=43.0, maxRange=100}
					decoyHeading = 90
				elseif positionInput == 'Southwest' then
					position = {latitude=29.0, longitude=45.0, maxRange=100}
					decoyHeading = 45
				elseif positionInput == 'South' then
					position = {latitude=25.0, longitude=50.0, maxRange=100}
					decoyHeading = 0
				elseif positionInput == 'Southeast' then
					position = {latitude=23.0, longitude=57.0, maxRange=100}
					decoyHeading = 315
				end

				PlayerAttackIranianSensorNetwork_FalseContacts(position, decoyHeading)
			elseif cyberAction_02 == 'Missile_Strike' then
				local targetList = {}
				local centerPoint = {}

				local targetOptions = {
					{form='missile_strike_2_arak', unitName='Arak Heavy Water Production Plant'},
					{form='missile_strike_2_esfahan', unitName='Esfahãn Uranium Conversion Facility'},
					{form='missile_strike_2_fordow', unitName='Fordow Fuel Enrichment Plant'},
					{form='missile_strike_2_natanz', unitName='Natanz Fuel Enrichment Plant'}
				}

				for _,target in ipairs(targetOptions) do
					local targetInput = string.gsub(form[target.form], "%'", "")
					if targetInput == 'Yes' then
						local targetData = ScenEdit_GetContact({side='Decoys-False Contacts', name=target.unitName})
						table.insert(targetList, targetData.guid)
					end
				end

				local positionInput = string.gsub(form['cyber_attack_2_position'], "%'", "")
				if positionInput  == 'West' then
					position = {latitude=33.0, longitude=43.0, maxRange=0}
				elseif positionInput  == 'Southwest' then
					position = {latitude=29.0, longitude=45.0, maxRange=0}
				elseif positionInput  == 'South' then
					position = {latitude=25.0, longitude=50.0, maxRange=0}
				elseif positionInput  == 'Southeast' then
					position = {latitude=23.0, longitude=57.0, maxRange=0}
				end

				for _,target in ipairs(targetList) do
					PlayerCyberAttackIranianSensors_FalseMissileStrike(target, position)
				end
			end
		else
			-- Iran has adapted to our cyber efforts or player cyber resources exhausted
		end
	end
end

-- Complete scenario setup script
ScenarioSetup()

