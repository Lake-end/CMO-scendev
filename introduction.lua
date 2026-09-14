-- 1. DEFINE THE SPECIAL ACTION SCRIPT AS A STRING

local inspectionList = {

--[[     
{name='Õhuväe Kopteribaas CHARLIE (FOB)', guid='W8V2DT-0HNO212JFI44P'}
{name='Riga Strategic Command & Bridges', guid='W8V2DT-0HNNV7U6OHUJT'}
{name='3-oji Oro gynybos baterija / Oro gynybos batalionas(NASAMS III)', guid='W8V2DT-0HNNT705P8CF9'}

{name='F16 KORPEN #1', guid='W8V2DT-0HNNT705P6TFQ'}
{name='32º Stormo PREDATOR #1', guid='W8V2DT-0HNNT705P6T3H'}
{name='NAEWCF SENTRY #1', guid='W8V2DT-0HNNT705P6SDG'}
{name='F16 KORPEN #1', guid='W8V2DT-0HNNT705P6TFQ'}
{name='32º Stormo PREDATOR #1', guid='W8V2DT-0HNNT705P6T3H'}

]]


        { guid = 'W8V2DT-0HNO212JFI44P', msg = "ESTONIA \n\n Ämari Air Base (EEEI) \n\n Primary aerial staging ground for NATO operations in Estonia, Ämari is a high-value target defended by a Dutch Patriot battery. The airbase houses six German TLwG 71 Eurofighter Typhoons, alongside a contingent of Bayraktar drones tasked with persistent reconnaissance and precision strikes. \n\nCamp Tapa\n\n As the center of gravity for Estonia's ground defense, Camp Tapa hosts the Estonian 1st Brigade and a reinforced NATO multinational presence: UK heavy brigade, supported by a French combined arms battalion, further reinforced by Swedish mechanized infantry company and a highly specialized company of Finnish Coastal Jaegers.\n\nHelicopter Forward Operating Bases\n\nThe UK Army Air Corps has dispersed its rotary-wing assets away from centralized garrisons. British AH-64E Apaches and AW159 Wildcats have been forward-deployed to two hidden helicopter FOBs (Forward Operating Bases), standing by to provide rapid anti-armor fires and armed reconnaissance." },

        { guid = 'W8V2DT-0HNNV7U6OHUJT', msg = "LATVIA \n\n Lielvārde Airbase (EVGA) \n\n Central rotary-wing hub for NATO in Latvia, Lielvārde is protected by French SAMP/T surface-to-air missile battery. The base houses Canadian CH-147F Chinooks of 450 Squadron and CH-146 Griffons of 430 Squadron, alongside French 1er RHC EC665 Tiger attack helicopters and Gazelles, with tactical reconnaissance support provided by four Luna NG UAVs. \n\n Forward Operating Base Rēzekne\n\n Covert helicopter staging area has been established deep within the forests west of Rēzekne. This dispersed forward operating base allows NATO rotary-wing elements to rapidly respond to border incursions while remaining hidden from preemptive ballistic missile strikes. \n\n Camp Ādaži\n\n Camp Ādaži hosts a massively expanded multinational presence led by Canadian mechanized brigade, reinforced by two multinational heavy maneuver battalions. \n\n Rukla Garrison \n\n Situated in central Lithuania, this critical military installation serves as the headquarters and primary staging ground for the Mechanized Infantry Brigade Iron Wolf." },

        { guid = 'W8V2DT-0HNNT705P8CF9', msg = "LITHUANIA \n\n Šiauliai Air Base (EYSA) \n\nThe airbase hosts four Portuguese F-16AM Falcon MLUs and four Spanish EF-18M fighters, augmented by four heavy Bayraktar Akinci UCAVs for long-endurance strike and surveillance. The installation is defended by a layered surface-to-air network combining a Spanish NASAMS II battery and a Lithuanian NASAMS III system.\n\nRūdninkai Garrison\n\nSituated precariously close to the Belarusian border, Rūdninkai is the heavily fortified home of the German Panzerbrigade 45, bolstered by a Polish armored battalion, alongside supporting mechanized companies from the Netherlands and France. The garrison is shielded by a German Patriot battery. The base also acts as the primary staging ground for an aviation element comprising eight German EC665 Tiger UHT attack helicopters and four NH90 TTH tactical transports.\n\nForward Operating Base Kaunas\n\nCovert Forward Operating Base has been prepared in the dense forests north of Kaunas." },

        { guid = 'W8V2DT-0HNNT705P6SDG', msg = "A NATO E-3A Sentry(NAEWCF SENTRY #1) out of Geilenkirchen Air Base has been assigned to cover the Baltics AOE aerial early warning and command duties. Operating from a safe standoff distance, it provides critical deep radar coverage to detect hostile air traffic and incoming cruise missiles." },
        
        { guid = 'W8V2DT-0HNNT705P6TFQ', msg = "Swedish S 102B Korpen has been assigned to gather critical electronic intelligence (ELINT) across the Baltic area of operations. By intercepting hostile radar and communication emissions, it provides vital early warning of enemy air defense activations and command network activities." },

        { guid = 'W8V2DT-0HNNT705P6TFQ', msg = "An Italian Air Force MQ-9A Reaper from the 32º Stormo, has been tasked with persistent intelligence, surveillance, and reconnaissance duties across the Baltics AOE. Loitering high above the theatre, it provides critical real-time targeting data and overwatch for allied forces on the ground." }
      

    }

    local latOffset = -0.5 
    local lonOffset = 0.0
    
    for i, item in ipairs(inspectionList) do

        local unit = ScenEdit_GetUnit({guid = item.guid})

        if unit then

            UI_SetCameraView(unit.latitude + latOffset, unit.longitude + lonOffset, 500000)

            local displayMsg = " (" .. i .. "/6)\n\n" .. item.msg .. "\n\n(Press OK for next, Abort to stop)"

            local response = ScenEdit_MsgBox(displayMsg, 1)

            if response == 'Cancel' then

                print("Inspection halted by user.")

                break

            end


        end

    end

