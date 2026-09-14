-- 1. DEFINE THE SPECIAL ACTION SCRIPT AS A STRING

local inspectionList = {

--[[     {name='Rovanniemen lentoasema (Rovanniemi airport)', guid='W8V2DT-0HNHJ3HMMD1K6'}
    {name='Kuopion lentoasema (Kuopio airport)', guid='W8V2DT-0HNHJ3HMMAH7H'}
{name='Jyväskylä-Tikkakoski lentoasema (Jyväskylä-Tikkakoski airport)', guid='W8V2DT-0HNHJ3HMMCK4A'}
{name='Hallin lentoasema (Halli airport)', guid='W8V2DT-0HNHJ3HMMCI9S'}
{name='Tampere-Pirkkala lentoasema (Tampere-Pirkkala airport)', guid='W8V2DT-0HNHGPUM8KC27'}
{name='Utin lentoasema (Utti airport)', guid='W8V2DT-0HNHJ3HMMR945'}
{name='Helsinki-Vantaa lentoasema (Helsinki-Vantaa airport)', guid='W8V2DT-0HNHJ3HMMI8EH'}
{name='Kaartin Jääkärirykmentti (Kaarti Guards regiment)', guid='W8V2DT-0HNJNS145O6M3'}
{name='Upinniemen tukikohta (Upinniemi naval base)', guid='W8V2DT-0HNJIM5NL172J'}
{name='Dragsvik Raasepori (Uudenmaan Prikaati + heli FARP)', guid='W8V2DT-0HNJNS145N9C7'}
{name='Pansion tukikohta (Pansio naval base)', guid='W8V2DT-0HNJIM5NL19FP'}
{name='Port of Marienhamn', guid='W8V2DT-0HNJNS145T1PJ'} ]]


        { guid = 'W8V2DT-0HNHJ3HMMD1K6', msg = "Rovaniemi Airfield (EFRO)\n\n Serving as the primary operational hub for Lapland Air Command, Rovaniemi is the strategic cornerstone of Northern Finland’s defense. It is the home base for the  HävLLv 11 squadron and its F-35A Lightning II stealth fighters." },

        { guid = 'W8V2DT-0HNHJ3HMMAH7H', msg = "Kuopio Airfield (EFKU)\n\n Kuopio is the most critical operational hub for the defense of Eastern Finland. Its proximity to the border means that any aircraft taking off are immediately within the engagement envelope of Russian S-400 Triumf SAM systems." },

        { guid = 'W8V2DT-0HNHJ3HMMCK4A', msg = "Jyväskylä-Tikkakoski Airfield (EFJY)\n\n As the headquarters of the Finnish Air Force Command and the Air Force Academy, Tikkakoski serves as the nation’s primary air operations command and control hub. The base currently hosts six two-seat F/A-18D Hornets." },

        { guid = 'W8V2DT-0HNHJ3HMMCI9S', msg = "Halli Airfield (EFHA)\n\n Primarily used for training and maintenance, Halli no longer hosts permanent fighter detachments but frequently serves as a high-readiness forward operating site. The base maintains pre-positioned material and infrastructure, allowing for rapid activation and combat sorties on short notice. However, like other main military airfields, its coordinates are well-known to the adversary, making it a certain target." },

        { guid = 'W8V2DT-0HNHGPUM8KC27', msg = "Tampere-Pirkkala Airfield (EFTP)\n\n Serving as the strategic hub for Southern Finland’s air defense, Pirkkala is home to the Satakunta Air Command and the nation's second F-35A Lightning II squadron. The base hosts a versatile fleet including C-295M transport aircraft, six F/A-18C Hornets, and Finland’s most critical airborne intelligence asset, the C-295M CC-1 ELINT aircraft." },

        { guid = 'W8V2DT-0HNHJ3HMMR945', msg = "Utti Air Base (EFUT)\n\n Serving as the primary home for the Utti Jaeger Regiment and the Air Force’s rotary-wing assets, Utti is the center of gravity for Finland's special operations and airborne tactical mobility." },

        { guid = 'W8V2DT-0HNHJ3HMMI8EH', msg = "Helsinki-Vantaa Airport (EFHK)\n\n While Helsinki-Vantaa hosts no permanent military fighter units, it remains Finland’s most critical node for civil aviation, logistics, and national connectivity. Its proximity to the capital and key government infrastructure makes it a primary target for adversary 'decapitation' strikes intended to disrupt national leadership and paralyze civil logistics." },

        { guid = 'W8V2DT-0HNJNS145O6M3', msg = "Santahamina Garrison\n\n As the primary base for the Guard Jaeger Regiment (Kaartin jääkärirykmentti), Santahamina serves as the backbone of the capital region's ground defense. It is the home of the special Urban Warfare Company (VYKS), whose primary mission is to protect vital government functions and secure the metropolitan area during crises." },

        { guid = 'W8V2DT-0HNJIM5NL172J', msg = "Upinniemi serves as the home port for the Finnish Navy 7th Missile Squadron and is the primary maritime hub for the Gulf of Finland. The base anchors the surface combatant fleet, including the FNS Pohjanmaa-led task force, which maintains high-readiness status for rapid-response and anti-surface warfare missions." },

        { guid = 'W8V2DT-0HNJNS145N9C7', msg = "Dragsvik Garrison (Raasepori)\n\n As the home of the Nyland Brigade, Dragsvik is the heart of Finland’s amphibious warfare capability. It serves as the base for the Amphibious Task Unit (ATU), a high-readiness Coastal Jaegers specializing in littoral combat and maritime power projection." },

        { guid = 'W8V2DT-0HNJIM5NL19FP', msg = "Pansio Naval Base \n\n Serving as the home port for the Finnish Navy 6th Missile Squadron, Pansio is the vital operational hub for maritime defense in the Archipelago Sea and the Åland Islands. It currently anchors the task force led by the FNS Hämeenmaa. Furher out on the sea vectoring towards Mariehamn is the Coast Guard vessel Turva. The ship is conducting a high-priority, covert operation escorting a chartered sealift transport." },
       
        { guid = 'W8V2DT-0HNJNS145T1PJ', msg = "Mariehamn, Åland Islands\n\n Despite its legal demilitarized status, the strategic importance of the Åland Islands cannot be overstated as they effectively command the maritime transit corridors of the Northern Baltic Sea. Because of its central location, the archipelago serves as a critical geographic pivot point; control over these islands allows an adversary to project power across the entire Gulf of Bothnia and most of the Baltic Sea, and disrupt vital sea lines of communication. In the current theater, the island's vulnerability to 'gray zone' operations and rapid, unsanctioned military seizure remains a primary concern for the security of both the Finnish mainland and the wider NATO maritime flank." },
        

    }


    for i, item in ipairs(inspectionList) do

        local unit = ScenEdit_GetUnit({guid = item.guid})

        if unit then

            UI_SetCameraView(unit.latitude, unit.longitude, 5000)

            local displayMsg = "UNIT: " .. unit.name .. " (" .. i .. "/17)\n\n" .. item.msg .. "\n\n(Press OK for next, Abort to stop)"

            local response = ScenEdit_MsgBox(displayMsg, 1)

            if response == 'Cancel' then

                print("Inspection halted by user.")

                break

            end


        end

    end




-- 2. CREATE THE SPECIAL ACTION

ScenEdit_AddSpecialAction({
    ActionNameOrID = 'Inspect Strategic Units5',
    description = 'Cycles camera through units with unique situational reports.',
    Side = 'NATO',
    IsActive = true,
    IsRepeatable = true,
    script = actionScript
})