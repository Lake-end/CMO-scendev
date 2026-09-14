 --PAFMM Spawner

local shipType = {

    {dbid = 339, chance = 0.1, namePrefix = "Large tanker"}, -- 

    {dbid = 222, chance = 0.1, namePrefix = "LNG/LPG tanker"}, -- 

    {dbid = 2024, chance = 0.1, namePrefix = "Cruise liner"}, --

    {dbid = 1599, chance = 0.1, namePrefix = "RO/RO vessel"}, --

    {dbid = 773 , chance = 0.1, namePrefix = "Dry-Bulk carrier"}, --

    {dbid = 775, chance = 0.1, namePrefix = "Feeder"}, -- 
    
    {dbid = 2030, chance = 0.1, namePrefix = "Coaster"}, -- 
    
    {dbid = 2359, chance = 0.1, namePrefix = "Trawler"}, -- 

    {dbid = 2033, chance = 0.1, namePrefix = "Tug"}, -- 

    {dbid = 2026, chance = 0.1, namePrefix = "Small feeder"}, -- 

}

local scenarioCounter = 0


local function runScenario(referencePointName)

    local point = ScenEdit_GetReferencePoint({ side="sip", name=referencePointName})

    local x_latitude = point.latitude

    local x_longitude = point.longitude


    local function CircularRandomPosition(x_latitude, x_longitude, max_radius)

        local randomisationCircle = World_GetCircleFromPoint({

            latitude=x_latitude,

            longitude=x_longitude,

            radius=(math.random(0,max_radius*10)/10),

            numpoints = 72})

        local randomisedPoint = randomisationCircle[math.random(1,#randomisationCircle)]

        return randomisedPoint

    end


    function spawnShip(shipNumber, shipType, x_latitude, x_longitude)

        local randomNumber = math.random()

        local cumulativeChance = 0

        local position = CircularRandomPosition(x_latitude, x_longitude, 20)

        local RandomShipNumber = shipNumber + math.random(1,99)


        for _, ship in ipairs(shipType) do

            cumulativeChance = cumulativeChance + ship.chance


            math.randomseed(os.time() + scenarioCounter)

            scenarioCounter = scenarioCounter + 1


            if randomNumber <= cumulativeChance then

                local shipPrefix = ship.namePrefix
                local shipName = shipPrefix..' 0' .. RandomShipNumber

                ScenEdit_AddUnit({type ='Ship', name = shipName, dbid = ship.dbid, side ='sip', Lat= position.latitude, Lon=position.longitude})  -- Corrected dbid access

                ScenEdit_AssignUnitToMission(shipName, "BS Mission")



                return

            end

        end

    end


    local numberOfShipToSpawn = math.random(2, 5) 


    for i = 1, numberOfShipToSpawn do

        spawnShip(i, shipType, x_latitude, x_longitude) 

    end

end


-- Call the function with different ReferencePoints
runScenario("RP-90")

runScenario("RP-91")

runScenario("RP-92")

runScenario("RP-93")

runScenario("RP-94") 

runScenario("RP-95")

runScenario("RP-96")

runScenario("RP-97")   

