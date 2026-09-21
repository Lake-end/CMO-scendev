--DataInit-lua
bL3={}
bL3.JSON = {}
bL3.JSON.UNITS = [[
{
  "AIR FIGHTERS": [
    {
      "size": 4,
      "value": 130,  
      "info": {
        "img": "https://i.imgur.com/LpskvuH.jpeg",
        "information": "<p>The F-15EX is a modernized air superiority fighter with advanced avionics and enhanced payload capacity. It excels in air-to-air combat and can carry a wide range of missiles and bombs, making it a versatile asset for maintaining air dominance.</p>"
      },
      "unit_name": "F-15EX",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "F-15EX Eagle II",
      "unit_dbid": 4771,
      "unit_type": "Aircraft"
    },
    {
      "size": 2,
      "value": 40,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c8/2024-07-21_Pitch_Black_Flypast_003.jpg/1024px-2024-07-21_Pitch_Black_Flypast_003.jpg",
        "information": "<p>The FA-50H is a light-aircraft supersonic fighter similar to F-16 but with only 80% of it's size. It can carry the AIM-9L-1 WVR AAM and for A/S GBU-38</p>"
      },
      "unit_name": "FA-50",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "FA-50 Golden Eagle",
      "unit_type": "Aircraft",
      "unit_dbid": 6905
    },
    {
      "size": 2,
      "value": 50,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/b/ba/94-0042_Lockheed_Martin_F-16CM_Fighting_Falcon_%289980385494%29.jpg",
        "information": "<p>The F-16CM Blk 50 is a multirole fighter known for its agility and advanced targeting systems. It is capable of performing both air-to-air and air-to-ground missions, providing flexibility and reliability in various combat scenarios.</p>"
      },
      "unit_name": "F-16CM",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "F-16CM Blk 50 Falcon",
      "unit_type": "Aircraft",
      "unit_dbid": 4612
    },
    {
      "size": 2,
      "value": 140,  
      "info": {
        "img": "https://i.imgur.com/fEwM3pX.jpeg",
        "information": "<p>The F-35A is a stealth multirole fighter equipped with cutting-edge sensors and avionics. It is designed for air superiority, ground attack, and reconnaissance missions, offering unparalleled situational awareness and network-centric capabilities.</p>"
      },
      "unit_name": "F-35A",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "F-35A Lightning II",
      "unit_type": "Aircraft",
      "unit_dbid": 3835
    },
    {
      "size": 4,
      "value": 100,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/b/b1/U.S._Navy_EA-18G_Growler_breaks_away_from_a_U.S._Air_Force_KC-135_%28altered%29.jpg",
        "information": "<p>The EA-18G Growler is an electronic warfare aircraft designed to suppress enemy air defenses. It provides critical support by jamming radar and communications, ensuring the success of allied air operations.</p>"
      },
      "unit_name": "EA-18G",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "EA-18G Growler",
      "unit_type": "Aircraft",
      "unit_dbid": 4879
    },
    {
      "size": 4,
      "value": 170,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/1/1e/F-22_Raptor_edit1_%28cropped%29.jpg",
        "information": "<p>The F-22A Raptor is a fifth-generation stealth fighter with unmatched air superiority capabilities. It features advanced avionics, supercruise capability, and highly integrated sensor systems, making it a formidable force in modern aerial combat.</p>"
      },
      "unit_name": "F-22",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "F-22A Raptor",
      "unit_type": "Aircraft",
      "unit_dbid": 4875
    },
    {
      "size": 4,
      "value": 60,  
      "info": {
        "img": "https://i.imgur.com/6LNWGBH.jpeg",
        "information": "<p>The F-15C Eagle is a highly maneuverable air superiority fighter designed to maintain control of the airspace. It is equipped with advanced radar and missile systems, ensuring dominance in aerial engagements.</p>"
      },
      "unit_name": "F-15C",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "F-15C Eagle",
      "unit_type": "Aircraft",
      "unit_dbid": 4919
    },
    {
      "size": 4,
      "value": 145,  
      "info": {
        "img": "https://i.imgur.com/vP1uOdw.jpeg",
        "information": "<p>The F-35B is a stealth multirole fighter designed to operate in short take off vertical landing enviroments. It is designed for air superiority, ground attack, and reconnaissance missions, offering unparalleled situational awareness and network-centric capabilities</p>"
      },
      "unit_name": "F-35B",
      "type": "AIR FIGHTERS",
      "icon": "fighter",
      "description": "F-35 B",
      "unit_type": "Aircraft",
      "unit_dbid": 4701
    }
  ],
  "AIR SUPPORT": [
    {
      "size": 8,
      "value": 70,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/E-7A_Wedgetail_assigned_to_RAAF_Base%2C_lands_at_Nellis_Air_Force_Base.jpg/1920px-E-7A_Wedgetail_assigned_to_RAAF_Base%2C_lands_at_Nellis_Air_Force_Base.jpg",
        "information": "<p>The E-7A Wedgetail is an airborne early warning and control aircraft equipped with advanced radar systems. It provides comprehensive situational awareness, command and control capabilities to enhance air operations.</p>"
      },
      "unit_name": "E-7",
      "type": "AIR SUPPORT",
      "icon": "support",
      "description": "E-7A Wedgetail",
      "unit_type": "Aircraft",
      "unit_dbid": 5436
    },
    {
      "size": 8,
      "value": 60,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Usaf.e3sentry.750pix.jpg/1200px-Usaf.e3sentry.750pix.jpg",
        "information": "<p>The E-3G Sentry is a versatile airborne warning and control system (AWACS) aircraft. It provides real-time intelligence, surveillance, and reconnaissance (ISR) data, facilitating coordinated air and ground operations.</p>"
      },
      "unit_name": "E-3G",
      "type": "AIR SUPPORT",
      "icon": "support",
      "description": "E-3G Sentry",
      "unit_type": "Aircraft",
      "unit_dbid": 3853
    },
    {
      "size": 8,
      "value": 90,  
      "info": {
        "img": "https://i.imgur.com/9OUf1wg.png",
        "information": "<p>The RQ-180 is an advanced stealth UAV ISR platform that provides real-time intelligence</p>"
      },
      "unit_name": "RQ-180",
      "type": "AIR SUPPORT",
      "icon": "support",
      "description": "RQ-180",
      "unit_type": "Aircraft",
      "unit_dbid": 4328
    },
    {
      "size": 8,
      "value": 15,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/7/78/KC-46_Pegasus_prepares_to_refuel_C-17_%28cropped%29.jpg",
        "information": "<p>The KC-46A Pegasus is a strategic and aerial refueling aircraft. It provides in-flight refueling capabilities to extend the range and endurance of combat and support aircraft, enhancing operational flexibility.</p>"
      },
      "unit_name": "KC-46A",
      "type": "AIR SUPPORT",
      "icon": "support",
      "description": "KC-46A Pegasus",
      "unit_type": "Aircraft",
      "unit_dbid": 6620
    },
    {
      "size": 8,
      "value": 50,  
      "info": {
        "img": "https://media.defense.gov/2021/Sep/30/2002865072/-1/-1/0/190508-F-OQ776-9036.JPG",
        "information": "<p>The RC-135S Cobra Ball is a reconnaissance aircraft specialized in ballistic missile tracking. It gathers and analyzes data on missile launches, providing critical information for missile defense and strategic planning.</p>"
      },
      "unit_name": "RC-135S",
      "type": "AIR SUPPORT",
      "icon": "support",
      "maxLimit": 2,
      "description": "RC-135S Cobra Ball",
      "unit_type": "Aircraft",
      "unit_dbid": 5877
    },
    {
      "size": 8,
      "value": 50,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/3/3f/US_Navy_P-8_Poseidon_taking_off_at_Perth_Airport.jpg",
        "information": "<p>The P-8 operates in anti-submarine warfare (ASW), anti-surface warfare (ASUW), and intelligence, surveillance and reconnaissance (ISR) roles. It is armed with torpedoes, Harpoon anti-ship missiles, and other weapons, can drop and monitor sonobuoys, and can operate in conjunction with other assets</p>"
      },
      "unit_name": "P-8",
      "type": "AIR SUPPORT",
      "icon": "support",
      "maxLimit": 3,
      "description": "P-8 Poseidon",
      "unit_type": "Aircraft",
      "unit_dbid": 5759
    },
    {
      "size": 8,
      "value": 45,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/3/3a/EA-37B_Aircraft.png",
        "information": "<p>The EA-37B Compass Call is an electronic warfare aircraft designed to disrupt enemy communications and radar systems. It plays a vital role in electronic attack missions, ensuring dominance in the electromagnetic spectrum.</p>"
      },
      "unit_name": "EA-37",
      "type": "AIR SUPPORT",
      "icon": "support",
      "maxLimit": 3,
      "description": "EA-37B Compass Call",
      "unit_type": "Aircraft",
      "unit_dbid": 4883
    },
    {
      "size": 8,
      "value": 50,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/B-52_Stratofortress_assigned_to_the_307th_Bomb_Wing_%28cropped%29.jpg/1920px-B-52_Stratofortress_assigned_to_the_307th_Bomb_Wing_%28cropped%29.jpg",
        "information": "<p>The B-52 is a long-range, subsonic, jet-powered strategic bomber.</p>"
      },
      "unit_name": "B-52",
      "type": "AIR SUPPORT",
      "icon": "support",
      "description": "B-52 H",
      "unit_dbid": 4893,
      "unit_type": "Aircraft",
      "maxLimit": 2
    }
    
    
  ],
  "SUBMARINE":[
    {
      "range":860,
      "value": 800,
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/USS_Jimmy_Carter_SSN_23.jpg/1200px-USS_Jimmy_Carter_SSN_23.jpg",
        "information": "<p></p><b>Weapons:</b><ul><li>12x UGM-109I MMT</li><li>24x Mk48</li></ul>"
      },
      "unit_name": "SSN Seawolf",
      "type": "SUBMARINE",
      "icon": "ssna",
      "description": "SSN SeaWolf",
      "unit_type": "Submarine",
      "unit_dbid": 567,
      "maxLimit": 1
    },
    {
      "range":860,
      "value": 600,
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bb/US_Navy_040730-N-1234E-002_PCU_Virginia_%28SSN_774%29_returns_to_the_General_Dynamics_Electric_Boat_shipyard.jpg/1920px-US_Navy_040730-N-1234E-002_PCU_Virginia_%28SSN_774%29_returns_to_the_General_Dynamics_Electric_Boat_shipyard.jpg",
        "information": "<p></p><b>Weapons:</b><ul><li>14x UGM-109I MMT</li><li>22x Mk48</li></ul>"
      },
      "unit_name": "SSN Virginia",
      "type": "SUBMARINE",
      "icon": "ssna",
      "description": "SSN Virginia Class IV",
      "unit_dbid": 554,
      "unit_type": "Submarine",
      "maxLimit": 1
    },
  ],
  "SHIP": [
    {
      "range":240,
      "value": 500,
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/9/93/USS_Arleigh_Burke_%28DDG_51%29_steams_through_the_Mediterranean_Sea.jpg",
        "information": "<p>The Arleigh Burke Flight III (DDG FIII) is a versatile guided-missile destroyer, equipped with advanced radar and weapon systems for multi-mission capability. With powerful Aegis-based air and missile defense, it ensures robust protection and strike capability across maritime and aerial threats.</p><b>Weapons:</b><ul><li>32x ESSM</li><li>24x SM-2MR BlkIIIB</li><li>42x SM-6 BlkIA</li><li>12x SM-3 BlkIB</li><li>6x SM-3 BlkIIA</li></ul>"
      },
      "unit_name": "DDG FIII",
      "type": "SHIP",
      "icon": "dd",
      "description": "Arleigh Burke Flight III",
      "unit_type": "Ship",
      "maxLimit": 2,
      "unit_dbid": 2718
      
    },
    {
      "range":35,
      "size": 3,
      "value": 200,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/BRP_Miguel_Malvar_FF-06.jpg/1920px-BRP_Miguel_Malvar_FF-06.jpg",
        "information": "<p>The FF 06 Miguel Malvar is a frigate designed for versatile naval operations, including anti-submarine warfare, surface combat, and maritime patrol. It is equipped with advanced weaponry and sensor systems to ensure maritime security.</p><p><b>Weapons</b><ul><li>RIM-162B ESSM</li></ul>"
      },
      "unit_name": "FF 06",
      "type": "SHIP",
      "icon": "ff",
      "description": "FF 06 Miguel Malvar [HDC-3100 Class]",
      "unit_type": "Ship",
      "unit_dbid": 4645
    }
  ],
  "RADAR": [
    {
      "range":300,
      "size": 1,
      "value": 40,  
      "info": {
        "img": "https://i.imgur.com/b8kpAtB.jpeg",
        "information": "<p>The AN/FPS-117 is a long-range surveillance radar system used for air defense and early warning. It provides critical data for tracking and identifying airborne threats.</p>"
      },
      "unit_name": "FPS-117",
      "type": "RADAR",
      "icon": "radar",
      "description": "Radar (AN/FPS-117)",
      "unit_type": "Facility",
      "unit_dbid": 962
    },
    {
      "range":300,
      "size": 1,
      "value": 60,  
      "info": {
        "img": "https://i.imgur.com/b8kpAtB.jpeg",
        "information": "<p>The J/FPS-3ME is a long-range 3D AESA (Active Electronically Scanned Array) air surveillance radar system capable of simultaneous detection and tracking of multiple aerial targets. The system is a new and improved version of the J/FPS-3, which has been in use by the Japan Air Self-Defense Force for over 30 years.</p>"
      },
      "unit_name": "FPS-3ME",
      "type": "RADAR",
      "icon": "radar",
      "description": "Radar (J/FPS-3ME)",
      "unit_type": "Facility",
      "unit_dbid": 3656
    },
    {
      "range":260,
      "size": 1,
      "value": 35,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/INS_Satpura_-_ELM-2238_Radar.jpg/1200px-INS_Satpura_-_ELM-2238_Radar.jpg",
        "information": "<p>The EL/M-2238 3D-STAR is a multi-purpose air and surface-search naval radar system. Has a range about 280nmi.</p>"
      },
      "unit_name": "ELM-2288ER AD-STAR",
      "type": "RADAR",
      "icon": "radar",
      "description": "Radar (ELM-2288ER AD-STAR)",
      "unit_type": "Facility",
      "unit_dbid": 4034
    },
    
    {
      "range":300,
      "size": 1,
      "value": 80,  
      "info": {
        "img": "https://www.radartutorial.eu/19.kartei/02.surv2/pic/img022-003-01.jpg",
        "information": "<p>The AN/TPY-4 is a high-resolution radar system designed for ballistic missile defense and airspace surveillance. It plays a crucial role in detecting and tracking missile threats at long ranges.</p>"
      },
      "unit_name": "TPY-4",
      "type": "RADAR",
      "icon": "radar",
      "description": "Radar (AN/TPY-4) 3DELRR, RAT-31 Replacement",
      "unit_type": "Facility",
      "unit_dbid": 4289
    },
    {
      "range":150,
      "size": 1,
      "value": 30,  
      "info": {
        "img": "https://i.imgur.com/WbwIXHo.jpeg",
        "information": "<p>The AN/TPS-80 G/ATOR is a mobile radar system used for air surveillance and target acquisition. It provides real-time data to support air operations and enhance situational awareness.</p>"
      },
      "unit_name": "TPS-80",
      "type": "RADAR",
      "icon": "radar",
      "description": "Radar (AN/TPS-80 G/ATOR) -",
      "unit_type": "Facility",
      "unit_dbid": 2249
    }
  ],
  "LRF": [
    {
      "range":500,
      "size": 1,
      "value": 100,  
      "info": {
        "img": "https://i.imgur.com/WvT2t45.jpeg",
        "information": "<p>The Typhon SSM platform is a medium-range missile system designed for precise targeting of land targets using the RGM-109E Tomahawk Blk IV TACTOM or aerial interceptions plus anti-surface capability using the RIM-174A ERAM SM-6 Blk IB.</p><b>Weapons:</b><ul><li>20x SM-6 Blk IB</li></ul>"
      },
      "unit_name": "Typhon",
      "type": "LRF",
      "icon": "ssm",
      "maxLimit": 2,
      "description": "SSM Plt (Typhon) MRC, Mid-Range Capability",
      "unit_type": "Facility",
      "unit_dbid": 3288
    },
    {
      "range":270,
      "size": 1,
      "value": 90,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/HIMARS_-_missile_launched.jpg/800px-HIMARS_-_missile_launched.jpg",
        "information": "<p>The M142 HIMARS is a highly mobile artillery rocket system capable of launching precision-guided missiles. It provides rapid deployment and high firepower, making it a key asset for tactical operations.</p><b>Weapons:</b><ul><li>20x Spiral PrSM 1</li></ul>"
      },
      "unit_name": "HIMARS (PrSM-1)",
      "type": "LRF",
      "icon": "himars",
      "maxLimit": 2,
      "description": "Arty Plt (M142 HIMARS)",
      "unit_type": "Facility",
      "unit_dbid": 3380
    },
    {
      "range":90,
      "size": 1,
      "value": 60,  
      "info": {
        "img": "https://i.imgur.com/HGSOiqa.jpeg",
        "information": "<p>The Naval Strike Missile (NSM) is a highly accurate, long-range missile designed for anti-ship and land attack missions. It provides stealth capabilities and precision targeting to effectively neutralize high-value targets.</p><b>Weapons:</b><ul><li>16x NSM</li></ul>"
      },
      "unit_name": "SSM NSM",
      "type": "LRF",
      "icon": "ssm",
      "description": "SSM Bty (Naval Strike Missile (NSM)) -",
      "unit_type": "Facility",
      "unit_dbid": 3860
    },
    {
      "range":160,
      "size": 1,
      "value": 60,  
      "info": {
        "img": "https://i.imgur.com/UqQe17U.jpeg",
        "information": "<p>The PJ-10 Brahmos is a supersonic cruise missile system renowned for its speed and precision. It is capable of engaging both maritime and land-based targets with high accuracy and minimal detection.</p><b>Weapons:</b><ul><li>16x PJ-10</il><ul>"
      },
      "unit_name": "SSM PJ-10",
      "type": "LRF",
      "icon": "ssm",
      "description": "SSM Bn (PJ-10 Brahmos) -",
      "unit_type": "Facility",
      "unit_dbid": 3427
    }
  ],
  
  "SAM": [
    {
      "range":55,
      "size": 1,
      "value": 40,  
      "info": {
        "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/e/eb/Patriot_System_2.jpg/800px-Patriot_System_2.jpg",
        "information": "<p>The Patriot SAM system is a highly effective surface-to-air missile battery designed to intercept and destroy incoming ballistic and cruise missiles. It provides robust air defense and protection against aerial threats.</p><b>Weapons:</b><ul><li>32x PAC-3 ERINT</li><li>24x PAC-3 MSE</li>"
      },
      "unit_name": "Patriot PAC-2+/PAC-3",
      "type": "SAM",
      "icon": "sam",
      "description": "SAM Bty (Patriot [PAC-2 GEM+ LAMDIS, PAC-3 ERINT/MSE])  6x Lnchr - GhostEye Radar",
      "unit_type": "Facility",
      "unit_dbid": 2506 
    },
    {
      "range":108,
      "size": 1,
      "value": 120,  
      "info": {
        "img": "https://i.imgur.com/3An7sE0.jpeg",
        "information": "<p>The THAAD (Terminal High Altitude Area Defense) system is designed to intercept and destroy short, medium, and intermediate-range ballistic missiles during their final phase of flight. It enhances national missile defense capabilities.</p><b>Weapons:</b><ul><li>48x THAAD-C2"
      },
      "unit_name": "THAAD",
      "type": "SAM",
      "icon": "sam",
      "maxLimit": 2,
      "description": "SAM Bty (THAAD CEC) 6x lnchr CEC",
      "unit_type": "Facility",
      "unit_dbid": 3215
    },
    {
      "range":10,
      "size": 1,
      "value": 10,  
      "info": {
        "img": "https://www.joint-forces.com/wp-content/uploads/2022/03/CR22-HML-03.jpg",
        "information": "<p>The NASAMS II HML platform is a short-range surface-to-air missile system. It uses the AMRAAM 120C-7</p><b>Weapons:</b><ul><li>16x MIM-120C-7</li></ul>"
      },
      "unit_name": "NASAMS",
      "type": "SAM",
      "icon": "sam",
      "description": "NASAMS II HML [Hawkei]",
      "unit_type": "Facility",
      "unit_dbid": 3222
    },
    
  ]
}

]]
bL3.JSON.CARDS = [[
{
  "Info Ops": [
    {
      "domain": "Info Ops",
      "value": 30,
      "title": "Electromagnetic-Defense",
      "description": "Counters enemy electromagnetic and communication jamming capabilities",
      "capability": "Protects communication lines from interference",
      "img": "https://www.armytimes.com/resizer/v2/SGCMWOXKVJF6LDZAD7H75QPZR4.jpg?width=1200&auth=fb40cc72b9c1c97bbaa5bb742fda0a18129a47fd853b0d4f7bff804bc8dac6c9",
      "id": 1,
      "info": "Strengthens defenses against electronic warfare by preventing enemy jamming from impacting friendly communications."
    },
    {
      "domain": "Info Ops",
      "value": 45,
      "title": "Attack on C2",
      "description": "Disrupts enemy C2 node, causing delays and miscoordinations",
      "capability": "Targets and disrupts command and control systems",
      "img": "https://upload.wikimedia.org/wikipedia/commons/c/c3/CIC-USS-CarlVinson-2001.jpg",
      "id": 2,
      "info": "Alters enemy coordination in Time On Target and Time on Station missions."
    },
    
    
    {
      "domain": "Info Ops",
      "value": 20,
      "title": "Military Deception",
      "description": "Deploys Spoofers, physical decoys and camouflage on mobile units",
      "capability": "Deploys decoys near Mobile units",
      "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Aircraft_preparation_-_S-300_SAM_mock_up_%283%29.jpg/1200px-Aircraft_preparation_-_S-300_SAM_mock_up_%283%29.jpg",
      "id": 3,
      "info": "Creates fake targets to mislead enemy reconnaissance, protecting real units by diverting enemy attention to decoys."
    },
    
    {
      "domain": "Info Ops",
      "value": 40,
      "title": "GPS Spoofing",
      "description": "Alters GPS signals to hinder enemy navigation and reveal enemy positions",
      "capability": "Exploits GPS Signal to reveal enemy units on an area",
      "img": "https://rntfnd.org/wp-content/uploads/cyber-attack-shutterstock_781900246-1080x675.jpg",
      "id": 4,
      "info": "Uses GPS manipulation to reveal enemy positions and mislead their navigation, impacting their tactic movements."
    },
    {
      "domain": "Info Ops",
      "value": 40,
      "title": "Tactical Cyber Attack",
      "description": "Disrupts enemy sensors capabilities on a precise location",
      "capability": "Targets sensors to disable enemy surveillance",
      "img": "https://humanfocus.co.uk/wp-content/uploads/Types-of-Cyber-Attack.jpg",
      "id": 5,
      "info": "Targets specific enemy sensors, blinding surveillance systems and reducing enemy situational awareness."
    },
    {
      "domain": "Info Ops",
      "value": 40,
      "title": "Unmanned Hacking",
      "description": "Disrupts enemy contact with UAV/UCAV platforms",
      "capability": "Hacks UAV/UCAV systems to cut off communication",
      "img": "https://www.eurocontrol.int/sites/default/files/styles/16_9_1920x1080/public/2024-08/uas-event-banner-1920x1080.jpg?h=03be536f&itok=aQDgkmbl",
      "id": 6,
      "info": "Interrupts enemy UAV communication links, forcing UAVs into standby or return-to-base, reducing enemy aerial surveillance."
    },
    {
      "domain": "Info Ops",
      "value": 45,
      "title": "Electromagnetic-Attack",
      "description": "Use Electronic Attack to degrade enemy capabilities",
      "capability": "Attack enemy electromagnetic espectrum",
      "img": "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/BLACK_SKIES_22-_STARCOM_debuts_new_cyber_warfare_exercise_%287426228%29.jpeg/640px-BLACK_SKIES_22-_STARCOM_debuts_new_cyber_warfare_exercise_%287426228%29.jpeg",
      "id": 7,
      "info": "Affects enemy OODA loop."
    },
    {
      "domain": "Info Ops",
      "value": 50,
      "title": "Network Resilience",
      "description": "Ability to keep and restore communication interruptions",
      "capability": "Restores network functionality after disruptions",
      "img": "https://eu-images.contentstack.com/v3/assets/bltde8121fc52c5c8f3/bltedbe99bae3a0f668/6602bdb9555201040afeac9c/resiliency-RKAEYM.jpg",
      "id": 8,
      "info": "Enhances network robustness, enabling quick recovery of communication channels after enemy disruptions."
    },
    {
      "domain": "Info Ops",
      "value": 30,
      "title": "Secure Communications",
      "description": "Ensures encrypted communication channels to prevent interception",
      "capability": "Secures communications against interception",
      "img": "https://www.selhagroup.com/wp-content/uploads/2019/05/defense-AS-164038465-1024x587.png",
      "id": 11,
      "info": "Establishes secure, encrypted communications that are resilient to enemy interception or jamming attempts."
    },
    {
      "domain": "Info Ops",
      "value": 40,
      "title": "Network Infiltration",
      "description": "Enhance offensive capabilities against the enemy",
      "capability": "Infiltrate enemy network",
      "img": "https://eu-images.contentstack.com/v3/assets/blt6d90778a997de1cd/blte17bc7f9dced30f8/64f15246c7f4a4972ea04229/network-attack-HernanSchmidt-alamy.jpg?width=1280&auto=webp&quality=95&format=jpg&disable=upscale",
      "id": 12,
      "info": "Access to network high classified enviroments, enhancing intelligence reports and increase offensive capabilities such Communication Jamming and Electromagnetic Attack"
    },
    {
      "domain": "Info Ops",
      "value": 30,
      "title": "Network Security",
      "description": "Enhance network protocols to prevent cyber attacks against platforms and C2",
      "capability": "Secures network connectivity",
      "img": "https://assets.enterprisenetworkingplanet.com/uploads/2023/06/enp-network-security.png",
      "id": 13,
      "info": "Establishes additional security measures in network access and protocols"
    },
    {
      "domain": "Info Ops",
      "value": 40,
      "title": "Comms Jamming",
      "description": "Use Electronic Attack to disrupt enemy communications",
      "capability": "Attack enemy communications",
      "img": "https://netlinetech.com/wp-content/uploads/2023/08/Communication-jamming-on-land-Large.jpeg",
      "id": 17,
      "info": "Affects enemy communications."
    },
    {
      "domain": "Info Ops",
      "value": 40,
      "title": "Enhanced EW Capabilities",
      "description": "Use advanced AI on EW to degrade enemy EW Defenses",
      "capability": "Degrade Enemy EW Defenses",
      "img": "https://www.defaiya.com/sites/default/files/images/Northrop-Grumman-to-Provide-Advanced-EW-Simulation-to-Saudi-Arabia.jpg",
      "id": 19,
      "info": "Degrade enemy EW defenses to enhance Electromagnetic Attack and Communication Jamming"
    },
  ],
  "C4ISR": [
    {
      "domain": "C4ISR",
      "value": 25,
      "title": "High Altitude Balloons",
      "description": "Deploy a HELIOS space-based ISR with EO/IR, ESM and DataLink capabilities",
      "capability": "Launches high-altitude balloons for ISR",
      "img": "https://media.defense.gov/2024/Jun/22/2003490232/1088/820/0/240610-A-GS967-1001.JPG",
      "id": 9,
      "info": "Provides persistent ISR with high-altitude balloons, offering coverage for intelligence and early warning detection."
    },
    {
      "domain": "C4ISR",
      "value": 25,
      "title": "Satellite Intelligence",
      "description": "Provides advanced intelligence of enemy movements",
      "capability": "Captures satellite images for intelligence",
      "img": "https://cdn.prod.website-files.com/638e3454949be8a29c563f03/64ede639d708403328669a78_satellite-67718_1280.jpg",
      "id": 10,
      "info": "Grants access to satellite-based high-resolution imagery, enhancing long-range observation of enemy activities and positions."
    },
    {
      "domain": "C4ISR",
      "value": 50,
      "title": "SBX 1",
      "description": "Deploy the SBX 1 in the East of PhilippinesPhilippines",
      "capability": "Deploy a SBX 1 Radar",
      "img": "https://missiledefenseadvocacy.org/wp-content/uploads/2014/10/seabased-deployed-770x385@2x.jpg",
      "id": 18,
      "info": "Mobile, sea-based radar system built on a semi-submersible oil platform, designed for tracking ballistic missile"
    },
    {
      "domain": "C4ISR",
      "value": 40,
      "title": "HUMINT",
      "description": "Deploy HUMINT resources near enemy airfields and C2",
      "capability": "HUMINT resources report enemy activities",
      "img": "https://adeosecurity.com/uploads/photos/shares/The%20Vital%20Role%20of%20Human%20Intelligence%20(HUMINT)%20in%20Cybersecurity.jpg",
      "id": 14,
      "info": "Deploy HUMINT resources near enemy airfields and C2"
    },
    {
      "domain": "C4ISR",
      "value": 30,
      "title": "AI Targeting",
      "description": "Degrade enemy concealment and spoofing capabilities",
      "capability": "Enemy decoys are revealed. Targeting bonifications",
      "img": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWPBlDSOE29sJT-sd4CH9YutNPo1HFLEFo8KarVkJPfb7OwJIEt9nTghbktZ9pXVwYLSw&usqp=CAU",
      "id": 15,
      "info": "Decoy units discovered by enemy are automatically classified as decoy"
    },
    {
      "domain": "C4ISR",
      "value": 20,
      "title": "Military Intelligence",
      "description": "Provide IPB and advanced intelligence on enemy units",
      "capability": "Disclose enemy OOB",
      "img": "https://media.istockphoto.com/id/1355657756/photo/military-surveillance-officer-working-on-a-city-tracking-operation-in-a-central-office-hub.jpg?s=612x612&w=0&k=20&c=IR_npi-H0X-65r1R-LIyHiea1XHuF6agkzlSkfwtiIQ=",
      "id": 16,
      "info": "Enemy OOB are send to the player"
    },
    {
      "domain": "C4ISR",
      "value": 40,
      "title": "SIGINT/ESM Stations",
      "description": "Integrate SIGINT/ESM Ground Stations into the network",
      "capability": "Increase SIGINT stream of data",
      "img": "https://miro.medium.com/v2/resize:fit:1400/0*MH5TcOaj_sqeXnlK.jpeg",
      "id": 21,
      "info": "Phillipines Ground SIGINT stations are added to the player side"
    },
    {
      "domain": "C4ISR",
      "value": 40,
      "title": "Extended NIFC-CA",
      "description": "Extends NIFC-CA network to specific Air and Ground assets.",
      "capability": "Enables AIM-120/260 and SM-6 strikes using ISR feeds.",
      "img": "https://aitechsystems.com/wp-content/uploads/2023/09/JADC2-infographic_Horizontal-1024x513.jpg",
      "id": 22,
      "info": "RQ-180, TPY-4 and HELIOS receive CEC + AIM + AEGIS DataLink in order to fire AIM-260, AIM-120 and SM-6"
    },
  ]
}
]]
bL3.JSON.FIXEDUNITS = [[
{
  "TARGETS": [
    {
      "icon": "HQ",
      "name": "PHILIPINES MARINE CORP HEADQUARTERS",
      "lon": 120.29136289695,
      "lat": 14.71098258453
    },
    {
      "icon": "HQ",
      "name": "PHILIPPINES NAVY HEADQUARTERS",
      "lon": 120.98587564263,
      "lat": 14.561168724506
    },
    {
      "icon": "HQ",
      "name": "PHILIPPINES AIR FORCE HEADQUARTERS",
      "lon": 121.02309020142,
      "lat": 14.517982667312
    },
    {
      "icon": "HQ",
      "name": "AIR DEFENSE COMMAND HEADQUARTERS",
      "lon": 120.53456609814,
      "lat": 15.18257154336
    },
    {
      "icon": "gov",
      "name": "Malacañang Palace (Presidential Palace",
      "lon": 120.99314263603,
      "lat": 14.593953613497
    },
    {
      "icon": "HQ",
      "name": "ARMY HEADQUARTERS PHILIPPINES",
      "lon": 121.06443549717,
      "lat": 14.605439058333
    },
    {
      "icon": "COMM",
      "name": "Building (Uplink Relay Station) A",
      "lon": 121.5677535213,
      "lat": 15.75926674995
    },
    {
      "icon": "energy",
      "name": "Structure (Power Station - Coal)",
      "lon": 120.53664355423,
      "lat": 14.42445788376
    },
    {
      "icon": "COMM",
      "name": "Building (Uplink Relay Station) C",
      "lon": 121.04881454238,
      "lat": 13.764055680593
    },
    {
      "icon": "COMM",
      "name": "Building (Uplink Relay Station) B",
      "lon": 14.1390651391089,
      "lat": 122.977927752276
    },
    {
      "icon": "energy",
      "name": "Structure (Power Station - Gas)",
      "lon": 121.03455013399,
      "lat": 13.770069428245
    }
  ],
  "ABs": {
    "Danilo Atienza AB": {
      "icon": "AB",
      "lat": 14.497200398353,
      "name": "Danilo Atienza AB",
      "lon": 120.9115180856,
      "capacity":152,
      "sizeT":"M"
    },
    "Iloilo International Airport": {
      "icon": "AB",
      "lat": 10.832778, 
      "name": "Iloilo International Airport",
      "lon": 122.493333,
      "capacity":48,
      "sizeT":"S"
    },
    "Benito Ebeun (Mactan) AB": {
      "icon": "AB",
      "lat": 10.315738867352,
      "name": "Benito Ebeun (Mactan) AB",
      "lon": 123.97898493467,
      "capacity":300,
      "sizeT":"L"
    },
    "Diosdado Macapagal International Airport": {
      "icon": "AB",
      "lat": 15.191560779332,
      "name": "Diosdado Macapagal International Airport",
      "lon": 120.56244664245,
      "capacity":500,
      "sizeT":"L"
    },
    "Laoag International Airport": {
      "icon": "AB",
      "lat": 18.180942694733,
      "name": "Laoag International Airport",
      "lon": 120.53225001459,
      "capacity":32,
      "sizeT":"S"
    },
    "Jesus Villamor AB": {
      "icon": "AB",
      "lat": 14.524939782853,
      "name": "Jesus Villamor AB",
      "lon": 121.00650463293,
      "capacity":700,
      "sizeT":"L"
    }
  }
}
]]
--[[
    -- {
    --   "range":10,
    --   "size": 1,
    --   "value": 10,  
    --   "info": {
    --     "img": "https://i.imgur.com/nppajwc.jpeg",
    --     "information": "<p>The MML SAM platform is a versatile short-range surface-to-air missile system designed for point-defense operations. It provides reliable air defense against a variety of aerial threats, from cruise missiles to UAS.</p><b>Weapons:</b><ul><li>81x MHTK</li><li>18x MGM-114L</li><li>18x MIM-9X</li></ul>"
    --   },
    --   "unit_name": "MML",
    --   "type": "SAM",
    --   "icon": "sam",
    --   "description": "SAM Plt (MML)",
    --   "unit_type": "Facility",
    --   "unit_dbid": 3159
    -- }
]]


--gKH-lua

--[[
  gKH State library functions
  Filename: State.lua
  Namespace: gKH.State
  Requirement (to use all functions): no dependecies including gKH.base atm
--]]


---- Setup ----
-- debug('gKH.State library loading...');

--Does overall gKH library exist? If not set it up, if so do not overwrite it.
if gKH == nil then 
  gKH={}; 
  -- debug('gKH library namespace already exists.');
end 

--Does State library already exist? If yes delete it force a flush of it.
if gKH.State ~= nil then --wipe existing copy if it exists.
  -- debug('gKH.State library existed, removing old copy.');
  gKH.State = nil;
  gKH.json = nil;
  collectgarbage("collect");
end
gKH.State = {};
gKH.State.Version = 1.00001;
---- End Setup ----

--------------------------------------------------------------------------------------------------------------------------------
-- JSON Library - Credit: https://gist.github.com/tylerneylon/59f4bcf316be525b30ab
--              - Only changes were the function names to fit the namespace
--              -   note to self: namespace change may slow it down slightly > ~100k of data. 
--              -   need to go back and benchmark throwing helper funcs inside each main fuc so refs are "local"
--              -   or meta table tweaks on gKH.json such that it never looks higher.
--              -   but the truth is I doubt it's going to make huge difference for cmo use cases.
--------------------------------------------------------------------------------------------------------------------------------

-- internal namespace used for all these functions. be careful fking with it, the whole point of the outer State namespace
-- is wrap usage of this and avoid calling the .json functions directly, though you can obviously if you want.
gKH.json = {};

-- Internal functions. --
function gKH.json.kind_of(obj)
  if type(obj) ~= 'table' then return type(obj) end
  local i = 1
  for _ in pairs(obj) do
    if obj[i] ~= nil then i = i + 1 else return 'table' end
  end
  if i == 1 then return 'table' else return 'array' end
end

function gKH.json.escape_str(s)
  local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
  local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
  for i, c in ipairs(in_char) do
    s = s:gsub(c, '\\' .. out_char[i])
  end
  return s
end

function gKH.json.skip_delim(str, pos, delim, err_if_missing)
  pos = pos + #str:match('^%s*', pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error('Expected ' .. delim .. ' near position ' .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

function gKH.json.parse_str_val(str, pos, val)
  val = val or ''
  local early_end_error = 'End of input found while parsing string.'
  if pos > #str then error(early_end_error) end
  local c = str:sub(pos, pos)
  if c == '"'  then return val, pos + 1 end
  if c ~= '\\' then return gKH.json.parse_str_val(str, pos + 1, val .. c) end
  -- We must have a \ character.
  local esc_map = {b = '\b', f = '\f', n = '\n', r = '\r', t = '\t'}
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then error(early_end_error) end
  return gKH.json.parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

function gKH.json.parse_num_val(str, pos)
  local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
  local val = tonumber(num_str)
  if not val then error('Error parsing number at position ' .. pos .. '.') end
  return val, pos + #num_str
end

function gKH.json.stringify(obj, as_key)
  local s = {}  -- We'll build the string as an array of strings to be concatenated.
  local kind = gKH.json.kind_of(obj)  -- This is 'array' if it's an array or type(obj) otherwise.
  if kind == 'array' then
    if as_key then error('Can\'t encode array as key.') end
    s[#s + 1] = '['
    for i, val in ipairs(obj) do
      if i > 1 then s[#s + 1] = ', ' end
      s[#s + 1] = gKH.json.stringify(val)
    end
    s[#s + 1] = ']'
  elseif kind == 'table' then
    if as_key then error('Can\'t encode table as key.') end
    s[#s + 1] = '{'
    for k, v in pairs(obj) do
      if #s > 1 then s[#s + 1] = ', ' end
      s[#s + 1] = gKH.json.stringify(k, true)
      s[#s + 1] = ':'
      s[#s + 1] = gKH.json.stringify(v)
    end
    s[#s + 1] = '}'
  elseif kind == 'string' then
    return '"' .. gKH.json.escape_str(obj) .. '"'
  elseif kind == 'number' then
    if as_key then return '"' .. tostring(obj) .. '"' end
    return tostring(obj)
  elseif kind == 'boolean' then
    return tostring(obj)
  elseif kind == 'nil' then
    return 'null'
  else
    error('Unjsonifiable type: ' .. kind .. '.')
  end
  return table.concat(s)
end

gKH.json.null = {}  -- This is a one-off table to represent the null value.

function gKH.json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then error('Reached unexpected end of input.') end
  local pos = pos + #str:match('^%s*', pos)  -- Skip whitespace.
  local first = str:sub(pos, pos)
  if first == '{' then  -- Parse an object.
    local obj, key, delim_found = {}, true, true
    pos = pos + 1
    while true do
      key, pos = gKH.json.parse(str, pos, '}')
      if key == nil then return obj, pos end
      if not delim_found then error('Comma missing between object items.') end
      pos = gKH.json.skip_delim(str, pos, ':', true)  -- true -> error if missing.
      obj[key], pos = gKH.json.parse(str, pos)
      pos, delim_found = gKH.json.skip_delim(str, pos, ',')
    end
  elseif first == '[' then  -- Parse an array.
    local arr, val, delim_found = {}, true, true
    pos = pos + 1
    while true do
      val, pos = gKH.json.parse(str, pos, ']')
      if val == nil then return arr, pos end
      if not delim_found then error('Comma missing between array items.') end
      arr[#arr + 1] = val
      pos, delim_found = gKH.json.skip_delim(str, pos, ',')
    end
  elseif first == '"' then  -- Parse a string.
    return gKH.json.parse_str_val(str, pos + 1)
  elseif first == '-' or first:match('%d') then  -- Parse a number.
    return gKH.json.parse_num_val(str, pos)
  elseif first == end_delim then  -- End of an object or array.
    return nil, pos + 1
  else  -- Parse true, false, or null.
    local literals = {['true'] = true, ['false'] = false, ['null'] = gKH.json.null}
    for lit_str, lit_val in pairs(literals) do
      local lit_end = pos + #lit_str - 1
      if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
    end
    local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
    error('Invalid json syntax starting at ' .. pos_info_str)
  end
end
-----------  end internal json related functions ------------



--- Wrapper function for saving table\array data to CMO string keys.
--- @param theTbl table @ - required the lua table to serialize\convert to an encoded string.
--- @param theKey string @ - required string of the keyname to save the table to.
--- @param forCampaign boolean? @ True if the key is stored for a campaign
--- @param nolog? boolean @ - optional boolean if true indicates no logging should be done, defaults to false.
--- @return boolean @ true on successful save, false if something went wrong.
--- Note: While this should not be abused (it's not meant to store huge amounts of data), but it's what we have.
---  That said I've stored a dozen or so MB's worth of data across a couple different keys without issue.
---  If you're thinking we should maybe compress this data before saving let me just say I've been down that road
---  and it's pointless, talk to me directly for details but the tldr of it is the default LZ4 
---  compression that late stage CMANO and CMO does for the whole scene xml makes it pointless to
---  try to do inside lua before-hand (say with a lua implementation of lib-deflate)99% of the time,
---  and the other 1% of time the savings aren't much without extremely specific types of ordered repeating data.
---  and tweaks to libdeflate to match that sort of specific data.
function gKH.State.SaveTableToKey(theTbl,theKey,forCampaign,nolog)
  if forCampaign == nil then forCampaign = false end
  local fn = "gKH.State.SaveTableToKey(): ";
  local retval = false;
  if nolog==nil then nolog =false; end
  if (theTbl ~= nil) and (theKey ~= nil and string.len(theKey) > 0) then
    retval = pcall(ScenEdit_SetKeyValue,theKey, gKH.json.stringify(theTbl), forCampaign);
    if retval == true then
      return true;
    elseif nolog ==false then
      -- debug(fn .."Call to ScenEdit_SetKeyValue failed! key:" .. tostring(theKey));
    end
  else 
    -- debug(fn.. "Missing params theTbl or theKey value! call aborted.");
  end
  return false;
end


--- Wrapper function for loading a savedkey that contains a string-ified table.
--- @param theKey string @ As a string key to grab and de-stringify.
--- @param nolog? boolean @ Optional nolog param tells the function not to log most errors.
--- @return table|nil @nil or a table repopulated with data.
function gKH.State.LoadTableFromKey(theKey,nolog)
  local fn="gKH.State.LoadTableFromKey(): "
  if nolog ==nil then nolog =false; end
  if((theKey ~=nil) and string.len(theKey) > 0) then
    local retval,theKeyData;
    retval, theKeyData = pcall(ScenEdit_GetKeyValue,theKey);

    if(retval ~=nil and theKeyData ~=nil) and retval == true and string.len(theKeyData) > 2 then
      local rettbl = gKH.json.parse(theKeyData);
      if rettbl ~= nil then
        return rettbl;
      elseif nolog ==false then
        -- debug(fn .. "Call to destringify the key failed to return data!");
      end
    elseif(retval ~=nil and theKeyData ~=nil) and retval == true and string.len(theKeyData) < 2 and nolog ==false then
      -- debug(fn .. "Call to ScenEdit_GetKeyValue " .. theKey .. " returned empty suggesting it has not yet been created.");
    elseif nolog ==false then
      -- debug(fn .. "Call to ScenEdit_GetKeyValue failed. Did you pass the right key? " .. theKey);
    end
  else
    -- debug(fn .. "Missing param, missing Key to load from.");
  end
  return nil;
end

-- debug('gKH.State library successfully loaded.');

--LuaInit-lua

bL3.Functions={}
bL3.TOOL =  {}
ScenEdit_SetEvent('LuaInit',{isActive=true})

---- Scenario variables
bL3.DATEFORMAT = ScenEdit_GetKeyValue('DATEFORMAT')

if bL3.DATEFORMAT == "" or bL3.DATEFORMAT == "STEAM" then
  bL3.DATEFORMAT = '!%Y-%m-%dT%H:%M:%S'
  bL3.COMPLEXITY = 3
  bL3.BUDGET = 1500
  local tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Special Action Setup</title>
    <link href="https://fonts.googleapis.com/css2?family=Staatliches&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body, html {
            font-family: 'Staatliches', sans-serif;
            font-size: 1.1rem;
            height: 100vh;
            margin: 0;
            padding: 0;
            background-color: #0d1b2a;
            color: #ffffff;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }
        #container {
            flex: 1;
            margin: 30px auto 0;
            width: 80%;
            max-width: 1200px;
            padding: 15px;
            display: flex;
            flex-direction: column;
            gap: 25px;
        }
        #main-dashboard {
            display: flex;
            gap: 40px;
            flex: 1;
            align-items: flex-start;
        }
        #selector {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 25px;
            min-width: 300px;
        }
        #notes {
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 20px;
            align-items: center;
            text-align: center;
        }
        #notes img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }
        #notes input[type="submit"] {
            background-color: #415a77;
            border: none;
            color: white;
            padding: 12px 30px;
            font-size: 1.2rem;
            font-family: 'Staatliches', sans-serif;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        #notes input[type="submit"]:hover {
            background-color: #1b263b;
        }
        .element {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .element label {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .element select {
            padding: 8px 12px;
            border: 1px solid #415a77;
            border-radius: 4px;
            background-color: #1b263b;
            color: #ffffff;
            font-family: 'Staatliches', sans-serif;
            font-size: 1rem;
        }
        .element select:focus {
            outline: none;
            border-color: #778da9;
        }
        #bottom {
            background-color: #1b263b;
            padding: 20px;
            text-align: center;
            border-top: 2px solid #415a77;
            margin-top: auto;
        }
        #bottom h4 {
            margin: 0;
            color: #e0e1dd;
            font-size: 1.2rem;
        }
        .hidden {
            display: none !important;
        }
        #close {
            background-color: #2d5016;
            padding: 20px;
            text-align: center;
            border-top: 2px solid #4a7c23;
            margin-top: auto;
        }
        #close h4 {
            margin: 0;
            color: #e0e1dd;
            font-size: 1.2rem;
        }
    </style>
</head>
<body>
    <div id="container">
        <div id="main-dashboard">
            <div id="selector">
                <div class="element">
                    <label>Select the Complexity of the Scenario</label>
                    <select id="complexity" data-field="complexity">
                        <option value="1">Easy</option>
                        <option value="2">Normal</option>
                        <option value="3">Hard</option>
                    </select>
                </div>
                <div class="element">
                    <label>Select the Budget Base</label>
                    <select id="budget" data-field="budget">
                        <option value="1000">$1000</option>
                        <option value="1250">$1250</option>
                        <option value="1500" selected>$1500</option>
                        <option value="1750">$1750</option>
                        <option value="2000">$2000</option>
                    </select>
                </div>
                <input type="submit" value="Submit" onclick="Clicked()"/>
            </div>
            <div id="notes">
            <h4>Please use the latest beta version which can be find at:</h4><p>https://forums.matrixgames.com/viewtopic.php?t=414039</p>
                <img src="https://i.imgur.com/xLjrqA6.png" alt="Scenario Image">
                <p>It is highly recommended that you disable the display of special messages in the message log for this scenario. Special messages are particularly long and can cause performance issues and problems when loading a saved game from the scenario.</p>
            </div>
        </div>
    </div>
    
    <div id="bottom">
        <h4>PLEASE DO NOT CLOSE THIS MESSAGE WITHOUT CLICKING ON SUBMIT. THE SCENARIO MAY NOT WORK PROPERLY</h4>
    </div>
    
    <div id="close" class="hidden">
        <h4>Thank you, now you can close this window and press play to start the scenario</h4>
    </div>
<script>
function Clicked() {
    let formData = {};

    // Get all inputs with "data-field"
    document.querySelectorAll("[data-field]").forEach(input => {
        if (input.type === "checkbox") {
            // Store boolean value for checkboxes
            formData[input.getAttribute("data-field")] = input.checked;
        } else if (input.type === "radio") {
            // Store selected value for radio buttons
            if (input.checked) {
                formData[input.getAttribute("data-field")] = input.value;
            }
        } else {
            // Store value for text inputs and selects
            formData[input.getAttribute("data-field")] = input.value;
        }
    });

    // Convert to JSON
    let jsonData = JSON.stringify(formData);

    // Send the JSON object to the backend
    window.chrome.webview.postMessage(`DIALOG_OKbL3.Functions.SetScenarioConfig('${jsonData}')`);

    // Hide form and show confirmation message
    document.getElementById('selector').classList.add("hidden");
    document.getElementById('bottom').classList.add("hidden");
    document.getElementById('close').classList.remove("hidden");
}
</script>

</body>
</html>
  ]]
  
  ScenEdit_SpecialMessage('playerside',tmp)
else
  bL3.COMPLEXITY = tonumber(ScenEdit_GetKeyValue('COMPLEXITY'))
end

function bL3.Functions.SetScenarioConfig(jsonData)
  local data = gKH.json.parse(jsonData)
  if data then
    bL3.BUDGET = data['budget']
    bL3.COMPLEXITY = data['complexity']
  end
  ScenEdit_SetKeyValue('DATEFORMAT',bL3.DATEFORMAT)
  ScenEdit_SetKeyValue('COMPLEXITY',bL3.COMPLEXITY)
  ScenEdit_SetKeyValue('BUDGET',bL3.BUDGET)
end

bL3.SIDES = {}
bL3.SIDES.BLUE = "BLUE"
bL3.SIDES.RED = "RED"
bL3.SIDES.BLUEDECOY = "BLUE DECOY"
bL3.BLUE = gKH.State.LoadTableFromKey('BLUE')
if not bL3.BLUE then bL3.BLUE = {} end
bL3.RED = gKH.State.LoadTableFromKey('RED')
if not bL3.RED then bL3.RED = {} end

bL3.BLUE.OOB = gKH.State.LoadTableFromKey('OOB')
if not bL3.BLUE.OOB then bL3.BLUE.OOB = {} gKH.State.SaveTableToKey(bL3.BLUE.OOB,'OOB') end

bL3.TargetList = gKH.State.LoadTableFromKey('TARGETLIST')
if not bL3.TargetList then bL3.TargetList = {} end
bL3.Contacts = gKH.State.LoadTableFromKey('CONTACTS')
if not bL3.Contacts then bL3.Contacts = {} end

function bL3.Functions.SetDateFormat(dateformat)
  if dateformat == 'dayfirst' then
    bL3.DATEFORMAT = '%d/%m/%Y %H:%M:%S'
  else
    bL3.DATEFORMAT = '%m/%d/%Y %H:%M:%S'
  end
  ScenEdit_SetKeyValue('DATEFORMAT',bL3.DATEFORMAT)
end
function bL3.Functions.GetOpSide(side)
  if side == 'RED' then return 'BLUE' else return 'RED' end
end

function bL3.Functions.GetOOB(side)
  local function addUnit(count,unit)
    if count[unit.type] == nil then count[unit.type]={} end
    if count[unit.type][unit.classname] == nil then
        count[unit.type][unit.classname] = {num = 1, dbid=unit.dbid, subtype=unit.subtype}
    else
        count[unit.type][unit.classname].num = count[unit.type][unit.classname].num + 1
    end
  end
  local count = {}
  local s = VP_GetSide({ name = side}).units
  for k, v in pairs(s) do
      local unit = ScenEdit_GetUnit({ guid = v.guid })
      if unit and unit.type ~= "Group" and (#unit.sensors>0 or #unit.mounts>0) then
          addUnit(count,unit)
      end
  end
  return count
end

function bL3.Functions.ISRONDEMAND()
  
end

function bL3.Functions.GetNAAWESC()
  local ships = VP_GetSide({side='RED'}):unitsBy('Ship')
  local n = 0
  for _,r in ipairs(ships) do
    if string.match(r.name, 'AAW') then
      n = n +1
    end
  end
  return n
end

function bL3.Functions.ReduceLoadoutTimes()
  local aircrafts = VP_GetSide({side='BLUE'}):unitsBy('Aircraft')
  for _, v in ipairs(aircrafts) do
    local u = SE_GetUnit({guid = v.guid})
    if u then
      local timetoready = u.readytime_v
      if math.floor(timetoready/(60*60)) > 3 and math.floor(timetoready/(60*60)) < 7 then
        local minutes = math.floor(timetoready/60 + 30) - 2*60
        ScenEdit_SetLoadout({unitname=u.guid, TimeToReady_Minutes=minutes})
      elseif math.floor(timetoready/(60*60)) > 7 then
        local minutes = math.floor(timetoready/60 + 30) - 12*60
        ScenEdit_SetLoadout({unitname=u.guid, TimeToReady_Minutes=minutes})
      end
    end
  end

end

function bL3.Functions.REDDetection()
  local c = UnitC()
  local noTypes = {['Missile']=true,['Weapon']=true,['Decoy']=true,['Sonobuoy']=true, ['Torpedo'] = true}
  if not c then return 0 end
  if not bL3.Contacts[c.guid] and not noTypes[c.type] then
    local u = SE_GetUnit({guid = c.actualunitid})
    if u and u.side == 'BLUE DECOY' and bL3.RED.NKE.AITargeting then 
      if math.random() > 0.9 then
        return 0 
      end
    end
    if u and (u.type == 'Ship' or u.type == 'Facility' ) then
      bL3.Contacts[c.guid] = {actualid = c.actualunitid, dbid=c.actualunitdbid, domain=c.type, classlevel = c.classificationlevel}
      gKH.State.SaveTableToKey(bL3.Contacts,'CONTACTS') 
    end
    
  elseif c.type == 'Torpedo' then
    local u = SE_GetUnit({guid = c.actualunitid})
    if Tool_Range(c.actualunitid,bL3.RED.UNITS.C2SHIP) < 120 and not bL3.RED.AMPHWITHDRAWAL then
      if not bL3.RED.SAGASW then
        bL3.RED.SAGASW = true
        
        gKH.State.SaveTableToKey(bL3.RED,'RED')
        local bearing = Tool_Bearing(bL3.RED.UNITS.C2SHIP,c.guid)
        bL3.Functions.ASWMode({latitude=c.latitude, longitude=c.longitude})
        local t = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + 60*60)
        bL3.AuxFunctions.TimeEvent('End ASWMode',t,'bL3.Functions.EndASWMode()','add')
      elseif bL3.RED.SAGASW then
        local t = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + 25*60)
        bL3.AuxFunctions.TimeEvent('End ASWMode',t,nil,'update')
      end  
    end
    
  end

end

function bL3.Functions.ASWMode(torpedo_position)
  
  local c2 = SE_GetUnit({guid = bL3.RED.UNITS.C2SHIP})
  
  if not c2 then return 0 end
  bL3.RED.SAGCOURSE = {}
  local course = c2.course
  for k,v in ipairs(course) do
    table.insert(bL3.RED.SAGCOURSE,{latitude=v.latitude, longitude=v.longitude})
  end
  gKH.State.SaveTableToKey(bL3.RED,'RED')
  local torpedo_bearing = Tool_Bearing(bL3.RED.UNITS.C2SHIP, torpedo_position)
  local route = World_GetPointFromBearing({latitude=c2.latitude, longitude=c2.longitude, bearing=torpedo_bearing, distance=-50})
  ScenEdit_SetUnit({guid = c2.guid, course={route}, presetThrottle=4})
  local ships = VP_GetSide({side='RED'}):unitsBy('Ship')
  local center = World_GetPointFromBearing({latitude=torpedo_position.latitude, longitude=torpedo_position.longitude, bearing=torpedo_bearing, distance=10})
  -- local area = bL3.AuxFunctions.NewArea(center,{distance=50,shape='circle', side='RED'})
  -- local aswMission = ScenEdit_AddMission('RED', 'ASW CONTACT #'..bL3.AuxFunctions.RandomTxt(3),'patrol',{type='asw', zone=area})
  -- ScenEdit_SetMission('RED',aswMission.guid,{TransitThrottleShip=4,StationThrottleShip=1,AttackThrottleShip=1})
  -- ScenEdit_SetEMCON('mission',aswMission.guid,'Sonar=Active')
  local closest_ship = {}
  if ships then
    for k,v in ipairs(ships) do
      if string.find(v.name, 'Escort') then
        local d = Tool_Range(v.guid,center)
        table.insert(closest_ship,{guid=v.guid, distance=d})
        ScenEdit_SetEMCON('unit',v.guid,'Sonar=Active')
      end
    end
  end
  local index = bL3.AuxFunctions.sortTableByValueKey(closest_ship,'distance')
  for i=1,3 do
    local ship = closest_ship[index[i]]
    ScenEdit_SetEMCON('unit',ship.guid,'Sonar=Active')
    ScenEdit_SetUnit({guid = ship.guid, presetThrottle=1})
  end
  
end

function bL3.Functions.EndASWMode()
  bL3.RED.SAGASW = false
  gKH.State.SaveTableToKey(bL3.RED,'RED')
  local ships = VP_GetSide({side='RED'}):unitsBy('Ship')
  for k,v in ipairs(ships) do
    if string.find(v.name, 'Escort') then
      local u = SE_GetUnit({guid = v.guid})
      ScenEdit_SetEMCON('unit',v.guid,'Sonar=Passive')
    end
  end
  local c2 = SE_GetUnit({guid = bL3.RED.UNITS.C2SHIP})
  ScenEdit_SetUnit({guid = bL3.RED.UNITS.C2SHIP, course=bL3.RED.SAGCOURSE, presetThrottle=1})
  bL3.AuxFunctions.RemoveEvent('End ASWMode')

end

function bL3.Functions.UpdateSSNPatrols()
  local missions = ScenEdit_GetMission('RED','ARG').packagelist
  local distanceToTheBeach = Tool_Range(bL3.RED.UNITS.C2SHIP,bL3.RED.BEACH)
  if distanceToTheBeach and distanceToTheBeach < 200 then
    for k,v in ipairs(missions) do
      if string.find(v.name, 'SSN') then
        local zone = v.patrolmission.PatrolZone
        local prosec = v.patrolmission.ProsecutionZone
        for _,p in ipairs(zone) do
          local rp = ScenEdit_GetReferencePoint({name=p.name, side='RED'})
          ScenEdit_SetReferencePoint({guid=rp.guid, side='RED', latitude=rp.latitude, longitude=rp.longitude-0.01})
        end
        for _,p in ipairs(prosec) do
          local rp = ScenEdit_GetReferencePoint({name=p.name, side='RED'})
          ScenEdit_SetReferencePoint({guid=rp.guid, side='RED', latitude=rp.latitude, longitude=rp.longitude-0.01})
        end
      end
    end
  end

end

function bL3.Functions.REDEval()
  --[[
  Priority Levels:
    0: Critical
    1: High
    2: Medium
    3: Low
  ]]
  local dbid_contacts= {
    [3215] = function (unit) --THAAD
      bL3.TargetList[unit.guid] = {name='THAAD #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'SAM', priority=1, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [2506] = function (unit) --Patriot
      bL3.TargetList[unit.guid] = {name='PATRIOT #'..bL3.AuxFunctions.RandomTxt(3),dbid=unit.dbid, latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'SAM', priority=3, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [3288] = function (unit) --MRC
      bL3.TargetList[unit.guid] = {name='MRC #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'SSM', priority=1, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [2718] = function (unit) --DDG
      bL3.TargetList[unit.guid] = {name='DDG #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'DDG', priority=0, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [4289] = function (unit) --TPY
      bL3.TargetList[unit.guid] = {name='TPY #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'RADAR', priority=2, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [962] = function (unit) --FPS117
      bL3.TargetList[unit.guid] = {name='FPS-117 #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'RADAR', priority=3, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [4034] = function (unit)
      bL3.TargetList[unit.guid] = {name='ELM-2288ER #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'RADAR', priority=2, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [615] = function (unit)
      bL3.TargetList[unit.guid] = {name='UAV JAMMING CENTER #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'JAMCENTER', priority=1, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [4645] = function (unit) --FF 
      bL3.TargetList[unit.guid] = {name='FF #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'FF', priority=2, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [3860] = function (unit) -- NSM
      bL3.TargetList[unit.guid] = {name='NSM #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'SSM', priority=3, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [3380] = function (unit) -- HIMARS
      bL3.TargetList[unit.guid] = {name='HIMARS #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'SSM', priority=1, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
    [3427] = function (unit) -- PJ-10
      bL3.TargetList[unit.guid] = {name='PJ10 #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.dbid,latitude=unit.latitude, longitude=unit.longitude,t_domain = unit.type, t_type = 'SSM', priority=2, status=0, classified=os.date("!%Y-%m-%dT%H:%M:%SZ", ScenEdit_CurrentTime()), AssignedMission=nil, AssignedUnits=nil}
    end,
  }
  local contacts = bL3.Contacts
  
  for k,v in pairs(contacts) do
    local c = ScenEdit_GetContact({side='RED', guid=k})
    if not c then bL3.Contacts[k] = nil goto continueREDEval end
    local u = SE_GetUnit({guid = v.actualid})
    if v.classlevel == 1 and c.classificationlevel >=2 and u then
      if dbid_contacts[u.dbid] then
        local e = dbid_contacts[u.dbid]
        e(u)
      end
      bL3.Contacts[k] = nil
    elseif v.classlevel >=2 then
      if dbid_contacts[v.dbid] then
        local e = dbid_contacts[v.dbid]
        e(u)
      end
      bL3.Contacts[k] = nil
    end

  ::continueREDEval::
  end
  gKH.State.SaveTableToKey(bL3.TargetList,'TARGETLIST')
  local time = ScenEdit_CurrentTime()
  local maxTime = bL3.AuxFunctions.DateToTimeStamp('12/03/2028 17:00:00')
  if time >= bL3.RED.DynStrikes and  time < maxTime then
    bL3.Functions.DynamicStrikes()
  end
end

function bL3.Functions.DynamicStrikes()
  --[[
  status: 
    0: Pre Assigned
    1: Assigned Mission
    2: In course
    3: Inactive: Target Destroyed
    4: Inactive: Target Alive
  ]]
  local targetList = bL3.AuxFunctions.sortTablebyType(bL3.TargetList,'priority')
  local missionType = {
    ['Facility'] = 'land',
    ['Ship'] = 'sea'
  }
  local Dtime = bL3.RED.Dtime
  local currentTime = ScenEdit_CurrentTime()
  local BadgerList={}
  for k,v in pairs(targetList) do
    if v.status == 0 then 
      local mission = ScenEdit_AddMission('RED','Strike '..v.name,'strike',{type=missionType[v.t_domain], isactive=false})
      ScenEdit_AssignUnitAsTarget(k,mission.guid)
      local tot = Dtime - math.random(10,20)*60
      if Dtime - currentTime > 180*60 then
        if bL3.BLUE.NKE.C2Attack and not bL3.RED.NKE.SecureComms then tot = tot + math.random(-30,30) end
        mission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, tot)
        v.ToT = os.date('!%Y-%m-%dT%H:%M:%SZ', tot)
      end
      if v.t_domain == 'Ship' then
        if v.t_type == 'DDG' then
          if bL3.RED.QRF.H6N then
            local units = bL3.RED.QRF.H6N
            ScenEdit_SetMission('RED', mission.name, {StrikeFlightSize=#units, starttime= os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+10*60)})
            for _,guid in ipairs(units) do
              ScenEdit_AssignUnitToMission(guid,mission.guid)
            end
            v.status = 1
            v.AssignedMission = mission.name
            v.AssignedUnits = units
            bL3.TargetList[k] = v
            bL3.RED.QRF.H6N = nil
          elseif bL3.RED.QRF.ASBM and next(bL3.RED.QRF.ASBM) then
            local u = table.remove(bL3.RED.QRF.ASBM,1)
            
            ScenEdit_SetMission('RED', mission.name, {starttime= os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+10*60)})
            ScenEdit_AssignUnitToMission(u,mission.guid)
            v.status = 1
            
            v.AssignedMission = mission.name
            v.AssignedUnits = {u.guid}
            bL3.TargetList[k] = v
          else --Use SAG or QRF Group
            if bL3.RED.QRF.SAG then
              local min_distance = 330
              local units = bL3.RED.QRF.SAG
              local enableToLunch = false
              local timeInRange
              for x,guid in ipairs(units) do
                
                local distance = Tool_Range(k,guid)
                if min_distance > distance then
                  enableToLunch = true
                  ScenEdit_AssignUnitToMission(guid,mission.guid)
                else
                  timeInRange = (distance / 10) * 3600
                  if timeInRange < tot - currentTime - 30*60 then
                    enableToLunch = true
                    ScenEdit_AssignUnitToMission(guid,mission.guid)
                  else
                    table.remove(units,x)
                  end
                end
              end
              if enableToLunch then
                local startTime = os.date(bL3.DATEFORMAT, currentTime+10*60)
                if timeInRange then
                  startTime = os.date(bL3.DATEFORMAT, currentTime + timeInRange - 10*60)
                end
                for _,guid in ipairs(units) do
                  ScenEdit_AssignUnitToMission(guid,mission.guid)
                  ScenEdit_SetDoctrine({guid=guid},{weapon_control_status_surface=1, weapon_control_status_land=2})
                end
                ScenEdit_SetMission('RED', mission.name, {starttime=startTime})
                bL3.AuxFunctions.SetDoctrineMission(mission,'RED',2868,{target='Ship', salvo='Max', shooters='Max'})
                bL3.AuxFunctions.SetDoctrineMission(mission,'RED',4058,{target='Ship', salvo='Max', shooters='Max'})
                bL3.RED.QRF.SAG = nil
                v.AssignedMission = mission.name
                v.AssignedUnits = units
                v.status = 1
                bL3.TargetList[k] = v
              else
                v.status = 5
                bL3.TargetList[k] = v
                ScenEdit_DeleteMission('RED',mission.guid)
              end
            end
            
          end
        else
          if bL3.RED.QRF.SAG then
            local min_distance = 330
            local units = bL3.RED.QRF.SAG
            local enableToLunch = false
            local timeInRange
            for x,guid in ipairs(units) do
              local distance = Tool_Range(k,guid)
              if min_distance > distance then
                enableToLunch = true
                ScenEdit_AssignUnitToMission(guid,mission.guid)
              else
                timeInRange = (distance / 10) * 3600
                if timeInRange < tot - currentTime - 30*60 then
                  enableToLunch = true
                  ScenEdit_AssignUnitToMission(guid,mission.guid)
                else
                  table.remove(units,x)
                end
              end
            end
            if enableToLunch then
              local startTime = os.date(bL3.DATEFORMAT, currentTime+10*60)
              if timeInRange then
                startTime = os.date(bL3.DATEFORMAT, currentTime + timeInRange - 10*60)
              end
              bL3.AuxFunctions.SetDoctrineMission(mission,'RED',2868,{target='Ship', salvo='Max', shooters='Max'})
              bL3.AuxFunctions.SetDoctrineMission(mission,'RED',4058,{target='Ship', salvo='Max', shooters='Max'})
              ScenEdit_SetMission('RED', mission.name, {starttime= os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+10*60)})
              bL3.RED.QRF.SAG = nil
            end
          elseif bL3.RED.QRF.ASBM and next(bL3.RED.QRF.ASBM) then
            local u = table.remove(bL3.RED.QRF.ASBM,1)
            ScenEdit_SetMission('RED', mission.name, {starttime= os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+10*60)})
            ScenEdit_AssignUnitToMission(u,mission.guid)
            v.status = 1
            
            v.AssignedMission = mission.name
            v.AssignedUnits = {u.guid}
            bL3.TargetList[k] = v
          end
        end
      else
        if bL3.RED.QRF.BM and next(bL3.RED.QRF.BM) and v.priority <=1 then -- Use BM
          ScenEdit_SetMission('RED',mission.guid, {starttime=os.date(bL3.DATEFORMAT, currentTime+10*60)})
        
          local u = table.remove(bL3.RED.QRF.BM,1)
          ScenEdit_AssignUnitToMission(u,mission.guid)
          v.AssignedMission = mission.name
          v.AssignedUnits = {u}
          v.status = 1
          bL3.TargetList[k] = v
          if not next(bL3.RED.QRF.BM) then bL3.RED.QRF.BM=nil end

        elseif bL3.RED.QRF.CM and next(bL3.RED.QRF.CM) then
          ScenEdit_SetMission('RED',mission.guid, {starttime=os.date(bL3.DATEFORMAT, currentTime+10*60)})
        
          local u = table.remove(bL3.RED.QRF.CM,1)
          ScenEdit_AssignUnitToMission(u,mission.guid)
          v.AssignedMission = mission.name
          v.AssignedUnits = {u}
          v.status = 1
          bL3.TargetList[k] = v
          if not next(bL3.RED.QRF.CM) then bL3.RED.QRF.CM=nil end
        elseif bL3.RED.QRF.AKF then -- Use AKF
          local units = {}
          for i=1,2 do
            if next(bL3.RED.QRF.AKF) then
              local u = table.remove(bL3.RED.QRF.AKF,1)
              ScenEdit_AssignUnitToMission(u,mission.guid)
              table.insert(units,u)
              
            end
          end
          ScenEdit_SetMission('RED',mission.guid, {starttime=os.date(bL3.DATEFORMAT, currentTime+10*60),StrikeFlightSize=2})
          
          if not next(bL3.RED.QRF.AKF) then
            bL3.RED.QRF.AKF = nil
          end
          v.AssignedMission = mission.name
          v.AssignedUnits = units
          v.status = 1
          v.ToT = os.date('!%Y-%m-%dT%H:%M:%SZ', tot)
          bL3.TargetList[k] = v
        else
          table.insert(BadgerList,k)
        end
        
      end
      if #mission.unitlist == 0 or v.status == 0 then
        ScenEdit_DeleteMission('RED', mission.guid)
      end

      
    elseif v.status == 1 then
      local missionA = ScenEdit_GetMission('RED',v.AssignedMission)
      if not missionA then goto continueEnd end
      if not v.TakeOff then
        if missionA.flightlist and missionA.flightlist[1] then
          local flight = missionA.flightlist[1]
          local flightplan = flight.course
          if flightplan then
            local takeoff = flightplan[1].Zulu
            local date = bL3.AuxFunctions.ZuluToIso(takeoff)
            v.TakeOff = date
            bL3.TargetList[k] = v
          end
        end
      else 
        local TakeOfDate = v.TakeOff
        local ts_TakeOff = bL3.AuxFunctions.ConvertIsoToTimeStamp(TakeOfDate)
        if ts_TakeOff and ts_TakeOff > ScenEdit_CurrentTime() then
          v.status = 2
          bL3.TargetList[k] = v
        end
      end
    elseif v.status == 2 then
      local tot_iso = v.ToT
      local ts_ToT = bL3.AuxFunctions.ConvertIsoToTimeStamp(tot_iso)
      if ts_ToT and ts_ToT < currentTime then
        -- local missionA = ScenEdit_GetMission('RED',v.AssignedMission)
        local target = SE_GetUnit({guid = k})
        if target then
          v.status = 4
        else
          v.status = 3
        end
        bL3.TargetList[k] = v
      end
    end
    ::continueEnd::
    
  end
  
  if not bL3.RED.StrikeBadger and #BadgerList >= 4 then
    local mission = ScenEdit_AddMission('RED','Strike Badger','strike',{type='land', isactive=false})
    bL3.RED.StrikeBadger = true
    gKH.State.SaveTableToKey(bL3.RED,'RED')  
    for i=1,4 do
      local unit = BadgerList[i]
      ScenEdit_AssignUnitAsTarget(unit.guid, mission.guid)
    end
  end
  gKH.State.SaveTableToKey(bL3.TargetList,'TARGETLIST')
end

function bL3.Functions.UpdateTargetList()
  local targetList = bL3.TargetList
  local currentTime = ScenEdit_CurrentTime()

  for k,v in pairs(targetList) do
    if v.status == 1 then
      local missionA = ScenEdit_GetMission('RED',v.AssignedMission)
      if not missionA then goto continueEnd2 end
      if #v.AssignedUnits >1 then
        if not v.TakeOff then
          if missionA.flightlist and missionA.flightlist[1] then
            local flight = missionA.flightlist[1]
            local flightplan = flight.course
            if flightplan then
              local takeoff = flightplan[1].Zulu
              local date = bL3.AuxFunctions.ZuluToIso(takeoff)
              v.TakeOff = date
              bL3.TargetList[k] = v
            end
          end
        else 
          local TakeOfDate = v.TakeOff
          local ts_TakeOff = bL3.AuxFunctions.ConvertIsoToTimeStamp(TakeOfDate)
          if ts_TakeOff and ts_TakeOff > ScenEdit_CurrentTime() then
            v.status = 2
            bL3.TargetList[k] = v
          end
        end
      else
        v.status = 2
        bL3.TargetList[k] = v
      end
    elseif v.status == 2 then
      local tot_iso = v.ToT
      local ts_ToT = bL3.AuxFunctions.ConvertIsoToTimeStamp(tot_iso)
      if ts_ToT and ts_ToT < currentTime then
        local target = SE_GetUnit({guid = k})
        if target then
          v.status = 4
        else
          v.status = 3
        end
        bL3.TargetList[k] = v
      end
    end
    ::continueEnd2::
  end
end
function bL3.Functions.SaveNotes(notes)
  bL3.BLUE.OOB = gKH.json.parse(notes)
  gKH.State.SaveTableToKey(bL3.BLUE.OOB,'OOB')
end

function bL3.Functions.RedSubsActions()
  local subs = VP_GetSide({side='RED'}):unitsBy('Submarine')
  for k,v in ipairs(subs) do
    local u = SE_GetUnit({guid = v.guid})

    if u and u.condition == 'Underway' then
      ScenEdit_SetMission('RED', u.mission.name, {StationThrottleSubmarine = 'Loiter', AttackThrottleSubmarine = 'Loiter', TransitThrottleSubmarine = 'Full'})
    end

  end
end


function bL3.Functions.AmphCloseBeach()
  bL3.MSG.AMPH1()
    local beach = bL3.RED.BEACH
    local beachArea = bL3.AuxFunctions.NewArea(beach, {side='RED', shape='circle', distance=45})
    bL3.AuxFunctions.UnitEntersAreaEvent('AMPH Enters Beach', {TargetSide='RED', TargetType=2, SpecificUnitID=bL3.RED.UNITS.C2SHIP}, beachArea,'bL3.Functions.AmphEntBeach()','add')

end

function bL3.Functions.AmphEntBeach()
  bL3.MSG.AMPH2()
  
  local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local msg = string.format('[%s] - AMPH Group Enters positions near the beach. RED Startegic Win. BLUE Strategic Loss',time)  
  table.insert(bL3.SCORE.LOG.RED,msg)
  table.insert(bL3.SCORE.LOG.BLUE,msg)
  bL3.AuxFunctions.SaveTableToKey(bL3.SCORE,'SCORE')
  if not ScenEdit_GetEvent('EndScenario') then
    local t = os.date(bL3.DATEFORMAT,ScenEdit_CurrentTime() + 5*60 )
    bL3.AuxFunctions.TimeEvent('EndScenario', t, 'bL3.Functions.EndScenario(3)','add')  
  end
end

function bL3.Functions.AmphWithDrawal()
  local ship_group = SE_GetUnit({name='ARG', side='RED'})
  local n_course = {
    {latitude=18.0749149630026, longitude=112.356770345252},
    {latitude='18.8695109501054', longitude='110.576858916865'}
  }
  ScenEdit_SetUnit({guid = ship_group.guid, course=n_course, presetThrottle=4})
  local withdrawalArea = bL3.AuxFunctions.NewArea(n_course[1],{side='RED',shape='circle', distance=30})
  bL3.AuxFunctions.UnitEntersAreaEvent('RED WITHDRAWAL', {TargetSide='RED', TargetType=2},withdrawalArea,'bL3.Functions.EndScenario()')
  bL3.RED.AMPHWITHDRAWAL = true
  --TODO Move assets to defend the withdrawal of the AMPHGROUP

end

function bL3.Functions.GetScenarioResult()
  --Index indicate 2: Strategic Win 1: Tactical Win, -1 Tactical Loss, -2 Strategic Loss, 0 
  local BLUESTRATWIN = 1
  local BLUETACTWIN = 2
  local REDSTRATWIN = 3
  local REDTACTWIN = 4
  local TACTLOSS = 6
  local STRATLOSS = 7

  local blueIndex = 2
  local total = 0
  local alive = 0
  for k,v in pairs(bL3.BLUETARGETS) do
    local t = SE_GetUnit({guid = k})
    local p = v.points
    total = total + p
    if t then
      alive = alive + p
    end
  end
  local strategicRatio = alive/total
  if  strategicRatio <= 0.5 then
    blueIndex = -2
    goto calcRed
  end
  if blueIndex > 0 then
    --Check Attritions
    local airAtt, seaAtt, landAtt
    for k,v in pairs(bL3.BLUE.ATTRITION) do
      if k == 'Aircraft' then
        if v.TOTAL > 100 then
          airAtt = v.CURRENT / v.TOTAL
        elseif v.TOTAL < 10 then
          airAtt = 1
        else
          airAtt = v.CURRENT / v.TOTAL + 0.5
        end
      elseif k == 'Land' then
        if v.TOTAL > 100 then
          landAtt = v.CURRENT / v.TOTAL
        elseif v.TOTAL < 10 then
          landAtt = 1
        else
          landAtt = v.CURRENT / v.TOTAL + 0.5
        end
      else
        if v.TOTAL > 30 then
          seaAtt = v.CURRENT / v.TOTAL
        elseif v.TOTAL < 10 then
          seaAtt = 1
        else
          seaAtt = v.CURRENT / v.TOTAL + 0.5
        end
      end
    end

    if airAtt < 0.25 or landAtt < 0.25 then
      blueIndex = 1
      if (airAtt < 0.25 and landAtt < 0.25) then
        blueIndex = -1
      end
      if bL3.SCORE.BLUE < -20 and strategicRatio < 0.75 then
        blueIndex = -1
      end
    end
  end
  ::calcRed::
  local c2 = SE_GetUnit({guid = bL3.RED.UNITS.C2SHIP})
  local redIndex = 1
  if not c2 then
    redIndex = -2
    goto calcIndex 
  else
    local namph = bL3.RED.AMPH
    if namph < 2 then
      redIndex = -2
    else
      redIndex = -1
    end
  end
  if redIndex >= 0 then
    local airAtt, seaAtt
    for k,v in pairs(bL3.RED.ATTRITION) do
      if k == 'Aircraft' then
        airAtt = v.CURRENT / v.TOTAL
      else
        seaAtt = v.CURRENT / v.TOTAL
      end
    end

    if airAtt < 0.25 and seaAtt < 0.25 then
      redIndex = -2
    elseif airAtt < 0.25 or seaAtt < 0.25 then
      redIndex = -1
    end
  end
  ::calcIndex::

  if blueIndex == 2 then return BLUESTRATWIN elseif redIndex == 1 then return REDTACTWIN 
  else
    if blueIndex == -2 and redIndex == -2 then return 7
    elseif blueIndex > redIndex then
      if blueIndex == 1 then
        return BLUETACTWIN
      else
        return TACTLOSS
      end
    else
      return REDTACTWIN
    end
  end

end

function bL3.Functions.EndScenario(index)
  local mode = {'Blue Strategic Win', 'Blue Tactical Win', 'Red Strategic Win', 'Red Tactical Win', 'Blue Non-compliance with ROE','Blue and Red Tactical Loss', 'Blue and Red Strategic Loss'}
  local r
  if index then 
    r = mode[index] 
  else
    local i = bL3.Functions.GetScenarioResult()
    r = mode[i]
  end
  bL3.Functions.Scoring(r)
  
  bL3.Functions.UnitKillComparison()

  ScenEdit_EndScenario()
end

--AuxFunctions-lua
bL3.AuxFunctions={}
function bL3.AuxFunctions.ImprovedRandomseed(quality)
  if quality == nil then quality=3 end
  -- os.time() removes dependency on how long the software has been running currently
  -- os.clock() provides miliseconds, unlike os.time()
  -- we "chain" this with previous math.random() output
  -- and "stir" a little by repeating more than once, though not much because the execution time
  -- probably doesn't vary much between calls and spending too much time will be a waste unless we want
  -- to spend several seconds doing this.
  math.randomseed(os.time() + math.random(90071992547)) -- preserve some previous seeding if there was any
  for i = 1, quality do
      -- Retain some previous PRNG state while adding a little jitter entropy, but not much.
      -- Jitter entropy comes from thread preemption, interrupt handing, and stuff like that in the OS that is
      -- somewhat random. This means you might not get much if any on a powerful and calm system.
      -- If we had a higher precision clock with ns instead of just ms then that would be more helpful.
      math.randomseed(((os.clock() * 1000) % 1000) + math.random(900719925470000))
  end
end

function bL3.AuxFunctions.DateToTimeStamp(date_string)
  local day, month, year, hour, min, sec = date_string:match("(%d%d)/(%d%d)/(%d%d%d%d) (%d%d):(%d%d):(%d%d)")

-- Crear una tabla con los datos para os.time
local time_table = {
    year = tonumber(year),
    month = tonumber(month),
    day = tonumber(day),
    hour = tonumber(hour),
    min = tonumber(min),
    sec = tonumber(sec)
}

-- Convertir la tabla en un timestamp
local timestamp = os.time(time_table)
return timestamp
end

function bL3.AuxFunctions.getKeys(t_table)
  local keyset={}
  local n=0
  
  for k,v in pairs(t_table) do
    n=n+1
    keyset[n]=k
  end
  return keyset
end
function bL3.AuxFunctions.matchWithTable(str, table)
  for pattern, value in pairs(table) do
      if string.match(str, pattern) then
          return value
      end
  end
  return nil -- No se encontró coincidencia
end

function bL3.AuxFunctions.KeyRegex(tabla, regex)
  local claves = {}
  for clave, valor in pairs(tabla) do
    if string.match(clave, regex) then
      table.insert(claves, clave)
    end
  end
  return claves
end
function bL3.AuxFunctions.ACP126(rec_station,snd_station,precedence,from,to,classification,body)
  --rec_station --4 letter code (e.g. YDCX)
  --snd_station --4 letter code +/- NR 3 number (e.g. YBDN NR 270)
  --precedence --Flash (Z), Immediate (O), Priority (P), Routine (R), Flash Override (Y)
  local dtg = bL3.AuxFunctions.DTG()
  --from --e.g. MET FLT OPS
  --to --e.g. SSN 21 SEAWOLF
  --classification --Unclass +/- SBU / FOUO / NOFORN (Restricted), Confidential, Secret, Top Secret
  --body
  local _,gr = body:gsub("%S+","")
  local sig_string = string.upper('<P><FONT face=Consolas>'..rec_station..' <BR>'..
  'DE '..snd_station..' <BR>'..
  precedence..' '..dtg..' <BR>'..
  'fm '..from..' <BR>'..
  'to '..to..' <BR>'..
  'wd gr'..gr..' <BR>'..
  'bt <BR>'..
  classification..' <BR>'..
  body..' <BR>'..
  'bt <BR>'..
  'nnnn </P>')
  return sig_string
end
function bL3.AuxFunctions.getUnit()
  local unit =  ScenEdit_SelectedUnits().units[1].name
  return ScenEdit_GetUnit({name=unit})
end


function bL3.AuxFunctions.msg(text)
  ScenEdit_SpecialMessage('playerside',text)
end
function bL3.AuxFunctions.KillUnitEvent(luascript, mode, targetFilter)
  ScenEdit_SetTrigger( { mode = mode, type='UnitDestroyed', name='UnitDestroyed',TargetFilter=targetFilter } )

  ScenEdit_SetAction({ mode = 'add', type='LuaScript', name='Lua-UnitDestroyed', ScriptText=luascript})

  ScenEdit_SetEvent('UnitIsDestroyed', {mode=mode, IsRepeatable = true})
  ScenEdit_SetEventTrigger('UnitIsDestroyed', {mode=mode, name='UnitDestroyed'})
  ScenEdit_SetEventAction('UnitIsDestroyed', {mode=mode, name='Lua-UnitDestroyed'})

end

function bL3.AuxFunctions.UnitDamaged(name,FilterType,luascript, mode,dp, rep)
  if mode == 'add' then
  local trigger = ScenEdit_SetTrigger({mode = 'add', type='UnitDamaged', name = name..'-trig', DamagePercent=dp,TargetFilter=FilterType})
  local action = ScenEdit_SetAction({ mode = 'add', type = 'LuaScript', name = name .. '-action', ScriptText = luascript })
  local event = ScenEdit_SetEvent( name, { mode = 'add', IsRepeatable = rep, isShown = false })
  ScenEdit_SetEventTrigger( name, { mode = 'add', name = name .. '-trig' })
  ScenEdit_SetEventAction( name, { mode = 'add', name = name .. '-action' })
  elseif mode=='update' then
    local trigger = ScenEdit_SetTrigger({mode = 'update', type='UnitDamaged', name = name..'-trig', DamagePercent=dp,TargetFilter=FilterType})
    local action = ScenEdit_SetAction({ mode = 'add', type = 'LuaScript', name = name .. '-action', ScriptText = luascript })
    local event = ScenEdit_SetEvent( name, { mode = 'add', IsRepeatable = rep, isShown = false })
    ScenEdit_SetEventTrigger( name, { mode = 'add', name = name .. '-trig' })
    ScenEdit_SetEventAction( name, { mode = 'add', name = name .. '-action' })
  end
end

function bL3.AuxFunctions.TimeEvent(name, trig_time, luascript, mode, Repeatable)
  local retval, retval1, retval2, event
  local rep = (Repeatable or false)
  if mode == 'add' then -- ADD
    retval, event = pcall(ScenEdit_SetTrigger, { mode = 'add', type = 'Time', name = name .. '-trig', time = trig_time })
    if not retval then
      print("[Error at " .. debug.getinfo(1).currentline .. "] - AddTimeEvent: Error adding the trigger. " .. event)
      return nil
    end
    retval, event = pcall(ScenEdit_SetAction,
    { mode = 'add', type = 'LuaScript', name = name .. '-action', ScriptText = luascript })
    if not retval then
      print("[Error at " .. debug.getinfo(1).currentline .. "] - AddTimeEvent: Error adding the action. " .. event)
      return nil
    end
    retval, event = pcall(ScenEdit_SetEvent, name, { mode = 'add', IsRepeatable = rep, isShown = false })
    retval1 = pcall(ScenEdit_SetEventTrigger, name, { mode = 'add', name = name .. '-trig' })
    retval2 = pcall(ScenEdit_SetEventAction, name, { mode = 'add', name = name .. '-action' })
    if retval and retval1 and retval2 then
      return event
    else
      print("[Error at " .. debug.getinfo(1).currentline .. "] - TimeEvent failed when creating the event: " .. event)
    end
  elseif mode == 'remove' then
    retval = pcall(ScenEdit_SetEvent, name, { mode = 'remove' })
    retval1 = pcall(ScenEdit_SetTrigger, { description = name .. '-trig', mode = 'remove' })
    retval2 = pcall(ScenEdit_SetAction, { description = name .. '-action', mode = 'remove', })
    if retval and retval1 and retval2 then return true else print("[Error at " ..
      debug.getinfo(1).currentline .. "] - TimeEvent failed when removing the event: " .. name) end
  elseif mode == 'update' then --UPDATE
    if trig_time ~= nil then
      retval = pcall(ScenEdit_SetTrigger, { mode = 'update', type = 'Time', name = name .. '-trig', time = trig_time })
      retval1, event = pcall(ScenEdit_SetEvent, name, { mode = 'update', isActive = true, isRepeatable = rep })
      if retval and retval1 then return event else print("[Error at " ..
        debug.getinfo(1).currentline .. "] - TimeEvent failed when updating the event: " .. event) end
    end
    if luascript ~= nil then
      retval = pcall(ScenEdit_SetAction, { mode = 'update', type = 'LuaScript', name = name .. '-action',
        ScriptText = luascript })
      if retval then return true else print("[Error at " ..
        debug.getinfo(1).currentline .. "] - TimeEvent failed when updating the event action: " .. event) end
    end
  elseif mode == 'remove' then
    ScenEdit_SetEvent(name, {mode='remove'})
    ScenEdit_SetAction({name=name..'-action', mode='remove'})
    ScenEdit_SetTrigger({name=name..'-trig', mode='remove'})
  end
end
function bL3.AuxFunctions.RegularEvent(name, interval, action, mode)
  local retval, retval1, retval2, event
  if mode == 'add' then
    retval = pcall(ScenEdit_SetTrigger, { description = name .. '-trig', mode = 'add', type = 'RegularTime',
      Interval = interval })
    if not retval then
      print("[Error at " ..
      debug.getinfo(1).currentline ..
      "] - AddRegularEvent: Error al añadir el trigger. Compruebe que el nombre del trigger sea único")
      return nil
    end
    retval = pcall(ScenEdit_SetAction, { mode = 'add', type = 'LuaScript', name = name .. '-action', ScriptText = action })
    if not retval then
      print("[Error at " ..
      debug.getinfo(1).currentline ..
      "] - AddRegularEvent: Error al añadir la acción. Compruebe que el nombre de la acción sea único")
      return nil
    end
    retval, event = pcall(ScenEdit_SetEvent, name, { mode = 'add', IsRepeatable = true, isShown = false })
    if not retval then
      print("[Error at " .. debug.getinfo(1).currentline .. "] - AddRegularEvent: Error al crear el evento.")
      return nil
    end
    ScenEdit_SetEventTrigger(name, { mode = 'add', name = name .. '-trig' })
    ScenEdit_SetEventAction(name, { mode = 'add', name = name .. '-action' })
    return event
  elseif mode == 'update' then
    if interval ~= nil then
      retval = pcall(ScenEdit_SetTrigger,
      { description = name .. '-trig', mode = 'update', type = 'RegularTime', Interval = interval })
      retval1, event = pcall(ScenEdit_SetEvent, name, { mode = 'update', name = name .. '-trig' })
      if retval and retval1 then
        return event
      else
        print("[Error at " .. debug.getinfo(1).currentline .. "] - UpdateEventTrigger Failed")
      end
    end
    if action ~= nil then
      retval = pcall(ScenEdit_SetAction, { mode = 'update', type = 'LuaScript', name = name .. '-action',
        ScriptText = action })
      retval1, event = pcall(ScenEdit_SetEvent, name, { mode = 'update', name = name .. '-action' })
      if retval and retval1 then
        return event
      else
        print("[Error at " .. debug.getinfo(1).currentline .. "] - UpdateEventAction Failed")
      end
    end
  elseif mode == 'delete' then
    retval = pcall(ScenEdit_SetEvent, name, { mode = 'remove' })
    retval1 = pcall(ScenEdit_SetAction, { mode = 'remove', name = name .. '-action' })
    retval2 = pcall(ScenEdit_SetTrigger, { description = name .. '-trig', mode = 'remove' })
    if not retval or not retval1 or not retval2 then print("[Error at " ..
      debug.getinfo(1).currentline .. "] - DeleteEvent Failed") else return true end
  end
end


---@param name string @ The name of the event
---@param FilterType table @ {TargetSide = 'N8SI1G-0HMNTT9V9303L', TargetSubType = '9001', ShowAllTypes = 'True', TargetType = '2'}
---@param area table @ Table with RefPoints defining the area
---@param script string @ Script action when trigger
---@param exit? boolean @ if true unit Leaves area
---@param isRepeatable? boolean @ Event is repeatable, false by default
---@param isActive? boolean @ Event is active, true by default
function bL3.AuxFunctions.UnitEntersAreaEvent(name, FilterType, area, script, mode, exit, isRepeatable, isActive)
  if isRepeatable == nil then isRepeatable = false end
  if isActive == nil then isActive = true end
  if exit == nil then exit = false end
  if mode == 'add' then
    local retval, result = pcall(ScenEdit_SetTrigger,{ description = name .. '_Entertrigg', mode = 'add', type = 'UnitEntersArea',TargetFilter = FilterType, Area = area, ExitArea = exit })
    if not retval then print("[ERROR]:"..result.." - trigger:"..name) return false end
    local retval, result = pcall(ScenEdit_SetAction,{ mode = 'add', type = 'LuaScript', name = name .. '-enteraction', ScriptText = script })
    if not retval then print("[ERROR]: "..result..'- trigger:'..name) return false end
    ScenEdit_SetEvent(name, { mode = 'add', IsRepeatable = isRepeatable, isActive = isActive, isShown = false })
    ScenEdit_SetEventTrigger(name, { mode = 'add', name = name .. '_Entertrigg' })
    ScenEdit_SetEventAction(name, { mode = 'add', name = name .. '-enteraction' })
  elseif mode == 'update' then
    if area ~= nil then
      ScenEdit_SetTrigger({ description = name .. '_Entertrigg', mode = 'update', type = 'UnitEntersArea',
        TargetFilter = FilterType, Area = area, ExitArea = exit })
    end
    if script ~= nil then
      ScenEdit_SetAction({ mode = 'update', type = 'LuaScript', name = name .. '-enteraction', ScriptText = script })
    end
  elseif mode == 'remove' then
    ScenEdit_SetTrigger({ description = name .. '_Entertrigg', mode = 'remove' })
    ScenEdit_SetAction({ description = name .. '-action', mode = 'remove' })
    ScenEdit_SetEvent(name, { mode = 'remove' })
  end
end

function bL3.AuxFunctions.UnitDetected(name,side,action,targetFilter,MCL)
ScenEdit_SetTrigger({name=name..'_trig',mode='add', type='UnitDetected', DetectorSideID=VP_GetSide({side=side}).guid, TargetFilter=targetFilter, MCL=MCL})
ScenEdit_SetAction({name=name..'_lua',mode='add',type='LuaScript', ScriptText=action})
ScenEdit_SetEvent(name, { mode = 'add', IsRepeatable = true, isShown = false })
ScenEdit_SetEventTrigger(name, { mode = 'add', name = name..'_trig' })
ScenEdit_SetEventAction(name, { mode = 'add', name = name..'_lua' })
end
function bL3.AuxFunctions.shuffle(t)
  bL3.AuxFunctions.ImprovedRandomseed(3)
  local n = #t
  while n > 1 do
      local k = math.random(n) -- Genera un índice aleatorio
      t[n], t[k] = t[k], t[n] -- Intercambia el elemento n con el elemento k
      n = n - 1
  end
end

function bL3.AuxFunctions.shuffleTable(t)
  -- Convertir la tabla de hash a una tabla indexada
  local indexedTable = {}
  for key, value in pairs(t) do
      table.insert(indexedTable, {key = key, value = value})
  end

  -- Mezclar la tabla indexada
  for i = #indexedTable, 2, -1 do
      local j = math.random(i)
      indexedTable[i], indexedTable[j] = indexedTable[j], indexedTable[i]
  end

  -- Crear la tabla aleatoria con las claves originales
  local shuffledTable = {}
  for _, entry in ipairs(indexedTable) do
      shuffledTable[entry.key] = entry.value
  end

  return shuffledTable
end

function bL3.AuxFunctions.RemoveEvent(event_name)
  local event = ScenEdit_GetEvent(event_name)
  if event ~= nil then
    ScenEdit_SetEvent(event_name, { mode = 'remove' })
    for k,v in ipairs(event.actions) do
      for typ,action in pairs(v) do
        if action.ID ~= nil then
          ScenEdit_SetAction({description=action.ID,mode='remove'})
        end
      end
    end
    
    for k,v in ipairs(event.triggers) do
      for typ,action in pairs(v) do
        if action.ID ~= nil then
          ScenEdit_SetTrigger({description = action.ID, mode='remove'})
        end
      end
    end
  end

end

---This function check if the unit is contact of a side
---@param side string Side to check contact list
---@param unit CMO__Unit Unit wrapper to check if it's a contact
---@return boolean  @True if unit is a contact
---@return string|nil @Contact Guid or nil
function bL3.AuxFunctions.IsUnitContact(side,unit)
  local side_guid = VP_GetSide({side=side}).guid
  local ascontact_t = unit.ascontact
  if ascontact_t ~= nil then
    for k,v in ipairs(ascontact_t) do
      if v.side == side_guid then return true, v.guid end
    end
  end
  return false, nil
end



function bL3.AuxFunctions.UnitRemainsInAreaEvent(name, FilterType, area, script, time, isRepeatable)
  local isrep = (isRepeatable or false)
  local retval, result = pcall(ScenEdit_SetTrigger,{ description = name .. '_trigg', mode = 'add', type = 'UnitRemainsInArea', TargetFilter = FilterType, Area = area, TD = time })
  if not retval then print("[ERROR]: "..result..'- trigger:'..name) return false end
  local retval, result = pcall(ScenEdit_SetAction,{ mode = 'add', type = 'LuaScript', name = name .. '_action', ScriptText = script })
  if not retval then print("[ERROR]: "..result..'- trigger:'..name) return false end
  ScenEdit_SetEvent(name, { mode = 'add', IsRepeatable = isrep, isShown = false })
  ScenEdit_SetEventTrigger(name, { mode = 'add', name = name .. '_trigg' })
  ScenEdit_SetEventAction(name, { mode = 'add', name = name .. '_action' })
end

function bL3.AuxFunctions.ContactInArea(name,FilterType,DetectorSideID, area, script)
  --UNIT DETECTED
  ScenEdit_SetTrigger( { mode = 'add', type='UnitDetected',DetectorSideID=DetectorSideID, TargetFilter=FilterType,MCL='2', name='UnitIsDetectedbyUS', Area=area })
end

function bL3.AuxFunctions.SetTrigToEvent(event_name, mode, FilterType, area, trig_name)
  local event = ScenEdit_GetEvent(event_name)
  if event == nil then return false end
  if mode == 'add' then

  elseif mode == 'remove' then

  elseif mode == 'update' then
  else
    return false
  end
end
---@diagnostic disable-next-line: lowercase-global
function getUnit()
  local unit =  ScenEdit_SelectedUnits().units[1].name
  return ScenEdit_GetUnit({name=unit})
end


function bL3.AuxFunctions.GetRandomPoint(latitude,longitude,options)
  local function GetPoint(minDistance,maxDistance,minBearing,maxBearing)
    local distance
    if maxDistance >= 1 then
      distance = math.random(minDistance,maxDistance-1)+math.random()
    else
      distance = bL3.AuxFunctions.RandomFloat(minDistance,maxDistance,9)
    end
    local bearing = math.random(minBearing,maxBearing)
    local point = World_GetPointFromBearing( { latitude = latitude, longitude = longitude, distance = distance, bearing = bearing } )
    return point
  end
  local iter = 0
  local minDistance, maxDistance,minBearing, maxBearing = options.minDistance, options.maxDistance, options.minBearing, options.maxBearing
  if maxDistance == nil then maxDistance = 10 end
  if minDistance == nil then minDistance = 0 end
  if minBearing == nil then minBearing = 0 end
  if maxBearing == nil then maxBearing = 359 end
  if options.altitude == nil then options.altitude= false end
  if maxDistance < minDistance or maxBearing < minBearing then return nil end
  if options.altitude == true then
    local max_altitude = 0
    local selected_point
    for i=1,20 do
      ::redoPointInArea::
      local point = GetPoint(minDistance,maxDistance,minBearing,maxBearing)
      if options.area ~= nil and options.side ~= nil and not bL3.AuxFunctions.PointInArea(point,options.area,options.side) then goto redoPointInArea end
      if World_GetElevation(point) > max_altitude then
        max_altitude = World_GetElevation(point)
        selected_point = point
      end
    end
    return selected_point
  end
  ::redoPosition::
  iter=iter+1
  if iter > 100 then print("No point with find") return nil end
  local point = GetPoint(minDistance,maxDistance,minBearing,maxBearing)
  if options.mode == nil then return {latitude = point.latitude, longitude = point.longitude} end
  if options.mode == 0 then 
    if World_GetElevation(point) > -20 then goto redoPosition end
  else
    if World_GetElevation(point) < 0 then  goto redoPosition end
  end
  if options.area ~= nil then
    if bL3.AuxFunctions.PointInArea(point,options.area,options.side) then return {latitude=point.latitude,longitude=point.longitude} else goto redoPosition end
  end
  

  return {latitude=point.latitude,longitude=point.longitude}
end
function bL3.AuxFunctions.translateCourse(course)
  if course=="N" then return 0
  elseif course=="S" then return 180
  elseif course=="E" then return 90
  elseif course=="W" then return 270
  elseif course=="NW" then return 315
  elseif course=="NE" then return 45
  elseif course=="SW" then return 225
  elseif course=="SE" then return 135
      --do
  end

end
function bL3.AuxFunctions.writeTableInOneLine(tbl)
  local result = "{"
  for key, value in pairs(tbl) do
      if type(value) == "table" then
          result = result .. bL3.AuxFunctions.writeTableInOneLine(value) .. ","
      else
          result = result .. tostring(value) .. ","
      end
  end
  result = result:sub(1, -2) .. "}"
  return result
end

function bL3.AuxFunctions.getWayPoint(distance,ruta,p0,lat,lon)
  --distancia: distance in nm
  --p0 -> deg variance in course
  --lat -> lat orig 
  --lon -> lon orig
  local bearing=bL3.AuxFunctions.translateCourse(ruta)+math.random(-p0,p0)
  local pos = World_GetPointFromBearing({latitude=lat, longitude=lon, bearing=bearing, distance=distance})
  local course ={
      [1]={ latitude=pos.latitude, longitude=pos.longitude, TypeOf = 'ManualPlottedCourseWaypoint' }
  }
  
  return course
  
end

function bL3.AuxFunctions.SetUnitCourse(unit,orden,desv)
  local lat_original=unit.latitude
  local lon_original=unit.longitude
  local lat_act=lat_original
  local lon_act=lon_original
  local tbl_ruta={}
  for distancia,ruta in string.gmatch(orden, "(%d+)(%a+)") do
      local way = bL3.AuxFunctions.getWayPoint(distancia,ruta,desv,lat_act,lon_act)
      lat_act=way[1].latitude
      lon_act=way[1].longitude
      table.insert(tbl_ruta,{ TypeOf = 'ManualPlottedCourseWaypoint', latitude = lat_act, longitude = lon_act} )
  end
  ScenEdit_SetUnit({guid=unit.guid,course=tbl_ruta})
end
---comment
---@param position CMO__Location @latitude, longitude
---@param mode table @shape, side, bear_offset, distance
---@return table|nil
function bL3.AuxFunctions.NewArea(position,mode)
  local side = mode.side
  local shape = mode.shape
  if side == nil or shape == nil then return nil end
  local name = (mode.name or nil)
  local bear_offset = (mode.bear_offset or 0)
  local rpTable={}
  local relative_unit = (mode.relativeTo or nil)
  local a = 1
  --Circle
  if shape== 'circle' then
    local distance = mode.distance
    local n = math.random(1,9999)
    for i = 0,359, 30 do
      local location = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, distance=distance, bearing=i})
      local rp
      if name then
         rp =ScenEdit_AddReferencePoint({side = side, latitude=location.latitude, longitude=location.longitude, name=name..' '..n, relativeTo=relative_unit})
      else
        rp = ScenEdit_AddReferencePoint({side = side, latitude=location.latitude, longitude=location.longitude, relativeTo=relative_unit})
      end
      
      a=a+1
      if rp then
        table.insert(rpTable,rp.name)
      end
      
    end
  elseif shape == 'square' then
    local distance = mode.distance
    for i = 0,3 do
      local b = 45 + (90 * i) + bear_offset
      local location = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, distance=distance, bearing=b})
      local rp =ScenEdit_AddReferencePoint({side = side, latitude=location.latitude, longitude=location.longitude, relativeTo=relative_unit})
      table.insert(rpTable,rp.name)
    end
    -- Rectangle
  elseif shape == 'rectangle' then
    local half_length = mode.length / 2
    local half_width = mode.width / 2

    -- Define the four corners based on the center point
    local corners = {
      {distance = half_length, bearing = 90 + bear_offset},    -- Top center
      {distance = half_width, bearing = 180 + bear_offset},    -- Left center
      {distance = half_length, bearing = 270 + bear_offset},   -- Bottom center
      {distance = half_width, bearing = 0 + bear_offset}       -- Right center
    }

    for _, corner in ipairs(corners) do
      local location = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, distance=corner.distance, bearing=corner.bearing})
      local rp = ScenEdit_AddReferencePoint({side = side, latitude=location.latitude, longitude=location.longitude, relativeTo=relative_unit})
      table.insert(rpTable, rp.name)
    end

  -- Triangle
  elseif shape == 'triangle' then
    local distance = mode.distance
    local angles = {0, 120, 240}
    for i = 1, 3 do
      local b = angles[i] + bear_offset
      local location = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, distance=distance, bearing=b})
      local rp = ScenEdit_AddReferencePoint({side = side, latitude=location.latitude, longitude=location.longitude})
      table.insert(rpTable, rp.name)
    end
    end
  

  return (rpTable)

end

function bL3.AuxFunctions.DeleteArea(area, side)
  for k,v in ipairs(area) do
    ScenEdit_DeleteReferencePoint({side=side, name=v})
  end
end

function bL3.AuxFunctions.RandomTxt(numLetters)
  local totTxt = ""
  for i = 1, numLetters do
    totTxt = totTxt .. string.char(math.random(65, 90))
  end
  return totTxt
end

function bL3.AuxFunctions.RandomFloat(min, max, escala)
  if min ~= nil and max ~= nil and min < max then
    return math.random(min * (10 ^ escala), max * (10 ^ escala)) / (10 ^ escala)
  end
  return 0
end

function bL3.AuxFunctions.RandomPar(min, max)
  local num = math.random(min, max)
  if num % 2 ~= 0 then num = num + 1 end
  return num
end

function bL3.AuxFunctions.Round(num, numDecimalPlaces)
  local mult = 10 ^ (numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end
function bL3.AuxFunctions.split(inputstr, sep)
  if sep == nil then
      sep = "%s"
  end
  local t = {}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
      table.insert(t, str)
  end
  return t
end
---Define a function bL3.AuxFunctions.to check if a point is inside a polygon on a sphere
---@param point any
---@param polygon any
---@return boolean
function bL3.AuxFunctions.PointInArea(point, polygon, side)
  local j = #polygon
  local oddNodes = false
  for i = 1, #polygon do
    local pi = ScenEdit_GetReferencePoint({ side = side, name = polygon[i] })
    local pj = ScenEdit_GetReferencePoint({ side = side, name = polygon[j] })
    if pi == nil or pj == nil then
      print("[Error 344] In Area Function points are nil")
      return false
    end
    if (pi.latitude < point.latitude and pj.latitude >= point.latitude
        or pj.latitude < point.latitude and pi.latitude >= point.latitude) then
      if (pi.longitude + (point.latitude - pi.latitude) /
          (pj.latitude - pi.latitude) *
          (pj.longitude - pi.longitude) < point.longitude) then
        oddNodes = not oddNodes
      end
    end
    j = i
  end

  return oddNodes
end

function bL3.AuxFunctions.calculateArea(coords)
  local earthRadius = 6371 -- Radio de la tierra en km
  local total = 0

  if #coords < 3 then
      return 0
  end

  for i = 1, #coords - 1 do
      total = total + (coords[i].longitude - coords[i + 1].longitude) * 
              (2 + math.sin(coords[i].latitude * math.pi / 180) + 
              math.sin(coords[i + 1].latitude * math.pi / 180))
  end

  -- Cierre el polígono
  total = total + (coords[#coords].longitude - coords[1].longitude) * 
          (2 + math.sin(coords[#coords].latitude * math.pi / 180) + 
          math.sin(coords[1].latitude * math.pi / 180))

  return math.abs(total) * earthRadius^2 / 2
end

function bL3.AuxFunctions.WeatherReport(outlook)
  if outlook == nil then outlook = 'next forecast at ' .. bL3.AuxFunctions.DTG(ScenEdit_CurrentTime() + 8*60*60) end
  --Generate special message to player
  local weather = ScenEdit_GetWeather() --Get new weather parameters
  local temp, cloud, rain, sea = weather.temp, weather.undercloud, weather.rainfall, weather.seastate

  local f_temp = bL3.AuxFunctions.Round((temp * 1.8) + 32, 0) -- Convert to Fahrenheit for philistines
  local precipdesc, clouddesc
  --create rain/precipitation descriptor (based on in-game descriptions)
  if rain == 0 then
    precipdesc = 'nil'
  elseif rain < 5 then
    precipdesc = 'very light'
  elseif rain < 11 then
    precipdesc = 'light'
  elseif rain < 20 then
    precipdesc = 'moderate'
  elseif rain < 30 then
    precipdesc = 'heavy'
  elseif rain < 40 then
    precipdesc = 'very heavy'
  else
    precipdesc = 'extreme'
  end

  --create cloud descriptor (based on in-game descriptions)
  if cloud == 0 then
    clouddesc = 'clear skies'
  elseif cloud < 0.2 then
    clouddesc = 'light low clouds'
  elseif cloud < 0.3 then
    clouddesc = 'light middle clouds'
  elseif cloud < 0.4 then
    clouddesc = 'light high clouds'
  elseif cloud < 0.5 then
    clouddesc = 'moderate low clouds'
  elseif cloud < 0.6 then
    clouddesc = 'moderate middle clouds'
  elseif cloud < 0.7 then
    clouddesc = 'moderate high clouds'
  elseif cloud < 0.8 then
    clouddesc = 'moderate middle clouds & light high clouds'
  elseif cloud < 0.9 then
    clouddesc = 'solid middle clouds & moderate high clouds'
  elseif cloud < 1.0 then
    clouddesc = 'thin fog & solid cloud cover'
  else
    clouddesc = 'thick fog & solid cloud cover'
  end

  --rec_station,snd_station,precedence,from,to,classification,body
  local wx_time = bL3.AuxFunctions.DTG()
  local wx_report = bL3.AuxFunctions.ACP126('TODOS', 'METOPS', 'r', 'HYDROLOGICAL AND METEOROLOGICAL OFFICE', 'ALL STATIONS',
  'unclass',
  'WX REPORT ' ..
  wx_time ..
  ' - SCS <BR>AVERAGE TEMP ' ..
  temp ..
  '°C / ' ..
  f_temp .. '°F <BR> SEA STATE ' .. sea .. ' <BR>' .. precipdesc .. ' PRECIPITATION <BR>' .. clouddesc ..
  ' <BR>' .. outlook)
    local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
    local from = 'HYDROLOGICAL AND METEOROLOGICAL OFFICE' 
    local to = 'ALL STATIONS'
    local subject = 'WX REPORT'
    local message= wx_report
    local priority = 3
    bL3.MAIL.NEW(date,from,to,subject,message,priority)
end

function bL3.AuxFunctions.WeatherDrift()
  local weatherBaseline = { undercloud = 0.2, seastate = 2, rainfall = 0, temp = 13 }
  local seastateVariability = math.random(-1, 1)
  local rnd = math.random()
  
  local undercloudVariability = math.random(-2,2)/10
  
  local tempVariability = math.random(-3, 4)

  local rainfallVariability = 0
  if math.random() > 0.15 then rainfallVariability = math.random(1, 4) end

  local newTemp = weatherBaseline.temp + tempVariability
  local newRainfall = weatherBaseline.rainfall + rainfallVariability
  local newUndercloud = weatherBaseline.undercloud + undercloudVariability
  newRainfall = math.min(newRainfall,1)
  newRainfall = math.max(newRainfall,0)
  newUndercloud = math.min(newUndercloud,1)
  newUndercloud = math.max(newUndercloud,0)
  local newSeastate = weatherBaseline.seastate + seastateVariability

  ScenEdit_SetWeather(
    newTemp,     --temp
    newRainfall, --rainfall
    newUndercloud, --undercloud
    newSeastate  --seastate
  )
end

function bL3.AuxFunctions.removekey(table, key)
  for k, v in ipairs(table) do
    for unit_guid, element in pairs(v) do
      if unit_guid == key then
        table[k] = nil
      end
    end
  end
  return table
end
function bL3.AuxFunctions.ZuluToIso(datetime)
  if not datetime then return nil end
  -- Extract components from the input string using pattern matching
  local year = string.sub(datetime, 1, 4)
  local month = string.sub(datetime, 5, 6)
  local day = string.sub(datetime, 7, 8)
  local hour = string.sub(datetime, 9, 10)
  local min = string.sub(datetime, 11, 12)
  local sec = string.sub(datetime, 13, 14)
  if not (day and month and year and hour and min and sec) then
      return ""
  end
  -- Convert to a table with the correct format for os.time
  local date_table = {
      year = tonumber(year),
      month = tonumber(month),
      day = tonumber(day),
      hour = tonumber(hour),
      min = tonumber(min),
      sec = tonumber(sec)
  }
  
  -- Convert to ISO format
  return string.format("%04d-%02d-%02dT%02d:%02d:%02d", 
      date_table.year, date_table.month, date_table.day, 
      date_table.hour, date_table.min, date_table.sec)

end
function bL3.AuxFunctions.DTG(TimeVar)
  if TimeVar == nil then
    TimeVar = ScenEdit_CurrentTime()
  end
  local msgtime = os.date("!%d%H%M" .. "Z" .. " " .. "%b %y", TimeVar)
  ---@diagnostic disable-next-line: param-type-mismatch
  msgtime = string.upper(msgtime)
  return msgtime
end

function bL3.AuxFunctions.GetDate(LocalOrZulu)
  if LocalOrZulu == 1 then
    return os.date("%Y/%m/%d ", ScenEdit_CurrentTime())
  else
    return os.date("%Y/%m/%d", ScenEdit_CurrentTime() + bL3.Zulu * 60)
  end
end

function bL3.AuxFunctions.GetTime(LocalOrZulu)
  if LocalOrZulu == 1 then
    return os.date("%H%MZ", ScenEdit_CurrentTime())
  else
    return os.date("%H%M UTC+1", ScenEdit_CurrentTime() + bL3.Zulu * 60*60)
  end
end

function bL3.AuxFunctions.ConvertTimeStamp(date)
  local pattern = "(%d+)/(%d+)/(%d+) (%d+):(%d+):(%d+)"
  local runday, runmonth, runyear, runhour, runminute, runseconds = date:match(pattern)
  local convertedTimestamp = os.time({ year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute,
    sec = runseconds })
  return convertedTimestamp
end
function bL3.AuxFunctions.ConvertIsoToTimeStamp(isoDate)
  if not isoDate then return nil end
  local pattern = "(%d+)-(%d+)-(%d+)T(%d+):(%d+):(%d+)"
  local runyear, runmonth,runday, runhour, runminute, runseconds = isoDate:match(pattern)
  local convertedTimestamp = os.time({ year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute,
    sec = runseconds })
  return convertedTimestamp
end
function bL3.AuxFunctions.ChangeTimeEvent(event_name,time)
  local event_t = ScenEdit_GetEvent(event_name, 1)
  if event_t then
    local trigg = event_t.triggers[1].Time
    if trigg then
      local newTime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + time)
      ScenEdit_SetTrigger({Description=trigg.Description, Time = newTime, Mode='update'})
      ScenEdit_SetEvent(event_name, {isActive=true})
    end
  end

end
function bL3.AuxFunctions.sortTableByValueKey(t, valueKey)
    -- Extract keys into an array
    local keys = {}
    for k, _ in pairs(t) do
        table.insert(keys, k)
    end
  
    -- Sort keys based on the value of the given key in the table values
    table.sort(keys, function(a, b)
        return t[a][valueKey] < t[b][valueKey]
    end)
  
    return keys
end
function bL3.AuxFunctions.sortTablebyType(t, key)
  -- Convert the hash table to a sortable array with key-value pairs
  local indexedTable = {}
  for k, v in pairs(t) do
      table.insert(indexedTable, {key = k, value = v})
  end

  -- Comparison function to sort by the specified key in the value
  local function compare(a, b)
      if type(a.value[key]) == "string" then
        return tostring(a.value[key]):upper() < tostring(b.value[key]):upper()
      else
        return a.value[key] < b.value[key]
      end
      
  end

  -- Sort the indexed table
  table.sort(indexedTable, compare)

  -- Reconstruct the sorted table with original keys
  local sortedTable = {}
  for _, entry in ipairs(indexedTable) do
      sortedTable[entry.key] = entry.value
  end

  return sortedTable
end
function bL3.AuxFunctions.RemoveMounts(unit,t_Mounts)
  if t_Mounts == nil then t_Mounts = {[0]=1} end
  for k,v in ipairs(unit.mounts) do
    if t_Mounts[v.mount_dbid] == nil then
      ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_mount', dbid=v.mount_dbid})
    end
  end
end
function bL3.AuxFunctions.RemoveMagazines(unit,t_Mags)
  if t_Mags == nil then t_Mags = {[0]=1} end
  for k,v in ipairs(unit.magazines) do
    if t_Mags[v.mag_dbid] == nil then
      ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_magazine', dbid=v.mag_dbid})
    end
  end
end
function bL3.AuxFunctions.MakeUnitDecoy(unit,keepSensors)
  if unit.mounts ~= nil then
    for k,v in ipairs(unit.mounts) do
        ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_mount', mountid=v.mount_guid})
    end
  end
  if unit.sensors ~= nil and not keepSensors then
    for k,v in ipairs(unit.sensors) do
      ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_sensor', sensorid =v.sensor_guid})
    end
  end
  if unit.magazines ~= nil then
    for k,v in ipairs(unit.magazines) do
      ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_magazine', magid=v.mag_guid})
    end
  end
end

bL3.AuxFunctions.ImprovedRandomseed(3)
function bL3.AuxFunctions.RemoveSensors(unit)
  for _,v in ipairs(unit.sensors) do
    ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_sensor', dbid=v.sensor_dbid, sensorid=v.sensor_guid})
  end
end
function bL3.AuxFunctions.EscapeString(str)
  return str
    :gsub("\\", "\\\\")   -- escape backslash
    :gsub("\"", "\\\"")   -- escape quote
    :gsub("\b", "\\b")    -- backspace
    :gsub("\f", "\\f")    -- form feed
    :gsub("\n", "\\n")    -- newline
    :gsub("\r", "\\r")    -- carriage return
    :gsub("\t", "\\t")    -- tab
end
function bL3.AuxFunctions.TableToJson(tbl)
  if not tbl then return "" end
  local json = ""
  local is_array = (#tbl > 0)

  if is_array then
      json = "["
  else
      json = "{"
  end

  local first = true
  for k, v in pairs(tbl) do
      if not first then
          json = json .. ", "
      end
      first = false

      if is_array then
          json = json .. bL3.AuxFunctions.ValueToJson(v)
      else
          json = json .. "\"" .. tostring(k) .. "\": " .. bL3.AuxFunctions.ValueToJson(v)
      end
  end

  if is_array then
      json = json .. "]"
  else
      json = json .. "}"
  end

  return json
end
function bL3.AuxFunctions.ValueToJson(value)
  local t = type(value)
  if t == "number" or t == "boolean" then
      return tostring(value)
  elseif t == "string" then
      return "\"" .. bL3.AuxFunctions.EscapeString(value) .. "\""
  elseif t == "table" then
      return bL3.AuxFunctions.TableToJson(value)
  else
      error("Unsupported value type: " .. t)
  end
end

function bL3.AuxFunctions.SetWeapon(unit,weapon_dbid,mount_id, num_weapons)
  local one_weapon = true
  local mounts=unit.mounts
  if mount_id ~= nil then
    if mounts and num_weapons then
      for k,v in ipairs(mounts) do
        if v.mount_weapons and #v.mount_weapons >0 then
          ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_mount', dbid=v.mount_dbid})
        end
      end
      for i=1,num_weapons do
        ScenEdit_UpdateUnit({guid = unit.guid, mode='add_mount', dbid=mount_id, arc_mount={'360'}})
      end
    end
    mounts=unit.mounts
    if unit.mounts ~= nil then
      for _,v in pairs(mounts) do
        if v.mount_dbid == mount_id then
          local weapons = v.mount_weapons
          for _,w in pairs(weapons) do
            local rep =  w.wpn_current
              if w.wpn_dbid ~= weapon_dbid then
                ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=rep, remove=true} )
              else
                ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=rep, remove=true} )
                ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=1} )
              end
          end
        else
          local weapons = v.mount_weapons
          if weapons then
            for _,w in pairs(weapons) do
              if w.wpn_dbid ~= weapon_dbid then
                ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=w.wpn_current, remove=true} )
              end
            end
          end
        end
          
      end
    end
    if unit.magazines then
      for k,v in ipairs(unit.magazines) do
        if #v.mag_weapons > 0 then
          if v.mag_dbid ~= 0 then
            for _,w in ipairs(v.mag_weapons) do
              if w.wpn_dbid ~= weapon_dbid then
                ScenEdit_AddWeaponToUnitMagazine( { guid = unit.guid, wpn_dbid=w.wpn_dbid, remove=true, number=w.wpn_current } )
              else
                ScenEdit_AddWeaponToUnitMagazine( { guid = unit.guid, wpn_dbid=w.wpn_dbid, remove=false, number=w.wpn_maxcap } )
              end
            end
          end
        end
      end
    end
  else
    if unit.mounts then
      for k,v in ipairs(unit.mounts) do
        ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_mount', dbid=v.mount_dbid})
      end
    end
    if unit.type == 'Aircraft' then
      local weapons = ScenEdit_GetLoadout({unitname = unit.guid})
      if weapons and weapons.weapons then
        for k3,w in ipairs(weapons.weapons) do
          if w.wpn_dbid ~= weapon_dbid and w.wpn_type < 2006 then
            ScenEdit_SetLoadout({unitname=unit.guid, LoadoutID=0, Wpn_DBID=w.wpn_dbid, number=w.wpn_current, remove=true})
          else
            ScenEdit_SetLoadout({unitname=unit.guid, LoadoutID=0, Wpn_DBID=w.wpn_dbid, number=w.wpn_current, remove=true})
            ScenEdit_SetLoadout({unitname=unit.guid, LoadoutID=0, Wpn_DBID=w.wpn_dbid, number=num_weapons})
          end
        end
      end
    end
  end
end

function bL3.AuxFunctions.SetDoctrineSide(side_name,dbid,data)
  local doctrine = {
    ['AAW'] = {1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100,2400,2200,2201,2202,2203,2204,2211},
    ['Aircraft'] = {1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100},
    ['Fighter']= {2001,2002,2003,2004},
    ['Non-Fighter']= {2011,2012,2013,2021,2022,2023,2033,2031},
    ['Bomber']= {2011,2012,2013},
    ['Recon_EW'] = {2021,2022,2023},
    ['Helicopter']= {2100},
    ['Tanker']= {2033},
    ['AEW'] = {2031},
    ['C_RAM'] = {2400},
    ['Missile'] = {2200,2201,2202,2203,2204,2211},
    ['Guided_Weapon']= {2201,2202,2203,2204},
    ['Ballistic_Missile']= {2211},
    
    
    ['ASuW'] = {2999,3000,3001,3002,3003,3004,3101,3102,3103,3104,3105,3106,3107,3108,3201,3202,3203,3204,3205,3206,3207,3208,3301,3302,3303,3304,3305,3306,3307,3308,3401,3402,3403,3404,3405,3406,3407,3408},
    ['Ship'] = {2999,3000,3001,3002,3003,3004,3101,3102,3103,3104,3105,3106,3107,3108,3201,3202,3203,3204,3205,3206,3207,3208,3301,3302,3303,3304,3305,3306,3307,3308,3401,3402,3403,3404,3405,3406,3407,3408},
    ['Surface_Combatant']= {3101,3102,3103,3104,3105,3106,3107,3108},
    ['Carrier']= {3001,3002,3003,3004},
    ['Amphibiou']= {3201,3202,3203,3204,3205,3206,3207,3208},
    ['Auxiliary'] = {3301,3302,3303,3304,3305,3306,3307,3308},
    ['Merchant_Civilian'] = {3401,3402,3403,3404,3405,3406,3407,3408},
    
    ['LandW'] = {4999,5000,5001,5002,5005,5006,5011,5100,5101,5102,5103,5104,5105,5106,5200,5201,5202,5203,5400,5401,5402,5500,5501,5300},
    ['Land'] = {4999,5000,5001,5002,5005,5006,5011,5100,5101,5102,5103,5104,5105,5106,5200,5201,5202,5203,5400,5401,5402,5500,5501},
    ['Soft_Structure']= {5000,5001,5002,5005,5006,5011},
    ['Hardened_Structure']= {5100,5101,5102,5103,5104,5105,5106},
    ['Runway']= {5200,5201,5202,5203},
    ['Mobile_Soft'] = {5400,5401,5402},
    ['Mobile_Hardened'] = {5500,5501},
    ['Radar'] = {5300},

    ['ASW'] = {3999,4000,5601},
    ['Sub'] = {3999,4000},
    ['Underwater_Structure']= {5601},
    
    ['Satellite'] = {2300},
    ['Air_Base'] = {5801}
  }
  local salvo = data.salvo or 'inherit'
  local range = data.range or 'inherit'
  local shooters = data.shooters or 'inherit'
  local selfdefense = data.selfdefense or 'inherit'
  local targetType = doctrine[data.target]
  if not targetType then
    return 0
  end
  for k,i in ipairs(targetType) do
    ScenEdit_SetDoctrineWRA({SIDE=side_name, target_type=i, weapon_dbid=dbid}, {salvo,shooters,range,selfdefense})
  end
end
function bL3.AuxFunctions.SetDoctrineUnit(unit,dbid,data)
  local doctrine = {
    ['AAW'] = {1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100,2400,2200,2201,2202,2203,2204,2211},
    ['Aircraft'] = {1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100},
    ['Fighter']= {2001,2002,2003,2004},
    ['Non-Fighter']= {2011,2012,2013,2021,2022,2023,2033,2031},
    ['Bomber']= {2011,2012,2013},
    ['Recon_EW'] = {2021,2022,2023},
    ['Helicopter']= {2100},
    ['Tanker']= {2033},
    ['AEW'] = {2031},
    ['C_RAM'] = {2400},
    ['Missile'] = {2200,2201,2202,2203,2204,2211},
    ['Guided_Weapon']= {2201,2202,2203,2204},
    ['Ballistic_Missile']= {2211},
    
    
    ['ASuW'] = {2999,3000,3001,3002,3003,3004,3101,3102,3103,3104,3105,3106,3107,3108,3201,3202,3203,3204,3205,3206,3207,3208,3301,3302,3303,3304,3305,3306,3307,3308,3401,3402,3403,3404,3405,3406,3407,3408},
    ['Ship'] = {2999,3000,3001,3002,3003,3004,3101,3102,3103,3104,3105,3106,3107,3108,3201,3202,3203,3204,3205,3206,3207,3208,3301,3302,3303,3304,3305,3306,3307,3308,3401,3402,3403,3404,3405,3406,3407,3408},
    ['Surface_Combatant']= {3101,3102,3103,3104,3105,3106,3107,3108},
    ['Carrier']= {3001,3002,3003,3004},
    ['Amphibiou']= {3201,3202,3203,3204,3205,3206,3207,3208},
    ['Auxiliary'] = {3301,3302,3303,3304,3305,3306,3307,3308},
    ['Merchant_Civilian'] = {3401,3402,3403,3404,3405,3406,3407,3408},
    
    ['LandW'] = {4999,5000,5001,5002,5005,5006,5011,5100,5101,5102,5103,5104,5105,5106,5200,5201,5202,5203,5400,5401,5402,5500,5501,5300},
    ['Land'] = {4999,5000,5001,5002,5005,5006,5011,5100,5101,5102,5103,5104,5105,5106,5200,5201,5202,5203,5400,5401,5402,5500,5501},
    ['Soft_Structure']= {5000,5001,5002,5005,5006,5011},
    ['Hardened_Structure']= {5100,5101,5102,5103,5104,5105,5106},
    ['Runway']= {5200,5201,5202,5203},
    ['Mobile_Soft'] = {5400,5401,5402},
    ['Mobile_Hardened'] = {5500,5501},
    ['Radar'] = {5300},

    ['ASW'] = {3999,4000,5601},
    ['Sub'] = {3999,4000},
    ['Underwater_Structure']= {5601},
    
    ['Satellite'] = {2300},
    ['Air_Base'] = {5801}
  }
  local salvo = data.salvo or 'inherit'
  local range = data.range or 'inherit'
  local shooters = data.shooters or 'inherit'
  local selfdefense = data.selfdefense or 'inherit'
  local targetType = doctrine[data.target]
  if not targetType then
    return 0
  end
  for k,i in ipairs(targetType) do
    ScenEdit_SetDoctrineWRA({guid=unit.guid, target_type=i, weapon_dbid=dbid}, {salvo,shooters,range,selfdefense})
  end

end
function bL3.AuxFunctions.SetDoctrineMission(mission,side_name,dbid,data)
  local doctrine = {
    ['AAW'] = {1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100,2400,2200,2201,2202,2203,2204,2211},
    ['Aircraft'] = {1999,2000,2001,2002,2003,2004,2011,2012,2013,2021,2022,2023,2031,2100},
    ['Fighter']= {2001,2002,2003,2004},
    ['Non-Fighter']= {2011,2012,2013,2021,2022,2023,2033,2031},
    ['Bomber']= {2011,2012,2013},
    ['Recon_EW'] = {2021,2022,2023},
    ['Helicopter']= {2100},
    ['Tanker']= {2033},
    ['AEW'] = {2031},
    ['C_RAM'] = {2400},
    ['Missile'] = {2200,2201,2202,2203,2204,2211},
    ['Guided_Weapon']= {2201,2202,2203,2204},
    ['Ballistic_Missile']= {2211},
    
    
    ['ASuW'] = {2999,3000,3001,3002,3003,3004,3101,3102,3103,3104,3105,3106,3107,3108,3201,3202,3203,3204,3205,3206,3207,3208,3301,3302,3303,3304,3305,3306,3307,3308,3401,3402,3403,3404,3405,3406,3407,3408},
    ['Ship'] = {2999,3000,3001,3002,3003,3004,3101,3102,3103,3104,3105,3106,3107,3108,3201,3202,3203,3204,3205,3206,3207,3208,3301,3302,3303,3304,3305,3306,3307,3308,3401,3402,3403,3404,3405,3406,3407,3408},
    ['Surface_Combatant']= {3101,3102,3103,3104,3105,3106,3107,3108},
    ['Carrier']= {3001,3002,3003,3004},
    ['Amphibiou']= {3201,3202,3203,3204,3205,3206,3207,3208},
    ['Auxiliary'] = {3301,3302,3303,3304,3305,3306,3307,3308},
    ['Merchant_Civilian'] = {3401,3402,3403,3404,3405,3406,3407,3408},
    
    ['LandW'] = {4999,5000,5001,5002,5005,5006,5011,5100,5101,5102,5103,5104,5105,5106,5200,5201,5202,5203,5400,5401,5402,5500,5501,5300},
    ['Land'] = {4999,5000,5001,5002,5005,5006,5011,5100,5101,5102,5103,5104,5105,5106,5200,5201,5202,5203,5400,5401,5402,5500,5501},
    ['Soft_Structure']= {5000,5001,5002,5005,5006,5011},
    ['Hardened_Structure']= {5100,5101,5102,5103,5104,5105,5106},
    ['Runway']= {5200,5201,5202,5203},
    ['Mobile_Soft'] = {5400,5401,5402},
    ['Mobile_Hardened'] = {5500,5501},
    ['Radar'] = {5300},

    ['ASW'] = {3999,4000,5601},
    ['Sub'] = {3999,4000},
    ['Underwater_Structure']= {5601},
    
    ['Satellite'] = {2300},
    ['Air_Base'] = {5801}
  }
  local salvo = data.salvo or 'inherit'
  local range = data.range or 'inherit'
  local shooters = data.shooters or 'inherit'
  local selfdefense = data.selfdefense or 'inherit'
  local targetType = doctrine[data.target]
  if not targetType then
    return 0
  end
  for k,i in ipairs(targetType) do
    ScenEdit_SetDoctrineWRA({SIDE=side_name, MISSION=mission.guid, target_type=i, weapon_dbid=dbid}, {salvo,shooters,range,selfdefense})
  end

end

--Setup-lua


function bL3.Functions.SetupWindow()
  --[[
  let budget = %d;
  const itemsData = %s;
  const fixedBuilds = %s;
  const capabilitiesData = %s;
  ]]
  local setup_tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scenario Setup</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Staatliches&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://unpkg.com/leaflet.gridlayer.googlemutant@0.8.0/Leaflet.GoogleMutant.js"></script>
    <script src="https://unpkg.com/leaflet.gridlayer.googlemutant@0.8.0/Leaflet.GoogleMutant.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body,
        html {
            font-family: 'Staatliches', sans-serif;
            font-size: 1.1rem;
            height: 100%%;
            margin: 0;
            padding: 0;
            background-color: #0d1b2a;
            color: #ffffff;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        #close-message {
            display: none;
            /* Hidden by default */
            height: 100vh;
            background-color: #0d1b2a;
            color: #e0e6ed;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            z-index: 1000;
            /* Ensure it appears above all other elements */
        }

        h3 {
            padding: 5px;
            padding-left: 10px;
            margin: auto;
        }

        h4 {
            margin: auto;
        }

        .leaflet-container {
            font-family: 'Staatliches', sans-serif;

        }

        .leaflet-right {
            right: 10px;
        }

        .leaflet-top {
            top: 20px;
        }

        .container {
            display: flex;
            background-color: #1b263b;
            padding: 15px;
            border-radius: 8px;
            justify-content: center;
            /* Centra la barra completa de filtros */
            flex-direction: column;
        }


        .section {
            margin-top: 20px;
        }

        .sub-section {
            margin-left: 20px;
            font-style: italic;
        }

        .header {
            text-align: center;
            font-weight: bold;
            border-bottom: 1px solid #ab3a3a;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        /* Estilos para la barra superior */

        .top-bar {
            font-family: 'Staatliches', sans-serif;
            display: flex;
            justify-content: space-between;
            /* Distribuye los elementos a los extremos */
            align-items: center;
            background-color: #0d1b2a;
            /* Fondo oscuro */
            padding: 10px 20px;
            color: #e0e6ed;
            border-bottom: 1px solid #1c2b3a;
            position: sticky;
            top: 0;
            z-index: 1000;
            /* Asegura que esté por encima del contenido */
        }

        .budget-display {
            font-family: 'Staatliches', sans-serif;
            font-weight: bold;

            font-size: 1.1em;
            color: #f4a261;
            /* Color destacado para el presupuesto */
            padding-left: 5vh;
        }

        .budget-display span {
            letter-spacing: .1rem;
        }

        .nav {
            flex-grow: 1;
            display: flex;
            justify-content: center;
        }

        .nav-tabs {
            display: flex;
            flex-direction: row;
            justify-content: center;
            font-size: 1.2rem;
            letter-spacing: 2px;
            border-radius: 1px;

        }

        .nav-item {
            border: #415a77;
            border-radius: 5px;
            color: whitesmoke;
        }

        .info-icon {
            width: 20px;
            height: 20px;
            cursor: pointer;
            margin-left: 8px;
            margin-bottom: 5px;
        }

        .store-item .card {

            background-color: #1b263b;
            border: none;
        }

        .card-body {
            font-size: 1.1rem;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 100%%;
            color: #ffffff;
        }



        .info-icon:hover {
            color: #0056b3;
        }

        h5 {
            font-size: 1.3rem;
        }

        .btn-primary,
        .btn-secondary,
        .btn-danger {
            background-color: #415a77;
            border-color: #415a77;
        }

        .btn-group .filter-button.active {
            background-color: #444c56;
            /* Active color */
            color: white;
        }

        .btn-primary:hover,
        .btn-secondary:hover,
        .btn-danger:hover {
            background-color: #778da9;
            border-color: #778da9;
        }
        .add{
            background-color: #00aae4;
            
        }
        .del{
            background-color: #FF8488;
        }
        #map {  
            max-height: 100vh;
            padding: 5px;
        }
        #map-tab{
            height: 100%%;
            overflow: hidden;
        }
        .container-map {
            height: 91%%;
            overflow: hidden;
        }

        .list-group {
            padding-left: 5px;
        }

        .list-group-item {
            background-color: #1b263b;
            color: #ffffff;
            border: 1px solid #415a77;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card {
            background-color: #00032F;
        }

        .budget {
            color: #ffffff;
            font-weight: bold;
        }

        .shop-filter {
            justify-content: center;
            margin: auto;
        }

        .shop-filter .btn {
            font-size: 1.3rem;
        }

        .filter-buttons .btn {
            margin-right: 5px;
            font-size: 1.4rem;
        }

        #map {
            height: 100%%;
        }
        #map-filters{
            align-items: center;
            margin: auto;
            justify-content: center;
            
        }
        .tab-content {
            height: calc(100vh - 56px);
            /* Adjust tab height */
        }

        .deployed {
            filter: grayscale(100%%);
            /* Grays out the item */
            pointer-events: none;
            /* Disables interaction for the item except the button */
        }

        .land-deploy {
            overflow-y: auto;
        }

        .deployed .remove-btn {
            opacity: 1 !important;
            /* Ensures full visibility */
            pointer-events: auto !important;
            /* Enables interaction */
            cursor: pointer;
            /* Shows a clickable cursor */
            color: white;
            /* Ensures color stands out */
        }

        .range-toggle-control {
            background-color: rgba(34, 34, 34, 0.8);
            /* Dark background with some transparency */
            color: white;
            padding: 10px;
            border-radius: 5px;
            font-family: Arial, sans-serif;
            font-size: 14px;
        }

        .range-toggle-control label {
            margin-left: 5px;
        }

        Exp .store {
            padding: 15px;
        }
        .card-title{
          cursor: pointer;
        }
        .purchased-item{
            border: #abd5a3;
            border-style: solid;
            border-width: 1px;
        }
        .menu {
            height: 100%%;
            padding: 15px;
            background-color: #00032F;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
        }

        .menu-item {
            cursor: grab;
        }

        /* Air deployment */
        .air-deployment-container {
            display: flex;
            flex-wrap: wrap;
            padding: 15px;
            background-color: #00032F;
            height: 95vh;
        }

        .air-deploy-map-container {
            flex: 2;
            min-width: 300px;
            margin-right: 15px;
            margin-top: 15px;
        }

        .airbase-details {
            margin-top: 15px;
            flex: 1;
            min-width: 250px;
            background-color: #1b263b;
            color: white;
            border-radius: 8px;
            padding: 15px;
            height: fit-content;
            max-height: 85vh;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }
         .airbase-details {
            
        }
        #air-deploy-map {
            width: 100%%;
            height: 75vh;
            border: 2px solid #415a77;
            border-radius: 8px;
        }

        #airbase-search {
            padding-top: 5px;
            max-width: 250px;
        }

        #airbase-info {
            background-color: #415a77;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            max-height: 40vh;
            overflow: auto;
        }

       

        .airunits-container {
            flex-grow: 1;
            /* Toma el espacio restante en la columna */
            overflow-y: auto;
            /* Habilita el desplazamiento vertical solo en este contenedor */
        }

        #available-airunits {

            overflow-y: auto;
            /* Habilita el scroll vertical */
        }

        #available-airunits .list-group-item {
            background-color: #1b263b;
            color: white;
            border: 1px solid #415a77;
            margin-bottom: 5px;

        }

        #available-airunits .list-group-item:hover {
            background-color: #778da9;
        }

        /* Custom styles for disabled buttons */
        .btn:disabled {
            opacity: 0.6;
            cursor: not-allowed;
        }

        .marker-icon {
            width: 30px;
            height: 30px;

            background-size: contain;
            background-repeat: no-repeat;
            background-position: center;
        }

        .unit-label {
            white-space: nowrap;
            /* Prevent text wrapping */
            overflow: hidden;
            /* Hide overflow if text is too long */
            text-overflow: ellipsis;
            /* Add ellipsis (...) if text overflows */
            position: absolute;
            top: -20px;
            /* Adjust positioning to sit above the icon */
            left: 50%%;
            transform: translateX(-50%%);

            color: white;
            padding: 2px 5px;
            border-radius: 3px;
            font-size: 12px;
        }
        .flc{
            margin-top: 5px;
            display: flex;
            justify-content: center;
            flex-direction: row;
        }
        
        /* Dark style for the modal */
        .modal-content {
            font-family: 'Roboto', sans-serif;
            background-color: #1b1b1b;
            /* Dark background for the modal */
            color: #ffffff;
            /* White text color */
            border-radius: 8px;
            /* Rounded corners */
        }

        .modal-header,
        .modal-footer {
            border: none;
            /* Remove border lines in header and footer */
            background-color: #1c1c84;
            /* Slightly lighter background for header/footer */
        }

        .modal-header .modal-title {
            color: #ffffff;
            /* White title text */
        }

        .modal-body img {
            border-radius: 5px;
            /* Rounded corners for images */
        }

        .modal-footer .btn-secondary {
            background-color: #555555;
            /* Darker background for close button */
            border: none;
        }

        .modal-footer .btn-secondary:hover {
            background-color: #777777;
            /* Lighter background on hover */
        }

        .btn-close {
            background-color: transparent;
            /* Make the close button background transparent */
            color: #ffffff;
            /* White color for close button icon */
        }

        .btn-close:hover {
            color: #cccccc;
            /* Lighter color on hover */
        }

        .boardcard {
            font-size: 1em;
            border-radius: 13px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.4);
            background: #333;
            color: #eee;
            height: 390px;
        }

        .boardcard-header {
            color: #ccc;
            padding: 10px 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .boardcard-header-number {
            font-size: 24px;
            font-weight: bold;
        }
        .purchase-checkbox{
            height: 20px;
        }

        .header-red {
            background: red;
        }

        .header-blue {
            background: #51d1f6;
            color: #00032F;
        }

        .header-green {
            background: green;
            color: #FFF;
        }

        .header-yellow {
            background: #b7d3b6;
        }

        .boardcard-image {
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            /* To ensure nothing spills out of the container */
            height: 125px;
            /* Fixed height for the image container */
        }

        .boardcard-image img {
            max-width: 100%%;
            object-fit: cover;
            /* This will cover the entire container, potentially cropping the image */
        }

        .boardcard-content {
            max-height: 100px;
            /* Ajusta esta altura según el diseño */
            font-size: 0.92em;
            padding: 10px;
            margin-bottom: 10px;

        }
        .boardcard-title {
            font-size: 18px;
            
        }
        .boardcard-text {
            font-size: 0.92em;
            line-height: 1.5;
            color: #666;
        }
        .boardcard-footer {
            background: #00032F;
            padding: 10px 15px;
            font-size: 0.92em;
            text-align: center;
        }
        .checkbox-container {
            text-align: center;
            padding: 5px;
        }

        .boardcard-content {
            flex: 1;
            margin-bottom: 10px;
        }

        /* Contenedor para el footer y el checkbox */
        .boardcard-footer {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: auto;
            /* Empuja el footer hacia el fondo */
        }

        /* Alinear el checkbox al fondo de la tarjeta */
        .checkbox-container {
            margin-top: 10px;
        }

        #purchase-summary {
            font-family: 'Staatliches', sans-serif;
            color: #eee;

        }

        #purchase-summary h2,
        #purchase-summary h3 {
            color: #f9f5f5;
        }


        * Estilos de la hoja de balance en tema oscuro */ .balance-sheet {
            font-family: 'Staatliches', sans-serif;
            max-width: 800px;
            margin: auto;
            padding: 20px;
            border: 1px solid #1c2b3a;
            /* Borde oscuro */
            background-color: #0d1b2a;
            /* Fondo oscuro */
            color: #e0e6ed;
            /* Texto en color claro */
        }

        .summary-section {
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #1c2b3a;
            /* Línea divisoria */
        }

        .summary-section:last-child {
            border-bottom: none;
        }

        .summary-group-title {
            font-weight: bold;
            color: #aab6c1;
            /* Color intermedio para el texto */
            margin-top: 10px;
            margin-bottom: 5px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px dotted #33415c;
            /* Línea divisoria en puntos */
        }

        .summary-item:last-child {
            border-bottom: none;
        }

        .section-total,
        .overall-total {
            display: flex;
            justify-content: space-between;
            padding-top: 10px;
            font-weight: bold;
        }

        hr {
            border-top: 1px solid #51d1f6;
        }

        .lowercase-x {
            text-transform: lowercase;
            font-size: 0.9em;
            /* Opcional: ajustar el tamaño si quieres que sea más pequeña */
        }

        .section-total {
            color: #aab6c1;
            /* Color para subtotales */
            border-top: 1px solid #ccc;
            /* Línea superior de color anaranjado */
        }

        .overall-total {
            color: #ffffff;
            /* Texto blanco para el total */
            font-size: 1.2em;
            border-top: 2px solid #f4a261;
            /* Línea superior de color anaranjado */
            padding-top: 15px;
        }

        .deploy-div {
            display: flex;
            justify-content: center;
        }

        .deploy-button {
            margin: auto;
            margin-top: 25px;
            padding: 10px;
            padding-left: 20px;
            padding-right: 20px;
            color: gold;
            background-color: #00032F;
            font-size: 1.2rem;
        }

        .marker-icon.fighter {
            background-image: url('https://i.imgur.com/fYuLtgR.png');
        }

        .marker-icon.support {
            background-image: url('https://i.imgur.com/B6rOmml.png');
        }

        .marker-icon.dd {
            background-image: url('https://i.imgur.com/OQBhw14.png');
        }

        .marker-icon.ff {
            background-image: url('https://i.imgur.com/o9tpmh1.png');
        }

        .marker-icon.mlrs {
            background-image: url('https://i.imgur.com/XpVXXPM.png');
        }

        .marker-icon.himars {
            background-image: url('https://i.imgur.com/H3nIpI7.png');
        }

        .marker-icon.sam {
            background-image: url('https://i.imgur.com/Ct6TMD0.png');
        }

        .marker-icon.ssm {
            background-image: url('https://upload.wikimedia.org/wikipedia/commons/7/7e/Military_Symbol_-_Friendly_Unit_%%28Solid_Light_1.5x1_Frame%%29-_Missile_-_Surface_to_Surface_%%28NATO_APP-6%%29.svg');
        }
        .marker-icon.ssna {
            background-image: url('https://i.imgur.com/2CDlC0m.png');
        }
        .marker-icon.radar {
            background-image: url('https://i.imgur.com/owb39dh.png');
        }

        .marker-icon.energy {
            background-image: url('https://i.imgur.com/ZFHGZ2i.png');
        }

        .marker-icon.COMM {
            background-image: url('https://i.imgur.com/AYtdrVD.png');
        }

        .marker-icon.gov {
            background-image: url('https://i.imgur.com/80ldEtH.png');
        }

        .marker-icon.HQ {
            background-image: url('https://i.imgur.com/Ncglqme.png');
        }

        .marker-icon.AB {
            background-image: url('https://i.imgur.com/betQKvH.png');
        }
        .marker-icon.out-of-bounds {
            border: 2px solid red; /* Add a red border to indicate out of bounds */
            box-shadow: 0 0 10px red; /* Optional: Add a glow effect */
        }
    </style>
</head>

<body>
    <div class="top-bar">
        <div class="budget-display">Budget: $<span id="budget-units">budget</span>M</div>
        <div class="nav">
            <nav class="nav nav-tabs">

                <a class="nav-item nav-link active" data-toggle="tab" href="#description-tab">Start</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#store-tab">1. Units</a>
                <a class="nav-item nav-link" id='capabilities-deploy-tab-link' data-toggle="tab" href="#capabilities-tab">2. Capabilities</a>
                <a class="nav-item nav-link" data-toggle="tab" href="#map-tab">3. Sea/Land Deploy</a>
                <a class="nav-item nav-link" id='air-deploy-tab-link' data-toggle="tab" href="#air-deploy-tab">4. Air Deploy</a>
                <a class="nav-item nav-link" id='summary-deploy-tab-link' data-toggle="tab" href="#summary-tab">5.Summmary</a>

            </nav>
        </div>
    </div>


    <div class="tab-content">
        <div id="description-tab" class="tab-pane fade show active">
            <div class="container large-text">
                <div class="instructions">

                    <p style="font-size: 1.4rem;">Welcome to the Tactical Deployment Interface! This guide provides a
                        quick overview of how to purchase, deploy, and manage units and capabilities in the scenario. </p>

                    <hr>

                    <h3>1. <strong>Units Tab</strong></h3>
                    <p>In the Units tab, review and purchase available units within your budget. Each unit card displays
                        relevant details; simply click Add to purchase, and your budget will automatically adjust.</p>
                    <i>Note: All unit cost are per unit except air fighters that are per 12 units.</i>

                    <h3>2. <strong>Capabilities Tab</strong></h3>
                    <p>The Capabilities tab contains unique abilities you can purchase. Click the checkbox on a
                        capability card to acquire it; the cost will be deducted from your budget, and you can deselect
                        to refund the cost if needed.</p>
                    
                    <h3>3. <strong>Sea/Land Deploy Tab</strong></h3>
                    <p>The Sea/Land Deploy tab allows you to position your purchased land and sea units. Drag and drop
                        units from the To Deploy list onto the map, where they will remain deployed and marked as used. Note that you need to deploy your units in the allowed area (you can toggle ON/OFF in the map legend).
                    </p>



                    <h3>4. <strong>Air Deploy Tab</strong></h3>
                    <p>In the Air Deploy tab, select an airbase on the map to view its details, then assign available
                        air units to the selected airbase by clicking the Assign button next to each unit in the list.
                    </p>



                    



                    <h3>5. <strong>Summary Tab</strong></h3>
                    <p>Use the Summary tab to view a detailed report of all purchased units and capabilities, grouped by
                        category with total costs to review your resources at a glance.</p>
                    <h2>Once you're done, click on DEPLOY in the Summary Tab!</h2>
                    <p>Enjoy setting up and deploying your forces, and good luck in your operations!</p>
                </div>


            </div>
        </div>
        <div id="store-tab" class="tab-pane fade">
            <div class="container store">

                
                <div class="btn-group mb-4 shop-filter" role="group" aria-label="Filtros">
                    
                </div>

                <div id="store-items" class="row"></div>
            </div>
        </div>

        <div id="map-tab" class="tab-pane fade">
            <div class="flc">
                <div class="btn-group mb-4" id="map-filters" role="group" aria-label="FiltrosMap"></div>
            </div>
                <div class="container-map">
                    <div class="row h-100">
                        <div class="col-md-3 menu land-deploy">
                            <h3>To Deploy:</h3>
                            <div id="menu-items" class="list-group"></div>
                        </div>
                        <div class="col-md-9 p-0">
                            <div id="map"></div>
                        </div>
                    </div>
                </div>
            
        </div>
        <div id="air-deploy-tab" class="tab-pane fade">
            <div class="air-deployment-container">
                <div class="air-deploy-map-container">
                    <input type="text" id="airbase-search" class="form-control mb-3" placeholder="Search Air Bases...">
                    <div id="air-deploy-map" style="height: 80vh;"></div>
                </div>
                <div class="airbase-details">
                    <h4 style="margin: auto">Air Base Details</h3>
                        <div id="airbase-info" class="mb-3 airbase-info">
                            <p>Select an Air Base on the map to assing the aircrafts.</p>
                        </div>

                        <h4 style="margin: auto">Available Air Units</h4>

                        <div class="airunits-container">
                            <ul id="available-airunits" class="list-group airbase">
                                <!-- Dynamically populated -->
                            </ul>
                        </div>
                </div>
            </div>
        </div>
        <div id="capabilities-tab" class="tab-pane fade">
            <div class="container store">
                <div class="btn-group mb-3 shop-filter" role="group" id="capabilities-filter" aria-label="Filter">
                </div>
                <div id="capabilities-items" class="row boardcards-container"></div>
            </div>
        </div>
        <div id="summary-tab" class="tab-pane fade">
            <div class="container">
                <div id="purchase-summary">
                    <h2>Deployment Resume</h2>
                    <div id="summary-details"></div>
                </div>
                <div class="deploy-div"><button class="deploy-button" onclick="finishDeploy()">Deploy</button></div>
            </div>
        </div>

    </div>

    <div class="modal fade" id="infoModal" tabindex="-1" aria-labelledby="infoModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="infoModalLabel"></h5>

                </div>
                <div class="modal-body">
                    <img id="infoModalImage" src="" style="width: 100%%; height: auto;">
                    <p id="infoModalDescription" class="mt-3"></p>
                </div>
                <!-- <div class="modal-footer"> -->
                <!-- <button type="button" class="btn btn-secondary" onclick="closeModal()">Close</button> -->
                <!-- </div> -->
            </div>
        </div>
    </div>
    <div id="close-message" style="display: none;"></div>
    <script>
        // Unique ID generator for unit instances
        let uniqueId = 0;
        function displaySetup() {
            //renderSummary(true)
            const summaryDetailsDiv = document.getElementById('close-message');
            // Hide all other content (top bar, tab content, etc.)
            document.querySelector('.top-bar').style.display = 'none';
            document.querySelector('.tab-content').style.display = 'none';
            summaryDetailsDiv.innerHTML = '<h4>You can close this window!</h4>'; // Limpiar contenido anterior
            // Show the close message
            summaryDetailsDiv.style.display = 'flex';
            summaryDetailsDiv.style.flexDirection = 'column';
            summaryDetailsDiv
            return true

        }
        function generateUniqueId() {
            return ++uniqueId;
        }
        document.addEventListener("DOMContentLoaded", function () {
            // Listen for when a tab is shown
            document.querySelector('nav.nav-tabs').addEventListener('click', function (event) {
                const clickedTab = event.target;
                if (!clickedTab.classList.contains("nav-link")) return;
        
                // Get the tab target from the href attribute
                const targetTab = clickedTab.getAttribute("href");
        
                // Check if it's the "Sea/Land Deploy" tab
                if (targetTab === "#map-tab") {
                    createFilterBar(purchasedLandUnits); // Generate filters
                    applyFilterMap('all'); // Reset filter to show all units
                }else if (targetTab === "#map-tab"){
                    populateFilters(itemsData)
                }
                
            });
        });
        // Define your unit data
        let isSetup = false;
        let budget = %d;
        const complexity = %d;
        const itemsData = %s;
        const fixedBuilds = %s;
        const capabilitiesData = %s;
        // Track purchased unit instances
        const purchasedLandUnits = {}; // key: instanceId, value: { ...unitData, placed: false, marker: null }
        const purchasedAirUnits = {};  // key: instanceId, value: { ...unitData, placed: false, marker: null }
        const purchasedCapabilities = new Map();;
        // Counters for purchased units
        const purchasedLandUnitsCount = {};
        const purchasedAirUnitsCount = {};
        function updateBudget() {
            document.getElementById('budget-units').innerText = budget;

        }
        if (complexity == 3){
            updateMaxLimit(itemsData, 1);
            updateValueByPercentage(capabilitiesData, 25)
        }else if (complexity == 1){
            updateValueByPercentage(capabilitiesData, -10)
        }
        const storeItemsDiv = document.getElementById('store-items');

        //Populate Filters with the data
        function getUniqueTypes(data) {
            const types = new Set(); // Use a Set to store unique types
            for (const category in data) {
                data[category].forEach(item => {
                    types.add(item.type);
                });
            }
            return Array.from(types).sort(); // Convert Set to Array and sort alphabetically
        }
        function populateFilters(data) {
            const filterContainer = document.querySelector('.btn-group[aria-label="Filtros"]');
            filterContainer.innerHTML = ''; // Clear any existing buttons

            // Add "All" filter button
            const allButton = document.createElement('button');
            allButton.type = 'button';
            allButton.className = 'btn btn-primary filter-button';
            allButton.dataset.filter = 'all';
            allButton.innerText = 'All';
            allButton.addEventListener('click', (event) => setActiveFilter(event, 'all'));
            filterContainer.appendChild(allButton);

            // Generate buttons for each unique type
            const uniqueTypes = getUniqueTypes(data);
            uniqueTypes.forEach(type => {
                const button = document.createElement('button');
                button.type = 'button';
                button.className = 'btn btn-secondary filter-button';
                button.dataset.filter = type;
                button.innerText = type; // Use type name for button text

                // Add click event to filter items by this type
                button.addEventListener('click', (event) => setActiveFilter(event, type));
                filterContainer.appendChild(button);
            });
        }
        // Helper function to set active filter
        function setActiveFilter(event, filterType) {
            // Remove 'active' class from all buttons
            document.querySelectorAll('.filter-button').forEach(button => {
                button.classList.remove('active');
            });

            // Add 'active' class to the clicked button
            event.target.classList.add('active');

            // Call renderItems to filter the displayed items
            renderItems(filterType);
        }
        // Modify renderItems function
        function renderItems(filter = 'all') {
            storeItemsDiv.innerHTML = '';
            for (const category in itemsData) {
                if (filter !== 'all' && category !== filter) continue;

                itemsData[category].forEach(item => {
                    const itemDiv = document.createElement('div');
                    itemDiv.className = 'col-md-4 mb-4';

                    const card = document.createElement('div');
                    card.className = 'card';

                    const cardBody = document.createElement('div');
                    cardBody.className = 'card-body';

                    // Flex container for title and symbol
                    const titleContainer = document.createElement('div');
                    titleContainer.className = 'd-flex justify-content-between align-items-center';

                    // Left container for title and info icon
                    const titleAndIconContainer = document.createElement('div');
                    titleAndIconContainer.className = 'd-flex align-items-center';

                    // Unit title
                    const itemName = document.createElement('h5');
                    itemName.className = 'card-title';
                    itemName.innerText = category === 'AIR FIGHTERS' ? `12x ${item.unit_name} - $${item.value}` : `${item.unit_name} - $${item.value}`;
                    itemName.setAttribute('title', item.description); // Tooltip
                    const unitType = item.unit_type;
                    const unitDBID = item.unit_dbid;
                    
                    itemName.addEventListener('click', () => {
                        window.chrome.webview.postMessage(`DIALOG_OKUI_OpenNewDatabaseWindow("${unitType}",${unitDBID})`);
                    });

                    // Info icon
                    const infoIcon = document.createElement('img');
                    infoIcon.src = 'https://i.imgur.com/efPl2qm.png';
                    infoIcon.className = 'info-icon';
                    infoIcon.alt = 'Info Icon';
                    infoIcon.style.width = '20px';
                    infoIcon.style.height = '20px';
                    infoIcon.style.marginBottom = '13px';

                    // Event to open the modal with additional information
                    infoIcon.addEventListener('click', (event) => {
                        event.stopPropagation(); // Prevent card click events
                        openInfoModal(item);
                    });

                    // Append title and info icon to titleAndIconContainer
                    titleAndIconContainer.appendChild(itemName);
                    titleAndIconContainer.appendChild(infoIcon);

                    // Unit symbol container on the right, applying CSS class for the icon
                    const unitSymbol = document.createElement('div');
                    unitSymbol.className = `marker-icon ${item.icon}`; // Use `item.icon` as the CSS class for the background image
                    unitSymbol.style.width = '40px';
                    unitSymbol.style.height = '40px';
                    unitSymbol.style.backgroundSize = 'contain';
                    unitSymbol.style.backgroundRepeat = 'no-repeat';

                    // Append left and right containers to titleContainer
                    titleContainer.appendChild(titleAndIconContainer);
                    titleContainer.appendChild(unitSymbol);

                    // Quantity purchased display
                    const quantityText = document.createElement('p');
                    quantityText.className = 'card-text';
                    const isAirUnit = item.type === "AIR FIGHTERS" || item.type === "AIR SUPPORT";
                    const quantityPurchased = isAirUnit ? purchasedAirUnitsCount[item.unit_dbid] || 0 : purchasedLandUnitsCount[item.unit_dbid] || 0;
                    quantityText.innerText = `Qty: ${quantityPurchased}`;
                    
                    const isPurchased = isAirUnit ? (purchasedAirUnitsCount[item.unit_dbid] || 0) > 0 : (purchasedLandUnitsCount[item.unit_dbid] || 0) > 0;
                    
                    if (isPurchased) {
                        card.classList.add('purchased-item');
                    } else{
                        card.classList.remove('purchased-item');
                    }
                    // Button container
                    const buttonContainer = document.createElement('div');
                    buttonContainer.className = 'd-flex justify-content-between';

                    // Add button
                    const addButton = document.createElement('button');
                    addButton.className = 'btn btn-primary add';
                    addButton.innerText = "Add";
                    const unitTypeCount = isAirUnit ? purchasedAirUnitsCount[item.unit_dbid] : purchasedLandUnitsCount[item.unit_dbid];
                    const currentCount = unitTypeCount || 0;
                    if (item.maxLimit !== undefined && currentCount == item.maxLimit) {
                        addButton.classList.remove('btn-primary');
                        addButton.classList.add('btn-secondary'); // Change to gray
                        addButton.disabled = true;
                    }
                    addButton.addEventListener('click', () => {
                        const unitTypeCount = isAirUnit ? purchasedAirUnitsCount[item.unit_dbid] : purchasedLandUnitsCount[item.unit_dbid];
                        const currentCount = unitTypeCount || 0;
                        if (budget >= item.value) {
                            if (item.maxLimit !== undefined && currentCount >= item.maxLimit) {
                                alert("You have reached the maximum limit for this unit.");
                                return;
                            }
                            budget -= item.value;
                            updateBudget();

                            if (isAirUnit) {
                                purchasedAirUnitsCount[item.unit_dbid] = (purchasedAirUnitsCount[item.unit_dbid] || 0) + 1;
                                quantityText.innerText = `Qty: ${purchasedAirUnitsCount[item.unit_dbid]}`;
                                const instanceId = generateUniqueId();
                                purchasedAirUnits[instanceId] = { ...item, instanceId, assigned: false, marker: null };
                                addToAirDeployMenu(purchasedAirUnits[instanceId]);
                            } else {
                                purchasedLandUnitsCount[item.unit_dbid] = (purchasedLandUnitsCount[item.unit_dbid] || 0) + 1;
                                quantityText.innerText = `Qty: ${purchasedLandUnitsCount[item.unit_dbid]}`;
                                const instanceId = generateUniqueId();
                                purchasedLandUnits[instanceId] = { ...item, instanceId, placed: false, marker: null };
                                addToLandDeployMenu(purchasedLandUnits[instanceId]);
                            }
                            if (item.maxLimit !== undefined && currentCount + 1 >= item.maxLimit) {
                                addButton.classList.remove('btn-primary');
                                addButton.classList.add('btn-secondary'); // Change to gray
                                addButton.disabled = true;
                            }
                        } else {
                            alert("You surpass your budget");
                        }
                        const isPurchased = isAirUnit 
                        ? (purchasedAirUnitsCount[item.unit_dbid] || 0) > 0 
                        : (purchasedLandUnitsCount[item.unit_dbid] || 0) > 0;
                        if (isPurchased) {
                            card.classList.add('purchased-item');
                        } else{
                            card.classList.remove('purchased-item');
                        }
                    });

                    // Delete button
                    const deleteButton = document.createElement('button');
                    deleteButton.className = 'btn btn-danger del';
                    deleteButton.innerText = "Remove";
                    deleteButton.addEventListener('click', () => {
                        const unitTypeCount = isAirUnit ? purchasedAirUnitsCount[item.unit_dbid] : purchasedLandUnitsCount[item.unit_dbid];
                        const currentCount = unitTypeCount || 0;
                        if (isAirUnit) {
                            if (purchasedAirUnitsCount[item.unit_dbid] > 0) {
                                purchasedAirUnitsCount[item.unit_dbid]--;
                                budget += item.value;
                                updateBudget();
                                quantityText.innerText = `Qty: ${purchasedAirUnitsCount[item.unit_dbid]}`;
                                const instanceIds = Object.keys(purchasedAirUnits).filter(id => purchasedAirUnits[id].unit_dbid === item.unit_dbid);
                                const lastInstanceId = instanceIds[instanceIds.length - 1];
                                if (lastInstanceId) {
                                    const unitInstance = purchasedAirUnits[lastInstanceId];
                                    if (unitInstance.airbase) removeUnitFromAirbase(lastInstanceId, unitInstance.airbase);
                                    removeFromAirDeployMenu(lastInstanceId);
                                    selectedAirbase ? displayAirbaseDetails(selectedAirbase) : renderAvailableAirUnits();
                                    delete purchasedAirUnits[lastInstanceId];
                                }
                            }
                        } else {
                            if (purchasedLandUnitsCount[item.unit_dbid] > 0) {
                                purchasedLandUnitsCount[item.unit_dbid]--;
                                budget += item.value;
                                updateBudget();
                                quantityText.innerText = `Qty: ${purchasedLandUnitsCount[item.unit_dbid]}`;
                                const instanceIds = Object.keys(purchasedLandUnits).filter(id => purchasedLandUnits[id].unit_dbid === item.unit_dbid);
                                const lastInstanceId = instanceIds[instanceIds.length - 1];
                                if (lastInstanceId) {
                                    if (purchasedLandUnits[lastInstanceId].placed && purchasedLandUnits[lastInstanceId].marker) {
                                        map.removeLayer(purchasedLandUnits[lastInstanceId].marker);
                                    }
                                    removeFromLandDeployMenu(lastInstanceId);
                                    delete purchasedLandUnits[lastInstanceId];
                                }
                            }
                        }
                        if (item.maxLimit !== undefined && currentCount - 1 < item.maxLimit) {
                            addButton.classList.remove('btn-secondary'); // Remove gray
                            addButton.classList.add('btn-primary'); // Restore primary color
                            addButton.disabled = false;
                        }
                        const isPurchased = isAirUnit 
                        ? (purchasedAirUnitsCount[item.unit_dbid] || 0) > 0 
                        : (purchasedLandUnitsCount[item.unit_dbid] || 0) > 0;
                        if (isPurchased) {
                            card.classList.add('purchased-item');
                        } else{
                            card.classList.remove('purchased-item');
                        }
                    });

                    // Append elements to card body
                    buttonContainer.appendChild(addButton);
                    buttonContainer.appendChild(deleteButton);
                    cardBody.appendChild(titleContainer); // Append titleContainer with title and symbol
                    cardBody.appendChild(quantityText);
                    cardBody.appendChild(buttonContainer);

                    // Assemble card
                    card.appendChild(cardBody);
                    itemDiv.appendChild(card);
                    storeItemsDiv.appendChild(itemDiv);
                });
            }
        }

        const tooltipTriggerList = [].slice.call(document.querySelectorAll('.card-title'));
        tooltipTriggerList.forEach(tooltipTriggerEl => {
            new bootstrap.Tooltip(tooltipTriggerEl);
        });
        const filterButtons = document.querySelectorAll('.filter-button');
        filterButtons.forEach(button => {
            button.addEventListener('click', () => {
                const filter = button.dataset.filter;
                renderItems(filter);
            });
        });

        function openInfoModal(item) {
            const info = item.info
            // Populate the modal with the additional information
            document.getElementById('infoModalImage').src = info.img;
            document.getElementById('infoModalDescription').innerHTML = info.information; // Set the description text
            document.getElementById('infoModalLabel').innerText = item.description
            // Show the modal
            const infoModal = new bootstrap.Modal(document.getElementById('infoModal'));
            infoModal.show();
        }
        function openCardModal(title, info) {

            // Populate the modal with the additional information
            document.getElementById('infoModalImage').src = '';
            document.getElementById('infoModalDescription').innerHTML = info; // Set the description text
            document.getElementById('infoModalLabel').innerText = title
            // Show the modal
            const infoModal = new bootstrap.Modal(document.getElementById('infoModal'));
            infoModal.show();
        }
        function closeModal() {
            const modalElement = document.getElementById('infoModal');
            const infoModal = new bootstrap.Modal(modalElement); // Create a new instance
            infoModal.hide(); // Hide the modal
        }
        // Add unit to Land Deploy menu
        function addToLandDeployMenu(unitInstance) {
            const menuItemsDiv = document.getElementById('menu-items');

            const menuItemDiv = document.createElement('div');
            menuItemDiv.className = 'list-group-item menu-item';
            menuItemDiv.innerText = `${unitInstance.unit_name} #${unitInstance.instanceId}`;
            menuItemDiv.dataset.instanceId = unitInstance.instanceId;

            if (unitInstance.placed) {
                menuItemDiv.classList.add('deployed'); // Apply grayed-out style
                menuItemDiv.draggable = false;         // Disable dragging
            } else {
                menuItemDiv.draggable = true;
                menuItemDiv.addEventListener('dragstart', (event) => {
                    event.dataTransfer.setData('text/plain', unitInstance.instanceId);
                });
            }
            const removeButton = document.createElement('button');
            removeButton.className = 'btn btn-sm btn-danger ml-2 remove-btn';
            removeButton.innerText = 'Remove';
            removeButton.addEventListener('click', () => {
                // If unit has a marker on the map, remove it
                if (unitInstance.marker) {
                    map.removeLayer(unitInstance.marker);
                }
                if (unitInstance.rangeCircle) {
                    map.removeLayer(unitInstance.rangeCircle); // Remove circle from map
                    unitInstance.rangeCircle = null; // Clear reference
                }
                // Update budget when unit is removed
                budget += unitInstance.value;
                updateBudget();
                // Remove from purchasedLandUnits

                delete purchasedLandUnits[unitInstance.instanceId];
                purchasedLandUnitsCount[unitInstance.unit_dbid]--;
                // Remove from Land Deploy menu
                menuItemDiv.remove();
            });

            menuItemDiv.appendChild(removeButton);
            menuItemsDiv.appendChild(menuItemDiv);
        }

        // Add unit to Air Deploy menu
        function addToAirDeployMenu(unitInstance) {
            const airunitList = document.getElementById("available-airunits");

            const airunitItem = document.createElement("li");
            airunitItem.className = `airunit-item ${unitInstance.icon.toLowerCase()}`;
            airunitItem.dataset.instanceId = unitInstance.instanceId;
            airunitItem.innerText = `${unitInstance.unit_name} #${unitInstance.instanceId}`;
            airunitItem.setAttribute('draggable', 'true');

            // Add drag start event to allow dragging
            airunitItem.addEventListener("dragstart", (event) => {
                event.dataTransfer.setData("text/plain", unitInstance.instanceId);
            });

            airunitList.appendChild(airunitItem);
        }

        // Remove unit from Land Deploy menu
        function removeFromLandDeployMenu(instanceId) {
            const menuItemsDiv = document.getElementById('menu-items');
            const existingItem = Array.from(menuItemsDiv.children).find(child => child.dataset.instanceId == instanceId);

            if (existingItem) {
                existingItem.remove();
            }
        }

        // Remove unit from Air Deploy menu
        function removeFromAirDeployMenu(instanceId) {
            const airunitList = document.getElementById("available-airunits");
            const existingItem = Array.from(airunitList.children).find(child => child.dataset.instanceId == instanceId);

            if (existingItem) {
                existingItem.remove();
            }
        }
        
        function applyFilterMap(filterType) {
            const menuItems = document.querySelectorAll('.menu-item');
        
            menuItems.forEach(item => {
                const unitInstanceId = item.dataset.instanceId;
                const unit = purchasedLandUnits[unitInstanceId];
        
                if (filterType === 'all' || (unit && unit.type === filterType)) {
                    item.style.display = ''; // Show item
                } else {
                    item.style.display = 'none'; // Hide item
                }
            });
        
            // Update button active state
            document.querySelectorAll('#map-filters .filter-btn').forEach(btn => {
                btn.classList.remove('active');
            });
            const activeButton = document.querySelector(`#map-filters .filter-btn[data-filter="${filterType}"]`);
            if (activeButton) {
                activeButton.classList.add('active');
            }
        }
        function createFilterBar(data) {
            const filterContainer = document.getElementById('map-filters');
            filterContainer.innerHTML = ''; // Clear existing filters
            
            const uniqueTypes = getUniqueTypes(itemsData);
        
            // Create "Show All" button
            const allButton = document.createElement('button');
            allButton.className = 'btn btn-primary filter-btn active';
            allButton.innerText = 'All';
            allButton.dataset.filter = 'all';
            allButton.addEventListener('click', () => applyFilterMap('all'));
        
            filterContainer.appendChild(allButton);
        
            // Create a button for each unique type
            uniqueTypes
            .filter(type => !type.toUpperCase().includes("AIR")) // Exclude types containing "AIR"
            .forEach(type => {
                const button = document.createElement('button');
                button.className = 'btn btn-secondary filter-btn';
                button.innerText = type;
                button.dataset.filter = type;
                button.addEventListener('click', () => applyFilterMap(type));

                filterContainer.appendChild(button);
            });
        }
        // Initialize Leaflet map

        const map = L.map('map').setView([17.263397866873937, 121.48759617976285], 7);

        // Define the default dark theme layer
        const darkTheme = L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap © CARTO'
        }); // Add dark theme as the default layer

        // Define additional tile layers
        const openTopoMap = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
            maxZoom: 17,
            attribution: '© OpenTopoMap'
        });
        const esriWorldTopo = L.tileLayer('https://{s}.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
            attribution: 'Tiles © Esri',
            subdomains: ['server', 'services']
        });  
        // Define Google Satellite layer using Google Mutant plugin
        // Define Esri Satellite layer
        const esriSatellite = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
            maxZoom: 21,
            attribution: 'Tiles © Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
        }).addTo(map);

        // Create a layer control and add it to the map
        const baseMaps = {
            "Dark Theme": darkTheme,
            "OpenTopoMap": openTopoMap,
            "EsriTopo": esriWorldTopo,
            "Satellite": esriSatellite
        };

        L.control.layers(baseMaps).addTo(map);

        // Optional: Invalidate size if the map is in a tab
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            if (e.target.getAttribute('href') === '#map-tab') { // Adjust for tab name if using tabs
                map.invalidateSize();
            }
        });
        const bounds = [
          [7, 119], // Southwest corner
          [19.8, 125.5]  // Northeast corner
        ];

      // Create a custom pane for the rectangle with a lower z-index
      map.createPane('allowedAreaPane');
      map.getPane('allowedAreaPane').style.zIndex = 400; // Lower than the default z-index of overlays (default is 401)

      // Add a rectangle to represent the allowed area
      const allowedArea = L.rectangle(bounds, {
          color: "#ff7800",
          weight: 0.3,
          fillOpacity: 0.1,
          fillColor: "#ff7800",
          pane: 'allowedAreaPane' // Assign the custom pane
      }).addTo(map);

        // Custom control for checkboxes to toggle ranges
        const rangeToggleControl = L.control({ position: 'bottomright' });
        rangeToggleControl.onAdd = function (map) {
            const div = L.DomUtil.create('div', 'range-toggle-control');

            // Radar Range Checkbox
            const radarCheckbox = document.createElement('input');
            radarCheckbox.type = 'checkbox';
            radarCheckbox.id = 'toggleRadarRanges';
            radarCheckbox.checked = true;
            radarCheckbox.addEventListener('change', toggleRadarRanges);

            const radarLabel = document.createElement('label');
            radarLabel.htmlFor = 'toggleRadarRanges';
            radarLabel.textContent = 'Radar Ranges';

            // Weapon Range Checkbox
            const weaponCheckbox = document.createElement('input');
            weaponCheckbox.type = 'checkbox';
            weaponCheckbox.id = 'toggleWeaponRanges';
            weaponCheckbox.checked = true;
            weaponCheckbox.addEventListener('change', toggleWeaponRanges);

            const weaponLabel = document.createElement('label');
            weaponLabel.htmlFor = 'toggleWeaponRanges';
            weaponLabel.textContent = 'Weapon Ranges';

            // Allowed Area Checkbox
            const areaCheckbox = document.createElement('input');
            areaCheckbox.type = 'checkbox';
            areaCheckbox.id = 'toggleAllowedArea';
            areaCheckbox.checked = false; // Initially visible
            areaCheckbox.addEventListener('change', function () {
                toggleAllowedArea(allowedArea, areaCheckbox.checked);
            });

            const areaLabel = document.createElement('label');
            areaLabel.htmlFor = 'toggleAllowedArea';
            areaLabel.textContent = 'Allowed Area';

            // Append checkboxes and labels to div
            div.appendChild(radarCheckbox);
            div.appendChild(radarLabel);
            div.appendChild(document.createElement('br')); // Line break for spacing
            div.appendChild(weaponCheckbox);
            div.appendChild(weaponLabel);
            div.appendChild(document.createElement('br')); // Line break for spacing
            div.appendChild(areaCheckbox);
            div.appendChild(areaLabel);

            // Prevent map interaction when clicking on the control
            L.DomEvent.disableClickPropagation(div);

            return div;
        };
        map.removeLayer(allowedArea);
        // Add the custom control to the map
        rangeToggleControl.addTo(map);

        // Track range circles for toggling
        const radarRanges = [];
        const weaponRanges = [];
        // Handle drag over the map
        map.getContainer().addEventListener('dragover', (event) => {
            event.preventDefault();
        });
        function createLabeledMarker(lat, lng, unitName, icon, range, isRadar) {
            const bounds = [
                [7, 119], // Southwest corner
                [19.8, 125.5]  // Northeast corner
            ];
            const customIcon = L.divIcon({
                className: `custom-div-icon ${icon}`,
                html: `<div class="unit-label">${unitName}</div><div class="marker-icon ${icon}"></div>`,
                iconSize: [30, 42],
                iconAnchor: [15, 21]
            });

            const marker = L.marker([lat, lng], { icon: customIcon, draggable: true });
            const rangeM = range * 1852;
            // Create a range circle with color based on unit type (green for radar, red for weapons)
            const rangeColor = isRadar ? 'green' : 'red';

            const showRadar = document.getElementById('toggleRadarRanges').checked;
            const showWeapon = document.getElementById('toggleWeaponRanges').checked;
            const showRange = isRadar ? showRadar : showWeapon;
            const circleOpacity = showRange ? 0.1 : 0;
            const circleWeight = showRange ? 1 : 0;

            const rangeCircle = L.circle([lat, lng], {
                radius: rangeM, // Set range in meters
                color: rangeColor,
                fillColor: rangeColor,
                weight: 1,
                fillOpacity: circleOpacity,
                opacity: circleWeight
            }).addTo(map);
            // Track the range circles in separate arrays
            if (isRadar) {
                radarRanges.push(rangeCircle);
            } else {
                weaponRanges.push(rangeCircle);
            }
            const isOutOfBounds = (position) => {
                return (
                    position.lat < bounds[0][0] || position.lat > bounds[1][0] ||
                    position.lng < bounds[0][1] || position.lng > bounds[1][1]
                );
            };
            // Function to update the marker's out-of-bounds status
            const updateMarkerStatus = (position) => {
                const outOfBounds = isOutOfBounds(position);

                // Use the marker's DOM element once it's added to the map
                const markerElement = marker.getElement();
                if (markerElement) {
                    const iconDiv = markerElement.querySelector('.marker-icon');
                    if (iconDiv) {
                        if (outOfBounds) {
                            iconDiv.classList.add('out-of-bounds');
                        } else {
                            iconDiv.classList.remove('out-of-bounds');
                        }
                    }
                }

                const popupContent = outOfBounds
                    ? `<span style="color: red;">⚠️ Danger: Out of bounds!</span>`
                    : `Unit: ${unitName}<br>Lat: ${position.lat.toFixed(5)}<br>Lng: ${position.lng.toFixed(5)}`;
                        
                marker.bindPopup(popupContent);
              
            };

            // Initial bounds check
            marker.on('add', () => {
                updateMarkerStatus({ lat, lng });
            });

            // Event to update circle position and popup content on drag
            marker.on('dragend', () => {
                const position = marker.getLatLng();
                rangeCircle.setLatLng(position); // Move range circle with marker
                // marker.setPopupContent(`Unidad: ${unitName}<br>Lat: ${position.lat.toFixed(5)}<br>Lng: ${position.lng.toFixed(5)}`);
                updateMarkerStatus(position);
            });

            marker.on('click', () => {
                rangeCircle.setStyle({ fillOpacity: 0.3, opacity: 1 });
            });

            marker.on('popupclose', () => {
                const isCheckboxChecked = document.getElementById(isRadar ? 'toggleRadarRanges' : 'toggleWeaponRanges').checked;
                rangeCircle.setStyle({ fillOpacity: isCheckboxChecked ? 0.1 : 0, opacity: isCheckboxChecked ? 1 : 0 });
            });

            return { marker, rangeCircle };
        }

        // Toggle functions for checkboxes
        function toggleRadarRanges() {
            const showRadar = document.getElementById('toggleRadarRanges').checked;
            radarRanges.forEach(circle => {
                circle.setStyle({
                    fillOpacity: showRadar ? 0.1 : 0,
                    opacity: showRadar ? 1 : 0
                });
            });
        }

        function toggleWeaponRanges() {
            const showWeapon = document.getElementById('toggleWeaponRanges').checked;
            weaponRanges.forEach(circle => {
                circle.setStyle({
                    fillOpacity: showWeapon ? 0.1 : 0,
                    opacity: showWeapon ? 1 : 0
                });
            });
        }
        function toggleAllowedArea(layer, visible) {
            if (visible) {
                map.addLayer(layer); // Add the layer back to the map
            } else {
                map.removeLayer(layer); // Remove the layer from the map
            }
        }
        function createFixedMarker(lat, lng, name, iconClass) {
            const customIcon = L.divIcon({
                className: `custom-div-icon`,
                html: `<div class="marker-icon ${iconClass}"></div>`, // Only the icon, no label text above
                iconSize: [30, 42], // Adjust based on icon size
                iconAnchor: [15, 21], // Center the icon on the location
            });

            // Add the marker to the map, make it non-draggable
            const marker = L.marker([lat, lng], { icon: customIcon, draggable: false }).addTo(map);

            // Bind a popup to show the unit's name when clicked
            marker.bindPopup(`<strong>${name}</strong>`);
        }
        // Handle drop on the map
        // Handle drop on the map
        map.getContainer().addEventListener('drop', (event) => {
            event.preventDefault();
            const instanceId = event.dataTransfer.getData('text/plain');
            const unitInstance = purchasedLandUnits[instanceId];

            if (!unitInstance) {
                alert("Unit not available");
                return;
            }

            if (unitInstance.placed) {
                alert("Unit already placed!");
                return;
            }

            const containerRect = map.getContainer().getBoundingClientRect();
            const x = event.clientX - containerRect.left;
            const y = event.clientY - containerRect.top;
            const latLng = map.containerPointToLatLng(L.point(x, y));
            const isRadar = unitInstance.type === 'RADAR'; // Check if unit is radar type
            // Create labeled marker with custom icon based on unit type
            const { marker, rangeCircle } = createLabeledMarker(latLng.lat, latLng.lng, unitInstance.unit_name, unitInstance.icon, unitInstance.range, isRadar);

            // Add marker and range circle to the map
            marker.addTo(map)

            // Update unit status as placed and save marker reference
            unitInstance.placed = true;
            unitInstance.marker = marker;
            unitInstance.rangeCircle = rangeCircle;
            // Find and add the 'deployed' class to the menu item
            const menuItemsDiv = document.getElementById('menu-items');
            const menuItemDiv = Array.from(menuItemsDiv.children).find(child => child.dataset.instanceId === instanceId);
            if (menuItemDiv) {
                menuItemDiv.classList.add('deployed');  // Apply grayed-out style
                menuItemDiv.draggable = false;          // Disable dragging
            }
            // Remove from menu


            


        });

        // Loop through TARGETS and ABs, adding each to the map
        function deployFixedUnits() {
            // Deploy TARGETS
            fixedBuilds.TARGETS.forEach(target => {
                createFixedMarker(target.lat, target.lon, target.name, target.icon);
            });

            // Deploy ABs
            for (const abName in fixedBuilds.ABs) {
                const ab = fixedBuilds.ABs[abName];
                createFixedMarker(ab.lat, ab.lon, ab.name, ab.icon);
            }
        }


        // Initialize Air Deployment Data Structures
        const airbases = Object.keys(fixedBuilds.ABs).map(key => ({
            ...fixedBuilds.ABs[key],
            capacity: fixedBuilds.ABs[key].capacity, // Default capacity, adjust as needed
            occupied: 0,
            assignedUnits: []
        }));

        let selectedAirbase = null;

        // Initialize Leaflet Map for Air Deployment
        const airDeployMap = L.map('air-deploy-map').setView([16.5633, 121.9], 6);
        L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
            maxZoom: 19,
            attribution: '© OpenStreetMap contributors'
        }).addTo(airDeployMap);

        // Optional: Invalidate size if the map is in a tab
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            if (e.target.getAttribute('href') === '#air-deploy-tab') {
                airDeployMap.invalidateSize();
            }
        });

        // Create Markers for Airbases
        const airbaseMarkers = {};
        function placedAirBaseMarkers() {
            airbases.forEach((airbase) => {
                const customIcon = L.divIcon({
                    className: `custom-div-icon`,
                    html: `<div class="unit-label">${airbase.sizeT}</div><div class="marker-icon AB"></div>`,
                    iconSize: [30, 42], // Set this to the actual icon dimensions
                    iconAnchor: [15, 21], // Center the icon on the point (half of width and height)
                });
                // Create the marker with the custom icon
                const marker = L.marker([airbase.lat, airbase.lon], {
                    icon: customIcon, // Set the custom icon here
                    title: airbase.name
                }).addTo(airDeployMap);
                marker.bindPopup(`<b>${airbase.name}</b><br>Capacity: ${airbase.capacity}<br>Occupied: ${airbase.occupied}`);
                marker.on('click', () => {
                    selectedAirbase = airbase;
                    displayAirbaseDetails(airbase);
                });
                airbaseMarkers[airbase.name] = marker;
            });
        }

        // Display Airbase Details and Populate UI
        function displayAirbaseDetails(airbase) {
            const airbaseInfo = document.getElementById("airbase-info");
            const availableAirunits = document.getElementById("available-airunits");

            if (!airbaseInfo || !availableAirunits) {
                console.error("Element with id 'airbase-info' or 'available-airunits' not found.");
                return;
            }

            airbaseInfo.innerHTML = `
            <h4>${airbase.name}</h4>
            <p>Capacity: ${airbase.capacity}</p>
            <p>Occupied: ${airbase.occupied}</p>
            <p>Assigned Units:</p>
            <ul id="assigned-units-list">
                ${airbase.assignedUnits.map(unit => `
                    <li>
                        ${unit.unit_name} #${unit.instanceId}
                        <button class="btn btn-sm btn-danger remove-unit-btn" data-instance-id="${unit.instanceId}">Remove</button>
                    </li>
                `).join('')}
            </ul>
        `;

            // Populate Available Air Units with Assign buttons
            availableAirunits.innerHTML = '';
            Object.keys(purchasedAirUnits).forEach(instanceId => {
                const unit = purchasedAirUnits[instanceId];
                if (!unit.assigned) {
                    const airunitItem = document.createElement("li");
                    airunitItem.className = "list-group-item airunit-item d-flex justify-content-between align-items-center";
                    airunitItem.innerHTML = `
                    ${unit.unit_name} #${unit.instanceId}
                    <button class="btn btn-sm btn-primary assign-unit-btn" data-instance-id="${unit.instanceId}">Assign</button>
                `;
                    availableAirunits.appendChild(airunitItem);
                }
            });

            // Update Marker Popup
            const marker = airbaseMarkers[airbase.name];
            marker.setPopupContent(`<b>${airbase.name}</b><br>Capacity: ${airbase.capacity}<br>Occupied: ${airbase.occupied}<br>Assigned Units: ${airbase.assignedUnits.length}`);
        }

        // Assign Air Unit to Airbase
        function assignUnitToAirbase(instanceId, airbase) {
            const strInstanceId = String(instanceId);
            const unit = purchasedAirUnits[strInstanceId];

            if (!unit) {
                alert("Unit not found");
                return;
            }

            const capacityRequired = unit.type === 'AIR FIGHTERS' ? unit.size * 12 : unit.size;
            if (airbase.occupied + capacityRequired > airbase.capacity) {
                alert("The airbase selected is full");
                return;
            }
            if (airbase.sizeT === 'S' && unit.size === 8){
                alert("Small airbase can't handle large aircrafts");
                return;
            }
            // Asigna la unidad a la base aérea
            airbase.occupied += capacityRequired;
            airbase.assignedUnits.push(unit);
            unit.assigned = true;
            unit.airbase = airbase; 

            // Actualizar popup del marcador
            const marker = airbaseMarkers[airbase.name];
            marker.setPopupContent(`<b>${airbase.name}</b><br>Capacity: ${airbase.capacity}<br>Occupied: ${airbase.occupied}<br>Assigned Units: ${airbase.assignedUnits.length}`);

            // Refrescar detalles de la base aérea
            displayAirbaseDetails(airbase);
        }

        // Remove Air Unit from Airbase
        function removeUnitFromAirbase(instanceId, airbase) {
            const strInstanceId = String(instanceId);

            // Encuentra y remueve la unidad de `assignedUnits` en la base aérea
            const unitIndex = airbase.assignedUnits.findIndex(u => String(u.instanceId) === strInstanceId);
            if (unitIndex === -1) {
                alert("Unit not found in the airbase");
                return;
            }

            const unit = airbase.assignedUnits.splice(unitIndex, 1)[0];
            airbase.occupied -= unit.type === 'AIR FIGHTERS' ? unit.size * 12 : unit.size;;
            unit.assigned = false;
            delete unit.airbase; // Remover la referencia de la base aérea de la unidad



            // Actualizar Popup del marcador
            const marker = airbaseMarkers[airbase.name];
            marker.setPopupContent(`<b>${airbase.name}</b><br>Capacity: ${airbase.capacity}<br>Occupied: ${airbase.occupied}<br>Assigned Units: ${airbase.assignedUnits.length}`);

            // Refresca los detalles de la base aérea

            displayAirbaseDetails(airbase);
        }

        // Event Delegation for Assign and Remove Buttons
        document.addEventListener("click", function (event) {
            const assignBtn = event.target.closest(".assign-unit-btn");
            if (assignBtn) {
                const instanceId = assignBtn.getAttribute("data-instance-id");
                if (selectedAirbase) {
                    assignUnitToAirbase(instanceId, selectedAirbase);
                } else {
                    alert("Please, select an airbase in the map");
                }
                return;
            }

            const removeBtn = event.target.closest(".remove-unit-btn");
            if (removeBtn) {
                const instanceId = removeBtn.getAttribute("data-instance-id");
                if (selectedAirbase) {
                    removeUnitFromAirbase(instanceId, selectedAirbase);
                }
                return;
            }
        });

        // Search Functionality for Airbases
        const airbaseSearch = document.getElementById("airbase-search");
        if (airbaseSearch) {
            airbaseSearch.addEventListener("input", function () {
                const searchTerm = this.value.toLowerCase();
                airbases.forEach(airbase => {
                    if (airbase.name.toLowerCase().includes(searchTerm)) {
                        airDeployMap.setView([airbase.lat, airbase.lon], 10);
                        airbaseMarkers[airbase.name].openPopup();
                    }
                });
            });
        }

        // Invalidate map size when Air Deploy tab is shown
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            const target = e.target.getAttribute('href');
            if (target === '#air-deploy-tab') { // Adjust for your Air Deploy tab's href
                airDeployMap.invalidateSize();
            }
        });

        // Render Available Air Units Initially
        function renderAvailableAirUnits() {
            const availableAirunits = document.getElementById("available-airunits");
            if (!availableAirunits) {
                console.error("Element with id 'available-airunits' not found.");
                return;
            }

            availableAirunits.innerHTML = '';
            Object.keys(purchasedAirUnits).forEach(instanceId => {
                const unit = purchasedAirUnits[instanceId];
                if (!unit.assigned) {
                    const airunitItem = document.createElement("li");
                    airunitItem.className = "list-group-item airunit-item d-flex justify-content-between align-items-center";
                    airunitItem.innerHTML = `
                ${unit.unit_name} #${unit.instanceId}
                <button class="btn btn-sm btn-primary assign-unit-btn" data-instance-id="${unit.instanceId}">Assign</button>
            `;
                    availableAirunits.appendChild(airunitItem);
                }
            });
        }

        // Create filter buttons
        function createFilters() {
            const filterContainer = document.getElementById('capabilities-filter');
            filterContainer.innerHTML = ''; // Clear existing filters

            // "All" filter button
            const allButton = document.createElement('button');
            allButton.classList.add('btn', 'btn-secondary');
            allButton.textContent = 'All';
            allButton.addEventListener('click', () => {
                populateCards(getAllCards());
                highlightActiveFilter(allButton);
            });
            filterContainer.appendChild(allButton);

            // Filter buttons based on capabilitiesData keys
            Object.keys(capabilitiesData).forEach(key => {
                const button = document.createElement('button');
                button.classList.add('btn', 'btn-secondary');
                button.textContent = key;
                button.addEventListener('click', () => {
                    filterCards(key);
                    highlightActiveFilter(button);
                });
                filterContainer.appendChild(button);
            });
        }

        // Highlight the active filter
        function highlightActiveFilter(activeButton) {
            const buttons = document.querySelectorAll('#capabilities-filter .btn');
            buttons.forEach(btn => {
                btn.classList.remove('btn-primary');
                btn.classList.add('btn-secondary');
            });
            activeButton.classList.add('btn-primary');
            activeButton.classList.add('active')
            activeButton.classList.remove('btn-secondary');
        }

        // Retrieve all cards
        function getAllCards() {
            return Object.values(capabilitiesData).flat();
        }

        // Filter cards by type
        function filterCards(type) {
            const cards = capabilitiesData[type];
            populateCards(cards);
        }

        // Populate cards based on selected filter
        function populateCards(cards) {

            const capabilitiesContainer = document.getElementById('capabilities-items');
            capabilitiesContainer.innerHTML = ''; // Clear any existing cards

            // Ensure cards is always an array
            const cardsArray = Array.isArray(cards) ? cards : [];

            cardsArray.forEach(card => {
                // Create the main card div
                const cardDiv = document.createElement('div');
                cardDiv.className = 'col-md-4 mb-4';

                // Apply boardcard structure and style
                cardDiv.innerHTML = `
    <div class="boardcard">
        <div class="boardcard-header ${getHeaderClass(card.domain)}">
            <span>${card.title}</span>
            <span class="boardcard-header-number">${card.value}</span>
        </div>
        <div class="boardcard-image">
            <img src="${card.img}" alt="${card.title}">
        </div>
        <div class="boardcard-content">${card.description} <img src="https://i.imgur.com/efPl2qm.png"
                 class="info-icon"
                 alt="Info Icon"
                 onclick="openCardModal('${card.title}','${card.info}')"></div>
        <div class="boardcard-footer">${card.capability}</div>
        <div class="checkbox-container">
            <input type="checkbox" class="purchase-checkbox" data-cost="${card.value}" data-title="${card.title}">
        </div>
    </div>
`;






                // Add checkbox logic
                const checkbox = cardDiv.querySelector('.purchase-checkbox');
                checkbox.checked = purchasedCapabilities.has(card.title); // Preserve checked state if already purchased

                checkbox.addEventListener('change', () => {
                    handleCheckboxChange(checkbox, card);
                });

                capabilitiesContainer.appendChild(cardDiv);
            });
        }


        // Handle checkbox selection for budget and purchasedCapabilities
        function handleCheckboxChange(checkbox, card) {
            const cardCost = parseInt(checkbox.getAttribute('data-cost'));
            const cardTitle = checkbox.getAttribute('data-title');

            if (checkbox.checked) {
                if (budget >= cardCost) {
                    purchasedCapabilities.set(cardTitle, card);
                    budget -= cardCost;
                } else {
                    checkbox.checked = false;
                    alert("Not enough budget!");
                }
            } else {
                purchasedCapabilities.delete(cardTitle);
                budget += cardCost;
            }

            updateBudget();
        }

        // Function to get header color based on domain
        function getHeaderClass(domain) {
            switch (domain) {
                case "Info Ops": return "header-blue";
                case "C4ISR": return "header-green";
                default: return "header-green";
            }
        }

        //Summary
        // Función para renderizar el resumen
        function generatePurchaseSummary() {
            const summary = {
                AirUnits: {},
                LandUnits: {},
                Capabilities: {},
                totalCost: 0
            };

            let airUnitsTotalCost = 0;
            let landUnitsTotalCost = 0;
            let capabilitiesTotalCost = 0;

            // Agrupar y calcular coste de Air Units
            Object.values(purchasedAirUnits).forEach(unit => {
                const type = unit.type || "Unknown Type";
                const cost = unit.value || 0;

                if (!summary.AirUnits[type]) {
                    summary.AirUnits[type] = { count: 0, totalCost: 0, items: [] };
                }

                summary.AirUnits[type].count += 1;
                summary.AirUnits[type].totalCost += cost;
                summary.AirUnits[type].items.push({ name: unit.unit_name, cost });

                airUnitsTotalCost += cost;
            });

            // Agrupar y calcular coste de Land Units
            Object.values(purchasedLandUnits).forEach(unit => {
                const type = unit.type || "Unknown Type";
                const cost = unit.value || 0;

                if (!summary.LandUnits[type]) {
                    summary.LandUnits[type] = { count: 0, totalCost: 0, items: [] };
                }

                summary.LandUnits[type].count += 1;
                summary.LandUnits[type].totalCost += cost;
                summary.LandUnits[type].items.push({ name: unit.unit_name, cost });

                landUnitsTotalCost += cost;
            });
            // Agrupar y calcular coste de Capabilities
            purchasedCapabilities.forEach((capability) => {
                const domain = capability.domain || "General";
                const cost = capability.value || 0;
                if (!summary.Capabilities[domain]) {
                    summary.Capabilities[domain] = { count: 0, totalCost: 0, items: [] };
                }
                summary.Capabilities[domain].count += 1;
                summary.Capabilities[domain].totalCost += cost;
                summary.Capabilities[domain].items.push({ name: capability.title, cost });
                capabilitiesTotalCost += cost;
            });
            // Añadir costes totales por grupo y general
            summary.AirUnits.totalCost = airUnitsTotalCost;
            summary.LandUnits.totalCost = landUnitsTotalCost;
            summary.Capabilities.totalCost = capabilitiesTotalCost;
            summary.totalCost = airUnitsTotalCost + landUnitsTotalCost + capabilitiesTotalCost;

            return summary;
        }
        function renderSummary(close) {
            const summary = generatePurchaseSummary();
            let summaryDetailsDiv;
            if (close){
                summaryDetailsDiv = document.getElementById('close-message');
            }else{
                summaryDetailsDiv = document.getElementById('summary-details');
            }
            summaryDetailsDiv.innerHTML = ''; // Limpiar contenido anterior
            if (close){
                summaryDetailsDiv.innerHTML += '<h4>You can close this window</h4>'
            }
            // Función auxiliar para generar HTML de cada sección
            function generateSectionHTML(sectionData, title) {
                const sectionDiv = document.createElement('div');
                sectionDiv.className = 'summary-section';
                const sectionTitle = document.createElement('h4');
                sectionTitle.textContent = title;
                sectionDiv.appendChild(sectionTitle);
                Object.keys(sectionData).forEach((group) => {
                    if (group !== 'totalCost') {
                        const groupData = sectionData[group];
                        const groupDiv = document.createElement('div');
                        groupDiv.className = 'summary-group';
                        const groupTitle = document.createElement('p');
                        groupTitle.className = 'summary-group-title';
                        groupTitle.textContent = `${group} - ${groupData.count} items`;
                        groupDiv.appendChild(groupTitle);
                        // Agrupar y contar unidades del mismo tipo
                        const unitCountMap = {};
                        groupData.items.forEach(item => {
                            if (unitCountMap[item.name]) {
                                unitCountMap[item.name].quantity += 1;
                            } else {
                                unitCountMap[item.name] = { quantity: 1, cost: item.cost };
                            }
                        });
                        // Crear elementos de lista para cada tipo de unidad agrupado
                        Object.entries(unitCountMap).forEach(([unitName, unitData]) => {
                            const itemDiv = document.createElement('div');
                            itemDiv.className = 'summary-item';

                            const itemQuantityText = unitData.quantity > 1 ? `${unitData.quantity}x` : '1   x';
                            itemDiv.textContent = `${itemQuantityText} ${unitName}`;

                            const itemCost = document.createElement('span');
                            itemCost.textContent = `$${(unitData.cost * unitData.quantity).toLocaleString()}`;
                            itemDiv.appendChild(itemCost);

                            groupDiv.appendChild(itemDiv);
                        });

                        // Añadir el subtotal de cada grupo
                        const sectionTotalDiv = document.createElement('div');
                        sectionTotalDiv.className = 'section-total';
                        sectionTotalDiv.innerHTML = `<span>Subtotal ${group}</span><span>$${groupData.totalCost.toLocaleString()}</span>`;
                        groupDiv.appendChild(sectionTotalDiv);

                        sectionDiv.appendChild(groupDiv);
                    }
                });

                return sectionDiv;
            }

            // Añadir secciones al resumen
            summaryDetailsDiv.appendChild(generateSectionHTML(summary.AirUnits, 'Air Domain'));
            summaryDetailsDiv.appendChild(generateSectionHTML(summary.LandUnits, 'Land/Sea Domain'));
            summaryDetailsDiv.appendChild(generateSectionHTML(summary.Capabilities, 'Capabilities'));

            // Añadir coste total general
            const totalCostDiv = document.createElement('div');
            totalCostDiv.className = 'overall-total';
            totalCostDiv.innerHTML = `<span>TOTAL</span><span>$${summary.totalCost.toLocaleString()}</span>`;
            summaryDetailsDiv.appendChild(totalCostDiv);
        }
        function exportData() {
            // Obtenemos las unidades aéreas desplegadas
            const airUnits = Object.values(purchasedAirUnits).map(unit => ({
                unit_dbid: unit.unit_dbid,
                base_name: unit.airbase ? unit.airbase.name : null, // Nombre de la base aérea donde está desplegada
                n_units: 1, // Número de unidades compradas (una por cada compra individual)
                type: unit.type
            }));
        
            // Obtenemos las unidades terrestres y marítimas desplegadas
            const landSeaUnits = Object.values(purchasedLandUnits).map(unit => ({
                unit_dbid: unit.unit_dbid,
                unit_name: unit.unit_name,
                lat: unit.marker ? unit.marker.getLatLng().lat : null, // Latitud si se ha colocado en el mapa
                lon: unit.marker ? unit.marker.getLatLng().lng : null,  // Longitud si se ha colocado en el mapa
                type: unit.type
            }));
            
            
            // Obtenemos las capacidades compradas
            const capabilities = Array.from(purchasedCapabilities.values()).map(capability => ({
                name: capability.title,
                capability_id: capability.id,
                description: capability.description,
                value: capability.value,
                domain: capability.domain
            }));

        
            // Crear el objeto final
            const exportData = {
                AirUnits: airUnits,
                LandSeaUnits: landSeaUnits,
                Capabilities: capabilities
            };
        
            // Convertir a JSON
            const exportJson = JSON.stringify(exportData);
        
            // Mostrar en consola (o en el lugar donde prefieras exportarlo)
            
            
            return exportJson
        }
        function finishDeploy() {
            const summary = exportData()
            console.log(summary)
            isSetup = true
            window.chrome.webview.postMessage(`DIALOG_OKbL3.Functions.BlueSetup('${summary}')`);
            displaySetup()
        }
        function updateMaxLimit(data, complexity) {
            for (const category in data) {
                data[category].forEach(unit => {
                    if (unit.hasOwnProperty('maxLimit')) {
                        if (category.includes("SHIP") || category.includes("SUBMARINE")) {
                            unit.maxLimit += complexity; // Regular increase
                        } else {
                            unit.maxLimit += complexity * 2; // Double increase
                        }
                    }
                });
            }
        }
        function updateValueByPercentage(data, percentage) {
            for (const category in data) {
                data[category].forEach(unit => {
                    if (unit.hasOwnProperty('value')) {
                        let newValue = unit.value * (1 + percentage / 100);
                        unit.value = Math.round(newValue / 5) * 5;
                    }
                });
            }
        }                    
        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            const target = e.target.getAttribute('href');
            console.log(target)
            if (target === '#store-tab') {
                // Si la pestaña activa es la de la tienda, refresca la vista de tienda
                renderItems();
            } else if (target === '#land-deploy-tab') {
                // Si es la pestaña de despliegue terrestre, refresca la vista de unidades desplegables

            } else if (target === '#air-deploy-tab') {
                // Si es la pestaña de despliegue aéreo, refresca la vista de unidades aéreas
                renderAvailableAirUnits();
            } else if (target === '#capabilities-deploy-tab') {
                populateCards(getAllCards());
            } else if (target === '#summary-tab') {
                renderSummary()
            }
        });
        document.addEventListener('DOMContentLoaded', () => {
            if (isSetup) {
                displaySetup()
            } else {
                populateFilters(itemsData);
                createFilters();
                updateBudget();
                renderItems(); // Initial render of items
                deployFixedUnits();
                placedAirBaseMarkers();
                populateCards(getAllCards());
            }
        });
    </script>
</body>

</html>]]
  local html = string.format(setup_tmp,bL3.BLUE.BUDGET,bL3.COMPLEXITY,bL3.JSON.UNITS,bL3.JSON.FIXEDUNITS,bL3.JSON.CARDS)
--   print(html)
  ScenEdit_SpecialMessage('playerside',html)
end
-- print("Setup Script Loaded")


--NKE-lua
bL3.NKE = {}


bL3.NKE.LOG = gKH.State.LoadTableFromKey('NKELOG')
if not bL3.NKE.LOG then
  bL3.NKE.LOG = {}
end
bL3.NKE.RED = gKH.State.LoadTableFromKey('NKERED')
if not bL3.NKE.RED then
  bL3.NKE.RED = {}
end
bL3.NKE.BLUE = gKH.State.LoadTableFromKey('NKEBLUE')
if not bL3.NKE.BLUE then
  bL3.NKE.BLUE = {}
end

function bL3.NKE.LogAction(side,msg)
  local timestamp = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local log = string.format("[%s NKE] - %s : %s",side,timestamp,msg)
  table.insert(bL3.NKE.LOG,log)
  gKH.State.SaveTableToKey(bL3.NKE.LOG, 'NKELOG')
end
function bL3.NKE.ShowLog()
  local html_tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log Viewer</title>
    <style>
        body {
            font-family: 'Consolas', monospace;
            background-color: #000;
            color: #00FF00;
            padding: 20px;
            text-transform: uppercase;
            text-align: justify;
            background-image: url('https://i.imgur.com/YLNSuH3.jpeg');
            background-size: cover;
        }
        .monitor-container {
            margin-top: 10vh;
            margin-bottom: 10vh;
        }
        .message-container {
            width: 70%%;
            height: 70%%;
            margin: auto;
            padding: 35px;
            color: #00FF00;
            border: 2px solid #00FF00;
            border-radius: 5px;
            background-color: rgba(31, 31, 31, 0.8);
            font-size: 0.95em;
        }
        .log-entry {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="monitor-container">
        <div class="message-container" id="message-body">
            <!-- Logs will be dynamically inserted here -->
        </div>
    </div>
    <script>
        const jsonMessageLog = %s;

        function renderLogs(logs) {
            const messageBody = document.getElementById('message-body');
            logs.forEach(log => {
                const logEntry = document.createElement('div');
                logEntry.className = 'log-entry';
                logEntry.textContent = log;
                messageBody.appendChild(logEntry);
            });
        }

        renderLogs(jsonMessageLog);
    </script>
</body>
</html>]]
  local msg = string.format(html_tmp,bL3.AuxFunctions.TableToJson(bL3.NKE.LOG))
  ScenEdit_SpecialMessage('playerside',msg)
end
bL3.RED.GPSWeapons = {
  [2863] = true ,
  [3716] = true,
  [4462] = true,
  [4463] = true
}
bL3.BLUE.GPSWeapons = {
  [2855] = true,
  [2378] = true
}
-- Info Ops

---id:1
---"description": "Counters enemy electromagnetic and communication jamming capabilities",
---"capability": "Protects communication lines from interference",
-- bL3.NKE.EMDefense= true | false


---id:2
---"description": "Disrupts enemy C2 node, causing delays and miscoordinations",
---This function will add a variability in all Time on Target or Time on Station missions from a given side. The variability and the probability of success will be related to opside capabilities Secure Comms and NetworkResilience.

function bL3.NKE.GetC2Threshold(side)
  local threshold = 0.4
  local mods = {}
  if bL3[side].NKE.SecureComms then
    threshold = threshold + 0.25
    table.insert(mods,"Secure Comms")
  end
  if bL3[side].NKE.NetworkResilience then
    threshold = threshold + 0.15
    table.insert(mods,"Network Resilience")
  end
  return threshold, mods
end

function bL3.NKE.C2Attack(opside)
  local side = bL3.Functions.GetOpSide(opside)
  local threshold, mods = bL3.NKE.GetC2Threshold(opside)
  local msg 
  if next(mods) == nil then
      msg = string.format(
          "Performing C2 Attack against %s. %s has no modifiers to counter the attack. Threshold = %f",
          opside,
          opside,
          threshold
      )
  else
      msg = string.format(
          "Performing C2 Attack against %s. %s has the following modifiers for defense: %s. Threshold = %f",
          opside,
          opside,
          table.concat(mods, ", "),
          threshold
      )
  end
  bL3.NKE.LogAction(side,msg)
  if opside == 'RED' then
    local missions = bL3.RED.MISSIONS
    for k,v in pairs(missions) do
      if v.tot and v.tot ~= 0 then

        local dice = math.random()
        if dice > threshold then
          local variation = {-1,1}
          local mission = ScenEdit_GetMission(opside,v.guid)
          local original_tot = v.tot
          -- print(mission.name.. ' - ORIGINAL TOT - ' .. os.date(bL3.DATEFORMAT, original_tot))
          local timeVariation = (math.random(20,120))*60*variation[math.random(#variation)]
          local new_tot = original_tot + timeVariation
          mission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, new_tot)
          -- print(mission.name.. ' - NEW TOT - ' .. os.date(bL3.DATEFORMAT, new_tot)..'\n')
          v.tot = new_tot
          msg = string.format("RED Mission: %s. Affected by C2 Attack. Time on Target changed. Dice roll = %f. Threshold = %f", mission.name,dice, threshold)
          bL3.NKE.LogAction(side,msg)
        end
      end
    end
  else
    local missions = ScenEdit_GetMissions(opside)
    if missions then
      for _,v in ipairs(missions) do
        local mission = ScenEdit_GetMission(opside,v.guid)
        if mission and mission.TimeOnTargetStation and #mission.TimeOnTargetStation ~= 0 then
          local original_tot = bL3.AuxFunctions.DateToTimeStamp(mission.TimeOnTargetStation)
        
          local variation = {-1,1}
          local new_tot = original_tot + (math.random(60)/threshold)*60*variation[math.random(#variation)]
          local dice = math.random()
          if dice > threshold then
            mission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, new_tot)
            msg = string.format("BLUE Mission: %s. Affected by C2 Attack. Time on Target changed. Dice roll = %f. Threshold = %f", mission.name,dice, threshold)
            bL3.NKE.LogAction(side,msg)
          end
        end
      end
    end
  end
end
---id:3
---"description": "Deploys Spoofers, physical decoys and camouflage on mobile units",

   
---id:4
---"Alters GPS signals to hinder enemy navigation and reveal enemy positions in an area",
function bL3.NKE.EntersGPSArea(opside)
  local unit = UnitX()
  local dice = math.random()
  
  local msg
  local side
  if unit then
    side = bL3.Functions.GetOpSide(unit.side)
  else
    return
  end
  if unit.type ~= 'Weapon' then
    if dice > 0.5 then
      ScenEdit_SetUnit({guid = unit.guid, autodetectable=true})
      msg = string.format("Unit %s [%s] entering GPS Spoof Area, trying to spoof its GPS system. Threshold=0.5. Dice = %f. Success", unit.name, unit.classname,dice)
    else
      msg = string.format("Unit %s [%s] entering GPS Spoof Area, trying to spoof its GPS system. Threshold=0.5. Dice = %f. Failure", unit.name, unit.classname,dice)
    end
    bL3.NKE.LogAction(side,msg)
  end
  
end

function bL3.NKE.LeavesGPSArea(opside)
  local side = bL3.Functions.GetOpSide(opside)
  local unit = UnitX()
  if unit and unit.type ~= 'Weapon' then
    ScenEdit_SetUnit({guid = unit.guid, autodetectable=false}) 
    local msg = string.format("Unit %s Class: %s leave GPS Spoof Area", unit.name, unit.classname)
    bL3.NKE.LogAction(side,msg)
  end
 
end
function bL3.NKE.GPSJamWeapon(weaponU)
  if weaponU.course then   
    local last_waypoint = weaponU.course[#weaponU.course]
    if last_waypoint then
      local lat = last_waypoint.latitude
      local lon = last_waypoint.longitude
      --Amount of deviation
      lat = lat + math.random(-100,100)/10^5
      lon = lon + math.random(-100,100)/10^5
      -- We change the course of the weapon assigning the new latitude and longitude info
      if #weaponU.course == 1 then -- If the unit only has the terminal point
        weaponU.target ={ latitude=lat, longitude=lon, GUID='BOL' }
        weaponU.course ={ {latitude=lat, longitude=lon, TypeOf='TerminalPoint'} }
      else -- For weapons with a predefined course of waypoints, we maintain all the waypoints
        local newCourse = {}
        for k,v in ipairs(weaponU.course) do
          if k ~= #weaponU.course then
            newCourse[k] = v
          else
            newCourse[k] = {latitude=lat, longitude=lon, TypeOf='TerminalPoint'}
          end
        end
        weaponU.course = newCourse
        weaponU.target ={ latitude=lat, longitude=lon, GUID='BOL' }
      end
    end
  end
end
function bL3.NKE.RemainsGPSArea(opside)
  local threshold = 0.7
  local side = bL3.Functions.GetOpSide(opside)
  local unit = UnitX()
  if unit and unit.type == 'Weapon' and bL3[opside].GPSWeapons[unit.dbid] then
    if math.random() > 0.5 then
      ScenEdit_SetUnit({guid = unit.guid, latitude=unit.latitude+math.random(-1000,1000)/10^5, longitude=unit.longitude+math.random(-1000,1000)/10^5})  
    end
    if math.random() > 0.75 then
      bL3.NKE.GPSJamWeapon(unit)
      local msg = string.format("Weapon: %s Class: %s being GPS Jammed", unit.name, unit.classname)
      bL3.NKE.LogAction(side,msg)
    end
  elseif unit and math.random()> 0.8 and not string.find(unit.name, 'HUMINT') then
    ScenEdit_SetUnit({guid = unit.guid, latitude=unit.latitude+math.random(-1000,1000)/10^5, longitude=unit.longitude+math.random(-1000,1000)/10^5, heading=unit.heading+math.random(-5,5)})
    local msg = string.format("Unit: %s Class: %s position altered due to GPS Jamming", unit.name, unit.classname)
    bL3.NKE.LogAction(side,msg)
  end
end
---id:5
---"description": "Disrupts enemy sensors capabilities on a precise location",
---"capability": "Targets sensors to disable enemy surveillance",
function bL3.NKE.TactCyberAttack(opside, unit_guid)
  
  local side = bL3.Functions.GetOpSide(opside)
  local unit
  if unit_guid then -- RED CyberAttack
    unit = SE_GetUnit({guid = unit_guid})
    if not unit then return 0 end
    local threshold = bL3[opside].NKE.CyberTH
    local mods = {}
    local blueM = false
    if bL3[opside].NKE.NetworkSecurity then
      threshold = threshold + 0.3
      table.insert(mods,'Network Security')
    end
    if bL3[opside].NKE.NetworkResilience then
      threshold = threshold + 0.1
      table.insert(mods,'Network Resilience')
    end
    if bL3[side].NKE.NetworkInfiltration then
      threshold = threshold - 0.3
      blueM = true
    end
    local dice = math.random()
    local msg
    if next(mods) == nil then
      msg = string.format("Performing Cyber Attack against unit %s Class: %s. %s has no modifiers against the attack. ", unit.name, unit.classname, opside)
    else
      msg = string.format("Performing Cyber Attack against %s [%s]. %s has the following modifiers against the attack: %s. ", unit.name, unit.classname, opside,table.concat(mods,', ') )
    end
    if blueM then
      msg = msg..string.format("%s has the following modifier to support the attack: NetworkInfiltration. ",side)
    end
    msg = msg..string.format("Threshold = %f. Dice = %f. Result: ", threshold, dice)
    if dice > threshold then
      local sensors = unit:filterOnComponent('sensor')
      for _,sens in ipairs(sensors) do
        if math.random() > 0.3 then
          ScenEdit_SetUnitDamage({side=opside, guid=unit.guid,dp=0, components={{sens.comp_guid,'1'}}})
        end
      end
      if unit.dbid == 615 then
        ScenEdit_KillUnit({guid = unit.guid})
      end
      msg = msg..' Success.'
    else
      msg = msg..' Failure.'
    end
    bL3.NKE.LogAction(side,msg)
  else -- BLUE CyberAttack
    local selected = ScenEdit_SelectedUnits().contacts
    if not selected then 
      ScenEdit_MsgBox('Select an unit before executing the Special Action',0)  
      return false 
    else
      unit = selected[1]
      local contact = ScenEdit_GetContact({side=side, guid=unit.guid})
      if contact and contact.classificationlevel >= 3 then
        unit = SE_GetUnit({guid=contact.actualunitid})
        if unit then
          local threshold = bL3[opside].NKE.CyberTH
          local mods = {}
          local blueM = false
          if bL3[opside].NKE.NetworkResilience then
            threshold = threshold + 0.1
            table.insert(mods,'Network Resilience')
          end
          if bL3[opside].NKE.NetworkSecurity then
            threshold = threshold + 0.3
            table.insert(mods,'Network Security')
          end
          if bL3[side].NKE.NetworkInfiltration then
            threshold = threshold - 0.3
            blueM = true
          end
          local dice = math.random()
          local msg
          if next(mods) == nil then
            msg = string.format("Performing Cyber Attack against unit %s Class: %s. %s has no modifiers against the attack. ", unit.name, unit.classname, opside)
          else
            msg = string.format("Performing Cyber Attack against %s [%s]. %s has the following modifiers against the attack: %s. ", unit.name, unit.classname, opside,table.concat(mods,', ') )
          end
          if blueM then
            msg = msg..string.format("%s has the following modifier to support the attack: NetworkInfiltration. ",side)
          end
          msg = msg..string.format("Threshold = %f. Dice = %f. Result: ", threshold, dice)
          if dice > threshold then
            local sensors = unit:filterOnComponent('sensor')
            for _,sens in ipairs(sensors) do
              if math.random() > 0.3 then
                ScenEdit_SetUnitDamage({side=opside, guid=unit.guid,dp=0, components={{sens.comp_guid,'1'}}})
              end
            end
            msg = msg..' Success.'
          else
            msg = msg..' Failure.'
          end
          -- local min = math.random(90,180)
          -- if bL3[side].NKE.NetworkInfiltration then min = min - math.random(30,45) end
          -- local time = os.date(bL3.DATEFORMAT, min*60 + ScenEdit_CurrentTime()) 
          -- msg = msg..' The action will become available again in '..min..' minutes.'
          ScenEdit_MsgBox(msg,0)
          bL3.NKE.LogAction(side,msg)
          ScenEdit_SetSpecialAction({ActionNameOrID='NKE_Tactical Cyber Attack',side=bL3.SIDES.BLUE, mode='remove'})
          -- local script = [[ScenEdit_AddSpecialAction({ActionNameOrID='NKE_Tactical Cyber Attack', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.NKE.TactCyberAttack("RED")', description='Select an enemy unit before proceed.'});bL3.AuxFunctions.RemoveEvent('TactCyberRegen')]]
          -- bL3.AuxFunctions.TimeEvent('TactCyberRegen',time,script,'add')
        end
      else
        ScenEdit_MsgBox('Select a Class ID contact to perform the cyber attack',0)  
        return false
      end
      
      
    end
  end

  if not unit then
    return false
  else
    
  end
end

function bL3.NKE.RedCyberAttack()
  local units = bL3.AuxFunctions.sortTableByValueKey(bL3.TargetList,'priority')
  local actPerformed = false
  local i = 0
  ::redoTact::
  i = i + 1
  local guid = units[i]
  if guid then
    if units[i].t_type ~= 'JAMCENTER' and units[i].t_type ~= 'SSM' then
      actPerformed = true
      bL3.NKE.TactCyberAttack('BLUE',guid)
    else
      goto redoTact 
    end
  end
  

  if not actPerformed then
    --Search if there's an ISR air unit to perform the cyber attack
    local ISR = { [5436] = true, [4328] = true}
    local airContacts = VP_GetSide({side='RED'}):contactsBy('Aircraft')
    if airContacts and next(airContacts) then
      for k,v in ipairs(airContacts) do
        local contact = ScenEdit_GetContact({guid=v.guid, side='RED'})
        if contact and contact.classificationlevel >=2 and ISR[contact.actualunitdbid] then
          bL3.NKE.TactCyberAttack('BLUE',contact.actualunitid)
          actPerformed = true
        end
      end  
    end
  end
  if not actPerformed then
    local nTime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + math.random(15,30)*60 )
    bL3.AuxFunctions.TimeEvent('RED Activate Cyber Attack',nTime,nil,'update')
  end

  --
end
---id:6
--- "description": "Disrupts enemy contact with UAV/UCAV platforms"
function bL3.NKE.HackUAV(opside)
  local side = bL3.Functions.GetOpSide(opside)
  local unit = UnitX()
  if unit and (unit.subtype == '8201' or unit.subtype == '8202') and not unit.outOfComms then
    local threshold = 0.4
    local mod
    if bL3[opside].NKE.SecureComms then
      threshold = threshold + 0.3
      mod = 'Secure Comms'
    end
    local dice = math.random()
    local msg

    if not mod then
      msg = string.format("Trying to hack UAV %s Class: %s. %s has not modifiers. Threshold %f. Dice %f Result:",unit.name,unit.classname,opside, threshold,dice)
    else
      msg = string.format("Trying to hack UAV %s Class: %s. %s has %s modifiers. Threshold %f. Dice %f Result:",unit.name,unit.classname,opside,mod, threshold,dice)
    end
 
    if dice > threshold then
      ScenEdit_SetUnit({guid = unit.guid, outofcomms=true})
      local duration = 3*60*60 + math.random(59)*60
      if bL3[opside].NetworkResilience then
        duration = duration - math.random(40,120)
      end
      local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+duration)
      local id = bL3.AuxFunctions.RandomTxt(3)
      bL3.AuxFunctions.TimeEvent('OutOfComms #'..id,time,'ScenEdit_SetUnit({guid="'..unit.guid..'", outofcomms=false}); bL3.AuxFunctions.RemoveEvent("OutOfComms #'..id..'")','add',false)
      msg = msg..'Success'
      
    else
      msg = msg..'Failure'
    end
    bL3.NKE.LogAction(side,msg)
  end
end

---id:7
---Electromagnetic Attack
function bL3.NKE.EMAttack(opside)
  
  local side = bL3.Functions.GetOpSide(opside)
  -- print(string.format('\n------%s EM Attack-----',side))
  local a_units = bL3[opside].ActiveUnits
  local jammed_units = bL3[opside].EMUnits
  

  local threshold = bL3[opside].NKE.EMTH
  local position = {
    ['RED'] = {latitude=14.57, longitude=120.97},
    ['BLUE'] = bL3.RED.UNITS.C2SHIP
  }
  local p = position[opside]
  for id,row in pairs(a_units) do
    if row.jamresistance/100 > math.random() then goto continueEM end
    local u = SE_GetUnit({guid = row.guid})
    if not u then bL3[opside].ActiveUnits[id] = nil goto continueEM end
    if u.type == 'Aircraft' and u.speed == 0 then goto continueEM end
    local dice = math.random()
    -- print(u.name..': '..dice .. ' vs Threshold: '..threshold)
    if dice < threshold and Tool_Range(p,u.guid) <= math.random(240,360) and not jammed_units[u.guid] then
      local detection = row.OODA.detection * (1+math.random(30,60)/100)
      local targeting = row.OODA.targeting * (1+math.random(30,60)/100)
      local evasion = row.OODA.evasion * (1+math.random(30,60)/100)
      u.OODA = {detection = detection, targeting = targeting, evasion = evasion}
      bL3[opside].EMUnits[u.guid] = {EMTime = 1, originalOODA = row.OODA, jamresistance=row.jamresistance, name=u.name}
    end
    ::continueEM::
  end
  
  -- print('\n------EM Degrade units-----')
  for id,v in pairs(jammed_units) do
    if v.EMTime > 1 then
      local th = math.exp(0.035 * v.EMTime) - 1
      th = th + v.jamresistance/150
      local dice = math.random()
      -- print(v.name..' - Time:'..v.EMTime.. ' - DICE: '..dice.. ' - THRESHOLD: '..th)
      if math.random() < th or Tool_Range(p,id) > math.random(240,360) then
        local u = SE_GetUnit({guid = id})
        if u then
          u.OODA = v.originalOODA
          bL3[opside].EMUnits[id]=nil
        else
          bL3[opside].EMUnits[id] = nil
        end
      else
        v.EMTime = v.EMTime + 5
        bL3[opside].EMUnits[id] = v
      end
    end
  end
  gKH.State.SaveTableToKey(bL3[opside],opside)
    ::continue::
end
function bL3.NKE.EndEMAttack(opside)
  local jammed_units = bL3[opside].EMUnits
  for id,v in pairs(jammed_units) do
    local unit = SE_GetUnit({guid = id})
    if unit then
      unit.OODA = v.originalOODA
    end
    bL3[opside].EMUnits[id] = nil  
  end
  gKH.State.SaveTableToKey(bL3[opside],opside)
end
---id:17
---Comms Jamming
---

function bL3.NKE.CommJamm(opside)
  
  local side = bL3.Functions.GetOpSide(opside)
  local a_units = bL3[opside].ActiveUnits
  local jammed_units = bL3[opside].JammedUnits
  local area = bL3[side].NKE.JammingArea.area
  local power = bL3[side].NKE.JammingArea.power
  local center = bL3[side].NKE.JammingArea.center
  local EA_mod = 0
  if bL3.BLUE.NKE.EA37 then
    local mod = 25
    for id,v in pairs(bL3.BLUE.NKE.EA37) do
      local u = SE_GetUnit({guid = id})
      if u and u.condition == 'Airborne' and u.jammer and Tool_Range(u.guid,center) < 500 then
        EA_mod = EA_mod + mod
        mod = mod/2
      end
    end
  end
  local threshold = bL3[opside].NKE.CJAM_TH
  local resJam = bL3[opside].NKE.RESJAM_TH
  --print(string.format('\n------%s COMM JAM-----',side))
  for id,row in pairs(a_units) do
    
    if row.jamresistance/100 > math.random() then goto continueCJ end
    local u = SE_GetUnit({guid = row.guid})
    if u and u:inArea(area) and not jammed_units[u.guid] then
      if u.type == 'Aircraft' and u.speed == 0 then goto continueCJ end
      local distance = Tool_Range(u.guid,center)
      local dice = (power/100)*threshold+(EA_mod/100 - distance/1200)
      dice = math.max(dice,0.005)
      -- print(u.name..': '..dice)
      if dice > math.random() then
        u = ScenEdit_SetUnit({guid = row.guid, outofcomms = true})
        bL3[opside].JammedUnits[u.guid] = {timeOutOfComms = 1, name=u.name, jamresistance=row.jamresistance}
      end
    elseif not u then
      bL3[opside].JammedUnits[id] = nil
    end
    ::continueCJ::
  end
  -- print('----------OUTOFCOMMS------------')
  for id,v in pairs(jammed_units) do
    local u = SE_GetUnit({guid = id})
    local th = math.exp(resJam * v.timeOutOfComms) - 1
    th = th - EA_mod/100
    th = th + v.jamresistance/200
    -- print(u.name..' OutOfComms DICE: '..th)
    if not u then
      bL3[opside].JammedUnits[id] = nil
      bL3[opside].ActiveUnits[id] = nil
    else
      if math.random() < th or not u:inArea(area) then
        ScenEdit_SetUnit({guid = id, outofcomms = false})
        bL3[opside].JammedUnits[id] = nil
      else
        bL3[opside].JammedUnits[id].timeOutOfComms = v.timeOutOfComms + 1
      end
    end
  end
  print('\n')
  gKH.State.SaveTableToKey(bL3[opside],opside)
end
function bL3.NKE.EndCommJamm(opside)
  local jammed_units = bL3[opside].JammedUnits
  for id,v in pairs(bL3[opside].JammedUnits) do
    ScenEdit_SetUnit({guid = id, outofcomms = false})
    bL3[opside].JammedUnits[id] = nil
  end
  gKH.State.SaveTableToKey(bL3[opside],opside)
end

-----
function bL3.Functions.Capabilities(mode)
  local html_tmp = [[<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Special Action Setup</title>
     <!-- Fuente de estilo militar -->
     <link href="https://fonts.googleapis.com/css2?family=Staatliches&display=swap" rel="stylesheet">

     <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
     <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
     <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <script src="https://unpkg.com/leaflet.gridlayer.googlemutant@0.8.0/Leaflet.GoogleMutant.js"></script>
     <script src="https://unpkg.com/leaflet.gridlayer.googlemutant@0.8.0/Leaflet.GoogleMutant.js"></script>
     <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
     <style>
      body,
      html {
          font-family: 'Staatliches', sans-serif;
          font-size: 1.1rem;
          height: 100%%;
          margin: 0;
          padding: 0;
          background-color: #0d1b2a;
          color: #ffffff;
          display: flex;
          flex-direction: column;
          overflow-x: hidden;
      }
      #map {
        height: 80vh;
    }

    .popup {
        background-color: #1a202c;
        display: flex;
        flex-direction: column;
        color: #fff;
        padding-top: 20px;
        border-radius: 5px;
        font-size: 1rem;
        align-items: center;
        width: 60%%;
        margin: auto;
    }

    #setup-btn {
        margin: 20px auto;
        display: block;
        background-color: #ff4c4c;
        border: none;
        padding: 10px;
        font-size: 1.2rem;
        color: #fff;
        border-radius: 5px;
        cursor: pointer;
    }
    #cancel-btn {
        margin: 20px auto;
        display: block;
        background-color: #2222EF;
        border: none;
        padding: 10px;
        font-size: 1.2rem;
        color: #fff;
        border-radius: 5px;
        cursor: pointer;
    }
    #setup-btn:hover {
        background-color: #e63c3c;
    }
    </style>
  </head>
  <body>
    <div id="maincontainer">
      <div class="popup" id="infoPopup">
        <h2>Instructions</h2>
        <p id="infoDescription"></p>
        <button id="setup-btn">ACK Setup</button>
        <button id="cancel-btn">Cancel</button>
      </div>
      <div id="map"></div>

    </div>
    <script>
      // Variables dinámicas según el modo
      const mode = "%s"; // Cambiar a diferentes modos según sea necesario
      let description, markerIcon, markerRadiusColor, markerRadius,functionName;
      let latMin, latMax, lngMin, lngMax;
      switch (mode) {
          case "HackUAV":
              description = "Place the UAV JAM station in a land position inside Phil. The station will try to jam enemy UAV/UCAV that enters the surrounding area";
              functionName = "HackUAV"
              markerIcon = L.icon({
                iconUrl: 'https://i.imgur.com/mJKV3vM.png', // Cambiar por un ícono personalizado
                iconSize: [42, 30],
                iconAnchor: [21, 15]
              });
              markerRadiusColor = "rgba(255, 120, 125, 0.25)";
              markerRadius = 125 * 1852
              latMin = 10;  
              latMax = 19.8;  
              lngMin = 119; 
              lngMax = 123.5;  
              break;
          case "gpsSpoof":
              description = "Select the area you would like to spoof. This action won't place any unit in the terrain.";
              functionName = "GPSSpoof"
              markerIcon = L.icon({
                iconUrl: 'https://i.imgur.com/mJKV3vM.png', // Cambiar por un ícono personalizado
                iconSize: [42, 30],
                iconAnchor: [21, 15]
              });
              markerRadiusColor = "rgba(173, 216, 230, 0.25)";
              markerRadius = 100 * 1852
              latMin = 10;  
              latMax = 20.5;  
              lngMin = 117; 
              lngMax = 125;
              break;
          case "DeployHelios":
              description = "Select the place you would like to deploy the HELIOS Aerostat Balloon";
              functionName = "DeployHelios"
              markerIcon = L.icon({
                iconUrl: 'https://i.imgur.com/Zhh08SM.png', // Cambiar por un ícono personalizado
                iconSize: [30, 30],
                iconAnchor: [15, 15]
              });
              latMin = 10;  
              latMax = 19.7;  
              lngMin = 119; 
              lngMax = 124;  
              break;
          case "CommJamming":
              description = "Select the area you would like to focus the Communication Jamming. Note that an EA-37B on air will increase the efficiency and area covered by the communications jamming. The farther you set the Comm Jamm area from Manila, the lower the jamming efficiency will be. ";
              functionName = "JammingArea"
              markerIcon = L.icon({
                iconUrl: 'https://i.imgur.com/mJKV3vM.png', // Cambiar por un ícono personalizado
                iconSize: [30, 30],
                iconAnchor: [15, 15]
              });
              markerRadiusColor = "rgba(110, 225, 115, 0.25)";
              markerRadius = 350 * 1852
              latMin = 10;  
              latMax = 23;  
              lngMin = 106; 
              lngMax = 126;  
              break;
          default:
              description = "Modo no definido.";
      }

      // Mostrar la información dinámica en el popup
      document.getElementById('infoDescription').innerText = description;

      // Mapa y marcador
      const map = L.map('map').setView([17.263397866873937, 121.48759617976285], 7);
      L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
          maxZoom: 19,
          attribution: '© OpenStreetMap © CARTO'
      }).addTo(map);
      // Define the allowed area bounds
      const bounds = [
          [latMin, lngMin], // Southwest corner
          [latMax, lngMax]  // Northeast corner
      ];

      // Create a custom pane for the rectangle with a lower z-index
      map.createPane('allowedAreaPane');
      map.getPane('allowedAreaPane').style.zIndex = 400; // Lower than the default z-index of overlays (default is 401)

      // Add a rectangle to represent the allowed area
      const allowedArea = L.rectangle(bounds, {
          color: "#ff7800",
          weight: 2,
          fillOpacity: 0.2,
          fillColor: "#ff7800",
          pane: 'allowedAreaPane' // Assign the custom pane
      }).addTo(map);

      // Fit the map view to the rectangle
      map.fitBounds(bounds);
      // Crear el marcador con círculo
      const marker = L.marker([17.263397866873937, 121.48759617976285], {
          icon: markerIcon,
          draggable: true
      }).addTo(map);
      if (markerRadius != null && !isNaN(markerRadius)) {
        const circle = L.circle(marker.getLatLng(), {
            color: markerRadiusColor,
            fillColor: markerRadiusColor,
            fillOpacity: 0.4,
            radius: markerRadius // Ajustar según sea necesario
        }).addTo(map);

        // Actualizar el círculo al mover el marcador
        marker.on('move', function (e) {
            circle.setLatLng(e.latlng);
        });
      }
      // Cerrar el popup
      

      // Acción del botón Confirmar Setup
      document.getElementById('setup-btn').addEventListener('click', function () {
          
          // Define the latitude and longitude limits
          

          
          const position = marker.getLatLng();
          const lat = position.lat.toFixed(6); // Format with 6 decimals for precision
        const lng = position.lng.toFixed(6); // Format with 6 decimals for precision
          if (lat < latMin || lat > latMax || lng < lngMin || lng > lngMax) {
              alert(`Unit out of area! Lat: ${lat}, Lon: ${lng} is outside the allowed bounds.`);
          } else {
              alert(`Setup done on lat: ${position.lat}, lon: ${position.lng}. You can close the window`);
              document.getElementById('setup-btn').style.display = 'none';
              document.getElementById('cancel-btn').style.display = 'none';
              document.getElementById('infoDescription').innerText = "Close the window";
              const command = `DIALOG_OKbL3.Functions.${functionName}(${lat}, ${lng})`;
              window.chrome.webview.postMessage(command);
              marker.dragging.disable();
          }
          
          
      });
      document.getElementById('cancel-btn').addEventListener('click', function () {
        document.getElementById('setup-btn').style.display = 'none';
        document.getElementById('cancel-btn').style.display = 'none';
        document.getElementById('infoDescription').innerText = "Action canceled. Close the window";
        marker.dragging.disable();
      });
  </script>
  </body>
</html>
    
  ]]
  --modes: hackUAV, gpsSpoof, DeployHelios
  local msg = string.format(html_tmp, mode)
  ScenEdit_SpecialMessage('BLUE', msg)
end

function bL3.Functions.HackUAV(lat, lon, opsideT)
  local opside
  if not opsideT then opside = bL3.SIDES.RED else opside=opsideT end
  local side = bL3.Functions.GetOpSide(opside)
  if side == 'BLUE' then
    local jam_building = ScenEdit_AddUnit({type='Facility', side=side, name='UAV Jamming Center', dbid=615, latitude=lat, longitude=lon, autodetectable=false})
    bL3[side].NKE.UAVJAM_BUILDING = jam_building.guid
  else
    bL3[side].NKE.UAVJAM_BUILDING = bL3.RED.UNITS.C2SHIP
  end
  local area = bL3.AuxFunctions.NewArea({latitude=lat,longitude=lon},{shape='circle', distance=120, side=bL3.SIDES.BLUEDECOY})
  bL3[side].NKE.UAVJAM_AREA = area
  bL3.AuxFunctions.UnitEntersAreaEvent('Hack UAV '..opside,{TargetSide=opside, TargetType=1},area,"bL3.NKE.HackUAV('"..opside.."')", 'add', false, true,true)
  if side == 'BLUE' then
    
    ScenEdit_SetSpecialAction({ActionNameOrID='NKE_Hack UAV',side=bL3.SIDES.BLUE, mode='remove'})
  end
  gKH.State.SaveTableToKey(bL3[side],side)
end

function bL3.Functions.REDGPSSpoof()
  local side = 'RED'
  local opside = 'BLUE'
  local beach = bL3.RED.BEACH
  local bearing = Tool_Bearing(beach,bL3.RED.UNITS.C2SHIP)
  local distance = Tool_Range(bL3.RED.UNITS.C2SHIP, beach) * 0.25
  local centerArea 
  if bearing ~= 0 then
    centerArea = World_GetPointFromBearing({latitude=beach.latitude, longitude=beach.longitude, bearing=bearing, distance=distance})
  else
    centerArea = {latitude=14.6207, longitude=120.7130}
  end
  bL3.Functions.GPSSpoof(centerArea.latitude, centerArea.longitude, opside)
end

function bL3.Functions.GPSSpoof(lat, lon, opsideT)
  local opside
  if not opsideT then opside = bL3.SIDES.RED else opside = opsideT end
  local side = bL3.Functions.GetOpSide(opside)
  local area = bL3.AuxFunctions.NewArea({latitude=lat,longitude=lon},{shape='circle', distance=100, side=bL3.SIDES.BLUEDECOY})
  
  bL3.AuxFunctions.UnitEntersAreaEvent('GPS SPOOF EntersArea '..opside,{TargetSide=opside},area,"bL3.NKE.EntersGPSArea('"..opside.."')", 'add', false, true,true)

  bL3.AuxFunctions.UnitEntersAreaEvent('GPS SPOOF LeavesArea '..opside,{TargetSide=opside},area,"bL3.NKE.LeavesGPSArea('"..opside.."')", 'add', true, true,true)
  gKH.State.SaveTableToKey(bL3[side],side)
  if side == bL3.SIDES.BLUE then
    ScenEdit_SetSpecialAction({ActionNameOrID='NKE_GPS Spoof',side=side, mode='remove'})
  end

  bL3.AuxFunctions.UnitRemainsInAreaEvent('GPS SPOOF RemainsArea '..opside,{Targetside=opside},area,"bL3.NKE.RemainsGPSArea('"..opside.."')",15,true)

  local script = [[
  bL3.AuxFunctions.RemoveEvent('GPS SPOOF LeavesArea %s')
  bL3.AuxFunctions.RemoveEvent('GPS SPOOF EntersArea %s')
  bL3.AuxFunctions.RemoveEvent('GPS SPOOF RemainsArea %s')
  bL3.NKE.LogAction("%s","GPS Spoofing has ended")
  bL3.MSG.EndGPS()
  ]]
  
  script = string.format(script,opside,opside,opside,side)
  local timeToEnd = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + math.random(240,360) * 60)
  bL3.AuxFunctions.TimeEvent('GPS-End '..opside, timeToEnd,script,'add')

  local msg = string.format("GPS Spoofing has started around Lat: %f Lon: %f. Duration of the effect until %s",lat,lon, timeToEnd)
  bL3.NKE.LogAction(side,msg)
end

function bL3.Functions.DeployHumint(side)
  
  if side == 'BLUE' then
    bL3.BLUE.HUMINT = {}
    
    local redAB = bL3.REDAIRBASES
    for k,v in ipairs(redAB) do
      if math.random() > 0.3 then
        local sideH = 'BLUE HUMINT'
        local active = 1
        if math.random() > 0.5 then
          sideH = 'BLUE HUMINT N'
          active = 0
        end
        local position = World_GetPointFromBearing({latitude=v.lat, longitude=v.lon, bearing=math.random(359), distance=math.random(-3,3)+math.random()})
        local u = ScenEdit_AddUnit({type='Facility', side=sideH, name='HUMINT #'..bL3.AuxFunctions.RandomTxt(3), dbid=614, latitude=24, longitude=112})
        if not u then goto continueHumint end
        ScenEdit_SetUnit({guid = u.guid, latitude=v.lat, longitude=v.lon})
        ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'},arc_track={'360'}, dbid=6029})
        local row = {unit=u.name, guid=u.guid, lat=u.latitude, lon=u.longitude, active=active, airbase=v.name, history={}}
        row.history[os.date('!%Y-%m-%dT%H:%M:%SZ', ScenEdit_CurrentTime())] = 0
        bL3.BLUE.HUMINT[u.guid] = row
      end
      ::continueHumint::
    end
    
    --Add Humint Logic
    bL3.AuxFunctions.RegularEvent('HUMINT SWAP',7,'bL3.Functions.BlueHumintSwap()','add')
  end
  
end
function bL3.Functions.BlueHumintSwap()
  for k,v in pairs(bL3.BLUE.HUMINT) do
    if math.random() > 0.5 then
      bL3.Functions.ChangeHumintSide(k)
    end
  end
  gKH.State.SaveTableToKey(bL3.BLUE,'BLUE')
end

function bL3.Functions.ChangeHumintSide(unit_guid)
  local u = SE_GetUnit({guid = unit_guid})
  if not u then
    return 0
  end
  local side = u.side
  local active
  if side == 'BLUE HUMINT' then
    ScenEdit_SetUnitSide({guid=unit_guid, side=u.side, newside= 'BLUE HUMINT N'})
    active = 0
  else
    ScenEdit_SetUnitSide({guid=unit_guid, side=u.side, newside= 'BLUE HUMINT'})
    active = 1
  end
  -- local history = bL3.BLUE.HUMINT[u.guid].history
  bL3.BLUE.HUMINT[u.guid].active = active
  -- history[os.date('!%Y-%m-%dT%H:%M:%SZ', ScenEdit_CurrentTime())] = active
  -- bL3.BLUE.HUMINT[u.guid].history = history
end

function bL3.Functions.DeployHelios(lat, lon, side)
  if not side then side = bL3.SIDES.BLUE end
  local balloon
  
  local area
  if side == bL3.SIDES.BLUE then
    local radius = math.random(100,140)
    balloon = ScenEdit_AddUnit({type='Air', side=side, name='Helios Balloon #'..bL3.AuxFunctions.RandomTxt(3), dbid=6813, loadoutid=33162, latitude=lat, longitude=lon, altitude=24384})
    if not balloon then ScenEdit_MsgBox('Balloon cannot be placed') return 0 else 
      ScenEdit_SetSpecialAction({ActionNameOrID='NKE_Deploy Helios Balloon',side=side, mode='remove'})
    end
    bL3.BLUE.UNITS.Balloon = balloon.guid
    --Adding Comms + Sensors to Helios
    if bL3.BLUE.NKE.ExtendedNIFC then
      for _,x in ipairs({318,294,346,458}) do
        ScenEdit_UpdateUnit({guid=balloon.guid, mode='add_comms', dbid=x})  
      end
    end
    for _,x in ipairs({540}) do
      ScenEdit_UpdateUnit({guid=balloon.guid, mode='add_sensor',arc_detect={'360'},arc_track={'360'}, dbid=x})
    end
    local msg = "Added Helios Balloon"
    bL3.NKE.LogAction(side,msg)
  else
    local radius = math.random(80,120)
    balloon = ScenEdit_AddUnit({type='Air', side=side, name='SPY Balloon #'..bL3.AuxFunctions.RandomTxt(3), dbid=6354, loadoutid=32488, latitude=lat, longitude=lon, altitude=24384})
    if not balloon then ScenEdit_MsgBox('Balloon cannot be placed') return 0 end
    bL3.RED.UNITS.Balloon = balloon.guid
    for _,x in ipairs({6001,4189}) do
      ScenEdit_UpdateUnit({guid=balloon.guid, mode='add_sensor',arc_detect={'360'},arc_track={'360'}, dbid=x})
    end
    local ballon_area = bL3.AuxFunctions.NewArea({latitude=lat, longitude=lon},{side=side, shape='square', distance=15, relativeTo=bL3.RED.UNITS.C2SHIP})
    local m = ScenEdit_AddMission(bL3.SIDES.RED,'Ballon Support', 'support', {category='package',pool='SAG',zone=ballon_area})
    ScenEdit_AssignUnitToMission(balloon.guid,m.guid)
    local p = ScenEdit_GetReferencePoint({side=bL3.SIDES.RED, name=ballon_area[1]})
    ScenEdit_SetUnit({guid=balloon.guid, latitude=p.latitude, longitude=p.longitude, heading=180})
    ScenEdit_SetEMCON('mission',m.name,'Radar=Active')
    local c2 = SE_SetUnit({guid = bL3.RED.UNITS.C2SHIP, manualSpeed=5})
    local msg = "Added Spy Balloon"
    bL3.NKE.LogAction(side,msg)
  end

end

function bL3.Functions.JammingArea(lat, lon, t_side)
  local side
  if not t_side then side = 'BLUE' else side = t_side end
  local area = bL3.AuxFunctions.NewArea({latitude=lat, longitude=lon},{side="BLUE DECOY", shape='circle', distance=450})
  local distance = Tool_Range({latitude=lat, longitude=lon},{latitude=14.5756, longitude=120.94})
  local power = 110
  local decay = 0.0012
  if distance > 300 then power = power * math.exp(-decay*distance) end
  bL3[side].NKE.JammingArea={area=area, power=power, center={latitude=lat,longitude=lon}}
  gKH.State.SaveTableToKey(bL3[side],side)
  bL3.Functions.JamComms('RED')
end

function bL3.Functions.JamComms(opside)
  if opside == 'BLUE' then
    local area = bL3.AuxFunctions.NewArea({latitude=14.660345, longitude=120.8967},{side="BLUE DECOY", shape='circle', distance=450})
    bL3.RED.NKE.JammingArea={area=area, power=math.random(60,80), center={latitude=14.660345,longitude=120.8967}}
  end
  
  local CJAM_TH = 0.25
  local RESJAM_TH = 0.040
  local mods = 0
  local side = bL3.Functions.GetOpSide(opside)
  local timeToEnd = ScenEdit_CurrentTime() + math.random(120,240) * 60
  local msg = string.format('Communication Jamming activated against %s.End time of effect: %s. ',opside, os.date(bL3.DATEFORMAT, timeToEnd))
  if bL3[side].NKE.NetworkInfiltration then
    local min = math.random(30,60) * 60
    timeToEnd = timeToEnd + min
    msg = msg..string.format('%s Network Infiltration modifier increase the end date of the effect %d minutes. ',side,min/60)
    mods = mods + 0.05
  end
  if bL3[side].NKE.EMAttack then
    local min = math.random(15,35)* 60
    timeToEnd = timeToEnd + min
    msg = msg..string.format('%s Electromagnetic Attack modifier increase the end date of the effect %d minutes. ',side,min/60)
    mods = mods + 0.025
  end
  if bL3[opside].NKE.NetworkResilience then
    local min = math.random(30,60)* 60
    timeToEnd = timeToEnd - min
    msg = msg..string.format('%s Network Resilience modifier reduce the end date of the effect %d minutes. ',opside,min/60)
    mods = mods - 0.015
    RESJAM_TH = RESJAM_TH + 0.003
  end
  if bL3[opside].NKE.EMDefense then
    local min = math.random(15,30)* 60
    timeToEnd = timeToEnd - min
    msg = msg..string.format('%s Electromagnetic-Defense modifier reduce the end date of the effect %d minutes. ',opside,min/60)
    mods = mods - 0.005
    RESJAM_TH = RESJAM_TH + 0.002
  end
  bL3[opside].NKE.CJAM_TH = CJAM_TH
  bL3[opside].NKE.RESJAM_TH = RESJAM_TH
  msg = msg..string.format( ' END DATE: %s', os.date(bL3.DATEFORMAT, timeToEnd))
  bL3.NKE.LogAction(side,msg)

  --Crear un regular event
  bL3.AuxFunctions.RegularEvent('ComJamm '..opside, 4, 'bL3.NKE.CommJamm("'..opside..'")', 'add')

  local date = os.date(bL3.DATEFORMAT , timeToEnd)
  local script = "bL3.AuxFunctions.RemoveEvent('ComJamm "..opside.."');bL3.NKE.EndCommJamm('"..opside.."');bL3.AuxFunctions.RemoveEvent('End ComJamm "..opside.."');bL3.MSG.EndCommJam()"
  bL3.AuxFunctions.TimeEvent('End ComJamm '..opside, date, script,'add',false)
  if side == bL3.SIDES.BLUE then
    ScenEdit_SetSpecialAction({ActionNameOrID='NKE_Communication Jamming',side=side, mode='remove'})
  end
  if opside == 'BLUE' then
    local baseTime = math.random(15,30)
    if bL3[opside].NKE.HUMINT then
      baseTime = baseTime - math.random(5,10)
    end
    local date = os.date(bL3.DATEFORMAT , ScenEdit_CurrentTime() + baseTime*60)
    local script = 'bL3.MSG.RedComJamAttack()'
    bL3.AuxFunctions.TimeEvent('CommJamm-BlueInform '..opside, date,script,'add')
  
  end

  gKH.State.SaveTableToKey(bL3[opside],opside)
  
end

function bL3.Functions.EMAttack(opside)
  local side = bL3.Functions.GetOpSide(opside)
  local msgTH = string.format("Electromagnetic Attack activated against %s. ",opside)
  local msgT = ""
  local timeToEnd = ScenEdit_CurrentTime() + math.random(120,300) * 60
  local threshold = math.random(5,15)/100
  msgTH = msgTH..string.format('Base Threshold: %f. ', threshold)
  if bL3[side].NKE.EMDefense then
    threshold = threshold - math.random(1,3)/100
    msgTH = msgTH..string.format('Threshold modified by %s Electromagnetic-Defense. Threshold: %f. ',side, threshold)
  end
  if bL3[opside].NKE.NetworkResilience then
    local min = math.random(35,60)* 60
    timeToEnd = timeToEnd - min
    msgT = msgT..string.format('%s Network Resilience modifier reduce the end date of the effect %d minutes. ',opside,min/60)
  end
  if bL3[side].NKE.NetworkInfiltration then
    local min = math.random(35,60)* 60
    timeToEnd = timeToEnd + min
    msgT = msgT..string.format('%s Network Infiltration modifier increase the end date of the effect %d minutes. ',side,min/60)
    threshold = threshold + math.random(2,6)/100
    msgTH = msgTH..string.format('Threshold modified by %s Network Infiltration. Threshold: %f. ',side, threshold)
  end
  bL3[opside].NKE.EMTH = threshold
  msgT = msgT..string.format('End time of effect: %s', os.date(bL3.DATEFORMAT, timeToEnd))
  msgTH = msgTH..string.format('Final Threshold: %f ', threshold)
  msgTH = msgTH ..'. '..msgT
  bL3.NKE.LogAction(side,msgTH)

  bL3.AuxFunctions.RegularEvent('EM-Attack '..opside, 5, 'bL3.NKE.EMAttack("'..opside..'")', 'add')
  if side == bL3.SIDES.BLUE then
    ScenEdit_SetSpecialAction({ActionNameOrID='NKE_Activate EM Attack',side=side, mode='remove'})
  end
  local date = os.date(bL3.DATEFORMAT , timeToEnd)
  local script = 'bL3.NKE.EndEMAttack("'..opside..'");bL3.AuxFunctions.RemoveEvent("EM-Attack '..opside..'");bL3.AuxFunctions.RemoveEvent("EM-End '..opside..'");bL3.MSG.EndEM();'
  bL3.AuxFunctions.TimeEvent('EM-End '..opside, date,script,'add')

  --Inform BLUE of EM Attack
  if opside == 'BLUE' then
    local baseTime = math.random(15,30)
    if bL3[opside].NKE.HUMINT then
      baseTime = baseTime - math.random(5,10)
    end
    local date = os.date(bL3.DATEFORMAT , ScenEdit_CurrentTime() + baseTime*60)
    local script = 'bL3.MSG.RedEMAttack()'
    bL3.AuxFunctions.TimeEvent('EM-BlueInform '..opside, date,script,'add')
  
  end
  gKH.State.SaveTableToKey(bL3[opside],opside)
end


--Messages-lua
bL3.MSG={}

bL3.MSG.MailBox = gKH.State.LoadTableFromKey('MAILBOX')
if not bL3.MSG.MailBox then bL3.MSG.MailBox = {} end

bL3.MSG.NotificationTemplate = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notification</title>
    <style>
        body {
            font-family: 'Consolas', monospace;
            background-color: #000;
            color: #00FF00;
            padding: 20px;
            text-transform: uppercase;
            text-align: justify;
            background-image: url('https://i.imgur.com/YLNSuH3.jpeg');
            background-size: cover;
        }
        .monitor-container {
            margin-top: 10vh;
            margin-bottom: 10vh;
        }
        .message-container {
            width: 70%%;
            height: 70%%;
            margin: auto;
            padding: 35px;
            color: #00FF00;
            border: 2px solid #00FF00;
            border-radius: 5px;
            background-color: rgba(31, 31, 31, 0.8);
            font-size: 0.95em;
        }
        .log-entry {
            margin-bottom: 5px;
        }
    </style>
</head>
<body>
    <div class="monitor-container">
        <div class="message-container" id="message-body">
            <p>%s</p>
        </div>
    </div>
    
</body>
</html>]]
bL3.MSG.MAILBOX_TEMPLATE = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mailbox</title>
    <!-- Enlazar DataTables CSS -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #1a1a1a;
            color: #f2f2f2;
            margin: 0;
            padding: 20px;
            display: block;
            font-size: 14px;
        }

        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        /* Sin hyperlink y azul claro para el subject */
        .subject {
            color: #00bfff; /* Azul claro */
        }
        /* Estrechar la columna de la fecha */
        #received {
            padding-bottom: 10px;
            align-items: center;
            max-width: 80vw;
            border-collapse: collapse;
            margin: auto;
            height: 48vh;
            overflow: auto;
        }

        th, td {
            padding: 5px 5px;
            text-align: left;
        }

        th {

            background-color: #333;
            color: #f2f2f2;
            padding: 5px;
        }

        td.date {
            width: 150px; /* Ajuste estrecho para la columna Date */
        }
        /* Efecto hover en filas */
        tr:hover {
            background-color: #242424 !important;  /* Cambio de color al pasar el mouse */
            transition: background-color 0.3s !important;
            cursor: pointer;
        }

        #separator {
          width: 100%%;
          height: 10px;
          background-color: #333;
      }

        .priority-1::before {
            content: "▲";
            color: red;
            margin-right: 8px;

        }

        .priority-2::before {
            content: "▲";
            color: yellow;
            margin-right: 8px;
        }


        .mail-header {
            padding: 10px;
            background-color: #333;
            border-radius: 5px 5px 0 0;
        }

        .mail-header p {
            margin: 5px 0;
        }

        .mail-body {
            padding: 20px;
            background-color: #2a2a2a;
            border-radius: 0 0 5px 5px;
            border-top: 1px solid #444;
            overflow-y: auto;
        }
        /* Ocultar detalles hasta que se seleccione un correo */
        .mail-details {
            display: none;
            margin: auto;
            margin-top: 20px;
            width: 80%%;


        }

        .dataTables_wrapper .dataTables_length,
        .dataTables_wrapper .dataTables_filter,
        .dataTables_wrapper .dataTables_info,
        .dataTables_wrapper .dataTables_paginate {
            color: #f2f2f2;
        }

        .dataTables_wrapper .dataTables_paginate .paginate_button {
            color: #f2f2f2 !important;
            margin-top: auto;
        }

        .dataTables_wrapper .dataTables_filter input {
            background-color: #333;
            color: #f2f2f2;

        }
    </style>
</head>
<body>
<div id="received">
  <table id="mailbox" class="display">
      <thead>
          <tr>
            <th class="date">Date</th>
            <th>From</th>
            <th>Subject</th>
          </tr>
      </thead>
      <tbody>

      </tbody>
  </table>
</div>
<div id="separator"></div>
<!-- Detalles del correo seleccionado -->
<div id="mail-details" class="mail-details">
    <div class="mail-header">
        <p><strong>From:</strong> <span id="mail-from"></span></p>
        <p><strong>To:</strong> <span id="mail-to"></span></p>
        <p><strong>Subject:</strong> <span id="mail-subject"></span></p>
        <p><strong>Date:</strong> <span id="mail-date"></span></p>
    </div>
    <div class="mail-body">
        <p id="mail-message"></p>
    </div>
</div>

<!-- Incluir JQuery y DataTables JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>

<script>
    
    const emails = %s;

    // Referencias a los elementos del DOM
    const mailboxTable = document.getElementById('mailbox').querySelector('tbody');
    const mailDetails = document.getElementById('mail-details');
    const mailSubject = document.getElementById('mail-subject');
    const mailFrom = document.getElementById('mail-from');
    const mailTo = document.getElementById('mail-to');
    const mailDate = document.getElementById('mail-date');
    const mailMessage = document.getElementById('mail-message');

    // Función para mostrar la lista de correos en la tabla
    function loadMails() {
      emails.forEach((email, index) => {
          let subjectContent = email.subject;
          if (email.priority === 1) {
              subjectContent = `<span class="priority-1"></span>` + subjectContent;
          } else if (email.priority === 2) {
              subjectContent = `<span class="priority-2"></span>` + subjectContent;
          }

          const row = document.createElement('tr');
          row.setAttribute('data-index', index); // Asignar índice para identificar fila
          row.innerHTML = `
              <td class="date">${email.date}</td>
              <td class="from">${email.from}</td>
              <td class="subject">${subjectContent}</td>
          `;
          mailboxTable.appendChild(row);

          // Añadir evento de clic a cada fila
          row.addEventListener('click', function() {
              showMailDetails(index);
          });
      });

      // Inicializar DataTables para el ajuste automático de columnas
      $('#mailbox').DataTable({
          paging: true,
          searching: true,
          info: true,
          autoWidth: true,
          lengthChange: false,
          order: %s,
          pageLength: 5,
          
      });
  }

  // Función para mostrar los detalles de un correo
  function showMailDetails(index) {
      const email = emails[index];
      mailSubject.innerText = email.subject;
      mailFrom.innerText = email.from;
      mailTo.innerText = email.to;
      mailDate.innerText = email.date;
      mailMessage.innerHTML = email.message;
      mailDetails.style.display = 'block';
  }

  // Cargar los correos cuando la página se cargue
  document.addEventListener('DOMContentLoaded', loadMails);
</script>

</body>
</html>
]]

--Mail Creation
bL3.MAIL = {}
function bL3.MAIL.NEW(date, from, to, subject, message, priority)
  local mail = {}
  mail.date = date
  mail.from = from
  mail.to = to
  mail.subject = subject
  mail.message = message
  mail.priority = priority or 0
  bL3.MAIL.send(mail)
end

--Send Mail and notifies the user
function bL3.MAIL.send(mail)
  table.insert(bL3.MSG.MailBox, mail)
  gKH.State.SaveTableToKey(bL3.MSG.MailBox, 'MAILBOX')
  bL3.MAIL.ShowMailBox()
end

function bL3.MAIL.ShowMailBox()
  local mailbox = bL3.MSG.MailBox
  local order = '[[0, "desc"]]'
  if #mailbox > 0 then
    local mailJSON = bL3.AuxFunctions.TableToJson(mailbox)
    local html_msg = string.format(bL3.MSG.MAILBOX_TEMPLATE, mailJSON, order)
    ScenEdit_SpecialMessage('BLUE', html_msg)
  end
end

function bL3.MSG.ShowIPB(opside)
  local side = bL3.Functions.GetOpSide(opside)
  local IPB_tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic IPB</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e1e2e;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1200px;
            width: 45%%;
            margin: 20px auto;
            padding: 20px;
            background-color: #2e2e3e;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .subtype {
            margin: 10px 0 5px;
            padding: 5px;
            background-color: #3a3a4a;
            border-radius: 4px;
            font-weight: bold;
        }
        .title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }
        .domain {
            margin-bottom: 20px;
        }
        .domain h2 {
            background-color: #444455;
            padding: 10px;
            border-radius: 4px;
        }
        .domain p {
            margin: 10px 0;
            font-style: italic;
        }
        .unit-list {
            padding: 0;
            margin: 0;
            list-style: none;
        }
        .unit-list li {
            display: flex;
            justify-content: space-between;
            background-color: #333344;
            margin: 5px 0;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        .unit-list li span {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="title">Intelligence Preparation of the Battlefield</div>
        <div class="section">
            <p>
            The People's Liberation Army is expected to employ ballistic missiles (BM), cruise missiles (CM), and conventional strikes to weaken defenses, while a navy amphibious task force prepares for a full-scale amphibious assault in the region. The following table from our MILINT services resume the units expected to take action in the theater.
            </p>
        </div>
        <div id="ipbContent"></div>
    </div>

    <script>
        const ipbData = %s;
        const uTypes = {
              'Facility' : {
                "1001": "None",
                "2001": "Runway",
                "2002": "Runway-Grade Taxiway",
                "2003": "Runway Access Point",
                "3001": "Building (Surface)",
                "3002": "Building (Reveted)",
                "3003": "Building (Bunker)",
                "3004": "Building (Underground)",
                "3005": "Structure (Open)",
                "3006": "Structure (Reveted)",
                "4001": "Underwater",
                "5001": "Mobile Vehicle(s)",
                "5002": "Mobile Personnel",
                "6001": "Aerostat Mooring",
                "9001": "Air Base",
              },
              'Ship' : {
                "2001": "CV",
                "2002": "CVA",
                "2003": "CVB",
                "2004": "CVE",
                "2005": "CVGH",
                "2006": "CVH",
                "2007": "CVL",
                "2008": "CVN",
                "2009": "CVS",
                "2010": "CVS",
                "2011": "AVT",
                "3001": "B",
                "3002": "BB",
                "3003": "BBC",
                "3004": "BBG",
                "3005": "BBH",
                "3006": "BCGN",
                "3007": "BM",
                "3101": "C",
                "3102": "CA",
                "3103": "CAG",
                "3104": "CB",
                "3105": "CBG",
                "3106": "CG",
                "3107": "CGH",
                "3108": "CGN",
                "3109": "CL",
                "3110": "CLAA",
                "3111": "CLC",
                "3112": "CLG",
                "3113": "CLH",
                "3114": "CS",
                "3201": "D",
                "3202": "DD",
                "3203": "DDG",
                "3204": "DDH",
                "3205": "DDK",
                "3206": "DDR",
                "3207": "DE",
                "3208": "DEG",
                "3209": "DER",
                "3210": "DL",
                "3211": "DLG",
                "3212": "DM",
                "3301": "F",
                "3302": "FF",
                "3303": "FFG",
                "3304": "FFL",
                "3305": "PF",
                "3306": "LCS",
                "3307": "OPV",
                "3308": "USV",
                "3401": "PB",
                "3402": "PC",
                "3403": "PC",
                "3404": "PCE",
                "3405": "PCF",
                "3406": "PCFG",
                "3407": "PG",
                "3408": "PG",
                "3409": "PGM",
                "3410": "PH",
                "3411": "PHM",
                "3412": "PHT",
                "3413": "PT",
                "3414": "PTS",
                "3415": "MTB",
                "3416": "WHEC",
                "3417": "WMEC",
                "3418": "WPB",
                "3419": "WPG",
                "3420": "MCDV",
                "4000": "AGF",
                "4001": "AGC",
                "4002": "LCAC",
                "4003": "LCC",
                "4004": "LCM",
                "4005": "LCP",
                "4006": "LCT",
                "4007": "LCU",
                "4008": "LCVP",
                "4009": "LFR",
                "4010": "LHA",
                "4011": "LHD",
                "4012": "LKA",
                "4013": "LPD",
                "4014": "LPH",
                "4015": "LSD",
                "4016": "LSH",
                "4017": "LSL",
                "4018": "LSM",
                "4019": "LSM(R)",
                "4020": "LST",
                "4021": "LSU",
                "4022": "LSV",
                "4023": "LCI",
                "4024": "LSDV",
                "4025": "LCPA",
                "4026": "EPF",
                "4027": "ESD",
                "4028": "ESB",
                "5001": "A",
                "5002": "AD",
                "5003": "AE",
                "5004": "AF",
                "5005": "AFS",
                "5006": "AG",
                "5007": "AGB",
                "5008": "AGF",
                "5009": "AGI",
                "5010": "AGMR",
                "5011": "AGOR",
                "5012": "AGOS",
                "5013": "AGR",
                "5014": "AGS",
                "5015": "AGTR",
                "5016": "AH",
                "5017": "AK",
                "5018": "AKA",
                "5019": "AKE",
                "5020": "AKR",
                "5021": "AKS",
                "5022": "AO",
                "5023": "AOE",
                "5024": "AOL",
                "5025": "AOR",
                "5026": "AOT",
                "5027": "APA",
                "5028": "APD",
                "5029": "AR",
                "5030": "AS",
                "5031": "ATC",
                "5032": "ATA",
                "5033": "ATS",
                "5034": "AV",
                "5035": "AX",
                "5036": "ASR",
                "5037": "AP",
                "5038": "DSV",
                "5039": "AGM",
                "5040": "AD",
                "5101": "T-AGOS",
                "5102": "T-AH",
                "5103": "T-AK",
                "5104": "T-AKE",
                "5105": "T-AKR",
                "5106": "T-AO",
                "5107": "T-AO",
                "5108": "T-MLP",
                "6001": "MCD",
                "6002": "MCM",
                "6003": "MCS",
                "6004": "MHC",
                "6005": "ML",
                "6006": "MSC",
                "6007": "MSF",
                "6008": "MSI",
                "6010": "MSO",
                "6011": "MST",
                "6012": "MHI",
                "6013": "MM",
                "7001": "YAG",
                "7002": "YRT",
                "7003": "YRM",
                "9001": "Civilian",
                "9002": "Merchant",
                "9003": "Platform",
                "9004": "NGS Buoy",
                "9005": "Bottom Fixed Array Sonar",
                "9006": "Moored Sonobuoy",
                "9007": "Special (Land Unit/Satellite)",
                "9008": "Small Watercraft",
                "9011": "Mobile Offshore Base (MOB)"
              },
              'Aircraft' : {
                "1001": "None",
                "2001": "Fighter",
                "2002": "Multirole",
                "2101": "ASAT",
                "2102": "Airborne Laser Platform",
                "3001": "Attack",
                "3002": "Wild Weasel",
                "3101": "Bomber",
                "3401": "BAI/CAS",
                "4001": "EW",
                "4002": "AEW",
                "4003": "ACP",
                "4101": "SAR",
                "4201": "MCM",
                "6001": "ASW",
                "6002": "MPA",
                "7001": "Forward Observer",
                "7002": "Area Surveillance",
                "7003": "Recon",
                "7004": "ELINT",
                "7005": "SIGINT",
                "7101": "Transport",
                "7201": "Cargo",
                "7301": "Commercial",
                "7302": "Civilian",
                "7401": "Utility",
                "7402": "Naval Utility",
                "8001": "Tanker",
                "8101": "Trainer",
                "8102": "Target Towing",
                "8103": "Target Drone",
                "8201": "UAV",
                "8202": "UCAV",
                "8901": "Airship",
                "8902": "Aerostat",
                "8903": "Balloon",
              },
              'Submarine' : {
                "2001": "AGSS",
                "2002": "APSS",
                "2003": "SS",
                "2004": "SSB",
                "2005": "SSBN",
                "2006": "SSG",
                "2007": "SSGN",
                "2008": "SSK",
                "2009": "SSM",
                "2010": "SSN",
                "2011": "SSP",
                "2012": "SSR",
                "2013": "SSRN",
                "3001": "SDV",
                "4001": "ROV",
                "4002": "UUV",
                "4003": "Unmanned Underwater Glider"
              },
              'Ground Unit' : {
                "Infantry": "1000",
                "Infantry_Old": "1001",
                "Marines": "1010",
                "Air_Assault": "1020",
                "Mountain": "1030",
                "Airborne": "1040",
                "Special_Forces": "1100",
                "Combined_Arms": "1500",
                "Armor": "2000",
                "Armor_Recon": "2500",
                "Artillery_Gun": "3000",
                "Artillery_Towed": "3010",
                "Artillery_SP": "3020",
                "Artillery_Rocket_Wheeled": "3110",
                "Artillery_Rocket_Tracked": "3120",
                "Artillery_Mortar": "3200",
                "Artillery_SSM": "4000",
                "AAA": "5000",
                "SAM": "6000",
                "Engineer": "7000",
                "Supply": "8000",
                "Surveillance": "9000",
                "Recon": "10000",
                "Amphibious_Recon": "10010",
                "MechInfantry": "11000",
                "MechMarines": "11010",
                "MechAirborne": "11040",
                "MechWheeled": "11500",
                "Motorized_Infantry": "12000",
                "Anti_Tank": "13000",
                "Radar": "14000",
                "Headquarters": "15000"
              },
              'Satellite' : {
                '1001' : "None",
                '2001' : "IMGSAT",
                '2002' : "RORSAT",
                '2003' : "EORSAT",
                '2004' : "SIGINT",
                '2005' : "ELINT",
                '2006' : "NOSS",
                '2007' : "MASINT",
                '2008' : "Reusable Test Vehicle",
              }
            };
        function generateIPB(data) {
            const ipbContent = document.getElementById('ipbContent');
            ipbContent.innerHTML = '';
            const sortedData = Object.keys(ipbData) // Get all top-level keys
                .sort() // Sort the keys alphabetically
                .reduce((acc, key) => {
                    acc[key] = ipbData[key]; // Reconstruct the object in sorted order
                    return acc;
            }, {});
            for (const domain in sortedData) {
                                const domainContainer = document.createElement('div');
                domainContainer.classList.add('domain');

                const domainTitle = document.createElement('h2');
                domainTitle.textContent = domain;
                domainContainer.appendChild(domainTitle);

                const subtypes = {};

                // Group units by subtype
                for (const unit in data[domain]) {
                    const subtype = data[domain][unit].subtype;
                    if (!subtypes[subtype]) subtypes[subtype] = [];
                    subtypes[subtype].push({ name: unit, ...data[domain][unit] });
                }

                for (const subtype in subtypes) {
                    const subtypeHeader = document.createElement('div');
                    subtypeHeader.classList.add('subtype');
                    subtypeHeader.textContent = uTypes[domain][subtype] || "Unknown Subtype";
                    domainContainer.appendChild(subtypeHeader);

                    const unitList = document.createElement('ul');
                    unitList.classList.add('unit-list');

                    subtypes[subtype].forEach(unit => {
                        const unitItem = document.createElement('li');
                        const unitName = document.createElement('span');
                        unitName.textContent = unit.name;
                        const unitCount = document.createElement('span');
                        unitCount.textContent = unit.num;
                        unitItem.appendChild(unitName);
                        unitItem.appendChild(unitCount)

                        unitItem.addEventListener('click', () => {
                            const selectedObjectType = domain;
                            const selectedObjectID = unit.dbid;
                            window.chrome.webview.postMessage(`DIALOG_OKUI_OpenNewDatabaseWindow("${selectedObjectType}",${selectedObjectID})`);
                        });

                        unitList.appendChild(unitItem);
                    });

                    domainContainer.appendChild(unitList);
                }

                ipbContent.appendChild(domainContainer);
            }
        }

        // Generate the IPB on page load
        generateIPB(ipbData);
    </script>
</body>
</html>
]]
  local data = bL3.Functions.GetOOB(opside)
  local html = string.format(IPB_tmp,bL3.AuxFunctions.TableToJson(data))
  
  ScenEdit_SpecialMessage(side,html)
end

function bL3.MSG.BlueOPORD(setup)
    
	local html_tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>(U) OPORD – Defense of Luzon</title>

<style>
  @import url('https://fonts.googleapis.com/css2?family=Space+Mono:ital,wght@0,400;0,700;1,400;1,700&display=swap');

  /* =====================
     TYPE & PAGE
  ======================*/
  :root{
    --ink:#ffffff;           /* text */
    --paper:#111221;         /* background */
    --grid:#7aabfb;          /* borders */
    --shade:#000111;      /* light panels */
    --shade2:#080E4B;     /* lighter panels */
    --banner:#ffdbdb;        /* classification bar */
    --banner-ink:#1f1c1c;
    --font-family: 'Noto Sans', sans-serif;
    --font-family-monospace: 'Inconsolata', monospace;
  }
  
  html,body{height:100%%}
  body{
    margin:0; padding:20px; background:var(--paper); color:var(--ink);
    font-family: var(--font-family-monospace);
    font-weight: 400;
    font-style: normal;
    font-size: 100%%;
  }
  /* Map containers */
  .map-container {
    width: 100%%;
    height: 400px;
    margin: 15px 0;
    border: 2px solid var(--grid);
    background: var(--shade);
  }

  .map-caption {
    text-align: center;
    font-size: 0.9rem;
    margin-top: 5px;
    margin-bottom: 10px;
    font-style: italic;
    opacity: 0.9;
  }
  .container{max-width:820px;margin:0 auto;background:var(--paper);border:2px solid var(--grid)}
  /* Classification */
  .classification{background:var(--banner);color:var(--banner-ink);text-align:center;padding:6px 8px;font-weight:700;font-size:1.1rem;letter-spacing:3px}
  /* Header */
  .header{padding:18px 20px;border-bottom:2px solid var(--grid);text-align:center}
  .header h1{margin:0 0 10px 0;font-size:1.5rem;text-decoration:underline}
  .header .info{margin:3px 0}
  /* Content */
  .content{padding:18px 20px}
  .section{margin-bottom:26px}
  .section-title{font-weight:700;font-size:1.2rem;margin-bottom:10px;text-decoration:underline}
  .subsection{margin-left:20px;margin-bottom:16px}
  .subsection-title{font-weight:700;margin-bottom:6px}
  .paragraph{margin:7px 0;text-align:justify}
  .indent-1{margin-left:20px}
  .indent-2{margin-left:40px}
  .indent-3{margin-left:60px}
  ul{margin:6px 0 6px 30px}
  li{margin:3px 0}
  /* Callouts */
  .panel{border:1px solid var(--grid);background:var(--shade);padding:8px;margin:10px 0}
  .panel.alt{background:var(--shade2)}
  .mission{font-weight:700;text-align:center;margin:14px 0;padding:10px;border:2px solid var(--grid)}
  /* Tables */
  table{border-collapse:collapse;width:100%%;margin:10px 0}
  th,td{border:1px solid var(--grid);padding:7px 8px;text-align:left;font-size:0.9rem;}
  th{background:var(--banner);font-weight:700; color: var(--banner-ink);}
  /* Utilities */
  .muted{opacity:.9}
  .mono{font-family:"Courier New","Liberation Mono",monospace}
  .page-break{page-break-before:always}
  /* Print */
  @media print{
    body{padding:16px}
    .container{border:none}
    .classification{position:running(header)}
    .classification.bottom{position:running(footer)}
    @page{margin:12mm}
  }
</style>
<!-- Leaflet CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.css" />
</head>
<body>
  <div class="container">
    <div class="classification">(U) UNCLASSIFIED</div>

    <header class="header">
      <h1>(U) OPERATIONS ORDER 25-001</h1>
      <div class="info">DEFENSE OF LUZON</div>
      <div class="info">TASK FORCE STEADFAST SHIELD</div>
      <div class="info"><span id="dtg">241200Z SEP 25</span></div>
    </header>

    <main class="content">
      <!-- 1. SITUATION -->
      <section class="section" id="situation">
        <div class="section-title">(U) 1. SITUATION</div>

        <div class="subsection">
          <div class="subsection-title">1.a. General.</div>
          <div class="paragraph">PRC Amphibious Ready Group (ARG) prepares landings on the western coast of Luzon. Intelligence assesses three possible landing zones along the West Coast. Expect pre‑assault missile and aviation strikes, electronic warfare, and cyber actions designed to degrade C2 and IADS before maritime approach. Coalition will execute layered defense to deny PRC lodgment and preserve Philippine sovereignty.</div>
        </div>

        <div class="subsection">
          <div class="subsection-title">1.b. Area of Operations.</div>
          <div id="map-ao" class="map-container"></div>
          <div class="map-caption">Fig 1. Area of Operations and Area of Interest</div>
          <div class="indent-1">
            <div class="subsection-title">1.b.1. Area of Interest (AOI).</div>
            <div class="paragraph">South China Sea, Luzon Island, western littorals, and adjacent approaches extending 1,000 NM; airspace to FL500. Includes possible attack axes from north and west.</div>
          </div>
          <div class="indent-1">
            <div class="subsection-title">1.b.2. Area of Operations (AO).</div>
            <div class="paragraph">Western Luzon coastal belt out to 500 NM. Priority: three potential landing zones on West Luzon; maritime approach corridors; air corridors supporting ARG operations.</div>
          </div>
        </div>

        <div class="subsection">
          <div class="subsection-title">1.c. Enemy Forces.</div>
          <div class="indent-1">
            <div class="subsection-title">1.c.1. Order of Battle (summary).</div>
            <table class="table">
              <thead>
                <tr>
                  <th>Component</th>
                  <th>Likely Systems</th>
                  <th>Primary Tasks</th>
                  <th>Estimate</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td>PLAAF/PLANAF</td>
                  <td>J‑20, J‑16, J‑15, H‑6K, KJ‑500A, YY‑20A, GJ‑11, WZ‑7/8</td>
                  <td>Air superiority, strike, AEW&C, tanker, ISR/UCAV</td>
                  <td>Fighters+Bombers: <span id="est-air"></span></td>
                </tr>
                <tr>
                  <td>PLAN ARG / Escorts</td>
                  <td>Type 076/071/072A, 052DL, 054A/054, 903A, 093; Z‑18J/F, Z‑9C</td>
                  <td>Amphibious lift, AAW/ASW escort, sea control, RAS</td>
                  <td>Naval Fighters: <span id="est-naval"></span></td>
                </tr>
                <tr>
                  <td>PLARF</td>
                  <td>DF‑17, DF‑27, DF‑3A, CJ‑10, CJ‑100</td>
                  <td>Pre‑assault strikes vs C2, airbases, ports, SAMs</td>
                  <td>TELs/Launchers: <span id="est-missiles"></span></td>
                </tr>
              </tbody>
            </table>

            <div class="indent-1">
              <div class="subsection-title">1.c.2. Courses of Action.</div>
              <div class="indent-2">
                <div class="subsection-title">1.c.2.a. MLCOA.</div>
                <div class="paragraph">PLARF missile saturation degrades IADS and airbases; PLAAF establishes local air superiority; ARG convoy approaches western Luzon; landings at one of three beaches with naval gunfire support.</div>
              </div>
              <div class="indent-2">
                <div class="subsection-title">1.c.2.b. MDCOA.</div>
                <div class="paragraph">Coordinated cyber/EW disrupts C2; simultaneous ballistic, cruise, and aviation strikes enable rapid lodgment across multiple axes, overwhelming Blue defense with dispersed landings.</div>
              </div>
            </div>
          </div>
            <div id="map-threat" class="map-container"></div>
            <div class="map-caption">Fig 2. Estimated RED ARG Approach Route and Landing Zones</div>

        </div>

        <div class="subsection">
          <div class="subsection-title">1.d. Friendly Forces.</div>
          <div class="paragraph">Multi‑national coalition supports Armed Forces of the Philippines. Layered IADS, maritime interdiction, submarine screening, and coastal defense posture focused on western Luzon landing zones. Scenario setup defines platform allocations.</div>
        </div>

        <div class="panel alt">
          <div class="subsection-title">1.e. CCIR.</div>
          <ul>
            <li>PIR: Convoy sortie/ETA to South China Sea; identification of three candidate landing zones; missile launch indications.</li>
            <li>FFIR: IADS degradation &gt;25%%; loss of two primary runways; AEW on‑station &gt; 2 hrs.</li>
          </ul>
        </div>
      </section>

      <!-- 2. MISSION -->
      <section class="section" id="mission">
        <div class="section-title">(U) 2. MISSION</div>
        <div class="mission">Task Force Steadfast Shield defends western Luzon and adjacent South China Sea by denying PLA air/missile superiority, interdicting amphibious lift, and preventing establishment of a hostile beachhead on Luzon.</div>
      </section>

      <!-- 3. EXECUTION -->
      <section class="section" id="execution">
        <div class="section-title">(U) 3. EXECUTION</div>

        <div class="subsection">
          <div class="subsection-title">3.a. Commander’s Intent.</div>
          <div class="paragraph">Purpose: Preserve Philippine sovereignty and coalition freedom of action.</div>
          <div class="paragraph">Method: Early detection; prioritized fires on lift and AAW escorts; maintain sortie generation under IADS; coordinate subsurface and coastal defense to attrit the convoy before landing.</div>
          <div class="paragraph">End State: Amphibious assault defeated; ports and airfields intact; no PLA beachhead established on Luzon.</div>
        </div>

        <div class="subsection">
          <div class="subsection-title">3.b. Concept of Operations.</div>
          <div class="indent-1">
            <div class="subsection-title">Phase 0 – Force Posture (Now–H‑Hour).</div>
            <div class="paragraph">Disperse aircraft; emplace IADS; ready submarines and coastal missiles; establish ISR rings; EMCON and deception active.</div>
          </div>
          <div class="indent-1">
            <div class="subsection-title">Phase 1 – Detect and Fix (H to H+6).</div>
            <div class="paragraph">Continuous ISR to locate ARG convoy and escorts; validate targets; build kill chains; ATO/ACO published.</div>
          </div>
          <div class="indent-1">
            <div class="subsection-title">Phase 2 – Engage and Defeat (H+6 to End).</div>
            <div class="paragraph">Long‑range fires vs ARG lift and escorts; synchronized air/maritime strikes; counter‑landing defense at three designated beaches.</div>
          </div>
        </div>

        <div class="subsection">
          <div class="subsection-title">3.c. Tasks to Subordinate Units.</div>
          <div class="indent-1">
            <div class="subsection-title">3.c.1. Air Component.</div>
            <ul>
              <li>Establish CAPs over western approaches; prosecute TSTs: AEW, tankers, H‑6K.</li>
              <li>SEAD/DEAD vs convoy escorts and coastal SAMs supporting landings.</li>
              <li>Counter‑UAS; classify and destroy GJ‑11, WZ‑7/8 tracks.</li>
            </ul>
          </div>
          <div class="indent-1">
            <div class="subsection-title">3.c.2. Naval Component.</div>
            <ul>
              <li>Submarines interdict ARG along approach corridors; prioritize shots on Type 076/071/072A.</li>
              <li>Surface forces execute SSM raids then retrograde under IADS umbrella.</li>
              <li>ASW screens along western axes; protect coalition logistics.</li>
            </ul>
          </div>
          <div class="indent-1">
            <div class="subsection-title">3.c.3. Missile Defense / IADS.</div>
            <ul>
              <li>Maintain radar coverage; enforce engagement criteria; conserve interceptors for massed raids.</li>
              <li>Rapid runway repair; hardened C2 nodes; deploy decoys.</li>
            </ul>
          </div>
          <div class="indent-1">
            <div class="subsection-title">3.c.4. Coastal Defense.</div>
            <ul>
              <li>Engage ARG lift within coastal belts; coordinate fires with Naval Component.</li>
              <li>Deny beach access at the three identified landing zones; prepare obstacle and interdiction plans.</li>
            </ul>
          </div>
        </div>

        <div class="subsection">
          <div class="subsection-title">3.d. Coordinating Instructions.</div>
          <div class="panel">
            <div class="paragraph">a. Airspace: ACO in effect; deconflict strike/SEAD/tanker corridors.</div>
            <div class="paragraph">b. Comms: primary SATCOM; alt HF; COMSEC per SPINS; brevity mandatory.</div>
            <div class="paragraph">c. Target priorities: 1) Amphibious lift; 2) AAW escorts; 3) Tankers/AEW; 4) Missile TELs.</div>
            <div class="paragraph">d. BDA within 30 minutes of window close; immediate contact/engagement reports.</div>
          </div>
        </div>
      </section>

      <!-- 4. SUSTAINMENT -->
      <section class="section" id="sustainment">
        <div class="section-title">(U) 4. SUSTAINMENT</div>
        <div class="subsection">
          <div class="subsection-title">4.a. Logistics.</div>
          <div class="paragraph">Maintain 96‑hour stocks of fuel, AAM/SSM/SAM, runway repair kits, medical. Coordinate coalition RAS windows under IADS cover; establish FARPs at dispersed strips.</div>
        </div>
        <div class="subsection">
          <div class="subsection-title">4.b. Maintenance.</div>
          <div class="paragraph">Expedite sortie generation; BDAR teams on 2‑hour recall; cannibalization by waiver only.</div>
        </div>
        <div class="subsection">
          <div class="subsection-title">4.c. Personnel.</div>
          <div class="paragraph">Alert posture: air QRA 5/15; SAM crews 15/30. Casualty collection points and MEDEVAC corridors per ACO.</div>
        </div>
      </section>

      <!-- 5. COMMAND AND CONTROL -->
      <section class="section" id="c2">
        <div class="section-title">(U) 5. COMMAND AND CONTROL</div>
        <div class="subsection">
          <div class="subsection-title">5.a. Command.</div>
          <div class="paragraph">Task Force Steadfast Shield Commander exercises OPCON of assigned coalition forces. Command Post: [TBD at setup].</div>
        </div>
        <div class="subsection">
          <div class="subsection-title">5.b. Control.</div>
          <div class="paragraph">C2 via resilient coalition networks with redundant SATCOM/HF fallbacks. Airspace control via ACO; ATO governs air operations.</div>
        </div>
        <div class="subsection">
          <div class="subsection-title">5.c. Succession of Command.</div>
          <div class="paragraph">Deputy TF Commander; then Air Component Commander.</div>
        </div>
      </section>
    </main>

    <div class="classification">(U) UNCLASSIFIED</div>
  </div>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/leaflet.min.js"></script>
  <script>
    // Provide scenario values at integration time. Example:
    // const data = { F: 120, B: 24, NF: 36, BM: 40, CM: 80 };
    const data = %s;

    // Deterministic estimate bands (±20_RUNITERATION) – avoids randomization in repeated runs
    function band(v){ if(typeof v!=="number"||isNaN(v)) return "n/a"; const lo=Math.max(0,Math.floor(v*0.8)); const hi=Math.ceil(v*1.2); return `${lo} - ${hi}`; }

    // Populate OOB estimates
    const airTotal = (data.F||0)+(data.B||0);
    const telTotal = (data.BM||0)+(data.CM||0);
    const navalFtr = (data.NF||0);
    const q = id=>document.getElementById(id);
    q('est-air').textContent     = band(airTotal);
    q('est-missiles').textContent= band(telTotal);
    q('est-naval').textContent   = band(navalFtr);

    // DTG autostamp (UTC). If a literal DTG is prefilled, leave it.
    const dtgEl=document.getElementById('dtg');
    if(dtgEl && /\d{6}Z\s\w{3}\s\d{2}/.test(dtgEl.textContent)===false){
      const d=new Date();
      const map=['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'];
      const Z=d.toISOString().replace(/[-:T]/g,'').slice(8,12)+'Z'; // HHMMZ
      const DD=String(d.getUTCDate()).padStart(2,'0');
      const MMM=map[d.getUTCMonth()];
      const YY=String(d.getUTCFullYear()).slice(-2);
      dtgEl.textContent = `${DD}${Z} ${MMM} ${YY}`;
    }

    // ===== LEAFLET MAPS =====
  
  // Map 1: AO/AOI Overview
  if(document.getElementById('map-ao')) {
    const mapAO = L.map('map-ao').setView([15.5, 120.0], 6);
    
    // Define the default dark theme layer
    const darkTheme = L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap © CARTO'
    }); // Add dark theme as the default layer

    // Define additional tile layers
    const openTopoMap = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
        maxZoom: 17,
        attribution: '© OpenTopoMap'
    });
    const esriWorldTopo = L.tileLayer('https://{s}.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
        attribution: 'Tiles © Esri',
        subdomains: ['server', 'services']
    });  
    // Define Google Satellite layer using Google Mutant plugin
    // Define Esri Satellite layer
    const esriSatellite = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 21,
        attribution: 'Tiles © Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
    }).addTo(mapAO);

    // Create a layer control and add it to the map
    const baseMaps = {
        "Dark Theme": darkTheme,
        "OpenTopoMap": openTopoMap,
        "Satellite": esriSatellite
    };

    L.control.layers(baseMaps).addTo(mapAO);

    // Area of Interest (1000 NM ~ 1850 km radius)
    const aoiCircle = L.circle([15.5, 120.0], {
      color: '#7aabfb',
      fillColor: '#7aabfb',
      fillOpacity: 0.1,
      radius: 1850000,
      weight: 2,
      dashArray: '10, 10'
    }).addTo(mapAO);
    aoiCircle.bindPopup('<b>Area of Interest (AOI)</b><br>1,000 NM radius');

    // Area of Operations (500 NM ~ 925 km)
    const aoCircle = L.circle([15.5, 120.0], {
      color: '#ffdbdb',
      fillColor: '#ffdbdb',
      fillOpacity: 0.15,
      radius: 925000,
      weight: 3
    }).addTo(mapAO);
    aoCircle.bindPopup('<b>Area of Operations (AO)</b><br>500 NM - Western Luzon');

  }

  // Map 2: Threat Route and Landing Zones
  if(document.getElementById('map-threat')) {
  const mapThreat = L.map('map-threat').setView([15.0, 119.8], 6);
  
  const darkTheme = L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
        maxZoom: 19,
        attribution: '© OpenStreetMap © CARTO'
    }); // Add dark theme as the default layer

    // Define additional tile layers
    const openTopoMap = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
        maxZoom: 17,
        attribution: '© OpenTopoMap'
    });
    const esriWorldTopo = L.tileLayer('https://{s}.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}', {
        attribution: 'Tiles © Esri',
        subdomains: ['server', 'services']
    });  
    // Define Google Satellite layer using Google Mutant plugin
    // Define Esri Satellite layer
    const esriSatellite = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
        maxZoom: 21,
        attribution: 'Tiles © Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
    }).addTo(mapThreat);

    // Create a layer control and add it to the map
    const baseMaps = {
        "Dark Theme": darkTheme,
        "OpenTopoMap": openTopoMap,
        "Satellite": esriSatellite
    };

    L.control.layers(baseMaps).addTo(mapThreat);

  // Four potential landing zones on western Luzon coast
  const landingZones = [
    { lat: 16.22019487, lng: 120.220432, name: 'LZ 1', desc: 'Northern sector - Lingayen area' },
    { lat: 14.293601828, lng: 120.503226, name: 'LZ 2', desc: 'Southern sector - Cavite area' },
    { lat: 14.731863565, lng: 120.044487, name: 'LZ 3', desc: 'Central western sector' },
    { lat: 14.04194, lng: 120.580255, name: 'LZ 4', desc: 'Southern sector - Batangas area' }
  ];

  // Create transparent circles with black borders for each LZ
  landingZones.forEach(lz => {
    // Landing zone area (approximately 10km radius for the zone)
    const lzCircle = L.circle([lz.lat, lz.lng], {
      color: '#000000',
      fillColor: '#000000',
      fillOpacity: 0,
      weight: 3,
      radius: 20000, // 10km radius
      opacity: 1
    }).addTo(mapThreat);
    lzCircle.bindPopup(`<b>${lz.name}</b><br>${lz.desc}`);

    // Label for the landing zone
    const labelIcon = L.divIcon({
      className: 'lz-label',
      html: `<div style="background-color:rgba(0,0,0,0.8);color:#fff;padding:4px 8px;border:2px solid #000;border-radius:4px;font-weight:bold;font-size:12px;white-space:nowrap;box-shadow:0 2px 6px rgba(0,0,0,0.5)">${lz.name}</div>`,
      iconSize: [50, 20],
      iconAnchor: [25, -15]
    });

    L.marker([lz.lat, lz.lng], { icon: labelIcon })
      .addTo(mapThreat);
  });

  // RED ARG approach route - adjusted to center on the LZ cluster
  const argRoute = [
    [20.5, 115.0],  // Start: South China Sea staging area
    [18.3, 116],  // Waypoint 1
    [17.3, 116.6],
    [16.5, 117],
  ];

  // Main route line
  const routeLine = L.polyline(argRoute, {
    color: '#ff4444',
    weight: 4,
    opacity: 0.8,
    dashArray: '15, 10'
  }).addTo(mapThreat);
  routeLine.bindPopup('<b>RED ARG Estimated Route</b><br>Primary approach corridor');

  // Branch routes to individual LZs from final waypoint
  landingZones.forEach((lz, idx) => {
    L.polyline([
      [16.5, 117],
      [lz.lat, lz.lng]
    ], {
      color: idx === 0 ? '#ff4444' : '#ff8888',
      weight: idx === 0 ? 3 : 2,
      opacity: idx === 0 ? 0.8 : 0.5,
      dashArray: idx === 0 ? '15, 10' : '5, 10'
    }).addTo(mapThreat).bindPopup(`Branch to ${lz.name}`);
  });

  // Starting position marker
  const startIcon = L.icon({
    iconUrl: 'https://i.imgur.com/1hpYCLj.png',
    iconSize: [35, 35],        // Size of the icon [width, height]
    iconAnchor: [22.5, 22.5],  // Point of the icon which corresponds to marker's location (center)
    popupAnchor: [0, -22.5]    // Point from which the popup should open relative to the iconAnchor
  });

  L.marker([20.5, 115.0], { icon: startIcon })
    .addTo(mapThreat)
    .bindPopup('<b>RED ARG Staging Area</b><br>Estimated start position');
}
  </script>
</body>
</html>]]
    local msg = string.format(html_tmp, bL3.AuxFunctions.TableToJson(setup))
    bL3.BLUE.OPORD = msg
	ScenEdit_SpecialMessage('BLUE',msg)
end
-- if not bL3.RED.ActiveUnits then
-- 	bL3.Functions.BlueOPORD()
-- end
function bL3.MSG.ROE1()

local msg = [[<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>(U) ROE – Defense of Luzon</title>

<style>
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Inter:wght@400;500;600;700&display=swap');

  /* =====================
     MODERN MILITARY THEME
  ======================*/
  :root{
   --ink:#ffffff;           /* text */
    --paper:#111221;         /* background */
    --grid:#7aabfb;          /* borders */
    --shade:#000111;      /* light panels */
    --shade2:#080E4B;     /* lighter panels */
    --banner:#ffdbdb;        /* classification bar */
    --banner-ink:#1f1c1c;
    --font-family: 'Noto Sans', sans-serif;
    --font-family-mono: 'Inconsolata', monospace;
    --accent: #60a5fa;            /* highlights */
    --accent-muted: #3b82f6;      /* muted highlights */
    --success: #22c55e;           /* friendly/positive */
    --warning: #f59e0b;           /* attention */
    --danger: #ef4444;            /* enemy/critical */
    --legal: #8b5cf6;             /* legal/authority */

  }
  
  html, body { height: 100%; margin: 0; padding: 0; }
  body {
    padding: 20px; 
    background: var(--paper);
    color: var(--ink);
    font-family: var(--font-family-mono);
    font-weight: 400;
    font-size: 1rem;
    line-height: 1.5;
  }

  .panel {
    max-width: 850px;
    margin: 0 auto;
    background: var(--paper);
    border: 2px solid var(--grid);
    border-radius: 6px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
    overflow: hidden;
  }

  /* Classification Banner */
  .classification {
    text-align: center;
    padding: 10px 8px;
    font-weight: 700;
    letter-spacing: 3px;
    text-transform: uppercase;
    border-bottom: 2px solid var(--accent);
  }

  /* Header */
  .hdr {
    padding: 24px 20px;
    border-bottom: 2px solid var(--grid-muted);
    text-align: center;
    
  }
  .hdr h2 {
    margin: 0 0 12px 0;
    font-size: 20px;
    font-weight: 700;
    
    text-decoration: underline;
    
    font-family: var(--font-family);
  }
  .hdr .meta {
    margin: 8px 0;
    font-size: 13px;
    color: var(--accent);
    font-weight: 500;
    font-family: var(--font-family);
  }

  /* Content */
  .content {
    padding: 24px 20px;
  }

  .sec {
    margin-bottom: 28px;

    border-radius: 0 6px 6px 0;
    padding: 12px;
    
  }

  .sec-title {
    font-weight: 700;
    font-size: 1.1rem;
    margin-bottom: 12px;
    color: var(--accent);
    font-family: var(--font-family);
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .sec p {
    margin: 8px 0;
    text-align: justify;
    line-height: 1.6;
    color: var(--ink);
  }

  .sec ul {
    margin: 8px 0;
    padding-left: 25px;
  }

  .sec li {
    margin: 6px 0;
    padding-left: 4px;
    line-height: 1.5;
  }

  .sec li::marker {
    color: var(--grid);
  }

  /* Special styling for definitions and key terms */
  .sec li b, .sec p b {
    color: var(--warning);
    font-weight: 600;
  }

  /* Escalation sequence styling */
  .sec:nth-of-type(5) {
    border-left-color: var(--warning);
  }

  .sec:nth-of-type(5) .sec-title {
    color: var(--warning);
  }

  .sec:nth-of-type(5) li b {
    color: var(--warning);
    font-family: var(--font-family-mono);
    font-size: 1.05rem;
  }


  .sec:nth-of-type(6) .sec-title {
    color: var(--danger);
  }

  /* Non-kinetic priority - success color */
  .sec:nth-of-type(7) {
    border-left-color: var(--success);
  }

  .sec:nth-of-type(7) .sec-title {
    color: var(--success);
  }

  /* Authority sections */
  .sec:nth-of-type(2), .sec:nth-of-type(11) {
    border-left-color: var(--legal);
  }

  .sec:nth-of-type(2) .sec-title, .sec:nth-of-type(11) .sec-title {
    color: var(--legal);
  }

  /* Special callout boxes */
  .box {
    margin: 20px 0;
    padding: 16px;
    border-radius: 6px;
    font-family: var(--font-family);
    font-weight: 500;
  }

  .box.note {
    background: linear-gradient(135deg, var(--shade) 0%, var(--shade2) 100%);
    border: 2px solid var(--accent);
    border-left: 6px solid var(--accent);
    color: var(--accent);
  }

  /* Signature block */
  .sig {
    text-align: center;
    margin-top: 20px;
    padding: 12px;
    font-weight: 600;
    color: var(--grid);
    font-family: var(--font-family);
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 1px;
  }

  /* Enhanced lists for better hierarchy */
  .sec ul ul {
    margin-left: 20px;
  }

  .sec ol {
    padding-left: 25px;
    margin: 8px 0;
  }

  .sec ol li {
    margin: 6px 0;
    padding-left: 4px;
  }

  /* Highlight key legal terms */
  .legal-term {
    color: var(--legal);
    font-weight: 600;
  }

  .threat-term {
    color: var(--danger);
    font-weight: 600;
  }

  .procedural-term {
    color: var(--warning);
    font-weight: 600;
  }

  /* Responsive design */
  @media (max-width: 768px) {
    body { padding: 12px; }
    .panel { margin: 0; }
    .content, .hdr { padding: 16px; }
    .sec { padding: 14px; margin-bottom: 20px; }
  }

  /* Print optimizations */
  @media print {
    body { padding: 16px; background: white; color: black; }
    .panel { border: 1px solid black; box-shadow: none; }
    .classification { background: black !important; color: white !important; }
    .sec { border: 1px solid black; background: #f9f9f9; }
    .box.note { background: #f0f0f0; color: black; border: 1px solid black; }
    .hdr { background: #f5f5f5; }
  }
</style>
</head>
<body>
  <div class="panel">
    <div class="classification">(U) UNCLASSIFIED</div>
    
    <div class="hdr">
      <h2>(U) RULES OF ENGAGEMENT (ROE)</h2>
      <div class="meta">(U) DEFENSE OF LUZON — TASK FORCE STEADFAST SHIELD — EFFECTIVE: IMMEDIATE</div>
    </div>

    <div class="content">
      <div class="sec">
        <div class="sec-title">1. Purpose</div>
        <p>(U) Provide clear, enforceable engagement authorities and constraints for coalition forces operating in the South China Sea and western Luzon approaches. Preserve strategic restraint while enabling lawful <span class="legal-term">self-defense</span> and <span class="legal-term">force protection</span>.</p>
      </div>

      <div class="sec">
        <div class="sec-title">2. Authority</div>
        <ul>
          <li>(U) Operational authority for ROE implementation rests with <span class="legal-term">Task Force Commander (TFC)</span>.</li>
          <li>(U) Only TFC or delegated <strong>O-6/JSOTF equivalent</strong> may change ROE in this AO; all changes will be promulgated in writing.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">3. Definitions</div>
        <ul>
          <li>(U) <b>Hostile act.</b> Use of force or demonstrated intent to use force against personnel, platforms, or protected assets.</li>
          <li>(U) <b>Hostile intent.</b> Clear, imminent threat indicating intent to employ force (e.g., targeting acquisition, launch preparation, deliberate closure with weapons trained).</li>
          <li>(U) <b>Self-defense.</b> Use of force to repel or prevent an imminent hostile act or hostile intent against self, assigned forces, or protected civilians/assets.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">4. General Policy</div>
        <ul>
          <li>(U) <strong>Do not initiate offensive action</strong> against Red forces absent explicit higher authorization.</li>
          <li>(U) Use of force is authorized only to: (a) defend own unit, (b) defend designated protected forces/assets, or (c) repel an imminent hostile act consistent with self-defense.</li>
          <li>(U) Maintain strict <span class="procedural-term">EMCON</span> and operational security to reduce escalation risk and avoid unnecessary detection.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">5. Escalation of Response (Sequence)</div>
        <p>(U) Apply the <strong>minimum necessary measures</strong> in sequence, consistent with force protection and mission. Sequence not mandatory in cases of <span class="threat-term">immediate lethal threat</span>.</p>
        <ul>
          <li>(U) <b>1 — Identification.</b> Visually identify contact; display unit markings and flags as required.</li>
          <li>(U) <b>2 — Warning.</b> Issue clear warnings over internationally recognized channels (bridge-to-bridge, guard, radio) and by visual signals when practicable.</li>
          <li>(U) <b>3 — Maneuver / Breakaway.</b> Take defensive maneuvers to avoid contact and de-escalate (increase separation, alter course, local defensive posture).</li>
          <li>(U) <b>4 — Non-kinetic measures.</b> Employ electronic warfare, cyber countermeasures, and non-lethal counter-UAS actions to deny hostile capability or intent.</li>
          <li>(U) <b>5 — Proportionate kinetic force.</b> Authorized when there is a lawful, imminent hostile act or when lesser measures have failed and hostile intent persists.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">6. Engagement Conditions</div>
        <ul>
          <li>(U) <strong>Engage in self-defense only when:</strong> (a) <span class="threat-term">hostile act or clear hostile intent</span> is present, and (b) no reasonable means of avoidance exist.</li>
          <li>(U) Kinetic engagements must be <span class="legal-term">proportional, discriminate</span>, and aimed to neutralize the immediate threat while minimizing collateral risk.</li>
          <li>(U) Weapons systems shall <strong>not acquire or lock on</strong> identified Red assets except when responding to hostile act or hostile intent.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">7. Non-Kinetic Priority</div>
        <p>(U) Prioritize <span class="procedural-term">electronic warfare, cyber measures, intelligence collection, and deception</span> to counter threats without escalating to lethal force. Non-kinetic actions that materially reduce threat are preferred where effective and lawful.</p>
      </div>

      <div class="sec">
        <div class="sec-title">8. Protection of Non-Combatants and Neutral Parties</div>
        <ul>
          <li>(U) Take all feasible precautions to avoid harm to <span class="legal-term">civilians, neutral vessels, and commercial shipping</span>.</li>
          <li>(U) Evade and warn neutral traffic in/through named engagement zones prior to any kinetic action when time and safety permit.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">9. Reporting and Accountability</div>
        <ul>
          <li>(U) <strong>Immediate report required</strong> for any contact, warning fired, non-kinetic suppression, or kinetic engagement. Report format: <span class="procedural-term">Time, Location, Unit, Opponent action, Friendly action, Effects (TLU)</span>.</li>
          <li>(U) All uses of force and deviations from ROE will be documented and routed to TFC <strong>within the hour</strong>.</li>
          <li>(U) Investigations will follow for any deviation from ROE or incidents involving neutral parties.</li>
        </ul>
      </div>

      <div class="sec">
        <div class="sec-title">10. Timing Considerations (For synchronization)</div>
        <ul>
          <li>(U) Alerts, warnings, and de-escalation steps shall be compressed where <span class="threat-term">threat imminence</span> demands; commanders will annotate timeline in contact reports.</li>
          <li>(U) <span class="procedural-term">BDA and contact reports</span>: initial within <strong>30 minutes</strong> of engagement window; updated at established reporting intervals or on significant change.</li>
        </ul>
      </div>

      <div class="sig">
        (U) Task Force Steadfast Shield — Command For Distribution
      </div>
    </div>

    <div class="classification">(U) UNCLASSIFIED</div>
  </div>
</body>
</html>]]
ScenEdit_SpecialMessage('BLUE',msg)

end

function bL3.MSG.ROE2()

local msg = [[<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>(U) ROE – Defense of Luzon</title>

<style>
  @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Inter:wght@400;500;600;700&display=swap');

  /* =====================
     MODERN MILITARY THEME
  ======================*/
  :root{
   --ink:#ffffff;           /* text */
    --paper:#111221;         /* background */
    --grid:#7aabfb;          /* borders */
    --shade:#000111;      /* light panels */
    --shade2:#080E4B;     /* lighter panels */
    --banner:#ffdbdb;        /* classification bar */
    --banner-ink:#1f1c1c;
    --font-family: 'Noto Sans', sans-serif;
    --font-family-mono: 'Inconsolata', monospace;
    --accent: #60a5fa;            /* highlights */
    --accent-muted: #3b82f6;      /* muted highlights */
    --success: #22c55e;           /* friendly/positive */
    --warning: #f59e0b;           /* attention */
    --danger: #ef4444;            /* enemy/critical */
    --legal: #8b5cf6;             /* legal/authority */

  }
  
  html, body { height: 100%; margin: 0; padding: 0; }
  body {
    padding: 20px; 
    background: var(--paper);
    color: var(--ink);
    font-family: var(--font-family-mono);
    font-weight: 400;
    font-size: 1rem;
    line-height: 1.5;
  }

  .panel {
    max-width: 850px;
    margin: 0 auto;
    background: var(--paper);
    border: 2px solid var(--grid);
    border-radius: 6px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.4);
    overflow: hidden;
  }

  /* Classification Banner */
  .classification {
    text-align: center;
    padding: 10px 8px;
    font-weight: 700;
    letter-spacing: 3px;
    text-transform: uppercase;
    border-bottom: 2px solid var(--accent);
  }

  /* Header */
  .hdr {
    padding: 24px 20px;
    border-bottom: 2px solid var(--grid-muted);
    text-align: center;
    
  }
  .hdr h2 {
    margin: 0 0 12px 0;
    font-size: 20px;
    font-weight: 700;
    
    text-decoration: underline;
    
    font-family: var(--font-family);
  }
  .hdr .meta {
    margin: 8px 0;
    font-size: 13px;
    color: var(--accent);
    font-weight: 500;
    font-family: var(--font-family);
  }

  /* Content */
  .content {
    padding: 24px 20px;
  }

  .sec {
    margin-bottom: 28px;

    border-radius: 0 6px 6px 0;
    padding: 12px;
    
  }

  .sec-title {
    font-weight: 700;
    font-size: 1.1rem;
    margin-bottom: 12px;
    color: var(--accent);
    font-family: var(--font-family);
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .sec p {
    margin: 8px 0;
    text-align: justify;
    line-height: 1.6;
    color: var(--ink);
  }

  .sec ul {
    margin: 8px 0;
    padding-left: 25px;
  }

  .sec li {
    margin: 6px 0;
    padding-left: 4px;
    line-height: 1.5;
  }

  .sec li::marker {
    color: var(--grid);
  }

  /* Special styling for definitions and key terms */
  .sec li b, .sec p b {
    color: var(--warning);
    font-weight: 600;
  }

  /* Signature block */
  .sig {
    text-align: center;
    margin-top: 20px;
    padding: 12px;
    font-weight: 600;
    color: var(--grid);
    font-family: var(--font-family);
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 1px;
  }

  /* Enhanced lists for better hierarchy */
  .sec ul ul {
    margin-left: 20px;
  }

  .sec ol {
    padding-left: 25px;
    margin: 8px 0;
  }

  .sec ol li {
    margin: 6px 0;
    padding-left: 4px;
  }

  /* Highlight key legal terms */
  .legal-term {
    color: var(--legal);
    font-weight: 600;
  }

  .threat-term {
    color: var(--danger);
    font-weight: 600;
  }

  .procedural-term {
    color: var(--warning);
    font-weight: 600;
  }

  /* Responsive design */
  @media (max-width: 768px) {
    body { padding: 12px; }
    .panel { margin: 0; }
    .content, .hdr { padding: 16px; }
    .sec { padding: 14px; margin-bottom: 20px; }
  }

  /* Print optimizations */
  @media print {
    body { padding: 16px; background: white; color: black; }
    .panel { border: 1px solid black; box-shadow: none; }
    .classification { background: black !important; color: white !important; }
    .sec { border: 1px solid black; background: #f9f9f9; }
    .box.note { background: #f0f0f0; color: black; border: 1px solid black; }
    .hdr { background: #f5f5f5; }
  }
</style>
</head>
<body>
<body>
    <div class="panel">
        <div class="classification">(U) UNCLASSIFIED</div>
        
        <div class="hdr">
            <h2>(U) RULES OF ENGAGEMENT (ROE)</h2>
            <div class="meta">(U) DEFENSE OF LUZON — TASK FORCE STEADFAST SHIELD — EFFECTIVE: IMMEDIATE</div>
            <p style="font-size: 1.1rem; margin: 10px 0 0 0;"><strong>(U) This document supersedes all previous Rules of Engagement for Task Force Steadfast Shield.</strong></p>
        </div>

        <div class="content">
            <div class="sec">
                <div class="sec-title">1. Purpose</div>
                <p>(U) To provide clear, aggressive, and decisive engagement authorities for coalition forces operating in the South China Sea and western Luzon approaches. These ROE enable full-spectrum combat operations to neutralize and destroy identified People's Liberation Army Navy (PLAN) forces, establish air superiority, ensure maritime dominance, and defend against hostile aggression.</p>
            </div>

            <div class="sec">
                <div class="sec-title">2. Authority</div>
                <ul>
                    <li>(U) Operational authority for ROE implementation rests with <span class="legal-term">Task Force Commander (TFC)</span>.</li>
                    <li>(U) Only TFC or delegated <strong>O-6/JSOTF equivalent</strong> may change ROE in this AO; all changes will be promulgated in writing.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">3. Definitions</div>
                <ul>
                    <li>(U) <b>Hostile Act.</b> Use of force or demonstrated intent to use force against personnel, platforms, or protected assets. <em>(Note: For identified PLAN assets, their presence within the AO is considered a hostile act in support of aggression.)</em></li>
                    <li>(U) <b>Hostile Intent.</b> Clear, imminent threat indicating intent to employ force (e.g., targeting acquisition, launch preparation, deliberate closure with weapons trained). <em>(Note: For identified PLAN assets, hostile intent is presumed upon identification.)</em></li>
                    <li>(U) <b>Self-defense.</b> Use of force to repel or prevent an imminent hostile act or hostile intent against self, assigned forces, or protected civilians/assets.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">4. General Policy</div>
                <ul>
                    <li>(U) <span class="threat-term">All identified People's Liberation Army Navy (PLAN) naval and air assets are hereby declared hostile forces and are legitimate targets for engagement.</span></li>
                    <li>(U) Coalition forces are authorized to use any and all means necessary to neutralize and destroy identified PLAN forces. Full engagement is permitted to achieve air superiority, maritime dominance, and defense against RED aggression.</li>
                    <li>(U) Use of force is authorized to: (a) neutralize and destroy all identified PLAN assets; (b) defend own unit; (c) defend designated protected forces/assets; or (d) repel any hostile act inconsistent with coalition objectives.</li>
                    <li>(U) <strong>Commanders are authorized to initiate offensive action against identified PLAN forces upon positive identification.</strong></li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">5. Key Engagement Principles</div>
                <ul>
                    <li>(U) <b>Engagement Policy.</b> <span class="threat-term">All identified PLAN naval and air assets are legitimate targets. Execute immediate and decisive actions to neutralize and destroy threats.</span></li>
                    <li>(U) <b>Air Superiority.</b> Prioritize the destruction of all identified PLAN air assets (fighters, bombers, and surveillance platforms) to establish and maintain control of the battlespace. <strong>Engage at will.</strong></li>
                    <li>(U) <b>Force Protection.</b> Protect BLUE forces and critical infrastructure using proactive and offensive measures. Preemptively neutralize any identified PLAN threats within operational zones.</li>
                    <li>(U) <b>Maritime Dominance.</b> Target and destroy identified PLAN warships, amphibious vessels, and other vessels directly supporting PLAN operations. Maintain secure maritime routes and chokepoints.</li>
                    <li>(U) <b>Proportionality.</b> While full engagement is authorized against identified PLAN assets, the use of force must remain proportional to the threat posed by the specific asset and aim to avoid unnecessary collateral damage to non-combatant entities.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">6. Engagement Conditions</div>
                <ul>
                    <li>(U) <span class="threat-term">Engage identified PLAN naval and air assets immediately and decisively upon positive identification. No further hostile act or hostile intent beyond identification as a PLAN asset is required.</span></li>
                    <li>(U) Kinetic engagements against PLAN assets shall be <span class="legal-term">proportional, discriminate</span>, and aimed to neutralize and destroy the identified threat.</li>
                    <li>(U) Weapons systems shall acquire and lock on identified PLAN assets consistent with tactical employment and engagement authority.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">7. Integrated Operations</div>
                <ul>
                    <li>(U) Integrate air, land, and naval assets to maximize combat effectiveness and operational success against PLAN forces.</li>
                    <li>(U) Prioritize <span class="procedural-term">intelligence, surveillance, and reconnaissance (ISR)</span> assets to locate, track, and prioritize high-value PLAN targets.</li>
                    <li>(U) Employ <span class="procedural-term">electronic warfare, cyber measures, and deception</span> to enhance kinetic effectiveness and combat success, supporting the objective of neutralizing PLAN forces. Non-kinetic actions support, but do not preclude, lethal force.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">8. Protection of Non-Combatants and Neutral Parties</div>
                <ul>
                    <li>(U) Take all feasible precautions to avoid harm to <span class="legal-term">civilians, neutral vessels, and commercial shipping</span>.</li>
                    <li>(U) Verify targets to ensure no engagement of neutral or civilian entities. Exercise caution in high-traffic zones.</li>
                    <li>(U) Evade and warn neutral traffic in/through named engagement zones prior to any kinetic action when time and safety permit.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">9. Reporting and Accountability</div>
                <ul>
                    <li>(U) <strong>Immediate report required</strong> for any contact, non-kinetic suppression, or kinetic engagement. Report format: <span class="procedural-term">Time, Location, Unit, Opponent action, Friendly action, Effects (TLU)</span>.</li>
                    <li>(U) All uses of force against PLAN assets and deviations from ROE (e.g., engagement of non-PLAN entities) will be documented and routed to TFC <strong>within the hour</strong>.</li>
                    <li>(U) Investigations will follow for any deviation from ROE or incidents involving neutral parties.</li>
                </ul>
            </div>

            <div class="sec">
                <div class="sec-title">10. Timing Considerations (For synchronization)</div>
                <ul>
                    <li>(U) Alerts, warnings, and de-escalation steps shall be compressed where <span class="threat-term">threat imminence</span> demands; commanders will annotate timeline in contact reports.</li>
                    <li>(U) <span class="procedural-term">BDA and contact reports</span>: initial within <strong>30 minutes</strong> of engagement window; updated at established reporting intervals or on significant change.</li>
                </ul>
            </div>

            <div class="sig">
                (U) Task Force Steadfast Shield — Command For Distribution
            </div>
        </div>

        <div class="classification">(U) UNCLASSIFIED</div>
    </div>
</body>



</body>
</html>]]
ScenEdit_SpecialMessage('BLUE',msg)
end

function bL3.MSG.EndCommJam()
  local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'USINDOPACOM-EW Center' 
  local to = 'USINDOPACOM'
  local subject = 'Enemy counter our Communication Jamming'
  local message = [[EW Division reports that the enemy has successfully countered our communications jamming efforts. As a result, the disruption is no longer effective, and enemy communications have likely been restored.

  We advise reassessing the electronic warfare strategy and considering alternative measures to maintain operational advantage]]
  message = message:gsub("\n",'<br>')

  local priority = 2

  bL3.MAIL.NEW(date,from,to,subject,message,priority)

end

function bL3.MSG.EndGPS()
    local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'USPAC-SPACE&CYBER'
  local to = 'USINDOPACOM'
  local subject = 'Enemy counter our Communication Jamming'
  local message = [[Space & Cyber division reports that the enemy has successfully mitigated our GPS jamming and spoofing efforts. As a result, their navigation and targeting systems are no longer disrupted.

We recommend evaluating alternative electronic warfare measures to counteract their regained positioning capabilities.']]
    message = message:gsub("\n",'<br>')

    local priority = 2

    bL3.MAIL.NEW(date,from,to,subject,message,priority)
end

function bL3.MSG.EndEM()
  local tmp = bL3.MSG.NotificationTemplate
  local text = 'It seems that the enemy has been able to adapt against our electromagnetic attack.'
end

function bL3.MSG.RedEMAttack()
    local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
    local from = 'USINDOPACOM-EW Center' 
    local to = 'USINDOPACOM'
    local subject = 'Enemy Electromagnetic Attacks Detected'
    local message = [[EW Division reports that the enemy is employing various forms of electromagnetic attack, disrupting our sensors and increasing the OODA loop of our units. This interference is impacting situational awareness and decision-making speed.

We recommend immediate countermeasures to mitigate the effects and restore operational effectiveness
  
    ]]
    message = message:gsub("\n",'<br>')
  
    local priority = 1
  
    bL3.MAIL.NEW(date,from,to,subject,message,priority)

end

function bL3.MSG.RedComJamAttack()
    local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
    local from = 'USINDOPACOM-EW Center' 
    local to = 'USINDOPACOM'
    local subject = 'Enemy Communication Jamming Detected'
    local message = [[EW Division reports that the enemy is employing various forms of jamming, disrupting our communications. This interference is impacting situational awareness and decision-making speed.

    We recommend immediate countermeasures to mitigate the effects and restore operational effectiveness
  
    ]]
    message = message:gsub("\n",'<br>')
  
    local priority = 1
  
    bL3.MAIL.NEW(date,from,to,subject,message,priority)

end

function bL3.MSG.INTREPTOT()
  local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'USINDOPACOM-J2' 
  local to = 'USINDOPACOM'
  local subject = 'INTREP: Enemy Mission Report'
  local message = [[<h3>INTELLIGENCE REPORT (INTREP)</h3>
<p><strong>Classification:</strong>UNCLASS</p>
<h3>1. Executive Summary</h3>
    <p>Intelligence analysis indicates the People's Liberation Army (PLA) will execute a coordinated effort to degrade our IAMD and A2AD capabilities. Several PLARF batteries have been deployed on the Southern Command and our HUMINT resources indicates that are ready to perform a coordinated attack along with PLAAF and PLAN assets.</p>
    <p><b>IMPORTANT:</b> INTELLIGENCE ESTIMATE THE HOSTILITIES WILL BEGIN at %s </p>
    <h3>2. Enemy Activity</h3>
    <p><b>OCA Operations:</b></p>
    <ul>
        <li>The PLA Air Force (PLAAF) has deployed multirole aircraft to execute OCA missions. These units are tasked with engaging our CAPs at range, leveraging advanced air-to-air missiles (PL-15s) to disrupt our air superiority and create gaps in our defensive posture.</li>
        <li>Unmanned Combat Aerial Vehicles (UCAVs) like the GJ-11 Sharp Sword are being employed for reconnaissance and being used as loyal wigman to the fighters</li>
    </ul>
    <p><b>SEAD Operations:</b></p>
    <ul>
        <li>High-intensity SEAD campaigns can being conducted using Su-30MKK, J-15D and J-16 strike aircraft armed with long-range anti-radiation missiles.</li>
        <li>PLARF is coordinating with PLAAF to launch precision BM strikes against key radar installations and airbase infrastructure to weaken our IAMD network.</li>
        <li>Advanced Electronic Warfare systems are disrupting our command-and-control nodes, aiming to reduce the effectiveness of our integrated response.</li>
    </ul>

    <h3>3. Enemy Intentions</h3>
    <p>The PLA's overarching objective is to degrade our defensive posture and establish air superiority, thereby enabling follow-on operations to neutralize our power projection capabilities in the region. Specific intentions include:</p>
    <ul>
        <li><b>Neutralization of CAPs:</b> OCA operations are aimed at creating airspace dominance by disrupting our fighter patrols and forcing redeployment to secondary airfields.</li>
        <li><b>Disruption of IAMD:</b> SEAD missions combined with precision missile strikes are intended to create blind spots in our air defense systems, exposing critical assets to further strikes.</li>
        <li><b>Degradation of A2AD:</b> A systematic missile campaign targets key A2AD infrastructure, aiming to neutralize our ability to deny PLA access to critical maritime and air corridors.</li>
    </ul>

    <h3>4. Operational Impact</h3>
    <ul>
        <li>Loss of CAP effectiveness may lead to unchallenged PLA air operations over key areas, jeopardizing force survivability and mission effectiveness.</li>
        <li>Significant degradation of IAMD could expose forward-deployed forces to persistent air and missile attacks, reducing the capacity for sustained operations.</li>
        <li>The erosion of A2AD capabilities risks enabling PLA amphibious and airlift operations, creating openings for further territorial incursions.</li>
    </ul>

    <h3>5. Recommendations</h3>
    <ul>
        <li>Reinforce ISR and EW platforms to ensure a good SA in order to react to enemy COA</li>
        <li>Increase CAP rotations and integrate stealth platforms to counter PLA OCA missions.</li>
        <li>Strengthen EW and cyber defenses to maintain command-and-control resilience.</li>
    </ul>

    <h3>6. Conclusion</h3>
    <p>The PLA's coordinated campaign leverages advanced capabilities across air, missile, and electronic warfare domains to systematically degrade our defensive network. Robust countermeasures and adaptive operational strategies are critical to maintaining regional stability and operational effectiveness.</p>

]]
  message = message:gsub("\n",'')
  local Dtime = os.date('!%Y-%m-%dT%H:%M:%SZ', bL3.RED.Dtime + math.random(-360,360)*60)
  message = string.format(message,Dtime)
  local priority = 1

  bL3.MAIL.NEW(date,from,to,subject,message,priority)
end

function bL3.MSG.AMPH1()
  local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'PHILIPPINES HQ' 
  local to = 'USINDOPACOM'
  local subject = 'CRITICAL SITUATION'
  local message= [[<p>We are on a critical situation. The PLA Amphibious group is close to the coasts of Luzon ready to commence the assault on the beaches.</p>]]
  local priority = 1
  bL3.MAIL.NEW(date,from,to,subject,message,priority)
end
function bL3.MSG.AMPH2()
    local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
    local from = 'PHILIPPINES HQ' 
    local to = 'USINDOPACOM'
    local subject = 'PLA REACHED BEACH'
    local message= [[<p>PLA have reached the beach and have started preparing for landing their troops in our beaches.</p>]]
    local priority = 1
    bL3.MAIL.NEW(date,from,to,subject,message,priority)
  end
  
function bL3.MSG.Logistics()
  local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'USINDOPACOM-J3' 
  local to = 'U.S Pacific Air Forces'
  local subject = 'Logistics readiness'
  local message= [[<p><b>Commander</b>,<BR><BR>In support of ongoing operations, the Joint Logistics Team has implemented measures to expedite aircraft readiness timelines. Units intending to benefit from these accelerated cycles must finalize and submit their desired loadout configurations for all assigned airframes no later than 12MAR 010000Z.</p><p>This deadline ensures the logistics pipeline can process and prepare assets efficiently, delivering maximum operational flexibility for immediate tasking. Loadouts set after this time will default to standard readiness protocols, which may result in longer preparation times.</p><p>Given the fluidity of the current conflict, this is a critical opportunity to enhance combat responsiveness. Ensure your logistics and operations teams coordinate to meet the deadline.</p><p><b>Action</b>: Confirm compliance through your respective operations channels and report readiness status NLT 12MAR 010000Z<BR><BR>Let’s maintain the tempo.</p><p><b style="display: flex; justify-content: center;">J3 Logistics & Engineering</b></p>]]
  local priority = 2
  bL3.MAIL.NEW(date,from,to,subject,message,priority)

end

function bL3.MSG.LostUAV()
	local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'USINDOPACOM-J2' 
  local to = 'USINDOPACOM'
  local subject = 'Lost UAV Jamming Station'
  local message = [[<p><b>Commander</b>,<BR><BR>Enemy has destroyed the Jamming UAV Station so we have lost the ability to JAM enemy UAVs.</p><p><b style="display: flex; justify-content: center;">J2 Operations</b></p>]]
	message = string.format(message,date)
  local priority = 1
  bL3.MAIL.NEW(date,from,to,subject,message,priority)
end

function bL3.MSG.HUMINT1()
  local date = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  local from = 'CIA #USINDO' 
  local to = 'USINDOPACOM'
  local subject = 'HUMINT Advisory'
  local message = [[<h5>TS</h5>
  <h3>HUMINT Advisory</h3>
<p><b>Attention:</b> Recent intelligence reports from multiple reliable sources indicate that the People’s Liberation Army Navy (PLAN) has deployed merchant vessels in the area that are disguising themselves as civilian ships. These vessels are equipped with electronic support measure (ESM) antennas and other systems designed for intelligence gathering.</p>
<p><b>Advisory:</b> Exercise extreme caution with your <b>Emission Control (EMCON)</b> protocols. Limit unnecessary electronic emissions and maintain strict operational security to avoid detection and compromise.</p>
<p>Remain vigilant, and report any suspicious activity through your secure communication channels.</p>
]]
  message = message:gsub("\n",'')
	
  local priority = 1
  bL3.MAIL.NEW(date,from,to,subject,message,priority)

end

--UnitKilled-lua


bL3.BLUETARGETS = {
  ["D2IH5S-0HN3KBFHJ8J6N"]={name="PHILIPINES MARINE CORP HEADQUARTERS", points=25},
  ["D2IH5S-0HN3KBFHJ8B2B"]={name="PHILIPPINES NAVY HEADQUARTERS", points=25},
  ["D2IH5S-0HN3KBFHJ87DD"]={name="PHILIPPINES AIR FORCE HEADQUARTERS", points=25},
  ["D2IH5S-0HN3KBFHJ84G8"]={name="AIR DEFENSE COMMAND HEADQUARTERS", points=25},
  ["D2IH5S-0HN3KBFHJ7VD5"]={name="Malacañang Palace (Presidential Palace", points=20},
  ["D2IH5S-0HN3KBFHJ7M6J"]={name="ARMY HEADQUARTERS PHILIPPINES", points=25},
  ["D2IH5S-0HN3KBFHJ61UI"]={name="Building (Uplink Relay Station) A", points=15},
  ["D2IH5S-0HN3KBFHJ5G7A"]={name="Structure (Power Station - Coal)", points=15},
  ["D2IH5S-0HN3KBFHJ5BMA"]={name="Building (Uplink Relay Station) C", points=15},
  ["D2IH5S-0HN3KBFHJ5QFA"]={name="Building (Uplink Relay Station) B", points=15},
  ["D2IH5S-0HN3KBFHJ5915"]={name="Structure (Power Station - Gas)", points=15},
}
bL3.REDUNITS = { 
  [4608] = { points = 0, dbid = 4608, name = 'Type 815G Dongdiao II [853 Tianwangxing]' }, 
  [4225] = { points = 3, dbid = 4225, name = 'J-16 Flying Shark [Su-30MKK Copy]' },
  [3586] = { points = 12, dbid = 3586, name = 'Type 052DL Luyang III Mod [156 Zibo]' }, 
  [7171] = { points = 1, dbid = 7171, name = 'WZ-7 Soaring Dragon UAV' },
  [4933] = { points = 1, dbid = 4933, name = 'Z-20F' }, 
  [776] = { points = 15, dbid = 776, name = 'Type 093 Shang I' },
  [4876] = { points = 25, dbid = 4876, name = 'Type 076' }, 
  [3727] = { points = 2, dbid = 3727, name = 'Il-78M Midas' },
  [6098] = { points = 3, dbid = 6098, name = 'J-15B Flying Shark [Su-33 Copy]' }, 
  [2005] = { points = 0, dbid = 2005, name = 'Type 920 Anwei [866 Daishan Dao]' },
  [5014] = { points = 5, dbid = 5014, name = 'J-20A Fagin' }, 
  [2714] = { points = 8, dbid = 2714, name = 'Type 054A Jiangkai II [599 Anyang]' },
  [413] = { points = 0, dbid = 413, name = 'Tianhui' }, 
  [7134] = { points = 4, dbid = 7134, name = 'H-6K Badger' },
  [7135] = { points = 4, dbid = 7135, name = 'H-6K Badger' }, 
  [3617] = { points = 8, dbid = 3617, name = 'Type 054 Jiangkai I [525 Manshan]' },
  [4962] = { points = 1, dbid = 4962, name = 'GJ-11 Sharp Sword UCAV' },
  [4963] = { points = 1, dbid = 4963, name = 'GJ-11 Sharp Sword UCAV' },
  [7203] = { points = 3, dbid = 7203, name = 'Su-30MKK Flanker G' },
  [676] = { points = 8, dbid = 676, name = 'Type 095 Sui' }, 
  [4837] = { points = 5, dbid = 4837, name = 'H-6N Badger' },
  [3883] = { points = 20, dbid = 3883, name = 'Type 055 Renhai [101 Nanchang]' }, 
  [133] = { points = 0, dbid = 133, name = 'LKW' },
  [432] = { points = 0, dbid = 432, name = 'Wenchang-1' }, 
  [2927] = { points = 0, dbid = 2927, name = 'Type 903A Fuchi [889 Taihu]' },
  [4656] = { points = 0, dbid = 4656, name = 'Type 048 Daguan [88 Xu Xiake]' }, 
  [4719] = { points = 12, dbid = 4719, name = 'Type 052DL Luyang III Mod [125 Cangzhou]' },
  [6642] = { points = 0, dbid = 6642, name = 'WZ-8' }, 
  [2463] = { points = 4, dbid = 2463, name = 'J-20B Fagin' }, 
  [6004] = { points = 6, dbid = 6004, name = 'KJ-500A Cub [GX9]' },
  [7349] = { points = 1, dbid = 7349, name = 'Z-9DF Haitun' }, 
  [5854] = { points = 1, dbid = 5854, name = 'Z-9C Haitun [AS.565SA]' },
  [6450] = { points = 3, dbid = 6450, name = 'J-16 Flying Shark [Su-30MKK Copy]' }, 
  [4600] = { points = 0, dbid = 4600, name = 'Type 072 Yantai' },
  [2006] = { points = 0, dbid = 2006, name = 'Type 071 Yuzhao [998 Kunlun Shan]' }, 
  [4602] = { points = 0, dbid = 4602, name = 'Type 072A Yuting II [981 Dabie Shan]' },
  [4596] = { points = 8, dbid = 4596, name = 'Type 056A Jiangdao II [625 Bazhong]' }, 
  [4722] = { points = 8, dbid = 4722, name = 'Type 056A Jiangdao II [625 Bazhong]' },
  [7357] = { points = 1, dbid = 7357, name = 'Z-18J Bat' }, 
  [4975] = { points = 2, dbid = 4975, name = 'YY-20A Kunpeng' },
  [7359] = { points = 1, dbid = 7359, name = 'Z-18F Sea Eagle' } }
bL3.BLUEUNITS = {
  [4771]={name='F-15EX', points=3, type='AIR FIGHTERS'},
  [2100]={name='SBX', points=0, type='RADAR'},
  [5338]={name='MH-60R', points=1, type='HELICOPTER'},
  [153]={name='SIGINT', points=0, type='RADAR'},
  [4612]={name='F-16CM', points=1, type='AIR FIGHTERS'},
  [3835]={name='F-35A', points=4, type='AIR FIGHTERS'},
  [4879]={name='EA-18G', points=2, type='AIR FIGHTERS'},
  [4875]={name='F-22', points=5, type='AIR FIGHTERS'},
  [4919]={name='F-15C', points=1, type='AIR FIGHTERS'},
  [4701]={name='F-35B', points=4, type='AIR FIGHTERS'},
  [6905]={name='FA-50', points=1, type='AIR FIGHTERS'},
  [2506]={name='Patriot PAC-2+/PAC-3', points=2, type='SAM'},
  [3215]={name='THAAD', points=10, type='SAM'},
  [3222]={name='NASAMS', points=1, type='SAM'},
  [2718]={name='DDG FIII', points=30, type='SHIP'},
  [4645]={name='FF 06', points=15, type='SHIP'},
  [5436]={name='E-7', points=4, type='AIR SUPPORT'},
  [3853]={name='E-3G', points=2, type='AIR SUPPORT'},
  [4328]={name='RQ-180', points=4, type='AIR SUPPORT'},
  [6620]={name='KC-46A', points=1, type='AIR SUPPORT'},
  [5877]={name='RC-135S', points=4, type='AIR SUPPORT'},
  [5759]={name='P-8', points=4, type='AIR SUPPORT'},
  [4883]={name='EA-37', points=5, type='AIR SUPPORT'},
  [4893]={name='B-52', points=2, type='AIR SUPPORT'},
  [962]={name='FPS-117', points=1, type='RADAR'},
  [4289]={name='TPY-4', points=2, type='RADAR'},
  [4034]={name='ELM-2288ER AD-STAR', points=1, type='RADAR'},
  [2249]={name='TPS-80', points=1, type='RADAR'},
  [3656]={name='FPS-3ME', points=2, type='RADAR'},
  [3288]={name='Typhon', points=4, type='LRF'},
  [3380]={name='HIMARS (PrSM-1)', points=2, type='LRF'},
  [3860]={name='SSM NSM', points=1, type='LRF'},
  [3427]={name='SSM PJ-10', points=1, type='LRF'},
  [567]={name='SSN Seawolf', points=40, type='SUBMARINE'},
  [554]={name='SSN Virginia', points=35, type='SUBMARINE'},
}
bL3.KILLS = gKH.State.LoadTableFromKey('KILLS')


bL3.SCORE = gKH.State.LoadTableFromKey('SCORE')

if not bL3.SCORE then

  bL3.SCORE = {}
  bL3.SCORE.RED = 0
  bL3.SCORE.BLUE = 0
  
  bL3.SCORE.LOG = {RED={},BLUE={}}

end

if not bL3.KILLS then
  bL3.KILLS = {}
  bL3.KILLS.RED = {}
  bL3.KILLS.BLUE = {}
end
function bL3.Functions.UnitKilled()

  local unit = UnitX()
  local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
  if not unit or unit.type == 'Weapon' then return 0 end

  if unit.side == "BLUE" then
    local row = {unit_name=unit.name, unit_guid=unit.guid, classname=unit.classname, lat=unit.latitude, lon=unit.longitude, type=unit.type, subtype=unit.subtype}
    table.insert(bL3.KILLS.BLUE,row)
    local blueTargets = bL3.BLUETARGETS
    
    if blueTargets[unit.guid] then
      
      local msg = string.format('[%s] - %s strategic target destroyed.',time,unit.name)

      table.insert(bL3.SCORE.LOG.RED,msg)

      local msg = string.format('[%s] - %s strategic target destroyed.',time,unit.name)

      table.insert(bL3.SCORE.LOG.BLUE,msg)
      
      goto saveKeys
    end

    if bL3.BLUE.ActiveUnits[unit.guid] then
      bL3.BLUE.ActiveUnits[unit.guid] = nil
      gKH.State.SaveTableToKey(bL3.BLUE,'BLUE')
    end
    local blueAU = bL3.BLUEUNITS
    local blueUnit = blueAU[unit.dbid]
    if blueUnit then
      
      local msg = string.format('[%s] - %s destroyed.',time,unit.classname)
      table.insert(bL3.SCORE.LOG.BLUE,msg)
      
      if unit.type == 'Aircraft' then
        local current_aircrafts = #VP_GetSide({side='BLUE'}):unitsBy('Aircraft')
        local ratio = current_aircrafts / bL3.BLUE.TOTAL_AIR
        if ratio < 0.25 and not bL3.BLUE.ATTR25 then
          bL3.BLUE.ATTR25 = true
          
          local msg = string.format('[%s] - BLUE AIR ATTRITION OVER 75%.',time)
          table.insert(bL3.SCORE.LOG.BLUE,msg)
          bL3.Functions.EndScenario()
        elseif ratio < 0.50 and not bL3.BLUE.ATTR50 then
          bL3.BLUE.ATTR50 = true
          
          local msg = string.format('[%s] - BLUE AIR ATTRITION OVER 50%.',time)
          table.insert(bL3.SCORE.LOG.BLUE,msg)
        elseif ratio < 0.75 and not bL3.BLUE.ATTR75 then
          bL3.BLUE.ATTR75 = true
          
          local msg = string.format('[%s] - BLUE AIR ATTRITION OVER 25%.',time)
          table.insert(bL3.SCORE.LOG.BLUE,msg)
        end

        bL3.BLUE.ATTRITION.Aircraft.CURRENT = bL3.BLUE.ATTRITION.Aircraft.CURRENT - blueUnit.points
      elseif unit.type == 'Ship' then
        bL3.SCORE.BLUE = bL3.SCORE.BLUE - 15
        bL3.BLUE.ATTRITION.Sea.CURRENT = bL3.BLUE.ATTRITION.Sea.CURRENT - blueUnit.points
      elseif unit.type == 'Submarine' then
        bL3.BLUE.ATTRITION.Sea.CURRENT = bL3.BLUE.ATTRITION.Sea.CURRENT - blueUnit.points
        bL3.SCORE.BLUE = bL3.SCORE.BLUE - 15
        if bL3.RED.SAGASW then
          bL3.AuxFunctions.RemoveEvent('End ASWMode')
          bL3.RED.SAGASW = false
          gKH.State.SaveTableToKey(bL3.RED,'RED')
        end
      elseif unit.type == 'Facility' then
        bL3.BLUE.ATTRITION.Land.CURRENT = bL3.BLUE.ATTRITION.Land.CURRENT - blueUnit.points
      end
      
      goto saveKeys
    end
      

    if unit.dbid == 615 then
      bL3.AuxFunctions.RemoveEvent('Hack UAV RED')
      bL3.MSG.LostUAV()
      goto saveKeys
    end

  elseif unit.side == "RED" then
    local row = {unit_name=unit.name, unit_guid=unit.guid, classname=unit.classname, lat=unit.latitude, lon=unit.longitude, type=unit.type, subtype=unit.subtype}
    table.insert(bL3.KILLS.RED,row)
    local redAU = bL3.REDUNITS[unit.dbid]
    local points 
    if not redAU then print("UNIT: "..unit.classname..' not in REDUNITS') points = 0 else
      points = redAU.points
    end

    if unit.type == 'Ship' then
      if ScenEdit_CurrentTime() < bL3.BLUE.ROETIME then
          local msg = string.format('[%s] - BLUE DOES NOT FOLLOW THE ROE. BLUE LOSES %d POINTS.',time,unit.name,100)
          table.insert(bL3.SCORE.LOG.BLUE,msg)
          local t = os.date(bL3.DATEFORMAT,ScenEdit_CurrentTime() + math.random(5)*60 )
          bL3.AuxFunctions.TimeEvent('EndScenario', t, 'bL3.Functions.EndScenario(5)','add')
          goto saveKeys
      end
      
      bL3.RED.ATTRITION.Sea.CURRENT = bL3.RED.ATTRITION.Sea.CURRENT - points
      local scap = ScenEdit_GetMission('RED','SAG SUPPORT #CAP')
      if scap and not scap.isactive then
        ScenEdit_SetMission('RED',scap.guid,{isactive=true})
        ScenEdit_SetMission('RED',scap.guid,{OneThirdRule=false})
        ScenEdit_SetMission('RED','#AAR SAG',{OnStation=6})
      elseif scap and scap.isactive then
        ScenEdit_SetMission('RED',scap.guid,{OneThirdRule=false})
        ScenEdit_SetMission('RED','#AAR SAG',{OnStation=6})
      end

      if string.find(unit.name, 'AMPH') then

        local msg = string.format('[%s] - %s sinked.',time,unit.classname)
        table.insert(bL3.SCORE.LOG.RED,msg)
        bL3.RED.AMPH = bL3.RED.AMPH - 1
        gKH.State.SaveTableToKey(bL3.RED,'RED')
        if bL3.RED.AMPH <= 2 then
          bL3.Functions.REDEndsScenario()
        end
        goto saveKeys
      elseif string.find(unit.name,'C2 Center') then
        local msg = string.format('[%s] - %s sinked.',time,unit.classname)
        table.insert(bL3.SCORE.LOG.RED,msg)
        bL3.Functions.AmphWithDrawal()
        local namph = bL3.RED.AMPH
        if namph <= 3 then
          bL3.Functions.REDEndsScenario()
        end
      elseif string.find(unit.name, 'Escort') then
        local nAAEWSC = bL3.Functions.GetNAAWESC()
        if nAAEWSC < 1 then
          bL3.Functions.AmphWithDrawal()
        end
        local msg = string.format('[%s] - %s destroyed.',time,unit.classname)
        table.insert(bL3.SCORE.LOG.RED,msg)
      end
    elseif unit.type == 'Aircraft' then
      bL3.RED.ATTRITION.Aircraft.CURRENT = bL3.RED.ATTRITION.Aircraft.CURRENT - points
      if unit.mission and string.match(unit.mission.name, '#SIG') then
        local area= unit.mission.supportmission.Zone
        for _,p in ipairs(area) do
          local rp = ScenEdit_GetReferencePoint({side='RED', name=p.name})
          if rp then
            ScenEdit_SetReferencePoint({side='RED', name=p.name, latitude=rp.latitude, longitude = rp.longitude - 0.35})  
          end
        end
      end
    elseif unit.type == 'Submarine' then
      bL3.RED.ATTRITION.Sea.CURRENT = bL3.RED.ATTRITION.Sea.CURRENT - points
      local msg = string.format('[%s] - %s destroyed.D2IH5S',time,unit.name,15)
      table.insert(bL3.SCORE.LOG.RED,msg)
      
      
    end

  end
  ::saveKeys::
  gKH.State.SaveTableToKey(bL3.SCORE,'SCORE')
  gKH.State.SaveTableToKey(bL3.KILLS,'KILLS')
  gKH.State.SaveTableToKey(bL3.BLUE,'BLUE')
  gKH.State.SaveTableToKey(bL3.RED,'RED')
end

function bL3.Functions.BlueFacilityUnitDamaged()
  local unit = UnitX()
  if unit and unit.group and unit.group.type == 'AirBase' then
    local group_name = unit.group.name
    local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime())
    bL3.SCORE.BLUE = bL3.SCORE.BLUE - 5
    local msg = string.format('[%s] - %s from AirBase: %s Damaged',time,unit.name,group_name)
    table.insert(bL3.SCORE.LOG.BLUE,msg)
    msg = string.format('[%s] - %s from AirBase: %s Damaged',time,unit.name,group_name)
    table.insert(bL3.SCORE.LOG.RED,msg)
  end

  gKH.State.SaveTableToKey(bL3.SCORE,'SCORE')
end

function bL3.Functions.RedShipUnitDamaged()
  if ScenEdit_CurrentTime() < bL3.BLUE.ROETIME then
    
    local msg = string.format('[%s] - BLUE DO NOT FOLLOW THE ROE. BLUE LOSES %d POINTS.',time,unit.name,100)
    table.insert(bL3.SCORE.LOG.BLUE,msg)
    local t = os.date(bL3.DATEFORMAT,ScenEdit_CurrentTime() + math.random(5)*60 )
    bL3.AuxFunctions.TimeEvent('EndScenario', t, 'bL3.Functions.EndScenario(5)','add')
    return 0
  else
    local scap = ScenEdit_GetMission('RED','SAG SUPPORT #CAP')
    if scap and not scap.isactive then
      ScenEdit_SetMission('RED',scap.guid,{isactive=true})
      ScenEdit_SetMission('RED',scap.guid,{OneThirdRule=false})
      ScenEdit_SetMission('RED',scap.guid,{OneStation=4})
      ScenEdit_SetMission('RED','#AAR SAG',{OnStation=2})
    end
  end
end


function bL3.Functions.UnitKillComparison()
  local tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unit Loss Comparison</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<!-- Add Bootstrap JS and dependencies -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <style>
        body {
            background-color: #121212;
            color: #ffffff;
            font-family: Arial, sans-serif;
        }
        .chart-container {
            width: 80%%;
            margin: 20px auto;
        }
        
        canvas {
            background-color: #1e1e1e;
            border-radius: 8px;
            padding: 50px;
            margin-top: 10px;
            font-size:1.1rem;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="chart-container">
        <canvas id="lossesByType"></canvas>
    </div>
    <!-- Add Bootstrap Tabs -->
     <div class="chart-container">
    <ul class="nav nav-tabs" id="chartTabs" role="tablist">
        <li class="nav-item">
            <a class="nav-link active" id="red-tab" data-toggle="tab" href="#redCharts" role="tab" aria-controls="redCharts" aria-selected="true">Red Charts</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" id="blue-tab" data-toggle="tab" href="#blueCharts" role="tab" aria-controls="blueCharts" aria-selected="false">Blue Charts</a>
        </li>
    </ul>

    <div class="tab-content" id="chartTabsContent">
        <div class="tab-pane fade show active" id="redCharts" role="tabpanel" aria-labelledby="red-tab" class="chart-container"></div>
        <div class="tab-pane fade" id="blueCharts" role="tabpanel" aria-labelledby="blue-tab" class="chart-container"></div>
    </div>
    </div>
    <script>
        const data = %s;

        function processLossesByType() {
            // Ensure RED and BLUE data are valid arrays
            const redDataArray = Array.isArray(data.RED) ? data.RED : [];
            const blueDataArray = Array.isArray(data.BLUE) ? data.BLUE : [];

            // Process RED losses
            const redLosses = redDataArray.reduce((acc, unit) => {
                acc[unit.type] = (acc[unit.type] || 0) + 1;
                return acc;
            }, {});

            // Process BLUE losses
            const blueLosses = blueDataArray.reduce((acc, unit) => {
                acc[unit.type] = (acc[unit.type] || 0) + 1;
                return acc;
            }, {});

            // Create unified labels from both datasets
            const labels = [...new Set([...Object.keys(redLosses), ...Object.keys(blueLosses)])];

            // Align both datasets with the labels
            const redData = labels.map(label => redLosses[label] || 0);
            const blueData = labels.map(label => blueLosses[label] || 0);

            return {
                labels,
                red: redData,
                blue: blueData
            };
        }

        const lossesByTypeData = processLossesByType();
        new Chart(document.getElementById('lossesByType'), {
            type: 'bar',
            data: {
                labels: lossesByTypeData.labels,
                datasets: [
                    {
                        label: 'BLUE Losses',
                        data: lossesByTypeData.blue,
                        backgroundColor: 'rgba(54, 162, 235, 0.5)',
                        borderColor: 'rgb(54, 162, 235)',
                        borderWidth: 1
                    },
                    {
                        label: 'RED Losses',
                        data: lossesByTypeData.red,
                        backgroundColor: 'rgba(255, 99, 132, 0.5)',
                        borderColor: 'rgb(255, 99, 132)',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                indexAxis: 'y',
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Losses by Type',
                        color: '#ffffff'
                    },
                    legend: {
                        labels: { color: '#ffffff' }
                    }
                },
                scales: {
                    x: {
                        beginAtZero: true,
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: { color: '#ffffff' }
                    },
                    y: {
                        grid: {
                            color: 'rgba(255, 255, 255, 0.1)'
                        },
                        ticks: { color: '#ffffff',font: {
                                        size: 18, // Adjust the font size here
                                    }, }
                    }
                }
            }
        });

        function getUniqueTypes(side) {
            return [...new Set(data[side].map(unit => unit.type))];
        }
        function createLossesByClassnameChart(side, type, containerId) {
            const filteredData = data[side].filter(unit => unit.type === type);
            const groupedData = filteredData.reduce((acc, unit) => {
                acc[unit.classname] = (acc[unit.classname] || 0) + 1;
                return acc;
            }, {});

            const canvas = document.createElement('canvas');
            canvas.width = 1365; // Match RED width
            canvas.height = 682; // Match RED height
            document.getElementById(containerId).appendChild(canvas);

            new Chart(canvas, {
                type: 'bar',
                data: {
                    labels: Object.keys(groupedData),
                    datasets: [{
                        label: `${side} ${type} Losses`,
                        data: Object.values(groupedData),
                        backgroundColor: side === 'RED' ? 'rgba(255, 99, 132, 0.5)' : 'rgba(54, 162, 235, 0.5)',
                        borderColor: side === 'RED' ? 'rgb(255, 99, 132)' : 'rgb(54, 162, 235)',
                        borderWidth: 1
                    }]
                },
                options: {
                    indexAxis: 'y',
                    responsive: false,
                    plugins: {
                        title: {
                            display: true,
                            text: `${side} ${type} Losses by Classname`,
                            color: '#ffffff'
                        },
                        legend: {
                            labels: { color: '#ffffff' }
                        }
                    },
                    scales: {
                        x: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                stepSize: 1,
                                color: '#ffffff',
                                font: {
                                        size: 14, // Adjust the font size here
                                    },
                            }
                        },
                        y: {
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: { color: '#ffffff',

                                     font: {
                                        size: 18, // Adjust the font size here
                                    },
                                 }
                        }
                    }
                }
            });
        }

        function createChartsForSide(side, containerId) {
            const types = getUniqueTypes(side);
            types.forEach(type => {
                createLossesByClassnameChart(side, type, containerId);
            });
        }

        createChartsForSide('RED', 'redCharts');
        createChartsForSide('BLUE', 'blueCharts');
    </script>
</body>
</html>]]

local msg = string.format(tmp,bL3.AuxFunctions.TableToJson(bL3.KILLS))

ScenEdit_SpecialMessage('playerside',msg)

end

function bL3.Functions.Scoring(result)
  local tmp = [[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scoring Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #1e1e1e;
            color: #ffffff;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: flex-start;
            flex-direction: column;
            align-items: center;
            height: 100vh;
            
        }

        .container {
            display: flex;
            width: 90%%;
            max-width: 1200px;
            gap: 20px;
            margin-top: 20px;
        }

        .column {
            flex: 1;
            background-color: #2e2e2e;
            border: 1px solid #444;
            border-radius: 8px;
            padding: 20px;
            overflow-y: auto;
            max-height: 80vh;
        }

        .header {
            
            font-size: 1.5em;
            margin-bottom: 10px;
            text-align: center;
            color: #ffcc00;
        }

        .score {
            text-align: center;
            font-size: 2em;
            margin-bottom: 20px;
            color: #4caf50;
        }

        .log-entry {
            margin: 5px 0;
            padding: 10px;
            border-bottom: 1px solid #555;
            font-size: 0.9em;
        }

        .log-entry:last-child {
            border-bottom: none;
        }

        .log-entry.blue {
            color: #00aaff;
        }

        .log-entry.red {
            color: #ff5555;
        }

    </style>
</head>
<body>
    <div class="header">
    <h1>THE SCENARIO HAS ENDED</h1>
    <h2>%s</h2>
    </div>
    <div class="container">
        <!-- Blue column -->
        <div class="column" id="blue-column">
            <div class="header">BLUE Team</div>
            <div class="log" id="blue-log"></div>
        </div>

        <!-- Red column -->
        <div class="column" id="red-column">
            <div class="header">RED Team</div>
            <div class="log" id="red-log"></div>
        </div>
    </div>
    <div class="header">
    <h3>Click on Next to check the losses</h3>
    </div>

    <script>
        const data = %s;

        // Update scores
        

        // Populate logs
        const blueLog = document.getElementById("blue-log");
        const redLog = document.getElementById("red-log");

        data.LOG.BLUE.forEach(entry => {
            const div = document.createElement("div");
            div.className = "log-entry blue";
            div.innerText = entry;
            blueLog.appendChild(div);
        });

        data.LOG.RED.forEach(entry => {
            const div = document.createElement("div");
            div.className = "log-entry red";
            div.innerText = entry;
            redLog.appendChild(div);
        });


    </script>
</body>
</html>]]

  local html = string.format(tmp,result,bL3.AuxFunctions.TableToJson(bL3.SCORE))
  ScenEdit_SpecialMessage('playerside',html)
  
end

function bL3.Functions.REDEndsScenario()
  if not ScenEdit_GetEvent('EndScenario') then
    local t 
    if ScenEdit_CurrentTime() > bL3.RED.Dtime then
      t = os.date(bL3.DATEFORMAT,ScenEdit_CurrentTime() + 5*60 )
    else
      t = os.date(bL3.DATEFORMAT,bL3.RED.Dtime + 20*60 )
    end
    bL3.AuxFunctions.TimeEvent('EndScenarioRed', t, 'bL3.Functions.EndScenario()','add')  
  end
end

--ToolUMS-lua

function bL3.TOOL.UMS()
    local html_tmp=[[<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Unit Management System</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
  <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
    integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" crossorigin="" />




  <!-- Google Fonts: Added Inconsolata -->
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link
    href="https://fonts.googleapis.com/css2?family=Inconsolata:wght@200..900&family=Segoe+UI:wght@400;700&display=swap"
    rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap"
    rel="stylesheet">

  <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
    integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" crossorigin=""></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.css" />
  <script
    src="https://cdnjs.cloudflare.com/ajax/libs/Leaflet.awesome-markers/2.0.2/leaflet.awesome-markers.min.js"></script>


  <!-- TomSelect CSS -->
  <link href="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/css/tom-select.bootstrap5.min.css" rel="stylesheet">

  <!-- Tippy.js & Popper.js (Tippy's dependency) -->
  <script src="https://unpkg.com/@popperjs/core@2"></script>
  <script src="https://unpkg.com/tippy.js@6"></script>

  <!-- TomSelect JS -->
  <script src="https://cdn.jsdelivr.net/npm/tom-select@2.3.1/dist/js/tom-select.complete.min.js"></script>


  <style>
    /* --- Global Styles & Variables --- */
    :root {
      --bg-color: #0e0e0e;
      --panel-bg: #1e1e1e;
      --panel-bg-secondary: #353535;
      --header-bg: #1a1a1a;
      --table-header-bg: #272727;
      --table-row-hover-bg: #333333;
      --table-row-selected-bg: #444444;
      --border-color: #444;
      --text-color: #e0e0e0;
      --text-muted-color: #aaa;
      --text-muted-color-rgb: 170, 170, 170;
      /* Added for consistency with usage */
      --accent-color: #5a9bd4;
      --accent-hover-color: #4a8ac1;
      --accent-color-rgb: 90, 155, 212;
      /* For rgba usage */
      --success-color: #98c379;
      --warning-color: #e5c07b;
      --danger-color: #e06c75;


      /* Main Panel Background (Slightly Opaque) */
      --panel-bg-transparent: rgba(40, 40, 40, 0.9);
      /* Translucent Panel Background for "Frosted Glass" effect */
      --panel-bg-translucent: rgba(50, 50, 50, 0.6);
      --table-header-bg: #222222;
      --table-row-hover-bg: rgba(68, 68, 68, 0.7);
      --table-row-selected-bg: #007aff;
      /* Brighter blue for selection */
      --input-border-color: #555555;
      --border-color: rgba(90, 90, 90, 0.5);
      /* Semi-transparent border */
      --text-color: #f5f5f7;
      --text-muted-color: #9d9d9d;
      --table-row-selected-bg: #333;
      --accent-color: #0a84ff;
      --accent-hover-color: #359dff;
      --accent-color-rgb: 10, 132, 255;

      --input-bg: #1e1e1e;
      --font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      --font-family: 'DejaVuSans', sans-serif;
      --font-family: 'Noto Sans', sans-serif;
      --font-family-monospace: 'Inconsolata', monospace;
      --transition-speed: 0.3s;

      /* Mission Tags (unchanged, but will work on new theme) */
      --mission-tag-cap-bg: #92d050;
      --mission-tag-cap-text: #000000;
      --mission-tag-oca-bg: #ffc000;
      --mission-tag-oca-text: #000000;
      --mission-tag-dca-bg: #7030a0;
      --mission-tag-dca-text: #ffffff;
      --mission-tag-asw-bg: #00b050;
      --mission-tag-asw-text: #000000;
      --mission-tag-cas-bg: #00b0f0;
      --mission-tag-cas-text: #000000;
      --mission-tag-sead-bg: #c00000;
      --mission-tag-sead-text: #ffffff;
      --mission-tag-sea-bg: #79b6c9;
      --mission-tag-sea-text: #000000;
      --mission-tag-aew-bg: #ec6daf;
      --mission-tag-aew-text: #000000;
      --mission-tag-c2-bg: #0070c0;
      --mission-tag-c2-text: #ffffff;
      --mission-tag-es-bg: #ff9900;
      --mission-tag-es-text: #000000;
      --mission-tag-rec-bg: #c46210;
      --mission-tag-rec-text: #ffffff;
      --mission-tag-ar-bg: #f1807e;
      --mission-tag-ar-text: #000000;
      --mission-tag-int-bg: #4a90e2;
      --mission-tag-int-text: #ffffff;
      --mission-tag-strat-bg: #500498;
      --mission-tag-strat-text: #ffffff;
      --mission-tag-marstr-bg: #f5a623;
      --mission-tag-marstr-text: #000000;
      --mission-tag-sup-bg: #007bff;
      --mission-tag-sup-text: #ffffff;
      --mission-tag-strike-bg: #242124;
      --mission-tag-strike-text: #ffffff;
      --mission-tag-patrol-bg: #6c757d;
      --mission-tag-patrol-text: #ffffff;
      --mission-tag-unknown-bg: #444444;
      --mission-tag-unknown-text: #cccccc;
      --mission-tag-unknown-border: #777777;
    }

    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    html,
    body {
      height: 100%%;
    }

    small {
      font-size: 0.9rem;
    }

    body {
      font-family: var(--font-family);
      background-color: var(--bg-color);
      color: var(--text-color);
      font-size: 14px;
      line-height: 1.5;
      overflow: hidden;
      display: flex;
      flex-direction: column;
      -ms-overflow-style: none;
      /* IE and Edge */
      scrollbar-width: none;
      /* Firefox */
    }

    h6 {
      font-weight: 600;
    }

    /* --- App Header --- */
    .app-header {
      background-color: var(--header-bg);
      border-bottom: 1px solid var(--border-color);
      padding: 5px 20px 2px 20px;
      display: flex;
      flex-direction: row;
      align-items: center;
    }

    .app-title {
      font-size: 1.3rem;
      font-weight: bold;
      color: var(--accent-color);
      margin-bottom: 10px;
      display: flex;
      align-items: center;
      margin: auto;
    }

    .app-title i {
      margin-right: 10px;

    }

    /* --- Main View Tabs (Top Level) --- */
    #main-view-tabs-container {
      display: flex;
      gap: 10px;
    }

    #current-time {
      margin-left: auto;
      /* This is the key to push it to the right */
    }

    /* New styles for the h5 element displaying the time */
    #current-scenario-time {
      color: var(--text-muted-color);
      /* Use a muted color for secondary info */
      font-size: 1.1rem;
      /* Slightly smaller font size */
      font-weight: 600;
      /* Medium weight, or 'normal' (400) for less emphasis */
      margin-left: 15px;
      /* Remove default h5 margins */
      white-space: nowrap;
      /* Prevent the time string from wrapping */
      display: flex;
      flex-direction: row;
      gap: 5px;
      align-items: center;
    }

    .main-view-tab-button {
      padding: 10px 15px;
      background-color: transparent;
      border: none;
      border-bottom: 3px solid transparent;
      color: var(--text-muted-color);
      cursor: pointer;
      font-size: 15px;
      font-weight: 500;
      transition: color var(--transition-speed) ease, border-color var(--transition-speed) ease;
    }

    .main-view-tab-button i {
      margin-right: 8px;
    }

    .main-view-tab-button:hover {
      color: var(--text-color);
    }

    .main-view-tab-button.active {
      color: var(--accent-color);
      border-bottom-color: var(--accent-color);
      font-weight: 600;
    }

    .text-orange {
      color: #fd7e14 !important;
      /* Bootstrap's orange or your preferred shade */
    }

    .btn-xs {
      padding: 0.15rem 0.4rem;
      font-size: 0.75rem;
      line-height: 1.5;
      border-radius: 0.2rem;
    }

    /* --- Filter Bars --- */
    .filter-bar-container {
      display: flex;
      /* Default to flex, JS will hide/show as needed */
      align-items: center;
      gap: 10px;
      /* Reduced gap */
      padding: 10px 0;
      border-bottom: 1px solid var(--border-color);
      margin-bottom: 15px;
      flex-wrap: wrap;
    }

    .filter-group {
      display: flex;
      align-items: center;
      gap: 5px;
      flex-shrink: 1;
    }

    .filter-group label {
      color: var(--text-muted-color);
      font-size: 12px;
      white-space: nowrap;
      flex-shrink: 0;
    }

    .filter-bar-container input[type="text"],
    .filter-bar-container select,
    .filter-bar-container .form-control,
    .filter-bar-container .form-select {
      background-color: var(--input-bg);
      color: var(--text-color);
      border: 1px solid var(--border-color);
      border-radius: 4px;
      padding: 5px 8px;
      font-size: 13px;
      max-width: 160px;
    }

    .form-control:focus,
    .form-select:focus {
      border-color: var(--accent-color);
      box-shadow: 0 0 0 0.2rem rgba(var(--accent-color-rgb), 0.25);
    }

    .filter-bar-container input[type="text"] {
      min-width: 220px;
    }

    .filter-bar-container select,
    .filter-bar-container .form-select {
      appearance: none;
      -webkit-appearance: none;
      -moz-appearance: none;
      background-image: url("data:image/svg+xml,%%3Csvg xmlns='http://www.w3.org/2000/svg' fill='%%23aaa' viewBox='0 0 20 20'%%3E%%3Cpath stroke='%%23aaa' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%%3E%%3C/svg%%3E");
      background-repeat: no-repeat;
      background-position: right 8px center;
      background-size: 1em;
      padding-right: 2em !important;
    }

    .filter-bar-container input::placeholder,
    .form-control::placeholder {
      color: var(--text-muted-color);
      opacity: 0.7;
    }

    .btn-outline-secondary {
      color: var(--text-muted-color);
      border-color: var(--border-color);
    }

    .btn-outline-secondary:hover {
      color: var(--text-color);
      background-color: var(--table-row-hover-bg);
      border-color: var(--accent-hover-color);
    }

    .btn-primary {
      background-color: var(--accent-color);
      border-color: var(--accent-color);
      color: var(--bg-color);
      /* Assuming high contrast needed with accent */
    }

    .btn-primary:hover {
      background-color: var(--accent-hover-color);
      border-color: var(--accent-hover-color);
    }

    .btn-secondary {
      background-color: var(--input-bg);
      color: var(--text-muted-color);
      border: 1px solid var(--border-color);
    }

    .btn-secondary:hover {
      background-color: var(--border-color);
      color: var(--text-color);
    }

    .btn-action-icon {
      background-color: transparent !important;
      /* Transparent background */
      border: none !important;
      /* No border */
      color: var(--text-muted-color) !important;
      /* Default icon color (visible but not too loud) */
      padding: 0.15rem 0.35rem !important;
      /* Adjust padding for a good size */
      font-size: 0.9em !important;
      /* Adjust icon size if needed */
      line-height: 1 !important;
      vertical-align: middle;
      box-shadow: none !important;
      /* Remove any default Bootstrap shadows */
      margin-right: 4px;
      /* Space between buttons */
    }

    .btn-action-icon:last-child {
      margin-right: 0;
      /* No margin for the last button in a group */
    }

    .btn-action-icon:hover,
    .btn-action-icon:focus {
      color: var(--accent-color) !important;
      /* Icon color change on hover/focus */
      background-color: rgba(var(--accent-color-rgb), 0.1) !important;
      /* Subtle background highlight on hover */
    }

    .mission-status-badge.planned {
      background-color: #109010;
      color: #000;

    }

    .mission-status-badge.inactive {
      background-color: #fa2335;
      color: #ffeaec;

    }

    .mission-status-badge.active {
      background-color: #9ba9ff;
      color: #000;

    }

    .badge.text-bg-blue {
      background-color: #9ba9ff;
      color: #000;
    }

    /* --- Modal Welcome panel --- */
    /* Add to your main <style> block if needed */
    #welcomeHelpModal .modal-header .h5 {
      /* Ensure title color */
      color: var(--accent-color);
    }

    #welcomeHelpModal .accordion-button {
      background-color: var(--panel-bg-transparent);
      color: var(--text-color);
      font-weight: 500;
      font-size: 0.95rem;
      padding: 0.75rem 1rem;
    }

    #welcomeHelpModal .accordion-button:not(.collapsed) {
      background-color: var(--table-header-bg);
      color: var(--accent-color);
      box-shadow: none;
    }

    #welcomeHelpModal .accordion-button:focus {
      box-shadow: none;
      border-color: var(--accent-color);
    }

    #welcomeHelpModal .accordion-button::after {
      /* Bootstrap's chevron */
      filter: invert(1) grayscale(1) brightness(1.5);
      /* Make chevron visible on dark */
    }

    #welcomeHelpModal .accordion-body {
      background-color: var(--bg-color);
      /* Slightly different from panel for contrast */
      color: var(--text-muted-color);

      padding: 1rem;
    }

    #welcomeHelpModal .accordion-body ul {
      padding-left: 20px;
    }

    #welcomeHelpModal .accordion-body code {
      background-color: var(--table-row-hover-bg);
      padding: .1em .3em;
      border-radius: 3px;
      color: var(--warning-color);
    }

    /* --- Main Container & Content --- */
    .main-container {
      flex-grow: 1;
      display: flex;
      overflow: hidden;
    }

    #view-content-wrapper {
      flex-grow: 1;
      overflow: auto;
      padding: 10px 20px;
    }

    .view-content {
      display: none;
      flex-direction: column;
    }

    .view-content.active {
      display: block;
    }

    .view-header {
      font-size: 1.8rem;
      font-weight: 500;
      color: var(--text-color);
      margin-bottom: 20px;
      padding-bottom: 10px;
      border-bottom: 1px solid var(--border-color);
    }

    /* --- Card styles (for Overview) --- */
    .info-card {
      margin-top: 5px;
      background-color: var(--panel-bg-transparent);
      border: 1px solid var(--border-color);
      border-radius: 8px;
      padding: 20px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
      height: 100%%;
      display: flex;
      flex-direction: column;

    }

    .critical-info-card {
      max-height: 35vh;
    }

    .info-card-content {
      font-size: 1em;
    }

    .info-card-title {
      font-size: 1.1em;
      font-weight: 500;
      color: var(--accent-color);
      margin-bottom: 15px;
    }

    .info-card-title i {
      margin-right: 8px;
    }

    .info-card-content {
      color: var(--text-muted-color);
      flex-grow: 1;
      overflow: hidden;
    }

    .info-card-content p {
      margin-bottom: 8px;
    }

    .info-card-content strong {
      color: var(--text-color);
    }

    .info-card-content ul {
      font-size: 0.8em;
    }

    .info-card canvas {
      max-height: 250px;
    }
    .flex-truncate {
      /* Allow the element to shrink below its minimum content size */
      min-width: 0;
    }

    .flex-truncate span,
    .flex-truncate strong {
      /* These are the standard rules for text truncation */
      display: block; /* or inline-block */
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }
    .unit-name-link,
    .classname-clickable {
      display: inline-block !important;
      width: -moz-fit-content !important;
      /* Firefox support */
      width: fit-content !important;
      /* Modern browsers */
    }

    .classname-clickable:hover {
      text-decoration: underline;
      cursor: pointer;
    }

    /* --- Table Styling --- */
    .scrollable-table-wrapper {
      flex-grow: 1;
      /* This allows the wrapper to take up remaining vertical space */
      overflow: hidden;
      /* Enable vertical scrolling ONLY for the table content */
      position: relative;
      /* Needed for sticky header positioning context if you don't use table-container directly */
      /* border: 1px solid var(--border-color); /* Optional: border around the scrollable area */
      /* border-radius: 4px; */
      -ms-overflow-style: none;
      /* IE and Edge */
      scrollbar-width: none;
      /* Firefox */
    }

    .scrollable-table-wrapper #weapons-table-div {
      max-height: 60vh;
      overflow-y: auto;
      /* Enable vertical scrolling ONLY for the table content */
    }

    .scrollable-table-wrapper #unit-table-div {
      max-height: 70vh;
      overflow-y: auto;
      /* Enable vertical scrolling ONLY for the table content */
    }

    .scrollable-table-wrapper #main-missions-table-container {
      max-height: 65vh;
      overflow-y: auto;
      /* Enable vertical scrolling ONLY for the table content */
    }

    #main-missions-table tbody tr.mission-summary-row td[data-col-id="name"] {
      cursor: pointer;
      /* Indicates the whole cell is clickable */
    }

    #main-missions-table tbody td[data-col-id="taskPool"] span.clickable-taskpool {
      cursor: pointer;
      color: var(--accent-color);
      /* Or your preferred default link color */
      text-decoration: none;
    }

    #main-missions-table tbody td[data-col-id="taskPool"] span.clickable-taskpool:hover {
      text-decoration: underline;
      color: var(--accent-color);
    }

    .table-container {
      overflow-x: auto;
      border: 1px solid var(--border-color);
      margin-bottom: 15px;
      background-color: var(--panel-bg);
      border-radius: 4px;
      -webkit-user-select: none;
      /* Safari */
      -moz-user-select: none;
      /* Old Firefox */
      -ms-user-select: none;
      /* Internet Explorer/Edge */
      user-select: none;
      /* Standard syntax */
    }

    .unit-table {
      width: 100%%;
      border-collapse: collapse;
    }

    .info-mission-buttons {
      gap: 5px;
    }

    .unit-table th,
    .unit-table td {
      padding: 6px 8px;
      text-align: left;
      border-bottom: 1px solid var(--border-color);
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }



    .unit-table th {
      background-color: var(--table-header-bg);
      position: sticky;
      top: 0;
      z-index: 1020;
      font-size: 1em;
      font-weight: 600;
      text-transform: uppercase;
      color: var(--text-muted-color);
      cursor: pointer;
    }

    .unit-table th .fas {
      margin-left: 5px;
    }

    .unit-table tbody tr {
      transition: background-color var(--transition-speed) ease;
      font-size: 0.95em;
    }

    .unit-table tbody tr:hover {
      background-color: var(--table-row-hover-bg);
    }

    .unit-table tbody tr.row-selected td {
      background-color: var(--selected-row-color- D) !important;
      /* Or your selection color */

      /* Or your selected text color */
    }

    .unit-table tbody tr.row-selected td a {
      /* Ensure links in selected rows are visible */
      color: var(--bs-light);
    }

    .unit-table tbody tr:hover td.selectable-cell,
    .unit-table tbody tr:hover td.selectable-cell-id {
      background-color: rgba(var(--bs-secondary-rgb), 0.3);
      /* Hover feedback */
    }

    .unit-table tbody tr.row-selected td {
      background-color: var(--table-row-selected-bg) !important;
      /* Or your chosen selection color */
      /* color: #fff !important; /* Or your selected text color */
    }



    .unit-table tbody tr.row-selected td .badge {
      /* Make badges readable on selection bg */
      /*color: var(--bs-dark) !important;*/

      /* Example, adjust as needed */
    }


    /* Hover effect for selectable cells */
    .unit-table tbody tr:not(.row-selected):hover td.selectable-cell,
    .unit-table tbody tr:not(.row-selected):hover td.selectable-cell-id {
      background-color: rgba(var(--bs-secondary-rgb), 0.2);
      /* Subtle hover */
    }

    .unit-table td[data-col-id="name"],
    .unit-table td[data-col-id="classname"],
    .unit-table td[data-col-id="base"] {
      /* Set a max-width on the cell itself. This acts as a container. */
      max-width: 250px;
      /* Adjust this value to your needs */
    }

    .unit-table td[data-col-id="base"]>*,
    .unit-table td[data-col-id="classname"]>*,
    .unit-table td[data-col-id="name"]>* {
      /* This targets the direct child (our <a> tag) inside the cell */
      display: block;
      /* Make the inner element a block to respect width */
      width: 100%%;
      /* Make it fill the cell's constrained width */
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .no-data-message {
      text-align: center;
      padding: 15px;
      font-style: italic;
      color: var(--text-muted-color);
    }

    .text-success {
      color: var(--success-color) !important;
    }

    .text-warning {
      color: var(--warning-color) !important;
    }

    .text-danger {
      color: var(--danger-color) !important;
    }


    /* Column Toggler Dropdown */
    .column-toggler-dropdown {
      background-color: var(--panel-bg);
      border: 1px solid var(--border-color);
      padding: 10px;
      min-width: 200px;
    }

    .column-toggler-dropdown .dropdown-item {
      color: var(--text-color);
      display: block;
    }

    .column-toggler-dropdown .dropdown-item input {
      margin-right: 8px;
      vertical-align: middle;
    }

    .column-toggler-dropdown .dropdown-item:hover {
      background-color: var(--table-row-hover-bg);
    }

    .badge {
      /* Bootstrap default styles provide padding, etc. */
      /* Ensure default text/bg are sensible *before* mTag colors are applied */
      background-color: var(--accent-color);
      /* Default badge background */
      color: var(--bg-color);
      /* Default badge text color for high contrast with accent */
    }

    /* Override background and text color based on mTag for badges */
    .badge[data-mTag="CAP"] {
      color: var(--mission-tag-cap-text) !important;
      background-color: var(--mission-tag-cap-bg) !important;
    }

    .badge[data-mTag="OCA"] {
      color: var(--mission-tag-oca-text) !important;
      background-color: var(--mission-tag-oca-bg) !important;
    }

    .badge[data-mTag="DCA"] {
      color: var(--mission-tag-dca-text) !important;
      background-color: var(--mission-tag-dca-bg) !important;
    }

    .badge[data-mTag="ASW"] {
      color: var(--mission-tag-asw-text) !important;
      background-color: var(--mission-tag-asw-bg) !important;
    }

    .badge[data-mTag="CAS"] {
      color: var(--mission-tag-cas-text) !important;
      background-color: var(--mission-tag-cas-bg) !important;
    }

    .badge[data-mTag="SEAD"] {
      color: var(--mission-tag-sead-text) !important;
      background-color: var(--mission-tag-sead-bg) !important;
    }

    .badge[data-mTag="SEA"] {
      color: var(--mission-tag-sea-text) !important;
      background-color: var(--mission-tag-sea-bg) !important;
    }

    .badge[data-mTag="AEW"] {
      color: var(--mission-tag-aew-text) !important;
      background-color: var(--mission-tag-aew-bg) !important;
    }

    .badge[data-mTag="C2"] {
      color: var(--mission-tag-c2-text) !important;
      background-color: var(--mission-tag-c2-bg) !important;
    }

    .badge[data-mTag="EW"] {
      color: var(--mission-tag-es-text) !important;
      background-color: var(--mission-tag-es-bg) !important;
    }

    .badge[data-mTag="REC"] {
      color: var(--mission-tag-rec-text) !important;
      background-color: var(--mission-tag-rec-bg) !important;
    }

    .badge[data-mTag="AR"] {
      color: var(--mission-tag-ar-text) !important;
      background-color: var(--mission-tag-ar-bg) !important;
    }

    .badge[data-mTag="INT"] {
      color: var(--mission-tag-int-text) !important;
      background-color: var(--mission-tag-int-bg) !important;
    }

    .badge[data-mTag="STRAT"] {
      color: var(--mission-tag-strat-text) !important;
      background-color: var(--mission-tag-strat-bg) !important;
    }

    .badge[data-mTag="MARSTR"] {
      color: var(--mission-tag-marstr-text) !important;
      background-color: var(--mission-tag-marstr-bg) !important;
    }

    .badge[data-mTag="SUP"] {
      color: var(--mission-tag-sup-text) !important;
      background-color: var(--mission-tag-sup-bg) !important;
    }

    .badge[data-mTag="Strike"] {
      color: var(--mission-tag-strike-text) !important;
      background-color: var(--mission-tag-strike-bg) !important;
      border: 1px solid var(--mission-tag-strike-border) !important;
    }

    .badge[data-mTag="Patrol"] {
      color: var(--mission-tag-patrol-text) !important;
      background-color: var(--mission-tag-patrol-bg) !important;
    }

    .badge[data-mTag="Unknown"] {
      color: var(--mission-tag-unknown-text) !important;
      background-color: var(--mission-tag-unknown-bg) !important;
      border: 1px dashed var(--mission-tag-unknown-border) !important;
    }

    .mission-list-info-badge {
      font-size: 0.75em;
      /* Slightly smaller than default badge for compactness */
      padding: .3em .6em;
      /* Default styling if no mTag matches */
      background-color: var(--accent-color);
      color: var(--bg-color);
      /* High contrast with accent */
      border: 1px solid transparent;
    }

    .mission-detail-row td {


      background-color: var(--table-row-hover-bg);
      /* Slightly different bg for expanded area */
      border-bottom: 2px solid var(--accent-color);
      /* Emphasize expanded section */
    }

    .mission-detail-content {
      padding: 15px;
      /* Padding inside the expanded content area */
    }

    .mission-detail-content h6 {
      color: var(--accent-color);
      margin-bottom: 10px;
      font-size: 1rem;
    }

    /* Inner table for assigned units */
    .mission-detail-content .table-container {
      max-height: 250px;
      /* Or your desired height */
      overflow-y: auto;
      border: 1px solid var(--border-color);
      border-radius: 4px;
      margin-bottom: 15px;
      /* No bottom margin if it's the last element */
    }

    .mission-detail-content .unit-table {
      font-size: 0.9rem;
      padding: 5px 10px;
      background-color: var(--panel-bg);
      /* Ensure inner table bg matches */
    }

    .mission-detail-content .unit-table th,
    .mission-detail-content .unit-table td {
      padding: 6px 8px;
      white-space: normal;
      /* Allow wrapping in inner table */
    }

    .mission-detail-content .unit-table th {
      white-space: nowrap;
      background-color: var(--table-header-bg);
      /* Ensure header bg for inner table */
      position: sticky;
      /* Make inner table headers sticky too */
      top: 0;
      z-index: 1;
      /* Lower z-index than main table headers */
    }

    /* Icon for expanding/collapsing - can be part of the mission name link or a separate cell */
    .mission-name-link-in-table .expand-icon {
      margin-left: 8px;
      font-size: 0.8em;
      transition: transform 0.2s ease-in-out;
      display: inline-block;
      /* For transform to work */
    }

    .mission-name-link-in-table.expanded .expand-icon {
      transform: rotate(90deg);
    }

    /* --- Inner Tabs (Missions, Weapons) --- */
    .inner-tab-headers {
      display: flex;
      border-bottom: 1px solid var(--border-color);
      margin-bottom: 0;
      /* Filter bar will have margin if present */
    }

    .inner-tab-button {
      padding: 8px 15px;
      background-color: transparent;
      border: none;
      border-bottom: 3px solid transparent;
      color: var(--text-muted-color);
      cursor: pointer;
      font-size: 14px;
      transition: color var(--transition-speed) ease, border-color var(--transition-speed) ease;
    }

    .inner-tab-button:hover {
      color: var(--text-color);
    }

    .inner-tab-button.active {
      color: var(--accent-color);
      border-bottom-color: var(--accent-color);
      font-weight: 600;
    }

    .inner-tab-pane {
      display: none;
      padding-top: 15px;
      /* Space for content below filter bar */
    }

    .inner-tab-pane.active {
      display: block;
    }

    /* Hide filter bar by default inside panes, show only when pane is active AND it's the list view */
    .inner-tab-pane .filter-bar-container {
      display: none;
    }

    .inner-tab-pane.active #missions-filter-bar {
      /* Specific to mission list view */
      display: flex;
    }

    .weapon-name-link,
    .unit-name-link {
      color: var(--accent-color);
      text-decoration: none;
      cursor: pointer;
    }

    .weapon-name-link:hover,
    /* Combined selector */
    .unit-name-link:hover {
      color: var(--accent-hover-color);
      text-decoration: underline;
    }

    #weapons-table {
      max-height: 50vh;
    }

    #weapons-table-summary {
      /* The main container for the summary */
      font-size: 0.9em;
      /* Slightly smaller base font for summary section */
    }

    #weapons-table-summary .info-card-title {
      /* General title for the summary section */
      font-size: 1rem;
      margin-bottom: 10px;
      color: var(--text-muted-color);
      /* Subtler main title */
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 5px;
    }

    .summary-capability-card {
      /* Specific styling for each capability card */
      padding: 10px 12px;
      /* Reduced padding */
      height: auto;
      min-height: 90px;
      /* Give a minimum height */
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      /* Pushes content slightly */
    }

    .summary-capability-card .info-card-title {
      /* Title within each capability card */
      font-size: 0.85rem;
      margin-bottom: 5px;
      border-bottom: none;
      /* Remove individual border from card titles here */
      padding-bottom: 0;
      color: var(--accent-color);
      /* Use accent color for these titles */
      display: flex;
      /* Align icon and text */
      align-items: center;
    }

    .summary-capability-card .info-card-title i {
      font-size: 0.9em;
      /* Adjust icon size if needed */
    }


    .summary-capability-card .capability-ranges small {
      color: var(--text-muted-color);
      display: inline-block;
      /* For better spacing with margin */
      margin-bottom: 3px;
    }

    .summary-capability-card .capability-ranges strong {
      color: var(--text-color);
    }

    .asset-title-clickable,
    .asset-critical-clickable,
    .asset-mission-clickable {
      cursor: pointer;
    }

    .asset-title-clickable:hover,
    .asset-critical-clickable:hover,
    .asset-mission-clickable:hover {
      background-color: rgba(var(--bs-secondary-rgb), 0.2);
    }

    .asset-stats-area p.asset-stat {
      font-size: 1.15em;
      margin-bottom: 0.2rem;
      white-space: nowrap;
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .key-asset-card .info-card-header {
      padding: 0.5rem 0.2rem;
    }

    .key-asset-card .asset-title {
      font-size: 0.95em;
      /* Slightly larger for the main title */
    }

    .key-asset-card .info-card-content {
      font-size: 0.9em;
      /* Adjust overall font size in card content */
    }

    #units-table-summary {
      font-size: 0.9em;
      margin-top: 10px !important;
      padding: 10px 15px !important;
    }

    /* Title for the entire summary section "Filtered Units Overview" */
    #units-table-summary>.info-card-title {
      font-size: 1rem;
      margin-bottom: 10px;
      color: var(--text-muted-color);
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 5px;
    }

    #units-table-summary>.info-card-title i {
      /* Icon next to "Filtered Units Overview" */
      font-size: 0.9em;
    }

    /* Titles for subsections like "Unit Statistics:" and "Unit Types:" */
    #filtered-units-stats .info-card-title {
      font-size: 0.9rem !important;
      /* Smaller subtitle */
      margin-bottom: 5px !important;
      border-bottom: none !important;
      padding-bottom: 0 !important;
      color: var(--text-muted-color);
      /* Keep it subtle */
      font-weight: 500;
    }


    /* Common styling for both summary lists if desired */
    .unit-summary-stat-list,
    .unit-type-summary-list {
      padding-left: 0;
      list-style: none;
      margin-bottom: 2px;
      margin-top: 2px;

    }

    .unit-summary-stat-list li small,
    .unit-type-summary-list li small {
      font-size: 0.95em;
      /* Slightly larger than the default 0.9em for list items in previous example */
      display: inline-flex;
      /* Helps with icon alignment */
      align-items: center;
    }

    .summary-section-title {
      /* Replaces the inline styles on the <h6> */
      font-size: 0.85rem;
      /* Make titles slightly smaller than main summary title */
      font-weight: 500;
      color: var(--text-muted-color);
      margin-bottom: 5px;
      padding-bottom: 3px;
      /* border-bottom: 1px dashed var(--border-color); /* Optional: if you want a separator */
    }

    /* Your existing .unit-summary-stat-list and .unit-type-summary-list styles should still apply */
    .unit-summary-stat-list,
    .unit-type-summary-list {
      padding-left: 0;
      list-style: none;
      margin-bottom: 0;
    }

    .unit-summary-stat-list li small,
    /* Adjusted from previous */
    .unit-type-summary-list li small {
      /* Adjusted from previous */
      font-size: 1em;
      /* Relative to parent #units-table-summary's font-size (0.85em) */
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }

    .unit-summary-stat-list li i,
    /* Icons in the main stats list */
    .unit-type-summary-list li i {
      /* Icons in the unit type list */
      margin-right: 5px;
      width: 12px;
      /* Give icons a fixed width for alignment */
      text-align: center;
    }

    .mission-tag-summary-list li small {
      /* font-size is already 1em relative to parent (0.85em), which is good */
      display: inline-flex;
      align-items: center;
      line-height: 1.2;
      /* Tighter line height for the small container */
    }

    /* The .summary-inline-badge class is used for tags in this list */
    .summary-inline-badge {
      font-size: 0.8em !important;
      /* Make badges within this list even smaller */
      padding: .1em .35em !important;
      /* Tighter padding */
      vertical-align: middle;
      /* Better alignment with adjacent text */
      margin-right: 3px;
      /* Slightly less margin than main badges */
      line-height: 1;
      /* Ensure badge height is minimal */
      border-radius: 4px;
      /* Less pronounced pill shape if desired for compactness */
    }

    /* Ensure the text following the badge aligns well */
    .mission-tag-summary-list {
      /* The text (e.g., ": 5") following the badge */
      /* No specific style needed if vertical-align on badge and flex on li>small works */
      margin-bottom: 0;
    }

    /* Ensure the section titles are consistent */
    .summary-section-title {
      font-size: 0.8rem;
      /* Adjusted from 0.85rem for more compactness */
      font-weight: 500;
      color: var(--text-muted-color);
      margin-bottom: 3px;
      /* Reduced margin */
      padding-bottom: 2px;
      /* border-bottom: 1px dashed var(--border-color); /* Optional */
    }

    .summary-section-title i {
      font-size: 0.9em;
      margin-right: 4px;
    }

    #filtered-weapons-stats .col-12.mb-3 i {
      font-size: 0.9em;
    }

    /* --- Modals --- */
    .modal-content {
      background-color: var(--panel-bg);
      color: var(--text-color);
      border: 1px solid var(--border-color);
    }

    .modal-header,
    .modal-footer {
      border-bottom-color: var(--border-color);
      border-top-color: var(--border-color);
    }

    .modal-header .btn-close {
      filter: invert(1) grayscale(100%%) brightness(200%%);
    }

    .modal-body label {
      color: var(--text-muted-color);
    }

    #weapon-map-view-pane.active {
      /* The container of the map */
      height: 75vh;
      /* Or a percentage of its parent if the parent has a defined height */
      display: flex;
      /* To make the map fill it */
      flex-direction: column;
      overflow: hidden;
    }

    #weaponMap {
      flex-grow: 1;
      /* Map will take available space in the flex container */
      border-radius: 4px;
      border: 1px solid var(--border-color);
      background-color: var(--input-bg);
    }

    .weapon-map-legend-control {
      padding: 6px 8px;
      font: 12px/1.5 Arial, Helvetica, sans-serif;
      background: rgba(30, 30, 30, 0.85);
      color: var(--text-muted-color);
      box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
      border-radius: 5px;
      border: 1px solid var(--border-color);
    }

    .weapon-map-legend-control i {
      border-radius: 50%%;
    }

    .popup-title {
      font-size: 1.1em;
      color: var(--text-color);
    }

    .popup-type {
      font-size: 0.8em;
    }

    .popup-total {
      color: var(--accent-color);
    }

    .popup-units {
      color: var(--text-muted-color);
      display: block;
      margin-bottom: 5px;
    }

    .popup-hr {
      margin: 5px 0;
      border-color: var(--border-color);
      opacity: 0.5;
    }

    .popup-inventory-list {
      list-style: none;
      padding-left: 5px;
      margin-top: 3px;
      font-size: 0.9em;
    }

    .popup-inventory-list li {
      margin-bottom: 2px;
    }

    /* --- Leaflet Map --- */


    .leaflet-popup-content-wrapper,
    .leaflet-popup-tip {
      background: var(--panel-bg) !important;
      color: var(--text-color) !important;
      box-shadow: 0 3px 14px rgba(0, 0, 0, 0.4);
      border-radius: 4px;
    }

    .leaflet-popup-content ul {
      padding-left: 20px;
      font-size: 0.9em;
    }

    .leaflet-tooltip {
      background: var(--panel-bg) !important;
      color: var(--text-color) !important;
      border: 1px solid var(--border-color) !important;
      border-radius: 4px;
      box-shadow: none;
    }

    .leaflet-control-attribution a {
      color: var(--accent-color);
    }

    .leaflet-control-attribution {
      background: rgba(30, 30, 30, 0.7) !important;
      color: var(--text-muted-color) !important;
    }

    /* --- Scrollbar Styling --- */
    ::-webkit-scrollbar {
      width: 10px;
      height: 10px;
    }

    ::-webkit-scrollbar-track {
      background: var(--bg-color);
    }

    ::-webkit-scrollbar-thumb {
      background-color: var(--border-color);
      border-radius: 5px;
      border: 2px solid var(--bg-color);
    }

    ::-webkit-scrollbar-thumb:hover {
      background-color: var(--accent-hover-color);
    }

    /* Bootstrap dropdown menus dark theme */
    .dropdown-menu {
      background-color: var(--panel-bg);
      border: 1px solid var(--border-color);
      color: var(--text-color);
      font-size: 13px;
      z-index: 1056;
    }

    .dropdown-menu .dropdown-item {
      color: var(--text-color);
      padding: 6px 12px;
    }

    .dropdown-menu .dropdown-item:hover,
    .dropdown-menu .dropdown-item:focus {
      background-color: var(--table-row-hover-bg);
      color: var(--text-color);
    }

    .dropdown-divider {
      border-top: 1px solid var(--border-color);
    }

    .dropdown-menu .dropdown-submenu {
      position: relative;
      /* Parent for absolute positioning of its child submenu */
    }

    .dropdown-menu .dropdown-submenu>.dropdown-menu {
      top: 0;
      right: 100%%;
      /* Position to the right of the parent item */
      margin-top: -1px;
      /* Align top border */
      margin-left: -1px;
      /* Align left border if needed */
      border-radius: 0 .25rem .25rem .25rem;
      /* Adjust rounding */
      display: none;
      /* Hidden by default, JS will toggle */
      position: absolute;
      /* Absolute positioning relative to parent li.dropdown-submenu */
      min-width: 10rem;
      /* Or your preferred width */
    }

    /* Show the submenu when parent is hovered OR clicked (if we add a class) */
    .dropdown-menu .dropdown-submenu:hover>.dropdown-menu,
    .dropdown-menu .dropdown-submenu.show>.dropdown-menu {
      /* Use a .show class toggled by JS */
      display: block;
    }

    /* Arrow indicator for items that have a submenu */


    /* Stop propagation wrapper for form elements inside dropdown items */
    .dropdown-item-form-wrapper {
      padding: 0.25rem 1rem;
      /* Match dropdown-item padding */
    }

    .dropdown-item-form-wrapper:hover {
      background-color: transparent;
      /* Prevent hover effect on the wrapper itself */
    }

    /* --- Mission Schedule Specific Styles --- */
    #mission-schedule-controls {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-bottom: 20px;
      gap: 10px;
    }

    #mission-schedule-controls button {
      background-color: var(--input-bg);
      border: 1px solid var(--border-color);
      color: var(--text-color);
      padding: 6px 12px;
      text-align: center;
      text-decoration: none;
      display: inline-block;
      font-size: 13px;
      cursor: pointer;
      border-radius: 4px;
      transition: background-color var(--transition-speed);
    }

    #mission-schedule-controls button:hover {
      background-color: var(--border-color);
    }

    #mission-schedule-container {
      width: 100%%;
      display: grid;
      grid-template-rows: auto auto auto;
      gap: 1px;
      background-color: var(--bg-color);
    }

    .schedule-grid {
      display: grid;
      gap: 0;
      width: 100%%;
    }

    #mission-timeline-labels {
      position: sticky;
      top: 0;
      z-index: 1025;
      grid-row: 1;
      display: grid;
      height: 30px;
      font-family: var(--font-family-monospace);
      background-color: var(--header-bg);
    }

    #mission-timeline-labels div {
      text-align: center;
      background: var(--table-header-bg);
      color: var(--text-muted-color);
      padding: 5px;
      grid-row: 1;
      grid-column: span 3;
      box-sizing: border-box;
      border-right: 1px solid var(--border-color);
      font-size: 0.9em;
    }



    #mission-timeline-grid {
      position: sticky;
      top: 30px;
      z-index: 1024;
      grid-row: 2;
      display: grid;
      border-bottom: 2px solid var(--bg-color);
      height: 20px;
      background-color: var(--header-bg);
    }

    #mission-timeline-grid div {
      border-right: 1px solid var(--border-color);
      height: 20px;
    }

    .mission-schedule-task-pool {
      display: grid;
      color: var(--text-color);
      background: var(--panel-bg);
      width: 100%%;
      position: relative;
      border-bottom: 1px solid var(--border-color);
    }

    .mission-schedule-task-pool-title {
      grid-column: 1 / -1;
      background-color: var(--table-header-bg);
      color: var(--accent-color);
      padding: 8px 5px;
      font-weight: 600;
      text-align: center;
      cursor: pointer;
      border-bottom: 1px solid var(--border-color);
    }

    .mission-schedule-task-pool-rows {
      display: grid;
      min-height: 30px;
      background-image: repeating-linear-gradient(to right, var(--border-color) 0, var(--border-color) 1px, transparent 1px, transparent 100%%);
      background-size: calc(100%% / var(--total-slots, 24)) 100%%;
    }

    .mission-schedule-mission {
      text-align: center;
      color: var(--text-color);
      border-radius: 3px;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 2px 1px;
      padding: 4px 6px;
      font-size: 0.8em;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
      border: 1px solid rgba(0, 0, 0, 0.2);
      min-height: 25px;
    }

    #mission-legend-row {
      display: grid;
      align-items: center;
      justify-items: stretch;
      border-bottom: 1px solid var(--border-color);
      text-align: center;
      margin-bottom: 10px;
      padding: 5px 0;
      background-color: var(--panel-bg);
      gap: 2px;
      /* Small gap between legend items */
    }

    .mission-schedule-legend-item {
      display: flex;
      align-items: center;
      text-align: center;
      padding: 3px 5px;
      justify-content: center;
      font-size: 11px;
      font-weight: bold;
      border-radius: 4px;
      height: 22px;
      cursor: pointer;
      transition: transform 0.2s ease-in-out, box-shadow var(--transition-speed) ease;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }

    .mission-schedule-legend-item.active {
      box-shadow: 0 0 8px rgba(var(--accent-color-rgb), 0.7);
      transform: scale(1.05);
      outline: 1px solid var(--accent-color);
      outline-offset: -1px;
      opacity: 1;
    }

    .mission-schedule-legend-item.inactive {
      opacity: 0.4;
      /* Make it look grayed out / faded */
      /* Optionally, change background to a neutral gray if colors clash with opacity */
      /* background-color: var(--border-color) !important; */
      /* color: var(--text-muted-color) !important; */
    }

    .mission-schedule-legend-item.isolated {
      opacity: 1;
      border: 2px solid var(--accent-color) !important;
      /* Highlight with an accent border */
      box-shadow: 0 0 8px rgba(var(--accent-color-rgb), 0.5);
      /* Colors are still from data-mTag specific rules */
    }

    .mission-schedule-legend-item:hover {
      transform: scale(1.05);
      opacity: 0.9;
    }

    /* For Mission Schedule Blocks and Legend Items */
    .mission-schedule-mission[data-mTag="CAP"],
    .mission-schedule-legend-item[data-mTag="CAP"] {
      background-color: var(--mission-tag-cap-bg);
      color: var(--mission-tag-cap-text);
    }

    .mission-schedule-mission[data-mTag="OCA"],
    .mission-schedule-legend-item[data-mTag="OCA"] {
      background-color: var(--mission-tag-oca-bg);
      color: var(--mission-tag-oca-text);
    }

    .mission-schedule-mission[data-mTag="DCA"],
    .mission-schedule-legend-item[data-mTag="DCA"] {
      background-color: var(--mission-tag-dca-bg);
      color: var(--mission-tag-dca-text);
    }

    .mission-schedule-mission[data-mTag="ASW"],
    .mission-schedule-legend-item[data-mTag="ASW"] {
      background-color: var(--mission-tag-asw-bg);
      color: var(--mission-tag-asw-text);
    }

    .mission-schedule-mission[data-mTag="CAS"],
    .mission-schedule-legend-item[data-mTag="CAS"] {
      background-color: var(--mission-tag-cas-bg);
      color: var(--mission-tag-cas-text);
    }

    .mission-schedule-mission[data-mTag="SEAD"],
    .mission-schedule-legend-item[data-mTag="SEAD"] {
      background-color: var(--mission-tag-sead-bg);
      color: var(--mission-tag-sead-text);
    }

    .mission-schedule-mission[data-mTag="SEA"],
    .mission-schedule-legend-item[data-mTag="SEA"] {
      background-color: var(--mission-tag-sea-bg);
      color: var(--mission-tag-sea-text);
    }

    .mission-schedule-mission[data-mTag="AEW"],
    .mission-schedule-legend-item[data-mTag="AEW"] {
      background-color: var(--mission-tag-aew-bg);
      color: var(--mission-tag-aew-text);
    }

    .mission-schedule-mission[data-mTag="C2"],
    .mission-schedule-legend-item[data-mTag="C2"] {
      background-color: var(--mission-tag-c2-bg);
      color: var(--mission-tag-c2-text);
    }

    .mission-schedule-mission[data-mTag="EW"],
    .mission-schedule-legend-item[data-mTag="EW"] {
      background-color: var(--mission-tag-es-bg);
      color: var(--mission-tag-es-text);
    }

    .mission-schedule-mission[data-mTag="REC"],
    .mission-schedule-legend-item[data-mTag="REC"] {
      background-color: var(--mission-tag-rec-bg);
      color: var(--mission-tag-rec-text);
    }

    .mission-schedule-mission[data-mTag="AR"],
    .mission-schedule-legend-item[data-mTag="AR"] {
      background-color: var(--mission-tag-ar-bg);
      color: var(--mission-tag-ar-text);
    }

    .mission-schedule-mission[data-mTag="INT"],
    .mission-schedule-legend-item[data-mTag="INT"] {
      background-color: var(--mission-tag-int-bg);
      color: var(--mission-tag-int-text);
    }

    .mission-schedule-mission[data-mTag="STRAT"],
    .mission-schedule-legend-item[data-mTag="STRAT"] {
      background-color: var(--mission-tag-strat-bg);
      color: var(--mission-tag-strat-text);
    }

    .mission-schedule-mission[data-mTag="MARSTR"],
    .mission-schedule-legend-item[data-mTag="MARSTR"] {
      background-color: var(--mission-tag-marstr-bg);
      color: var(--mission-tag-marstr-text);
    }

    .mission-schedule-mission[data-mTag="SUP"],
    .mission-schedule-legend-item[data-mTag="SUP"] {
      background-color: var(--mission-tag-sup-bg);
      color: var(--mission-tag-sup-text);
    }

    .mission-schedule-mission[data-mTag="Patrol"],
    .mission-schedule-legend-item[data-mTag="Patrol"] {
      background-color: var(--mission-tag-patrol-bg);
      color: var(--mission-tag-patrol-text);
    }

    .mission-schedule-mission[data-mTag="Strike"],
    .mission-schedule-legend-item[data-mTag="Strike"] {
      background-color: var(--mission-tag-strike-bg);
      color: var(--mission-tag-strike-text);
      border: 1px solid var(--mission-tag-strike-border);
    }

    .mission-schedule-mission[data-mTag="Unknown"],
    .mission-schedule-legend-item[data-mTag="Unknown"] {
      background-color: var(--mission-tag-unknown-bg);
      color: var(--mission-tag-unknown-text);
      border: 1px dashed var(--mission-tag-unknown-border);
    }


    #mission-schedule-currentDate {
      font-size: 1.2rem;
      font-weight: 500;
      color: var(--text-color);
      min-width: 120px;
      text-align: center;
    }

    .mission-list-table-title {
      font-size: 1.1rem;
      color: var(--accent-color);
      margin-bottom: 10px;
      padding-bottom: 5px;
      border-bottom: 1px solid var(--border-color);
    }

    /* Add these to your main <style> block */

    .mission-card {
      background-color: var(--panel-bg);
      border: 1px solid var(--border-color);
      border-radius: 6px;
      padding: 12px 15px;
      transition: box-shadow var(--transition-speed) ease;
      height: 100%%;
      /* For equal height cards in a Bootstrap row, if desired */
      display: flex;
      /* Allow flexbox for internal card layout */
      flex-direction: column;
      /* Stack header, summary, details vertically */
    }

    .mission-card:hover {
      box-shadow: 0 0 10px rgba(var(--accent-color-rgb), 0.3);
    }

    .mission-card-header {
      margin-bottom: 10px;
      justify-content: space-between;
    }

    .mission-card-header .mission-name {
      font-size: 1.1rem;
      color: var(--text-color);
      /* Making mission name more prominent */
      font-weight: 500;
      margin-right: 10px;
    }

    .mission-card-header .mission-name-link {
      color: inherit;
      /* Inherit color from h5 */
      text-decoration: none;
    }

    .mission-card-header .mission-name-link:hover {
      color: var(--accent-color);
    }

    #filtered-missions-stats {
      margin: auto;
      padding-bottom: 5px;
      align-content: center;
    }

    #missions-table-summary {
      /* The main container for the mission summary */
      font-size: 0.85em;
      margin-top: 10px !important;
      padding: 10px 15px !important;
    }

    /* Title for the entire summary section "Filtered Missions Overview" */
    #missions-table-summary>.info-card-title {
      font-size: 1rem;
      margin-bottom: 10px;
      color: var(--text-muted-color);
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 5px;
    }

    #missions-table-summary>.info-card-title i {
      font-size: 0.9em;
    }


    .mission-tag-badge {
      display: inline-flex;
      /*  Allows flex properties while keeping it inline */
      align-items: center;
      /* Vertically centers the text */
      justify-content: center;
      /* Horizontally centers the text */
      font-size: 0.7rem;
      padding: .3em .5em;
      border-radius: 10px;
      /* Pill shape */
      font-weight: 600;
      text-transform: uppercase;
      /* Default, will be overridden by data-mtag specific styles */
      background-color: var(--text-muted-color);
      color: var(--bg-color);
      /* High contrast with muted color */
      text-align: center;
    }

    .mission-tag-badge[data-mtag="CAP"] {
      color: var(--mission-tag-cap-text);
      background-color: var(--mission-tag-cap-bg);
    }

    .mission-tag-badge[data-mtag="OCA"] {
      color: var(--mission-tag-oca-text);
      background-color: var(--mission-tag-oca-bg);
    }

    .mission-tag-badge[data-mtag="DCA"] {
      color: var(--mission-tag-dca-text);
      background-color: var(--mission-tag-dca-bg);
    }

    .mission-tag-badge[data-mtag="ASW"] {
      color: var(--mission-tag-asw-text);
      background-color: var(--mission-tag-asw-bg);
    }

    .mission-tag-badge[data-mtag="CAS"] {
      color: var(--mission-tag-cas-text);
      background-color: var(--mission-tag-cas-bg);
    }

    .mission-tag-badge[data-mtag="SEAD"] {
      color: var(--mission-tag-sead-text);
      background-color: var(--mission-tag-sead-bg);
    }

    .mission-tag-badge[data-mtag="SEA"] {
      color: var(--mission-tag-sea-text);
      background-color: var(--mission-tag-sea-bg);
    }

    .mission-tag-badge[data-mtag="AEW"] {
      color: var(--mission-tag-aew-text);
      background-color: var(--mission-tag-aew-bg);
    }

    .mission-tag-badge[data-mtag="C2"] {
      color: var(--mission-tag-c2-text);
      background-color: var(--mission-tag-c2-bg);
    }

    .mission-tag-badge[data-mtag="EW"] {
      color: var(--mission-tag-es-text);
      background-color: var(--mission-tag-es-bg);
    }

    .mission-tag-badge[data-mtag="REC"] {
      color: var(--mission-tag-rec-text);
      background-color: var(--mission-tag-rec-bg);
    }

    .mission-tag-badge[data-mtag="AR"] {
      color: var(--mission-tag-ar-text);
      background-color: var(--mission-tag-ar-bg);
    }

    .mission-tag-badge[data-mtag="INT"] {
      color: var(--mission-tag-int-text);
      background-color: var(--mission-tag-int-bg);
    }

    .mission-tag-badge[data-mtag="STRAT"] {
      color: var(--mission-tag-strat-text);
      background-color: var(--mission-tag-strat-bg);
    }

    .mission-tag-badge[data-mtag="MARSTR"] {
      color: var(--mission-tag-marstr-text);
      background-color: var(--mission-tag-marstr-bg);
    }

    .mission-tag-badge[data-mtag="SUP"] {
      color: var(--mission-tag-sup-text);
      background-color: var(--mission-tag-sup-bg);
    }

    .mission-tag-badge[data-mtag="Patrol"] {
      color: var(--mission-tag-patrol-text);
      background-color: var(--mission-tag-patrol-bg);
    }

    .mission-tag-badge[data-mtag="Strike"] {
      color: var(--mission-tag-strike-text);
      background-color: var(--mission-tag-strike-bg);
      border: 1px solid var(--mission-tag-strike-border);
    }

    .mission-tag-badge[data-mtag="Unknown"] {
      color: var(--mission-tag-unknown-text);
      background-color: var(--mission-tag-unknown-bg);
      /* border: 1px dashed var(--mission-tag-unknown-border); /* Add if desired, was not in original for this selector */
    }


    .mission-card-actions .btn-icon {
      padding: 0.2rem 0.4rem;
      font-size: 0.85em;
      line-height: 1;
      color: var(--text-muted-color);
      background-color: transparent;
      border: 1px solid transparent;
    }

    .mission-card-actions .btn-icon:hover {
      color: var(--accent-color);
      background-color: var(--table-row-hover-bg);
      border-color: var(--border-color);
    }

    .mission-card-actions .mission-expand-toggle i {
      transition: transform 0.2s ease-in-out;
    }

    .mission-card-actions .mission-expand-toggle.expanded i {
      transform: rotate(180deg);
    }


    .mission-card-summary {
      font-size: 0.85em;
      padding-bottom: 10px;
      margin-bottom: 10px;
      border-bottom: 1px dashed var(--border-color);
      /* Subtle separator before details */
    }

    .mission-card-summary .col-auto {
      padding-right: 10px;
      /* Space between summary items */
      margin-bottom: 3px;
      /* For wrapping */
    }

    .mission-card-summary strong {
      color: var(--text-color);
    }

    .mission-card-summary .mission-status {
      /* Example: color code status */
      font-weight: bold;
    }

    .mission-card-summary .mission-status.active {
      color: var(--success-color);
    }

    .mission-card-summary .mission-status.planned {
      color: var(--warning-color);
    }


    .mission-card-details {
      padding-top: 5px;

      flex-grow: 1;
      /* If details section contains a table, it might need to grow */
      overflow: hidden;
      /* To contain the table within the card */
    }

    .mission-card-details h6 {
      font-size: 1.05rem;
      color: var(--text-color);
      margin-bottom: 5px;
    }

    .mission-card-details .assigned-units-list {
      max-height: 150px;
      /* Limit height if many units */
      overflow-y: auto;
      padding-left: 15px;
      /* Indent unit list */
    }

    .mission-card-details .assigned-units-list p {
      margin-bottom: 3px;
    }

    .mission-card-details .table-container {
      max-height: 200px;
      /* Or other desired height for the scrollable unit table */
      overflow-y: auto;
      margin-top: 5px;
      border: 1px solid var(--border-color);
      /* Add border around inner table */
      border-radius: 4px;
    }

    .mission-card-details .unit-table th,
    .mission-card-details .unit-table td {
      padding: 6px 8px;
      /* Compact padding */
      white-space: normal;
      /* Allow text to wrap in cells if needed */
      overflow: hidden;
      text-overflow: ellipsis;
    }

    .mission-card-details .unit-table th {
      white-space: nowrap;
      /* Keep headers on one line */
    }

    .mission-card-details .unit-table td[data-col-id="mission"] {
      /* If you had the mission assignment dropdown here, it's probably not needed */
      /* as this table is ALREADY for a specific mission */
      display: none;
    }

    .mission-card-actions .mission-expand-toggle i {
      transition: transform 0.2s ease-in-out;
    }

    .mission-card-actions .mission-expand-toggle.expanded i {
      transform: rotate(180deg);
    }

    /* Add these to your main <style> block */
    .mission-border-cap {
      background-color: var(--mission-tag-cap-bg);
      color: var(--mission-tag-cap-text);
    }

    .mission-border-oca {
      background-color: var(--mission-tag-oca-bg);
      color: var(--mission-tag-oca-text);
    }

    .mission-border-dca {
      background-color: var(--mission-tag-dca-bg);
      color: var(--mission-tag-dca-text);
    }

    .mission-border-asw {
      background-color: var(--mission-tag-asw-bg);
      color: var(--mission-tag-asw-text);
    }

    .mission-border-cas {
      background-color: var(--mission-tag-cas-bg);
      color: var(--mission-tag-cas-text);
    }

    .mission-border-sead {
      background-color: var(--mission-tag-sead-bg);
      color: var(--mission-tag-sead-text);
    }

    .mission-border-sea {
      background-color: var(--mission-tag-sea-bg);
      color: var(--mission-tag-sea-text);
    }

    .mission-border-aew {
      background-color: var(--mission-tag-aew-bg);
      color: var(--mission-tag-aew-text);
    }

    .mission-border-c2 {
      background-color: var(--mission-tag-c2-bg);
      color: var(--mission-tag-c2-text);
    }

    .mission-border-es {
      background-color: var(--mission-tag-es-bg);
      color: var(--mission-tag-es-text);
    }

    .mission-border-rec {
      background-color: var(--mission-tag-rec-bg);
      color: var(--mission-tag-rec-text);
    }

    .mission-border-ar {
      background-color: var(--mission-tag-ar-bg);
      color: var(--mission-tag-ar-text);
    }

    .mission-border-int {
      background-color: var(--mission-tag-int-bg);
      color: var(--mission-tag-int-text);
    }

    .mission-border-strat {
      background-color: var(--mission-tag-strat-bg);
      color: var(--mission-tag-strat-text);
    }

    .mission-border-marstr {
      background-color: var(--mission-tag-marstr-bg);
      color: var(--mission-tag-marstr-text);
    }

    .mission-border-sup {
      background-color: var(--mission-tag-sup-bg);
      color: var(--mission-tag-sup-text);
    }

    .mission-border-strike {
      background-color: var(--mission-tag-strike-bg);
      color: var(--mission-tag-strike-text);
      border-color: var(--mission-tag-strike-border);
    }

    .mission-border-patrol {
      background-color: var(--mission-tag-patrol-bg);
      color: var(--mission-tag-patrol-text);
    }

    .mission-border-unknown {
      background-color: var(--mission-tag-unknown-bg);
      color: var(--mission-tag-unknown-text);
      border-color: var(--mission-tag-unknown-border);
    }

    [class*="mission-border-"]:hover {
      background-color: #114411;
      color: #fafafa;
      border-color: #fafafa;
    }

    #critical-munitions-modal-search {
      background-color: var(--input-bg);
      color: white;
      border-radius: 5px;

    }

    .target-icons-container {
      display: flex;
      gap: 8px;
      /* Space between icons */
      align-items: center;
    }

    .capability-svg-icon {
      width: 1.1em;
      height: 1.1em;
      vertical-align: middle;
      /* Better alignment with text if any */
      fill: currentColor;
      /* SVG will inherit the text color */
    }

    .target-icons-container .fas {
      font-size: 1.1em;
    }

    /* --- TomSelect Dark Theme --- */
    .ts-wrapper {
      min-height: 0px !important;
    }

    .ts-control {
      /* --- REVISED: Flexible Width & Shape --- */
      min-width: 120px;
      /* Set a minimum width */
      max-width: 230px;
      /* Set a maximum width */
      width: auto !important;
      /* Allow it to be flexible */
      border-radius: 12px !important;
      display: flex !important;
      align-items: center;
      position: relative;
      /* Needed for the ::after arrow positioning */

      /* --- REVISED: Padding to make space for the arrow --- */
      padding: 0.2rem 1.7rem 0.2rem 0.6rem !important;
      /* (top, right, bottom, left) */

      /* Other styles remain */
      background: var(--input-bg) !important;
      color: var(--text-color) !important;
      border: 1px solid var(--border-color) !important;
      font-size: 0.8em;
      min-height: 0;
    }

    .ts-control::after {
      content: ' ';
      display: block;
      position: absolute;
      top: 50%%;
      right: 0.75rem;
      /* Position inside the right padding */
      margin-top: -3px;
      /* Vertical centering */
      width: 0;
      height: 0;
      border-style: solid;
      border-width: 5px 5px 0 5px;
      /* Creates the triangle */
      /* --- THIS IS THE FIX --- */
      border-color: currentColor transparent transparent transparent;
      opacity: 0.8;
    }

    .ts-control,
    .ts-control input {
      background: var(--input-bg) !important;
      color: var(--text-color) !important;
      border: 1px solid var(--border-color) !important;
      font-size: 0.8em;
      padding: 0.2rem 0.4rem !important;
      min-height: 0;
      max-width: 145px;
      /* Ensure it doesn't overflow its cell */
      border-radius: 12px !important;
      /* Rounded pill shape */
      display: flex !important;
      /* Use flexbox for alignment */
      align-items: center;
    }

    .ts-control .item {
      display: inline;
      flex-grow: 1;
      /* Allow the item to take up space */
      overflow: hidden;
      text-overflow: ellipsis;
      /* Add ... for long text */
      white-space: nowrap;
      padding-right: 25px !important;
      /* Space before the arrow */
      font-size: 1.15em;
    }




    /* --- TomSelect Dropdown Options Styling (IMPROVED) --- */
    .ts-dropdown {
      background: var(--panel-bg-secondary);
      border: 1px solid var(--text-color);
      z-index: 9999 !important;
      color: var(--text-color) !important;
      position: fixed !important;
      /* Keep this, it's key to breaking out of the container */
      width: max-content !important;
      /* Let it size to its content */
      max-width: 600px !important;
      /* But don't let it get too wide */
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
      border-radius: 5px;
      visibility: hidden;
      /* Hide by default, JS will show it */
    }

    .ts-dropdown-content {
      max-height: 350px;
      overflow-y: auto;
      min-width: 200px;
    }



    .ts-dropdown .option {
      border-bottom: 1px solid var(--input-border-color);

    }

    .ts-dropdown .optgroup-header {
      font-size: 0.9em;
      font-weight: bold;
      color: var(--accent-color);
      cursor: default;
      background-color: var(--table-header-bg);
      padding-left: 10px !important;
    }

    .ts-dropdown .optgroup-header::before {
      margin: 0 !important;
    }

    /* *** IMPROVED: Direction-specific styling *** */
    .ts-dropdown.direction-up {
      transform-origin: bottom;
      /* *** IMPORTANT: Ensure upward dropdowns are properly positioned *** */
      box-shadow: 0 -4px 20px rgba(0, 0, 0, 0.3);
    }

    .ts-dropdown.direction-down {
      transform-origin: top;
      box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
    }

    /* Dropdown option styling (with row separators) */
    .ts-dropdown .option,
    .ts-dropdown .option div {
      color: var(--text-color) !important;
      padding: 8px 14px;
      font-size: 0.9em;
      white-space: nowrap;
      border-bottom: 1px solid var(--input-border-color);
    }

    /* Remove border from the very last option in any group */
    .ts-dropdown .optgroup .option:last-child,
    .ts-dropdown .option:last-child {
      border-bottom: none;
    }

    .ts-dropdown .option.active,
    .ts-dropdown .option:hover {
      background-color: var(--table-row-hover-bg);
    }

    .ts-dropdown .option.active div,
    .ts-dropdown .option:hover div {
      color: var(--text-color) !important;
    }

    .ts-dropdown .option-unassign {
      color: var(--text-color) !important;
      border-bottom: 1px solid var(--border-color);
      font-style: italic;
      font-weight: 500;
    }

    /* *** IMPORTANT: Ensure parent containers don't clip the dropdown *** */

    /* *** IMPORTANT: Alternative approach - create a higher stacking context *** */
    .ts-dropdown[data-placement^="top"] {
      margin-bottom: 4px;
    }

    .ts-dropdown[data-placement^="bottom"] {
      margin-top: 4px;
    }

    /* Specific rules for each Mission Tag */
    .ts-control.ts-control-mtag-cap {
      background-color: var(--mission-tag-cap-bg) !important;
      color: var(--mission-tag-cap-text) !important;
    }

    .ts-control.ts-control-mtag-oca {
      background-color: var(--mission-tag-oca-bg) !important;
      color: var(--mission-tag-oca-text) !important;
    }

    .ts-control.ts-control-mtag-dca {
      background-color: var(--mission-tag-dca-bg) !important;
      color: var(--mission-tag-dca-text) !important;
    }

    .ts-control.ts-control-mtag-asw {
      background-color: var(--mission-tag-asw-bg) !important;
      color: var(--mission-tag-asw-text) !important;
    }

    .ts-control.ts-control-mtag-cas {
      background-color: var(--mission-tag-cas-bg) !important;
      color: var(--mission-tag-cas-text) !important;
    }

    .ts-control.ts-control-mtag-sead {
      background-color: var(--mission-tag-sead-bg) !important;
      color: var(--mission-tag-sead-text) !important;
    }

    .ts-control.ts-control-mtag-sea {
      background-color: var(--mission-tag-sea-bg) !important;
      color: var(--mission-tag-sea-text) !important;
    }

    .ts-control.ts-control-mtag-aew {
      background-color: var(--mission-tag-aew-bg) !important;
      color: var(--mission-tag-aew-text) !important;
    }

    .ts-control.ts-control-mtag-c2 {
      background-color: var(--mission-tag-c2-bg) !important;
      color: var(--mission-tag-c2-text) !important;
    }

    .ts-control.ts-control-mtag-ew {
      background-color: var(--mission-tag-es-bg) !important;
      color: var(--mission-tag-es-text) !important;
    }

    .ts-control.ts-control-mtag-rec {
      background-color: var(--mission-tag-rec-bg) !important;
      color: var(--mission-tag-rec-text) !important;
    }

    .ts-control.ts-control-mtag-ar {
      background-color: var(--mission-tag-ar-bg) !important;
      color: var(--mission-tag-ar-text) !important;
    }

    .ts-control.ts-control-mtag-int {
      background-color: var(--mission-tag-int-bg) !important;
      color: var(--mission-tag-int-text) !important;
    }

    .ts-control.ts-control-mtag-strat {
      background-color: var(--mission-tag-strat-bg) !important;
      color: var(--mission-tag-strat-text) !important;
    }

    .ts-control.ts-control-mtag-marstr {
      background-color: var(--mission-tag-marstr-bg) !important;
      color: var(--mission-tag-marstr-text) !important;
    }

    .ts-control.ts-control-mtag-sup {
      background-color: var(--mission-tag-sup-bg) !important;
      color: var(--mission-tag-sup-text) !important;
    }

    .ts-control.ts-control-mtag-strike {
      background-color: var(--mission-tag-strike-bg) !important;
      color: var(--mission-tag-strike-text) !important;
    }

    .ts-control.ts-control-mtag-patrol {
      background-color: var(--mission-tag-patrol-bg) !important;
      color: var(--mission-tag-patrol-text) !important;
    }

    .ts-control.ts-control-mtag-unknown {
      background-color: var(--mission-tag-unknown-bg) !important;
      color: var(--mission-tag-unknown-text) !important;
      border-color: var(--mission-tag-unknown-border) !important;
    }

    /* --- Tippy.js Custom Mission Tooltip --- */
    .tippy-box[data-theme~='mission-tooltip'] {
      background-color: var(--panel-bg);
      border: 1px solid var(--border-color);
      border-radius: 6px;
      font-family: var(--font-family);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
    }

    .tippy-box[data-theme~='mission-tooltip'] .tippy-content {
      padding: 0;
      color: var(--text-color);
    }

    /* --- NEW: Location Tooltip Styling --- */
    .tippy-box[data-theme~='location-tooltip'] {
      background-color: var(--panel-bg);
      border: 1px solid var(--border-color);
      border-radius: 6px;
      font-family: var(--font-family);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.4);
      max-width: 450px !important;
      /* Allow it to be wider */
    }

    .tippy-box[data-theme~='location-tooltip'] .tippy-content {
      padding: 8px;
      color: var(--text-color);
      text-align: left;
    }

    .location-tooltip-group {
      margin-bottom: 8px;
    }

    .location-tooltip-group:last-child {
      margin-bottom: 0;
    }

    .location-tooltip-header {
      font-weight: bold;
      color: var(--accent-color);
      border-bottom: 1px solid var(--border-color);
      padding-bottom: 4px;
      margin-bottom: 4px;
      display: flex;
      align-items: center;
    }

    .location-tooltip-header .fas {
      margin-right: 6px;
    }

    .location-tooltip-list {
      display: flex;
      flex-wrap: wrap;
      /* Allows unit names to wrap into multiple lines */
      gap: 4px 8px;
      /* Vertical and horizontal gap between items */
      padding-left: 18px;
      /* Indent the unit names under the header */
    }

    .location-tooltip-item {
      background-color: var(--table-header-bg);
      padding: 2px 6px;
      border-radius: 4px;
      font-size: 0.9em;
    }

    .mission-tooltip-content {
      padding: 10px;
      min-width: 280px;
    }

    .mission-tooltip-header {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      margin-bottom: 8px;
      padding-bottom: 8px;
      border-bottom: 1px solid var(--border-color);
    }

    .mission-tooltip-type {
      font-size: 0.9em;
      color: var(--text-muted-color);
    }

    .mission-tooltip-type strong {
      color: var(--text-color);
      display: block;
      font-size: 1.1em;
    }

    .mission-tooltip-body {
      font-size: 0.9em;
      text-align: center;
    }

    .mission-tooltip-body p {
      margin: 4px 0;
    }

    .mission-tooltip-body .fas {
      margin-right: 5px;
      color: var(--accent-color);
    }

    .mission-tooltip-footer {
      margin: auto;
      font-size: 0.8em;
      font-style: italic;
      text-align: center;
    }

    .mission-tooltip-footer .fas {
      margin-right: 5px;
      color: var(--accent-color);
    }

    /* Style for the select dropdowns used as search results */
    #key-asset-config-classname-select,
    #key-asset-config-unit-select {
      position: absolute;
      z-index: 1056;
      /* Ensure it's above other modal content but below modal backdrop */
      width: calc(100%% - 120px);
      /* Adjust based on input-group-text width */
      margin-left: 120px;
      /* Adjust based on input-group-text width */
      top: 100%%;
      /* Position below the input */
      border-top: none;
      border-radius: 0 0 0.25rem 0.25rem;
      max-height: 150px;
      /* Or desired height */
      overflow-y: auto;
      background-color: var(--input-bg);
      /* Match your theme */
      color: var(--text-color);
    }

    #key-asset-config-classname-select option,
    #key-asset-config-unit-select option {
      padding: 0.25rem 0.5rem;
      cursor: pointer;
    }

    #key-asset-config-classname-select option:hover,
    #key-asset-config-unit-select option:hover {
      background-color: var(--accent-color);
      color: var(--bs-white);
      /* Or your hover text color */
    }

    .force-health-summary {
      font-size: 0.9em;
      /* Or whatever suits your header */
      color: var(--text-muted-color);
      /* Default text color */
      margin-left: 15px;
      /* Spacing from time */
      cursor: pointer;
      /* To indicate it's clickable */
      user-select: none;
      /* Prevent text selection on click */
    }

    .force-health-summary .operational-count {
      font-weight: bold;
      /* Color will be set by JS */
    }

    .force-health-summary .critical-count {
      font-weight: bold;
      color: var(--danger-color);
      /* Always red for critical, or set by JS if thresholds apply */
    }

    /* --- NEW: Loading Overlay Styling --- */
    .app-loader-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%%;
      height: 100%%;
      background-color: var(--bg-color);
      /* Match your app's background */
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      z-index: 10000;
      /* Ensure it's on top of everything */
      transition: opacity 0.5s ease;
      color: var(--text-muted-color);
    }

    /* Initially hide the main app containers */
    .app-header,
    .main-container {
      visibility: hidden;
      opacity: 0;
      transition: opacity 0.5s ease;
    }

    /* Class to apply when the app is loaded */
    body.app-loaded .app-header,
    body.app-loaded .main-container {
      visibility: visible;
      opacity: 1;
    }
  </style>
</head>

<body>
  <div id="app-loader" class="app-loader-overlay">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Loading...</span>
    </div>
    <p class="mt-3">Initializing Asset Data...</p>
  </div>
  <header class="app-header">
    <!-- <div class="app-title">
      <i class="fas fa-shield-alt"></i> Unit Management System
    </div> -->
    <div id="main-view-tabs-container">
      <button class="main-view-tab-button active" data-view="overview"><i class="fas fa-tachometer-alt"></i>
        Overview</button>
      <button class="main-view-tab-button" data-view="units"><i class="fas fa-users"></i> Units</button>
      <button class="main-view-tab-button" data-view="missions"><i class="fas fa-bullseye"></i> Missions</button>
      <button class="main-view-tab-button" data-view="weapons"><i class="fas fa-crosshairs"></i> Weapons</button>
    </div>
    <div id="current-time">
      <h5 id="current-scenario-time"></h5>
      <div id="force-health-summary" class="force-health-summary">
        <span id="operational-units-count" class="operational-count">---</span> /
        <span id="total-relevant-units-count">---</span> Online
        (<span id="critical-units-count" class="critical-count">---</span> Critical)
      </div>
    </div>
  </header>

  <div class="main-container">
    <div id="view-content-wrapper">
      <!-- Overview View -->
      <!-- This content will replace the existing content of #overview-view -->
      <div id="overview-view" class="view-content">
        <div id="overview-container" class="row mb-2">
          <div class="col-xl-4 col-lg-6 col-md-12 mb-2">
            <div class="info-card critical-info-card" id="ccir-critical-units-card">
              <div class="info-card-header d-flex justify-content-between align-items-center">
                <h5 class="info-card-title mb-0"><i class="fas fa-exclamation-triangle text-danger me-2"></i>Units
                  w/Operational Issues</h5>
                <button class="btn btn-sm btn-outline-light view-details-btn" data-target-view="units"
                  data-filter-preset="critical_any" title="View All Critical Units">
                  <i class="fas fa-arrow-circle-right"></i>
                </button>
              </div>
              <div id="ccir-critical-units-content" class="info-card-content p-3">
                <!-- JS will populate this -->
                <p class="text-center text-muted-color">Loading critical unit data...</p>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-6 col-md-12 mb-2">
            <div class="info-card critical-info-card" id="ccir-priority-missions-card">
              <div class="info-card-header d-flex justify-content-between align-items-center">
                <h5 class="info-card-title mb-0"><i class="fas fa-bullseye text-warning me-2"></i>Priority Mission Focus
                </h5>
                <button class="btn btn-sm btn-outline-light view-details-btn" data-target-view="missions"
                  data-filter-preset="priority_active_hs" title="View Active High-Value Missions">
                  <i class="fas fa-arrow-circle-right"></i>
                </button>
              </div>
              <div id="ccir-priority-missions-content" class="info-card-content p-3">
                <!-- JS will populate this -->
                <p class="text-center text-muted-color">Loading priority mission data...</p>
              </div>
            </div>
          </div>
          <div class="col-xl-4 col-lg-12 col-md-12 mb-2">
            <div class="info-card critical-info-card" id="ccir-resource-watch-card">
              <div class="info-card-header d-flex justify-content-between align-items-center">
                <h5 class="info-card-title mb-0"><i class="fas fa-pallet text-info me-2"></i>Resource Watchlist</h5>
                <button class="btn btn-sm btn-outline-light view-details-btn" data-target-view="weapons"
                  data-filter-preset="shortage_critical_munitions" title="View Critical Munitions">
                  <i class="fas fa-arrow-circle-right"></i>
                </button>
              </div>
              <div id="ccir-resource-watch-content" class="info-card-content">
                <!-- JS will populate this -->
                <p class="text-center text-muted-color">Loading resource data...</p>
              </div>
              <div class="text-end mt-2"><button class="btn btn-xs btn-outline-info" id="open-critical-munitions-modal-btn">View Full Report</button></div>
            </div>
          </div>
        </div>

        <div class="row mb-3" id="key-assets">
          <div class="col-12">
            <div class="info-card">
              <div class="info-card-header d-flex justify-content-between align-items-center">
                <h5 class="info-card-title mb-0"><i class="fas fa-cogs me-2"></i>Key Asset Availability</h5>
                <button class="btn btn-sm btn-outline-secondary" id="launch-key-asset-config-modal-btn"
                  title="Configure Key Assets Watchlist">
                  <i class="fas fa-plus-circle"></i> Configure
                </button>
              </div>
              <div id="key-asset-availability-content" class="p-3 row" style="min-height: 20px;">
                <p class="text-center text-muted-color col-12">No key assets configured or data loading...</p>
              </div>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-lg-6 col-md-12 mb-4">
            <div class="info-card">
              <div class="info-card-header">
                <h5 class="info-card-title mb-0"><i class="fas fa-chart-pie me-2"></i>Force Readiness Snapshot</h5>
              </div>
              <div class="info-card-content p-3" style="height: 300px;">
                <canvas id="overviewUnitReadinessChart"></canvas>
              </div>
            </div>
          </div>
          <div class="col-lg-6 col-md-12 mb-4">
            <div class="info-card">
              <div class="info-card-header">
                <h5 class="info-card-title mb-0"><i class="fas fa-tasks me-2"></i>Mission Engagement</h5>
              </div>
              <div class="info-card-content p-3" style="height: 300px;">
                <canvas id="overviewMissionStatusChart"></canvas>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Units View -->
      <div id="units-view" class="view-content">
        <div id="units-filter-bar" class="filter-bar-container ">

          <div class="filter-group">
            <input type="text" id="unit-search" style="min-width:200px;" class="form-control"
              placeholder="Search units...">
          </div>
          <div class="filter-group">
            <label for="unit-ncu-filter" data-bs-toggle="tooltip" data-bs-placement="top"
              title="Show Non Combatant Units">NCU:</label>
            <input type="checkbox" id="unit-ncu-filter" class="form-check-input" style="margin-top:0.1em;">
          </div>
          <div class="filter-group">
            <!-- <label for="unit-type-filter">Type:</label> -->
            <select id="unit-type-filter" class="form-select">
              <option value="">All Types</option>
            </select>
          </div>
          <!-- <div class="filter-group">
             <label for="unit-subtype-filter">Subtype:</label> 
            <select id="unit-subtype-filter" class="form-select">
              <option value="">All Subtypes</option>
            </select>
          </div>-->
          <div class="filter-group">
            <select id="unit-mission-mtype-filter" class="form-select form-select-sm" title="Mission Type">
              <option value="">All Mission Types</option>
            </select>
          </div>
          <div class="filter-group" style="max-width:250px;">
            <!-- <label for="unit-mission-filter">Mission:</label> -->
            <select id="unit-mission-filter" class="form-select">
              <option value="">All Missions</option>
            </select>
          </div>
          <div class="filter-group">
            <!-- <label for="unit-base-filter">Base:</label> -->
            <select id="unit-base-filter" class="form-select">
              <option value="">All Bases</option>
            </select>
          </div>
          <div class="filter-group">
            <select id="unit-status-filter" class="form-select form-select-sm" title="Status">
              <option value="">All Status</option>
            </select>
          </div>
          <div class="filter-group">
            <select id="unit-loadout-role-filter" class="form-select form-select-sm" title="Loadout Role (Aircraft)">
              <option value="">All Load. Roles</option>
            </select>
          </div>
          <div class="filter-group">
            <label for="unit-hide-unavailable-filter" data-bs-toggle="tooltip" data-bs-placement="top"
              title="Hide Unavailable">Hide Unavail</label>
            <input type="checkbox" id="unit-hide-unavailable-filter" class="form-check-input" style="margin-top:0.1em;"
              checked>
          </div>
          <div class="col-md-auto col-sm-12 mt-2 mt-md-0">
            <button class="btn btn-secondary btn-sm" id="clear-units-filters-btn" title="Clear All Unit Filters">
              <i class="fas fa-eraser"></i> <span class="d-none d-lg-inline"></span>
            </button>
          </div>
          <div class="ms-auto filter-group">
            <div class="dropdown">
              <button class="btn btn-secondary dropdown-toggle" type="button" id="unitsTableColumnToggler"
                data-bs-toggle="dropdown" aria-expanded="false">
                <i class="fas fa-cog"></i>
              </button>
              <ul class="dropdown-menu dropdown-menu-end column-toggler-dropdown"
                aria-labelledby="unitsTableColumnToggler" id="units-column-toggler-menu">
              </ul>
            </div>
          </div>
        </div>
        <!-- UNIT TABLE -->
        <div class="scrollable-table-wrapper">
          <div class="table-container" id="unit-table-div">
            <table class="unit-table" id="units-table">
              <thead>
                <tr>
                  <th class="unit-checkbox-cell">
                    <input class="form-check-input" type="checkbox" id="unit-select-all-checkbox"
                      title="Select All/None">
                  </th>
                  <th scope="col" data-sort="id" data-col-id="id" data-col-name="Unit ID">Unit ID <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="name" data-col-id="name" data-col-name="Name">Name <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="classname" data-col-id="classname" data-col-name="Classname">Class <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="unitType" data-col-id="unitType" data-col-name="Type">Type <i
                      class="fas fa-sort"></i>
                  </th>
                  <th scope="col" data-sort="unitSubtype" data-col-id="unitSubtype" data-col-name="Subtype">Subtype <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="mission" data-col-id="mission" data-col-name="Mission">Mission <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="base" data-col-id="base" data-col-name="Base">Base <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="condition" data-col-id="condition" data-col-name="Status">Status <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="loadoutRole" data-col-id="loadoutRole" data-col-name="Loadout">Loadout<i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="integrity" data-col-id="integrity" data-col-name="Integrity">HEALTH <i
                      class="fas fa-sort"></i></th>
                  <th scope="col" data-sort="fuel_status" data-col-id="fuel" data-col-name="Fuel">Fuel <i
                      class="fas fa-sort"></i>
                  </th>
                  <th scope="col" data-sort="proficiency" data-col-id="proficiency" data-col-name="Proficiency">
                    Proficiency <i class="fas fa-sort"></i></th>
                  <th scope="col" data-col-id="actions" data-col-name="Actions">Actions</th>
                </tr>
              </thead>
              <tbody id="units-table-body">
              </tbody>
            </table>
          </div>

          <div id="batch-action-info" class="mt-2 mb-2 p-2"
            style="display:none; background-color: var(--panel-bg-lighter); border: 1px solid var(--border-color); border-radius: 4px;">
            <!-- Content populated by JS -->
          </div>


        </div>
        <div id="units-table-summary" class="mt-3 p-3 summary-below-table"
          style="background-color: var(--panel-bg); border: 1px solid var(--border-color); border-radius: 4px;">
          <h5 class="info-card-title" style="margin-bottom: 10px; font-size: 1rem;">
            <i class="fas fa-chart-bar me-1"></i>Filtered Units Overview
          </h5>
          <div id="filtered-units-stats" class="row">

          </div>
        </div>
      </div>

      <!-- Missions View -->
      <div id="missions-view" class="view-content">
        <div class="inner-tab-headers" id="missions-inner-tabs">
          <button class="inner-tab-button active" data-bs-target="#mission-list-view-pane"
            data-tab-group="missions">List View</button>
          <button class="inner-tab-button" data-bs-target="#mission-schedule-view-pane"
            data-tab-group="missions">Schedule View</button>
        </div>

        <div class="inner-tab-content">
          <!-- Mssion Table View -->
          <div class="inner-tab-pane active" id="mission-list-view-pane">
            <div id="missions-filter-bar" class="filter-bar-container"> <!-- Moved here -->
              <div class="filter-group" style="min-width: 250px;">
                <input type="text" id="mission-search-input" class="form-control form-control-sm"
                  placeholder="Search mission...">
              </div>
              <div class="filter-group">
                <label for="mission-filter-taskpool">Task Pool:</label> <!-- NEW -->
                <select id="mission-filter-taskpool" class="form-select">
                  <option value="">All Task Pools</option>
                </select>
              </div>
              <div class="filter-group">
                <label for="mission-filter-mtype">Type:</label>
                <select id="mission-filter-mtype" class="form-select">
                  <option value="">All Mission Types</option>
                </select>
              </div>
              <div class="filter-group">
                <label for="mission-filter-mtag">Tag:</label>
                <select id="mission-filter-mtag" class="form-select">
                  <option value="">All Tags</option>
                </select>
              </div>
              <div class="d-flex justify-content-end">
                <button class="btn btn-sm btn-outline-info" id="overview-show-help-modal-btn"
                  title="Mission Tagging Help">
                  <i class="fas fa-question-circle"></i>
                </button>
              </div>
              <div class="filter-group">
                <label for="mission-filter-msubtype">Subtype:</label>
                <select id="mission-filter-msubtype" class="form-select">
                  <option value="">All Subtypes</option>
                </select>
              </div>
              <div class="filter-group">
                <label for="mission-filter-status">Subtype:</label>
                <select id="mission-filter-status" class="form-select">
                  <option value="">All Status</option>
                </select>
              </div>
              <div class="col-md-auto mt-2 mt-md-0">
                <button class="btn btn-secondary btn-sm" id="clear-missions-filters-btn"
                  title="Clear All Mission Filters">
                  <i class="fas fa-eraser"></i> <span class="d-none d-lg-inline"></span>
                </button>
              </div>
              <div class="ms-auto filter-group">
                <div class="dropdown">
                  <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="missionsTableColumnToggler"
                    data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-cog"></i> <span class="d-none d-lg-inline"></span>
                  </button>
                  <ul class="dropdown-menu dropdown-menu-end column-toggler-dropdown dropdown-menu-end"
                    aria-labelledby="missionsTableColumnToggler" id="missions-column-toggler-menu">
                    <!-- Placeholder for status/priority, can be added back if data supports -->
                  </ul>
                </div>
              </div>
            </div>
            <!-- MISSION TABLE -->

            <div class="scrollable-table-wrapper">

              <div class="table-container" id="main-missions-table-container">
                <table class="unit-table" id="main-missions-table">
                  <thead>
                    <tr>
                      <th scope="col" data-sort-mission="name" data-col-id="name" data-col-name="Mission Name">Name <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="taskPool" data-col-id="taskPool" data-col-name="Task Pool">Task
                        Pool <i class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="status" data-col-id="status" data-col-name="Status">Status <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="mType" data-col-id="mType" data-col-name="Type">Type <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="mTag" data-col-id="mTag" data-col-name="Tag">Tag <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="mSubType" data-col-id="mSubType" data-col-name="Subtype">
                        Subtype <i class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="assignedUnitsCount" data-col-id="units"
                        data-col-name="# Units"># Units <i class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="startT" data-col-id="startT" data-col-name="Start">Start <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="endT" data-col-id="endT" data-col-name="End">End <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-mission="ToT" data-col-id="ToT" data-col-name="ToT">ToT <i
                          class="fas fa-sort"></i>
                      </th>
                      <th scope="col" data-col-id="actions" data-col-name="Actions">Actions</th>
                    </tr>
                  </thead>
                  <tbody id="main-missions-table-body">

                  </tbody>
                </table>
              </div>

            </div>
            <!-- MISSION RESUME -->
            <div id="missions-table-summary" class="mt-3 p-3 summary-below-table"
              style="background-color: var(--panel-bg); border: 1px solid var(--border-color); border-radius: 4px;">
              <h5 class="info-card-title" style="margin-bottom: 10px; font-size: 1rem;">
                <i class="fas fa-chart-pie me-1"></i>Filtered Missions Overview
              </h5>
              <div id="filtered-missions-stats" class="row">
              </div>
            </div>
          </div><!-- END Mission Table view -->
          <div class="inner-tab-pane" id="mission-schedule-view-pane">
            <div id="mission-schedule-controls">
              <button id="schedule-prevHour">◀ -1H</button>
              <span id="mission-schedule-currentDate"></span>
              <button id="schedule-toggleTimespan">24-Hour</button>
              <button id="schedule-nextHour">+1H ▶</button>
            </div>
            <div id="mission-schedule-container">
              <div id="mission-timeline-labels" class="schedule-grid"></div>
              <div id="mission-timeline-grid" class="schedule-grid"></div>
              <div id="mission-legend-row" class="schedule-grid" data-toggle="tooltip" data-placement="top"
                title="Click to toggle, double-click to isolate."></div>
              <div id="mission-taskPools"></div>
            </div>
          </div>
        </div>
      </div>

      <!-- Weapons View -->
      <div id="weapons-view" class="view-content">

        <div class="inner-tab-headers" id="weapons-inner-tabs">
          <button class="inner-tab-button active" data-bs-target="#weapon-table-view-pane"
            data-tab-group="weapons">Table View</button>
          <button class="inner-tab-button" data-bs-target="#weapon-map-view-pane" data-tab-group="weapons">Map
            View</button>
        </div>
        <div class="inner-tab-content">
          <div class="inner-tab-pane active" id="weapon-table-view-pane">
            <div id="weapons-filter-bar" class="filter-bar-container">
              <div class="filter-group">
                <input type="text" id="weapon-search" class="form-control" placeholder="Search weapons...">
              </div>
              <div class="filter-group">
                <label for="weapon-type-filter">Category:</label>
                <select id="weapon-type-filter" class="form-select">
                  <option value="">All Categories</option>
                </select>
              </div>
              <div class="filter-group">
                <label for="weapon-targets-filter">Targets:</label>
                <select id="weapon-targets-filter" class="form-select">
                  <option value="">All Targets</option>
                  <!-- Options populated by JS -->
                </select>
              </div>
              <div class="filter-group">
                <label for="weapon-base-filter">Base:</label>
                <select id="weapon-base-filter" class="form-select">
                  <option value="">All Bases/Units</option>
                </select>
              </div>
              <div class="col-md-auto mt-2 mt-md-0">
                <button class="btn btn-secondary btn-sm" id="clear-weapons-filters-btn"
                  title="Clear All Weapon Filters">
                  <i class="fas fa-eraser"></i> <span class="d-none d-lg-inline"></span>
                </button>
              </div>
              <div class="ms-auto filter-group">
                <div class="dropdown">
                  <button class="btn btn-secondary dropdown-toggle" type="button" id="weaponsTableColumnToggler"
                    data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-cog"></i>
                  </button>
                  <ul class="dropdown-menu dropdown-menu-end column-toggler-dropdown"
                    aria-labelledby="weaponsTableColumnToggler" id="weapons-column-toggler-menu">
                  </ul>
                </div>
              </div>
            </div>
            <div class="scrollable-table-wrapper">
              <div class="table-container" id="weapons-table-div">
                <table class="unit-table" id="weapons-table">
                  <thead>
                    <tr>
                      <th scope="col" data-sort-weapon="name" data-col-id="name" data-col-name="Weapon Name">Name <i
                          class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-weapon="quantity" data-col-id="quantity" data-col-name="Total Qty">Qty
                        <i class="fas fa-sort"></i>
                      </th>
                      <th scope="col" data-sort-weapon="category" data-col-id="category" data-col-name="Category">
                        Category <i class="fas fa-sort"></i></th>
                      <th scope="col" data-sort-weapon="targets" data-col-id="targets" data-col-name="Targets">Targets
                        <i class="fas fa-sort"></i>
                      </th>
                      <th scope="col" data-sort-weapon="effectiveRange" data-col-id="effectiveRange"
                        data-col-name="Range">Range <i class="fas fa-sort"></i></th>
                      <th scope="col" data-col-id="locations" data-col-name="Locations">Locations</th>
                    </tr>
                  </thead>
                  <tbody id="weapons-table-body">
                  </tbody>
                </table>
              </div>
            </div>
            <div id="weapons-table-summary" class="mt-1 p-2"
              style="background-color: var(--panel-bg); border: 1px solid var(--border-color); border-radius: 4px;">
              <div id="filtered-weapons-stats" class="row">

              </div>
            </div>
          </div>
          <div class="inner-tab-pane" id="weapon-map-view-pane">
            <div id="weaponMap"></div>
            <p class="text-muted-color" style="font-size: 0.9em; margin-top: 15px;">Visualizing weapon distribution.
              Markers indicate units or aggregated aircraft weapon stockpiles at bases.</p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- Modals -->


  <div class="modal fade" id="welcomeHelpModal" tabindex="-1" aria-labelledby="welcomeHelpModalLabel" aria-hidden="true"
    data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="welcomeHelpModalLabel">
            <i class="fas fa-info-circle me-2"></i>Mission Tagging System Overview
          </h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"
            id="welcomeModalCloseButton"></button>
        </div>
        <div class="modal-body">
          <p>This Unit Management Window uses a hybrid system to categorize missions with specific <strong>Tags</strong>
            for quick identification and filtering. Tags are determined based on the mission's Type, Subtype, and
            keywords found in the mission name.</p>
          <p>Here's how tags are generally assigned:</p>

          <div class="accordion" id="missionTagHelpAccordion">
            <div class="accordion-item">
              <h2 class="accordion-header" id="headingSupport">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                  data-bs-target="#collapseSupport" aria-expanded="false" aria-controls="collapseSupport">
                  <i class="fas fa-headset me-2"></i>Support Missions
                </button>
              </h2>
              <div id="collapseSupport" class="accordion-collapse collapse" aria-labelledby="headingSupport"
                data-bs-parent="#missionTagHelpAccordion">
                <div class="accordion-body">
                  If the mission type is "Support", tags are determined by keywords in the mission name:
                  <ul>
                    <li><code>#ISR</code>, <code>#REC</code> → <strong>REC</strong> (Reconnaissance)</li>
                    <li><code>#ECM</code>, <code>#ELINT</code>, <code>#ES</code>, <code>#SIG</code>, <code>#EA</code> →
                      <strong>EW</strong> (Electronic Warfare)
                    </li>
                    <li><code>#AAR</code>, <code>#REFUEL</code> → <strong>AR</strong> (Aerial Refueling)</li>
                    <li><code>#AEW</code> → <strong>AEW</strong> (Airborne Early Warning)</li>
                    <li><code>#ACP</code>, <code>#C2</code>, <code>#ABCCC</code> → <strong>C2</strong> (Command &
                      Control)</li>
                    <li>If no specific keywords, defaults to <strong>SUP</strong> (General Support).</li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="headingPatrol">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                  data-bs-target="#collapsePatrol" aria-expanded="false" aria-controls="collapsePatrol">
                  <i class="fas fa-binoculars me-2"></i>Patrol Missions
                </button>
              </h2>
              <div id="collapsePatrol" class="accordion-collapse collapse" aria-labelledby="headingPatrol"
                data-bs-parent="#missionTagHelpAccordion">
                <div class="accordion-body">
                  If the mission type is "Patrol", further analysis of subtype and name yields:
                  <ul>
                    <li>Subtype includes "SEAD" OR <code>#SEAD</code> in name → <strong>SEAD</strong></li>
                    <li>Subtype includes "ASW" OR <code>#ASW</code> in name → <strong>ASW</strong> (Anti-Submarine
                      Warfare)</li>
                    <li>Subtype includes "Sea Control" OR "Naval" → <strong>SEA</strong> (Sea Control)</li>
                    <li>Subtype includes "Ground" OR <code>#CAS</code> in name → <strong>CAS</strong> (Close Air
                      Support)</li>
                    <li>For "AAW Patrol" subtypes:
                      <ul>
                        <li><code>#OCA</code> in name → <strong>OCA</strong> (Offensive Counter-Air)</li>
                        <li><code>#DCA</code> in name → <strong>DCA</strong> (Defensive Counter-Air)</li>
                        <li>Otherwise, defaults to <strong>CAP</strong> (Combat Air Patrol).</li>
                      </ul>
                    </li>
                    <li>If no specific subtype match above, may default to a general Patrol tag or CAP.</li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="headingStrike">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                  data-bs-target="#collapseStrike" aria-expanded="false" aria-controls="collapseStrike">
                  <i class="fas fa-crosshairs me-2"></i>Strike Missions
                </button>
              </h2>
              <div id="collapseStrike" class="accordion-collapse collapse" aria-labelledby="headingStrike"
                data-bs-parent="#missionTagHelpAccordion">
                <div class="accordion-body">
                  If the mission type is "Strike":
                  <ul>
                    <li>Subtype includes "Land Strike":
                      <ul>
                        <li><code>#INT</code> or <code>#AI</code> in name → <strong>INT</strong> (Interdiction)</li>
                        <li><code>#OCA</code> in name → <strong>OCA</strong> (Offensive Counter-Air)</li>
                        <li>Otherwise (general land strike) → <strong>STRAT</strong> (Strategic/Deep Strike)</li>
                      </ul>
                    </li>
                    <li>Subtype includes "Maritime Strike" OR "Naval" → <strong>MARSTR</strong> (Maritime Strike)</li>
                    <li>Subtype includes "ASW Strike" → <strong>ASW</strong> (Anti-Submarine Warfare Attack)</li>
                    <li>Subtype includes "Air Interception Strike" or similar → <strong>DCA</strong> (Defensive Counter
                      Air - Strike Context)</li>
                  </ul>
                </div>
              </div>
            </div>

            <div class="accordion-item">
              <h2 class="accordion-header" id="headingCargoFerry">
                <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                  data-bs-target="#collapseCargoFerry" aria-expanded="false" aria-controls="collapseCargoFerry">
                  <i class="fas fa-truck-loading me-2"></i>Cargo and Ferry Missions
                </button>
              </h2>
              <div id="collapseCargoFerry" class="accordion-collapse collapse" aria-labelledby="headingCargoFerry"
                data-bs-parent="#missionTagHelpAccordion">
                <div class="accordion-body">
                  Missions with type "Cargo" or "Ferry" typically default to the <strong>SUP</strong> (Support) tag.
                </div>
              </div>
            </div>
          </div>
          <hr>
          <p class="mt-3 text-muted-color"><small>This window provides a consolidated view of your assets. For detailed
              tactical interactions, please refer to the main map display and specialized editor windows.</small></p>
        </div>
        <div class="modal-footer">

          <button type="button" class="btn btn-primary" data-bs-dismiss="modal" id="welcomeModalGotItButton">Got
            it!</button>
        </div>
      </div>
    </div>
  </div>
  <!-- Key Asset Configuration Modal -->
  <div class="modal fade" id="keyAssetConfigModal" tabindex="-1" aria-labelledby="keyAssetConfigModalLabel"
    aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="keyAssetConfigModalLabel"><i class="fas fa-cogs me-2"></i>Configure Key Assets
            Watchlist</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-3">
            <h6>Add Asset to Watchlist:</h6>
            <div class="input-group mb-2">
              <span class="input-group-text" style="min-width: 120px;">Add by:</span>
              <select id="key-asset-add-method" class="form-select form-select-sm">
                <option value="classname">Classname</option>
                <option value="specific_unit">Specific Unit</option>
              </select>
            </div>

            <!-- Fields for adding by Classname -->
            <div id="key-asset-add-by-classname-fields">
              <div class="input-group mb-2">
                <span class="input-group-text" style="min-width: 120px;">Unit Type:</span>
                <select id="key-asset-config-type-for-class" class="form-select form-select-sm">
                  <option value="">-- Select Type --</option>
                  <!-- Populated by JS -->
                </select>
              </div>
              <div class="input-group mb-2">
                <span class="input-group-text" style="min-width: 120px;">Classname:</span>
                <input type="text" id="key-asset-config-classname-search" class="form-control form-control-sm"
                  placeholder="Search & select classname...">
                <select id="key-asset-config-classname-select" class="form-select form-select-sm d-none">
                  <option value="">-- Select Classname --</option>
                  <!-- Populated by JS based on Type and search -->
                </select>
              </div>
            </div>

            <!-- Fields for adding by Specific Unit -->
            <div id="key-asset-add-by-unit-fields" style="display:none;">
              <div class="input-group mb-2">
                <span class="input-group-text" style="min-width: 120px;">Unit Name/ID:</span>
                <input type="text" id="key-asset-config-unit-search" class="form-control form-control-sm"
                  placeholder="Search by Unit Name or ID...">
                <select id="key-asset-config-unit-select" class="form-select form-select-sm d-none">
                  <option value="">-- Select Unit --</option>
                  <!-- Populated by JS based on search -->
                </select>
              </div>
            </div>
            <button id="modal-add-key-asset-btn" class="btn btn-sm btn-primary"><i class="fas fa-plus me-1"></i>Add to
              Watchlist</button>
          </div>
          <hr>
          <h6>Current Watchlist:</h6>
          <div id="modal-current-key-assets-watchlist" class="mt-2">
            <!-- List of currently watched assets with remove buttons -->
            <p class="text-muted-color small">No assets currently on watchlist.</p>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <!-- Optionally a "Save Watchlist" button if sending to backend -->
        </div>
      </div>
    </div>
  </div>
  <!-- Critical Munitions Detail Modal -->
  <div class="modal fade" id="criticalMunitionsDetailModal" tabindex="-1"
    aria-labelledby="criticalMunitionsDetailModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-xl modal-dialog-scrollable">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="criticalMunitionsDetailModalLabel"><i class="fas fa-pallet me-2"></i>Detailed
            Critical Munitions Report</h5>
          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
        </div>
        <div class="modal-body">
          <div class="mb-2">
            <input type="text" id="critical-munitions-modal-search" class="form-control form-control-sm"
              placeholder="Filter report by munition, platform, or reason...">
          </div>
          <div class="table-responsive">
            <table class="unit-table" id="critical-munitions-detail-table">
              <thead>
                <tr>
                  <th scope="col" data-sort-modal="base">Base<i class="fas fa-sort"></i></th>
                  <th scope="col" data-sort-modal="munition">Munition<i class="fas fa-sort"></i></th>
                  <th scope="col" data-sort-modal="platformClass">Platform<i class="fas fa-sort"></i></th>
                  <th scope="col" data-sort-modal="AC">#AC<i class="fas fa-sort"></i></th>
                  <th scope="col" data-sort-modal="maxSorties">Max Sorties<i class="fas fa-sort"></i></th>
                  <th scope="col" data-sort-modal="currentQty">Current Qty <i class="fas fa-sort"></i></th>
                  <th scope="col" data-sort-modal="detail">Mun per Sortie<i class="fas fa-sort"></i></th>

                </tr>
              </thead>
              <tbody id="critical-munitions-detail-table-body"></tbody>
            </table>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
  <script>
    const loadoutRoleEnum = {
      1001: "None",
      2001: "BVR Intercept",
      2002: "WVR Intercept",
      2003: "BVR Air Superiority",
      2004: "WVR Air Superiority",
      2005: "BVR Point Defence",
      2006: "WVR Point Defence",
      2007: "Guns Only",
      2101: "Anti-Satellite Intercept",
      2102: "Airborne Laser",
      3001: "Land/Naval Strike",
      3002: "Land/Naval Standoff",
      3003: "Land/Naval SEAD (ARM)",
      3004: "Land/Naval SEAD (TALD)",
      3005: "Land/Naval DEAD",
      3101: "Land Strike",
      3102: "Land Standoff",
      3103: "Land SEAD (ARM)",
      3104: "Land SEAD (TALD)",
      3105: "Land DEAD",
      3201: "Naval Strike",
      3202: "Naval Standoff",
      3203: "Naval SEAD (ARM)",
      3204: "Naval SEAD (TALD)",
      3205: "Naval DEAD",
      3401: "BAI / CAS",
      3501: "Buddy Illumination",
      4001: "OECM (Jamming)",
      4002: "AEW (Early Warning)",
      4003: "Command Post",
      4004: "Chaff Laying",
      4101: "Search & Rescue",
      4102: "Combat Search & Rescue",
      4201: "Mine Sweeping",
      4202: "Mine Recon",
      4301: "Naval Mine Laying",
      6001: "ASW Patrol",
      6002: "ASW Attack",
      7001: "Forward Observer",
      7002: "Area Surveillance",
      7003: "Armed Recon",
      7004: "Unarmed Recon",
      7005: "Maritime Surveillance",
      7101: "Paratroopers",
      7102: "Troop Transport",
      7201: "Cargo",
      8001: "Air Refueling",
      8101: "Training",
      8102: "Target Tow",
      8103: "Target Drone",
      9001: "Ferry",
      9002: "Unavailable",
      9003: "Reserve",
      9004: "Armed Ferry"
    };

    function getLoadoutRoleText(roleId) {
      return loadoutRoleEnum[roleId] || "Unknown Role";
    }
    const uTypes = {
      'Facility': {
        "1001": "None",
        "2001": "Radar",
        "3001": "SAM",
        "4001": "AAA",
        "5001": "Artillery",
        "5011": "Towed Artillery",
        "5021": "Self Propelled Artillery",
        "5111": "Wheeled Rocket Artillery",
        "5121": "Tracked Rocket Artillery",
        "5201": "Mortar",
        "6001": "SSM",
        "7001": "Armored",
        "7500": "Combined Arms",
        "8001": "Infantry",
        "8011": "Marines",
        "8021": "Air Assault",
        "8031": "Mountain",
        "8041": "Airborne",
        "8101": "Special Forces",
        "9001": "Mechanized",
        "9041": "Mechanized Airborne",
        "9501": "Mechanized Wheeled",
        "10001": "Motorized",
        "11001": "Ammo",
        "12001": "Fuel",
        "13001": "Supply",
        "14001": "Recon",
        "14011": "Amphibious Recon",
        "16001": "Anti Tank",
        "17001": "Engineer",
        "18000": "Headquarters"
      },
      'Ship': {
        "2001": "CV",
        "2002": "CVA",
        "2003": "CVB",
        "2004": "CVE",
        "2005": "CVGH",
        "2006": "CVH",
        "2007": "CVL",
        "2008": "CVN",
        "2009": "CVS",
        "2010": "CVS",
        "2011": "AVT",
        "3001": "B",
        "3002": "BB",
        "3003": "BBC",
        "3004": "BBG",
        "3005": "BBH",
        "3006": "BCGN",
        "3007": "BM",
        "3101": "C",
        "3102": "CA",
        "3103": "CAG",
        "3104": "CB",
        "3105": "CBG",
        "3106": "CG",
        "3107": "CGH",
        "3108": "CGN",
        "3109": "CL",
        "3110": "CLAA",
        "3111": "CLC",
        "3112": "CLG",
        "3113": "CLH",
        "3114": "CS",
        "3201": "D",
        "3202": "DD",
        "3203": "DDG",
        "3204": "DDH",
        "3205": "DDK",
        "3206": "DDR",
        "3207": "DE",
        "3208": "DEG",
        "3209": "DER",
        "3210": "DL",
        "3211": "DLG",
        "3212": "DM",
        "3301": "F",
        "3302": "FF",
        "3303": "FFG",
        "3304": "FFL",
        "3305": "PF",
        "3306": "LCS",
        "3307": "OPV",
        "3308": "USV",
        "3401": "PB",
        "3402": "PC",
        "3403": "PC",
        "3404": "PCE",
        "3405": "PCF",
        "3406": "PCFG",
        "3407": "PG",
        "3408": "PG",
        "3409": "PGM",
        "3410": "PH",
        "3411": "PHM",
        "3412": "PHT",
        "3413": "PT",
        "3414": "PTS",
        "3415": "MTB",
        "3416": "WHEC",
        "3417": "WMEC",
        "3418": "WPB",
        "3419": "WPG",
        "3420": "MCDV",
        "4000": "AGF",
        "4001": "AGC",
        "4002": "LCAC",
        "4003": "LCC",
        "4004": "LCM",
        "4005": "LCP",
        "4006": "LCT",
        "4007": "LCU",
        "4008": "LCVP",
        "4009": "LFR",
        "4010": "LHA",
        "4011": "LHD",
        "4012": "LKA",
        "4013": "LPD",
        "4014": "LPH",
        "4015": "LSD",
        "4016": "LSH",
        "4017": "LSL",
        "4018": "LSM",
        "4019": "LSM(R)",
        "4020": "LST",
        "4021": "LSU",
        "4022": "LSV",
        "4023": "LCI",
        "4024": "LSDV",
        "4025": "LCPA",
        "4026": "EPF",
        "4027": "ESD",
        "4028": "ESB",
        "5001": "A",
        "5002": "AD",
        "5003": "AE",
        "5004": "AF",
        "5005": "AFS",
        "5006": "AG",
        "5007": "AGB",
        "5008": "AGF",
        "5009": "AGI",
        "5010": "AGMR",
        "5011": "AGOR",
        "5012": "AGOS",
        "5013": "AGR",
        "5014": "AGS",
        "5015": "AGTR",
        "5016": "AH",
        "5017": "AK",
        "5018": "AKA",
        "5019": "AKE",
        "5020": "AKR",
        "5021": "AKS",
        "5022": "AO",
        "5023": "AOE",
        "5024": "AOL",
        "5025": "AOR",
        "5026": "AOT",
        "5027": "APA",
        "5028": "APD",
        "5029": "AR",
        "5030": "AS",
        "5031": "ATC",
        "5032": "ATA",
        "5033": "ATS",
        "5034": "AV",
        "5035": "AX",
        "5036": "ASR",
        "5037": "AP",
        "5038": "DSV",
        "5039": "AGM",
        "5040": "AD",
        "5101": "T-AGOS",
        "5102": "T-AH",
        "5103": "T-AK",
        "5104": "T-AKE",
        "5105": "T-AKR",
        "5106": "T-AO",
        "5107": "T-AO",
        "5108": "T-MLP",
        "6001": "MCD",
        "6002": "MCM",
        "6003": "MCS",
        "6004": "MHC",
        "6005": "ML",
        "6006": "MSC",
        "6007": "MSF",
        "6008": "MSI",
        "6010": "MSO",
        "6011": "MST",
        "6012": "MHI",
        "6013": "MM",
        "7001": "YAG",
        "7002": "YRT",
        "7003": "YRM",
        "9001": "Civilian",
        "9002": "Merchant",
        "9003": "Platform",
        "9004": "NGS Buoy",
        "9005": "Bottom Fixed Array Sonar",
        "9006": "Moored Sonobuoy",
        "9007": "Special (Land Unit/Satellite)",
        "9008": "Small Watercraft",
        "9011": "Mobile Offshore Base (MOB)"
      },
      'Aircraft': {
        "1001": "None",
        "2001": "Fighter",
        "2002": "Multirole",
        "2101": "ASAT",
        "2102": "Airborne Laser Platform",
        "3001": "Attack",
        "3002": "Wild Weasel",
        "3101": "Bomber",
        "3401": "BAI/CAS",
        "4001": "EW",
        "4002": "AEW",
        "4003": "ACP",
        "4101": "SAR",
        "4201": "MCM",
        "6001": "ASW",
        "6002": "MPA",
        "7001": "Forward Observer",
        "7002": "Area Surveillance",
        "7003": "Recon",
        "7004": "ELINT",
        "7005": "SIGINT",
        "7101": "Transport",
        "7201": "Cargo",
        "7301": "Commercial",
        "7302": "Civilian",
        "7401": "Utility",
        "7402": "Naval Utility",
        "8001": "Tanker",
        "8101": "Trainer",
        "8102": "Target Towing",
        "8103": "Target Drone",
        "8201": "UAV",
        "8202": "UCAV",
        "8901": "Airship",
        "8902": "Aerostat",
        "8903": "Balloon",
      },
      'Submarine': {
        "2001": "AGSS",
        "2002": "APSS",
        "2003": "SS",
        "2004": "SSB",
        "2005": "SSBN",
        "2006": "SSG",
        "2007": "SSGN",
        "2008": "SSK",
        "2009": "SSM",
        "2010": "SSN",
        "2011": "SSP",
        "2012": "SSR",
        "2013": "SSRN",
        "3001": "SDV",
        "4001": "ROV",
        "4002": "UUV",
        "4003": "Unmanned Underwater Glider"
      },
      'Ground Unit': {
        "Infantry": "1000",
        "Infantry_Old": "1001",
        "Marines": "1010",
        "Air_Assault": "1020",
        "Mountain": "1030",
        "Airborne": "1040",
        "Special_Forces": "1100",
        "Combined_Arms": "1500",
        "Armor": "2000",
        "Armor_Recon": "2500",
        "Artillery_Gun": "3000",
        "Artillery_Towed": "3010",
        "Artillery_SP": "3020",
        "Artillery_Rocket_Wheeled": "3110",
        "Artillery_Rocket_Tracked": "3120",
        "Artillery_Mortar": "3200",
        "Artillery_SSM": "4000",
        "AAA": "5000",
        "SAM": "6000",
        "Engineer": "7000",
        "Supply": "8000",
        "Surveillance": "9000",
        "Recon": "10000",
        "Amphibious_Recon": "10010",
        "MechInfantry": "11000",
        "MechMarines": "11010",
        "MechAirborne": "11040",
        "MechWheeled": "11500",
        "Motorized_Infantry": "12000",
        "Anti_Tank": "13000",
        "Radar": "14000",
        "Headquarters": "15000"
      },
      'Satellite': {
        '1001': "None",
        '2001': "IMGSAT",
        '2002': "RORSAT",
        '2003': "EORSAT",
        '2004': "SIGINT",
        '2005': "ELINT",
        '2006': "NOSS",
        '2007': "MASINT",
        '2008': "Reusable Test Vehicle",
      }
    };

    const targetHierarchy = {
      "Aircraft": ["Aircraft", "Helicopters"],
      "Missile": ["Missiles & Guided Bombs"],
      "Ship": ["Surface Ships"],
      "Submarine": ["Submarines"],
      "Land": ["Land Structures (Hard)", "Land Structures (Soft)", "Mobile Units (Hard)", "Mobile Units (Soft)", "Runways"],
      "Radar": ["Radars"] // If you have a specific "Radars" target type
    };
    const CAPABILITY_ICONS = {
      "Aircraft": "fas fa-plane",
      "Missile": `<svg class="capability-svg-icon" viewBox="0 -8 72 72" xmlns="http://www.w3.org/2000/svg" fill="currentColor" stroke="currentColor" stroke-width="2">
                    <path d="M60.15,4.11S55.37,3.25,48.73,9.8l2.79,2.82,2.78,2.83C60.94,8.9,60.15,4.11,60.15,4.11Z"/>
                    <rect x="49.37" y="10" width="1.57" height="7.93" transform="translate(4.64 39.25) rotate(-44.61)"/>
                    <rect x="14.55" y="25.36" width="40.09" height="7.93" transform="translate(-10.63 32.75) rotate(-44.62)"/>
                    <polyline points="15.48 41.3 23.96 32.94 15.27 34.19 11.82 37.6"/>
                    <polyline points="22.3 48.22 30.78 39.85 29.41 48.52 25.96 51.92"/>
                </svg>
            `, // Or fa-crosshairs, fa-bullseye
      "Land": "fas fa-building", // Or fa-truck-monster, fa-landmark
      "Radar": `<svg  version="1.1" class="capability-svg-icon radar-custom-size" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
            viewBox="0 0 283.824 283.824" xml:space="preserve" stroke="currentColor" 
         stroke-width="2">
        <g fill="currentColor">
            <path d="M249.798,263.962l-45.067-83.529c3.306-2.759,6.445-5.741,9.391-8.938
                c18.069-19.604,27.423-45.071,26.337-71.71c-1.086-26.64-12.481-51.261-32.085-69.33l-5.515-5.083l-62.563,67.879l-31.517-29.049
                c0.667-4.301-0.748-8.849-4.182-12.014c-2.5-2.305-5.749-3.574-9.148-3.574c-3.761,0-7.38,1.585-9.928,4.349
                c-2.445,2.651-3.711,6.097-3.564,9.701c0.146,3.603,1.688,6.934,4.339,9.377c2.501,2.305,5.75,3.575,9.15,3.575
                c1.073,0,2.13-0.143,3.159-0.392l31.525,29.057L67.566,172.16l5.515,5.083c18.485,17.038,42.501,26.421,67.625,26.421
                c0.31,0,0.619-0.009,0.928-0.012l-32.54,60.311c-2.529,4.689-2.622,9.653-0.255,13.62c2.367,3.967,6.78,6.242,12.108,6.242h117
                c5.328,0,9.741-2.275,12.108-6.242C252.421,273.615,252.328,268.651,249.798,263.962z M94.343,61.1
                c0.279-0.302,0.69-0.483,1.101-0.483c0.373,0,0.744,0.145,1.018,0.396c0.161,0.148,0.281,0.332,0.364,0.532
                c-0.357,0.269-0.698,0.569-1.012,0.909c-0.309,0.336-0.575,0.694-0.812,1.066c-0.211-0.06-0.41-0.153-0.572-0.303
                C93.822,62.657,93.784,61.707,94.343,61.1z M88.985,171.054L203.503,46.807c13.409,14.705,21.148,33.469,21.968,53.589
                c0.923,22.636-7.025,44.276-22.379,60.934c-16.01,17.371-38.749,27.334-62.387,27.334
                C121.873,188.664,103.773,182.458,88.985,171.054z M123.514,268.824l36.146-66.994c11.588-2.251,22.69-6.536,32.76-12.623
                l42.957,79.617H123.514z"/>
            <path d="M80.004,14.973c4.127-0.356,7.184-3.989,6.828-8.116c-0.355-4.127-3.984-7.189-8.116-6.828
                c-11.725,1.01-24.291,7.368-32.792,16.593c-8.423,9.138-13.735,22.047-13.864,33.69c-0.046,4.142,3.275,7.537,7.417,7.582
                c0.028,0,0.056,0,0.084,0c4.103,0,7.452-3.304,7.497-7.417c0.086-7.843,4.063-17.362,9.894-23.689
                C62.839,20.402,72.102,15.654,80.004,14.973z"/>
            <path d="M73.696,42.162c3.327-3.607,8.842-6.587,12.829-6.93c4.127-0.355,7.185-3.988,6.829-8.115
                c-0.355-4.126-3.99-7.193-8.115-6.829c-8.835,0.76-17.702,6.427-22.571,11.708c-4.822,5.233-9.732,14.441-9.831,23.216
                c-0.047,4.142,3.273,7.537,7.415,7.584c0.029,0,0.057,0,0.086,0c4.102,0,7.451-3.303,7.498-7.416
                C67.879,51.487,70.454,45.68,73.696,42.162z"/>
        </g>
        </svg>`,
      "Ship": `<svg class="capability-svg-icon" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
   viewBox="0 0 512 512" xml:space="preserve">
<g fill="currentColor">
  <path d="M226.496,190.563c2.862-0.638,5.832-0.639,8.695-0.001l113.612,25.286l-10.658-67.5c-1.112-7.041-7.171-12.233-14.3-12.252
    l-31.675-0.085l-5.185-64.064c-0.609-7.523-6.882-13.325-14.43-13.345l-21.56-0.058l0.1-37.157
    c0.03-11.045-8.9-20.024-19.946-20.054c-0.019,0-0.036,0-0.055,0c-11.02,0-19.969,8.919-19.999,19.946l-0.1,37.157l-20.988-0.056
    c-7.548-0.021-13.852,5.747-14.501,13.268l-5.529,64.036l-31.26-0.084c-7.128-0.019-13.216,5.14-14.365,12.175l-11.116,68.028
    L226.496,190.563z"/>
  <path d="M110.416,375.186c17.402-12.674,38.307-19.514,60.277-19.514c21.969,0,42.875,6.841,60.277,19.514
    c17.402-12.674,38.307-19.514,60.277-19.514c21.969,0,42.872,6.84,60.275,19.512c7.392-5.388,15.418-9.711,23.883-12.916
    l27.664-76.601c1.417-3.924,1.077-8.268-0.932-11.924c-2.01-3.656-5.495-6.27-9.567-7.177l-161.721-35.994L69.365,266.558
    c-4.071,0.907-7.556,3.522-9.565,7.178c-2.009,3.656-2.348,7.999-0.931,11.922l27.675,76.632
    C95.007,365.49,103.029,369.806,110.416,375.186z"/>
  <path d="M456.083,413.984c-11.828-11.828-27.554-18.342-44.281-18.342s-32.453,6.514-44.281,18.342
    c-4.273,4.273-9.954,6.626-15.997,6.626c-6.043,0-11.724-2.353-15.996-6.626c-12.209-12.208-28.246-18.312-44.282-18.312
    c-16.036,0-32.072,6.104-44.28,18.312c-4.273,4.273-9.954,6.626-15.997,6.626c-6.043,0-11.724-2.353-15.996-6.626
    c-12.209-12.208-28.246-18.312-44.282-18.312c-16.036,0-32.072,6.104-44.28,18.312c-4.41,4.41-10.204,6.615-15.996,6.615
    c-5.794,0-11.586-2.205-15.997-6.615c-12.208-12.208-28.245-18.312-44.281-18.312c-16.036,0-32.072,6.104-44.28,18.312
    c-7.811,7.811-7.811,20.474,0,28.284c7.81,7.81,20.473,7.811,28.284,0c4.41-4.41,10.203-6.615,15.997-6.615
    s11.586,2.205,15.997,6.616c12.208,12.208,28.244,18.312,44.28,18.312s32.073-6.104,44.281-18.312
    c4.41-4.411,10.204-6.616,15.997-6.616s11.586,2.205,15.996,6.616c11.827,11.827,27.554,18.341,44.28,18.341c0,0,0,0,0,0h0
    c16.727,0,32.453-6.514,44.281-18.342c4.41-4.41,10.204-6.615,15.997-6.615s11.586,2.205,15.996,6.616
    c11.827,11.827,27.554,18.341,44.28,18.341h0h0c16.727,0,32.453-6.514,44.281-18.342c4.273-4.272,9.954-6.626,15.997-6.626
    c6.043,0,11.724,2.354,15.997,6.626c7.811,7.81,20.473,7.811,28.284,0C463.894,434.458,463.894,421.794,456.083,413.984z"/>
</g>
</svg>`,
      "Submarine": `<svg version="1.1" class="capability-svg-icon"  xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" 
   viewBox="0 0 512 512" xml:space="preserve">
<g fill="currentColor">>
  <g fill="currentColor">>
    <path d="M469.333,251.733H396.8l-23.04-30.72c-1.613-2.15-4.147-3.413-6.827-3.413H358.4v-51.2c0-4.702,3.823-8.533,8.533-8.533
      c4.719,0,8.533-3.823,8.533-8.533s-3.814-8.533-8.533-8.533c-14.114,0-25.6,11.486-25.6,25.6v51.2h-17.067v-17.067
      c0-4.71-3.814-8.533-8.533-8.533s-8.533,3.823-8.533,8.533V217.6h-34.133c-2.68,0-5.214,1.263-6.827,3.413l-23.04,30.72h-81.067
      c-0.777,0-1.545,0.102-2.287,0.316l-65.98,18.33V243.2c0-4.71-3.814-8.533-8.533-8.533H51.2c-4.173,0-7.731,3.021-8.414,7.125
      l-7.475,44.843l-18.244,5.077v-5.845c0-4.71-3.814-8.533-8.533-8.533S0,281.156,0,285.867V320c0,4.71,3.814,8.533,8.533,8.533
      s8.533-3.823,8.533-8.533v-5.845l18.244,5.069l7.475,44.843c0.683,4.113,4.241,7.134,8.414,7.134h34.133
      c4.719,0,8.533-3.823,8.533-8.533v-27.179l65.98,18.33c0.742,0.213,1.51,0.316,2.287,0.316h307.2
      c23.526,0,42.667-22.963,42.667-51.2C512,274.697,492.86,251.733,469.333,251.733z"/>
  </g>
</g>
</svg>`// Placeholder, could be custom or more specific
    };
    %s

    
    let uiState = {
      isUnitsTableDirty: true, // Start as true to ensure the first render happens
      isMissionsTableDirty: true,
      isWeaponsTableDirty: true
      // Add flags for other components as needed
    };
    const DEFAULT_ASSET_ICONS = {
      "Aircraft": "fa-fighter-jet",
      "Ship": "fa-ship",
      "Facility": "fa-building",
      "Submarine": "fa-water", // Assuming you might have submarines
      "MobileUnit": "fa-truck-moving" // Or similar for ground units
    };
    let keyAssetConfigModalInstance; // For the modal instance
    let unitMap = new Map();
    const timeElement = document.getElementById("current-scenario-time");

    // Convert to local time for better readability
    const localTime = new Date(currentISOTime).toLocaleString();

    timeElement.innerHTML = `<i class="fa-solid fa-clock"></i><span>${currentISOTime}</span>`;


    let savedManualUnitFilters = null;
    const SHORT_RANGE_MAX_NM = 12;
    const MEDIUM_RANGE_MAX_NM = 50;
    const unitsTableRowCache = new Map();

    const tomSelectInstances = new Map();
    // Global state
    let currentUnitFilters = {
      search: '', type: '', mission: '', base: '',
      condition: '', loadoutRole: '',
      showNCU: false, // Default
      operationalStatus: '',
      hideUnavailableReserve: true,
      showOnlyCritical: false
    };
    let currentMissionFilters = {
      search: '',
      taskPool: '',
      mType: '',
      mTag: '',
      mSubtype: '',
      mStatus: '' // NEW: For filtering by the chart's clicked status
    };

    let unitBaseDropdownPopulationType = 'all'; // Default: show all distinct unit.base values
    let missionBaseDropdownPopulationType = 'all';
    let weaponBaseDropdownPopulationType = 'all';
    let currentUnitSort = {
      column: 'classname',
      order: 'asc',
      secondaryColumn: 'name', // New property for secondary sort
      secondaryOrder: 'asc'    // New property for secondary sort order
    };
    let selectedUnitIds = new Set();
    let lastSelectedUnitId = null;
    let currentUnitsInTableForSelection = []; // Will be updated by renderUnitsTable
    let unitsTableColumnVisibility = {};
    let currentMissionSort = { column: 'name', order: 'asc' };
    let missionsTableColumnVisibility = {};
    let currentWeaponFilters = {
      search: '',
      type: '',
      base: '',
      targets: '',
      showOnlyCritical: false
    };
    let currentWeaponSort = { column: 'name', order: 'asc' };
    let weaponsTableColumnVisibility = {};

    let criticalMunitionsDetailModalInstance;
    let allCurrentlyCriticalMunitionsForFiltering = [];
    let unitsWithOperationalIssues = [];

    let weaponMap;
    let unitsByTypeChartInstance, missionsByTypeChartInstance;
    let weaponsByCapabilityChartInstance, weaponsByLocationTypeChartInstance;
    let missionScheduleInitialized = false;

    const allMissionsMap = getAllMissionsFromData(missionData);

    Chart.defaults.color = getComputedStyle(document.documentElement).getPropertyValue('--text-muted-color').trim();
    Chart.defaults.borderColor = getComputedStyle(document.documentElement).getPropertyValue('--border-color').trim();
    Chart.defaults.font.family = getComputedStyle(document.documentElement).getPropertyValue('--font-family').trim();

    const MAX_TRUNCATE_LENGTH = 20;

    // Función sencilla de truncado
    function truncate(text, max = MAX_TRUNCATE_LENGTH) {
      if (!text) return 'Unassigned';
      return text.length > max
        ? text.slice(0, max - 1) + '…'
        : text;
    }
    // PREPROCESS DATA
    function buildUnitMap() {
      unitMap.clear();
      for (const unit of unitData) {
        unitMap.set(unit.id, unit);
      }
    }
    /**
     * Determines a unit's complete status, including its high-level operational category,
     * display text, badge class, and tooltip. This is the single source of truth for unit status.
     * @param {object} unit - The unit data object.
     * @returns {{
     *   operationalStatus: string,
     *   displayText: string,
     *   badgeClass: string,
     *   tooltip: string
     * }}
     */
    function determineUnitStatus(unit) {
      // --- Defaults ---
      let operationalStatus = 'Other/Unknown';
      let displayText = unit.condition || 'Unknown';
      let badgeClass = 'secondary';
      let tooltip = unit.state || '';

      // --- Intermediate values ---
      const roleId = unit.unitType === 'Aircraft' ? parseInt(unit.loadout_role, 10) : null;
      const isParked = unit.condition?.toLowerCase().startsWith('parked') || unit.condition === 'Docked';
      const isUnavailableRole = (roleId === 9002);
      const isReserveRole = (roleId === 9003);
      const damagePercent = parseFloat(unit.damage?.dp_percent_now);
      const fuelPercent = parseFloat(unit.fuel_status);
      const roleText = getLoadoutRoleText(roleId);

      // --- Logic Tree (combines the best of both old functions) ---

      // 1. Highest Priority: Explicit "Down" statuses (from roles)
      if (isUnavailableRole) {
        operationalStatus = 'Unavailable';
        displayText = 'UNAVAILABLE';
        badgeClass = 'danger';
        tooltip = 'Unit is unavailable for tasking.';
      } else if (isReserveRole) {
        operationalStatus = 'Reserve';
        displayText = 'RESERVE';
        badgeClass = 'dark';
        tooltip = 'Unit is in reserve.';
      }
      // 2. Next Priority: Critical Issues (damage, fuel, etc.)
      else if (!isNaN(damagePercent) && damagePercent >= 40) {
        operationalStatus = 'Significant Issues';
        displayText = unit.condition; // Show actual condition like 'AIRBORNE'
        badgeClass = damagePercent >= 70 ? 'danger' : 'warning';
        tooltip = `Severe Damage (${damagePercent.toFixed(0)}%%). Current state: ${unit.state}`;
      } else if (!isNaN(fuelPercent) && fuelPercent < 15 && !isParked) {
        operationalStatus = 'Significant Issues';
        displayText = unit.condition;
        badgeClass = 'danger';
        tooltip = `Critical Fuel (${fuelPercent.toFixed(0)}%%). Current state: ${unit.state}`;
      }
      // 3. Next Priority: Normal Operational States
      else if (unit.condition?.toLowerCase() === 'readying') {
        operationalStatus = 'Readying';
        displayText = 'READYING';
        badgeClass = 'warning text-dark';
        tooltip = `Aircraft is preparing. Role: ${roleText}`;
        const readyTimeSeconds = parseFloat(unit.timeToReady_s);
        if (!isNaN(readyTimeSeconds) && readyTimeSeconds > 0) {
          displayText = `RDY IN: ${unit.readytime}`;
          tooltip = `Expected ready at ${unit.readytime}. Role: ${roleText}`;
        }
      } else if (isParked) {
        operationalStatus = 'Ready';
        displayText = 'PARKED';
        badgeClass = 'info text-dark';
        tooltip = `Role: ${roleText || 'N/A'}`;
      } else if (unit.condition?.toLowerCase().includes('active') || unit.condition === 'Airborne' || unit.condition === 'Underway') {
        operationalStatus = 'Ongoing/Airborne';
        displayText = unit.condition === 'Airborne' ? 'AIRBORNE' : unit.condition.toUpperCase();
        badgeClass = unit.condition === 'Airborne' ? 'blue' : 'success';
        tooltip = unit.state || `Role: ${roleText}`;
      }
      // 4. Special cases and Fallbacks
      else if (unit.unitType === 'Facility' && !unit.condition) {
        operationalStatus = 'Operational';
        displayText = 'OPERATIONAL';
        badgeClass = 'success';
        tooltip = 'Facility is operational.';
      } else if (unit.unitType === 'Satellite') {
        operationalStatus = 'Ongoing/Airborne';
        displayText = 'ON ORBIT';
        badgeClass = 'blue';
        tooltip = unit.state || 'Satellite is operational.';
      }

      // Finally, check for minor issues if no major ones were found
      if (operationalStatus === 'Ready' || operationalStatus === 'Ongoing/Airborne') {
        if (!isNaN(damagePercent) && damagePercent > 0) {
          operationalStatus = 'Minor Issues';
        }
      }

      // Return the complete, unified status object
      return {
        operationalStatus,
        displayText,
        badgeClass: `text-bg-${badgeClass}`,
        tooltip
      };
    }


    /**
     * Calculates the integrity display text, class, and tooltip.
     * @param {object} unit - The unit data object.
     * @returns {{text: string, className: string, tooltip: string}}
     */
    function getUnitDisplayIntegrity(unit) {
      let integrityPercent = 100;
      let className = 'text-success';
      let tooltip = 'Integrity: 100%%';

      if (unit.damage) {
        const dpPercentNow = parseFloat(unit.damage.dp_percent_now);
        if (!isNaN(dpPercentNow)) {
          integrityPercent = 100 - dpPercentNow;
        }

        tooltip = `Integrity: ${integrityPercent.toFixed(0)}%%`;
        if (unit.damage.fires && unit.damage.fires !== "NoFire") tooltip += `<br>Fire: ${unit.damage.fires}`;
        if (unit.damage.flood && unit.damage.flood !== "NoFlooding") tooltip += `<br>Flood: ${unit.damage.flood}`;

        if (integrityPercent < 30) className = 'text-danger';
        else if (integrityPercent < 70) className = 'text-warning';
      }

      if (unit.isJammed) {
        tooltip += "<br>Unit is being Jammed";
      }

      return { text: `${integrityPercent.toFixed(0)}%%`, className, tooltip };
    }

    /**
     * Calculates the proficiency display HTML and tooltip.
     * @param {object} unit - The unit data object.
     * @returns {{html: string, tooltip: string}}
     */
    function getUnitDisplayProficiency(unit) {
      const proficiencyText = unit.proficiency || 'N/A';
      const oodaStatus = unit.oodaStatus || 'N/A';

      let proficiencyClass = 'text-muted-color';
      switch (proficiencyText) {
        case 'Ace': proficiencyClass = 'text-success'; break;
        case 'Veteran': proficiencyClass = 'text-info'; break;
        case 'Regular': proficiencyClass = 'text-light'; break;
        case 'Cadet':
        case 'Novice': proficiencyClass = 'text-warning'; break;
      }

      const degradedIcon = (oodaStatus === 'DEGRADED')
        ? `<i class="fas fa-exclamation-triangle text-danger ms-2" title="OODA Performance Degraded"></i>`
        : '';

      const html = `<span class="${proficiencyClass}">${proficiencyText}</span>${degradedIcon}`;
      const tooltip = unit.oodaTooltip || 'No OODA details available.';

      return { html, tooltip };
    }


    /**
     * Determines if a unit's actions (like changing loadout) should be disabled.
     * @param {object} unit - The unit data object.
     * @returns {{all: boolean, loadout: boolean, doctrine: boolean, mission: boolean}}
     */
    function getUnitActionStates(unit) {
      const roleId = unit.unitType === 'Aircraft' ? parseInt(unit.loadout_role, 10) : null;
      const isReadying = unit.condition?.toLowerCase() === 'readying';

      const isDisabled = {
        all: false,
        loadout: isReadying,
        doctrine: false,
        mission: (unit.unitType === 'Aircraft' && (roleId === 9002 || roleId === 9003 || roleId === 1001)) || unit.unitType === 'Satellite'
      };

      if (unit.unitType === 'Aircraft') {
        if (roleId === 9002) isDisabled.all = true;
        if (roleId === 9003) isDisabled.loadout = true;
      }

      if (unit.unitType === 'Satellite') {
        isDisabled.doctrine = true;
      }

      return isDisabled;
    }

    /**
     * Builds the complete HTML string for the action buttons cell.
     * @param {object} unit - The unit data object.
     * @param {object} disabledStates - The pre-calculated disabled states from getUnitActionStates.
     * @returns {string} The HTML for the action buttons.
     */
    function getUnitDisplayActionsHTML(unit, disabledStates) {
      const loadoutButtonHTML = unit.unitType === 'Aircraft'
        ? `<button class="btn btn-action-icon modify-loadout-btn" data-unit-id="${unit.id}" title="Modify Loadout" ${disabledStates.all || disabledStates.loadout ? 'disabled' : ''}><i class="fas fa-wrench"></i></button>`
        : '';

      const doctrineButtonHTML = `<button class="btn btn-action-icon open-doctrine-btn" data-unit-id="${unit.id}" title="View Unit Doctrine" ${disabledStates.all || disabledStates.doctrine ? 'disabled' : ''}><i class="fas fa-book"></i></button>`;

      return loadoutButtonHTML + doctrineButtonHTML;
    }
    function preprocessUnitData() {
      // Perform any one-time calculations for the entire dataset first
      if (Object.keys(oodaAverages).length === 0) {
        precomputeOodaAverages();
      }

      // Now, process each individual unit
      unitData.forEach(unit => {
        // --- Phase 1: Intermediate Calculations ---
        processUnitOODA(unit); // Calculates unit.oodaStatus and unit.oodaTooltip
        const actionStates = getUnitActionStates(unit);
        const statusInfo = determineUnitStatus(unit);

        // --- Phase 2: Assemble the Display Object ---
        // This creates our clean "plating guide" by calling the helper functions.
        // All rendering logic will now use this `display` object.
        unit.operationalStatus = statusInfo.operationalStatus
        unit.criticalIssues = getUnitCriticalIssues(unit);
        unit.display = {
          status: {
            text: statusInfo.displayText,
            badgeClass: statusInfo.badgeClass,
            tooltip: statusInfo.tooltip
          },
          integrity: getUnitDisplayIntegrity(unit),
          proficiency: getUnitDisplayProficiency(unit),
          actionsHTML: getUnitDisplayActionsHTML(unit, actionStates),
          isMissionSelectDisabled: actionStates.mission,
          fuelClass: getFuelColorClass(unit.fuel_status),

          // Add all other calculated properties needed for rendering:
          subtypeString: getUnitSubtypeString(unit),
          subtypeTooltip: `${unit.unitType} - ${getUnitSubtypeString(unit)}`,
          loadout: {
            text: getLoadoutRoleText(unit.loadout_role),
            // (You can expand this with a helper to generate the armament tooltip)
            tooltip: 'Armament details can be pre-calculated here.'
          },
          // Pre-calculate truncated values
          truncated: {
            name: truncate(unit.name, 40),
            classname: truncate(unit.classname, 25),
            base: truncate(unit.base, 25)
          }
        };

        // You can also add the armament tooltip calculation here for better performance
        if (unit.unitType === 'Aircraft') {
          const currentWeaponsAndMagazines = { ...(unit.weapons || {}), ...(unit.magazines || {}) };
          const weaponEntriesForTooltip = Object.entries(currentWeaponsAndMagazines)
            .filter(([, data]) => data.qty > 0)
            .sort(([nameA], [nameB]) => nameA.localeCompare(nameB));

          unit.display.loadout.tooltip = weaponEntriesForTooltip.length > 0
            ? '<strong>Armament:</strong><br>' + weaponEntriesForTooltip.map(([name, data]) => `${data.qty}x <strong>${name}</strong>`).join('<br>')
            : 'No armament.';
        }
      });
    }

    function processUnitOODA(unit, threshold) {
      // If unit has no OODA data, set defaults and return early
      if (!unit.OODA) {
        unit.oodaStatus = 'N/A';
        unit.oodaTooltip = 'No OODA data available.';
        return;
      }

      // Get the average values for this unit type and proficiency
      const key = `${unit.classname}|${unit.proficiency}`;
      const averages = oodaAverages[key];

      // If no averages exist for this group, set N/A and return
      if (!averages) {
        unit.oodaStatus = 'N/A';
        unit.oodaTooltip = buildOODATooltip(unit, null);
        return;
      }

      // Check if unit is degraded
      const isDegraded = (
        (unit.OODA.detection > averages.detection * threshold) ||
        (unit.OODA.targeting > averages.targeting * threshold)
      );

      // Set status
      unit.oodaStatus = isDegraded ? 'DEGRADED' : 'OK';

      // Build tooltip
      unit.oodaTooltip = buildOODATooltip(unit, averages);
    }
    function buildOODATooltip(unit) {
      if (!unit.OODA) {
        return `<div style='text-align: left;'>
        <small class='text-muted-color'>No OODA data available.</small>
      </div>`;
      }
      return `<div style='text-align: left;'>
        Detection: ${unit.OODA.detection}<br>
        Targeting: ${unit.OODA.targeting}<br>
        Evasion: ${unit.OODA.evasion}
      </div>
  `;

    }
    function getAllMissionsFromData(data) {
      const allMissions = {};
      for (const taskPoolName in data) {
        if (data[taskPoolName] && data[taskPoolName].missionList) {
          for (const missionName in data[taskPoolName].missionList) {
            // Add taskPoolName to the missionDetails for context if needed later
            allMissions[missionName] = {
              ...data[taskPoolName].missionList[missionName],
              taskPool: taskPoolName // Store original task pool
            };
          }
        }
      }
      return allMissions; // Returns an object { missionName: missionDetails, ... }
    }
    function precomputeOodaAverages() {
      // Initialize the averages object

      const MIN_UNITS_FOR_AVERAGE = 3;

      // First pass: Group units by classname and proficiency
      unitData.forEach(unit => {
        // Skip if unit doesn't have required data
        if (!unit.NCU || !unit.OODA || !unit.classname || !unit.proficiency) {

          return;
        }

        const key = `${unit.classname}|${unit.proficiency}`;

        // Initialize group if it doesn't exist
        if (!oodaAverages[key]) {
          oodaAverages[key] = {
            units: [],
            detection: 0,
            targeting: 0,
            evasion: 0,
            count: 0
          };
        }

        // Add unit's OODA values to the group
        oodaAverages[key].units.push(unit);
        oodaAverages[key].detection += Number(unit.OODA.detection) || 0;
        oodaAverages[key].targeting += Number(unit.OODA.targeting) || 0;
        oodaAverages[key].evasion += Number(unit.OODA.evasion) || 0;
        oodaAverages[key].count++;
      });

      // Second pass: Calculate averages only for groups with enough units
      const finalAverages = {};
      Object.keys(oodaAverages).forEach(key => {
        const group = oodaAverages[key];
        if (group.count >= MIN_UNITS_FOR_AVERAGE) {
          finalAverages[key] = {
            detection: group.detection / group.count,
            targeting: group.targeting / group.count,
            evasion: group.evasion / group.count,
            count: group.count
          };

        }
      });

      oodaAverages = finalAverages;
      if (window.chrome) {
        const jsonAverages = JSON.stringify(oodaAverages);
        window.chrome.webview.postMessage(`DIALOG_OKOODAAverageValues('${jsonAverages}')`);
      }
    }
    function initializeBootstrapTooltips() {
      const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
      tooltipTriggerList.map(function (tooltipTriggerEl) {
        // Check if tooltip is already initialized to prevent duplicates
        if (!bootstrap.Tooltip.getInstance(tooltipTriggerEl)) {
          return new bootstrap.Tooltip(tooltipTriggerEl);
        }
        return bootstrap.Tooltip.getInstance(tooltipTriggerEl);
      });
    }
    // Main functions


    function renderFilteredWeaponsSummary(filteredWeaponsArray) {
      const statsContainer = document.getElementById('filtered-weapons-stats');
      if (!statsContainer) return;

      if (!filteredWeaponsArray || filteredWeaponsArray.length === 0) {
        statsContainer.innerHTML = '<div class="col-12"><p class="text-muted-color">No weapons match current filters to summarize.</p></div>';
        return;
      }

      const SHORT_RANGE_MAX_NM = 12;
      const MEDIUM_RANGE_MAX_NM = 50;

      let totalWeaponInstances = 0;
      const weaponTypesCount = filteredWeaponsArray.length;

      const capabilities = {
        'Anti-Air': { icon: 'fa-fighter-jet', Short: new Set(), Medium: new Set(), Long: new Set(), quantities: { Short: 0, Medium: 0, Long: 0 } },
        'Anti-Ship': { icon: 'fa-ship', Short: new Set(), Medium: new Set(), Long: new Set(), quantities: { Short: 0, Medium: 0, Long: 0 } }, // Renamed for brevity
        'Land Attack': { icon: 'fa-landmark', Short: new Set(), Medium: new Set(), Long: new Set(), quantities: { Short: 0, Medium: 0, Long: 0 } }, // Renamed
        'Anti-Sub': { icon: 'fa-water', Short: new Set(), Medium: new Set(), Long: new Set(), quantities: { Short: 0, Medium: 0, Long: 0 } } // Renamed
      };

      filteredWeaponsArray.forEach(weapon => {
        totalWeaponInstances += weapon.quantity;

        const getRangeCategory = (maxRange) => {
          if (maxRange === null || maxRange === undefined || maxRange <= 0) return null;
          if (maxRange <= SHORT_RANGE_MAX_NM) return 'Short';
          if (maxRange <= MEDIUM_RANGE_MAX_NM) return 'Medium';
          return 'Long';
        };

        if (Array.isArray(weapon.targets)) {
          if (weapon.targets.some(t => t.includes('Aircraft') || t.includes('Helicopters') || t.includes('Missiles'))) {
            const rangeCat = getRangeCategory(weapon.rangeAir?.max);
            if (rangeCat) {
              capabilities['Anti-Air'][rangeCat].add(weapon.name);
              capabilities['Anti-Air'].quantities[rangeCat] += weapon.quantity;
            }
          }
          if (weapon.targets.some(t => t.includes('Surface Ships'))) {
            const rangeCat = getRangeCategory(weapon.rangeSurface?.max);
            if (rangeCat) {
              capabilities['Anti-Ship'][rangeCat].add(weapon.name);
              capabilities['Anti-Ship'].quantities[rangeCat] += weapon.quantity;
            }
          }
          if (weapon.targets.some(t => t.includes('Land Structures') || t.includes('Mobile Units') || t.includes('Runways'))) {
            const rangeCat = getRangeCategory(weapon.rangeLand?.max);
            if (rangeCat) {
              capabilities['Land Attack'][rangeCat].add(weapon.name);
              capabilities['Land Attack'].quantities[rangeCat] += weapon.quantity;
            }
          }
          if (weapon.targets.some(t => t.includes('Submarines'))) {
            const rangeCat = getRangeCategory(weapon.rangeSubsurface?.max);
            if (rangeCat) {
              capabilities['Anti-Sub'][rangeCat].add(weapon.name);
              capabilities['Anti-Sub'].quantities[rangeCat] += weapon.quantity;
            }
          }
        }
      });

      // Single line for Overall Inventory
      let overallSummaryHTML = `
                <div class="col-12 mb-3" style="font-size: 0.9em;">
                    <i class="fas fa-cubes me-1 text-muted-color"></i><strong style="color: var(--text-color);">Total Instances:</strong> ${totalWeaponInstances.toLocaleString()}
                    <span class="mx-2 text-muted-color">|</span>
                    <i class="fas fa-th-list me-1 text-muted-color"></i><strong style="color: var(--text-color);">Unique Types:</strong> ${weaponTypesCount}
                </div>
            `;

      let capabilityCardsHTML = '';

      for (const capName in capabilities) {
        const capData = capabilities[capName];
        let hasDataForCapability = false;
        let rangesHTML = '';

        ['Short', 'Medium', 'Long'].forEach(rangeKey => {
          if (capData[rangeKey].size > 0) {
            hasDataForCapability = true;
            // More compact display for ranges
            rangesHTML += `<span class="me-2"><small><strong>${rangeKey[0]}R:</strong> ${capData.quantities[rangeKey].toLocaleString()} (${capData[rangeKey].size}t)</small></span>`;
          }
        });

        if (hasDataForCapability) {
          capabilityCardsHTML += `
                        <div class="col-xl-3 col-lg-4 col-md-6"> 
                            <div class="info-card summary-capability-card">
                                <h6 class="info-card-title">
                                    <i class="fas ${capData.icon} me-2"></i>${capName}
                                </h6>
                                <div class="capability-ranges">
                                    ${rangesHTML || '<small class="text-muted-color">No specific range data.</small>'}
                                </div>
                            </div>
                        </div>
                    `;
        }
      }

      statsContainer.innerHTML = overallSummaryHTML + capabilityCardsHTML;
    }

    function getAllMissionsArray(data) {
      const missionsArray = [];
      for (const taskPoolName in data) {
        if (data[taskPoolName] && data[taskPoolName].missionList) {
          for (const missionName in data[taskPoolName].missionList) {
            missionsArray.push({
              name: missionName,
              ...data[taskPoolName].missionList[missionName],
              taskPool: taskPoolName
            });
          }
        }
      }
      return missionsArray;
    }
    function getUnitSubtypeString(unit) {
      return uTypes[unit.unitType]?.[unit.unitSubtype] || unit.unitSubtype || 'N/A';
    }
    function getFuelColorClass(fuelStatus) {
      if (!fuelStatus) return ''; // No status, no color
      const fuelPercent = parseFloat(fuelStatus);
      if (isNaN(fuelPercent)) return '';

      if (fuelPercent > 50) return 'text-success';
      if (fuelPercent < 20) return 'text-danger';
      return 'text-warning';
    }

    // Modify the renderOverview function
    function renderOverview() { // This REPLACES the old renderOverview
      const overviewView = document.getElementById('overview-view');
      if (!overviewView) {
        console.error("Overview view container not found!");
        return;
      }

      // The HTML structure for overview-view is assumed to be ALREADY IN THE MAIN HTML BODY.
      // This function will now only focus on populating the content areas and setting up charts/listeners.

      // Sanity check if the main content placeholders exist (they should if HTML was updated)
      if (!document.getElementById('ccir-critical-units-content') ||
        !document.getElementById('overviewUnitReadinessChart')) {
        console.warn("Key elements for the new overview are missing. Ensure the HTML for #overview-view has been updated with the new CCIR and chart structure.");
        // You could potentially inject the HTML here as a fallback if it's missing,
        // but it's better if the main HTML file is the source of truth for the static structure.
        // For now, we'll proceed assuming they exist.
      }

      // Call new rendering functions for the content
      renderCCIRCriticalUnits();
      renderCCIRPriorityMissions();
      renderCCIRResourceWatch();
      renderKeyAssetAvailability();
      renderOverviewUnitReadinessChart();
      renderOverviewMissionStatusChart();
      updateForceHealthSummaryDisplay();
      // Remove any existing listeners from previous calls to avoid duplication,
      // then re-attach event listeners for the "View Details" buttons within the overview.
      // A more robust approach for buttons added statically would be to add listeners once on DOMContentLoaded
      // or use event delegation if the parent #overview-view is stable.
      const detailButtons = overviewView.querySelectorAll('.view-details-btn');
      detailButtons.forEach(button => {
        // Clone and replace to remove all old listeners effectively, then add the new one.
        const newButton = button.cloneNode(true);
        button.parentNode.replaceChild(newButton, button);
        newButton.addEventListener('click', handleOverviewDetailNavigation);
      });

      initializeBootstrapTooltips(); // For any new tooltips on the overview
    }
    function handleOverviewDetailNavigation(event) {
      const targetView = event.currentTarget.dataset.targetView;
      const filterPreset = event.currentTarget.dataset.filterPreset;

      // Logic to apply filters based on preset before switching view
      if (targetView === 'units') {
        const ncuState = document.getElementById('unit-ncu-filter').checked;
        const unavailableState = document.getElementById('unit-hide-unavailable-filter').checked;
        // Clear UI elements for standard filters
        document.getElementById('unit-search').value = '';
        document.getElementById('unit-type-filter').value = '';
        // document.getElementById('unit-subtype-filter').value = '';
        document.getElementById('unit-mission-filter').value = '';
        document.getElementById('unit-base-filter').value = '';
        document.getElementById('unit-mission-mtype-filter').value = '';
        document.getElementById('unit-status-filter').value = '';
        document.getElementById('unit-loadout-role-filter').value = '';

        // Reset filter state object, preserving NCU, and setting criticality
        currentUnitFilters = {
          search: '', type: '',  mission: '', base: '',
          missionMType: '', condition: '', loadoutRole: '',
          showNCU: ncuState,
          operationalStatus: '',
          hideUnavailableReserve: unavailableState,
          showOnlyCritical: false // Default to false
        };

        if (filterPreset === 'critical_any') {
          currentUnitFilters.showOnlyCritical = true;

        }
      } else if (targetView === 'missions') {
        clearMissionFiltersAndRender();
        if (filterPreset === 'priority_active_hs') {
          document.getElementById('mission-filter-mtag').value = 'STRAT';
          // Manually trigger change on mission filter if renderMissionsTable doesn't pick it up from clear/set
          const mtagFilter = document.getElementById('mission-filter-mtag');
          if (mtagFilter) mtagFilter.dispatchEvent(new Event('change', { bubbles: true }));

        }
      } else if (targetView === 'weapons') {
        // Clear standard weapon filter UI elements
        document.getElementById('weapon-search').value = '';
        document.getElementById('weapon-type-filter').value = '';
        document.getElementById('weapon-targets-filter').value = '';
        document.getElementById('weapon-base-filter').value = '';

        // Reset weapon filter state object
        currentWeaponFilters = {
          search: '', type: '', base: '', targets: '',
          showOnlyCritical: false // Default to false
        };

        if (filterPreset === 'shortage_critical_munitions') {
          currentWeaponFilters.showOnlyCritical = true;
          console.debug("Setting showOnlyCritical for weapons to true");
          // No need to set the search input to "Tomahawk" anymore
        }

      }

      switchView(targetView); // switchView should handle re-rendering tables based on new filter values
    }
    // Modify renderTopWeaponsSummary to accept unit data
    function renderTopWeaponsSummary(unitsToSummarize) { // Modified to accept data
      const topWeaponsContent = document.getElementById('top-weapon-systems-content');
      const allWeaponCounts = {};
      unitsToSummarize.forEach(unit => { // Use the passed-in units
        const unitWeapons = { ...(unit.weapons || {}), ...(unit.magazines || {}) };
        Object.entries(unitWeapons).forEach(([weaponName, data]) => {
          if (data.qty > 0) {
            allWeaponCounts[weaponName] = (allWeaponCounts[weaponName] || 0) + data.qty;
          }
        });
      });
      // ... (rest of renderTopWeaponsSummary remains the same)
      const sortedWeapons = Object.entries(allWeaponCounts)
        .sort(([, a], [, b]) => b - a)
        .slice(0, 5);

      let topWeaponsHTML = '';
      if (sortedWeapons.length > 0) {
        topWeaponsHTML += `<ul class="list-unstyled mb-0">`;
        sortedWeapons.forEach(([name, count]) => {
          topWeaponsHTML += `<li><small><strong>${name.substring(0, 28)}${name.length > 28 ? '...' : ''}:</strong> ${count}</small></li>`;
        });
        topWeaponsHTML += `</ul>`;
      } else {
        topWeaponsHTML = '<p><small>No weapon data in current selection.</small></p>';
      }
      topWeaponsContent.innerHTML = topWeaponsHTML;
    }

    function renderTopWeaponsSummary() {
      const topWeaponsContent = document.getElementById('top-weapon-systems-content');
      const allWeaponCounts = {};
      unitData.forEach(unit => {
        const unitWeapons = { ...(unit.weapons || {}), ...(unit.magazines || {}) };
        Object.entries(unitWeapons).forEach(([weaponName, data]) => {
          if (data.qty > 0) {
            allWeaponCounts[weaponName] = (allWeaponCounts[weaponName] || 0) + data.qty;
          }
        });
      });
      const sortedWeapons = Object.entries(allWeaponCounts)
        .sort(([, a], [, b]) => b - a)
        .slice(0, 5);

      let topWeaponsHTML = '';
      if (sortedWeapons.length > 0) {
        topWeaponsHTML += `<ul class="list-unstyled mb-0">`;
        sortedWeapons.forEach(([name, count]) => {
          topWeaponsHTML += `<li><small><strong>${name.substring(0, 28)}${name.length > 28 ? '...' : ''}:</strong> ${count}</small></li>`;
        });
        topWeaponsHTML += `</ul>`;
      } else {
        topWeaponsHTML = '<p><small>No weapon data available.</small></p>';
      }
      topWeaponsContent.innerHTML = topWeaponsHTML;
    }

    function renderUnitsByTypeChart(data) {
      const ctx = document.getElementById('unitsByTypeChart').getContext('2d');
      if (unitsByTypeChartInstance) unitsByTypeChartInstance.destroy();
      unitsByTypeChartInstance = new Chart(ctx, {
        type: 'doughnut',
        data: {
          labels: Object.keys(data),
          datasets: [{
            label: 'Units by Type',
            data: Object.values(data),
            backgroundColor: ['#5a9bd4', '#c678dd', '#98c379', '#e5c07b', '#e06c75', '#56b6c2'],
            borderColor: getComputedStyle(document.documentElement).getPropertyValue('--panel-bg').trim(),
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'bottom',
              labels: { color: getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim() }
            }
          }
        }
      });
    }

    function renderMissionsByTypeChart(data) { // 'data' here will be missionsByTypeForChart
      const ctx = document.getElementById('missionsByTypeChart').getContext('2d');
      if (missionsByTypeChartInstance) missionsByTypeChartInstance.destroy(); // Destroy previous instance
      missionsByTypeChartInstance = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: Object.keys(data),
          datasets: [{
            label: 'Missions by Type',
            data: Object.values(data),
            backgroundColor: ['#5a9bd4', '#c678dd', '#98c379', '#e5c07b', '#e06c75', '#56b6c2'],
            borderColor: getComputedStyle(document.documentElement).getPropertyValue('--panel-bg').trim(),
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          scales: {
            y: {
              ticks: {
                color: getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim(),
                beginAtZero: true,
                callback: function (value) { if (value %% 1 === 0) { return value; } } // Only show integer ticks
              },
              grid: { color: getComputedStyle(document.documentElement).getPropertyValue('--border-color').trim() }
            },
            x: {
              ticks: { color: getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim() },
              grid: { display: false }
            }
          },
          plugins: {
            legend: { display: false } // Legend is often not needed for a simple bar chart with one dataset
          }
        }
      });
    }
    function renderWeaponsByCapabilityChart(data) {
      const ctx = document.getElementById('weaponsByCapabilityChart')?.getContext('2d');
      if (!ctx) return;
      if (weaponsByCapabilityChartInstance) weaponsByCapabilityChartInstance.destroy();

      // Filter out capabilities with 0 quantity for a cleaner chart
      const filteredLabels = Object.keys(data).filter(key => data[key] > 0);
      const filteredData = filteredLabels.map(key => data[key]);

      if (filteredLabels.length === 0) {
        // Optional: Display a message if no data
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.textAlign = 'center';
        ctx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--text-muted-color').trim();
        ctx.fillText("No weapon capability data to display for current selection.", ctx.canvas.width / 2, ctx.canvas.height / 2);
        return;
      }


      weaponsByCapabilityChartInstance = new Chart(ctx, {
        type: 'pie', // Or 'doughnut'
        data: {
          labels: filteredLabels,
          datasets: [{
            label: 'Weapons by Capability',
            data: filteredData,
            backgroundColor: ['#5a9bd4', '#c678dd', '#98c379', '#e5c07b', '#e06c75', '#56b6c2', '#ff9f40', '#4bc0c0'],
            borderColor: getComputedStyle(document.documentElement).getPropertyValue('--panel-bg').trim(),
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: {
              position: 'right',
              labels: { color: getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim() }
            },
            tooltip: {
              callbacks: {
                label: function (context) {
                  let label = context.label || '';
                  if (label) { label += ': '; }
                  if (context.parsed !== null) {
                    label += context.parsed.toLocaleString();
                  }
                  return label;
                }
              }
            }
          }
        }
      });
    }

    function renderWeaponsByLocationTypeChart(dataForChart) { // Renamed param for clarity
      const ctx = document.getElementById('weaponsByLocationTypeChart')?.getContext('2d');
      if (!ctx) return;
      if (weaponsByLocationTypeChartInstance) weaponsByLocationTypeChartInstance.destroy();

      const chartLabels = Object.keys(dataForChart);
      const chartDataPoints = Object.values(dataForChart);

      if (chartLabels.length === 0) {
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.textAlign = 'center';
        ctx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--text-muted-color').trim();
        ctx.fillText("No weapon location data for current selection.", ctx.canvas.width / 2, ctx.canvas.height / 2);
        return;
      }

      weaponsByLocationTypeChartInstance = new Chart(ctx, {
        type: 'bar', // or 'pie' / 'doughnut' if preferred for this breakdown
        data: {
          labels: chartLabels,
          datasets: [{
            label: 'Weapon Instances by Location',
            data: chartDataPoints,
            backgroundColor: [ // Provide enough colors or a function to generate them
              '#61afef', '#c678dd', '#98c379', '#e5c07b', '#e06c75', '#56b6c2', '#ff9f40', '#4bc0c0',
              '#36a2eb', '#ffcd56'
            ],
            borderColor: getComputedStyle(document.documentElement).getPropertyValue('--panel-bg').trim(),
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          indexAxis: 'y', // Horizontal bar chart is good for location names
          scales: {
            x: {
              ticks: {
                color: getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim(), beginAtZero: true,
                callback: function (value) { if (Number.isInteger(value)) { return value.toLocaleString(); } }
              },
              grid: { color: getComputedStyle(document.documentElement).getPropertyValue('--border-color').trim() }
            },
            y: {
              ticks: { color: getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim() },
              grid: { display: false }
            }
          },
          plugins: {
            legend: { display: false }, // Often not needed for single dataset bar charts
            tooltip: {
              callbacks: {
                label: function (context) {
                  let label = context.dataset.label || '';
                  if (label) { label += ': '; }
                  if (context.parsed.x !== null) {
                    label += context.parsed.x.toLocaleString();
                  }
                  return label;
                }
              }
            }
          }
        }
      });
    }
    function renderFilteredMissionsSummary(filteredMissionsArray) {
      const statsContainer = document.getElementById('filtered-missions-stats'); // This is the <div class="row">
      if (!statsContainer) return;

      if (!filteredMissionsArray || filteredMissionsArray.length === 0) {
        statsContainer.innerHTML = '<div class="col-12"><p class="text-muted-color">No missions to summarize for current filters.</p></div>';
        return;
      }

      const totalMissionsDisplayed = filteredMissionsArray.length;
      let activeMissions = 0;
      let plannedMissions = 0;
      let completedMissions = 0; // Assuming "Deactivated" might mean "Completed" or similar
      let inactiveMissions = 0;
      // Add other status counters if needed, e.g., let abortedMissions = 0;
      const missionsByTagCount = {};
      const now = new Date(currentISOTime);

      filteredMissionsArray.forEach(missionEntry => {
        const d = missionEntry;
        let currentMissionStatus = d.calculatedStatus

        const startTime = parseAsUTC(d.startT);
        const endTime = parseAsUTC(d.endT);


        if (currentMissionStatus === "ACTIVE") activeMissions++;
        else if (currentMissionStatus === "PLANNED") plannedMissions++;
        else if (currentMissionStatus === "COMPLETED") completedMissions++;
        else if (currentMissionStatus === "INACTIVE") inactiveMissions++;
        // Add other status checks here, e.g. else if (currentMissionStatus === "DEACTIVATED") completedMissions++;

        if (d.mTag) {
          missionsByTagCount[d.mTag] = (missionsByTagCount[d.mTag] || 0) + 1;
        } else {
          missionsByTagCount['Untagged'] = (missionsByTagCount['Untagged'] || 0) + 1;
        }
      });

      let summaryHTML = '';

      // --- Section 1: Mission Status Summary ---
      summaryHTML += `<div class="col-lg-6 col-md-12 mb-3 summary-section">`; // Takes up half on large, full on medium
      summaryHTML += `<ul class="list-inline unit-summary-stat-list">`; // New class for specific styling if needed
      summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-layer-group me-1 text-muted-color"></i><strong style="color:var(--text-color);">Total:</strong> ${totalMissionsDisplayed}</small></li>`;
      summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-play-circle me-1 text-success"></i><strong style="color:var(--text-success);">Active:</strong> ${activeMissions}</small></li>`;
      summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-pause-circle me-1 text-warning"></i><strong style="color:#fa2335;">Inactive:</strong> ${inactiveMissions}</small></li>`;
      summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-calendar-alt me-1 text-warning"></i><strong style="color:var(--warning-color);">Planned:</strong> ${plannedMissions}</small></li>`;
      summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-check-double me-1 text-muted-color"></i><strong style="color:var(--text-muted-color);">Completed:</strong> ${completedMissions}</small></li>`;
      // Add more statuses here if you track them (e.g., Deactivated, Aborted)
      summaryHTML += `</ul></div>`;

      // --- Section 2: Missions by Tag ---
      if (Object.keys(missionsByTagCount).length > 0) {
        summaryHTML += `<div class="col-lg-6 col-md-12 mb-3 summary-section">`;
        summaryHTML += `<ul class="list-inline mission-tag-summary-list">`; // New class
        Object.entries(missionsByTagCount).sort((a, b) => b[1] - a[1]).forEach(([tag, count]) => {
          summaryHTML += `
                  <li class="list-inline-item me-3 mb-1">
                      <small>
                          <span class="mission-tag-badge summary-inline-badge" data-mtag="${tag}">${tag}</span>: ${count}
                      </small>
                  </li>`;
        });
        summaryHTML += `</ul></div>`;
      }

      statsContainer.innerHTML = summaryHTML;
    }

    // ADD THIS FUNCTION. This is the only one you need for the unit table's delegated events.

    /**
     * Sets up a single, delegated event listener for the main Units table.
     * This handles ALL clicks: row selection (incl. shift/ctrl), links, and action buttons.
     */
    function initializeUnitTableInteractions() {
      const tableBody = document.getElementById('units-table-body');
      if (!tableBody) {
        console.error("Unit table body not found for event delegation setup.");
        return;
      }

      // Attach the single "manager" event listener to the table body.
      tableBody.addEventListener('click', (event) => {
        const target = event.target;
        // --- Handle Checkbox Selection Clicks ---
        const checkbox = target.closest('input.unit-row-checkbox');
        if (checkbox) {
          const clickedUnitId = checkbox.dataset.unitId;
          if (!clickedUnitId) return;

          // Handle Shift+Click for range selection
          if (event.shiftKey && lastSelectedUnitId && lastSelectedUnitId !== clickedUnitId) {
            const lastIdx = currentUnitsInTableForSelection.findIndex(u => u.id === lastSelectedUnitId);
            const currentIdx = currentUnitsInTableForSelection.findIndex(u => u.id === clickedUnitId);

            if (lastIdx !== -1 && currentIdx !== -1) {
              const start = Math.min(lastIdx, currentIdx);
              const end = Math.max(lastIdx, currentIdx);
              // The checkbox's state determines if we are selecting or deselecting the range
              const shouldSelect = checkbox.checked;
              for (let i = start; i <= end; i++) {
                const unitInRange = currentUnitsInTableForSelection[i];
                if (unitInRange) {
                  if (shouldSelect) {
                    selectedUnitIds.add(unitInRange.id);
                  } else {
                    selectedUnitIds.delete(unitInRange.id);
                  }
                }
              }
            }
          } else {
            // Handle a normal click (or Ctrl+Click, which has the same toggle effect here)
            if (checkbox.checked) {
              selectedUnitIds.add(clickedUnitId);
              lastSelectedUnitId = clickedUnitId; // Set as anchor for next shift-click
            } else {
              selectedUnitIds.delete(clickedUnitId);
            }
          }
          uiState.isUnitsTableDirty = true;
          renderUnitsTable();
          return; // Done with this click event
        }
        // --- Handle Action Buttons and Links first (most specific clicks) ---
        // event.preventDefault() is used to stop default browser actions, like a link navigating.
        // return; is used to stop further execution within this handler, preventing unintended row selection.

        const modifyLoadoutBtn = target.closest('.modify-loadout-btn');
        if (modifyLoadoutBtn) {
          event.preventDefault();
          handleModifyLoadoutClick(modifyLoadoutBtn.dataset.unitId);
          return;
        }

        const openDoctrineBtn = target.closest('.open-doctrine-btn');
        if (openDoctrineBtn) {
          event.preventDefault();
          handleOpenDoctrineClick(openDoctrineBtn.dataset.unitId);
          return;
        }

        const unitNameLink = target.closest('.unit-name-link');
        if (unitNameLink) {
          event.preventDefault();
          handleUnitNameClick(unitNameLink.dataset.unitId, unitNameLink.dataset.unitLat, unitNameLink.dataset.unitLon);
          return;
        }

        const classnameSpan = target.closest('.classname-clickable');
        if (classnameSpan) {
          event.preventDefault();
          openDatabaseEntry(classnameSpan.dataset.unitDbid, classnameSpan.dataset.unitType);
          return;
        }




      });
    }

    /**
    * Sets up a single, delegated event listener for the main Missions table and its detail rows.
    * This handles all clicks for mission names, action buttons, and links within detail rows.
    */
    function setupMissionTableDelegatedEvents() {
      const tableBody = document.getElementById('main-missions-table-body');
      if (!tableBody) return;

      tableBody.addEventListener('click', (event) => {
        // --- Mission Row Clicks ---
        const missionNameCell = event.target.closest('.mission-name-clickable-cell');
        if (missionNameCell && !event.target.closest('button, a')) { // Avoid triggering on button clicks inside the cell
          event.stopPropagation();
          const missionRow = missionNameCell.closest('tr');
          // This is where you can re-implement your single/double click logic if needed,
          // or just the single click for expanding details.
          toggleAssignedUnitsDetail(missionRow, missionRow.dataset.missionName);
          return;
        }

        const missionEditorBtn = event.target.closest('.open-mission-editor-btn');
        if (missionEditorBtn) {
          event.preventDefault();
          openMissionInEditor(missionEditorBtn.dataset.missionId, missionEditorBtn.dataset.missionName);
          return;
        }

        const missionDoctrineBtn = event.target.closest('.open-mission-doctrine-btn');
        if (missionDoctrineBtn) {
          event.preventDefault();
          openMissionDoctrine(missionDoctrineBtn.dataset.missionId, missionDoctrineBtn.dataset.missionName);
          return;
        }

        // --- Clicks within the dynamically created "Assigned Units" sub-table ---
        const unitLinkInSubTable = event.target.closest('.mission-detail-row .unit-name-link');
        if (unitLinkInSubTable) {
          event.preventDefault();
          handleUnitNameClick(unitLinkInSubTable.dataset.unitId, unitLinkInSubTable.dataset.unitLat, unitLinkInSubTable.dataset.unitLon);
          return;
        }

        const loadoutBtnInSubTable = event.target.closest('.mission-detail-row .modify-loadout-btn');
        if (loadoutBtnInSubTable) {
          event.preventDefault();
          // Note: handleModifyLoadoutClick is designed to work with selection,
          // so we can still use it here for a single unit.
          handleModifyLoadoutClick(loadoutBtnInSubTable.dataset.unitId);
          return;
        }

        const doctrineBtnInSubTable = event.target.closest('.mission-detail-row .open-doctrine-btn');
        if (doctrineBtnInSubTable) {
          event.preventDefault();
          handleOpenDoctrineClick(doctrineBtnInSubTable.dataset.unitId);
          return;
        }
      });
    }
    // Replace the existing renderMissionsTable function
    function renderMissionsTable() {
      uiState.isMissionsTableDirty = false;
      const tableBody = document.getElementById('main-missions-table-body');
      if (!tableBody) { console.error("Mission table body not found!"); return; }
      tableBody.innerHTML = '';
      // Clear existing detail rows before re-rendering
      tableBody.querySelectorAll('.mission-detail-row').forEach(row => row.remove());

      // --- Filter logic (same as your last working version) ---
      const searchTerm = document.getElementById('mission-search-input')?.value.toLowerCase() || "";
      // ... (all other filter value retrievals)
      const taskPoolFilterVal = document.getElementById('mission-filter-taskpool')?.value || "";
      const mTypeFilterVal = document.getElementById('mission-filter-mtype')?.value || "";
      const mTagFilterVal = document.getElementById('mission-filter-mtag')?.value || "";
      const mSubtypeFilterVal = document.getElementById('mission-filter-msubtype')?.value || "";
      const rawStatusFilterVal = document.getElementById('mission-filter-status')?.value || "";

      let missionsToDisplay = [];
      const allMissionsSource = getAllMissionsArray(missionData);
      allMissionsSource.forEach(missionEntry => {
        const missionDetails = missionEntry; // missionEntry is the mission object

        // --- Filter by mStatus FIRST if it's set ---
        if (currentMissionFilters.mStatus &&
          missionDetails.calculatedStatus !== currentMissionFilters.mStatus) {
          return; // Skip if it doesn't match the chart-clicked status
        }
        // --- END Chart Status Filter ---

        // Apply standard filters based on currentMissionFilters state
        const searchTerm = currentMissionFilters.search.toLowerCase(); // search is already lowercased when set
        if (searchTerm && !(
          missionDetails.name.toLowerCase().includes(searchTerm) ||
          (missionDetails.id && missionDetails.id.toLowerCase().includes(searchTerm))
          // Add other searchable fields if needed
        )) {
          return;
        }

        if (currentMissionFilters.taskPool && missionDetails.taskPool !== currentMissionFilters.taskPool) return;
        if (currentMissionFilters.mType && missionDetails.mType !== currentMissionFilters.mType) return;
        if (currentMissionFilters.mTag && missionDetails.mTag !== currentMissionFilters.mTag) return;
        if (currentMissionFilters.mSubtype && missionDetails.mSubType !== currentMissionFilters.mSubtype) return;

        // If you have a raw status filter from a dropdown, and it should only apply
        // when mStatus is NOT active:
        // if (!currentMissionFilters.mStatus && currentMissionFilters.status &&
        //     missionDetails.calculatedStatus !== currentMissionFilters.status) { // Assuming 'status' field in currentMissionFilters
        //     return;
        // }

        missionsToDisplay.push(missionDetails);
      });
      // Call populateMissionFilters AFTER filtering the missions to display,
      // so dropdowns reflect options available within the filtered set.
      populateMissionFilters(missionsToDisplay.map(m => m.details));

      if (missionsToDisplay.length === 0) {
        const visibleColumnCount = document.querySelectorAll('#main-missions-table thead th:not([style*="display: none"])').length || 1;
        tableBody.innerHTML = `<tr><td colspan="${visibleColumnCount}" class="no-data-message">No missions match the current filters.</td></tr>`;
        // Also clear the summary below the table if it exists
        const summaryContainer = document.getElementById('filtered-missions-stats');
        if (summaryContainer) {
          summaryContainer.innerHTML = '<div class="col-12"><p class="text-muted-color">No missions to summarize.</p></div>';
        }
        return;
      }

      // Sort missions (e.g., by start time, then by name)
      missionsToDisplay.sort((a, b) => {
        let valA, valB;

        // Special handling for calculated or nested values
        if (currentMissionSort.column === 'name') {
          valA = a.name;
          valB = b.name;
        } else if (currentMissionSort.column === 'taskPool') { // **** EXPLICIT HANDLING FOR taskPool ****
          valA = a.taskPool === "No TaskPool" ? "zzz" : a.taskPool; // Sort "No TaskPool" last or first
          valB = b.taskPool === "No TaskPool" ? "zzz" : b.taskPool; // Use a string that sorts predictably
        } else if (currentMissionSort.column === 'assignedUnitsCount') {
          valA = unitData.filter(u => u.mission === a.name).length;
          valB = unitData.filter(u => u.mission === b.name).length;
        } else if (currentMissionSort.column === 'startT' || currentMissionSort.column === 'endT') {
          const dateA_str = a[currentMissionSort.column];
          const dateB_str = b[currentMissionSort.column];
          valA = dateA_str ? new Date(dateA_str + (dateA_str.endsWith('Z') ? '' : 'Z')).getTime() : null;
          valB = dateB_str ? new Date(dateB_str + (dateB_str.endsWith('Z') ? '' : 'Z')).getTime() : null;
          // Handle nulls for date sorting (e.g., push them to end or beginning)
          if (valA === null) valA = currentMissionSort.order === 'asc' ? Infinity : -Infinity;
          if (valB === null) valB = currentMissionSort.order === 'asc' ? Infinity : -Infinity;
        } else {
          // General case: access property from a.details or b.details
          valA = a[currentMissionSort.column];
          valB = b[currentMissionSort.column];
        }

        // Type coercion and null/undefined handling for comparison
        if (typeof valA === 'number' && typeof valB === 'number') {
          // Numerical sort
        } else { // String sort or mixed types (treat as string for now)
          if (valA === undefined || valA === null) valA = "";
          if (valB === undefined || valB === null) valB = "";
          if (typeof valA !== 'string') valA = String(valA);
          if (typeof valB !== 'string') valB = String(valB);
          valA = valA.toLowerCase();
          valB = valB.toLowerCase();
        }

        // Comparison logic
        if (valA < valB) return currentMissionSort.order === 'asc' ? -1 : 1;
        if (valA > valB) return currentMissionSort.order === 'asc' ? 1 : -1;
        return 0;
      });


      if (missionsToDisplay.length === 0) {
        tableBody.innerHTML = `<tr><td colspan="1" class="no-data-message">No missions match filters.</td></tr>`;
      } else {
        tableBody.innerHTML = missionsToDisplay.map(missionEntry => {
          const missionName = missionEntry.name;
          const d = missionEntry;
          const assignedUnitsCount = unitData.filter(u => u.mission === missionName).length;

          const now = new Date(currentISOTime);
          const startTime = formatCustomUTC(parseAsUTC(d.startT));
          const endTime = formatCustomUTC(parseAsUTC(d.endT));

          let missionStatusText = d.calculatedStatus;


          // Add data attributes to the <tr> for easy access, and an expand icon to the name
          return `
                  <tr class="mission-summary-row" 
                  data-mission-id="${d.id}" 
                  data-mission-name="${missionName}"
                  data-task-pool="${missionEntry.taskPool}"">
                      <td data-col-id="name" class="mission-name-clickable-cell">
                          <span class="mission-name-link-in-table">
                              ${missionName}
                              <i class="fas fa-chevron-right expand-icon"></i>
                          </span>
                      </td>
                       <td data-col-id="taskPool">
                            ${missionEntry.taskPool === "No TaskPool" ?
              "N/A" :
              `<span class="clickable-taskpool" data-taskpool-name="${missionEntry.taskPool}">${truncate(missionEntry.taskPool)}</span>`}
                        </td>
                      <td data-col-id="status"><span class="badge mission-status-badge ${missionStatusText.toLowerCase()}">${missionStatusText}</span></td>
                      <td data-col-id="mType">${d.mType || 'N/A'}</td>
                      <td data-col-id="mTag"><span class="mission-tag-badge" data-mtag="${d.mTag || 'Unknown'}">${d.mTag || 'N/A'}</span></td>
                      <td data-col-id="mSubType">${d.mSubType || 'N/A'}</td>
                      <td data-col-id="units">${assignedUnitsCount}</td>
                      <td data-col-id="startT">${startTime || 'N/A'}</td>
                      <td data-col-id="endT">${endTime || 'N/A'}</td>
                      <td data-col-id="ToT">${d.ToT || 'N/A'}</td>
                      <td data-col-id="actions" class="text-nowrap info-mission-buttons">
                          
                          <button class="btn btn-action-icon assign-units-to-mission-btn" title="Manage Assigned Units" data-mission-name="${missionName}" data-mission-id="${d.id}"><i class="fas fa-users-cog"></i></button>
                          <button class="btn btn-action-icon open-mission-doctrine-btn" title="View Mission Doctrine" data-mission-id="${d.id}" data-mission-name="${missionName}"><i class="fas fa-book"></i></button>
                          <button class="btn btn-action-icon open-mission-editor-btn" title="Edit Mission Details" data-mission-id="${d.id}" data-mission-name="${missionName}"><i class="fas fa-edit"></i></button>
                      </td>
                  </tr>
              `;
        }).join('');
      }
      updateTableColumnVisibility('main-missions-table', missionsTableColumnVisibility);
      renderFilteredMissionsSummary(missionsToDisplay);
      initializeBootstrapTooltips();
      //attachMissionTableRowClickListeners(tableBody); // New function for row clicks

    }

    function toggleAssignedUnitsDetail(clickedRowElement, missionName) {
      const table = clickedRowElement.closest('table');
      const existingDetailRow = clickedRowElement.nextElementSibling;
      const expandIcon = clickedRowElement.querySelector('.expand-icon');

      // Close any other open detail rows in this table
      table.querySelectorAll('.mission-detail-row').forEach(row => {
        if (row !== existingDetailRow) { // Don't remove the one we might be about to re-create/show
          row.remove();
        }
      });
      table.querySelectorAll('.mission-summary-row .expand-icon.expanded').forEach(icon => {
        if (icon !== expandIcon) {
          icon.classList.remove('expanded');
          icon.classList.remove('fa-chevron-down'); // Assuming it was fa-chevron-down
          icon.classList.add('fa-chevron-right');
        }
      });


      if (existingDetailRow && existingDetailRow.classList.contains('mission-detail-row')) {
        existingDetailRow.remove(); // Remove if already open (toggle off)
        if (expandIcon) {
          expandIcon.classList.remove('expanded', 'fa-chevron-down');
          expandIcon.classList.add('fa-chevron-right');
        }
      } else {
        // Create and insert the new detail row
        const detailRow = table.insertRow(clickedRowElement.rowIndex + 1); // Insert after clicked row
        detailRow.className = 'mission-detail-row';
        const detailCell = detailRow.insertCell(0);

        // Determine colspan based on visible columns in the main mission table
        let colspan = 0;
        document.querySelectorAll('#main-missions-table thead th').forEach(th => {
          if (th.style.display !== 'none') {
            colspan++;
          }
        });
        detailCell.colSpan = colspan > 0 ? colspan : 1; // Fallback to 1 if no columns visible

        const assignedUnits = unitData.filter(u => u.mission === missionName);
        let unitsTableHTML = '<p class="m-2 text-muted-color"><small>No units assigned to this mission.</small></p>';

        if (assignedUnits.length > 0) {
          unitsTableHTML = `
                <div class="table-container">
                    <table class="unit-table">
                        <thead><tr>
                            <th>Name</th><th>Classname</th>
                            <th>Loadout Role</th><th>Status</th><th>Integrity</th><th>Base</th><th>Fuel</th><th>Proficiency</th><th>Actions</th>
                        </tr></thead>
                        <tbody>
                         ${assignedUnits.map(u => {
            // THIS IS THE KEY CHANGE:
            // We now call our new, simple HTML builder function.
            // All complex logic is gone from here.
            return buildUnitSubTableRowHTML(u);
          }).join('')}
                        </tbody>
                    </table>
                </div>
            `;
        }

        detailCell.innerHTML = `<div class="mission-detail-content">${unitsTableHTML}</div>`;
        initializeBootstrapTooltips(); // For tooltips in the new detail table

        if (expandIcon) {
          expandIcon.classList.add('expanded', 'fa-chevron-down');
          expandIcon.classList.remove('fa-chevron-right');
        }
      }
    }
    /**
    * Builds the complete HTML string for a unit row in a sub-table (e.g., assigned units).
    * This function is "dumb" and relies entirely on the pre-calculated unit.display object.
    * @param {object} unit - The unit data object, which must have a pre-calculated `display` property.
    * @returns {string} The HTML for the table row.
    */
    function buildUnitSubTableRowHTML(unit) {
      const display = unit.display; // All calculations are already done!

      return `
            <tr>
                <td>
                    <a href="#" class="unit-name-link" 
                      data-unit-id="${unit.id}" 
                      data-unit-lat="${unit.lat || ''}" 
                      data-unit-lon="${unit.lon || ''}"
                    >${unit.name}</a>
                </td>
                <td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" title="${display.subtypeTooltip}">${unit.classname || 'N/A'}</td>
                <td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" title="${display.loadout.tooltip}">${display.loadout.text}</td>
                <td data-bs-toggle="tooltip" data-bs-placement="top" title="${display.status.tooltip}">
                    <span class="badge rounded-pill ${display.status.badgeClass}">${display.status.text}</span>
                </td>
                <td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" title="${display.integrity.tooltip}">
                    <span class="${display.integrity.className}">${display.integrity.text}</span>
                </td>
                <td>${unit.base || 'N/A'}</td>
                <td><span class="${display.fuelClass}">${unit.fuel_status || 'N/A'}</span></td>
                <td data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" title="${display.proficiency.tooltip}">
                    ${display.proficiency.html}
                </td>
                <td class="text-nowrap">${display.actionsHTML}</td>
            </tr>
        `;
    }
    function attachUnitDetailTableActionListeners(parentElement) { // Takes the parent element (detailCell or its inner table tbody)
      if (!parentElement) return;
      parentElement.querySelectorAll('.unit-name-link').forEach(link => {
        link.addEventListener('click', function (e) {
          e.preventDefault();
          handleUnitNameClick(this.dataset.unitId, this.dataset.unitLat, this.dataset.unitLon);
        });
      });
      parentElement.querySelectorAll('.modify-loadout-btn').forEach(btn => {
        btn.addEventListener('click', function (event) { // Keep 'event' if needed
          event.preventDefault();
          const unitIdToPass = this.dataset.unitId;
          openAircraftLoadout(unitIdToPass); // Call your new function
        });
      });
      parentElement.querySelectorAll('.open-doctrine-btn').forEach(btn => {
        btn.addEventListener('click', function (e) {
          e.preventDefault();
          handleOpenDoctrineClick(this.dataset.unitId, this.dataset.unitName);
        });
      });
    }
    /**
    * Updates the 'hideUnavailableReserve' filter state and triggers a re-render.
    * This becomes the single point of control for this filter.
    * @param {boolean} shouldHide - The new state for the filter.
    */
    function updateHideUnavailableFilter(shouldHide) {
      // 1. Update the state object (single source of truth)
      currentUnitFilters.hideUnavailableReserve = shouldHide;

      // 2. Update the UI to match the state
      const checkbox = document.getElementById('unit-hide-unavailable-filter');
      if (checkbox) {
        checkbox.checked = shouldHide;
      }

      // 3. Mark the table as dirty and re-render
      uiState.isUnitsTableDirty = true;

      // If we are already on the units view, render immediately.
      // Otherwise, the change will be picked up when we switch to it.
      if (document.getElementById('units-view').classList.contains('active')) {
        renderUnitsTable();
      }
    }
    function populateUnitFilters(unitsCurrentlyInTable) {
      // unitsCurrentlyInTable is the result of renderUnitsTable's filtering.
      // If called initially, it might be null/undefined, so we get a base set.
      const baseSourceUnitsForOptions = unitsCurrentlyInTable || unitData.filter(unit => {
        const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
        const showUNA = document.getElementById('unit-hide-unavailable-filter')?.checked || false;
        if (!showNCU && (unit.NCU === "true" || unit.NCU === true)) return false;
        if (showUNA && unit.loadout === 9002) return false;
        return true;
      });

      const typeFilterEl = document.getElementById('unit-type-filter');
      //const subtypeFilterEl = document.getElementById('unit-subtype-filter'); // Commented out in your provided code
      const missionFilterEl = document.getElementById('unit-mission-filter');
      const baseFilterEl = document.getElementById('unit-base-filter');
      const missionMTypeFilterEl = document.getElementById('unit-mission-mtype-filter');
      const statusFilterEl = document.getElementById('unit-status-filter');
      const loadoutRoleFilterEl = document.getElementById('unit-loadout-role-filter');

      // Preserve current selections
      const currentSelections = {
        type: typeFilterEl.value,
        // subtype: subtypeFilterEl.value, // Commented out as per your code
        mission: missionFilterEl.value,
        base: baseFilterEl.value,
        missionMType: missionMTypeFilterEl.value,
        condition: statusFilterEl.value,
        loadoutRole: loadoutRoleFilterEl.value
      };
      // ADD this new function somewhere with your other helper functions.


      // --- Filters that show ALL possible options (from full dataset, respecting NCU) ---
      const ncuFilteredFullUnitData = unitData.filter(unit => {
        const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
        if (!showNCU && (unit.NCU === "true" || unit.NCU === true)) return false;
        return true;
      });

      // 1. Unit Types
      const allTypes = [...new Set(ncuFilteredFullUnitData.map(u => u.unitType).filter(Boolean))].sort();
      typeFilterEl.innerHTML = '<option value="">All Types</option>' + allTypes.map(t => `<option value="${t}" ${currentSelections.type === t ? 'selected' : ''}>${t}</option>`).join('');

      const allMissionsDetailsArray = getAllMissionsArray(missionData); // Assuming this function exists

      // 5. Mission MTypes
      const allMissionMTypes = [...new Set(allMissionsDetailsArray.map(m => m.mType).filter(Boolean))].sort();
      missionMTypeFilterEl.innerHTML = '<option value="">All Mission Types</option>' + allMissionMTypes.map(mt => `<option value="${mt}" ${currentSelections.missionMType === mt ? 'selected' : ''}>${mt}</option>`).join('');

      // 6. Status
      const availableStatuses = [...new Set(ncuFilteredFullUnitData.map(u => u.condition).filter(Boolean))].sort();
      statusFilterEl.innerHTML = '<option value="">All Conditions</option>' + availableStatuses.map(status => {
        const isSelected = currentSelections.condition === status;
        if (currentSelections.condition && currentSelections.condition !== "" && status === currentSelections.condition) {
          console.debug(`POPULATE_FILTERS --- MATCH! Setting '${status}' as selected because currentSelections.condition is '${currentSelections.condition}'`);
        }
        return `<option value="${status}" ${isSelected ? 'selected' : ''}>${status}</option>`;
      }).join('');
      // 7. Loadout Roles
      const allAircraftLoadoutRoles = [...new Set(
        ncuFilteredFullUnitData
          .filter(u => u.unitType === 'Aircraft' && u.loadout_role)
          .map(u => u.loadout_role.toString())
      )].sort((a, b) => (loadoutRoleEnum[a] || '').localeCompare(loadoutRoleEnum[b] || '')); // Assuming loadoutRoleEnum and getLoadoutRoleText exist

      loadoutRoleFilterEl.innerHTML = '<option value="">All Load. Roles</option>' +
        allAircraftLoadoutRoles.map(roleId =>
          `<option value="${roleId}" ${currentSelections.loadoutRole === roleId ? 'selected' : ''}>${getLoadoutRoleText(roleId)}</option>`
        ).join('');

      // --- LOGIC FOR DYNAMIC MISSION AND BASE FILTERS ---
      let unitsForMissionFilterPopulation;
      if (currentSelections.base === "" || !currentSelections.base) {
        unitsForMissionFilterPopulation = ncuFilteredFullUnitData;
      } else {
        unitsForMissionFilterPopulation = ncuFilteredFullUnitData.filter(unit => unit.base === currentSelections.base);
      }
      // 8. Assigned Mission Names (DYNAMIC based on Base Filter selection)
      // Get all unique mission names from the units determined above
      let potentialMissionsFromUnits = [...new Set(unitsForMissionFilterPopulation.map(u => u.mission).filter(Boolean))];

      // *** NEW: Filter these missions by the selected Mission MType ***
      const selectedUnitMissionMType = currentSelections.missionMType; // Get the value from the "#unit-mission-mtype-filter"
      let finalMissionsForDropdown;

      if (selectedUnitMissionMType) {

        finalMissionsForDropdown = potentialMissionsFromUnits.filter(missionName => {
          const missionDetails = allMissionsMap[missionName];
          // Keep the mission if its MType matches the selected MType
          return missionDetails && missionDetails.mType === selectedUnitMissionMType;
        }).sort();
      } else {
        // If no Mission MType is selected, show all missions derived from unitsForMissionFilterPopulation
        finalMissionsForDropdown = potentialMissionsFromUnits.sort();
      }

      missionFilterEl.innerHTML = '<option value="">All Missions</option>' +
        finalMissionsForDropdown.map(mName => `<option value="${mName}" ${currentSelections.mission === mName ? 'selected' : ''}>${mName}</option>`).join('');


      // 9. Bases (DYNAMIC based on Mission Filter selection - this logic should be correct)
      let unitsToConsiderForBaseOptions;
      // First, filter by mission if a mission is selected (your existing logic)
      if (currentSelections.mission === "" || !currentSelections.mission) {
        unitsToConsiderForBaseOptions = ncuFilteredFullUnitData;
      } else {
        unitsToConsiderForBaseOptions = ncuFilteredFullUnitData.filter(unit => unit.mission === currentSelections.mission);
      }

      // Now, further refine the BASES THEMSELVES based on unitBaseDropdownPopulationType
      let potentialBases = new Set();
      unitsToConsiderForBaseOptions.forEach(unit => { // Iterate units to find their 'base'
        if (unit.base && unit.base.trim() !== "") {
          // Find the actual unit object that IS the base, to check its type
          const baseUnitObject = ncuFilteredFullUnitData.find(bUnit => bUnit.name === unit.base);

          if (unitBaseDropdownPopulationType === 'land') {
            if (airbaseData[unit.base] || (baseUnitObject && baseUnitObject.unitType === 'Facility')) {
              potentialBases.add(unit.base);
            }
          } else if (unitBaseDropdownPopulationType === 'sea') {
            if (baseUnitObject && (baseUnitObject.unitType === 'Ship' || baseUnitObject.unitType === 'Submarine')) {
              potentialBases.add(unit.base);
            }
          } else { // 'all' or default
            potentialBases.add(unit.base);
          }
        }
      });

      // If 'land' and 'airbases_only' was a more specific option you want to keep:
      // if (unitBaseDropdownPopulationType === 'airbases_only') { // Assuming you had a more specific type
      //     Object.keys(airbaseData).forEach(abName => potentialBases.add(abName));
      //     unitsToConsiderForBaseOptions.forEach(u => { // Add bases of units that are at known airbases
      //          if (u.base && airbaseData[u.base]) potentialBases.add(u.base);
      //     });
      // }


      const finalBasesToDisplay = Array.from(potentialBases).sort();
      let baseOptionsHTML = '<option value="">All Bases</option>';
      finalBasesToDisplay.forEach(b => {
        baseOptionsHTML += `<option value="${b}" ${currentSelections.base === b ? 'selected' : ''}>${b}</option>`;
      });
      baseFilterEl.innerHTML = baseOptionsHTML;

      // Restore previous selection or default to "All Bases"
      if (finalBasesToDisplay.includes(currentSelections.base)) {
        baseFilterEl.value = currentSelections.base;
      } else {
        baseFilterEl.value = ""; // Default to "All Bases" if previous selection is no longer valid
        if (currentUnitFilters.base !== "") { // Only update state if it changed
          currentUnitFilters.base = ""; // Also update the actual filter state
        }
      }


      // --- Filters that are DYNAMIC based on other selections (use baseSourceUnitsForOptions) ---
      // 2. Unit Subtypes
      // updateUnitSubtypeFilterOptions(baseSourceUnitsForOptions, currentSelections.type, currentSelections.subtype); // Commented out as per your code
    }

    // updateUnitSubtypeFilterOptions needs to use the correct source for its options
    function updateUnitSubtypeFilterOptions(unitsInTable, selectedType, currentSelectedSubtype) {
        const subtypeFilterEl = document.getElementById('unit-subtype-filter');
        if (!subtypeFilterEl) return; // Defensive check

        let subtypesToShow;
        let relevantUnits = unitsInTable;

        // First, filter by type if one is selected.
        if (selectedType) {
            relevantUnits = unitsInTable.filter(u => u.unitType === selectedType);
        }

        // Now, map over the relevant units to get their subtypes from the pre-calculated property.
        // The `display` object and its `subtypeString` are guaranteed to exist from our preprocessing step.
        subtypesToShow = [...new Set(
            relevantUnits.map(u => u.display.subtypeString).filter(Boolean)
        )].sort();
        
        // Build the final HTML for the dropdown options.
        subtypeFilterEl.innerHTML = '<option value="">All Subtypes</option>' + 
            subtypesToShow.map(s => `<option value="${s}" ${currentSelectedSubtype === s ? 'selected' : ''}>${s}</option>`).join('');
    }

    function renderFilteredUnitsSummary(filteredUnitsArray) {
      const statsContainer = document.getElementById('filtered-units-stats');
      if (!statsContainer) return;

      if (!filteredUnitsArray || filteredUnitsArray.length === 0) {
        statsContainer.innerHTML = '<div class="col-12"><p class="text-muted-color">No units match current filters to summarize.</p></div>';
        return;
      }

      const totalUnitsDisplayed = filteredUnitsArray.length;
      const unitsByType = {};

      // Initialize counts based on the categories returned by getUnitOperationalStatus
      // and any other specific counts you want.
      const statusCounts = {
        "Ready": 0,
        "Ongoing/Airborne": 0,
        "Readying": 0,
        "Unavailable": 0, // Combined from "Unavailable" role
        "Reserve": 0,     // Combined from "Reserve" role
        "Significant Issues": 0,
        "Minor Issues": 0, // If you want to show this
        "Operational": 0,  // For Facilities mostly
        "Other/Unknown": 0,
        // Specific counts you might still want in addition to getUnitOperationalStatus categories:
        "With Mission": 0,
        "Available (No Mission)": 0 // Specifically "Ready" units without a mission
      };


      filteredUnitsArray.forEach(unit => {
        unitsByType[unit.unitType] = (unitsByType[unit.unitType] || 0) + 1;

        const operationalStatus = unit.operationalStatus // Get the consistent status

        if (statusCounts.hasOwnProperty(operationalStatus)) {
          statusCounts[operationalStatus]++;
        } else {
          statusCounts["Other/Unknown"]++; // Fallback
          console.warn(`Unit ${unit.name} returned unhandled status: ${operationalStatus} in renderFilteredUnitsSummary`);
        }

        // For "With Mission" and "Available (No Mission)"
        if (unit.mission && unit.mission.trim() !== "") {
          statusCounts["With Mission"]++;
        } else if (operationalStatus === "Ready") { // Only count if "Ready" AND no mission
          statusCounts["Available (No Mission)"]++;
        }
      });

      let summaryHTML = '';

      // --- Section 1: Unit Statistics (using new statusCounts) ---
      summaryHTML += `<div class="col-lg-8 col-md-12  summary-section">`; // Adjusted width
      summaryHTML += `<ul class="list-inline unit-summary-stat-list">`;
      summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-users me-1 text-muted-color"></i><strong style="color:var(--text-color);">Total:</strong> ${totalUnitsDisplayed.toLocaleString()}</small></li>`;

      // Display statuses from statusCounts. Choose which ones are most relevant for this summary.
      if (statusCounts["Ready"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-check-circle me-1 text-success"></i><strong style="color:var(--text-success);">Ready:</strong> ${statusCounts["Ready"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Ongoing/Airborne"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-route me-1 text-primary"></i><strong style="color:var(--accent-color);">Ongoing/Airborne:</strong> ${statusCounts["Ongoing/Airborne"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Operational"] > 0) { // For facilities primarily
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-building me-1 text-info"></i><strong style="color:var(--info-color);">Operational:</strong> ${statusCounts["Operational"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Readying"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-hourglass-half me-1 text-warning"></i><strong style="color:var(--warning-color);">Readying:</strong> ${statusCounts["Readying"].toLocaleString()}</small></li>`;
      }
      summaryHTML += `</ul><ul class="list-inline unit-summary-stat-list">`;
      if (statusCounts["With Mission"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-bullseye me-1 text-info"></i><strong style="color:var(--info-color);">Tasked:</strong> ${statusCounts["With Mission"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Available (No Mission)"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-plane-departure me-1 text-success"></i><strong style="color:var(--success-color);">Available (Idle):</strong> ${statusCounts["Available (No Mission)"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Minor Issues"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-exclamation-circle me-1 text-warning"></i><strong style="color:var(--warning-color);">Minor Issues:</strong> ${statusCounts["Minor Issues"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Significant Issues"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-bomb me-1 text-danger"></i><strong style="color:var(--danger-color);">Significant Issues:</strong> ${statusCounts["Significant Issues"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Unavailable"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-times-circle me-1 text-danger"></i><strong style="color:var(--danger-color);">Unavailable:</strong> ${statusCounts["Unavailable"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Reserve"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-archive me-1 text-secondary"></i><strong style="color:var(--text-muted-color);">Reserve:</strong> ${statusCounts["Reserve"].toLocaleString()}</small></li>`;
      }
      if (statusCounts["Other/Unknown"] > 0) {
        summaryHTML += `<li class="list-inline-item me-3 mb-1"><small><i class="fas fa-question-circle me-1 text-muted-color"></i><strong style="color:var(--text-muted-color);">Other/Unknown:</strong> ${statusCounts["Other/Unknown"].toLocaleString()}</small></li>`;
      }

      summaryHTML += `</ul></div>`;

      // --- Section 2: Unit Type Breakdown (remains the same) ---
      if (Object.keys(unitsByType).length > 0) {
        summaryHTML += `<div class="col-lg-4 col-md-12 mb-3 summary-section">`; // Adjusted width
        summaryHTML += `<ul class="list-inline unit-type-summary-list">`;
        Object.entries(unitsByType).sort((a, b) => b[1] - a[1]).forEach(([type, count]) => {
          let iconClass = 'fa-cube';
          if (type.toLowerCase().includes('aircraft')) iconClass = 'fa-fighter-jet';
          else if (type.toLowerCase().includes('ship')) iconClass = 'fa-ship';
          else if (type.toLowerCase().includes('facility')) iconClass = 'fa-building';
          else if (type.toLowerCase().includes('satellite')) iconClass = 'fa-satellite'; // Added Satellite
          // else if (type.toLowerCase().includes('ground')) iconClass = 'fa-users'; // If you have specific ground types
          // else if (type.toLowerCase().includes('submarine')) iconClass = 'fa-water';
          summaryHTML += `
                <li class="list-inline-item me-3 mb-1">
                    <small><i class="fas ${iconClass} me-1 text-muted-color"></i><strong style="color:var(--text-color);">${type}:</strong> ${count.toLocaleString()}</small>
                </li>`;
        });
        summaryHTML += `</ul></div>`;
      }

      statsContainer.innerHTML = summaryHTML;
    }
    function getUnitOperationalStatus(unit) {
      // Returns one of: "Ready", "Ongoing/Airborne", "Readying", "Unavailable","Reserve", "Significant Issues", "Other"
      // This logic is adapted from renderFilteredUnitsSummary and getUnitCriticalIssues

      const isParked = unit.condition && (unit.condition.toLowerCase().startsWith('parked') || unit.condition === 'Docked');
      const roleId = unit.unitType === 'Aircraft' ? parseInt(unit.loadout_role, 10) : null;
      const isUnavailableRole = (roleId === 9002 || roleId === "9002");
      const isReserveRole = (roleId === 9003 || roleId === "9003");

      if (isUnavailableRole || unit.condition === "UNAVAILABLE_STATUS") { // Assuming a hypothetical explicit unavailable status
        return "Unavailable";
      }
      if (isReserveRole || (isParked && unit.readytime_s === "")) {
        return "Reserve";
      }

      const damagePercent = parseFloat(unit.damage?.dp_percent_now);
      if (!isNaN(damagePercent) && damagePercent >= 70) { // Severe damage
        return "Significant Issues";
      }

      // Operational checks
      if (isParked && !isUnavailableRole && !isReserveRole) { // Parked and operationally available role
        if (!isNaN(damagePercent) && damagePercent >= 40) return "Significant Issues"; // Parked but mod damage
        return "Ready";
      }

      if (unit.condition && (
        unit.condition.toLowerCase() === 'underway' ||
        unit.condition.toLowerCase().includes('active') || // Generic active
        unit.condition.toLowerCase().includes('rtb') ||
        unit.condition.toLowerCase().includes('airborne') ||
        unit.condition.toLowerCase().includes('on station') ||
        unit.condition.toLowerCase().includes('engaged') ||
        unit.condition.toLowerCase().includes('refuel') ||
        unit.condition.toLowerCase().includes('offloading fuel')
      )) {
        if (!isNaN(damagePercent) && damagePercent >= 40) return "Significant Issues"; // Active but mod damage
        const fuel = parseFloat(unit.fuel_status);
        if (!isNaN(fuel) && fuel < 15) return "Significant Issues"; // Active but critical fuel
        return "Ongoing/Airborne";
      }

      if (unit.condition && unit.condition.toLowerCase() === 'readying') {
        return "Readying";
      }

      // If it has moderate damage or other critical issues not yet caught by role/condition
      if (!isNaN(damagePercent) && damagePercent >= 40) {
        return "Significant Issues";
      }
      const fuel = parseFloat(unit.fuel_status);
      if (!isNaN(fuel) && fuel < 15 && unit.condition && !['Parked', 'Maintenance', 'RESERVE', 'UNAVAILABLE_STATUS'].includes(unit.condition.toUpperCase())) {
        return "Significant Issues"; // Critical fuel while not explicitly parked/reserve
      }


      // If not fitting any above specific operational states but has minor issues (e.g. light damage)
      const criticalIssues = unit.criticalIssues; // Use your existing detailed issue checker
      if (criticalIssues.some(issue => issue.severity === 1 || (issue.severity === 2 && issue.type !== 'Fuel' && issue.type !== 'Damage'))) { // Example: severity 1 or 2 non-critical issues
        return "Minor Issues"; // A new category for the chart if desired
      }


      // Fallback - could be units with no explicit condition but no major issues either, or less critical facilities
      // For the chart, we might categorize these differently, or as "Other" if they are not clearly operational or down.
      // If a unit is a facility and has no specific negative condition, it might be considered 'Nominal' or 'Fully Operational'.
      if (unit.unitType === 'Facility' && (!unit.condition || unit.condition === "")) {
        if (!isNaN(damagePercent) && damagePercent > 0) return "Minor Issues"; // Facility with some damage
        return "Operational"; // Default for facilities if no other issues
      }


      // Default for units not fitting cleanly into above. Could be an issue if many fall here.
      // console.warn(`Unit ${unit.name} (${unit.classname}) with condition "${unit.condition}" and role "${unit.loadout_role}" did not fit a clear operational status for the chart.`);
      if (unit.unitType === 'Satellite') {

        return "Ongoing/Airborne"
      }

      return "Other/Unknown";
    }
    function sortUnits(units, sortConfig) {
      const { column, order, secondaryColumn, secondaryOrder } = sortConfig;
      const NATURAL_SORT_COLUMNS = ['name'];

      const getSortableValue = (unit, colName) => {
        if (!unit) return null;

        // Use pre-calculated values where possible
        if (colName === 'loadout_role') return unit.display?.loadout?.text || 'N/A';
        if (colName === 'integrity') return 100 - (parseFloat(unit.damage?.dp_percent_now) || 0);
        if (colName === 'unitSubtype') return unit.display?.subtypeString || 'N/A';

        if (colName === 'fuel_status') {
          const fuel = parseFloat(unit.fuel_status);
          // Treat NaN/null as -1 to sort them at the beginning in ascending order
          return isNaN(fuel) ? -1 : fuel;
        }

        // Default direct property access
        return unit[colName];
      };

      units.sort((a, b) => {
        let comparison = 0;

        // Primary Sort
        const valA = getSortableValue(a, column);
        const valB = getSortableValue(b, column);

        if (NATURAL_SORT_COLUMNS.includes(column)) {
          comparison = naturalCompare(valA, valB);
        } else if (typeof valA === 'number' && typeof valB === 'number') {
          comparison = valA - valB;
        } else {
          const strA = String(valA ?? "").toLowerCase();
          const strB = String(valB ?? "").toLowerCase();
          comparison = strA.localeCompare(strB);
        }

        if (order === 'desc') {
          comparison *= -1;
        }

        // Secondary Sort
        if (comparison === 0 && secondaryColumn) {
          const secValA = getSortableValue(a, secondaryColumn);
          const secValB = getSortableValue(b, secondaryColumn);

          if (NATURAL_SORT_COLUMNS.includes(secondaryColumn)) {
            comparison = naturalCompare(secValA, secValB);
          } else if (typeof secValA === 'number' && typeof secValB === 'number') {
            comparison = secValA - secValB;
          } else {
            const strA = String(secValA ?? "").toLowerCase();
            const strB = String(secValB ?? "").toLowerCase();
            comparison = strA.localeCompare(strB);
          }

          if (secondaryOrder === 'desc') {
            comparison *= -1;
          }
        }

        return comparison;
      });

      return units;
    }
    function updateSelectAllCheckboxState() {
      const selectAllCheckbox = document.getElementById('unit-select-all-checkbox');
      if (!selectAllCheckbox) return;

      const totalVisible = currentUnitsInTableForSelection.length;
      // This is a more efficient way to get the count of selected items that are also visible
      let selectedInViewCount = 0;
      for (const unit of currentUnitsInTableForSelection) {
        if (selectedUnitIds.has(unit.id)) {
          selectedInViewCount++;
        }
      }

      if (totalVisible === 0) {
        selectAllCheckbox.checked = false;
        selectAllCheckbox.indeterminate = false;
      } else if (selectedInViewCount === 0) {
        selectAllCheckbox.checked = false;
        selectAllCheckbox.indeterminate = false;
      } else if (selectedInViewCount === totalVisible) {
        selectAllCheckbox.checked = true;
        selectAllCheckbox.indeterminate = false;
      } else {
        selectAllCheckbox.checked = false;
        selectAllCheckbox.indeterminate = true;
      }
    }


    function renderUnitsTable() {
      console.time('Render Units Table')
      uiState.isUnitsTableDirty = false; // Mark as clean immediately

      // --- 1. DATA PREPARATION ---
      // This is the complete, non-placeholder filter logic.
      const searchStr = currentUnitFilters.search.toLowerCase();


      let filteredUnits = unitData.filter(unit => {
        // --- High-priority filters (apply first for efficiency) ---
        if (!currentUnitFilters.showNCU && (unit.NCU === "true" || unit.NCU === true)) {
          return false;
        }
        if (currentUnitFilters.hideUnavailableReserve && unit.unitType === 'Aircraft') {
          const roleId = parseInt(unit.loadout_role, 10);
          if (roleId === 9002) { // Hide both Unavailable and Reserve
            return false;
          }
        }
        if (currentUnitFilters.operationalStatus &&
          unit.operationalStatus !== currentUnitFilters.operationalStatus) {
          return false;
        }

        // --- Text Search ---
        if (searchStr && !(
          (unit.name && unit.name.toLowerCase().includes(searchStr)) ||
          (unit.classname && unit.classname.toLowerCase().includes(searchStr))
        )) {
          return false;
        }

        // --- Dropdown Filters ---
        if (currentUnitFilters.type && unit.unitType !== currentUnitFilters.type) return false;
        if (currentUnitFilters.subtype && unit.display.subtypeString !== currentUnitFilters.subtype) return false;
        if (currentUnitFilters.base && unit.base !== currentUnitFilters.base) return false;
        if (currentUnitFilters.mission && unit.mission !== currentUnitFilters.mission) return false;
        if (currentUnitFilters.condition && unit.condition !== currentUnitFilters.condition) return false;

        // --- Loadout Role Filter ---
        if (currentUnitFilters.loadoutRole) {
          if (unit.unitType === 'Aircraft') {
            if (!unit.loadout_role || unit.loadout_role.toString() !== currentUnitFilters.loadoutRole) {
              return false;
            }
          } else {
            return false; // Exclude non-aircraft if a role filter is active
          }
        }

        // --- Mission Property Filters ---
        if (currentUnitFilters.missionMType) {
          if (!unit.mission) return false;
          const missionDetails = allMissionsMap[unit.mission];
          if (!missionDetails || missionDetails.mType !== currentUnitFilters.missionMType) return false;
        }

        // --- Criticality Filter ---
        if (currentUnitFilters.showOnlyCritical) {
          // Use the pre-calculated 'criticalIssues' array.
          // An empty array means no issues.
          if (!unit.criticalIssues || unit.criticalIssues.length === 0) {
            return false;
          }
        }

        return true; // Unit passes all filters
      });

      const sortedUnits = sortUnits(filteredUnits, currentUnitSort);
      currentUnitsInTableForSelection = [...sortedUnits];

      // --- 2. DOM PREPARATION & COMPARISON ---
      const tbody = document.getElementById('units-table-body');
      if (!tbody) { console.error("Units table body not found!"); return; }

      const currentDomIds = Array.from(tbody.rows, row => row.dataset.unitId).filter(Boolean);
      const newSortedIds = sortedUnits.map(u => u.id);

      if (JSON.stringify(currentDomIds) === JSON.stringify(newSortedIds)) {
        console.debug("DOM is already in sync. Skipping render.");
        tbody.querySelectorAll('tr[data-unit-id]').forEach(row => {
          const unitId = row.dataset.unitId;
          const isSelected = selectedUnitIds.has(unitId);

          // Sync both the row highlight AND the checkbox state
          row.classList.toggle('row-selected', isSelected);
          const checkbox = row.querySelector('.unit-row-checkbox');
          if (checkbox) {
            checkbox.checked = isSelected;
          }
        });
        // Don't forget to update the "Select All" checkbox state as well!
        updateSelectAllCheckboxState();
        updateBatchActionUIState();
        return;
      }

      // --- 3. INTELLIGENT DOM UPDATING ---
      const newVisibleIdSet = new Set(newSortedIds);
      const rowCache = new Map();

      for (const row of tbody.children) {
        const unitId = row.dataset.unitId;
        if (unitId) {
          if (newVisibleIdSet.has(unitId)) {
            rowCache.set(unitId, row);
          } else {
            row.remove();
            if (tomSelectInstances.has(unitId)) {
              tomSelectInstances.get(unitId).destroy();
              tomSelectInstances.delete(unitId);
            }
          }
        }
      }

      const allMissionsArray = getAllMissionsArray(missionData);
      const missionOptionsHTML = buildMissionOptionsHTML(allMissionsArray);
      const fragment = document.createDocumentFragment();

      newSortedIds.forEach(unitId => {
        let row = rowCache.get(unitId);
        const isSelected = selectedUnitIds.has(unitId);
        if (row) {
          row.classList.toggle('row-selected', isSelected);
          const checkbox = row.querySelector('.unit-row-checkbox');
          if (checkbox) {
            checkbox.checked = isSelected;
          }
        } else {
          const unit = sortedUnits.find(u => u.id === unitId);
          row = document.createElement('tr');

          // ** KEY CHANGE: Use the new node builder **
          buildAndAppendUnitRowCells(row, unit, missionOptionsHTML);

          const selectEl = row.querySelector('.mission-select-tom');
          if (selectEl) {
            initializeTomSelectForUnit(selectEl);
          }
        }
        fragment.appendChild(row);
      });

      tbody.replaceChildren(fragment);

      // --- 4. POST-PROCESSING & CLEANUP ---
      if (sortedUnits.length === 0) {
        // Correctly calculate colspan based on visible columns
        const visibleCols = Object.values(unitsTableColumnVisibility).filter(v => v).length || document.querySelectorAll('#units-table thead th').length;
        tbody.innerHTML = `<tr><td colspan="${visibleCols}" class="no-data-message">No units match current filters.</td></tr>`;
      }

      updateTableColumnVisibility('units-table', unitsTableColumnVisibility);
      populateUnitFilters(sortedUnits);
      renderFilteredUnitsSummary(sortedUnits);
      const tooltipTriggerList = tbody.querySelectorAll('[data-bs-toggle="tooltip"]');
      tooltipTriggerList.forEach(tooltipTriggerEl => {
        // This check is still good practice.
        if (!bootstrap.Tooltip.getInstance(tooltipTriggerEl)) {
          new bootstrap.Tooltip(tooltipTriggerEl);
        }
      });
      const selectAllCheckbox = document.getElementById('unit-select-all-checkbox');
      if (selectAllCheckbox) {
        const totalVisible = currentUnitsInTableForSelection.length;
        const totalSelectedInView = currentUnitsInTableForSelection.filter(u => selectedUnitIds.has(u.id)).length;

        if (totalSelectedInView === 0) {
          selectAllCheckbox.checked = false;
          selectAllCheckbox.indeterminate = false;
        } else if (totalSelectedInView === totalVisible && totalVisible > 0) {
          selectAllCheckbox.checked = true;
          selectAllCheckbox.indeterminate = false;
        } else {
          selectAllCheckbox.checked = false;
          selectAllCheckbox.indeterminate = true;
        }
      }
      updateSelectAllCheckboxState();
      updateBatchActionUIState();
      console.timeEnd('Render Units Table')
    }
    /**
 * Creates and configures the `<td>` elements for a unit row and appends them.
 * This avoids innerHTML parsing and is faster for creating new rows.
 * @param {HTMLTableRowElement} tr - The `<tr>` element to append cells to.
 * @param {object} unit - The unit data object with its `display` property.
 * @param {string} missionOptionsHTML - The pre-built HTML for the mission dropdown.
 */
    function buildAndAppendUnitRowCells(tr, unit, missionOptionsHTML) {
      const d = unit.display; // Alias for convenience

      // Set row properties
      tr.dataset.unitId = unit.id;
      tr.classList.toggle('row-selected', selectedUnitIds.has(unit.id));

      // Create and append each cell
      tr.innerHTML = `
        <td class="unit-checkbox-cell">
            <input 
                class="form-check-input unit-row-checkbox" 
                type="checkbox" 
                data-unit-id="${unit.id}" 
                ${selectedUnitIds.has(unit.id) ? 'checked' : ''}
            >
        </td>
        <td data-col-id="id">${unit.id}</td>
        <td data-col-id="name" title="${unit.name}" data-bs-toggle="tooltip" data-bs-placement="top">
            <a href="#" class="unit-name-link" data-unit-id="${unit.id}" data-unit-lat="${unit.lat}" data-unit-lon="${unit.lon}">${d.truncated.name}</a>
        </td>
        <td data-col-id="classname" title="${d.subtypeTooltip}" data-bs-toggle="tooltip" data-bs-placement="top">
            <span 
                class="classname-clickable" 
                data-unit-dbid="${unit.dbid}" 
                data-unit-type="${unit.unitType}"
            >${d.truncated.classname}</span>
        </td>
        <td data-col-id="unitType">${unit.unitType}</td>
        <td data-col-id="unitSubtype">${d.subtypeString}</td>
        <td data-col-id="mission">
            <select class="mission-select-tom" data-unit-id="${unit.id}" ${d.isMissionSelectDisabled ? 'disabled' : ''}>
                ${missionOptionsHTML.replace(`value="${unit.mission}"`, `value="${unit.mission}" selected`)}
            </select>
        </td>
        <td data-col-id="base" title="${unit.base || 'N/A'}" data-bs-toggle="tooltip" data-bs-placement="top">${d.truncated.base || 'N/A'}</td>
        <td data-col-id="condition" title="${d.status.tooltip}" data-bs-toggle="tooltip" data-bs-placement="top">
            <span class="badge rounded-pill ${d.status.badgeClass}">${d.status.text}</span>
        </td>
        <td data-col-id="loadoutRole" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true" title="${d.loadout.tooltip}">${d.loadout.text}</td>
        <td data-col-id="integrity" title="${d.integrity.tooltip}" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true">
            <span class="${d.integrity.className}">${d.integrity.text}</span>
            ${unit.isJammed ? '<i class="fas fa-bolt ms-1 text-danger" title="Being Jammed"></i>' : ''}
        </td>
        <td data-col-id="fuel"><span class="${d.fuelClass}">${unit.fuel_status || 'N/A'}</span></td>
        <td data-col-id="proficiency" title="${d.proficiency.tooltip}" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-html="true">${d.proficiency.html}</td>
        <td data-col-id="actions">${d.actionsHTML}</td>
    `;
    }
    // This new function creates the HTML for the mission tooltip
    function createMissionTooltipHTML(missionName) {

      const mission = allMissionsMap[missionName];
      if (!mission) return 'Mission details not found.';

      const assignedUnitsCount = unitData.filter(u => u.mission === missionName).length;
      const startTime = mission.startT ? formatCustomUTC(parseAsUTC(mission.startT)) : 'N/A';
      const endTime = mission.endT ? formatCustomUTC(parseAsUTC(mission.endT)) : 'N/A';
      const mTag = mission.mTag || 'Unknown';
      const taskPoolText = (mission.taskPool && mission.taskPool !== "No TaskPool") ? mission.taskPool : 'No TaskPool';
      return `
      <div class="mission-tooltip-content">
          <div class="mission-tooltip-header">
              <div class="mission-tooltip-type">
                  <strong>${mission.mType || 'N/A'}</strong>
                  <small>${mission.mSubType || 'N/A'}</small>
              </div>
              <span class="badge mission-tag-badge" data-mtag="${mTag}">${mTag}</span>
          </div>
          <div class="mission-tooltip-body">
              <p><i class="fas fa-users"></i>Assigned Units: <strong>${assignedUnitsCount}</strong></p>
              <p><i class="fas fa-play"></i>Start: <strong>${startTime}</strong></p>
              <p><i class="fas fa-stop"></i>End: <strong>${endTime}</strong></p>
          </div>
          <div class="mission-tooltip-footer">
              <p><i class="fas fa-folder"></i>${taskPoolText}</p>
          </div>
      </div>
  `;
    }

    function applyTomSelectStyles(tomInstance, missionName) {
      if (!tomInstance || !tomInstance.control) return; // Add a safety check

      const control = tomInstance.control;
      // Remove any existing mission tag classes
      control.className.split(' ').forEach(cls => {
        if (cls.startsWith('ts-control-mtag-')) {
          control.classList.remove(cls);
        }
      });

      if (missionName) {
        // --- THIS IS THE FIX ---
        // DO NOT recalculate the map here. Use the global constant.
        const missionDetails = allMissionsMap[missionName];
        const mTag = missionDetails?.mTag?.toLowerCase() || 'unknown';
        control.classList.add(`ts-control-mtag-${mTag}`);
      } else {
        // Apply default style for "Unassigned"
        control.classList.add('ts-control-mtag-unassigned');
      }

    }

    /**
    * Builds the complete HTML string for the mission dropdown options, including optgroups.
    * This is called only ONCE per table render, not per row.
    * @param {Array} allMissions - The pre-calculated array of all mission objects.
    * @returns {string} An HTML string of <option> and <optgroup> elements.
    */
    function buildMissionOptionsHTML(allMissions) {
      // Start with the "Unassign" option.
      let optionsHTML = '<option value="">Unassign Mission</option>';

      // Group missions by their Task Pool
      const missionsByTaskPool = {};
      allMissions.forEach(mission => {
        const poolName = mission.taskPool || 'Uncategorized';
        if (!missionsByTaskPool[poolName]) {
          missionsByTaskPool[poolName] = [];
        }
        missionsByTaskPool[poolName].push(mission);
      });

      // Sort task pools alphabetically
      const sortedPoolNames = Object.keys(missionsByTaskPool).sort((a, b) => {
        if (a === 'Uncategorized') return 1;
        if (b === 'Uncategorized') return -1;
        return a.localeCompare(b);
      });

      // Build the HTML for each optgroup
      sortedPoolNames.forEach(poolName => {
        optionsHTML += `<optgroup label="${poolName}">`;
        const missionsInPool = missionsByTaskPool[poolName].sort((a, b) => a.name.localeCompare(b.name));
        missionsInPool.forEach(mission => {
          // NOTE: We do NOT add the 'selected' attribute here. We'll set the value later.
          optionsHTML += `<option value="${mission.name}">${mission.name}</option>`;
        });
        optionsHTML += `</optgroup>`;
      });

      return optionsHTML;
    }
    function initializeTomSelectForUnit(selectElement) {
      if (!selectElement) return;
      const unitId = selectElement.dataset.unitId;

      // Clean up any old instance for this ID, just in case.
      if (tomSelectInstances.has(unitId)) {
        tomSelectInstances.get(unitId).destroy();
      }

      const tomInstance = new TomSelect(selectElement, {
        // The options are already in the HTML, so TomSelect reads them automatically.
        // We only need to configure behavior and rendering.
        controlInput: null, // We are not searching in the control box.
        dropdownParent: 'body', // Important for visibility in a scrolling table.
        placeholder: 'Unassign Mission', // <--- ADD THIS
        allowEmptyOption: true,
        labelField: 'text',
        valueField: 'value',
        onDestroy: function () {
          if (this.popperInstance) {
            this.popperInstance.destroy();
            this.popperInstance = null;
          }
        },

        onInitialize: function () {
          this.popper = null;
          const initialValue = this.getValue();
          applyTomSelectStyles(this, initialValue);
          this.control_tippy = tippy(this.control, {
            placement: 'bottom',
            arrow: true,
            // We will set the content dynamically later
          });
          // Initially disable it so it doesn't show for "Unassigned"
          this.control_tippy.disable();
          if (initialValue === '' && this.items.length === 0) {
            this.addItem('', true);
            const itemElement = this.getItem('');
            if (itemElement) {
              itemElement.innerHTML = 'Unassigned';
            }
          }
        },
        onDropdownOpen: function () {
          if (this.popper) {
            this.popper.destroy();
            this.popper = null;
          }
          this.popper = Popper.createPopper(this.control, this.dropdown);
          this.popper.update();
          this.popper = Popper.createPopper(this.control, this.dropdown, {
            placement: 'bottom-start',
            strategy: 'fixed', // Use 'fixed' for better positioning within scrolling contexts
            modifiers: [
              {
                name: 'flip',
                options: {
                  // Tell Popper to use our scrollable div as the flipping boundary
                  boundary: document.getElementById('unit-table-div'),
                  padding: 10,
                },
              },
              {
                name: 'preventOverflow',
                options: {
                  // Also use the scrollable div as the overflow boundary
                  boundary: document.getElementById('unit-table-div'),
                  padding: 10,
                },
              },
              {
                name: 'offset',
                options: {
                  offset: [0, 6],
                },
              },
            ],
          });

        },
        onDropdownClose: function () {
          if (this.popper) { this.popper.destroy(); this.popper = null; }

        },
        positionDropdown: function () {
          // Let the library do its default positioning...
          this.position();
          // ...then immediately remove the fixed width it just set.
          this.dropdown.style.width = '';
        },
        render: {
          item: function (data, escape) {
            if (data.value === null || data.value === '') {
              return `<div>Unassigned</div>`;
            }
            // Truncate the displayed text in the control box.
            return `<div>${escape(truncate(data.text, 25))}</div>`;
          },
          option: function (data, escape) {
            const div = document.createElement('div');
            div.innerHTML = escape(data.text);
            if (data.value === '') {
              div.classList.add('option-unassign');
            }
            // Add the mission tooltip to each option in the dropdown.
            if (data.value && data.value !== '') {
              tippy(div, {
                content: 'Loading...',
                placement: 'right',
                theme: 'mission-tooltip',
                allowHTML: true,
                onShow(instance) {
                  instance.setContent(createMissionTooltipHTML(data.value));
                },
              });
            }
            return div;
          }
        }
      });

      // Add the change listener
      tomInstance.on('change', function (newMissionName) {
        this.blur(); // Good UX to remove focus from the dropdown

        const changedUnitId = this.input.dataset.unitId;
        if (!changedUnitId) return;

        // 1. Determine which units to update based on the current selection.
        const idsToUpdate = [];
        if (selectedUnitIds.size > 0 && selectedUnitIds.has(changedUnitId)) {
          // If the changed unit is part of a selection, apply to all selected.
          idsToUpdate.push(...selectedUnitIds);
        } else {
          // Otherwise, just apply to the single unit that was changed.
          idsToUpdate.push(changedUnitId);
        }

        // 2. Dispatch the work to our new central handler.
        if (idsToUpdate.length > 0) {
          updateUnitMissions(idsToUpdate, newMissionName, changedUnitId);
        }
      });

      // Add a tooltip to the main control box to show the full mission name on hover.
      tippy(tomInstance.control, {
        placement: 'top',
        onShow(instance) {
          const fullText = tomInstance.options[tomInstance.getValue()]?.text;
          if (fullText) {
            instance.setContent(fullText);
            return true;
          }
          return false; // Don't show for "Unassigned"
        }
      });

      // Apply initial styling and save the instance.
      applyTomSelectStyles(tomInstance, tomInstance.getValue());
      tomSelectInstances.set(unitId, tomInstance);
    }
    /**
    * The new central dispatcher for updating unit missions.
    * It handles data, UI, and backend calls in an orderly fashion.
    * @param {string[]} unitIdsToUpdate - An array of unit IDs to process.
    * @param {string} newMissionName - The target mission name.
    */
    function updateUnitMissions(unitIdsToUpdate, newMissionName, triggerUnitId) {
      console.time('UpdateMissions')
      const missionName = newMissionName || ""; // Normalize to empty string for "Unassigned"


      // --- 1. DATA UPDATE PASS ---
      // First, update all the objects in our local data model.
      unitIdsToUpdate.forEach(unitId => {
        // THE FIX: Instant lookup from the map
        const unit = unitMap.get(unitId);
        if (unit) {
          unit.mission = missionName;
        }
      });



      // --- 2. UI UPDATE PASS (The Fix) ---
      console.time('UI UPDATE PASS');
      unitIdsToUpdate.forEach(unitId => {
        if (unitId !== triggerUnitId) {
          const instance = tomSelectInstances.get(unitId);
          if (instance) {
            // This is the only place the expensive .setValue should be called.
            instance.setValue(missionName, true);
          }
        }
      });


      // --- 2b. STYLE UPDATE PASS (Separate and Fast) ---
      // Now, loop again to apply styles. This is cheap and ensures all instances,
      // including the trigger, get the correct style.
      unitIdsToUpdate.forEach(unitId => {
        const instance = tomSelectInstances.get(unitId);
        if (instance) {
          applyTomSelectStyles(instance, missionName);
        }
      });
      // --- 3. BATCH BACKEND CALL ---
      // Send all changes to the backend in one go.


      // --- 4. RENDER DEPENDENT COMPONENTS ---
      // Re-render other parts of the UI that depend on this data.
      requestAnimationFrame(() => {


        // The summary stats can be updated later.
        renderFilteredUnitsSummary(currentUnitsInTableForSelection);

        // The missions table (which might have an updated unit count) can also be updated later.
        if (document.getElementById('missions-view').classList.contains('active')) {
          uiState.isMissionsTableDirty = true;
          renderMissionsTable();
        }


      });

      console.timeEnd('UpdateMissions')
      sendBatchMissionUpdatesToBackend(unitIdsToUpdate, missionName);
    }
    // This new function initializes TomSelect and Tippy on a single <select> element


    function updateBatchActionUIState() {
      const selectedCount = selectedUnitIds.size;
      const batchActionInfoBar = document.getElementById('batch-action-info'); // Create this div
      if (batchActionInfoBar) {
        if (selectedCount > 0) {
          batchActionInfoBar.innerHTML = `${selectedCount} unit(s) selected. <button id="clear-selection-btn" class="btn btn-xs btn-outline-warning">Clear Selection</button>`;
          batchActionInfoBar.style.display = 'block';
          document.getElementById('clear-selection-btn')?.addEventListener('click', () => {
            selectedUnitIds.clear();
            lastSelectedUnitId = null;
            uiState.isUnitsTableDirty = true;
            renderUnitsTable();
            updateBatchActionUIState();
          });
        } else {
          batchActionInfoBar.style.display = 'none';
        }
      }
      // Enable/disable dedicated batch action buttons here if you add them
    }

    function handleOpenDoctrineClick(clickedUnitId) { // clickedUnitId is the original unit.id
      let idsToOpenDoctrineFor = []; // This will store the original unit.id values

      if (selectedUnitIds.size > 0 && selectedUnitIds.has(clickedUnitId)) {
        // If the button on a selected row is clicked, and there's a multi-selection,
        // assume action is for all selected units.
        idsToOpenDoctrineFor = Array.from(selectedUnitIds);
      } else if (selectedUnitIds.size > 0 && !selectedUnitIds.has(clickedUnitId)) {
        // If there's a multi-selection, but the button on an *unselected* row was clicked.
        // Ask the user for their intent.
        const clickedUnitObject = unitMap.get(clickedUnitID);
        const clickedUnitName = clickedUnitObject ? clickedUnitObject.name : "the clicked unit";

        if (confirm(`Open doctrine for ${clickedUnitName} only? \n(Press Cancel to open doctrines for all ${selectedUnitIds.size} selected units).`)) {
          idsToOpenDoctrineFor = [clickedUnitId];
        } else {
          idsToOpenDoctrineFor = Array.from(selectedUnitIds);
        }
      } else {
        // No multi-selection, or only one unit is selected (which is the clickedUnitId).
        // Act on the single unit associated with the clicked button's row.
        idsToOpenDoctrineFor = [clickedUnitId];
      }

      if (idsToOpenDoctrineFor.length > 0) {
        // The `idsToOpenDoctrineFor` array now contains the original unit.id strings.
        openUnitDoctrineWindow(idsToOpenDoctrineFor); // Pass the array of original unit IDs
      } else {
        // This case should ideally not be reached if clickedUnitId is always valid.
        alert("No units found to open doctrine for.");
      }
    }


    function handleModifyLoadoutClick(clickedUnitId) {
      let unitsForLoadoutAction = []; // Will store full unit objects

      // Determine which units to act upon based on selection
      if (selectedUnitIds.size > 0 && selectedUnitIds.has(clickedUnitId)) {
        selectedUnitIds.forEach(id => {
          const unit = unitMap.get(unitId);
          if (unit) unitsForLoadoutAction.push(unit);
        });
      } else if (selectedUnitIds.size > 0 && !selectedUnitIds.has(clickedUnitId)) {
        const clickedUnitObject = unitMap.get(clickedUnitId);
        const clickedUnitName = clickedUnitObject ? clickedUnitObject.name : "the clicked unit";
        if (confirm(`Modify loadout for ${clickedUnitName} only? \n(Press Cancel to attempt for all ${selectedUnitIds.size} selected units).`)) {
          if (clickedUnitObject) unitsForLoadoutAction.push(clickedUnitObject);
        } else {
          selectedUnitIds.forEach(id => {
            const unit = unitMap.get(id);
            if (unit) unitsForLoadoutAction.push(unit);
          });
        }
      } else {
        const unit = unitMap.get(clickedUnitId);
        if (unit) unitsForLoadoutAction.push(unit);
      }

      if (unitsForLoadoutAction.length === 0) {
        alert("No units selected or found for loadout modification.");
        return;
      }

      // --- Validation (applies to all units in unitsForLoadoutAction) ---
      const firstUnit = unitsForLoadoutAction[0];
      const firstUnitBase = firstUnit.base;
      const firstUnitDbid = firstUnit.dbid; // Get dbid of the first unit for comparison

      let allAreAircraft = true;
      let allParkedAndEligible = true;
      let allSameBase = true;
      let allSameDbid = true; // NEW check

      for (const unit of unitsForLoadoutAction) {
        if (unit.unitType !== 'Aircraft') {
          allAreAircraft = false;
          break;
        }
        const roleId = parseInt(unit.loadout_role, 10);
        if (!(unit.condition && unit.condition.toLowerCase().startsWith('parked') && roleId !== 9002)) {
          allParkedAndEligible = false;
          break;
        }
        if (unit.base !== firstUnitBase) {
          allSameBase = false;
          // No break, we'll alert based on this later if it's a batch for game engine
        }
        if (unit.dbid !== firstUnitDbid) { // NEW: Check if all units have the same dbid
          allSameDbid = false;
          // No break, for batch game engine call this will be a failure condition
        }
      }

      if (!allAreAircraft) {
        alert("Loadout modification is only applicable to Aircraft.");
        return;
      }
      if (!allParkedAndEligible) {
        alert("All selected aircraft must be parked and eligible (not 'Unavailable') for loadout modification.");
        return;
      }

      // --- Action based on count ---
      if (unitsForLoadoutAction.length === 1) {
        // Single Aircraft: Open Web UI modal for description + call game engine command
        const unit = unitsForLoadoutAction[0];


        // Call your game engine function for this single aircraft
        // Pass the original unit.id, as your openAircraftLoadout function expects this
        openAircraftLoadout(unit.id);

      } else { // Batch of >1 Aircraft
        console.debug(unitsForLoadoutAction)
        // For batch call to your game engine function, stricter rules apply:
        if (!allSameBase) {
          alert("To batch command loadout changes via game engine, all selected aircraft must be at the same base.");
          return;
        }
        if (!allSameDbid) { // NEW: If dbids are different for a batch game engine call
          alert("To batch command loadout changes via game engine, all selected aircraft must be of the exact same database ID).");
          return;
        }
        // --- If all validations pass, call the single entry point function ---
        // Pass an array of the original unit.id strings
        const unitIdsToProcess = unitsForLoadoutAction.map(u => u.id);
        openAircraftLoadout(unitIdsToProcess); // NEW: Pass array of original IDs
      }
    }

    function populateMissionFilters(missionsToConsiderInput) {
      const allMissionsArrayForFilters = getAllMissionsArray(missionData);
      const missionsForCurrentDropdownOptions = missionsToConsiderInput || allMissionsArrayForFilters;

      const taskPoolFilterEl = document.getElementById('mission-filter-taskpool');
      const mTypeFilterEl = document.getElementById('mission-filter-mtype');
      const mTagFilterEl = document.getElementById('mission-filter-mtag');
      const mSubtypeFilterEl = document.getElementById('mission-filter-msubtype');
      const mStatusFilterEl = document.getElementById('mission-filter-status');
      // Get current selections (IMPORTANT: do this BEFORE clearing/repopulating)
      const currentTaskPool = currentMissionFilters.taskPool || taskPoolFilterEl.value;
      const currentMType = currentMissionFilters.mType || mTypeFilterEl.value;
      const currentMTag = currentMissionFilters.mTag || mTagFilterEl.value;
      const currentMSubtype = currentMissionFilters.mSubtype || mSubtypeFilterEl.value;
      const currentMStatus = currentMissionFilters.status || mStatusFilterEl.value; // Get current status selection
      // Base options for each dropdown should come from ALL missions initially,
      // then get refined if other filters are active.

      // Task Pools are always from all missions
      const allTaskPools = [...new Set(allMissionsArrayForFilters.map(m => m.taskPool))].sort();
      taskPoolFilterEl.innerHTML = '<option value="">All Task Pools</option>' + allTaskPools.map(tp => `<option value="${tp}" ${currentTaskPool === tp ? 'selected' : ''}>${tp}</option>`).join('');

      // For MType, MTag, MSubtype, derive options based on what's *potentially visible*
      // after the *currently selected* preceding filters are applied.
      // --- Cascading Filters: MType, MTag, MSubtype, MStatus ---
      // The options available in subsequent dropdowns depend on selections in preceding ones.

      let sourceForNextFilter = allMissionsArrayForFilters;

      // Filter by Task Pool for MType options
      if (currentTaskPool) {
        sourceForNextFilter = sourceForNextFilter.filter(m => m.taskPool === currentTaskPool);
      }
      const mTypes = [...new Set(sourceForNextFilter.map(m => m.mType).filter(Boolean))].sort();
      mTypeFilterEl.innerHTML = '<option value="">All Types</option>' +
        mTypes.map(t => `<option value="${t}" ${currentMType === t ? 'selected' : ''}>${t}</option>`).join('');

      // Filter by MType for MTag options
      if (currentMType) {
        sourceForNextFilter = sourceForNextFilter.filter(m => m.mType === currentMType);
      }
      const mTags = [...new Set(sourceForNextFilter.map(m => m.mTag).filter(Boolean))].sort();
      mTagFilterEl.innerHTML = '<option value="">All Tags</option>' +
        mTags.map(t => `<option value="${t}" ${currentMTag === t ? 'selected' : ''}>${t}</option>`).join('');

      // Filter by MTag for MSubtype options
      if (currentMTag) {
        sourceForNextFilter = sourceForNextFilter.filter(m => m.mTag === currentMTag);
      }
      const mSubtypes = [...new Set(sourceForNextFilter.map(m => m.mSubType).filter(Boolean))].sort();
      mSubtypeFilterEl.innerHTML = '<option value="">All Subtypes</option>' +
        mSubtypes.map(t => `<option value="${t}" ${currentMSubtype === t ? 'selected' : ''}>${t}</option>`).join('');

      // --- NEW: Populate Mission Status Filter (using mission.calculatedStatus) ---
      // This filter's options should also be dependent on the selections made in previous filters.
      if (currentMSubtype) { // If a subtype is selected, further filter the source for status options
        sourceForNextFilter = sourceForNextFilter.filter(m => m.mSubType === currentMSubtype);
      }
      // Get unique statuses from the *currently relevant* set of missions
      const mStatuses = [...new Set(sourceForNextFilter.map(m => m.calculatedStatus).filter(Boolean))].sort();
      mStatusFilterEl.innerHTML = '<option value="">All Conditions</option>' +
        mStatuses.map(s => `<option value="${s}" ${currentMStatus === s ? 'selected' : ''}>${s}</option>`).join('');
    }


    function aggregateWeaponData() {
      const aggregatedWeapons = {};
      if (!Array.isArray(unitData) || unitData.length === 0) return [];

      const weaponBaseFilterSelect = document.getElementById('weapon-base-filter');
      const selectedLocationName = weaponBaseFilterSelect?.value;
      const selectedOption = weaponBaseFilterSelect?.options[weaponBaseFilterSelect.selectedIndex];
      const selectedLocationType = selectedOption?.dataset.locationType; // Relies on data-location-type from populateWeaponFilters

      let unitsForAggregation = JSON.parse(JSON.stringify(unitData)); // Start with a full copy
      let effectiveLocationNameForDisplay = "Various Locations";
      const isSpecificLocationSelected = selectedLocationName && selectedLocationType;

      if (isSpecificLocationSelected) {
        effectiveLocationNameForDisplay = selectedLocationName;
        let collectedUnits = [];

        if (selectedLocationType === 'AirBaseGroup') {
          // 1. Get core facilities OF this airbase group
          const coreFacilities = unitsForAggregation.filter(u => u.unitType === 'Facility' && (u.name === selectedLocationName || u.group === selectedLocationName));
          collectedUnits.push(...coreFacilities);
          const coreFacilityNames = coreFacilities.map(f => f.name);

          // 2. Get aircraft based AT this airbase (name) OR at any of its core facilities
          const aircraftAtAirBase = unitsForAggregation.filter(u =>
            u.unitType === 'Aircraft' &&
            (u.base === selectedLocationName || coreFacilityNames.includes(u.base))
          );
          collectedUnits.push(...aircraftAtAirBase);

        } else if (selectedLocationType === 'ShipGroup') {
          collectedUnits = unitsForAggregation.filter(u => u.group === selectedLocationName);
        } else if (selectedLocationType === 'StandaloneShip') {
          collectedUnits = unitsForAggregation.filter(u => u.name === selectedLocationName && u.unitType === 'Ship');
        } else if (selectedLocationType === 'StandaloneFacility') {
          collectedUnits = unitsForAggregation.filter(u => u.name === selectedLocationName && u.unitType === 'Facility');
          // Also include aircraft directly based at this standalone facility
          const aircraftAtThisFacility = unitsForAggregation.filter(u =>
            u.unitType === 'Aircraft' && u.base === selectedLocationName
          );
          collectedUnits.push(...aircraftAtThisFacility);
        } else { // Fallback if type is unknown, should not happen if populate is correct
          console.warn("Unknown location type for filter:", selectedLocationName, selectedLocationType);
          collectedUnits = unitsForAggregation.filter(u => u.name === selectedLocationName || u.base === selectedLocationName || u.group === selectedLocationName);
        }

        // Remove duplicates from collectedUnits
        const uniqueIds = new Set();
        unitsForAggregation = collectedUnits.filter(unit => {
          if (!uniqueIds.has(unit.id)) {
            uniqueIds.add(unit.id);
            return true;
          }
          return false;
        });

        // Pre-process ships within this selection to merge their hosted aircraft
        const tempProcessedUnits = [];
        const shipsInSelectionProcessed = new Set();
        unitsForAggregation.forEach(unitInFilterList => {
          if (unitInFilterList.unitType === 'Ship' && !shipsInSelectionProcessed.has(unitInFilterList.name)) {
            const shipCopy = JSON.parse(JSON.stringify(unitInFilterList));
            if (!shipCopy.weapons) shipCopy.weapons = {};

            // Iterate original FULL unitData to find aircraft hosted by THIS specific ship
            unitData.forEach(originalUnit => {
              if (originalUnit.unitType === 'Aircraft' && originalUnit.base === shipCopy.name) {
                const aircraftAllInventory = { ... (originalUnit.weapons || {}), ...(originalUnit.magazines || {}) };
                for (const itemName in aircraftAllInventory) {
                  if (aircraftAllInventory[itemName].qty > 0) {
                    shipCopy.weapons[itemName] = {
                      qty: (shipCopy.weapons[itemName]?.qty || 0) + aircraftAllInventory[itemName].qty
                    };
                  }
                }
              }
            });
            tempProcessedUnits.push(shipCopy);
            shipsInSelectionProcessed.add(shipCopy.name);
          } else if (unitInFilterList.unitType !== 'Ship') {
            tempProcessedUnits.push(unitInFilterList);
          }
        });
        unitsForAggregation = tempProcessedUnits;

      } else { // No specific location selected (Global View)
        const mergedAircraftIndices = new Set();
        unitsForAggregation.forEach((potentialHostUnit, hostIndex) => {
          if (potentialHostUnit.unitType === 'Ship') {
            potentialHostUnit.hostedUnitsForDisplay = [];
            unitsForAggregation.forEach((potentialHostedUnit, hostedIndex) => {
              if (hostIndex === hostedIndex || mergedAircraftIndices.has(hostedIndex)) return;
              if (potentialHostedUnit.unitType === 'Aircraft' && potentialHostedUnit.base === potentialHostUnit.name) {
                const aircraftAllInventory = { ... (potentialHostedUnit.weapons || {}), ...(potentialHostedUnit.magazines || {}) };
                if (!potentialHostUnit.weapons) potentialHostUnit.weapons = {};
                for (const itemName in aircraftAllInventory) {
                  if (aircraftAllInventory[itemName].qty > 0) {
                    potentialHostUnit.weapons[itemName] = {
                      qty: (potentialHostUnit.weapons[itemName]?.qty || 0) + aircraftAllInventory[itemName].qty
                    };
                  }
                }
                potentialHostUnit.hostedUnitsForDisplay.push(potentialHostedUnit.name);
                mergedAircraftIndices.add(hostedIndex);
              }
            });
          }
        });
        unitsForAggregation = unitsForAggregation.filter((_, index) => !mergedAircraftIndices.has(index));
      }

      // --- Actual Aggregation Step ---
      unitsForAggregation.forEach(unit => { // This 'unit' is from the (potentially filtered and ship-merged) list
        const unitAllInventory = { ... (unit.weapons || {}), ...(unit.magazines || {}) };
        Object.entries(unitAllInventory).forEach(([weaponName, weaponInstanceData]) => {
          if (weaponInstanceData.qty > 0) {
            if (!aggregatedWeapons[weaponName]) {
              const weaponDefinitionEntry = weaponData[weaponName];
              let details = weaponDefinitionEntry?.[0];
              aggregatedWeapons[weaponName] = {
                name: weaponName, category: details?.type || 'Unknown', targets: details?.targets || [], dbid: details?.dbid,
                rangeAir: details?.ranges?.air || { max: null, min: null }, rangeLand: details?.ranges?.land || { max: null, min: null },
                rangeSurface: details?.ranges?.surface || { max: null, min: null }, rangeSubsurface: details?.ranges?.subsurface || { max: null, min: null },
                quantity: 0, locations: []
              };
            }

            if (aggregatedWeapons[weaponName]) {
              aggregatedWeapons[weaponName].quantity += weaponInstanceData.qty;

              if (!isSpecificLocationSelected) {
                let baseName = unit.base || 'Mobile';
                if (unit.unitType === 'Ship' && unit.hostedUnitsForDisplay && unit.hostedUnitsForDisplay.length > 0) {
                  baseName = `${unit.name} Platform`;
                } else if (unit.group && unit.group.trim() !== "") {
                  const groupOption = document.querySelector(`#weapon-base-filter option[value="${unit.group}"]`);
                  if (groupOption && (groupOption.dataset.locationType === 'AirBaseGroup' || groupOption.dataset.locationType === 'ShipGroup')) {
                    baseName = unit.group;
                  } else if (unit.unitType === 'Facility' && unit.base && unit.base !== unit.group) {
                    baseName = unit.base;
                  } else {
                    baseName = unit.group;
                  }
                } else if (unit.unitType === 'Facility') {
                  baseName = unit.name;
                }
                if (!aggregatedWeapons[weaponName].locations.find(l => l.name === unit.name && l.base === baseName)) {
                  aggregatedWeapons[weaponName].locations.push({ name: unit.name, base: baseName, unitType: unit.unitType });
                }
              }
            }
          }
        });
      });

      if (isSpecificLocationSelected) {
        Object.values(aggregatedWeapons).forEach(aw => {
          aw.locations = [{ name: effectiveLocationNameForDisplay, base: effectiveLocationNameForDisplay, unitType: selectedLocationType || 'Selected Location' }];
        });
      }
      return Object.values(aggregatedWeapons);
    }

    function getEffectiveWeaponRange(weapon) {
      const SHORT_RANGE_MAX_NM = 15;
      const MEDIUM_RANGE_MAX_NM = 75;

      // Define the priority of domains: Air > Surface/Land > Subsurface
      const domainPriority = [
        { key: 'rangeAir', label: 'Air' },
        { key: 'rangeSurface', label: 'Surf' },
        { key: 'rangeLand', label: 'Land' },
        { key: 'rangeSubsurface', label: 'Sub' }
      ];

      let effectiveRangeText = 'N/A';
      let effectiveRangeClass = 'range-na';
      let tooltipContent = '';
      let maxRangeFound = -1;

      // Find the most relevant range to display based on priority and value
      for (const domain of domainPriority) {
        const range = weapon[domain.key];
        if (range && range.max > 0) {
          // We only set the main display text for the *first valid* range we find based on priority.
          if (maxRangeFound === -1) {
            maxRangeFound = range.max;

            // Special case: If surface and land ranges are identical, combine their labels.
            if (domain.key === 'rangeSurface' &&
              weapon.rangeLand?.max === range.max &&
              weapon.rangeLand?.min === range.min) {
              effectiveRangeText = `Surf/Land: ${range.max.toFixed(1)} NM`;
            } else {
              effectiveRangeText = `${domain.label}: ${range.max.toFixed(1)} NM`;
            }

            if (range.max <= SHORT_RANGE_MAX_NM) effectiveRangeClass = 'range-short';
            else if (range.max <= MEDIUM_RANGE_MAX_NM) effectiveRangeClass = 'range-medium';
            else effectiveRangeClass = 'range-long';
          }

          // Build the tooltip content, adding every valid range
          const rangeText = (range.min && range.min > 0)
            ? `${range.min.toFixed(1)} - ${range.max.toFixed(1)} NM`
            : `${range.max.toFixed(1)} NM`;

          tooltipContent += `<strong>${domain.label}:</strong> ${rangeText}<br>`;
        }
      }

      // If no tooltip content was generated, set a default message.
      if (tooltipContent === '') {
        tooltipContent = 'No effective range.';
      }

      return {
        text: effectiveRangeText,
        className: effectiveRangeClass,
        tooltip: tooltipContent.trim()
      };
    }
    function buildLocationTooltipHTML(locations) {
      if (!locations || locations.length === 0) {
        return 'No specific locations.';
      }

      const aircraftByBase = {};
      const platforms = [];

      // --- 1. Separate locations into Aircraft and Platforms ---
      locations.forEach(loc => {
        if (loc.unitType === 'Aircraft') {
          const baseName = loc.base || 'No Base';
          if (!aircraftByBase[baseName]) {
            aircraftByBase[baseName] = [];
          }
          // Avoid adding duplicate unit names for the same base
          if (!aircraftByBase[baseName].find(u => u.name === loc.name)) {
            aircraftByBase[baseName].push(loc);
          }
        } else { // It's a Ship, Facility, etc.
          // Avoid adding duplicate platforms
          if (!platforms.find(p => p.name === loc.name)) {
            platforms.push(loc);
          }
        }
      });

      let html = '';

      // --- 2. Render Platforms (Ships, Facilities) First ---
      if (platforms.length > 0) {
        // Sort platforms by name
        platforms.sort((a, b) => a.name.localeCompare(b.name));

        platforms.forEach(platform => {
          let iconClass = 'fa-building'; // Default facility
          if (platform.unitType === 'Ship') iconClass = 'fa-ship';

          html += `<div class="location-tooltip-group">`;
          html += `<div class="location-tooltip-item"><i class="fas ${iconClass}"></i> ${platform.name}</div>`;
          // For platforms, we don't need a sub-list. The header is the location.
          html += `</div>`;
        });
      }

      // --- 3. Render Aircraft grouped by their Airbase ---
      const sortedBases = Object.keys(aircraftByBase).sort();

      sortedBases.forEach(baseName => {
        const unitsAtBase = aircraftByBase[baseName];
        if (unitsAtBase.length > 0) {
          // The icon for a group of aircraft is a warehouse/hangar
          const iconClass = 'fa-warehouse';

          html += `<div class="location-tooltip-group">`;
          html += `<div class="location-tooltip-header"><i class="fas ${iconClass}"></i> Aircraft at ${baseName}</div>`;
          html += `<div class="location-tooltip-list">`;

          // Sort aircraft by name before displaying
          unitsAtBase.sort((a, b) => a.name.localeCompare(b.name)).forEach(unit => {
            html += `<span class="location-tooltip-item">${unit.name}</span>`;
          });

          html += `</div></div>`;
        }
      });

      return html || 'No specific locations.'; // Fallback just in case
    }
    function generateTargetIconsHTML(targets) {
      const weaponTargets = new Set(targets || []);
      if (weaponTargets.size === 0) {
        return '<span>N/A</span>';
      }

      const activeCapabilities = new Set();
      let iconsHTML = '';

      // Determine which high-level capabilities this weapon has
      for (const catKey in targetHierarchy) {
        for (const subType of targetHierarchy[catKey]) {
          if (weaponTargets.has(subType)) {
            activeCapabilities.add(catKey);
            break; // Move to the next category once one match is found
          }
        }
      }

      if (activeCapabilities.size === 0) {
        return '<span>N/A</span>';
      }

      // Generate the HTML for the icons
      activeCapabilities.forEach(capKey => {
        const iconData = CAPABILITY_ICONS[capKey];
        if (iconData) {
          if (iconData.startsWith('fas')) {
            iconsHTML += `<i class="${iconData}" title="${capKey}"></i>`;
          } else {
            // Wrap SVG in a span for the tooltip
            iconsHTML += `<span title="${capKey}">${iconData}</span>`;
          }
        }
      });

      return `<div class="target-icons-container">${iconsHTML}</div>`;
    }
    function renderWeaponsTable() {
      uiState.isWeaponsTableDirty = false;
      const aggregatedData = aggregateWeaponData();
      const tableBody = document.getElementById('weapons-table-body');

      // --- Filtering Logic (No changes needed here) ---
      const searchTerm = document.getElementById('weapon-search').value.toLowerCase();
      const categoryFilterVal = document.getElementById('weapon-type-filter').value;
      const targetsFilterVal = document.getElementById('weapon-targets-filter').value;

      let filteredWeaponsForDisplay = aggregatedData.filter(w => {
        const nameMatch = (searchTerm === '' || w.name.toLowerCase().includes(searchTerm));
        const categoryMatch = (categoryFilterVal === '' || w.category === categoryFilterVal);
        const targetMatch = (targetsFilterVal === '' || (Array.isArray(w.targets) && w.targets.includes(targetsFilterVal)));
        return nameMatch && categoryMatch && targetMatch;
      });

      // --- Sorting Logic (No changes needed here, just ensure it's correct) ---
      filteredWeaponsForDisplay.sort((a, b) => {
        let valA = a[currentWeaponSort.column];
        let valB = b[currentWeaponSort.column];

        if (currentWeaponSort.column === 'effectiveRange') {
          const getRangeValue = (weapon) => {
            const rangeData = getEffectiveWeaponRange(weapon);
            const match = rangeData.text.match(/(\d+\.\d+)\s*NM$/);
            return match ? parseFloat(match[1]) : -1;
          };
          valA = getRangeValue(a);
          valB = getRangeValue(b);
          return currentWeaponSort.order === 'asc' ? valA - valB : valB - valA;
        }
        if (currentWeaponSort.column === 'quantity') {
          return currentWeaponSort.order === 'asc' ? valA - valB : valB - valA;
        }
        // ... rest of your string/generic sort logic ...
        if (typeof valA === 'string') valA = valA.toLowerCase();
        if (typeof valB === 'string') valB = valB.toLowerCase();
        if (valA < valB) return currentWeaponSort.order === 'asc' ? -1 : 1;
        if (valA > valB) return currentWeaponSort.order === 'asc' ? 1 : -1;
        return 0;
      });

      // --- HTML Generation (This is the corrected part) ---
      if (filteredWeaponsForDisplay.length === 0) {
        const visibleCols = document.querySelectorAll('#weapons-table thead th').length;
        tableBody.innerHTML = `<tr><td colspan="${visibleCols}" class="no-data-message">No weapons found matching filters.</td></tr>`;
      } else {
        tableBody.innerHTML = filteredWeaponsForDisplay.map(w => {
          // Call all helper functions FIRST to get the data
          const effectiveRange = getEffectiveWeaponRange(w);
          const targetIconsHTML = generateTargetIconsHTML(w.targets); // Use new helper
          const locationTooltipHTML = buildLocationTooltipHTML(w.locations);

          const locationCount = w.locations?.length || 0;


          let locationsDisplayText = `${locationCount} Location(s)`;
          if (locationCount === 1) {
            locationsDisplayText = truncate(w.locations[0].name, 25);
          }

          // Escape the tooltip content for use in the data- attribute
          const escapedRangeTooltip = effectiveRange.tooltip.replace(/"/g, "'");
          const escapedLocationTooltip = locationTooltipHTML.replace(/"/g, "'");

          console.debug(escapedLocationTooltip);
          // Build the final, clean HTML string for the row
          return `
                <tr>
                    <td data-col-id="name">
                        <a href="#" class="weapon-name-link" data-weapon-dbid="${w.dbid}" data-weapon-name="${w.name}">${w.name}</a>
                    </td>
                    <td data-col-id="quantity">${w.quantity.toLocaleString()}</td>
                    <td data-col-id="category">${w.category}</td>
                    <td data-col-id="targets">${targetIconsHTML}</td>
                    <td data-col-id="effectiveRange" data-tooltip-content="${escapedRangeTooltip}">
                        <span class="${effectiveRange.className}">${effectiveRange.text}</span>
                    </td>
                    <td data-col-id="locations" data-tooltip-content="${escapedLocationTooltip}">
                        ${locationsDisplayText}
                    </td>
                </tr>
            `;
        }).join('');
      }
      tableBody.querySelectorAll('.weapon-name-link').forEach(link => {
        link.addEventListener('click', function (e) {
          openDatabaseEntry(this.dataset.weaponDbid, 'Weapon')
        });
      });
      const cellsWithTooltips = tableBody.querySelectorAll('[data-tooltip-content]');
      cellsWithTooltips.forEach(cell => {
        const content = cell.dataset.tooltipContent;
        if (content) {
          tippy(cell, {
            content: content,
            allowHTML: true,
            placement: 'top',
            arrow: true,
            theme: (cell.dataset.colId === 'locations') ? 'location-tooltip' : 'dark'
          });
        }
      });
      updateTableColumnVisibility('weapons-table', weaponsTableColumnVisibility);
      renderFilteredWeaponsSummary(filteredWeaponsForDisplay);
    }

    function populateWeaponFilters() {
      const weaponBaseFilterEl = document.getElementById('weapon-base-filter');
      const filterableLocations = new Map();

      // --- Pre-calculate effective inventories for all units (including hosted aircraft for ships) ---
      const unitEffectiveInventories = new Map(); // unit.id -> { totalItems: number }
      const tempUnitDataCopy = JSON.parse(JSON.stringify(unitData)); // To modify for ship hosting

      // Merge hosted aircraft into ships FOR INVENTORY CHECK ONLY
      const aircraftProcessedForInventoryCheck = new Set();
      tempUnitDataCopy.forEach(hostUnit => {
        if (hostUnit.unitType === 'Ship') {
          let currentHostInventoryCount = Object.values({ ...(hostUnit.weapons || {}), ...(hostUnit.magazines || {}) })
            .reduce((sum, item) => sum + (item.qty || 0), 0);

          tempUnitDataCopy.forEach((acUnit, acIndex) => {
            if (acUnit.unitType === 'Aircraft' && acUnit.base === hostUnit.name && !aircraftProcessedForInventoryCheck.has(acUnit.id)) {
              currentHostInventoryCount += Object.values({ ...(acUnit.weapons || {}), ...(acUnit.magazines || {}) })
                .reduce((sum, item) => sum + (item.qty || 0), 0);
              aircraftProcessedForInventoryCheck.add(acUnit.id); // Mark as processed for this ship
            }
          });
          unitEffectiveInventories.set(hostUnit.id, { totalItems: currentHostInventoryCount });
        } else { // For non-ships, just their own inventory
          unitEffectiveInventories.set(hostUnit.id, {
            totalItems: Object.values({ ...(hostUnit.weapons || {}), ...(hostUnit.magazines || {}) })
              .reduce((sum, item) => sum + (item.qty || 0), 0)
          });
        }
      });
      // Aircraft not hosted by ships also need their inventory count
      tempUnitDataCopy.forEach(unit => {
        if (unit.unitType === 'Aircraft' && !aircraftProcessedForInventoryCheck.has(unit.id) && !unitEffectiveInventories.has(unit.id)) {
          unitEffectiveInventories.set(unit.id, {
            totalItems: Object.values({ ...(unit.weapons || {}), ...(unit.magazines || {}) })
              .reduce((sum, item) => sum + (item.qty || 0), 0)
          });
        }
      });


      // --- Now, build filterableLocations based on entities that WILL have weapons ---

      Object.values(airbaseData).forEach(airbase => { // 'airbase' is now an object like {lon, lat, id, name}
        const airbaseNameForComparison = airbase.name; // Use the actual name
        let airbaseHasWeapons = false;

        // Check facilities that are *named* this airbase or *grouped* under this airbase name
        const facilitiesAtOrGroupedUnderAirbase = unitData.filter(u =>
          u.unitType === 'Facility' && (u.name === airbaseNameForComparison || u.group === airbaseNameForComparison)
        );
        if (facilitiesAtOrGroupedUnderAirbase.some(f => unitEffectiveInventories.get(f.id)?.totalItems > 0)) {
          airbaseHasWeapons = true;
        }

        // Check aircraft based at this airbase (using airbaseNameForComparison)
        if (!airbaseHasWeapons) {
          const aircraftAtThisAirbase = unitData.filter(u =>
            u.unitType === 'Aircraft' && u.base === airbaseNameForComparison && unitEffectiveInventories.get(u.id)?.totalItems > 0
          );
          if (aircraftAtThisAirbase.length > 0) {
            airbaseHasWeapons = true;
          }
        }

        if (airbaseHasWeapons) {
          // Use airbase.name for the value and display
          filterableLocations.set(airbaseNameForComparison, { value: airbaseNameForComparison, type: 'AirBase' });
        }
      });


      // 2. Ship Groups & Standalone Ships
      const shipGroupsFound = new Map();
      const standaloneShips = new Map();
      unitData.forEach(unit => {
        if (unit.unitType === 'Ship') {
          const shipEffectiveItemCount = unitEffectiveInventories.get(unit.id)?.totalItems || 0;
          if (shipEffectiveItemCount === 0) return;

          if (unit.group && unit.group.trim() !== "" && unit.group.toLowerCase().includes("desron")) { // Or other ship group keywords
            if (!filterableLocations.has(unit.group)) { // Avoid overwriting if group was already identified as AirBase (unlikely)
              let groupData = shipGroupsFound.get(unit.group) || { totalWeaponCount: 0 };
              groupData.totalWeaponCount += shipEffectiveItemCount;
              shipGroupsFound.set(unit.group, groupData);
            }
          } else {
            if (!filterableLocations.has(unit.name)) { // Avoid overwriting if ship name was an AirBase (unlikely)
              standaloneShips.set(unit.name, { totalWeaponCount: shipEffectiveItemCount });
            }
          }
        }
      });
      shipGroupsFound.forEach((data, groupName) => {
        if (data.totalWeaponCount > 0) {
          filterableLocations.set(groupName, { value: groupName, type: 'ShipGroup' });
        }
      });
      standaloneShips.forEach((data, shipName) => {
        // Ensure it's not already added (e.g. as part of an AirBase if names overlap, though unlikely)
        if (!filterableLocations.has(shipName) && data.totalWeaponCount > 0) {
          filterableLocations.set(shipName, { value: shipName, type: 'StandaloneShip' });
        }
      });

      // 3. Standalone Land Facilities (that are NOT Airbases and have weapons)
      unitData.forEach(unit => {
        if (unit.unitType === 'Facility' && unit.name) {
          // Skip if it's an AirBase (already handled) or part of one, or already in filterableLocations
          if (airbaseData[unit.name] || (unit.group && airbaseData[unit.group]) || filterableLocations.has(unit.name)) {
            return;
          }

          let facilityEffectiveItemCount = unitEffectiveInventories.get(unit.id)?.totalItems || 0;
          unitData.forEach(au => { // Add weapons from aircraft based directly at this standalone facility
            if (au.unitType === 'Aircraft' && au.base === unit.name) {
              facilityEffectiveItemCount += (unitEffectiveInventories.get(au.id)?.totalItems || 0);
            }
          });

          if (facilityEffectiveItemCount > 0) {
            // You can add more specific classname checks if needed to further categorize these
            filterableLocations.set(unit.name, { value: unit.name, type: 'LandFacility' }); // Generic type for non-airbase land facilities
          }
        }
      });
      // --- End of location identification logic ---


      // --- Filter locations based on the weaponBaseDropdownPopulationType values ---
      let locationsToDisplayInDropdown = Array.from(filterableLocations.values())
        .filter(loc => loc.value && loc.value.trim() !== "");

      console.debug("populateWeaponFilters: All identified filterableLocations:", locationsToDisplayInDropdown.map(l => `${l.value} (Type: ${l.type})`));
      console.debug("populateWeaponFilters: Current weaponBaseDropdownPopulationType:", weaponBaseDropdownPopulationType);

      switch (weaponBaseDropdownPopulationType) {
        case 'airbase':
          locationsToDisplayInDropdown = locationsToDisplayInDropdown.filter(loc =>
            loc.type === 'AirBase' // Match the type we set using airbaseData
          );
          break;
        case 'facility':
          locationsToDisplayInDropdown = locationsToDisplayInDropdown.filter(loc =>
            loc.type === 'LandFacility' // Match the type for standalone land facilities
          );
          break;
        case 'sea':
          locationsToDisplayInDropdown = locationsToDisplayInDropdown.filter(loc =>
            loc.type === 'ShipGroup' || loc.type === 'StandaloneShip'
          );
          break;
        case 'all':
        default:
          // No additional type-based filtering
          break;
      }

      const sortedLocations = locationsToDisplayInDropdown.sort((a, b) => a.value.localeCompare(b.value));

      const currentSelectedBase = weaponBaseFilterEl.value;
      weaponBaseFilterEl.innerHTML = '<option value="">All Locations</option>';

      sortedLocations.forEach(loc => {
        const option = document.createElement('option');
        option.value = loc.value;
        option.textContent = loc.value;
        option.dataset.locationType = loc.type;
        if (loc.value === currentSelectedBase) {
          option.selected = true;
        }
        weaponBaseFilterEl.appendChild(option);
      });

      // --- Targets and Category filters (no change needed here) ---
      const categories = [...new Set(Object.values(weaponData).map(wArray => wArray[0]?.type || 'Unknown'))].sort();
      const typeFilterEl = document.getElementById('weapon-type-filter');
      typeFilterEl.innerHTML = '<option value="">All Categories</option>' + categories.map(c => `<option value="${c}">${c}</option>`).join('');

      const allTargets = new Set();
      Object.values(weaponData).forEach(wArray => {
        if (wArray[0] && Array.isArray(wArray[0].targets)) {
          wArray[0].targets.forEach(target => allTargets.add(target));
        }
      });
      const sortedTargets = Array.from(allTargets).sort();
      const targetsFilterEl = document.getElementById('weapon-targets-filter');
      targetsFilterEl.innerHTML = '<option value="">All Targets</option>' + sortedTargets.map(t => `<option value="${t}">${t}</option>`).join('');
    }

    function initializeWeaponMap() {
      function getAirbaseDetailsByName(name) {
        return Object.values(airbaseData).find(ab => ab.name === name);
      }
      if (weaponMap) {
        weaponMap.remove();
        weaponMap = null;
      }
      const mapElement = document.getElementById('weaponMap');
      if (!mapElement || !mapElement.offsetParent) { // Check if element is visible
        console.debug("Weapon map element not visible or not found, skipping map initialization.");
        return;
      }

      weaponMap = L.map('weaponMap').setView([15, 120], 5); // Centered more on SE Asia example
      L.tileLayer('https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png', {
        attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors © <a href="https://carto.com/attributions">CARTO</a>'
      }).addTo(weaponMap);

      const finalMapEntities = new Map();
      // Key: Entity Name (Airbase name, Ship group name, Standalone unit name)
      // Value: { lat, lon, totalItems, inventory: {}, constituentUnitNames: Set, entityType: string, originalUnits: [] }

      const unitDataCopy = JSON.parse(JSON.stringify(unitData)); // Work on a copy

      // Pre-process: Aggregate aircraft weapons onto their host platforms (Airbases or Ships)
      // and mark aircraft as processed to avoid double-counting or individual plotting.
      const processedAircraftIds = new Set();

      unitDataCopy.forEach(unit => {
        if (isNaN(parseFloat(unit.lat)) || isNaN(parseFloat(unit.lon))) return; // Skip units without valid coords

        let entityKey = null;
        let entityLat = parseFloat(unit.lat);
        let entityLon = parseFloat(unit.lon);
        let entityType = null; // Will be determined
        const unitAirbaseDetails = getAirbaseDetailsByName(unit.name);
        const groupAirbaseDetails = unit.group ? getAirbaseDetailsByName(unit.group) : null;


        // 1. Identify Airbases directly from airbaseData
        if (unit.unitType === 'Facility' && unitAirbaseDetails) {
          entityKey = unit.name;
          entityType = 'AirBase';
          entityLat = parseFloat(unitAirbaseDetails.lat); // Use definitive coords from airbaseData
          entityLon = parseFloat(unitAirbaseDetails.lon);
        }
        // Also check if a facility unit's GROUP is an airbase name (for sub-facilities of an AB)
        else if (unit.unitType === 'Facility' && groupAirbaseDetails) {
          entityKey = unit.group; // Aggregate to the main airbase
          entityType = 'AirBase';
          entityLat = parseFloat(groupAirbaseDetails.lat);
          entityLon = parseFloat(groupAirbaseDetails.lon);
        }
        // 2. Identify Ship Groups (e.g., DESRONs)
        else if (unit.unitType === 'Ship' && unit.group && unit.group.toLowerCase().includes("desron")) { // Add other keywords for ship groups
          entityKey = unit.group;
          entityType = 'ShipGroup';
          // For ShipGroups, we'll use the coordinates of the first ship encountered for that group,
          // or average them if desired (more complex).
          if (finalMapEntities.has(entityKey)) {
            entityLat = finalMapEntities.get(entityKey).lat;
            entityLon = finalMapEntities.get(entityKey).lon;
          }
        }
        // 3. Standalone Ships
        else if (unit.unitType === 'Ship') {
          entityKey = unit.name;
          entityType = 'ShipStandalone';
        }
        // 4. Standalone Land Facilities (not part of an identified airbase)
        else if (unit.unitType === 'Facility' && !airbaseData[unit.name] && (!unit.group || !airbaseData[unit.group])) {
          entityKey = unit.name;
          entityType = 'LandFacility';
        }
        // 5. Aircraft - their weapons will be added to their host (AirBase or Ship)
        else if (unit.unitType === 'Aircraft') {
          if (processedAircraftIds.has(unit.id)) return; // Already handled

          let hostEntityKey = null;
          let hostEntityType = null;
          let hostLat, hostLon;

          if (unit.base) {
            const hostAirbase = getAirbaseDetailsByName(unit.base);
            if (hostAirbase) { // Based at a known AirBase
              hostEntityKey = unit.base;
              hostEntityType = 'AirBase';
              hostLat = parseFloat(hostAirbase.lat);
              hostLon = parseFloat(hostAirbase.lon);
            } else { // Based at another facility or ship
              const hostUnit = unitDataCopy.find(u => u.name === unit.base && (u.unitType === 'Facility' || u.unitType === 'Ship'));
              if (hostUnit) {
                const hostUnitAsAirbase = getAirbaseDetailsByName(hostUnit.name); // Check if host facility IS an airbase
                const hostUnitGroupAsAirbase = hostUnit.group ? getAirbaseDetailsByName(hostUnit.group) : null;

                if (hostUnitAsAirbase) { // Hosted by a facility that is an airbase
                  hostEntityKey = hostUnit.name;
                  hostEntityType = 'AirBase';
                  hostLat = parseFloat(hostUnitAsAirbase.lat);
                  hostLon = parseFloat(hostUnitAsAirbase.lon);
                } else if (hostUnitGroupAsAirbase) { // Hosted by a facility whose GROUP is an airbase
                  hostEntityKey = hostUnit.group;
                  hostEntityType = 'AirBase';
                  hostLat = parseFloat(hostUnitGroupAsAirbase.lat);
                  hostLon = parseFloat(hostUnitGroupAsAirbase.lon);
                } else if (hostUnit.unitType === 'Ship') {
                  // Your existing ship logic
                  hostEntityKey = hostUnit.group && hostUnit.group.toLowerCase().includes("desron") ? hostUnit.group : hostUnit.name;
                  hostEntityType = hostUnit.group && hostUnit.group.toLowerCase().includes("desron") ? 'ShipGroup' : 'ShipStandalone';
                  hostLat = parseFloat(hostUnit.lat);
                  hostLon = parseFloat(hostUnit.lon);
                } else { // Hosted by a standalone facility (not an airbase itself)
                  hostEntityKey = hostUnit.name;
                  hostEntityType = 'LandFacility'; // Default to LandFacility if not an AirBase
                  hostLat = parseFloat(hostUnit.lat);
                  hostLon = parseFloat(hostUnit.lon);
                }
              }
            }
          }

          if (hostEntityKey) {
            if (!finalMapEntities.has(hostEntityKey)) {
              if (isNaN(hostLat) || isNaN(hostLon)) { // If host coords are bad, skip
                console.warn(`Aircraft ${unit.name} host ${hostEntityKey} has invalid coords.`);
                processedAircraftIds.add(unit.id);
                return;
              }
              finalMapEntities.set(hostEntityKey, {
                lat: hostLat, lon: hostLon, totalItems: 0, inventory: {},
                constituentUnitNames: new Set(), entityType: hostEntityType, originalUnits: []
              });
            }
            const hostMapEntity = finalMapEntities.get(hostEntityKey);
            hostMapEntity.constituentUnitNames.add(unit.name + " (AC)"); // Mark as aircraft
            hostMapEntity.originalUnits.push(unit);
            const acInventory = { ...(unit.weapons || {}), ...(unit.magazines || {}) };
            Object.entries(acInventory).forEach(([itemName, data]) => {
              if (data.qty > 0) {
                hostMapEntity.inventory[itemName] = (hostMapEntity.inventory[itemName] || 0) + data.qty;
                hostMapEntity.totalItems += data.qty;
              }
            });
            processedAircraftIds.add(unit.id);
          }
          return; // Aircraft processed, don't create a separate entity for it
        } else {
          return; // Skip other unit types or those that couldn't be classified
        }


        if (!entityKey) return;

        // Initialize entity in map if not an aircraft and not already present
        if (!finalMapEntities.has(entityKey)) {
          finalMapEntities.set(entityKey, {
            lat: entityLat, lon: entityLon, totalItems: 0, inventory: {},
            constituentUnitNames: new Set(), entityType: entityType, originalUnits: []
          });
        }

        // Add current unit's direct inventory (if not an aircraft, as those are handled above)
        const mapEntity = finalMapEntities.get(entityKey);
        mapEntity.constituentUnitNames.add(unit.name);
        mapEntity.originalUnits.push(unit);
        const unitCombinedInventory = { ...(unit.weapons || {}), ...(unit.magazines || {}) };
        Object.entries(unitCombinedInventory).forEach(([itemName, data]) => {
          if (data.qty > 0) {
            mapEntity.inventory[itemName] = (mapEntity.inventory[itemName] || 0) + data.qty;
            mapEntity.totalItems += data.qty;
          }
        });
      });

      // --- Create Markers (Prioritizing CircleMarkers for quantity indication) ---
      const markersLayerGroup = L.layerGroup().addTo(weaponMap);
      const markerBounds = [];

      finalMapEntities.forEach((entity, key) => {
        if (entity.totalItems > 0 && !isNaN(entity.lat) && !isNaN(entity.lon)) {
          markerBounds.push([entity.lat, entity.lon]);

          let fillColor = "#AAAAAA"; // Default Grey
          let borderColor = getComputedStyle(document.documentElement).getPropertyValue('--text-color').trim() || '#FFFFFF';
          let radius = Math.max(6, Math.log2(entity.totalItems + 1) * 2.5 + 4); // Base radius, min 6

          switch (entity.entityType) {
            case 'AirBase':
              fillColor = "#a33ea4"; // Purple
              radius += 4; // Airbases largest
              break;
            case 'ShipGroup':
              fillColor = "#3b7ddd"; // Darker Blue
              radius += 2;
              break;
            case 'ShipStandalone':
              fillColor = "#5496f3"; // Lighter Blue
              break;
            case 'LandFacility':
              fillColor = "#34a853"; // Green
              // Could also vary LandFacility color based on sub-type if desired (SAM, Radar etc.)
              break;
            // No default needed as fillColor is already set
          }

          const circleMarkerOptions = {
            radius: radius,
            fillColor: fillColor,
            color: borderColor, // Border color
            weight: 1.5,          // Border width
            opacity: 1,
            fillOpacity: 0.75
          };

          const marker = L.circleMarker([entity.lat, entity.lon], circleMarkerOptions);
          marker.addTo(markersLayerGroup);


          let popupContent = `<strong class="popup-title">${key}</strong> <span class="badge bg-secondary popup-type">${entity.entityType}</span><br>`;
          popupContent += `Total Weapon Items: <strong class="popup-total">${entity.totalItems.toLocaleString()}</strong><br>`;
          //popupContent += `<small class="popup-units">Contributing Units (${entity.constituentUnitNames.size}): ${Array.from(entity.constituentUnitNames).slice(0,3).join(', ')}${entity.constituentUnitNames.size > 3 ? '...' : ''}</small>`;

          const topInventory = Object.entries(entity.inventory)
            .sort(([, countA], [, countB]) => countB - countA)
            .slice(0, 10);

          if (topInventory.length > 0) {
            popupContent += `<hr class="popup-hr">Inventory (Top ${topInventory.length}):<ul class="popup-inventory-list">`;
            topInventory.forEach(([name, qty]) => {
              if (qty > 0) popupContent += `<li><small>${truncate(name, 25)}: <strong>${qty.toLocaleString()}</strong></small></li>`;
            });
            if (Object.keys(entity.inventory).length > topInventory.length) {
              popupContent += `<li><small>...and ${Object.keys(entity.inventory).length - topInventory.length} more types.</small></li>`;
            }
            popupContent += `</ul>`;
          }
          marker.bindPopup(popupContent);
          marker.bindTooltip(`${key} (${entity.entityType})<br>${entity.totalItems.toLocaleString()} items`);
        }
      });

      if (markerBounds.length > 0) {
        try {
          weaponMap.fitBounds(markerBounds, { padding: [50, 50], maxZoom: 14 });
        } catch (e) {
          console.error("Error fitting map bounds:", e, markerBounds);
        }
      }

      // Placeholder for custom controls
      addWeaponMapCustomControls();
      // Example: weaponMap.invalidateSize(); // if map was hidden and now shown.
    }

    function addWeaponMapCustomControls() {
      // Example: Adding a simple legend
      if (document.getElementById('weapon-map-legend')) return; // Avoid adding multiple times

      const legend = L.control({ position: 'bottomright' });
      legend.onAdd = function (map) {
        const div = L.DomUtil.create('div', 'info legend weapon-map-legend-control'); // Add a specific class
        div.id = 'weapon-map-legend';
        const types = {
          'AirBase': '#a33ea4',
          'Ship Entity': '#3b7ddd', // Combined ship groups and standalone
          'Land Facility': '#34a853',
          'Other': '#AAAAAA'
        };
        div.innerHTML += '<strong>Legend</strong><br>';
        for (let key in types) {
          div.innerHTML += `<i style="background:${types[key]}; width:18px; height:18px; float:left; margin-right:8px; opacity:0.7;"></i> ${key}<br>`;
        }
        return div;
      };
      if (weaponMap) { // Ensure weaponMap is initialized before adding control
        legend.addTo(weaponMap);
      }
    }

    function setupColumnToggler(tableId, columnVisibilityState, togglerMenuId) {
      const table = document.getElementById(tableId);
      if (!table) return;

      const headers = table.querySelectorAll('thead th[data-col-id]');
      const mainMenu = document.getElementById(togglerMenuId);
      if (!mainMenu) return;

      mainMenu.innerHTML = '';
      if (tableId === 'units-table') {
        // Set defaults if not already defined in columnVisibilityState
        if (columnVisibilityState['id'] === undefined) {
          columnVisibilityState['id'] = false; // Unit ID hidden by default
        }
        if (columnVisibilityState['name'] === undefined) {
          columnVisibilityState['name'] = true;  // Unit Name visible by default
        }
        if (columnVisibilityState['unitType'] === undefined) {
          columnVisibilityState['unitType'] = false; // Unit Type hidden by default
        }
        if (columnVisibilityState['unitSubtype'] === undefined) {
          columnVisibilityState['unitSubtype'] = false; // Unit Subtype hidden by default
        }
        // Add any other columns you want hidden by default for 'units-table' here
        // e.g., if (columnVisibilityState['base'] === undefined) columnVisibilityState['base'] = false;
      }
      // --- Helper to close other open submenus in this main menu ---
      const closeOtherSubmenus = (currentSubmenuLi) => {
        mainMenu.querySelectorAll('.dropdown-submenu.show').forEach(openSubmenu => {
          if (openSubmenu !== currentSubmenuLi) {
            openSubmenu.classList.remove('show');
          }
        });
      };

      // --- 1. "Show/Hide Columns" Submenu ---
      const columnsLi = document.createElement('li');
      columnsLi.className = 'dropdown-submenu'; // Key class for CSS and JS
      const columnsSubmenuTriggerId = `${tableId}-columns-submenu-trigger`;
      columnsLi.innerHTML = `
        <a class="dropdown-item" href="#" id="${columnsSubmenuTriggerId}" tabindex="-1">
           <i class="fas fa-table-columns me-2"></i>Show/Hide Columns
           <!-- Arrow will be added by CSS ::after -->
        </a>
        <ul class="dropdown-menu column-toggler-submenu">
            <!-- Checkboxes populated here -->
        </ul>
    `;
      mainMenu.appendChild(columnsLi);
      const columnsSubmenuUl = columnsLi.querySelector('.column-toggler-submenu');
      const columnsSubmenuTriggerA = document.getElementById(columnsSubmenuTriggerId);

      columnsSubmenuTriggerA.addEventListener('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        closeOtherSubmenus(columnsLi);
        columnsLi.classList.toggle('show');
      });

      // Populate column toggles
      if (tableId === 'units-table') { /* ... special defaults ... */ }
      headers.forEach((th) => {
        const colId = th.dataset.colId;
        const colName = th.dataset.colName || colId;
        if (columnVisibilityState[colId] === undefined) columnVisibilityState[colId] = true;
        let isDisabled = false;
        if (tableId === 'units-table' && colId === 'name') {
          columnVisibilityState[colId] = true; isDisabled = true;
        }

        const listItem = document.createElement('li');
        // Wrap form elements in a non-<a> dropdown-item or a div that stops propagation
        listItem.innerHTML = `
            <div class="dropdown-item-form-wrapper ${isDisabled ? 'disabled' : ''}">
              <div class="form-check" style="padding-left: 1.5rem;"> <!-- Indent for submenu feel -->
                <input type="checkbox" class="form-check-input" id="${tableId}-col-toggle-${colId}"
                       data-col-id="${colId}" ${columnVisibilityState[colId] ? 'checked' : ''} ${isDisabled ? 'disabled' : ''}>
                <label class="form-check-label" for="${tableId}-col-toggle-${colId}">
                  ${colName}
                </label>
              </div>
            </div>
        `;

        if (!isDisabled) {
          const checkbox = listItem.querySelector('input');
          // Event listener on the wrapper div
          listItem.querySelector('.dropdown-item-form-wrapper').addEventListener('click', (e) => {
            e.stopPropagation(); // Prevent closing submenu
            if (e.target !== checkbox) { // If click wasn't directly on checkbox, toggle it
              checkbox.checked = !checkbox.checked;
            }
            // Trigger change event manually AFTER updating checked state
            columnVisibilityState[colId] = checkbox.checked;
            updateTableColumnVisibility(tableId, columnVisibilityState);
          });
        }
        columnsSubmenuUl.appendChild(listItem);
      });


      if (tableId === 'units-table' || tableId === 'weapons-table') {
        const dividerLi = document.createElement('li');
        dividerLi.innerHTML = '<hr class="dropdown-divider">';
        mainMenu.appendChild(dividerLi);

        const filterOptionsLi = document.createElement('li');
        filterOptionsLi.className = 'dropdown-submenu';
        const filterOptionsTriggerId = `${tableId}-filteroptions-submenu-trigger`;
        filterOptionsLi.innerHTML = `
            <a class="dropdown-item" href="#" id="${filterOptionsTriggerId}" tabindex="-1">
               <i class="fas fa-filter-circle-dollar me-2"></i>Base/Location Type
            </a>
            <ul class="dropdown-menu filter-options-submenu"></ul>
        `;
        mainMenu.appendChild(filterOptionsLi);
        const filterOptionsSubmenuUl = filterOptionsLi.querySelector('.filter-options-submenu');
        const filterOptionsSubmenuTriggerA = document.getElementById(filterOptionsTriggerId);

        filterOptionsSubmenuTriggerA.addEventListener('click', function (e) { /* ... as before ... */
          e.preventDefault(); e.stopPropagation();
          closeOtherSubmenus(filterOptionsLi);
          filterOptionsLi.classList.toggle('show');
        });

        // --- Populate "Base/Location Type" filter options ---
        const baseFilterTypeItemLi = document.createElement('li');
        let currentBaseFilterTypeValue; // To store the current value for this table

        if (tableId === 'units-table') {
          currentBaseFilterTypeValue = unitBaseDropdownPopulationType; // Use the global state for units
          baseFilterTypeItemLi.innerHTML = `
                <div class="dropdown-item-form-wrapper">
                  <div style="padding-left: 1.5rem;">
                    <span class="text-muted-color small d-block mb-1">Unit Base Type:</span>
                    <div id="${tableId}-base-filter-type-options">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseAll" value="all" ${currentBaseFilterTypeValue === 'all' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseAll">All</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseLand" value="land" ${currentBaseFilterTypeValue === 'land' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseLand">Land</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseSea" value="sea" ${currentBaseFilterTypeValue === 'sea' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseSea">Sea</label>
                        </div>
                    </div>
                  </div>
                </div>
            `;
        } else if (tableId === 'weapons-table') {
          currentBaseFilterTypeValue = weaponBaseDropdownPopulationType; // Use the global state for weapons
          // For weapons, the options might be different (e.g., "Aggregated Locations", "Individual Platforms")
          // For now, let's use similar "All", "Land Stockpiles", "Sea Stockpiles" for consistency,
          // but the actual filtering in populateWeaponFilters will be more complex.
          baseFilterTypeItemLi.innerHTML = `
                <div class="dropdown-item-form-wrapper">
                  <div style="padding-left: 1.5rem;">
                    <span class="text-muted-color small d-block mb-1">Weapon Location Type:</span>
                    <div id="${tableId}-base-filter-type-options">
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseAll" value="all" ${currentBaseFilterTypeValue === 'all' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseAll">All</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseAirbase" value="airbase" ${currentBaseFilterTypeValue === 'airbase' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseAirbase">AirBase</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseFacility" value="facility" ${currentBaseFilterTypeValue === 'facility' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseFacility">Facility</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="${tableId}BasePopType" id="${tableId}BaseSea" value="sea" ${currentBaseFilterTypeValue === 'sea' ? 'checked' : ''}>
                            <label class="form-check-label small" for="${tableId}BaseSea">Sea</label>
                        </div>
                    </div>
                  </div>
                </div>
            `;
        }
        filterOptionsSubmenuUl.appendChild(baseFilterTypeItemLi);

        // Listeners for radio buttons
        baseFilterTypeItemLi.querySelector('.dropdown-item-form-wrapper').addEventListener('click', e => e.stopPropagation()); // Stop clicks on wrapper

        document.getElementsByName(`${tableId}BasePopType`).forEach(radio => {
          radio.addEventListener('change', function () {
            // Call a generic handler or specific ones
            handleBaseFilterTypeChange(tableId, this.value);
          });
          // Radio buttons are correctly checked based on currentBaseFilterTypeValue when HTML is built
        });
      }

      // Click outside to close submenus
      document.addEventListener('click', function (event) {
        if (!mainMenu.contains(event.target)) { // If click is outside the main dropdown menu
          mainMenu.querySelectorAll('.dropdown-submenu.show').forEach(openSubmenu => {
            openSubmenu.classList.remove('show');
          });
        } else {
          // If click is inside main menu but not on a submenu trigger or inside an open submenu content area
          if (!event.target.closest('.dropdown-submenu > a') && !event.target.closest('.dropdown-submenu > .dropdown-menu')) {
            mainMenu.querySelectorAll('.dropdown-submenu.show').forEach(openSubmenu => {
              // This part can be tricky; you might only want to close if the click
              // wasn't expanding another submenu within the same parent.
              // For now, a simpler "close all if click isn't in an active submenu" might be okay.
            });
          }
        }
      }, true); // Use capture phase for reliable outside click detection

      updateTableColumnVisibility(tableId, columnVisibilityState);
    }
    // New handler function for base filter type changes
    function handleBaseFilterTypeChange(tableId, selectedType) {
      console.debug(`Table: ${tableId}, Base Filter Type Changed To: ${selectedType}`);
      // 1. Store this preference (e.g., in currentUnitFilters, currentWeaponFilters)
      //    Example for units:
      if (tableId === 'units-table') {
        unitBaseDropdownPopulationType = selectedType;
        populateUnitFilters();
      } else if (tableId === 'weapons-table') {
        weaponBaseDropdownPopulationType = selectedType;
        populateWeaponFilters();
      } else {
        missionBaseDropdownPopulationType = selectedType;
        populateMissionFilters();
      }

      // 3. Re-render the table.
    }
    function updateTableColumnVisibility(tableId, columnVisibilityState) {
      const table = document.getElementById(tableId);
      if (!table) return;

      const headerCells = table.querySelectorAll('thead th[data-col-id]');
      const bodyRows = table.querySelectorAll('tbody tr');

      headerCells.forEach(th => {
        const colId = th.dataset.colId;
        // Ensure state exists, default to true if not explicitly set (except for special cases handled in setup)
        if (columnVisibilityState[colId] === undefined) columnVisibilityState[colId] = true;
        th.style.display = columnVisibilityState[colId] ? '' : 'none';
      });

      bodyRows.forEach(row => {
        if (row.querySelector('.no-data-message')) return; // Skip the no-data message row for cell-by-cell hiding

        const cells = row.querySelectorAll('td[data-col-id]');
        cells.forEach(td => {
          const colId = td.dataset.colId;
          // Ensure state exists, default to true
          if (columnVisibilityState[colId] === undefined) columnVisibilityState[colId] = true;
          td.style.display = columnVisibilityState[colId] ? '' : 'none';
        });
      });

      // Adjust colspan for no-data message if present
      const noDataRowCell = table.querySelector('.no-data-message');
      if (noDataRowCell) {
        let visibleHeaderCount = 0;
        headerCells.forEach(th => {
          // Check actual display style as columnVisibilityState might not be updated yet for a full re-render
          if (th.style.display !== 'none') {
            visibleHeaderCount++;
          }
        });
        noDataRowCell.colSpan = visibleHeaderCount > 0 ? visibleHeaderCount : 1;
      }
    }
    // --- Mission Schedule View Specific Script ---
    const schedule_missionStyles = [
      { mTag: "CAP", name: "Combat Air Patrol" }, { mTag: "OCA", name: "Offensive Counter Air" },
      { mTag: "DCA", name: "Defensive Counter Air" }, { mTag: "ASW", name: "Anti-Submarine Warfare" },
      { mTag: "CAS", name: "Close Air Support" }, { mTag: "SEAD", name: "Suppression of Enemy Air Defenses" },
      { mTag: "SEA", name: "Maritime Sea Control" }, { mTag: "AEW", name: "Airborne Early Warning" },
      { mTag: "C2", name: "Command & Control" }, { mTag: "EW", name: "Electronic Warfare" },
      { mTag: "REC", name: "Reconnaissance" }, { mTag: "AR", name: "Air Refueling" },
      { mTag: "INT", name: "Interdiction" }, { mTag: "STRAT", name: "Strategic/Deep Strike" },
      { mTag: "MARSTR", name: "Maritime Strike" }, { mTag: "SUP", name: "Support" },
      //{ mTag: "ASuW", name: "Anti Surface Warfare" }
    ];
    schedule_missionStyles.sort((a, b) => {
      const tagA = a.mTag.toUpperCase();
      const tagB = b.mTag.toUpperCase();
      if (tagA < tagB) {
        return -1;
      }
      if (tagA > tagB) {
        return 1;
      }
      return 0;
    });

    let schedule_startDay = roundDate(currentISOTime); //REPLACE
    let schedule_is24HourView = true;
    let schedule_activeFilters = new Set();

    function initializeMissionScheduleView() {
      if (missionScheduleInitialized) {
        schedule_updateFullTimeline();
        return;
      }
      // INITIAL STATE: All active, no isolation
      schedule_isolatedTag = null;
      schedule_activeFilters.clear(); // Clear just in case
      schedule_missionStyles.forEach(style => schedule_activeFilters.add(style.mTag));

      const startDate = new Date(schedule_startDay);
      const currentDateLabel = document.getElementById("mission-schedule-currentDate");
      if (currentDateLabel) currentDateLabel.textContent = startDate.toISOString().slice(0, 10);

      schedule_updateTimelineAxis();
      schedule_createTaskPools();

      document.getElementById("schedule-toggleTimespan")?.addEventListener("click", schedule_toggleTimespan);
      document.getElementById("schedule-prevHour")?.addEventListener("click", () => schedule_shiftTimeline("prev"));
      document.getElementById("schedule-nextHour")?.addEventListener("click", () => schedule_shiftTimeline("next"));
      missionScheduleInitialized = true;
      schedule_updateMissionVisibility();
    }
    let schedule_clickTimer = null;
    const DOUBLE_CLICK_DELAY = 250; // milliseconds

    // --- Modified State Variables ---
    // schedule_activeFilters = new Set(); // Already defined, will hold active tags
    let schedule_isolatedTag = null; // NEW: Stores the mTag if one is isolated, otherwise null

    // Helper to apply visual state to a legend item
    function schedule_setLegendItemState(legendItemElement, isActive) { // Removed isIsolated parameter
      if (!legendItemElement) return;
      legendItemElement.classList.toggle('active', isActive);
      legendItemElement.classList.toggle('inactive', !isActive);
    }

    // Helper to update all legend items' appearance based on current state
    function schedule_updateAllLegendVisuals() {
      const allLegendItems = document.querySelectorAll("#mission-legend-row .mission-schedule-legend-item");
      allLegendItems.forEach(itemElement => {
        const tag = itemElement.dataset.mtag;
        schedule_setLegendItemState(itemElement, schedule_activeFilters.has(tag));
      });
    }

    // Helper to update mission visibility
    function schedule_updateMissionVisibility() {
      const timelineMissionBlocks = document.querySelectorAll(".mission-timeline-block");
      if (!timelineMissionBlocks) return;

      timelineMissionBlocks.forEach(missionBlock => {
        const missionTag = missionBlock.dataset.mtag;
        let showMission = false;

        if (schedule_activeFilters.size === 0 && schedule_missionStyles.length > 0) {
          // If all filters are toggled off by user, show no missions (that have filterable tags)
          showMission = false;
        } else if (schedule_activeFilters.size > 0) {
          // Show if mission's tag is in the active set
          showMission = schedule_activeFilters.has(missionTag);
        } else {
          // No filters defined at all (schedule_missionStyles is empty), or all filters active by default
          // (This case is for when schedule_activeFilters initially has all tags)
          showMission = true;
        }
        missionBlock.style.display = showMission ? "flex" : "none";
      });
    }
    function schedule_updateFullTimeline() {
      const startDate = new Date(schedule_startDay);
      const currentDateLabel = document.getElementById("mission-schedule-currentDate");
      if (currentDateLabel) currentDateLabel.textContent = startDate.toISOString().slice(0, 10);
      schedule_updateTimelineAxis();
      schedule_createTaskPools();
    }

    function schedule_handleLegendItemInteraction(clickedTag) { // clickedLegendItemElement no longer needed here for state, only visuals
      if (schedule_clickTimer !== null) { // Double click detected
        clearTimeout(schedule_clickTimer);
        schedule_clickTimer = null;

        // --- DOUBLE CLICK LOGIC ---
        // Check if the double-clicked tag is currently the *only* one in activeFilters
        const isCurrentlyOnlyActive = schedule_activeFilters.has(clickedTag) && schedule_activeFilters.size === 1;

        if (isCurrentlyOnlyActive) {
          // Double-clicked the ONLY active tag: reset all to active
          schedule_activeFilters.clear();
          schedule_missionStyles.forEach(style => schedule_activeFilters.add(style.mTag));
        } else {
          // Double-clicked any item (active or inactive) to isolate it
          schedule_activeFilters.clear();
          schedule_activeFilters.add(clickedTag);
        }
      } else {
        // --- SINGLE CLICK LOGIC ---
        schedule_clickTimer = setTimeout(() => {
          schedule_clickTimer = null; // Reset timer

          // Standard toggle for multi-select
          if (schedule_activeFilters.has(clickedTag)) {
            schedule_activeFilters.delete(clickedTag);
          } else {
            schedule_activeFilters.add(clickedTag);
          }
          // After single click, update visuals and mission visibility
          schedule_updateAllLegendVisuals();
          schedule_updateMissionVisibility();
        }, DOUBLE_CLICK_DELAY);
      }

      // For double-click, update visuals and visibility immediately
      if (!schedule_clickTimer) {
        schedule_updateAllLegendVisuals();
        schedule_updateMissionVisibility();
      }
    }
    function schedule_filterMissions(tag, clickedLegendItem) {
      // Target ONLY the mission blocks in the timeline, NOT the legend items
      const timelineMissionBlocks = document.querySelectorAll(".mission-timeline-block");

      if (schedule_activeFilters.has(tag)) {
        schedule_activeFilters.delete(tag);
        clickedLegendItem.classList.remove("active");
      } else {
        schedule_activeFilters.add(tag);
        clickedLegendItem.classList.add("active");
      }

      if (schedule_activeFilters.size === 0) {
        timelineMissionBlocks.forEach((missionBlock) => (missionBlock.style.display = "flex"));
      } else {
        timelineMissionBlocks.forEach((missionBlock) => {
          const missionTag = missionBlock.dataset.mtag;
          missionBlock.style.display = schedule_activeFilters.has(missionTag) ? "flex" : "none";
        });
      }
    }

    function schedule_createLegendRow() {
      const legendRow = document.getElementById("mission-legend-row");
      if (!legendRow) return;
      legendRow.innerHTML = "";

      const legendItemsToCreate = schedule_missionStyles;

      if (legendItemsToCreate.length === 0) { /* ... */ return; }
      legendRow.style.gridTemplateColumns = `repeat(${legendItemsToCreate.length}, minmax(0, 1fr))`;

      legendItemsToCreate.forEach((styleDef) => {
        const legendItem = document.createElement("div");
        legendItem.className = "mission-schedule-legend-item mission-schedule-mission";
        legendItem.setAttribute("data-mTag", styleDef.mTag);
        legendItem.textContent = styleDef.mTag;
        legendItem.title = styleDef.name || styleDef.mTag;

        legendItem.addEventListener("click", (event) => {
          event.stopPropagation();
          schedule_handleLegendItemInteraction(styleDef.mTag); // Pass only the tag
        });

        // Set initial visual state
        schedule_setLegendItemState(legendItem, schedule_activeFilters.has(styleDef.mTag));
        legendRow.appendChild(legendItem);
      });
    }

    function schedule_shiftTimeline(direction) {
      const oneHour = 60 * 60 * 1000;
      const currentStart = new Date(schedule_startDay);
      if (direction === "prev") {
        schedule_startDay = new Date(currentStart.getTime() - oneHour).toISOString();
      } else if (direction === "next") {
        schedule_startDay = new Date(currentStart.getTime() + oneHour).toISOString();
      }
      schedule_updateFullTimeline();
    }

    function schedule_updateTimelineAxis() {
      const timelineLabels = document.getElementById("mission-timeline-labels");
      const timelineGrid = document.getElementById("mission-timeline-grid");
      if (!timelineLabels || !timelineGrid) return;

      timelineLabels.innerHTML = "";
      timelineGrid.innerHTML = "";

      const startTime = new Date(schedule_startDay);
      const endTime = new Date(startTime.getTime() + (schedule_is24HourView ? 24 : 8) * 60 * 60 * 1000);
      const interval = schedule_is24HourView ? 15 * 60 * 1000 : 5 * 60 * 1000;

      const timeSlots = [];
      let currentTime = new Date(startTime);
      while (currentTime < endTime) {
        const label = currentTime.getUTCHours().toString().padStart(2, "0") + currentTime.getUTCMinutes().toString().padStart(2, "0");
        timeSlots.push({ time: new Date(currentTime), label: label });
        currentTime = new Date(currentTime.getTime() + interval);
      }

      const totalSlots = timeSlots.length;
      document.documentElement.style.setProperty('--total-slots', totalSlots);

      const gridTemplate = `repeat(${totalSlots}, 1fr)`;
      timelineLabels.style.gridTemplateColumns = gridTemplate;
      timelineGrid.style.gridTemplateColumns = gridTemplate;

      const labelFrequency = schedule_is24HourView ? 4 : (totalSlots >= 3 * 12 ? 12 : 3);
      for (let i = 0; i < timeSlots.length; i += labelFrequency) {
        const labelDiv = document.createElement("div");
        labelDiv.textContent = timeSlots[i].time.getUTCMinutes() === 0 ? timeSlots[i].time.getUTCHours().toString().padStart(2, "0") + 'Z' : timeSlots[i].label;
        labelDiv.style.gridColumn = `${i + 1} / span ${labelFrequency}`;
        if (i + labelFrequency > timeSlots.length) {
          labelDiv.style.gridColumn = `${i + 1} / span ${timeSlots.length - i}`;
        }
        timelineLabels.appendChild(labelDiv);
      }

      for (let i = 0; i < totalSlots; i++) {
        const gridDiv = document.createElement("div");
        if (timeSlots[i].time.getUTCMinutes() === 0) {
          gridDiv.style.borderRight = `1px solid ${getComputedStyle(document.documentElement).getPropertyValue('--accent-color').trim()}`;
        }
        timelineGrid.appendChild(gridDiv);
      }
      schedule_createLegendRow();
    }
    function schedule_createTaskPools() {
      const taskPoolsContainer = document.getElementById("mission-taskPools");
      if (!taskPoolsContainer) return;
      taskPoolsContainer.innerHTML = "";
      const scheduleData = missionData;

      const viewStartTime = new Date(schedule_startDay);
      const viewEndTime = new Date(viewStartTime.getTime() + (schedule_is24HourView ? 24 : 8) * 60 * 60 * 1000);
      const intervalDuration = schedule_is24HourView ? 15 * 60 * 1000 : 5 * 60 * 1000;
      const totalSlots = Math.ceil((viewEndTime - viewStartTime) / intervalDuration);

      const sortedPools = Object.entries(scheduleData).sort(([a], [b]) => a.localeCompare(b));
      for (const [poolName, poolData] of sortedPools) {
        const poolDiv = document.createElement("div");
        poolDiv.className = "mission-schedule-task-pool";
        poolDiv.style.backgroundSize = `calc(100%%%% / ${totalSlots}) 100%%%%`;

        const poolTitle = document.createElement("div");
        poolTitle.className = "mission-schedule-task-pool-title";
        poolTitle.textContent = poolName;
        poolDiv.appendChild(poolTitle);

        const rowsContainer = document.createElement("div");
        rowsContainer.className = "mission-schedule-task-pool-rows";
        rowsContainer.style.gridTemplateColumns = `repeat(${totalSlots}, 1fr)`;
        rowsContainer.style.backgroundSize = `calc(100%%%% / ${totalSlots}) 100%%%%`;
        poolDiv.appendChild(rowsContainer);

        let missionsInPoolRendered = 0; // Keep track if any mission from this pool is rendered in the view
        for (const [missionName, missionDetails] of Object.entries(poolData.missionList)) {
          const missionStartStr = missionDetails.startT;
          const missionEndStr = missionDetails.endT;
          const hasToT = missionDetails.ToT && missionDetails.ToT.trim() !== "";
          // const hasToS = missionDetails.ToS && missionDetails.ToS.trim() !== ""; // If you have ToS

          let missionStart, missionEnd;
          let isUnboundedStart = false;
          let isUnboundedEnd = false;
          let visualLabelSuffix = "";

          if (missionStartStr && missionEndStr) { // Both start and end defined
            missionStart = new Date(missionStartStr + (missionStartStr.endsWith('Z') ? '' : 'Z'));
            missionEnd = new Date(missionEndStr + (missionEndStr.endsWith('Z') ? '' : 'Z'));
            if (isNaN(missionStart.getTime()) || isNaN(missionEnd.getTime())) continue;
          } else if (missionStartStr && !missionEndStr && !hasToT) { // Only start defined
            missionStart = new Date(missionStartStr + (missionStartStr.endsWith('Z') ? '' : 'Z'));
            missionEnd = new Date(viewEndTime); // Extends to end of view
            isUnboundedEnd = true;
            visualLabelSuffix = " (Ongoing...)";
            if (isNaN(missionStart.getTime())) continue;
          } else if (!missionStartStr && missionEndStr && !hasToT) { // Only end defined
            missionStart = new Date(viewStartTime); // Starts from beginning of view
            missionEnd = new Date(missionEndStr + (missionEndStr.endsWith('Z') ? '' : 'Z'));
            isUnboundedStart = true;
            visualLabelSuffix = "(...Ongoing)";
            if (isNaN(missionEnd.getTime())) continue;
          } else if (!missionStartStr && !missionEndStr && !hasToT) { // No start, no end, no ToT/ToS
            missionStart = new Date(viewStartTime);
            missionEnd = new Date(viewEndTime);
            isUnboundedStart = true;
            isUnboundedEnd = true;
            visualLabelSuffix = " (Continuous/Unbounded)";
          } else {
            // Has ToT/ToS but no explicit start/end for block visualization, or other unhandled case
            continue; // Skip for timeline block view if not fitting above patterns
          }

          // Ensure mission times are within the view window for block rendering
          const effectiveMissionStart = Math.max(viewStartTime.getTime(), missionStart.getTime());
          const effectiveMissionEnd = Math.min(viewEndTime.getTime(), missionEnd.getTime());

          if (effectiveMissionEnd <= effectiveMissionStart) continue; // Not visible in this window or zero duration

          missionsInPoolRendered++;

          const startOffset = effectiveMissionStart - viewStartTime.getTime();
          const endOffset = effectiveMissionEnd - viewStartTime.getTime();

          const gridStart = Math.floor(startOffset / intervalDuration);
          let gridEnd = Math.ceil(endOffset / intervalDuration);
          gridEnd = Math.max(gridStart + 1, gridEnd); // Ensure at least 1 slot width

          const missionDiv = document.createElement("div");
          const titleDiv = document.createElement("span");
          missionDiv.className = "mission-schedule-mission mission-timeline-block";
          titleDiv.className = "mission-title";
          titleDiv.textContent = missionName + visualLabelSuffix;
          titleDiv.style.cursor = "pointer";
          tippy(titleDiv, {
            onShow(instance) {
              const tooltipContent = createMissionTooltipHTML(missionName);
              instance.setContent(tooltipContent);
            },
            allowHTML: true,
            theme: 'mission-tooltip',
            placement: 'top',
            arrow: true,
            appendTo: () => document.body,

            // --- THE FIX ---
            trigger: 'click',      // Only show the tooltip on a mouse click
            interactive: true,     // Allows the user to move their mouse over the tooltip without it hiding
            hideOnClick: true,     // You can set this to 'toggle' or true/false
          });
          missionDiv.appendChild(titleDiv);

          missionDiv.style.gridColumn = `${gridStart + 1} / ${gridEnd + 1}`;

          const mTag = missionDetails.mTag && schedule_missionStyles.some(s => s.mTag === missionDetails.mTag) ? missionDetails.mTag : "Unknown";
          missionDiv.setAttribute("data-mTag", mTag);

          if (schedule_activeFilters.size > 0 && !schedule_activeFilters.has(mTag)) {
            missionDiv.style.display = "none";
          } else {
            missionDiv.style.display = "flex";
          }
          if (isUnboundedStart || isUnboundedEnd) {
            missionDiv.style.opacity = "0.7";
            missionDiv.style.borderStyle = "dashed";
          }

          rowsContainer.appendChild(missionDiv);
        } // End loop through missions in poolData.missionList

        if (missionsInPoolRendered === 0) { // Changed variable name
          const noMissionMsg = document.createElement("div");
          noMissionMsg.textContent = "No missions scheduled in this time window for this pool.";
          noMissionMsg.style.gridColumn = `1 / -1`;
          noMissionMsg.style.padding = "5px";
          noMissionMsg.style.fontSize = "0.9em";
          noMissionMsg.style.color = "var(--text-muted-color)";
          noMissionMsg.style.textAlign = "center";
          rowsContainer.appendChild(noMissionMsg);
        }

        taskPoolsContainer.appendChild(poolDiv);
        poolTitle.addEventListener("click", () => {
          rowsContainer.style.display = rowsContainer.style.display === "none" ? "grid" : "none";
        });
      } // End loop through task pools
    }
    function schedule_toggleTimespan() {
      schedule_is24HourView = !schedule_is24HourView;
      const toggleButton = document.getElementById("schedule-toggleTimespan");
      if (toggleButton) toggleButton.textContent = schedule_is24HourView ? "24-Hour" : "8-Hour";
      schedule_updateFullTimeline();
    }
    let overviewUnitReadinessChartInstance, overviewMissionStatusChartInstance;

    // --- Helper function to determine unit criticality ---
    function getUnitCriticalIssues(unit) {
      const issues = [];
      const damagePercent = parseFloat(unit.damage?.dp_percent_now);

      // --- Operational Degradations ---
      if (!isNaN(damagePercent) && damagePercent >= 50) {
        issues.push({ text: `Severe Damage (${damagePercent.toFixed(0)}%%)`, severity: 5, type: 'Damage', category: 'operational_degradation' });
      } else if (!isNaN(damagePercent) && damagePercent >= 20) {
        issues.push({ text: `Moderate Damage (${damagePercent.toFixed(0)}%%)`, severity: 3, type: 'Damage', category: 'operational_degradation' });
      } else if (!isNaN(damagePercent) && damagePercent > 0) {
        issues.push({ text: `Light Damage (${damagePercent.toFixed(0)}%%)`, severity: 1, type: 'Damage', category: 'operational_degradation' });
      }

      const fuel = parseFloat(unit.fuel_status);
      if (!isNaN(fuel) && fuel < 15 &&
        unit.condition && !['Parked', 'Maintenance', 'Readying', 'RESERVE', 'UNAVAILABLE_STATUS', 'Unavailable'].includes(unit.condition?.toUpperCase())) { // Added toUpperCase for robustness
        issues.push({ text: `Critical Fuel (${fuel.toFixed(0)}%%)`, severity: 3, type: 'Fuel', category: 'operational_degradation' });
      }

      if (unit.isJammed) {
        issues.push({ text: 'Being Jammed', severity: 1, type: 'Comms', category: 'operational_degradation' }); // Increased severity for jamming
      }
      if (unit.isOutOfComms) {
        issues.push({ text: 'Out Of Comms', severity: 3, type: 'Comms', category: 'operational_degradation' }); // Increased severity for jamming
      }

      // --- Imposed Statuses (for completeness, but may be filtered out by CCIR card) ---
      if (unit.condition === 'RESERVE') {
        issues.push({ text: 'Status: Reserve', severity: 0, type: 'Status', category: 'imposed_status' }); // Severity 0 or 1, less "critical" for CCIR
      }
      if (unit.condition === 'UNAVAILABLE_STATUS' || unit.condition === 'Unavailable') { // Assuming 'Unavailable' is also a valid condition string
        issues.push({ text: 'Status: Unavailable', severity: 0, type: 'Status', category: 'imposed_status' }); // Severity 0 or 1
      }
      // Sort by severity to report the most critical
      issues.sort((a, b) => b.severity - a.severity);
      return issues; // Return all issues, can pick top one later
    }


    // --- Functions to populate CCIR cards ---
    function renderCCIRCriticalUnits() {
      const contentDiv = document.getElementById('ccir-critical-units-content');
      if (!contentDiv) return;
      contentDiv.innerHTML = '';
      unitsWithOperationalIssues = []
      const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
      const relevantUnits = unitData.filter(u => showNCU || (u.NCU !== "true" && u.NCU !== true));


      relevantUnits.forEach(unit => {
        const allIssues = unit.criticalIssues;
        const operationalDegradations = allIssues.filter(iss => iss.category === 'operational_degradation');

        if (operationalDegradations.length > 0) {
          let aggregateSeverityScore = 0;
          operationalDegradations.forEach(iss => {
            aggregateSeverityScore += iss.severity; // Simple sum of severities
          });

          // Sort operationalDegradations by severity to easily get the top one
          operationalDegradations.sort((a, b) => b.severity - a.severity);

          unitsWithOperationalIssues.push({
            unit,
            operationalIssues: operationalDegradations, // Store all operational issues
            topOperationalIssue: operationalDegradations[0], // The most severe operational issue
            aggregateSeverityScore: aggregateSeverityScore
          });
        }
      });

      // Sort units:
      // 1. By their aggregate severity score (higher score = more critical).
      // 2. Then by the severity of their single worst operational issue (just in case scores are tied).
      // 3. Then by unit name for consistent ordering.
      unitsWithOperationalIssues.sort((a, b) => {
        if (b.aggregateSeverityScore !== a.aggregateSeverityScore) {
          return b.aggregateSeverityScore - a.aggregateSeverityScore;
        }
        if (b.topOperationalIssue.severity !== a.topOperationalIssue.severity) {
          return b.topOperationalIssue.severity - a.topOperationalIssue.severity;
        }
        return a.unit.name.localeCompare(b.unit.name);
      });

      let html = `<p class="mb-2"><strong>${unitsWithOperationalIssues.length}</strong> units with operational issues requiring attention.</p>`;

      if (unitsWithOperationalIssues.length > 0) {
        html += `<ul class="list-unstyled mb-0">`;
        unitsWithOperationalIssues.slice(0, 10).forEach(detail => {
          let iconClass = "fas fa-caret-right";
          let iconColorClass = "text-danger";
          if (detail.topOperationalIssue.severity === 2) iconColorClass = "text-warning";
          else if (detail.topOperationalIssue.severity === 1) iconColorClass = "text-info";

          let issueSummaryText = detail.topOperationalIssue.text;
          if (detail.operationalIssues.length > 1) {
            const distinctIssueTypes = new Set(detail.operationalIssues.map(iss => iss.type));
            if (distinctIssueTypes.size > 1) {
              issueSummaryText += ` (+${detail.operationalIssues.length - 1} other issue${detail.operationalIssues.length - 1 > 1 ? 's' : ''} of types: ${Array.from(distinctIssueTypes).join(', ')})`;
            } else {
              issueSummaryText += ` (+${detail.operationalIssues.length - 1} similar issue${detail.operationalIssues.length - 1 > 1 ? 's' : ''})`;
            }
          }
          issueSummaryText = truncate(issueSummaryText, 60);

          // MODIFIED LINE: Wrap unit name in an anchor tag
          html += `<li>
                     <small class="d-flex align-items-center w-100">
            <!-- Unit Name (should not truncate) -->
            <div class="text-nowrap me-2">
                <i class="${iconClass} ${iconColorClass}"></i>
                <strong class="ms-1">
                    <a href="#" class="ccir-unit-link" ...>
                        ${truncate(detail.unit.name, 15)}
                    </a>
                </strong>
            </div>

            <!-- Classname and Issue (this part will shrink and truncate) -->
            <div class="text-muted-color flex-truncate" title="${detail.topOperationalIssue.text}">
                <span>(${truncate(detail.unit.classname,10)}): ${detail.topOperationalIssue.text}</span>
            </div>
        </small>
                    </li>`;
        });
        if (unitsWithOperationalIssues.length > 10) {
          html += `<li><small>...and ${unitsWithOperationalIssues.length - 10} more units with operational issues.</small></li>`;
        }
        html += `</ul>`;
      } else {
        html = `<p class="text-success"><i class="fas fa-check-circle me-1"></i>All units are currently operationally sound.</p>`;
      }
      contentDiv.innerHTML = html;

      // AFTER innerHTML is set, attach event listeners to the new links
      attachCCIRUnitLinkListeners(contentDiv);
    }
    function attachCCIRUnitLinkListeners(parentElement) {
      if (!parentElement) return;
      parentElement.querySelectorAll('a.ccir-unit-link').forEach(link => {
        // To prevent attaching multiple listeners if renderCCIRCriticalUnits is called often,
        // you might consider a more robust way to manage listeners (e.g., event delegation on parentElement,
        // or cloning and replacing the link). For this case, direct attachment after innerHTML
        // replacement is generally fine if the whole card content is replaced.
        link.addEventListener('click', handleCCIRUnitLinkClick);
      });
    }

    function handleCCIRUnitLinkClick(event) {
      event.preventDefault(); // Stop the link from navigating to "#"
      const unitNameToSearch = event.currentTarget.dataset.unitName;

      if (!unitNameToSearch) {
        console.error("CCIR Unit Link: unit-name data attribute is missing.");
        return;
      }

      // 1. Get current state of NCU and Hide Unavailable filters to preserve them
      const ncuState = document.getElementById('unit-ncu-filter')?.checked || false;
      const hideUnavailableState = document.getElementById('unit-hide-unavailable-filter')?.checked || true; // Default true

      // 2. Clear existing unit filters in the UI
      document.getElementById('unit-search').value = unitNameToSearch; // Set the search term
      document.getElementById('unit-type-filter').value = '';
      // document.getElementById('unit-subtype-filter').value = ''; // If you have it
      document.getElementById('unit-mission-filter').value = '';
      document.getElementById('unit-base-filter').value = '';
      document.getElementById('unit-mission-mtype-filter').value = '';
      document.getElementById('unit-status-filter').value = '';
      document.getElementById('unit-loadout-role-filter').value = '';
      clearUnitFilters
      // 3. Update the global currentUnitFilters state object
      currentUnitFilters = {
        search: unitNameToSearch,
        type: '',
        mission: '',
        base: '',
        missionMType: '',
        condition: '',
        loadoutRole: '',
        operationalStatus: '', 
        showNCU: ncuState,
        hideUnavailableReserve: hideUnavailableState,
        showOnlyCritical: false // Important: We are not applying the "show only critical" from overview's main button
      };

      // 4. Switch to the 'units' view
      // switchView('units') should internally call renderUnitsTable()
      // which will use the updated currentUnitFilters.search
      uiState.isUnitsTableDirty = true;
      switchView('units');
    }
    function renderCCIRPriorityMissions() {
      const contentDiv = document.getElementById('ccir-priority-missions-content');
      if (!contentDiv) return;

      const allMissions = getAllMissionsArray(missionData); // Gets {name, details, taskPool}
      const now = new Date(currentISOTime);
      const priorityTags = ["STRAT", "SEAD", "DCA", "OCA", "INT"];

      let activePriorityMissions = [];
      let missionsWithIssues = []; // e.g., active priority mission with 0 units

      allMissions.forEach(missionEntry => {
        const d = missionEntry; // d is now the full mission object from the array
        const startTime = parseAsUTC(d.startT);
        const endTime = parseAsUTC(d.endT);
        const isMissionActive = (d.calculatedStatus === "ACTIVE");

        if (isMissionActive && d.mTag && priorityTags.includes(d.mTag.toUpperCase())) {
          const assignedUnitsCount = unitData.filter(u => u.mission === d.name).length;
          activePriorityMissions.push({ ...d, assignedUnitsCount });
          if (assignedUnitsCount === 0) {
            missionsWithIssues.push({ ...d, issue: "0 Units Assigned" });
          }
        }
      });

      let html = `<p class="mb-2"><strong>${activePriorityMissions.length}</strong> active high-priority missions.</p>`;
      if (missionsWithIssues.length > 0) {
        html += `<p class="mb-1 text-warning"><small><i class="fas fa-exclamation-circle me-1"></i>${missionsWithIssues.length} potentially require attention:</small></p>`;
        html += `<ul class="list-unstyled mb-2 sub-list">`;
        missionsWithIssues.slice(0, 2).forEach(m => {
          html += `<li><small><strong>${m.name}</strong> (${m.mTag}): ${m.issue}</small></li>`;
        });
        if (missionsWithIssues.length > 2) {
          html += `<li><small>...and ${missionsWithIssues.length - 2} more with issues.</small></li>`;
        }
        html += `</ul>`;
      } else if (activePriorityMissions.length > 0) {
        html += `<p class="text-success mb-1"><small><i class="fas fa-check-circle me-1"></i>All active priority missions have units assigned.</small></p>`;
        html += `<ul class="list-unstyled mb-0 sub-list" style="overflow:hidden;">`;
        activePriorityMissions.slice(0, 2).forEach(m => {
          html += `<li><small><strong>${m.name}</strong> (${m.mTag}): ${m.assignedUnitsCount} units</small></li>`;
        });
        if (activePriorityMissions.length > 2) {
          html += `<li><small>...and ${activePriorityMissions.length - 2} more.</small></li>`;
        }
        html += `</ul>`;
      } else {
        html = `<p class="text-info"><i class="fas fa-info-circle me-1"></i>No active high-priority missions currently.</p>`;
      }
      contentDiv.innerHTML = html;
    }
    let criticalMunitionEntriesGlobal = [];
    function renderCCIRResourceWatch() {
      const contentParent = document.getElementById('ccir-resource-watch-card')
      const contentDiv = document.getElementById('ccir-resource-watch-content');
      const cardHeaderButton = document.querySelector('#ccir-resource-watch-card .view-details-btn');
      if (!contentDiv) return;

      const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
      const relevantUnits = unitData.filter(u => showNCU || (u.NCU !== "true" && u.NCU !== true));

      criticalMunitionEntriesGlobal = []; // Will store objects {munition, platformName, currentQty, reason, type: 'low_percent' | 'low_sortie'}




      // --- Part 2: Aircraft Munitions (Limiting to < 2 Sorties) ---
      const aircraftForSortieCalc = relevantUnits.filter(u =>
        u.unitType === 'Aircraft' &&
        u.weapons && Object.keys(u.weapons).length > 0 &&
        u.condition === "Parked" &&
        (u.loadout_role !== 9002 && u.loadout_role !== "9002") && (u.loadout_role !== 9003 && u.loadout_role !== "9003")
      );

      // Group aircraft by base and classname to aggregate munition needs vs stock
      const aircraftGroupedByBaseAndClass = {}; // ... (grouping logic as before) ...
      aircraftForSortieCalc.forEach(ac => {
        const baseKey = ac.base || "No Base";
        const classKey = ac.classname;
        const groupKey = `${baseKey}_${classKey}`;
        if (!aircraftGroupedByBaseAndClass[groupKey]) {
          aircraftGroupedByBaseAndClass[groupKey] = {
            baseName: baseKey, aircraftClass: classKey, aircraftCount: 0,
            totalLoadoutDemandPerSortie: {}, aircraftInstances: []
          };
        }
        aircraftGroupedByBaseAndClass[groupKey].aircraftCount++;
        aircraftGroupedByBaseAndClass[groupKey].aircraftInstances.push(ac.name);
        for (const [munitionName, loadoutData] of Object.entries(ac.weapons)) {
          const qtyPerAcSortie = loadoutData.qty;
          if (qtyPerAcSortie > 0) {
            aircraftGroupedByBaseAndClass[groupKey].totalLoadoutDemandPerSortie[munitionName] =
              (aircraftGroupedByBaseAndClass[groupKey].totalLoadoutDemandPerSortie[munitionName] || 0) + qtyPerAcSortie;
          }
        }
      });

      Object.values(aircraftGroupedByBaseAndClass).forEach(group => {
        if (group.aircraftCount === 0) return;

        let minPossibleFullGroupSorties = Infinity;
        let overallLimitingMunition = null;
        let stockForLimitingMunition = 0;
        let demandForLimitingMunitionPerSortie = 0;

        if (Object.keys(group.totalLoadoutDemandPerSortie).length === 0) return; // No weapons demanded by this group

        for (const [munitionName, totalDemandPerSortie] of Object.entries(group.totalLoadoutDemandPerSortie)) {
          if (totalDemandPerSortie === 0) continue;

          let currentTotalStock = 0;
          // Sum stock from all aircraft in the group
          aircraftForSortieCalc.filter(ac => ac.base === group.baseName && ac.classname === group.aircraftClass).forEach(acInstance => {
            currentTotalStock += (acInstance.weapons?.[munitionName]?.qty || 0);
            // Don't double count from magazines if weapons already includes it
            // currentTotalStock += (acInstance.magazines?.[munitionName]?.qty || 0);
          });


          // Add stock from the base (Facility or Ship)
          if (group.baseName !== "No Base") {
            const basePlatform = relevantUnits.find(u => u.name === group.baseName && (u.unitType === 'Facility' || u.unitType === 'Ship'));
            if (basePlatform) {
              currentTotalStock += (basePlatform.weapons?.[munitionName]?.qty || 0);
              currentTotalStock += (basePlatform.magazines?.[munitionName]?.qty || 0);
            }
          }

          const possibleSortiesForMunition = Math.floor(currentTotalStock / totalDemandPerSortie);

          if (possibleSortiesForMunition < minPossibleFullGroupSorties) {
            minPossibleFullGroupSorties = possibleSortiesForMunition;
            overallLimitingMunition = munitionName;
            stockForLimitingMunition = currentTotalStock;
            demandForLimitingMunitionPerSortie = totalDemandPerSortie;
          }
        }

        if (minPossibleFullGroupSorties < 2 && overallLimitingMunition) {
          criticalMunitionEntriesGlobal.push({
            munition: overallLimitingMunition,
            base: `${group.baseName}`,
            platformName: `${group.aircraftClass} @ ${group.baseName}`, // Indicate the group
            platformClass: group.aircraftClass,
            currentQty: stockForLimitingMunition, // Total stock available to the group for this munition
            maxSorties: minPossibleFullGroupSorties,
            AC: group.aircraftCount,
            MunPerSortie: demandForLimitingMunitionPerSortie,
            reason: `Can only support ${minPossibleFullGroupSorties} full group sortie(s) (Needs ${demandForLimitingMunitionPerSortie} per sortie). ${group.aircraftCount} AC.`,
            detail: `${minPossibleFullGroupSorties} sorties`,
            type: 'low_sortie'
          });
        }
      });


      // --- Display Logic ---
      // Sort by type (low_sortie first, then low_percent), then by platform name
      criticalMunitionEntriesGlobal.sort((a, b) => {
        if (a.type === 'low_sortie' && b.type !== 'low_sortie') return -1;
        if (b.type === 'low_sortie' && a.type !== 'low_sortie') return 1;
        if (a.type === 'low_percent' && b.type === 'low_absolute_heuristic') return -1;
        if (b.type === 'low_percent' && a.type === 'low_absolute_heuristic') return 1;
        return a.platformName.localeCompare(b.platformName);
      });


      // --- Aggregated Summary for the Card ---
      let cardHtml = `<p class="mb-2"><strong>${criticalMunitionEntriesGlobal.length}</strong> critical munition situation(s) identified.</p>`;
      if (criticalMunitionEntriesGlobal.length > 0) {
        cardHtml += `<ul class="list-unstyled mb-0 sub-list">`;
        criticalMunitionEntriesGlobal.slice(0, 6).forEach(entry => {
          let itemHtml = '';
          // This block is specifically for the 'low_sortie' calculation, which is the most informative.
          if (entry.type === 'low_sortie') {
            const tooltipContent = `
              <div class='text-start sortie-tooltip-content'>
                  <strong>${entry.munition} Details:</strong><br>
                  - Aircrafts: <strong>${entry.AC}</strong><br>
                  - Munitions per Sortie: <strong>${entry.MunPerSortie}</strong><br>
                  - Total Stock : <strong>${entry.currentQty}</strong><br>
                  - Calculation: floor(${entry.currentQty} / ${entry.MunPerSortie}) = <strong>${entry.maxSorties}</strong>
              </div>
          `;
            itemHtml = `
                <li data-bs-toggle="tooltip" 
            data-bs-placement="top" 
            data-bs-html="true" 
            title="${tooltipContent}">
                    <small class="d-flex justify-content-between align-items-center w-100">

                    <!-- Left Group: Weapon Info -->
                    <div class="text-nowrap me-2">
                        <!-- No truncation needed here as it's the primary info -->
                        <strong>${entry.currentQty}x ${truncate(entry.munition, 15)}:</strong>
                    </div>

                    <!-- Center Group: This is the part that needs to shrink and truncate -->
                    <div class="d-flex align-items-center text-muted-color mx-2 flex-truncate">
                        <span title="Aircraft Class">
                            <i class="fas fa-fighter-jet me-1"></i>${entry.platformClass}
                        </span>
                        <span class="ms-3" title="Base">
                            <i class="fas fa-map-marker-alt me-1"></i>${entry.base}
                        </span>
                    </div>

                    <!-- Right Group: Critical Sortie Count -->
                    <div class="text-warning fw-bold text-nowrap ms-auto">
                        <span title="Potential Sorties">
                            <i class="fas fa-plane-slash me-1"></i>${entry.maxSorties} Sortie(s)
                        </span>
                    </div>

                </small>
                </li>`;
          } else {
            // Fallback for any other types of critical entries, keeping it simple.
            itemHtml = `
                <li>
                    <small>
                        <i class="fas fa-exclamation-triangle text-danger me-1"></i>
                        ${entry.currentQty}x <strong>${truncate(entry.munition, 18)}</strong> @ ${truncate(entry.platformName, 20)}: Low Stock
                    </small>
                </li>`;
          }
          cardHtml += itemHtml;
        });
        if (criticalMunitionEntriesGlobal.length > 4) {
          cardHtml += `<li><small>...and ${criticalMunitionEntriesGlobal.length - 6} more.</small></li>`;
        }
        cardHtml += `</ul>`;
        // Add the "View Full Report" button IF there are entries
        //cardHtml += `<div class="text-end mt-2"><button class="btn btn-xs btn-outline-info" id="open-critical-munitions-modal-btn">View Full Report</button></div>`;

      } else {
        cardHtml = `<p class="text-success mb-0"><i class="fas fa-check-circle me-1"></i>No critical munition situations currently flagged.</p>`;
      }
      contentDiv.innerHTML = cardHtml;
      
      // Attach listener for the "View Full Report" button (inside the card)
      const openModalBtn = document.getElementById('open-critical-munitions-modal-btn');
      if (openModalBtn) {
        openModalBtn.addEventListener('click', () => {
          if (criticalMunitionsDetailModalInstance && criticalMunitionEntriesGlobal) {
            // Sort criticalMunitionEntriesGlobal by default before showing (e.g., by type, then platform)
            const initialSortState = { column: 'type', order: 'asc' }; // Example initial sort
            let entriesForModal = [...criticalMunitionEntriesGlobal];
            entriesForModal.sort((a, b) => {
              let valA = a[initialSortState.column] || ""; let valB = b[initialSortState.column] || "";
              if (typeof valA === 'number' && typeof valB === 'number') return initialSortState.order === 'asc' ? valA - valB : valB - valA;
              valA = String(valA).toLowerCase(); valB = String(valB).toLowerCase();
              if (valA < valB) return initialSortState.order === 'asc' ? -1 : 1;
              if (valA > valB) return initialSortState.order === 'asc' ? 1 : -1;
              // Secondary sort if primary is equal
              if (a.platformName < b.platformName) return -1;
              if (a.platformName > b.platformName) return 1;
              return 0;
            });

            renderCriticalMunitionsModalTable(entriesForModal, ''); // Render with all, no filter, initially sorted
            // Reset modal search input
            const modalSearch = document.getElementById('critical-munitions-modal-search');
            if (modalSearch) modalSearch.value = '';
            // Reset modal sort indicators (optional, or set to initial sort)
            document.querySelectorAll('#critical-munitions-detail-table thead th[data-sort-modal] i').forEach(i => i.className = 'fas fa-sort');
            const initialSortHeader = document.querySelector(`#critical-munitions-detail-table thead th[data-sort-modal="${initialSortState.column}"] i`);
            if (initialSortHeader) initialSortHeader.className = `fas fa-sort-${initialSortState.order === 'asc' ? 'up' : 'down'}`;

            criticalMunitionsDetailModalInstance.show();
          } else {
            console.error("Modal instance or critical munition entries not ready.");
          }
        });
      }

      // Update the main card header button's behavior (for link to Weapons tab)
      if (cardHeaderButton) {
        const newCardHeaderButton = cardHeaderButton.cloneNode(true); // To clear old listeners
        cardHeaderButton.parentNode.replaceChild(newCardHeaderButton, cardHeaderButton);

        if (criticalMunitionEntriesGlobal.length > 0) {
          newCardHeaderButton.disabled = false;
          newCardHeaderButton.addEventListener('click', navigateToWeaponsWithCriticalFilter); // Uses correct global
        } else {
          newCardHeaderButton.disabled = true;
        }
      }
    }
    function renderCriticalMunitionsModalTable(entriesToDisplay, searchTerm) {
      const tableBody = document.getElementById('critical-munitions-detail-table-body');
      if (!tableBody) {
        console.error("Modal table body not found!");
        return;
      }

      const lowerSearchTerm = searchTerm ? searchTerm.toLowerCase() : "";
      let filteredEntries = entriesToDisplay;

      if (lowerSearchTerm) {
        filteredEntries = entriesToDisplay.filter(entry => {
          return (
            (entry.munition && entry.munition.toLowerCase().includes(lowerSearchTerm)) ||
            (entry.platformName && entry.platformName.toLowerCase().includes(lowerSearchTerm)) ||
            (entry.platformClass && entry.platformClass.toLowerCase().includes(lowerSearchTerm)) ||
            (entry.reason && entry.reason.toLowerCase().includes(lowerSearchTerm)) ||
            (entry.type && entry.type.toLowerCase().includes(lowerSearchTerm))
          );
        });
      }

      if (filteredEntries.length === 0) {
        tableBody.innerHTML = `<tr><td colspan="6" class="text-center text-muted-color">No critical munition entries match your filter${searchTerm ? '' : ' (or no issues found)'}.</td></tr>`;
        return;
      }

      tableBody.innerHTML = filteredEntries.map(entry => {
        let typeClass = 'info text-dark'; // Default
        if (entry.type === 'Low Sorties') typeClass = 'warning text-dark';
        else if (entry.type === 'Low Percentage') typeClass = 'danger';
        else if (entry.type === 'Low Absolute') typeClass = 'orange'; // Use .text-orange or style directly
        const tooltipTitle = entry.detail || "No further details available.";
        return `
            <tr>
                <td>${entry.base || 'N/A'}</td>
                <td>${entry.munition || 'N/A'}</td>
                <td>${entry.platformClass || 'N/A'}</td>
                <td>${entry.AC}</td>
                <td>${entry.maxSorties}</td>
                <td class="text-center">${entry.currentQty !== undefined ? entry.currentQty : 'N/A'}</td>
                <td data-bs-toggle="tooltip" data-bs-placement="top" title="${tooltipTitle}"><small>${entry.MunPerSortie || 'N/A'}</small></td>
                
            </tr>
        `;
      }).join('');
    }

    function navigateToWeaponsWithCriticalFilter() {
      if (allCurrentlyCriticalMunitionsForFiltering.length === 0) {
        switchView('weapons'); // Just go to weapons tab if nothing specific
        return;
      }

      // Get unique munition names that are critical
      const criticalMunitionNames = [...new Set(allCurrentlyCriticalMunitionsForFiltering.map(entry => entry.munition))];

      // Construct a search string like "Tomahawk OR AMRAAM OR SM-6"
      // Note: Simple "OR" might not be directly supported by your basic text search.
      // A more robust way would be if your weapon search could handle a list of exact names.
      // For now, we'll create a space-separated list which might catch some if names are partial.
      // Or, for a simple implementation, just take the first few.
      let searchFilterString = criticalMunitionNames.slice(0, 5).join(' '); // Take up to 5, space separated
      // If you want to try an OR, it would look like:
      // let searchFilterString = criticalMunitionNames.join(' OR ');
      // But your renderWeaponsTable search logic would need to understand "OR"

      console.debug("Navigating to Weapons with filter string:", searchFilterString);

      // Set this string in the weapon search input
      const weaponSearchInput = document.getElementById('weapon-search');
      if (weaponSearchInput) {
        weaponSearchInput.value = searchFilterString;
      }

      currentWeaponFilters.search = searchFilterString; // If you use a state object for filters

      switchView('weapons'); // This will trigger renderWeaponsTable

      // Ensure renderWeaponsTable is called again if switchView itself doesn't guarantee it
      // with the updated search input value if it's not event-driven on input.
      // Or trigger the input event:
      if (weaponSearchInput) {
        weaponSearchInput.dispatchEvent(new Event('input', { bubbles: true }));
      }
    }
    function initializeKeyAssetConfigModal() {
      keyAssetConfigModalInstance = new bootstrap.Modal(document.getElementById('keyAssetConfigModal'));

      const launchBtn = document.getElementById('launch-key-asset-config-modal-btn');
      if (launchBtn) {
        launchBtn.addEventListener('click', () => {
          populateModalTypeDropdown(); // For classname selection
          updateAddMethodFields(); // Show correct fields based on dropdown
          renderModalKeyAssetsWatchlist(); // Populate current watchlist in modal
          keyAssetConfigModalInstance.show();
        });
      }

      const addMethodSelect = document.getElementById('key-asset-add-method');
      if (addMethodSelect) {
        addMethodSelect.addEventListener('change', updateAddMethodFields);
      }

      // Populate Classname dropdown based on Type selection (for "Add by Classname")
      const typeForClassSelect = document.getElementById('key-asset-config-type-for-class');
      const classnameSearchInput = document.getElementById('key-asset-config-classname-search');
      const classnameSelectDropdown = document.getElementById('key-asset-config-classname-select');

      if (typeForClassSelect) {
        typeForClassSelect.addEventListener('change', () => {
          filterAndPopulateClassnameDropdown(typeForClassSelect.value, '', classnameSelectDropdown, classnameSearchInput);
        });
      }
      if (classnameSearchInput) {
        classnameSearchInput.addEventListener('input', debounce(function () {
          filterAndPopulateClassnameDropdown(typeForClassSelect.value, this.value, classnameSelectDropdown, classnameSearchInput);
        }, 300));
        // Show dropdown when input gets focus if it has options
        classnameSearchInput.addEventListener('focus', () => {
          if (classnameSelectDropdown.options.length > 1) { // More than just "-- Select Classname --"
            classnameSelectDropdown.classList.remove('d-none');
            classnameSelectDropdown.size = Math.min(5, classnameSelectDropdown.options.length);
          }
        });
      }
      if (classnameSelectDropdown) {
        classnameSelectDropdown.addEventListener('change', function () {
          if (this.value) {
            classnameSearchInput.value = this.options[this.selectedIndex].text; // Update input with selection
            this.classList.add('d-none'); // Hide dropdown after selection
          }
        });
        // Hide dropdown if clicked outside
        document.addEventListener('click', (event) => {
          if (!classnameSearchInput.contains(event.target) && !classnameSelectDropdown.contains(event.target)) {
            classnameSelectDropdown.classList.add('d-none');
          }
        });
      }


      // Search and select for "Specific Unit"
      const unitSearchInput = document.getElementById('key-asset-config-unit-search');
      const unitSelectDropdown = document.getElementById('key-asset-config-unit-select');
      if (unitSearchInput) {
        unitSearchInput.addEventListener('input', debounce(function () {
          filterAndPopulateUnitDropdown(this.value, unitSelectDropdown, unitSearchInput);
        }, 300));
        unitSearchInput.addEventListener('focus', () => {
          if (unitSelectDropdown.options.length > 1) {
            unitSelectDropdown.classList.remove('d-none');
            unitSelectDropdown.size = Math.min(5, unitSelectDropdown.options.length);
          }
        });
      }
      if (unitSelectDropdown) {
        unitSelectDropdown.addEventListener('change', function () {
          if (this.value) {
            unitSearchInput.value = this.options[this.selectedIndex].text;
            unitSelectDropdown.classList.add('d-none');
          }
        });
        document.addEventListener('click', (event) => {
          if (!unitSearchInput.contains(event.target) && !unitSelectDropdown.contains(event.target)) {
            unitSelectDropdown.classList.add('d-none');
          }
        });
      }


      const modalAddBtn = document.getElementById('modal-add-key-asset-btn');
      if (modalAddBtn) {
        modalAddBtn.addEventListener('click', handleAddKeyAssetFromModal);
      }
    }
    function initializeCriticalMunitionsModal() {
      if (document.getElementById('criticalMunitionsDetailModal')) {
        criticalMunitionsDetailModalInstance = new bootstrap.Modal(document.getElementById('criticalMunitionsDetailModal'));
      } else {
        console.error("Critical Munitions Detail Modal HTML not found!");
        return;
      }


      const modalSearchInput = document.getElementById('critical-munitions-modal-search');
      if (modalSearchInput) {
        modalSearchInput.addEventListener('input', debounce(function () {
          // Use the global criticalMunitionEntriesGlobal array
          renderCriticalMunitionsModalTable(criticalMunitionEntriesGlobal, this.value);
        }, 300));
      }

      // Basic Sort State for Modal Table
      let modalSortState = { column: 'munition', order: 'asc' };

      const modalTableHeaders = document.querySelectorAll('#critical-munitions-detail-table thead th[data-sort-modal]');
      modalTableHeaders.forEach(th => {
        th.addEventListener('click', function () {
          const column = this.dataset.sortModal;
          if (modalSortState.column === column) {
            modalSortState.order = modalSortState.order === 'asc' ? 'desc' : 'asc';
          } else {
            modalSortState.column = column;
            modalSortState.order = 'asc';
          }

          // Sort criticalMunitionEntriesGlobal (the global array that feeds the modal)
          // Make a copy to sort for display if you don't want to alter the original order permanently
          let sortedEntries = [...criticalMunitionEntriesGlobal];
          sortedEntries.sort((a, b) => {
            let valA = a[modalSortState.column] || ""; // Handle undefined
            let valB = b[modalSortState.column] || "";

            if (typeof valA === 'number' && typeof valB === 'number') {
              return modalSortState.order === 'asc' ? valA - valB : valB - valA;
            }
            // String comparison (case-insensitive)
            valA = String(valA).toLowerCase();
            valB = String(valB).toLowerCase();
            if (valA < valB) return modalSortState.order === 'asc' ? -1 : 1;
            if (valA > valB) return modalSortState.order === 'asc' ? 1 : -1;
            return 0;
          });

          renderCriticalMunitionsModalTable(sortedEntries, modalSearchInput.value); // Render with sorted data

          modalTableHeaders.forEach(h => h.querySelector('i').className = 'fas fa-sort');
          this.querySelector('i').className = `fas fa-sort-${modalSortState.order === 'asc' ? 'up' : 'down'}`;
        });
      });
    }
    function updateAddMethodFields() {
      const addMethod = document.getElementById('key-asset-add-method').value;
      const classnameFields = document.getElementById('key-asset-add-by-classname-fields');
      const unitFields = document.getElementById('key-asset-add-by-unit-fields');

      if (addMethod === 'classname') {
        classnameFields.style.display = 'block';
        unitFields.style.display = 'none';
        populateModalTypeDropdown(); // Ensure type dropdown for classname is populated
      } else { // specific_unit
        classnameFields.style.display = 'none';
        unitFields.style.display = 'block';
        // Clear and hide specific unit search results initially
        document.getElementById('key-asset-config-unit-search').value = '';
        const unitSelect = document.getElementById('key-asset-config-unit-select');
        unitSelect.innerHTML = '<option value="">-- Select Unit --</option>';
        unitSelect.classList.add('d-none');
      }
    }

    function populateModalTypeDropdown() { // For "Add by Classname"
      const typeSelect = document.getElementById('key-asset-config-type-for-class');
      if (!typeSelect) return;
      const currentVal = typeSelect.value; // Preserve selection if any
      const uniqueTypes = [...new Set(unitData.map(u => u.unitType).filter(Boolean))].sort();
      typeSelect.innerHTML = '<option value="">-- Select Type --</option>' +
        uniqueTypes.map(t => `<option value="${t}" ${t === currentVal ? 'selected' : ''}>${t}</option>`).join('');
    }


    function filterAndPopulateClassnameDropdown(selectedType, searchTerm, classnameSelectEl, searchInputEl) {
      classnameSelectEl.innerHTML = '<option value="">-- Select Classname --</option>';
      if (!selectedType) {
        classnameSelectEl.classList.add('d-none');
        return;
      }

      const lowerSearchTerm = searchTerm.toLowerCase();
      const classnames = [...new Set(
        unitData
          .filter(u => u.unitType === selectedType && u.classname && u.classname.toLowerCase().includes(lowerSearchTerm))
          .map(u => u.classname)
      )].sort();

      if (classnames.length > 0) {
        classnames.forEach(cn => {
          const option = document.createElement('option');
          option.value = cn;
          option.textContent = cn;
          classnameSelectEl.appendChild(option);
        });
        classnameSelectEl.classList.remove('d-none');
        classnameSelectEl.size = Math.min(5, classnames.length + 1); // +1 for the placeholder
      } else {
        classnameSelectEl.classList.add('d-none');
      }
    }

    function filterAndPopulateUnitDropdown(searchTerm, unitSelectEl, searchInputEl) {
      unitSelectEl.innerHTML = '<option value="">-- Select Unit --</option>';
      const lowerSearchTerm = searchTerm.toLowerCase();

      if (lowerSearchTerm.length < 2) { // Don't search on very short terms
        unitSelectEl.classList.add('d-none');
        return;
      }

      const matchingUnits = unitData.filter(u =>
        (u.name && u.name.toLowerCase().includes(lowerSearchTerm)) ||
        (u.id && u.id.toLowerCase().includes(lowerSearchTerm))
      ).slice(0, 10); // Limit results

      if (matchingUnits.length > 0) {
        matchingUnits.forEach(u => {
          const option = document.createElement('option');
          option.value = u.id; // Use ID as value
          option.textContent = `${u.name} (${u.classname}) - [${u.id}]`;
          option.dataset.unitName = u.name;
          option.dataset.unitType = u.unitType;
          option.dataset.unitClassname = u.classname;
          unitSelectEl.appendChild(option);
        });
        unitSelectEl.classList.remove('d-none');
        unitSelectEl.size = Math.min(5, matchingUnits.length + 1);
      } else {
        unitSelectEl.classList.add('d-none');
      }
    }


    function handleAddKeyAssetFromModal() {
      const addMethod = document.getElementById('key-asset-add-method').value;
      let newAsset = {};

      if (addMethod === 'classname') {
        const selectedType = document.getElementById('key-asset-config-type-for-class').value;
        const classnameSearchVal = document.getElementById('key-asset-config-classname-search').value; // This is the final selected classname
        const classnameSelect = document.getElementById('key-asset-config-classname-select');
        // Ensure the search input accurately reflects a chosen classname
        const chosenClassname = classnameSelect.options[classnameSelect.selectedIndex]?.value || classnameSearchVal;


        if (!selectedType) { alert("Please select a Unit Type."); return; }
        if (!chosenClassname) { alert("Please select or type a Classname."); return; }

        // Check if this exact classname exists for the type
        const classExistsForType = unitData.some(u => u.unitType === selectedType && u.classname === chosenClassname);
        if (!classExistsForType) {
          alert(`Classname "${chosenClassname}" not found for type "${selectedType}". Please select from the suggestions or ensure it's correct.`);
          return;
        }


        newAsset = {
          watchType: "classname",
          type: selectedType,
          classname: chosenClassname,
          displayName: chosenClassname, // Or `${selectedType} / ${chosenClassname}`
          icon: DEFAULT_ASSET_ICONS[selectedType] || 'fa-question-circle'
        };
      } else { // specific_unit
        const unitSelect = document.getElementById('key-asset-config-unit-select');
        const selectedOption = unitSelect.options[unitSelect.selectedIndex];

        if (!selectedOption || !selectedOption.value) { alert("Please search and select a Specific Unit."); return; }

        newAsset = {
          watchType: "specific_unit",
          unitId: selectedOption.value,
          unitName: selectedOption.dataset.unitName,
          type: selectedOption.dataset.unitType, // Store type for icon/display
          classname: selectedOption.dataset.unitClassname, // Store classname for display consistency
          displayName: selectedOption.dataset.unitName,
          icon: DEFAULT_ASSET_ICONS[selectedOption.dataset.unitType] || 'fa-question-circle'
        };
      }

      // Prevent duplicates
      const alreadyExists = userDefinedKeyAssets.some(asset =>
        asset.watchType === newAsset.watchType &&
        (asset.watchType === "classname" ? (asset.type === newAsset.type && asset.classname === newAsset.classname)
          : (asset.unitId === newAsset.unitId))
      );

      if (alreadyExists) {
        alert("This asset (or classname) is already on the watchlist.");
        return;
      }

      userDefinedKeyAssets.push(newAsset);
      renderModalKeyAssetsWatchlist();
      renderKeyAssetAvailability(); // Update the main overview display
      //console.debug("Updated Key Assets Watchlist (from modal):", JSON.stringify(userDefinedKeyAssets));
      const jsonAssets = JSON.stringify(userDefinedKeyAssets);

      //TO-DO send this array to lua and store it in a scenario key
      if (window.chrome) {
        window.chrome.webview.postMessage(`DIALOG_OKUserDefinedKeyAssets('${jsonAssets}')`);
      }
      // Clear inputs for next addition
      if (addMethod === 'classname') {
        document.getElementById('key-asset-config-type-for-class').value = '';
        document.getElementById('key-asset-config-classname-search').value = '';
        const classSelect = document.getElementById('key-asset-config-classname-select');
        classSelect.innerHTML = '<option value="">-- Select Classname --</option>';
        classSelect.classList.add('d-none');
      } else {
        document.getElementById('key-asset-config-unit-search').value = '';
        const unitSelect = document.getElementById('key-asset-config-unit-select');
        unitSelect.innerHTML = '<option value="">-- Select Unit --</option>';
        unitSelect.classList.add('d-none');
      }
    }


    function renderModalKeyAssetsWatchlist() {
      const watchlistDiv = document.getElementById('modal-current-key-assets-watchlist');
      if (!watchlistDiv) return;

      if (userDefinedKeyAssets.length === 0) {
        watchlistDiv.innerHTML = '<p class="text-muted-color small">No assets currently on watchlist.</p>';
        return;
      }
      let html = '<ul class="list-group list-group-flush">'; // Using list-group for better styling in modal
      userDefinedKeyAssets.forEach((asset, index) => {
        let assetLabel = "";
        if (asset.watchType === "classname") {
          assetLabel = `Class: ${asset.type} / ${truncate(asset.classname, 30)}`;
        } else { // specific_unit
          assetLabel = `Unit: ${asset.unitName} (${truncate(asset.classname, 20)})`;
        }
        html += `
            <li class="list-group-item d-flex justify-content-between align-items-center py-1 px-2">
                <small><i class="fas ${asset.icon || 'fa-cube'} me-2"></i>${assetLabel}</small>
                <button class="btn btn-sm btn-outline-danger remove-key-asset-btn" data-index="${index}" title="Remove"><i class="fas fa-times"></i></button>
            </li>
        `;
      });
      html += '</ul>';
      watchlistDiv.innerHTML = html;

      // Add event listeners for remove buttons
      watchlistDiv.querySelectorAll('.remove-key-asset-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
          const indexToRemove = parseInt(e.currentTarget.dataset.index, 10);
          userDefinedKeyAssets.splice(indexToRemove, 1);
          renderModalKeyAssetsWatchlist(); // Re-render list in modal
          renderKeyAssetAvailability();    // Re-render main overview display

        });
      });
    }
    function populateKeyAssetConfigDropdowns() {
      const typeSelect = document.getElementById('key-asset-select-type');
      const classnameSelect = document.getElementById('key-asset-select-classname');
      if (!typeSelect || !classnameSelect) return;

      const uniqueTypes = [...new Set(unitData.map(u => u.unitType).filter(Boolean))].sort();
      typeSelect.innerHTML = '<option value="">-- Select Type --</option>' +
        uniqueTypes.map(t => `<option value="${t}">${t}</option>`).join('');

      typeSelect.addEventListener('change', () => {
        const selectedType = typeSelect.value;
        classnameSelect.innerHTML = '<option value="">-- Any Class of Selected Type --</option>';
        if (selectedType) {
          const uniqueClassnamesForType = [...new Set(
            unitData.filter(u => u.unitType === selectedType).map(u => u.classname).filter(Boolean)
          )].sort();
          classnameSelect.innerHTML += uniqueClassnamesForType.map(cn => `<option value="${cn}">${cn}</option>`).join('');
        }
      });
    }

    function renderCurrentKeyAssetsWatchlist() {
      const watchlistDiv = document.getElementById('current-key-assets-watchlist');
      if (!watchlistDiv) return;
      if (userDefinedKeyAssets.length === 0) {
        watchlistDiv.innerHTML = '<p class="text-muted-color small">No assets currently on watchlist.</p>';
        return;
      }
      let html = '<ul class="list-unstyled mb-0">';
      userDefinedKeyAssets.forEach((asset, index) => {
        html += `
            <li class="d-flex justify-content-between align-items-center mb-1">
                <small><i class="fas ${asset.icon || 'fa-cube'} me-1"></i> ${asset.type}${asset.classname ? ` / ${truncate(asset.classname, 25)}` : ''}</small>
                <button class="btn btn-xs btn-danger remove-key-asset-btn" data-index="${index}" title="Remove"><i class="fas fa-times"></i></button>
            </li>
        `;
      });
      html += '</ul>';
      watchlistDiv.innerHTML = html;

      // Add event listeners for remove buttons
      watchlistDiv.querySelectorAll('.remove-key-asset-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
          const indexToRemove = parseInt(e.currentTarget.dataset.index, 10);
          userDefinedKeyAssets.splice(indexToRemove, 1);
          renderCurrentKeyAssetsWatchlist();
          renderKeyAssetAvailability(); // Re-render the availability display
          // Here you would also "send" the updated userDefinedKeyAssets array to your app/backend
          if (window.chrome) {
            const jsonAssets = JSON.stringify(userDefinedKeyAssets);
            window.chrome.webview.postMessage(`DIALOG_OKUserDefinedKeyAssets('${jsonAssets}')`);
          }
        });
      });
    }
    function renderKeyAssetAvailability() {
      const contentDiv = document.getElementById('key-asset-availability-content');
      if (!contentDiv) return;

      if (userDefinedKeyAssets.length === 0) {
        contentDiv.innerHTML = `<p class="text-center text-muted-color col-12">No key assets configured. Click 'Configure' to add assets to the watchlist.</p>`;
        return;
      }

      const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
      const relevantUnits = unitData.filter(u => showNCU || (u.NCU !== "true" && u.NCU !== true));
      let html = "";

      userDefinedKeyAssets.forEach(assetWatch => {
        let assetsToList;
        if (assetWatch.watchType === "classname") {
          assetsToList = relevantUnits.filter(u =>
            u.unitType === assetWatch.type &&
            u.classname === assetWatch.classname // Exact match for classname watch
          );
        } else { // specific_unit
          assetsToList = relevantUnits.filter(u => u.id === assetWatch.unitId);
        }

        let total = assetsToList.length;
        let ready = 0;
        let tasked = 0;

        assetsToList.forEach(unit => {
          const issues = unit.criticalIssues; // Assuming this function is defined elsewhere
          const isCriticallyDown = issues.some(iss => iss.severity === 3);

          if (!isCriticallyDown) {
            if (unit.unitType === "Aircraft") {
              if (unit.condition === "Parked" && unit.loadout_role !== 9002 && unit.loadout_role !== "9002" && unit.loadout_role !== 9003 && unit.loadout_role !== "9003") {
                ready++;
              }
            } else if (unit.unitType === "Ship") {
              if (unit.condition === "Underway") {
                ready++;
              }
            } else {
              if (unit.condition !== "Out of Action" && unit.condition !== "Damaged") { // Simplified for others
                ready++;
              }
            }
          }
          if (unit.mission && unit.mission.trim() !== "") {
            tasked++;
          }
        });
        const available = ready - tasked > 0 ? ready - tasked : 0;

        html += `
            <div class="col-xl-2 col-lg-3 col-md-4 col-sm-6 mb-3"> 
                <h6 class="asset-title mb-1" style="font-size: 0.9em;" title="${assetWatch.displayName} (${assetWatch.type})">
                    <i class="fas ${assetWatch.icon || DEFAULT_ASSET_ICONS[assetWatch.type] || 'fa-cube'} me-1 text-muted-color"></i>${truncate(assetWatch.displayName, 15)}
                </h6>
                <p class="asset-stat mb-0">Total: <span class="fw-bold">${total}</span></p>
                <p class="asset-stat mb-0">Ready: <span class="fw-bold text-success">${ready}</span></p>
                <p class="asset-stat mb-0">Tasked: <span class="fw-bold text-warning">${tasked}</span></p>
                <p class="asset-stat mb-0">Available: <span class="fw-bold text-info">${available}</span></p>
            </div>
        `;
      });

      if (html === "") {
        contentDiv.innerHTML = `<p class="text-center text-muted-color col-12">No units match the configured key assets watchlist or data is loading.</p>`;
      } else {
        contentDiv.innerHTML = html;
      }
    }


    function renderKeyAssetAvailability() {
      const contentDiv = document.getElementById('key-asset-availability-content');
      if (!contentDiv) return;

      if (!userDefinedKeyAssets || userDefinedKeyAssets.length === 0) {
        contentDiv.innerHTML = `<p class="text-center text-muted-color col-12">No key assets configured. Click 'Configure' to add assets to the watchlist.</p>`;
        return;
      }

      const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
      const relevantUnitsGlobal = unitData.filter(u => showNCU || (u.NCU !== "true" && u.NCU !== true));
      let html = "";

      userDefinedKeyAssets.forEach(assetWatch => {
        let cardHtml = '';
        const titleIcon = assetWatch.icon || DEFAULT_ASSET_ICONS[assetWatch.type] || 'fa-cube';

        if (assetWatch.watchType === "classname") {
          const assetsToList = relevantUnitsGlobal.filter(u =>
            u.unitType === assetWatch.type &&
            u.classname === assetWatch.classname
          );

          let total = assetsToList.length;
          let readyCount = 0;
          let taskedCount = 0;
          let criticalIssuesCount = 0;
          let operationalForAvg = 0;
          let totalIntegrityForAvg = 0;
          let totalFuelForAvg = 0;

          assetsToList.forEach(unit => {
            
            const operationalStatus = unit.operationalStatus
            const issues = unit.criticalIssues;
            const hasSignificantIssue = issues.some(iss => iss.severity >= 2); // e.g. Mod/Severe Damage, Crit Fuel

            if (hasSignificantIssue) {
              criticalIssuesCount++;
            }

            // Determine readiness based on operationalStatus, excluding those with significant issues from "Ready" count for this summary
            if (operationalStatus === "Ready" && !hasSignificantIssue) {
              readyCount++;
            }
            if (operationalStatus === "Ongoing/Airborne" || operationalStatus === "Operational" || operationalStatus === "Readying") {
              // Count these as potentially operational for averages if not severely damaged
              if (!issues.some(iss => iss.severity === 3)) { // Exclude severely damaged from avg
                operationalForAvg++;
                totalIntegrityForAvg += (100 - (parseFloat(unit.damage?.dp_percent_now) || 0));
                if (unit.fuel_status && unit.fuel_status.endsWith('%%')) {
                  totalFuelForAvg += parseFloat(unit.fuel_status);
                }
              }
            }

            if (unit.mission && unit.mission.trim() !== "") {
              taskedCount++;
            }
          });

          const availableCount = readyCount - taskedCount > 0 ? readyCount - taskedCount : 0;
          const avgIntegrity = operationalForAvg > 0 ? (totalIntegrityForAvg / operationalForAvg).toFixed(0) : 'N/A';
          const avgFuel = operationalForAvg > 0 ? (totalFuelForAvg / operationalForAvg).toFixed(0) : 'N/A';

          cardHtml = `
                    <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 mb-1 key-asset-card"> 
                        <div class="info-card h-100"> 
                            <div class="info-card-header asset-title-clickable"
                                data-watchtype="${assetWatch.watchType}"
                                data-classname="${assetWatch.classname}"
                                title="View all ${assetWatch.displayName} units">
                                <h6 class="asset-title mb-0" style="cursor:pointer; text-decoration:underline;">
                                    <i class="fas ${titleIcon} me-1 text-muted-color"></i>${truncate(assetWatch.displayName, 20)}
                                    <span class="badge bg-primary float-end">${total} Total</span>
                                </h6>
                            </div>
                            <div class="info-card-content p-2 asset-stats-area">
                                <p class="asset-stat"><i class="fas fa-check-circle text-success me-1"></i>Ready: <span class="fw-bold">${readyCount}</span></p>
                                <p class="asset-stat"><i class="fas fa-bullseye text-warning me-1"></i>Tasked: <span class="fw-bold">${taskedCount}</span></p>
                                <p class="asset-stat"><i class="fas fa-plane-departure text-info me-1"></i>Available: <span class="fw-bold">${availableCount}</span></p>
                                <hr class="my-1">
                                <p class="asset-stat"><i class="fas fa-shield-alt text-secondary me-1"></i>Avg. Integrity: <span class="fw-bold">${avgIntegrity}%%</span></p>
                                <p class="asset-stat"><i class="fas fa-gas-pump text-secondary me-1"></i>Avg. Fuel: <span class="fw-bold">${avgFuel}%%</span></p>
                                ${criticalIssuesCount > 0 ? `
                                    <p class="asset-stat asset-critical-clickable"
                                      data-watchtype="${assetWatch.watchType}"
                                      data-classname="${assetWatch.classname}"
                                      title="View critical ${assetWatch.displayName} units">
                                      <i class="fas fa-exclamation-triangle text-danger me-1"></i>Critical Issues: <span class="fw-bold">${criticalIssuesCount}</span>
                                    </p>
                                ` : '<p class="asset-stat"><i class="fas fa-heartbeat text-success me-1"></i>No Critical Issues</p>'}
                            </div>
                        </div>
                    </div>
                `;

        } else { // specific_unit
          const unit = relevantUnitsGlobal.find(u => u.id === assetWatch.unitId); // Find the specific unit
          if (unit) {
            const operationalStatus = unit.operationalStatus;
            const issues = unit.criticalIssues;
            const integrity = 100 - (parseFloat(unit.damage?.dp_percent_now) || 0);
            const fuel = parseFloat(unit.fuel_status) || 0;
            const fuelColor = getFuelColorClass(unit.fuel_status); // Your existing fuel color function
            const isTasked = unit.mission && unit.mission.trim() !== "";

            let statusBadgeClass = 'secondary'; // Default
            if (operationalStatus === "Ready") statusBadgeClass = 'success';
            else if (operationalStatus === "Ongoing/Airborne" || operationalStatus === "Operational") statusBadgeClass = 'primary';
            else if (operationalStatus === "Readying") statusBadgeClass = 'warning text-dark';
            else if (operationalStatus === "Unavailable" || operationalStatus === "Reserve") statusBadgeClass = 'dark';
            else if (operationalStatus === "Significant Issues") statusBadgeClass = 'danger';
            else if (operationalStatus === "Minor Issues") statusBadgeClass = 'info text-dark';


            cardHtml = `
                        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 mb-1 key-asset-card">
                            <div class="info-card h-100">
                                <div class="info-card-header asset-title-clickable"
                                    data-watchtype="${assetWatch.watchType}"
                                    data-unitid="${unit.id}" 
                                    data-unitname="${unit.name}"
                                    title="View details for ${unit.name}">
                                    <h6 class="asset-title mb-0" style="cursor:pointer; text-decoration:underline;">
                                        <i class="fas ${titleIcon} me-1 text-muted-color"></i>${truncate(assetWatch.displayName, 20)}
                                        <span class="badge bg-${statusBadgeClass} float-end">${operationalStatus}</span>
                                    </h6>
                                </div>
                                <div class="info-card-content p-2 asset-stats-area">
                                    <p class="asset-stat"><i class="fas fa-heartbeat me-1 ${integrity < 70 ? (integrity < 30 ? 'text-danger' : 'text-warning') : 'text-success'}"></i>Integrity: <span class="fw-bold">${integrity.toFixed(0)}%%</span></p>
                                    <p class="asset-stat"><i class="fas fa-gas-pump me-1 ${fuelColor}"></i>Fuel: <span class="fw-bold">${fuel.toFixed(0)}%%</span></p>
                                    ${isTasked ? `
                                        <p class="asset-stat asset-mission-clickable" data-mission-name="${unit.mission}" title="View mission ${unit.mission}">
                                          <i class="fas fa-bullseye text-info me-1"></i>Tasked: <span class="fw-bold">${truncate(unit.mission, 15)}</span>
                                        </p>
                                    ` : `
                                        <p class="asset-stat"><i class="fas fa-coffee text-secondary me-1"></i>Status: Idle</p>
                                    `}
                                    ${issues.length > 0 ? `
                                        <p class="asset-stat text-danger" title="${issues.map(iss => iss.text).join(', ')}">
                                          <i class="fas fa-exclamation-circle me-1"></i>${issues.length} Issue(s)
                                        </p>
                                    ` : ''}
                                </div>
                            </div>
                        </div>
                    `;
          } else {
            // Unit not found in relevantUnits (e.g., filtered out by NCU)
            cardHtml = `
                        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12 mb-1 key-asset-card">
                            <div class="info-card h-100">
                                <div class="info-card-header">
                                    <h6 class="asset-title mb-0 text-muted-color">
                                        <i class="fas ${titleIcon} me-1"></i>${truncate(assetWatch.displayName, 20)} (Not found)
                                    </h6>
                                </div>
                                <div class="info-card-content p-2 asset-stats-area">
                                    <p class="asset-stat text-muted-color">Unit may be filtered (e.g., NCU) or data unavailable.</p>
                                </div>
                            </div>
                        </div>`;
          }
        }
        html += cardHtml;
      });

      if (html === "") {
        contentDiv.innerHTML = `<p class="text-center text-muted-color col-12">No units match the configured key assets watchlist or data is loading.</p>`;
      } else {
        contentDiv.innerHTML = html; // This is a .row element
      }

      // Add event listeners AFTER content is in the DOM
      contentDiv.querySelectorAll('.asset-title-clickable').forEach(titleEl => {
        titleEl.addEventListener('click', handleKeyAssetTitleClick);
      });
      contentDiv.querySelectorAll('.asset-critical-clickable').forEach(criticalEl => {
        criticalEl.addEventListener('click', handleKeyAssetCriticalClick);
      });
      contentDiv.querySelectorAll('.asset-mission-clickable').forEach(missionEl => {
        missionEl.addEventListener('click', handleKeyAssetMissionClick);
      });
    }

    // --- New Event Handlers for Key Asset Card Clicks ---
    function handleKeyAssetTitleClick(event) {
      const target = event.currentTarget;
      const watchType = target.dataset.watchtype;
      let searchTerm = '';

      if (watchType === "classname") {
        searchTerm = target.dataset.classname;
      } else { // specific_unit
        searchTerm = target.dataset.unitname; // Search by name for user readability
        // Could also use target.dataset.unitid or dbid if you want to filter by that directly
      }

      // Clear existing unit filters (except NCU and Hide Unavailable/Reserve)
      const ncuState = document.getElementById('unit-ncu-filter').checked;
      const hideUnavailableState = document.getElementById('unit-hide-unavailable-filter').checked;

      document.getElementById('unit-search').value = searchTerm;
      document.getElementById('unit-type-filter').value = '';
      // ... reset other dropdowns ...
      document.getElementById('unit-mission-filter').value = '';
      document.getElementById('unit-base-filter').value = '';
      document.getElementById('unit-mission-mtype-filter').value = '';
      document.getElementById('unit-status-filter').value = '';
      document.getElementById('unit-loadout-role-filter').value = '';


      currentUnitFilters = {
        search: searchTerm,
        type: '', mission: '', base: '', missionMType: '', condition: '', loadoutRole: '',
        showNCU: ncuState,
        operationalStatus: '',
        hideUnavailableReserve: hideUnavailableState,
        showOnlyCritical: false // Ensure this is reset
      };
      uiState.isUnitsTableDirty = true;
      switchView('units'); // This will trigger renderUnitsTable
      // The input event dispatch might not be necessary if renderUnitsTable correctly reads currentUnitFilters.search
      // document.getElementById('unit-search').dispatchEvent(new Event('input', { bubbles: true }));
    }

    function handleKeyAssetCriticalClick(event) {
      const target = event.currentTarget;
      const classname = target.dataset.classname; // Assumes this is always by classname

      if (!classname) return;

      // Clear existing unit filters (except NCU and Hide Unavailable/Reserve)
      const ncuState = document.getElementById('unit-ncu-filter').checked;
      const hideUnavailableState = document.getElementById('unit-hide-unavailable-filter').checked;

      document.getElementById('unit-search').value = classname; // Pre-fill search with classname
      // ... reset other dropdowns ...
      document.getElementById('unit-type-filter').value = '';
      document.getElementById('unit-mission-filter').value = '';
      document.getElementById('unit-base-filter').value = '';
      document.getElementById('unit-mission-mtype-filter').value = '';
      document.getElementById('unit-status-filter').value = '';
      document.getElementById('unit-loadout-role-filter').value = '';


      currentUnitFilters = {
        search: classname, // Filter by classname
        type: '', mission: '', base: '', missionMType: '', condition: '', loadoutRole: '', operationalStatus: '',
        showNCU: ncuState,
        hideUnavailableReserve: hideUnavailableState,
        showOnlyCritical: true // <<<< SET CRITICAL FILTER
      };
      uiState.isUnitsTableDirty = true;
      switchView('units');
    }
    function handleKeyAssetMissionClick(event) {
      const target = event.currentTarget;
      const missionName = target.dataset.missionName;

      if (!missionName) return;

      // Clear mission filters
      document.getElementById('mission-search-input').value = missionName;
      document.getElementById('mission-filter-taskpool').value = '';
      document.getElementById('mission-filter-mtype').value = '';
      document.getElementById('mission-filter-mtag').value = '';
      document.getElementById('mission-filter-msubtype').value = '';

      currentMissionFilters = {
        search: '',
        taskPool: '',
        mType: '',
        mTag: '',
        mSubtype: '',
        // status: '', // If you have a dropdown for raw mission status
        mStatus: '' // NEW: For filtering by the chart's clicked status
      };

      switchView('missions');
      // Ensure the mission list tab is active if it wasn't
      const missionListTabBtn = document.querySelector('.inner-tab-button[data-bs-target="#mission-list-view-pane"][data-tab-group="missions"]');
      if (missionListTabBtn && !missionListTabBtn.classList.contains('active')) {
        switchInnerTab('#mission-list-view-pane', 'missions', missionListTabBtn);
      } else {
        // If already on list view, or switchInnerTab handles it, just render
        uiState.isWeaponsTableDirty = true;
        renderMissionsTable(); // Or dispatch event on search input
      }
      // document.getElementById('mission-search-input').dispatchEvent(new Event('input', { bubbles: true }));
    }

    function setupKeyAssetConfigurationListeners() {
      const configureBtn = document.getElementById('configure-key-assets-btn');
      const configSection = document.getElementById('key-asset-config-section');
      const addAssetBtn = document.getElementById('add-key-asset-btn');
      const typeSelect = document.getElementById('key-asset-select-type');
      const classnameSelect = document.getElementById('key-asset-select-classname');

      if (configureBtn && configSection) {
        configureBtn.addEventListener('click', () => {
          const isVisible = configSection.style.display !== 'none';
          configSection.style.display = isVisible ? 'none' : 'block';
          if (!isVisible) { // If opening, populate dropdowns
            populateKeyAssetConfigDropdowns();
            renderCurrentKeyAssetsWatchlist();
          }
        });
      }

      if (addAssetBtn && typeSelect && classnameSelect) {
        addAssetBtn.addEventListener('click', () => {
          const selectedType = typeSelect.value;
          const selectedClassname = classnameSelect.value; // Might be empty

          if (!selectedType) {
            alert("Please select a Unit Type.");
            return;
          }

          // Prevent duplicates (simple check based on type and classname)
          const alreadyExists = userDefinedKeyAssets.some(asset =>
            asset.type === selectedType && (asset.classname || "") === selectedClassname
          );
          if (alreadyExists) {
            alert("This asset configuration is already on the watchlist.");
            return;
          }

          userDefinedKeyAssets.push({
            type: selectedType,
            classname: selectedClassname || null, // Store null if "Any Class"
            icon: DEFAULT_ASSET_ICONS[selectedType] || 'fa-question-circle' // Default icon
          });

          renderCurrentKeyAssetsWatchlist();
          renderKeyAssetAvailability(); // Re-render the display
          // Here you would "send" the updated userDefinedKeyAssets array to your app/backend
          console.debug("Updated Key Assets Watchlist:", JSON.stringify(userDefinedKeyAssets));
          if (window.chrome) {
            const jsonAssets = JSON.stringify(userDefinedKeyAssets);
            window.chrome.webview.postMessage(`DIALOG_OKUserDefinedKeyAssets('${jsonAssets}')`);
          }
        });
      }
    }
    function updateForceHealthSummaryDisplay() {
      const operationalUnitsEl = document.getElementById('operational-units-count');
      const totalRelevantUnitsEl = document.getElementById('total-relevant-units-count');
      const criticalUnitsEl = document.getElementById('critical-units-count');

      const summaryContainer = document.getElementById('force-health-summary');

      if (!operationalUnitsEl || !totalRelevantUnitsEl || !criticalUnitsEl || !summaryContainer) {
        console.error("Force health summary elements not found. Please check HTML IDs.");
        return;
      }

      // --- Data Calculation (No changes needed here) ---
      const relevantUnits = unitData.filter(u => {
        const roleId = u.unitType === 'Aircraft' ? parseInt(u.loadout_role, 10) : null;
        return roleId !== 9003 && (u.NCU !== "true" && u.NCU !== true);
      });
      const totalRelevantUnitsCount = relevantUnits.length;

      let inCommsUnitsCount = 0;
      relevantUnits.forEach(u => {
        if (u.isOutOfComms !== true) {
          inCommsUnitsCount++;
        }
      });

      const criticalUnitIds = new Set();
      relevantUnits.forEach(u => {
        let isUnitCritical = false;
        if (u.isOutOfComms === true) { isUnitCritical = true; }
        if (u.operationalStatus === "Significant Issues") { isUnitCritical = true; }
        if (isUnitCritical) { criticalUnitIds.add(u.id); }
      });
      const criticalUnitsCount = criticalUnitIds.size;


      // --- Update UI (Now much simpler) ---
      operationalUnitsEl.textContent = inCommsUnitsCount.toLocaleString();
      totalRelevantUnitsEl.textContent = totalRelevantUnitsCount.toLocaleString();
      criticalUnitsEl.textContent = criticalUnitsCount.toLocaleString();

      // THE FIX: Directly update the text of our new span


      // --- Styling and Tooltip Logic (No changes needed here) ---
      const inCommsPercentage = totalRelevantUnitsCount > 0 ? (inCommsUnitsCount / totalRelevantUnitsCount) * 100 : 100;
      let inCommsColor = "var(--success-color)";
      if (inCommsPercentage < 60) {
        inCommsColor = "var(--danger-color)";
      } else if (inCommsPercentage < 80) {
        inCommsColor = "var(--warning-color)";
      }
      operationalUnitsEl.style.color = inCommsColor;

      const outOfCommsCount = totalRelevantUnitsCount - inCommsUnitsCount;
      summaryContainer.title =
        `${inCommsUnitsCount} of ${totalRelevantUnitsCount} units are in communication.\n` +
        `${outOfCommsCount} units are out of communication.\n` +
        `${criticalUnitsCount} units have critical issues (incl. comms issues).\n` +
        `Click to view details.`;

      // --- Event Listener Handling (No changes needed here) ---
      const newSummaryContainer = summaryContainer.cloneNode(true);
      summaryContainer.parentNode.replaceChild(newSummaryContainer, summaryContainer);

      newSummaryContainer.addEventListener('click', () => {
        clearUnitFiltersAndRender();
        if (criticalUnitsCount > 0) {
          if (outOfCommsCount > 0 && criticalUnitIds.size === outOfCommsCount) { // All critical are due to comms
            currentUnitFilters.filterOutOfComms = true;
          } else { // Some criticals are non-comms related or mixed
            currentUnitFilters.showOnlyCritical = true; // General critical filter
            // If you want to show OutOfComms AND other criticals, you might need two filters
            // or a more complex 'operationalStatus' that renderUnitsTable can interpret.
            // For now, showOnlyCritical is a good general approach.
          }
        } else if (outOfCommsCount > 0) {
          currentUnitFilters.filterOutOfComms = true;
        }
        switchView('units');
      });
    }
    /**
     * A centralized function to clear existing unit filters, apply a new set of filters,
     * and switch to the Units view.
     * @param {object} newFilters - An object containing the filter keys and values to apply.
     *        Example: { operationalStatus: 'Ready' } or { showOnlyCritical: true, search: 'F-22' }
     */
    function applyFiltersAndSwitchToUnits(newFilters = {}) {
        if (!savedManualUnitFilters) {
            savedManualUnitFilters = JSON.parse(JSON.stringify(currentUnitFilters));
            console.debug("Saved manual filters:", JSON.stringify(savedManualUnitFilters));
        }
        // 1. Get the state of UI elements that should persist across filter changes.
        const ncuState = document.getElementById('unit-ncu-filter').checked;
        
        // Determine the state of the 'hide' filter based on the new filters being applied.
        const shouldHide = (newFilters.operationalStatus !== 'Unavailable' && newFilters.operationalStatus !== 'Reserve');
        updateHideUnavailableFilter(shouldHide); // Use our existing helper for this

        // 2. Clear the UI inputs for all other filters.
        document.getElementById('unit-search').value = '';
        document.getElementById('unit-type-filter').value = '';
        document.getElementById('unit-mission-filter').value = '';
        document.getElementById('unit-base-filter').value = '';
        document.getElementById('unit-mission-mtype-filter').value = '';
        document.getElementById('unit-status-filter').value = '';
        document.getElementById('unit-loadout-role-filter').value = '';

        // 3. Reset the global filter state and merge in the new filters.
        const defaultFilters = {
            search: '', type: '', mission: '', base: '', missionMType: '',
            condition: '', loadoutRole: '', operationalStatus: '', showOnlyCritical: false
        };
        
        currentUnitFilters = {
            ...defaultFilters,
            showNCU: ncuState,
            hideUnavailableReserve: shouldHide,
            ...newFilters // Apply the new filters passed to the function
        };
        
        console.debug("Applied new filters:", JSON.stringify(currentUnitFilters));

        // 4. Mark the table as dirty and switch view.
        uiState.isUnitsTableDirty = true;
        switchView('units');
    }
    // --- Functions to render new overview charts ---
    function renderOverviewUnitReadinessChart() {
        const ctx = document.getElementById('overviewUnitReadinessChart')?.getContext('2d');
        if (!ctx) return;

        // --- 1. DATA AGGREGATION (Simplified) ---
        const showNCU = document.getElementById('unit-ncu-filter')?.checked || false;
        const relevantUnits = unitData.filter(u => showNCU || (u.NCU !== "true" && u.NCU !== true));

        // Use a Map for efficient counting.
        const readinessCounts = new Map();

        for (const unit of relevantUnits) {
            // We read the pre-calculated status directly. No more complex logic!
            const status = unit.operationalStatus || 'Other/Unknown';
            readinessCounts.set(status, (readinessCounts.get(status) || 0) + 1);
        }

        // --- 2. CHART DATA PREPARATION ---
        // Define the desired order and colors for the chart. This ensures consistency.
        const orderedStatuses = [
            "Operational", "Ready", "Ongoing/Airborne", "Minor Issues", "Readying",
            "Significant Issues", "Unavailable", "Reserve", "Other/Unknown"
        ];

        const statusColors = {
            "Operational": "#20c997", "Ready": "#50C878", "Ongoing/Airborne": "#0dcaf0",
            "Minor Issues": "#ffda6a", "Readying": "#ffc107", "Significant Issues": "#fd7e14",
            "Unavailable": "#dc3545", "Reserve": "#6c757d", "Other/Unknown": "#495057"
        };

        const chartLabels = [];
        const chartData = [];
        const backgroundColors = [];

        // Iterate in our desired order to build the chart data arrays.
        // This ensures the legend and colors are always consistent.
        for (const status of orderedStatuses) {
            if (readinessCounts.has(status)) {
                chartLabels.push(status);
                chartData.push(readinessCounts.get(status));
                backgroundColors.push(statusColors[status]);
            }
        }

        // --- 3. CHART RENDERING ---
        if (overviewUnitReadinessChartInstance) {
            overviewUnitReadinessChartInstance.destroy();
        }

        if (chartLabels.length === 0) {
            // ... (no data message logic remains the same) ...
            return;
        }

        overviewUnitReadinessChartInstance = new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: chartLabels,
                datasets: [{
                    data: chartData,
                    backgroundColor: backgroundColors,
                    borderColor: getComputedStyle(document.documentElement).getPropertyValue('--panel-bg').trim(),
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                // --- The onClick handler is now much cleaner ---
                onClick: (event, elements) => {
                    if (elements.length > 0) {
                        const clickedLabel = chartLabels[elements[0].index];
                        
                        // Centralize all filter-setting logic in a new, clean function.
                        applyFiltersAndSwitchToUnits({ operationalStatus: clickedLabel });
                    }
                },
                plugins: {
                    legend: { position: 'right', labels: { color: Chart.defaults.color } },
                    tooltip: { callbacks: { label: chartCtx => `${chartCtx.label}: ${chartCtx.raw.toLocaleString()}` } }
                }
            }
        });
    }

    function renderOverviewMissionStatusChart() {
      const ctx = document.getElementById('overviewMissionStatusChart')?.getContext('2d');
      if (!ctx) return;

      const allMissions = getAllMissionsArray(missionData); // Assumes this returns array of mission objects

      // Initialize counts for all expected statuses
      const missionStatusCounts = {
        "PLANNED": 0,
        "ACTIVE": 0,
        "COMPLETED": 0,
        // Add other statuses if your mission.calculatedStatus can have them
        "INACTIVE": 0, // Example if you have this status
        // "ISSUE": 0,   // Example
      };

      allMissions.forEach(missionEntry => {
        const status = missionEntry.calculatedStatus; // Use the pre-calculated status

        if (missionStatusCounts.hasOwnProperty(status)) {
          missionStatusCounts[status]++;
        } else {
          // Handle unexpected statuses if necessary, or ignore
          console.warn(`Unexpected mission status encountered: ${status} for mission ${missionEntry.name}`);
          // Optionally, you could have an "Other" category:
          // missionStatusCounts["Other"] = (missionStatusCounts["Other"] || 0) + 1;
        }
      });

      // Filter out statuses with 0 counts for a cleaner chart
      const chartLabels = Object.keys(missionStatusCounts).filter(key => missionStatusCounts[key] > 0);
      const chartData = chartLabels.map(key => missionStatusCounts[key]);

      // Define colors for your statuses
      const statusColors = {
        "PLANNED": "#0dcaf0",   // Bootstrap Info (light blue)
        "ACTIVE": "#198754",    // Bootstrap Success (green)
        "COMPLETED": "#6c757d", // Bootstrap Secondary (grey)
        "INACTIVE": "#adb5bd",  // Lighter grey
        "ISSUE": "#ffc107",     // Bootstrap Warning (yellow)
        // Add more as needed
      };
      const backgroundColors = chartLabels.map(label => statusColors[label] || '#adb5bd'); // Fallback color


      if (overviewMissionStatusChartInstance) overviewMissionStatusChartInstance.destroy();

      if (chartLabels.length === 0) {
        ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height);
        ctx.textAlign = 'center';
        ctx.fillStyle = getComputedStyle(document.documentElement).getPropertyValue('--text-muted-color').trim();
        ctx.fillText("No mission status data to display.", ctx.canvas.width / 2, ctx.canvas.height / 2);
        return;
      }

      overviewMissionStatusChartInstance = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: chartLabels,
          datasets: [{
            label: 'Mission Status', // This label is for the dataset, not individual bars
            data: chartData,
            backgroundColor: backgroundColors,
            borderColor: backgroundColors.map(color => Chart.helpers.color(color).darken(0.2).rgbString()), // Slightly darker border
            borderWidth: 1
          }]
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          indexAxis: 'y', // Optional: makes it a horizontal bar chart if preferred
          onClick: (event, elements) => {
            if (elements.length > 0) {
              const clickedElementIndex = elements[0].index;
              const clickedStatusLabel = overviewMissionStatusChartInstance.data.labels[clickedElementIndex];

              console.debug("Mission Status Chart clicked. Status Label:", clickedStatusLabel);

              // Clear other mission filters and apply the new one
              document.getElementById('mission-search-input').value = '';
              document.getElementById('mission-filter-taskpool').value = '';
              document.getElementById('mission-filter-mtype').value = '';
              document.getElementById('mission-filter-mtag').value = '';
              document.getElementById('mission-filter-msubtype').value = '';
              // If you had a raw status dropdown:
              // document.getElementById('mission-filter-status').value = '';
              currentMissionFilters = {
                search: '',
                taskPool: '',
                mType: '',
                mTag: '',
                mSubtype: '',
                mStatus: clickedStatusLabel // SET THE CLICKED STATUS
              };

              switchView('missions'); // Switch to missions view
              // renderMissionsTable() will be called by switchView or by filter change events (if any)
              // To be safe, ensure renderMissionsTable is called after this if switchView doesn't always do it.
              // setTimeout(renderMissionsTable, 50); // Or directly if no race conditions
            }
          },
          scales: {
            y: {
              beginAtZero: true,
              ticks: { color: Chart.defaults.color } // Removed stepSize for bar chart y-axis (categories)
            },
            x: { // For bar chart, x is the value axis
              beginAtZero: true,
              ticks: {
                color: Chart.defaults.color,
                precision: 0 // Ensure whole numbers for counts
              }
            }
          },
          plugins: {
            legend: { display: false }, // Legend usually not needed for single dataset bar chart
            tooltip: {
              callbacks: {
                label: function (context) {
                  // context.label is the status (e.g., "PLANNED")
                  // context.raw is the count
                  return `${context.label}: ${context.raw.toLocaleString()}`;
                }
              }
            }
          }
        }
      });
    }
    /**
     * Updates all the filter UI elements (dropdowns, inputs, checkboxes)
     * to match the values in a given filter state object.
     * @param {object} filterState - A unit filter state object (e.g., currentUnitFilters).
     */
    function updateFilterUIFromState(filterState) {
        document.getElementById('unit-search').value = filterState.search || '';
        document.getElementById('unit-type-filter').value = filterState.type || '';
        document.getElementById('unit-mission-filter').value = filterState.mission || '';
        document.getElementById('unit-base-filter').value = filterState.base || '';
        document.getElementById('unit-mission-mtype-filter').value = filterState.missionMType || '';
        document.getElementById('unit-status-filter').value = filterState.condition || '';
        document.getElementById('unit-loadout-role-filter').value = filterState.loadoutRole || '';
        
        // Checkboxes
        const ncuCheckbox = document.getElementById('unit-ncu-filter');
        if (ncuCheckbox) ncuCheckbox.checked = filterState.showNCU || false;

        const hideCheckbox = document.getElementById('unit-hide-unavailable-filter');
        if (hideCheckbox) hideCheckbox.checked = filterState.hideUnavailableReserve === undefined ? true : filterState.hideUnavailableReserve;
    }
    // --- General UI Logic ---
    function switchView(viewId) {
      const currentView = document.querySelector('.view-content.active');
      const currentViewId = currentView ? currentView.id.replace('-view', '') : '';
      
      console.debug(currentViewId)
      if (currentViewId && currentViewId !== viewId) {
          if (currentViewId === 'units') {
              leaveUnitsView();
          }
          
      }
      document.querySelectorAll('.view-content').forEach(view => view.classList.remove('active'));
      document.getElementById(`${viewId}-view`).classList.add('active');

      document.querySelectorAll('.main-view-tab-button').forEach(link => link.classList.remove('active'));
      document.querySelector(`.main-view-tab-button[data-view="${viewId}"]`).classList.add('active');

      // Show/hide filter bars based on the main view.
      // Mission filter bar is handled by inner tab logic.
      document.querySelectorAll('.filter-bar-container').forEach(fb => {
        if (fb.id !== 'missions-filter-bar') fb.style.display = 'none';
      });
      const activeMainFilterBar = document.getElementById(`${viewId}-filter-bar`);
      if (activeMainFilterBar && activeMainFilterBar.id !== 'missions-filter-bar') { // Don't show missions filter bar here
        activeMainFilterBar.style.display = 'flex';
      }
      
      if (viewId === 'overview') renderOverview();

      if (viewId === 'units') {
        enterUnitsView();
      }
      if (viewId === 'missions') {
        if (uiState.isMissionsTableDirty) {
          populateMissionFilters(getAllMissionsArray(missionData));
          // Default to list view when switching to Missions main view
          const missionListPane = document.getElementById('mission-list-view-pane');
          const missionSchedulePane = document.getElementById('mission-schedule-view-pane');
          const missionListTabBtn = document.querySelector('.inner-tab-button[data-bs-target="#mission-list-view-pane"]');
          const missionScheduleTabBtn = document.querySelector('.inner-tab-button[data-bs-target="#mission-schedule-view-pane"]');

          // Check which tab is currently marked active or default to list
          if (missionSchedulePane.classList.contains('active')) {
            if (!missionScheduleInitialized) initializeMissionScheduleView(); else schedule_updateFullTimeline();
            document.getElementById('missions-filter-bar').style.display = 'none';
          } else {
            missionListPane.classList.add('active');
            missionSchedulePane.classList.remove('active');
            missionListTabBtn.classList.add('active');
            missionScheduleTabBtn.classList.remove('active');
            uiState.isWeaponsTableDirty = true;
            renderMissionsTable();
            document.getElementById('missions-filter-bar').style.display = 'flex';
          }
        }
      }
      if (viewId === 'weapons') {
        if (uiState.isWeaponsTableDirty) {
          if (!weaponsTableColumnVisibility['name']) {
            setupColumnToggler('weapons-table', weaponsTableColumnVisibility, 'weapons-column-toggler-menu');
          }
          populateWeaponFilters(); // Populates filters for the table view
          uiState.isWeaponsTableDirty = true;
          renderWeaponsTable();   // Renders the table view by default

          // Check which tab is active within weapons view
          const weaponsMapPane = document.getElementById('weapon-map-view-pane');
          const weaponTablePane = document.getElementById('weapon-table-view-pane'); // Added

          // If map tab happens to be active (e.g. from previous state or if you change default)
          if (weaponsMapPane.classList.contains('active')) {
            setTimeout(initializeWeaponMap, 50);
            if (document.getElementById('weapons-filter-bar')) document.getElementById('weapons-filter-bar').style.display = 'none';
          } else { // Table view is active
            if (document.getElementById('weapons-filter-bar')) document.getElementById('weapons-filter-bar').style.display = 'flex';
          }
        }
      }
    }
    /**
     * This function is called ONLY when switching TO the Units view.
     * It handles the rendering logic for the units table.
     */
    function enterUnitsView() {
        console.debug("Entering Units View.");
        // If the table is dirty (because of a filter change or state restoration), render it.
        if (uiState.isUnitsTableDirty) {
            renderUnitsTable();
            // The render function itself will set the flag to false.
        }
    }

    /**
     * This function is called ONLY when switching AWAY from the Units view.
     * It restores any saved manual filters.
     */
    function leaveUnitsView() {
        console.debug("Leaving Units View.");
        // If a temporary filter was active, restore the user's manual settings.
        if (savedManualUnitFilters) {
            console.debug("Restoring manual unit filters.");
            
            // Restore the saved state.
            currentUnitFilters = JSON.parse(JSON.stringify(savedManualUnitFilters));
            
            // Clear the snapshot.
            savedManualUnitFilters = null;
            
            // Mark the table as dirty so it uses the restored filters next time.
            uiState.isUnitsTableDirty = true;

            // Update the filter UI to match the restored state.
            updateFilterUIFromState(currentUnitFilters);
        }
    }
    function switchInnerTab(targetPaneId, tabGroup, clickedButton) {
      const tabButtons = document.querySelectorAll(`.inner-tab-button[data-tab-group="${tabGroup}"]`);
      const tabPanes = document.querySelectorAll(`#${tabGroup}-inner-tabs + .inner-tab-content > .inner-tab-pane`);

      tabButtons.forEach(btn => btn.classList.remove('active'));
      clickedButton.classList.add('active');

      tabPanes.forEach(pane => pane.classList.remove('active'));
      const targetPane = document.querySelector(targetPaneId);
      if (targetPane) targetPane.classList.add('active');

      // Handle Mission Filter Bar visibility
      if (tabGroup === 'missions') {
        const missionFilterBar = document.getElementById('missions-filter-bar');

        if (targetPaneId === '#mission-list-view-pane') {
          missionFilterBar.style.display = 'flex';
          uiState.isWeaponsTableDirty = true;
          renderMissionsTable();
        } else {
          missionFilterBar.style.display = 'none';
        }
      }

      // Handle Weapon Filter Bar visibility
      if (tabGroup === 'weapons') {
        const weaponFilterBar = document.getElementById('weapons-filter-bar');
        if (targetPaneId === '#weapon-table-view-pane') {
          weaponFilterBar.style.display = 'flex';
          // If you want to explicitly destroy/hide map here you could,
          // but CSS should handle hiding #weapon-map-view-pane
        } else { // Map view is active
          weaponFilterBar.style.display = 'none';
          // Initialize/refresh map ONLY when its tab is explicitly selected
          setTimeout(() => {
            const mapContainer = document.getElementById('weaponMap');
            if (!mapContainer || !mapContainer.offsetParent) return;

            if (!weaponMap || !weaponMap.getContainer()) {
              initializeWeaponMap();
            } else {
              weaponMap.invalidateSize(true);
            }
          }, 50);
        }
      }

      if (targetPaneId === '#mission-schedule-view-pane') {
        if (!missionScheduleInitialized) {
          initializeMissionScheduleView();
        } else {
          schedule_updateFullTimeline();
        }
      }
    }
    //Clear filters
    function clearUnitFiltersAndRender() {
      // Reset UI elements
      document.getElementById('unit-search').value = '';
      document.getElementById('unit-type-filter').value = '';
      //document.getElementById('unit-subtype-filter').value = '';
      document.getElementById('unit-mission-filter').value = '';
      document.getElementById('unit-base-filter').value = '';
      document.getElementById('unit-mission-mtype-filter').value = '';
      document.getElementById('unit-status-filter').value = '';
      document.getElementById('unit-loadout-role-filter').value = '';
      // Note: NCU filter is a toggle, users usually expect it to persist unless explicitly reset.
      // If you want to reset NCU too:
      // document.getElementById('unit-ncu-filter').checked = false; 

      // Reset global filter state object
      currentUnitFilters = {
        search: '', type: '', mission: '', base: '',
        missionMType: '', missionMTag: '', loadoutRole: '',
        operationalStatus: '',
        showNCU: document.getElementById('unit-ncu-filter')?.checked || false, // Preserve NCU or reset
        showOnlyCritical: false,
        hideUnavailableReserve: true // Reset state to default
      };
      document.getElementById('unit-hide-unavailable-filter').checked = true;
      uiState.isUnitsTableDirty = true;
      renderUnitsTable(); // This will re-populate filters based on full data (respecting NCU)
    }

    function clearMissionFiltersAndRender() {
      // Reset UI elements
      document.getElementById('mission-search-input').value = '';
      document.getElementById('mission-filter-taskpool').value = '';
      document.getElementById('mission-filter-mtype').value = '';
      document.getElementById('mission-filter-mtag').value = '';
      document.getElementById('mission-filter-msubtype').value = '';
      document.getElementById('mission-filter-status').value = '';
      // Reset global mission filter state object (if you have one, e.g., currentMissionViewFilters)
      // For now, renderMissionsTable reads directly from inputs.
      // If you introduce a state object like currentUnitFilters, reset it here.
      // currentMissionViewFilters = { search: '', taskPool: '', mType: '', ... };
      currentMissionFilters = {
        search: '',
        taskPool: '',
        mType: '',
        mTag: '',
        mSubtype: '',
        // status: '', // If you have a dropdown for raw mission status
        mStatus: '' // NEW: For filtering by the chart's clicked status
      };
      uiState.isWeaponsTableDirty = true;
      renderMissionsTable(); // This will re-populate its own filters after clearing inputs

    }

    function clearWeaponFiltersAndRender() {
      // Reset UI elements
      document.getElementById('weapon-search').value = '';
      document.getElementById('weapon-type-filter').value = '';
      document.getElementById('weapon-targets-filter').value = '';
      document.getElementById('weapon-base-filter').value = '';

      // Reset global weapon filter state object
      currentWeaponFilters = {
        search: '',
        type: '',
        base: '',
        targets: '',
        showOnlyCritical: false
      };
      uiState.isWeaponsTableDirty = true;
      renderWeaponsTable(); // This will re-populate its own filters
    }
    //Backend functions
    /**
    * Asynchronously sends mission updates to the backend for multiple units,
    * one by one, without blocking the UI.
    * @param {string[]} unitIds - An array of unit IDs to update.
    * @param {string} newMissionName - The mission to assign.
    */
    async function sendBatchMissionUpdatesToBackend(unitIds, newMissionName) {
      console.debug(`Starting background update for ${unitIds.length} units...`);

      // A small helper function to create a non-blocking delay.
      const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

      for (const unitId of unitIds) {
        // Send the update for one unit.
        updateUnitMissionInBackend(unitId, newMissionName);

        // Wait for a very short period (e.g., 1ms) to allow the browser's
        // event loop to handle other tasks (like rendering). This prevents
        // the browser from freezing if the loop is very long.
        await delay(1);
      }

      console.debug(`Finished background update for ${unitIds.length} units.`);
    }
    function updateUnitMissionInBackend(unitId, newMissionName) {
      let mission = newMissionName || "";
      console.debug(`BACKEND CALL (simulated): Updating unit ${unitId} to mission: ${mission}`);
      if (window.chrome) {
        window.chrome.webview.postMessage(`DIALOG_OKScenEdit_AssignUnitToMission("${unitId}","${mission}")`)
      }
    }
    function openAircraftLoadout(unitInput) {

      let unitIDsArray = [];

      // --- Normalize input to always be an array ---
      if (typeof unitInput === 'string') {
        if (unitInput.trim() !== "") {
          unitIDsArray = [unitInput.trim()]; // Convert single string to an array with one element
        }
      } else if (Array.isArray(unitInput)) {
        unitIDsArray = unitInput.filter(id => typeof id === 'string' && id.trim() !== ""); // Filter out empty/invalid IDs
      }
      if (!unitIDsArray || unitIDsArray.length === 0) {
        console.warn("openAircraftLoadout called with no unit IDs.");
        return;
      }

      let messagePayloadIDsString;

      if (unitIDsArray.length === 1) {
        // --- SINGLE UNIT ---
        const unitID = unitIDsArray[0];
        messagePayloadIDsString = `{"${unitID}"}`; // Format: {"ID1"}


        // alert(`Simulating: Game engine loadout window requested for SINGLE Unit ID: ${unitID}`);
        window.chrome.webview.postMessage(`DIALOG_OKUI_ShowWindow("readyaircraft",${messagePayloadIDsString})`);

      } else {
        // --- BATCH OF UNITS ---
        // All units in unitIDsArray have already passed validation.

        // Construct the string: {"ID1","ID2","ID3",...}
        messagePayloadIDsString = "{" + unitIDsArray.map(id => `"${id}"`).join(',') + "}";


        window.chrome.webview.postMessage(`DIALOG_OKUI_ShowWindow("readyaircraft",${messagePayloadIDsString})`);
      }
    }
    function handleUnitNameClick(unitId, unitLat, unitLon) {
      var latitude = parseFloat(unitLat);
      var longitude = parseFloat(unitLon);
      //console.debug(`${latitude}, ${longitude}`)
      window.chrome.webview.postMessage(`DIALOG_OKUI_SetCameraView(${latitude},  ${longitude})`);
      window.chrome.webview.postMessage(`DIALOG_OKUI_SelectThisUnit("${unitId}",true)`)

    }
    function openUnitDoctrineWindow(unitId, unitName) {
      console.debug(`OPEN DOCTRINE WINDOW (simulated): For Unit ID: ${unitId}, Name: ${unitName}`);
      // In a real application, this might open a new modal or a side panel
      // with doctrine-specific information related to the unit.
      window.chrome.webview.postMessage(`DIALOG_OKUI_ShowWindow("doctrine",{"${unitId}"})`)
    }
    function openMissionDoctrine(missionId, missionName) {
      console.debug(`OPEN MISSION DOCTRINE (simulated): For Mission ID: ${missionId}, Name: ${missionName}`);
      //alert(`Mission Doctrine for:\nID: ${missionId}\nName: ${missionName}\n\n(This would show doctrine specific to this mission)`);
      window.chrome.webview.postMessage(`DIALOG_OKUI_ShowWindow("mission",{"${missionId}",4})`)
      //window.chrome.webview.postMessage(`DIALOG_OKUI_ShowWindow("doctrine",{"${missionId}"})`)
    }

    // Placeholder function for opening mission in editor
    function openMissionInEditor(missionId, missionName) {
      //console.debug(`OPEN MISSION IN EDITOR (simulated): For Mission ID: ${missionId}, Name: ${missionName}`);
      window.chrome.webview.postMessage(`DIALOG_OKUI_ShowWindow("mission",{"${missionId}"})`)
      //alert(`Editing Mission:\nID: ${missionId}\nName: ${missionName}\n\n(This would open a mission editing interface)`);
    }

    function openDatabaseEntry(unitDBID, unitType) {
      //console.debug(`OPEN DATABASE ENTRY : ${unitDBID} - ${unitType}`)
      window.chrome.webview.postMessage(`DIALOG_OKUI_OpenNewDatabaseWindow("${unitType}",${unitDBID})`);
    }


    //Auxiliary functions

    function roundDate(date) {
      const rounded = new Date(date);
      rounded.setMinutes(0, 0, 0); // set minutes, seconds, and ms to zero
      return rounded;
    }
    function createCapabilityIconElement(iconData) {
      if (iconData.startsWith('fas')) {
        // It's a Font Awesome class string
        const i = document.createElement('i');
        i.className = iconData;
        return i;
      } else {
        // It's an SVG string
        const span = document.createElement('span');
        span.innerHTML = iconData;
        return span.firstChild; // Return the <svg> element itself
      }
    }
    function escapeForLuaString(str) {
      return str.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
    }
    function naturalCompare(a, b, options = {}) {
      const { caseSensitive = false } = options;

      // Ensure inputs are strings for consistent processing
      const sA = String(a == null ? "" : a);
      const sB = String(b == null ? "" : b);

      // If not case sensitive, convert to lower case for string parts comparison
      const strA = caseSensitive ? sA : sA.toLowerCase();
      const strB = caseSensitive ? sB : sB.toLowerCase();

      // Regex to split into sequences of digits or non-digits
      // \d+ matches one or more digits
      // [^\d]+ matches one or more non-digits
      const chunkRegex = /(\d+)|([^\d]+)/g;

      const getChunks = (str) => {
        const chunks = [];
        let match;
        chunkRegex.lastIndex = 0; // Reset regex state for each string
        while ((match = chunkRegex.exec(str)) !== null) {
          // match[1] is digits, match[2] is non-digits
          if (match[1]) { // Digit sequence
            chunks.push(parseInt(match[1], 10));
          } else if (match[2]) { // Non-digit sequence
            chunks.push(match[2]);
          }
        }
        // If the string was empty and chunks is empty, it's fine.
        // If string was not empty but chunks is empty (e.g. str contained only characters not matched by regex, though unlikely with current regex)
        // then push the original string as a single chunk.
        if (chunks.length === 0 && str) {
          chunks.push(str); // Fallback for strings not tokenized by regex
        }
        return chunks;
      };

      const chunksA = getChunks(strA);
      const chunksB = getChunks(strB);

      const minLength = Math.min(chunksA.length, chunksB.length);

      for (let i = 0; i < minLength; i++) {
        const chunk1 = chunksA[i];
        const chunk2 = chunksB[i];

        // If both are numbers, compare numerically
        if (typeof chunk1 === 'number' && typeof chunk2 === 'number') {
          if (chunk1 !== chunk2) {
            return chunk1 - chunk2;
          }
        } else {
          // If one is a number and the other is not, numbers typically come before strings
          if (typeof chunk1 === 'number') return -1; // chunk1 (number) < chunk2 (string)
          if (typeof chunk2 === 'number') return 1;  // chunk1 (string) > chunk2 (number)

          // Both are strings, compare lexicographically
          if (chunk1 !== chunk2) {
            return chunk1 < chunk2 ? -1 : 1;
          }
        }
      }

      // If all common chunks are equal, the one with more chunks comes later
      // e.g., "file1" vs "file1a" -> "file1" comes first because it's shorter after common prefix.
      return chunksA.length - chunksB.length;
    }
    const debounce = (fn, wait = 250) => { // Increased default wait time slightly
      let t;
      return function (...args) { // Use a regular function if you need `this` context from the event listener
        clearTimeout(t);
        t = setTimeout(() => fn.apply(this, args), wait); // Use apply to preserve `this` and pass arguments
      };
    };
    function addSecondsToISOString(isoString, seconds) {
      if (!isoString || typeof seconds !== 'number' || isNaN(seconds)) {
        return null;
      }
      try {
        const date = new Date(isoString);
        date.setSeconds(date.getSeconds() + seconds);
        return date;
      } catch (e) {
        console.error("Error manipulating date:", e);
        return null;
      }
    }
    const parseAsUTC = (dateString) => {
      if (!dateString || typeof dateString !== 'string' || dateString.trim() === "") return null;
      // Check if it's already explicitly UTC (ends with Z or has +/- offset)
      if (dateString.endsWith('Z') || /[\+\-]\d{2}:\d{2}$/.test(dateString) || /[\+\-]\d{4}$/.test(dateString)) {
        return new Date(dateString);
      }
      // Otherwise, assume it's an ISO-like string missing 'Z' and append it
      return new Date(dateString + 'Z');
    };
    function formatCustomUTC(dateObj) {
      if (!dateObj || !(dateObj instanceof Date) || isNaN(dateObj.getTime())) return 'N/A';
      const M = dateObj.getUTCMonth() + 1;
      const D = dateObj.getUTCDate();
      const Y = dateObj.getUTCFullYear();
      const h = dateObj.getUTCHours().toString().padStart(2, '0');
      const m = dateObj.getUTCMinutes().toString().padStart(2, '0');
      const s = dateObj.getUTCSeconds().toString().padStart(2, '0');
      return `${M}/${D}/${Y}, ${h}:${m}:${s}`; // No "UTC" suffix here, but values are UTC
    }
    function getMissionStatus(missionDetails, currentScenarioTime) {
      // missionDetails: The object like { startT: "...", endT: "...", mType: "...", ... }
      // currentScenarioTime: A Date object representing the current scenario time (UTC)

      const startTime = parseAsUTC(missionDetails.startT);
      const endTime = parseAsUTC(missionDetails.endT);
      const now = currentScenarioTime; // Use the passed-in current time

      let calculatedStatus;


      if (missionDetails.status) { // Explicit status from data source takes precedence
        calculatedStatus = missionDetails.status.toUpperCase();
        // Optional: Map to your standard set if needed
        // if (calculatedStatus === "IN_PROGRESS") calculatedStatus = "ACTIVE";
      } else if (endTime && endTime.getTime() < now.getTime()) {
        calculatedStatus = "COMPLETED";
      } else if ((!startTime || (startTime && startTime.getTime() <= now.getTime())) &&
        (!endTime || (endTime && endTime.getTime() >= now.getTime()))) {
        calculatedStatus = "ACTIVE";
        if (!missionDetails.isActive) calculatedStatus = "INACTIVE";
      } else if (startTime && startTime.getTime() > now.getTime()) {
        calculatedStatus = "PLANNED";
      } else {
        // console.warn(`Mission ${missionDetails.name || missionDetails.id} has unusual time data for status calc. Defaulting to PLANNED.`);
        calculatedStatus = "PLANNED"; // Fallback
      }


      return calculatedStatus;
    }
    function preprocessMissionDataWithStatus(missionDataSource, isoTime) {
      const scenarioTime = new Date(isoTime); // Convert currentISOTime to a Date object once

      for (const taskPoolName in missionDataSource) {
        if (missionDataSource[taskPoolName] && missionDataSource[taskPoolName].missionList) {
          for (const missionName in missionDataSource[taskPoolName].missionList) {
            const missionDetails = missionDataSource[taskPoolName].missionList[missionName];
            // Add a new property, e.g., 'calculatedStatus' or overwrite 'status'
            // if you are sure 'status' isn't used for something else from the source.
            // Using 'calculatedStatus' avoids conflict if 'status' comes from the source with different meanings.
            missionDetails.calculatedStatus = getMissionStatus(missionDetails, scenarioTime);
          }
        }
      }
      // missionDataSource is modified in place
    }
    if (typeof missionData !== 'undefined' && typeof currentISOTime !== 'undefined') {
      preprocessMissionDataWithStatus(missionData, currentISOTime);

    } else {
      console.error("missionData or currentISOTime is not defined for pre-processing.");
    }
    // Event Listeners
    document.addEventListener('DOMContentLoaded', () => {

      function initializeApp() {

        initializeBootstrapTooltips();
        buildUnitMap();
        preprocessUnitData();

        preprocessMissionDataWithStatus();
        const welcomeHelpModalInstance = new bootstrap.Modal(document.getElementById('welcomeHelpModal')); // Made local

        const overviewHelpButton = document.getElementById('overview-show-help-modal-btn');
        if (overviewHelpButton) {
          overviewHelpButton.addEventListener('click', () => {

            welcomeHelpModalInstance.show();
          });
        }

        keyAssetConfigModalInstance = new bootstrap.Modal(document.getElementById('keyAssetConfigModal'));
        initializeKeyAssetConfigModal();
        initializeCriticalMunitionsModal();
        initializeUnitTableInteractions();

        setupMissionTableDelegatedEvents();
        const unitTableWrapper = document.getElementById('unit-table-div');
        if (unitTableWrapper) {
          unitTableWrapper.addEventListener('scroll', () => {
            // Check if there are any open TomSelect instances
            if (tomSelectInstances.size > 0) {
              tomSelectInstances.forEach((instance, unitId) => {
                // The 'isOpen' property tells us if the dropdown is currently visible
                if (instance.isOpen) {
                  instance.close(); // Programmatically close the dropdown
                }
              });
            }
          });
        }

        const selectAllCheckbox = document.getElementById('unit-select-all-checkbox');
        if (selectAllCheckbox) {
          selectAllCheckbox.addEventListener('click', (event) => {
            const isChecked = event.currentTarget.checked;

            if (isChecked) {
              // Select all units currently visible in the table
              currentUnitsInTableForSelection.forEach(unit => selectedUnitIds.add(unit.id));
            } else {
              // Deselect all
              selectedUnitIds.clear();
            }

            lastSelectedUnitId = null; // Reset shift-click anchor
            uiState.isUnitsTableDirty = true;
            renderUnitsTable();
          });
        }
        document.getElementById('unit-ncu-filter')?.addEventListener('change', (e) => {
          currentUnitFilters.showNCU = e.target.checked;
          uiState.isUnitsTableDirty = true;
          renderUnitsTable();
        });
        document.querySelectorAll('.main-view-tab-button').forEach(link => {
          link.addEventListener('click', (e) => {
            e.preventDefault();
            switchView(e.currentTarget.dataset.view);
          });
        });
        setupKeyAssetConfigurationListeners();
        document.querySelectorAll('.inner-tab-button').forEach(button => {
          button.addEventListener('click', (e) => {
            e.preventDefault();
            switchInnerTab(e.currentTarget.dataset.bsTarget, e.currentTarget.dataset.tabGroup, e.currentTarget);
          });
        });


        document.addEventListener('click', function (event) {
          // Deselect if clicked outside the relevant table area and not on a batch action control
          const unitsTable = document.getElementById('units-table');
          // Add a class to your batch action controls container, e.g., 'batch-action-controls'
          const batchActionControls = document.querySelector('.batch-action-controls-container'); // You'll need to add this container

          if (unitsTable && !unitsTable.contains(event.target) &&
            (!batchActionControls || !batchActionControls.contains(event.target))) {
            if (selectedUnitIds.size > 0) {
              selectedUnitIds.clear();
              lastSelectedUnitId = null;
              uiState.isUnitsTableDirty = true;
              renderUnitsTable(); // Re-render to update visuals
              updateBatchActionUIState();
            }
          }
        });
        const hideUnavailableFilterCheckbox = document.getElementById('unit-hide-unavailable-filter');
        if (hideUnavailableFilterCheckbox) {
          // The listener now just calls our clean helper function.
          hideUnavailableFilterCheckbox.addEventListener('change', (e) => {
            updateHideUnavailableFilter(e.target.checked);
          });
        }
        const unitSearchInput = document.getElementById('unit-search');
        if (unitSearchInput) {
          unitSearchInput.addEventListener('input', debounce(function (e) { // `function(e)` to keep `this` as the input element
            currentUnitFilters.search = e.target.value; // No toLowerCase() here, do it in filter logic
            uiState.isUnitsTableDirty = true;
            renderUnitsTable();
          }, 300)); // 300ms delay
        }
        //'unit-subtype-filter'
        ['unit-type-filter', 'unit-mission-filter', 'unit-base-filter',
          'unit-mission-mtype-filter', 'unit-status-filter', 'unit-loadout-role-filter' // NEW
        ].forEach(id => {
          const filterElement = document.getElementById(id);
          if (filterElement) {
            filterElement.addEventListener('change', (e) => {
              // A manual filter change always cancels any temporary state.
              if (savedManualUnitFilters) {
                  savedManualUnitFilters = null;
                  //console.debug("Manual filter applied, clearing temporary state.");
              }
              
              let filterKey;
              if (id === 'unit-type-filter') filterKey = 'type';
              //else if (id === 'unit-subtype-filter') filterKey = 'subtype';
              else if (id === 'unit-mission-filter') filterKey = 'mission';
              else if (id === 'unit-base-filter') filterKey = 'base';
              else if (id === 'unit-mission-mtype-filter') filterKey = 'missionMType'; // NEW
              else if (id === 'unit-status-filter') filterKey = 'condition';   // NEW
              else if (id === 'unit-loadout-role-filter') filterKey = 'loadoutRole'; // NEW

              currentUnitFilters[filterKey] = e.target.value;

              // Special handling for dependent filters
              if (id === 'unit-type-filter') {
                currentUnitFilters.subtype = ''; // Reset subtype if type changes
                // populateUnitFilters will be called by renderUnitsTable, which will update subtype options
              }
              uiState.isUnitsTableDirty = true;
              renderUnitsTable();
            });
          }
        });
        document.querySelectorAll('#units-table thead th[data-sort]').forEach(th => {
          th.addEventListener('click', () => {
            const column = th.dataset.sort;

            if (currentUnitSort.column === column) {
              // Clicked same column, toggle order
              currentUnitSort.order = currentUnitSort.order === 'asc' ? 'desc' : 'asc';
              // Optionally, toggle secondary order if primary order changes, or keep it
              // currentUnitSort.secondaryOrder = currentUnitSort.order; 
            } else {
              // Clicked new column, set as primary, default to ascending
              currentUnitSort.column = column;
              currentUnitSort.order = 'asc';
              // Set a default secondary sort when primary changes
              // For example, always sort by name secondarily if not sorting by name primarily
              if (column !== 'name') {
                currentUnitSort.secondaryColumn = 'name';
                currentUnitSort.secondaryOrder = 'asc';
              } else {
                // If primary is 'name', maybe secondary by 'id' or clear secondary
                currentUnitSort.secondaryColumn = 'id'; // Or null
                currentUnitSort.secondaryOrder = 'asc';
              }
            }

            // Update sort icons (as before)
            document.querySelectorAll('#units-table thead th[data-sort] i').forEach(i => i.className = 'fas fa-sort');
            th.querySelector('i').className = `fas fa-sort-${currentUnitSort.order === 'asc' ? 'up' : 'down'}`;
            // If you want to indicate secondary sort, you'd need more complex icon logic
            uiState.isUnitsTableDirty = true;
            renderUnitsTable();
          });
        });

        const missionSearchInput = document.getElementById('mission-search-input');
        if (missionSearchInput) {
          missionSearchInput.addEventListener('input', debounce(function (e) {
            // If you store mission search term in a state object:
            currentMissionFilters.search = e.target.value.toLowerCase(); // Update state
            currentMissionFilters.mStatus = ''; // Clear chart filter when typing
            uiState.isWeaponsTableDirty = true;
            renderMissionsTable();
          }, 300));
        }
        ['mission-filter-taskpool', 'mission-filter-mtype', 'mission-filter-mtag', 'mission-filter-msubtype', 'mission-filter-status'].forEach(id => {
          const filterElement = document.getElementById(id);
          if (filterElement) {
            filterElement.addEventListener('change', (e) => {
              let filterKey;
              if (id === 'mission-filter-taskpool') filterKey = 'taskPool';
              else if (id === 'mission-filter-mtype') filterKey = 'mType';
              else if (id === 'mission-filter-mtag') filterKey = 'mTag';
              else if (id === 'mission-filter-msubtype') filterKey = 'mSubtype';
              else if (id === 'mission-filter-status') filterKey = 'mStatus';

              if (filterKey) {
                currentMissionFilters[filterKey] = e.target.value;
                uiState.isWeaponsTableDirty = true;
                renderMissionsTable();
              }
            });
          }
        });
        document.querySelector('#mission-assigned-units-detail .close-assigned-units-detail-btn')?.addEventListener('click', hideAssignedUnitsDetail);

        // Mission Table Sorting
        document.querySelectorAll('#main-missions-table thead th[data-sort-mission]').forEach(th => {
          th.addEventListener('click', () => {
            const column = th.dataset.sortMission;
            if (currentMissionSort.column === column) {
              currentMissionSort.order = currentMissionSort.order === 'asc' ? 'desc' : 'asc';
            } else {
              currentMissionSort.column = column;
              currentMissionSort.order = 'asc';
            }
            document.querySelectorAll('#main-missions-table thead th[data-sort-mission] i').forEach(i => i.className = 'fas fa-sort');
            th.querySelector('i').className = `fas fa-sort-${currentMissionSort.order === 'asc' ? 'up' : 'down'}`;
            uiState.isWeaponsTableDirty = true;
            renderMissionsTable(); // This will now use the updated currentMissionSort
          });
        });
        setupColumnToggler('main-missions-table', missionsTableColumnVisibility, 'missions-column-toggler-menu');

        const weaponSearchInput = document.getElementById('weapon-search');
        if (weaponSearchInput) {
          weaponSearchInput.addEventListener('input', debounce(function (e) {
            // If you store weapon search term in a state object:
            // currentWeaponFilters.search = e.target.value; 
            uiState.isWeaponsTableDirty = true;
            renderWeaponsTable();
          }, 300));
        }

        document.getElementById('weapon-type-filter').addEventListener('change', (e) => renderWeaponsTable());
        document.getElementById('weapon-targets-filter')?.addEventListener('change', renderWeaponsTable);
        document.getElementById('weapon-base-filter')?.addEventListener('change', renderWeaponsTable);

        document.querySelectorAll('#weapons-table th[data-sort-weapon]').forEach(th => {
          th.addEventListener('click', () => {
            const column = th.dataset.sortWeapon;
            if (currentWeaponSort.column === column) {
              currentWeaponSort.order = currentWeaponSort.order === 'asc' ? 'desc' : 'asc';
            } else {
              currentWeaponSort.column = column;
              currentWeaponSort.order = 'asc';
            }
            document.querySelectorAll('#weapons-table th[data-sort-weapon] i').forEach(i => i.className = 'fas fa-sort');
            th.querySelector('i').className = `fas fa-sort-${currentWeaponSort.order === 'asc' ? 'up' : 'down'}`;
            uiState.isWeaponsTableDirty = true;
            renderWeaponsTable();
          });
        });

        document.querySelectorAll('.column-toggler-dropdown').forEach(menu => {
          menu.addEventListener('click', function (e) {
            if (e.target.tagName !== 'INPUT' && e.target.tagName !== 'LABEL') {
            }
          });
        });
        document.getElementById('clear-units-filters-btn')?.addEventListener('click', () => {
          clearUnitFiltersAndRender();
        });
        document.getElementById('clear-missions-filters-btn')?.addEventListener('click', () => {
          clearMissionFiltersAndRender();
        });
        document.getElementById('clear-weapons-filters-btn')?.addEventListener('click', () => {
          clearWeaponFiltersAndRender();
        });
        setupColumnToggler('units-table', unitsTableColumnVisibility, 'units-column-toggler-menu');
        setupColumnToggler('weapons-table', weaponsTableColumnVisibility, 'weapons-column-toggler-menu');
        switchView('overview');

        // --- 4. Hide the loader and show the app ---
        const loader = document.getElementById('app-loader');
        if (loader) {
          loader.style.opacity = '0';
          // Wait for the fade-out transition to finish before removing it
          setTimeout(() => {
            loader.remove();
          }, 500); // This should match your CSS transition duration
        }
        // Add the 'app-loaded' class to the body to fade in the main content
        document.body.classList.add('app-loaded');
      }
      setTimeout(initializeApp, 50);
    });
  </script>
</body>

</html>]]
Tool_EmulateNoConsole(true)
AuxFunctions = {}

function AuxFunctions.EscapeString(str)
  -- Escape backslash first, then quote
  str = str:gsub("\\", "\\\\")
           :gsub("\"", "\\\"")
  -- Standard C escape sequences
  str = str:gsub("\n", "\\n")
           :gsub("\r", "\\r")
           :gsub("\t", "\\t")
           :gsub("\b", "\\b") -- Lua string "\b" is char(8)
           :gsub("\f", "\\f") -- Lua string "\f" is char(12)

  -- Escape other C0 control characters (U+0000 to U+001F)
  -- Pattern for ASCII 0-7, 11 (VT), 14-31.
  -- (8=\b, 9=\t, 10=\n, 12=\f, 13=\r are handled above)
  return str:gsub("([\0-\7\11\14-\31])", function(c)
    return string.format("\\u%04x", string.byte(c))
  end)
end

function AuxFunctions.ValueToJson(value)
  -- Forward declaration or ensure TableToJson is defined before ValueToJson if they call each other.
  -- In this structure, they are defined sequentially, so direct call is fine.

  local t = type(value)
  if value == nil then -- Explicitly handle nil
      return "null"
  elseif t == "number" then
      -- JSON doesn't support NaN or Infinity
      if value ~= value or value == math.huge or value == -math.huge then
          return "null" -- Or error, depending on desired behavior
      end
      return tostring(value)
  elseif t == "boolean" then
      return tostring(value)
  elseif t == "string" then
      return "\"" .. AuxFunctions.EscapeString(value) .. "\""
  elseif t == "table" then
      return AuxFunctions.TableToJson(value)
  else
      -- You might want to return "null" for unsupported types or specific userdata
      -- instead of erroring, depending on your needs.
      error("Unsupported value type for JSON: " .. t)
  end
end

function AuxFunctions.TableToJson(tbl)
  if tbl == nil then return "null" end -- Or "" as your original code returned for nil tbl

  local parts = {} -- Use a table to build parts, then concat

  -- Determine if it's an array or an object
  local is_array = false
  local n = 0 -- Number of elements if it's array-like
  local num_keys = 0 -- Total number of keys

  for k in pairs(tbl) do
    num_keys = num_keys + 1
    if type(k) == "number" and k >= 1 and math.floor(k) == k then
      if k > n then
        n = k -- Max numeric key
      end
    else
      -- If any key is not a positive integer, it's definitely an object
      is_array = false
      break -- No need to check further for array properties
    end
    is_array = true -- Candidate for array so far
  end
  
  -- If it was a candidate, further check if it's dense (no holes, all keys 1..n are present)
  -- And also ensure that the number of numeric keys found (n) matches the total number of keys.
  if is_array and num_keys ~= n then
    is_array = false -- It has holes or mixed keys, so it's an object
  end
  if num_keys == 0 then -- Empty table
    is_array = false -- Treat {} as an object "{}". Change if you want "[]".
  end


  if is_array then
    table.insert(parts, "[")
    for i = 1, n do
      table.insert(parts, AuxFunctions.ValueToJson(tbl[i])) -- tbl[i] could be nil, ValueToJson handles it
      if i < n then
        table.insert(parts, ", ")
      end
    end
    table.insert(parts, "]")
  else -- Object
    table.insert(parts, "{")
    local first = true
    -- For consistent key order (optional, but good for testing/diffs)
    -- Collect and sort keys if desired, otherwise iterate with pairs
    local keys_to_iterate = {}
    for k, _ in pairs(tbl) do
        table.insert(keys_to_iterate, k)
    end
    -- Sort keys for predictable output (tostring for comparison robustness)
    table.sort(keys_to_iterate, function(a,b) return tostring(a) < tostring(b) end)

    for _, k in ipairs(keys_to_iterate) do
      local v = tbl[k]
      if not first then
        table.insert(parts, ", ")
      end
      first = false

      -- Keys in JSON objects must be strings and escaped
      local key_str = AuxFunctions.EscapeString(tostring(k))
      table.insert(parts, "\"" .. key_str .. "\": ")
      table.insert(parts, AuxFunctions.ValueToJson(v))
    end
    table.insert(parts, "}")
  end

  return table.concat(parts)
end

local function formatTime(seconds)
  local hours = math.floor(seconds / 3600)
  local minutes = math.floor((seconds % 3600) / 60)
  local seconds = seconds % 60
  local seconds = math.floor(seconds)
  if hours > 0 then
      return string.format("%02d:%02d:%02d", hours, minutes, seconds)
  elseif minutes > 0 then
      return string.format("%02d:%02d", minutes, seconds)
  else
      return string.format("%02d", seconds)
  end
end
local function GetMissionType(mission)
  local name = mission.name
  local typ = mission.typeS
  local mtype = typ
  if typ == 'Support' then
    mtype = 'SUP'
    if string.find(name,'#ISR') or string.find(name,'#REC') then mtype = 'REC' end
    if string.find(name,'#ECM') or string.find(name,'#ELINT') or string.find(name,'#ES') or string.find(name,'#SIG') or string.find(name,'#EA') then mtype = 'EW' end
    if string.find(name,'#AAR') then mtype ='AR' end
    if string.find(name,'#AEW') then mtype ='AEW' end
    if string.find(name,'#ACP') or string.find(name,'#C2') or string.find(name,'#ABCCC') then mtype ='C2' end
  elseif typ == 'Patrol' then
    local subtype = mission.subtype
    if string.find(subtype, 'SEAD') or string.find(name,'#SEAD') then mtype = 'SEAD' end
    if string.find(subtype, 'ASW') or string.find(name,'#ASW') then mtype = 'ASW' end
    if string.find(subtype, 'Sea Control Patrol') or string.find(subtype, 'Naval') then mtype = 'SEA' end
    if string.find(subtype, 'Ground') or string.find(name,'#CAS') then mtype = 'CAS' end
    if mission.subtype == 'AAW Patrol' then
      mtype = 'CAP'
      if string.find(name,'#OCA') then mtype = 'OCA' end
      if string.find(name,'#DCA') then mtype = 'DCA' end
    end
  elseif typ == 'Cargo' then
    mtype = 'SUP'
  elseif typ == 'Ferry' then
    mtype = 'SUP'
  elseif typ == 'Strike' then
    if mission.subtype == 'Land Strike' then
      mtype = 'STRAT'
      if string.find(name,'#INT') or string.find(name,'#AI') then mtype = 'INT' end
      if string.find(name,'#OCA') then mtype = 'OCA' end
    elseif mission.subtype == 'Maritime Strike' or string.find(mission.subtype, 'Naval') then 
      mtype = 'MARSTR' 
    elseif mission.subtype  == 'ASW Strike' then
      mtype = 'ASW'
    else
      mtype = 'DCA'
    end
  end

  return mtype
end
local function tsISO(timestamp)
    -- Add 30 minutes to round to the nearest hour
    local roundedTime = timestamp + 30 * 60

    -- Get the hour-aligned timestamp
    local hourAligned = roundedTime - (roundedTime % 3600)

    -- Convert to UTC ISO 8601 format
    local isoDate = os.date("!%Y-%m-%dT%H:00:00Z", hourAligned)

    return isoDate
end
local function to_iso_date(input_date)
    
    -- Extract components from the input string using pattern matching
    local day, month, year, hour, min, sec = input_date:match("(%d%d)/(%d%d)/(%d%d%d%d) (%d?%d):(%d%d):(%d%d)")
    if not (day and month and year and hour and min and sec) then
        return ""
    end
    -- Convert to a table with the correct format for os.time
    local date_table = {
        year = tonumber(year),
        month = tonumber(month),
        day = tonumber(day),
        hour = tonumber(hour),
        min = tonumber(min),
        sec = tonumber(sec)
    }
    
    -- Convert to ISO format
    
    return string.format("%04d-%02d-%02dT%02d:%02d:%02d", 
        date_table.year, date_table.month, date_table.day, 
        date_table.hour, date_table.min, date_table.sec)
end
local function GetMissionInfo(mission_guid)
  local side = ScenEdit_PlayerSide()
  local mission = ScenEdit_GetMission(side,mission_guid)
  local flights = {}
  
  
  startT = mission.starttime
  endT = mission.endtime
  
  startT = to_iso_date(startT)
  endT = to_iso_date(endT)
  local OnStation = 0
  
  if mission.typeS == 'Patrol' then
    
    if not mission.patrolmission.OneThirdRule then
      if mission.patrolmission.OnStation ~= 0 then
        if mission.patrolmission.UseGroupSize and mission.patrolmission.GroupSize > 0 then -- Ensure groupSize is positive
            OnStation = math.ceil(mission.patrolmission.OnStation / mission.patrolmission.GroupSize) * mission.patrolmission.GroupSize
        end
      else
        OnStation = #mission.unitlist
      end
    else
      
      if math.floor(#mission.unitlist/3 + 0.5) > mission.patrolmission.OnStation then
        OnStation = math.floor(#mission.unitlist/3 + 0.5)
      else
        OnStation = mission.patrolmission.OnStation
      end
    end
  elseif mission.typeS == 'Support' then
    if not mission.supportmission.OneThirdRule then
      if mission.supportmission.OnStation ~= 0 then
        OnStation = mission.supportmission.OnStation
      else
        OnStation = #mission.unitlist
      end
    else
      if math.floor(#mission.unitlist/3 + 0.5) > mission.supportmission.OnStation then
        OnStation = math.floor(#mission.unitlist/3 + 0.5)
      else
        OnStation = mission.supportmission.OnStation
      end
    end
  elseif mission.typeS == 'Strike' then
    local flights = mission.strikemission.Strike.StrikeMax
    
    if flights == 'NoPreferences' then
      OnStation = #mission.unitlist
    else
      local number = flights:match("Flight_x(%d)")
      if number then
        OnStation = tonumber(number) * mission.strikemission.Strike.StrikeGroupSize 
      end
    end
  end
  return {mType =mission.typeS, id=mission.guid,mSubType=mission.subtype, mTag=GetMissionType(mission), ToT=mission.TimeOnTargetStation, takeOff=mission.TakeOffTime, startT=startT, endT=endT, OnStation = OnStation, isActive=mission.isactive}

end
function GetWeaponInfo(weapon_dbid)
  local weapon = ScenEdit_QueryDB('weapon',weapon_dbid)
  if weapon then
    
    local row = {type=weapon.subtype,ranges=weapon.ranges, targets=weapon.validTargetList, dbid=weapon_dbid}
    return row
  end
  return ''
end
local function GetMagazines(unit)
  
  local types = {[2001]=true,[2007]=true,[4001]=true,[5000]=true,[5001]=true,[8001]=true}
  local mags = {}
  local u_mags = unit.magazines
  if u_mags and #u_mags>0 then
    
    for _,m in ipairs(u_mags) do
      local mag_weapons = m.mag_weapons
      if mag_weapons and #mag_weapons > 0 then
        for _,w in ipairs(mag_weapons) do
        local weapon = ScenEdit_QueryDB( 'weapon', w.wpn_dbid  )
        if types[weapon.subtypeN] then
          if not mags[w.wpn_name] then 
            mags[w.wpn_name] = {qty=w.wpn_current, max = w.wpn_maxcap}
            if not dweapons[w.wpn_name] then
              local row = GetWeaponInfo(w.wpn_dbid)
              dweapons[w.wpn_name] = {row}
            end
          else 
            mags[w.wpn_name].qty = mags[w.wpn_name].qty + w.wpn_current 
          end
        end
      end
      end
      
    end
  end
  return mags
end
local function GetWeapons(unit)
  local loadout_name = ''
  local loadout_role = ''
  local mountsData = {}
  local types = {[2001]=true,[2007]=true,[4001]=true,[5000]=true,[5001]=true,[8001]=true}
  local data_weapons = {}
  local areWeapons = false
  if unit.type == 'Aircraft' then
    local weapons = ScenEdit_GetLoadout({unitname = unit.guid})
    if weapons.roles then
      loadout_role = weapons.roles.role
    else
      loadout_role = 1001
    end
    if weapons and weapons.weapons then
      loadout_name = weapons.name
      local loads = {}
      for k3,w in ipairs(weapons.weapons) do
        if types[w.wpn_type] then
          areWeapons = true
          
          if data_weapons[w.wpn_name] then
            data_weapons[w.wpn_name].qty = data_weapons[w.wpn_name].qty + w.wpn_current
          else
            data_weapons[w.wpn_name] = {qty=w.wpn_current ,max=w.wpn_maxcap}
            if not dweapons[w.wpn_name] then
              local row = GetWeaponInfo(w.wpn_dbid)
              dweapons[w.wpn_name] = {row}
            end
          end
        end
      end
    end

  else 
    local mounts = unit.mounts
    if mounts then
      for _,m in ipairs(mounts) do
        local wpns = m.mount_weapons
        if wpns then
          for k3,w in ipairs(wpns) do
            if types[w.wpn_type] and w.wpn_current > 0 then
              areWeapons = true
              if not mountsData[m.mount_guid] then
                mountsData[m.mount_guid] = {fill=0, name=m.mount_name, dbid=m.mount_dbid, weapons={}}
              end
              mountsData[m.mount_guid].fill = mountsData[m.mount_guid].fill + w.wpn_current
              table.insert(mountsData[m.mount_guid].weapons,w)
              if not dweapons[w.wpn_name] then
                local row = GetWeaponInfo(w.wpn_dbid)
                dweapons[w.wpn_name] = {row}
              end
              if data_weapons[w.wpn_name] then
                data_weapons[w.wpn_name].qty = data_weapons[w.wpn_name].qty + w.wpn_current
              else
                data_weapons[w.wpn_name] = {qty=w.wpn_current, dbid=w.wpn_dbid}
              end
              if not dweapons[w.wpn_name] then
                local row = GetWeaponInfo(w.wpn_dbid)
                dweapons[w.wpn_name] = {row}
              end
            end
          end
        end
      end
    end
  end
  return data_weapons,loadout_name, areWeapons, loadout_role, mountsData
end

local function EvaluateAmmo(unit)
  local types = {[2001]=true,[4001]=true,[5001]=true,[8001]=true}
  local d_mount = {}
  local state = ''
  local loadout_name =  ''
  if unit.type ~= 'Aircraft' and #unit.mounts > 0 then

    for k,v in ipairs(unit.mounts) do

      local wpns = v.mount_weapons
      for _,w in ipairs(wpns) do
      if types[w.wpn_type] then
        if d_mount[v.mount_guid] == nil then
            d_mount[v.mount_guid]={fill=0, name=v.mount_name}
        end
        if weapons[w.wpn_dbid] == nil then weapons[w.wpn_dbid] = w.wpn_current else weapons[w.wpn_dbid] = weapons[w.wpn_dbid] + w.wpn_current end
        local f = w.wpn_current /w.wpn_maxcap
        d_mount[v.mount_guid].fill = f + d_mount[v.mount_guid].fill
        end
      end
    end
    local total = 0
    local nm = 0
    for k,v in pairs(d_mount) do
        total = v.fill + total
        nm = nm+1
    end
    if nm ~= 0 then
      state = string.format("%.2f",100*(total/nm)).. '%'
    end
  elseif unit.type=='Aircraft' then
    local weapons = ScenEdit_GetLoadout({unitname = unit.guid})
    
    if weapons and weapons.weapons then
      loadout_name = weapons.name
      local loads = {}
      for k3,w in ipairs(weapons.weapons) do
        if types[w.wpn_type] then
          local f = w.wpn_current /w.wpn_maxcap
          table.insert(loads,f)
        end
      end
      if #loads >0 then
        local total = 0
        for _,f in ipairs(loads) do
          total = total + f
        end
        state = string.format("%.2f",100*(total/#loads)).. '%'
      end
    end
  end
  
  return state, loadout_name
  

end

local function GetMissionData()
  local missions = ScenEdit_GetMissions(ScenEdit_PlayerSide())
  local missionData = {}
  local missionSet = {}
  local activeMission = 'Unassigned'
  missionData[activeMission]={missionList = {} }
  for k,v in ipairs(missions) do
    
    if v.subtype == 'Task Pool' then
      missionData[v.name]={missionList = {} }
      for _,m in ipairs(v.packagelist) do        
          missionData[v.name].missionList[m.name] = GetMissionInfo(m.guid)
          missionSet[m.guid] = true                  
      end
    end
    ::continue::
  end
  missionData['No TaskPool'] = {missionList={}}
  for k,v in ipairs(missions) do
    if not missionSet[v.guid]  and v.subtype ~= 'Task Pool' then
      missionData['No TaskPool'].missionList[v.name] = GetMissionInfo(v.guid)
    end
  end
  for k,v in pairs(missionData) do
    if not next(v.missionList) then missionData[k] = nil end
  end
  return missionData
end

local function GetFuel(unit)
  local fuel = ''
  if unit.fuel ~= nil then
        for k,f in pairs(unit.fuel) do
          if unit.type == 'Aircraft' then
            if k < 3000 then
              fuel = string.format("%.2f",100*(f.current/f.max)) .. '%'
            end
          else
            if k > 3000 then
              fuel = string.format("%.2f",100*(f.current/f.max)) .. '%'
            end
          end
        end
      end
  return fuel
end

local function GetUnitData()
  local side = ScenEdit_PlayerSide()
  local s = VP_GetSide({ name = side })
  local dataAirbases = {}
  local data = {}
  dweapons = {}

  for _, v in pairs(s.units) do
      local unit = ScenEdit_GetUnit({ guid = v.guid })
      if unit and unit.type ~= 'Group' and unit.type ~= 'Weapon' then
          local row = {
              id = unit.guid,
              name = unit.name,
              proficiency = unit.proficiency,
              unitType = unit.type,
              dbid = unit.dbid,
              unitSubtype = unit.subtype,
              classname = unit.classname,
              lat = string.format("%.5f", unit.latitude),
              lon = string.format("%.5f", unit.longitude),
              heading = unit.heading,
              EMCON = ScenEdit_GetDoctrine({guid=unit.guid, actual=true}).emcon,
              isOutOfComms = unit.outOfComms,
              isJammed = unit.jammed,
              isJamming = unit.jammer,
              damage = unit.damage,
              state = unit.unitstate,
          }
          if unit.type == 'Aircraft' then print(row) end
          -- Conditionally add elements
          local fuel = GetFuel(unit)
          if fuel and fuel ~= '' then
              row.fuel_status = fuel
          end

          if unit.base ~= nil then
              row.base = unit.base.name
              if unit.base.type == 'Group' or unit.base.type == 'Facility' then
                  if not dataAirbases[unit.base.guid] then
                      dataAirbases[unit.base.guid] = {name=unit.base.name, id=unit.base.guid, lat=string.format("%.5f", unit.base.latitude), lon=string.format("%.5f", unit.base.longitude)}
                  end
              end
          end

          if unit.group ~= nil then
              row.group = unit.group.name
              if unit.group.lead == unit.guid then
                  row.lead = 'YES'
              end
          end

          if unit.mission ~= nil then
              row.mission = unit.mission.name
          end

          local condition = unit.condition
          local timeToReady_seconds = unit.readytime_v
          if condition and condition ~= '' then
              if timeToReady_seconds and timeToReady_seconds > 0 then
                  row.condition = 'Readying'
                  row.readytime = formatTime(timeToReady_seconds)
                  row.timeToReady_s = timeToReady_seconds
              else
                  row.condition = condition
              end
          end
          
          local weapons, loadout, areWeapons, role, mounts = GetWeapons(unit)
          if weapons then
              row.weapons = weapons
          end
          if loadout and loadout ~= '' then
              row.loadout = loadout
          end
          if role and role ~= '' then
              row.loadout_role = role
          end

          local mags = GetMagazines(unit)
          if mags and not (type(mags) == 'table' and next(mags) == nil) then
              row.magazines = mags
          end

          if string.find(unit.classname, 'Single-Unit') then
              dataAirbases[unit.guid] = {name=unit.name, id=unit.guid, lat=string.format("%.5f", unit.longitude), lon=string.format("%.5f", unit.longitude)}
          end

          -- NCU and OODA logic
          if not areWeapons and unit.type == 'Facility' and #unit.sensors == 0 then
              row.NCU = 'true'
          else
              row.NCU = 'false'
              if unit.OODA ~= nil then
                  row.OODA = unit.OODA
              end
          end
          
          table.insert(data, row)

      elseif unit and unit.type == 'Group' and unit.group.type == 'AirBase' then
          if not dataAirbases[unit.guid] then
              dataAirbases[unit.guid] = {name=unit.name, id=unit.guid, lat=string.format("%.5f", unit.latitude), lon=string.format("%.5f", unit.longitude)}
          end
      end
  end
  return data, dweapons, dataAirbases
end

local function UserDefinedKeyAssets(json)

  if json then
    print(json)
    local KeyAssets = json
    ScenEdit_SetKeyValue('KEYASSETS',KeyAssets)
  else
    local KeyAssets = ScenEdit_GetKeyValue('KEYASSETS')
    if KeyAssets == "" then
        return "[]"
    else
        return KeyAssets
    end
  end
end

local function OODAAverageValues(json)
  if json then
    print(json)
    local OODAAverageValues = json
    ScenEdit_SetKeyValue('OODAAVERAGEVALUES',OODAAverageValues)
  else
    local OODAAverageValues = ScenEdit_GetKeyValue('OODAAVERAGEVALUES')
    if OODAAverageValues == "" then
      return "{}"
    end
    return OODAAverageValues
  end
end
-- print(AuxFunctions.TableToJson(data))
-- print('------------------------------------------')


-- print(AuxFunctions.TableToJson(dmissions))
-- print('------------------------------------------')

-- ScenEdit_SpecialMessage(side,string.format(tmp,AuxFunctions.TableToJson(data),AuxFunctions.TableToJson(dmissions)))
local unitData, weaponData, airbaseData = GetUnitData()
local misisonData = GetMissionData()
print("----------------------------")
local tmp = [[const unitData=%s;

        const missionData = %s;

        const weaponData = %s;

        const airbaseData = %s;

        const currentISOTime = "%s";

        let userDefinedKeyAssets = %s;

        let oodaAverages = %s;
]]
local isoDate = os.date("!%Y-%m-%dT%H:%M:%SZ",ScenEdit_CurrentTime())

local data = string.format(tmp,AuxFunctions.TableToJson(unitData),AuxFunctions.TableToJson(misisonData),AuxFunctions.TableToJson(weaponData),AuxFunctions.TableToJson(airbaseData),isoDate, UserDefinedKeyAssets(),OODAAverageValues())

--print(data)
local html = string.format(html_tmp,data)

-- print(html)
ScenEdit_SpecialMessage('playerside',html)


end


--BlueSetup-lua


local JR_BON = 1
if bL3.RED.NKE.EWAI then
  JR_BON = 0.8
end
local function AddActiveUnit(unit, jam_resistance)

  local jr = math.random(0,10)
  if jam_resistance then jr = jam_resistance end
  local row = {name=unit.name, type=unit.type, subtype=unit.subtype, guid=unit.guid,lat=unit.latitude, longitude=unit.longitude, OODA = unit.OODA, jamresistance = jr*JR_BON}
  bL3.BLUE.ActiveUnits[unit.guid] = row
  if unit.dbid == 4883 then
    if not bL3.BLUE.NKE.EA37 then
      bL3.BLUE.NKE.EA37={}  
    end
    bL3.BLUE.NKE.EA37[unit.guid] = {name=unit.name}
  end

  
  
end
local function AITargeting(unit)
  local targeting = unit.OODA.targeting
  targeting = math.floor(targeting*(math.random(50,75)/100))
  unit.OODA = {detection = unit.OODA.detection, targeting = targeting, evasion = unit.OODA.evasion}
end
function bL3.Functions.ReloadDDG(unit)
  local vls_32, vls_64 
  for k,v in pairs(unit.mounts) do
    if string.find(v.mount_name,'64 Cells') then
      vls_64 = v.mount_guid
      for _,w in ipairs(v.mount_weapons) do
        ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=w.wpn_current, remove=true} )
      end
    elseif string.find(v.mount_name,'32 Cells') then
      vls_32 = v.mount_guid
      for _,w in ipairs(v.mount_weapons) do
        ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=w.wpn_current, remove=true} )
      end
    end
  end
  ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=vls_32, wpn_dbid=15, number=8} )
  ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=vls_32, wpn_dbid=1194, number=24} )
  ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=vls_64, wpn_dbid=3541, number=42} )
  ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=vls_64, wpn_dbid=2692, number=12} )
  ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=vls_64, wpn_dbid=3256, number=6} )
  ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=vls_64, wpn_dbid=993, number=4} )

end
local function ReloadTyphon(unit)
  for k,v in pairs(unit.mounts) do
    local weapons = v.mount_weapons
    if weapons then
      for _, w in ipairs(weapons) do
        if w.wpn_dbid == 3772 then
          ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=3772, number=w.wpn_maxcap} )
        else
          ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=w.wpn_dbid, number=w.wpn_maxcap, remove=true} )
          ScenEdit_AddReloadsToUnit( { side= unit.side , guid=unit.guid, mount_guid=v.mount_guid, wpn_dbid=3772, number=w.wpn_maxcap} )
        end
      end
    end
  end
  if unit.magazines then
    for k,v in ipairs(unit.magazines) do
      if #v.mag_weapons > 0 then
        if v.mag_dbid ~= 0 then
          for _,w in ipairs(v.mag_weapons) do
            if w.wpn_dbid ~= 3772 then
              ScenEdit_AddWeaponToUnitMagazine( { guid = unit.guid, wpn_dbid=w.wpn_dbid, remove=true, number=w.wpn_current } )
            else
              ScenEdit_AddWeaponToUnitMagazine( { guid = unit.guid, wpn_dbid=w.wpn_dbid, remove=false, number=w.wpn_maxcap } )
            end
          end
        end
      end
    end
  end

end
local function ReloadSSN(unit)
  if unit.dbid == 567 then
    for k, v in ipairs(unit.magazines) do
      if v.mag_dbid == 1440 then
        for _,row in ipairs(v.mag_weapons) do
          if row.wpn_dbid== 810 then
            ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid =810, number = 12, remove=true})
          elseif row.wpn_dbid== 2942 then
            ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid = 2942, number = 12})
          end
        end
      end
    end
  else
    for k, v in ipairs(unit.magazines) do
      if v.mag_dbid == 1439 then
        for _,row in ipairs(v.mag_weapons) do
          if row.wpn_dbid== 810 then
            ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid =810, number = 12, remove=true})
          elseif row.wpn_dbid== 2942 then
            ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid = 2942, number = 12})
          elseif row.wpn_dbid == 1712 then
            ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid = 1712, number = 8})
          end
        end
      end
    end
  end
end
function bL3.Functions.DeployLandUnit(unit_dbid,lat,lon,k,unit_type)
  local deception = bL3.BLUE.NKE.MilDeception
  local threshold = 0.4
  local unit = ScenEdit_AddUnit({type='Facility', name='Facility #'..k, side='BLUE', dbid=unit_dbid, latitude=lat, longitude=lon, autodetectable=false})
  if not unit then return false end
  if not unit:inArea({'RP1','RP2','RP3','RP4'}) then
    unit:delete()
    return false
  end
  local resJam = math.random(10,20)
  if unit.dbid == 4289 then resJam = math.random(30,40) end
  local heading = 0
  if unit then SE_SetUnit({guid=unit.guid, newName=unit.classname..' #'..k}) end
  if unit_dbid == 3288 then -- Typhon
    ReloadTyphon(unit)
  elseif unit_dbid==3215 then -- THAAD
    heading = math.random(265,275)
    resJam = math.random(25,35)
  elseif unit_dbid == 2506 then -- Patriot
    heading = 269
    for _,mount in ipairs(unit.mounts) do
      if mount.mount_dbid == 816 then
        ScenEdit_UpdateUnit({guid = unit.guid, mode='remove_mount', mountid=mount.mount_guid})
      end
    end
    ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid =642, number = 16, remove=true})
  elseif unit_dbid == 3380 then -- HIMARS
    ScenEdit_AddWeaponToUnitMagazine({guid=unit.guid, wpn_dbid =3843, number = 10, remove=true})
  elseif unit_dbid == 3427 then -- PJ-10
    ScenEdit_UpdateUnit({guid = unit.guid, mode='add_magazine', dbid=1185})
    ScenEdit_AddWeaponToUnitMagazine( { guid=unit.guid, wpn_dbid=305, number=8, new=true } )
  elseif unit_dbid == 3860 then -- NSM
    ScenEdit_UpdateUnit({guid = unit.guid, mode='add_magazine', dbid=1185})
    ScenEdit_AddWeaponToUnitMagazine( { guid=unit.guid, wpn_dbid=299, number=8, new=true } )
  end
  ScenEdit_SetUnit({guid = unit.guid, heading = heading})
  AddActiveUnit(unit,resJam)
  if deception and math.random() > 0.4 and (unit_type == 'RADAR' or unit_type== 'LRF' or unit_type == 'SAM')   then
    ::redoDecoyPosition::
    local decoy_position = World_GetPointFromBearing({latitude=unit.latitude, longitude=unit.longitude, bearing=math.random(359), distance=math.random(5,25)})
    if World_GetElevation(decoy_position) < 5 then goto redoDecoyPosition end
    local decoy = ScenEdit_AddUnit({type='Facility', name='Decoy #'..bL3.AuxFunctions.RandomTxt(4), side='BLUE DECOY', dbid=unit_dbid, latitude=decoy_position.latitude, longitude=decoy_position.longitude, autodetectable=false})
    if unit_type == 'RADAR' or unit_type == 'SAM' then
      ScenEdit_SetEMCON('unit',decoy.guid,'Radar=Active')
      bL3.AuxFunctions.MakeUnitDecoy(decoy,true)
    else
      bL3.AuxFunctions.MakeUnitDecoy(decoy,false)
    end
    
  end
  if bL3.BLUE.NKE.ExtendedNIFC and unit.dbid == 4289 then
    for _,x in ipairs({318,294,346,458}) do
      ScenEdit_UpdateUnit({guid=unit.guid, mode='add_comms', dbid=x})  
    end    
  end
  return true
end

function bL3.Functions.DeployShipUnit(unit_dbid,lat,lon,k)
  local unit = ScenEdit_AddUnit({type='Ship', name='FF #'..k, side='BLUE', dbid=unit_dbid, latitude=lat, longitude=lon})
  if not unit then return false end
  if not unit:inArea({'RP1','RP2','RP3','RP4'}) then
    unit:delete()
    return false
  end
  local resJam = math.random(30,40)
  if unit then SE_SetUnit({guid=unit.guid, newName=unit.classname..' #'..k}) end
  if unit_dbid == 2718 then
    bL3.Functions.ReloadDDG(unit)
    resJam = math.random(80,90)
    ScenEdit_AddUnit({type='Aircraft', name='HSM-'..math.random(35,100), dbid=5338, side='BLUE', loadoutid=3, base=unit.guid})
    ScenEdit_FillMagsForLoadout({unit=unit.guid, loadoutid=1100, quantity=5})

  end
  AddActiveUnit(unit,resJam)
end
function bL3.Functions.DeploySub(unit_dbid,lat,lon,k)
  local unit = ScenEdit_AddUnit({type='Sub', name='SSN Seawolf #'..k, side='BLUE', dbid=unit_dbid, latitude=lat, longitude=lon})
  if not unit then return false end
  if not unit:inArea({'RP1','RP2','RP3','RP4'}) then
    unit:delete()
    return false
  end
  local resJam = 120
  if unit then SE_SetUnit({guid=unit.guid, newName=unit.classname..' #'..k}) end
  ReloadSSN(unit)
end
function bL3.Functions.BLUENKE(id)
  local actions = {
    [1] = function ()
      bL3.BLUE.NKE.EMDefense= true 
    end,
    [2] = function ()
      bL3.NKE.C2Attack(bL3.SIDES.RED) 
    end,
    [3] = function ()
      bL3.BLUE.NKE.MilDeception = true
    end,
    [4] = function ()
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_GPS Spoof', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.Functions.Capabilities("gpsSpoof")', description='The action will pop up a map in order to select the area where you want to spoof/jam the GPS signal'})
    end,
    [5] = function ()
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_Tactical Cyber Attack', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.NKE.TactCyberAttack("RED")', description='Select an enemy contact that has been class ID before proceed.'})
      bL3['RED'].NKE.CyberTH = 0.25
    end,
    [6] = function ()
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_Hack UAV', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.Functions.Capabilities("HackUAV")', description='The action will pop up a map in order to select the point to deploy your UAV/UCAV jammer'})
    end,
    [7] = function ()
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_Activate EM Attack', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.Functions.EMAttack("RED")', description='The action will degrade enemy OODA loop near Luzon, depending on enemy EM defense. The duration of the effect depends on enemy capabilities'})
      bL3.BLUE.NKE.EMAttack = true
    end,
    [8] = function ()
      bL3.BLUE.NKE.NetworkResilience = true 
    end,
    [9] = function ()
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_Deploy Helios Balloon', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.Functions.Capabilities("DeployHelios")'})
    end,
    [10] = function ()
      bL3.BLUE.NKE.SatelliteIntelligence = true
      ScenEdit_AddUnit({type='Satellite', name="USA 274 P/L 1", side=bL3.SIDES.BLUE, dbid=30, orbit='17'})
      ScenEdit_AddUnit({type='Satellite', name="SkySat C3", side=bL3.SIDES.BLUE, dbid=111, orbit='3'})
    end,
    [11] = function ()
      bL3.BLUE.NKE.SecureComms = true 
    end,
    [12] = function ()
      bL3.BLUE.NKE.NetworkInfiltration = true
    end,
    [13] = function ()
      bL3.BLUE.NKE.NetworkSecurity = true
    end,
    [14] = function ()
      bL3.BLUE.NKE.HUMINT = true
      bL3.Functions.DeployHumint('BLUE')
    end,
    [15] = function ()
      bL3.BLUE.NKE.AITargeting = true
    end,
    [16] = function ()
      bL3.BLUE.NKE.MilIntelligence = true 
      local t = os.date(bL3.DATEFORMAT , ScenEdit_CurrentTime() + math.random(20,180) )
      local script = "bL3.MSG.ShowIPB('RED')"
      bL3.AuxFunctions.TimeEvent('MILREP',t,script,'add')
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_MilitaryIPB', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText=script, description='Replay Mil IPB'})
    end,
    [17] = function ()
      ScenEdit_AddSpecialAction({ActionNameOrID='NKE_Communication Jamming', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.Functions.Capabilities("CommJamming")', description='The action will degrade enemy communications near Luzon, depending on enemy comms security. The duration of the effect depends on enemy capabilities'})
    end,
    [18] = function ()
      ScenEdit_AddUnit({type='Ship', side=bL3.SIDES.BLUE, name='SBX 1', dbid=2100, latitude=10+math.random(-100,100)/80, longitude=127+math.random(-100,100)/110})
    end,
    [19] = function ()
      for k,v in pairs(bL3.RED.ActiveUnits) do
        v.jamresistance = v.jamresistance * 0.8
        bL3.RED.ActiveUnits[k] = v
      end
    end,
    [21] = function ()
      bL3.Functions.DeploySIGINT()
    end,
    [22] = function()
      bL3.BLUE.NKE.ExtendedNIFC = true
    end
  }
  local action = actions[id]
  if action then
    action()
  end

end
function bL3.Functions.DeploySIGINT()
  local locations = {
    {latitude='15.8549729036945', longitude='120.116330788871'},
    {latitude='16.8220680010504', longitude='120.668703754876'},
    {latitude=18.2138770850946, longitude=120.919083519328},
    {latitude='13.4861901625284', longitude='120.395476142581'}
  }
  for _, c in ipairs(locations) do
    local sigint = ScenEdit_AddUnit({side='BLUE', type='Facility', name='SIGINT #'..bL3.AuxFunctions.RandomTxt(4), dbid=153, latitude=c.latitude, longitude=c.longitude})

    ScenEdit_UpdateUnit({guid=sigint.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=6544})
    ScenEdit_UpdateUnit({guid=sigint.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=6497})
    ScenEdit_UpdateUnit({guid=sigint.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=5272})
  end

end
function bL3.Functions.BlueSetup(JSON)
  
  bL3.BLUE.UNITS = {}
  bL3.BLUE.ActiveUnits = {}
  bL3.BLUE.ATTRITION = {Aircraft={CURRENT=0, TOTAL=0},Land={CURRENT=0, TOTAL=0},Sea={CURRENT=0, TOTAL=0}}
  bL3.BLUE.JammedUnits = {}
  bL3.BLUE.EMUnits = {}
  bL3.BLUE.NKE={}
  bL3.BLUE.NKE.EMAttack = false 
  bL3.BLUE.NKE.EMDefense= false 
  bL3.BLUE.NKE.NetworkResilience = false
  bL3.BLUE.NKE.SatelliteIntelligence = false
  bL3.BLUE.NKE.SecureComms = false
  bL3.BLUE.NKE.NetworkInfiltration = false
  bL3.BLUE.NKE.NetworkSecurity = false 
  bL3.BLUE.NKE.HUMINT = false
  bL3.BLUE.NKE.AITargeting = false
  bL3.BLUE.NKE.MilIntelligence = false
  bL3.BLUE.NKE.ExtendedNIFC = false
  bL3.BLUE.NKE.CyberTH = 0.3
  bL3.BLUE.SETUP_JSON = JSON
  bL3.BLUE.SETUP = gKH.json.parse(JSON)
  
  print("BLUE INITIAL SET")
  local data = bL3.BLUE.SETUP
  local airunits = data['AirUnits']
  local landunits = data['LandSeaUnits']
  local capabilities = data['Capabilities']

  local loadouts = {
    [4771] = {25957,27651},
    [3835] = {26470,27441,27349,18066,33106},
    [4875] = {26462,31423,27624},
    [4879] = {3088,34898,2953},
    [4612] = {15523,13403,12075,26270},
    [4919] = {27616,25580,27623},
    [4701] = {10095,10071,30281,19388,18064},
    [6620] = {32851},
    [5759] = {30777,28507,28495,28493,30778,31617},
    [4893] = {27438,13395},
    [6905] = {21785,21788}
  }
  local us_callasigns = {"Ghost","Shadow","Maverick","Avalanche","Cyclone","Hammer","Avalanche","Phoenix","Razor","Banshee","Nomad","Wraith","Tempest","Spectre","Valkyrie","Corsair","Renegade","Titan","Sabre","Sentinel","Rendezvous","Serpent","Gryphon","Nightshade","Cyclone","Eclipse","Warlock","Wally","Boar","Brick","Blaze","Viper","Death","Lando","Solo","Sky"}
  --First read capabilities in order to setup units according this ones 
  for k,v in ipairs(capabilities) do
    print('Adding '..v.name)
    bL3.Functions.BLUENKE(v.capability_id)    
    bL3.NKE.LogAction('BLUE',string.format('Blue select %s capability',v.name))
  end
  local airbases_used = {}
  local airCallAssigns = {}
  local resJam = math.random(5,20)
  for k,v in ipairs(airunits) do
      local n_units = 1
      local n = math.random(#us_callasigns)
      local callasign
      if airCallAssigns[v.unit_dbid] == nil then
        callasign = table.remove(us_callasigns, n)
        airCallAssigns[v.unit_dbid] = {n=1, callasign=callasign}
      else
        callasign = airCallAssigns[v.unit_dbid].callasign
      end
      
      if v.type == 'AIR FIGHTERS' then n_units = 12 end
      for i=1,n_units do
        local unit = ScenEdit_AddUnit({type='Air', name=callasign..' #'..airCallAssigns[v.unit_dbid].n, side='BLUE', dbid=v.unit_dbid, loadoutid=3, base=v.base_name})
        airCallAssigns[v.unit_dbid].n = airCallAssigns[v.unit_dbid].n + 1
        if unit then
          if bL3.BLUE.NKE.AITargeting then AITargeting(unit) end
          if unit.dbid == 5436 or unit.dbid == 4883 then --E-7 E-37B
            resJam = math.random(50,70) 
          elseif unit.dbid == 4328 or unit.dbid == 5877 or unit.dbid == 5759 then -- RQ-180, P-8, RC-135
            resJam = math.random(45,55) 
          elseif unit.dbid == 3853 then -- E-3G
            resJam = math.random(40,50) 
          elseif unit.dbid == 4701 or unit.dbid == 4875 or unit.dbid == 4835 then -- F-35, F-22
            resJam = math.random(30,40) 
          end
          AddActiveUnit(unit, resJam)
          if bL3.BLUE.NKE.ExtendedNIFC and unit.dbid == 4328 then
            for _,x in ipairs({318,294,346,458}) do
              ScenEdit_UpdateUnit({guid=unit.guid, mode='add_comms', dbid=x})  
            end
          end
        end
      end
      local mag_loadouts = loadouts[v.unit_dbid]
      if mag_loadouts and #v.base_name>0 then
        for _,loadoutid in ipairs(mag_loadouts) do
          ScenEdit_FillMagsForLoadout({unit=v.base_name, loadoutid=loadoutid, quantity=math.floor(n_units*1.2)})  
        end
      end
      airbases_used[v.base_name] = true
  end
  for k,v in pairs(airbases_used) do
    local airbase = SE_GetUnit({name=k, side='BLUE'})
    if airbase then
      ScenEdit_AddWeaponToUnitMagazine({guid=airbase.guid, wpn_dbid = 3567, number=200})
      ScenEdit_AddWeaponToUnitMagazine({guid=airbase.guid, wpn_dbid = 51, number=200})
      ScenEdit_AddWeaponToUnitMagazine({guid=airbase.guid, wpn_dbid = 2780, number=90})
      ScenEdit_AddWeaponToUnitMagazine({guid=airbase.guid, wpn_dbid = 945, number=90})
    end
    
  end

  local allowed_area = {
    {latitude=19.8, longitude=119, name='RP1'},
    {latitude=19.8, longitude=125.5, name='RP2'},    
    {latitude=7, longitude=125.5, name='RP3'},
    {latitude=7, longitude=119, name='RP4'},
  }
  local area = ScenEdit_AddZone('BLUE DECOY',-925,{description='AllowedArea', area=allowed_area})
  for k,v in ipairs(landunits) do
    local altitude = World_GetElevation({latitude=v.lat, longitude=v.lon})
    if v.type == 'SHIP' and altitude < -10 then
      bL3.Functions.DeployShipUnit(v.unit_dbid,v.lat,v.lon,k)
    elseif v.type == 'SUBMARINE' and altitude < -10 then
      bL3.Functions.DeploySub(v.unit_dbid,v.lat,v.lon,k)
    elseif altitude > 0 then
      local deployed = bL3.Functions.DeployLandUnit(v.unit_dbid,v.lat,v.lon,k,v.type)
      if not deployed then
        ScenEdit_SpecialMessage('playerside','There was a problem deploying '..v.unit_name) 
      end
    end
    
  end
  if VP_GetSide({side='BLUE'}):unitsBy('Aircraft') then
    bL3.BLUE.TOTAL_AIR = #VP_GetSide({side='BLUE'}):unitsBy('Aircraft')  
  end
  

  local function CreateBlueAttrition()
    
    local function AddUnit(unit)
      if unit.type ~= 'Satellite' and unit.type ~= 'Group' then
        local row = bL3.BLUEUNITS[unit.dbid]
        if not row then 
          ScenEdit_SpecialMessage('playerside','No ROW for unit: '..unit.classname) 
          print("NO ROW: "..unit.classname)
        else
          local type = unit.type
          if type == 'Facility' then 
            type = 'Land' 
          elseif type == 'Submarine' or type == 'Ship' then 
            type = 'Sea'
          end
          bL3.BLUE.ATTRITION[type].TOTAL = bL3.BLUE.ATTRITION[type].TOTAL + row.points
        end
      end
    end
    local unit_types = {'Ship','Submarine','Aircraft','Facility'}
    for _,unit_type in ipairs(unit_types) do
      local units = VP_GetSide({side='BLUE'}):unitsBy(unit_type)
      if units and next(units) then
        for k,v in ipairs(units) do
          if not bL3.BLUETARGETS[v.guid] then
            local unit = SE_GetUnit({guid = v.guid})
            if unit and not unit.group then
              AddUnit(unit)
            end
          end
        end
        if unit_type == 'Ship' or unit_type =='Submarine' then
          bL3.BLUE.ATTRITION.Sea.CURRENT = bL3.BLUE.ATTRITION.Sea.TOTAL
        elseif unit_type == 'Facility' then
          bL3.BLUE.ATTRITION.Land.CURRENT = bL3.BLUE.ATTRITION.Land.TOTAL
        else
          bL3.BLUE.ATTRITION.Aircraft.CURRENT = bL3.BLUE.ATTRITION.Aircraft.TOTAL
        end
      end
    end
  end
  CreateBlueAttrition()
  gKH.State.SaveTableToKey(bL3.BLUE,'BLUE')
  gKH.State.SaveTableToKey(bL3.RED,'RED')
  ScenEdit_SetKeyValue('DATEFORMAT',bL3.DATEFORMAT)
  ScenEdit_SetKeyValue('COMPLEXITY',bL3.COMPLEXITY)
  ScenEdit_SetKeyValue('BUDGET',bL3.BUDGET)
end
bL3.BLUE.OOB = {}
bL3.BLUE.BUDGET = tonumber(bL3.BUDGET)
local budget_bonification = 0
local penalty = 1
if bL3.COMPLEXITY == 2 then penalty = 0.9 elseif bL3.COMPLEXITY == 3 then penalty = 0.8 end
for i,v in pairs(bL3.RED.SETUP) do
  local bon = {
    ['BM'] = 20,
    ['CM'] = 10,
    ['AAWF'] = 40,
    ['s1strike'] = 75,
    ['s2strike'] = 50,
  }
  if bon[i] then
    budget_bonification = budget_bonification + bon[i]*v*penalty
  end
end
-- bL3.SCEN_VAR.BUDGET = math.max(bL3.SCEN_VAR_BUDGET,1500)
budget_bonification = math.floor(budget_bonification/100)*100
bL3.BLUE.BUDGET = bL3.BLUE.BUDGET + budget_bonification
bL3.Functions.SetupWindow()






local timeS = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+4)

local script = [[bL3.AuxFunctions.WeatherDrift(); bL3.AuxFunctions.WeatherReport(); bL3.AuxFunctions.ChangeTimeEvent('WeatherForecast',8*60*60)]]
bL3.AuxFunctions.TimeEvent('WeatherForecast',timeS,script,'add')

timeS = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+ math.random(5,10)*60 + math.random(59))
bL3.AuxFunctions.TimeEvent('J3-Logistics Msg',timeS,'bL3.MSG.Logistics()','add')

timeS = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+59*60)
bL3.AuxFunctions.TimeEvent('ReduceLoadoutTimes',timeS,'bL3.Functions.ReduceLoadoutTimes()','add')

timeS = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+60)
bL3.AuxFunctions.TimeEvent('ROE 1',timeS,'bL3.MSG.ROE1()','add')

bL3.BLUE.ROETIME = ScenEdit_CurrentTime()+4*60*60+math.random(30)*60
timeS = os.date(bL3.DATEFORMAT, bL3.BLUE.ROETIME)
local script = [[
ScenEdit_SetSpecialAction({ActionNameOrID='RE_ReplayROE',side=bL3.SIDES.BLUE, ScriptText='bL3.MSG.ROE2()'})
bL3.MSG.ROE2()
]]

bL3.AuxFunctions.TimeEvent('ROE 2',timeS,script,'add')

timeS = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + 47*60*60 + 55*60*60)
bL3.AuxFunctions.TimeEvent('End Scenario General',timeS,'bL3.Functions.EndScenario()','add')


ScenEdit_AddSpecialAction({ActionNameOrID='TOOL_UMS', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.TOOL.UMS(); return "","false"', description='Unit Management Window. Still a WIP. Submit your feedback on the discussion in the Steam Workshop Page'})
ScenEdit_AddSpecialAction({ActionNameOrID='TOOL_MailBox', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.MAIL.ShowMailBox() return "","false"', description='Show your mail box'})


ScenEdit_AddSpecialAction({ActionNameOrID='RE_ReplayOPORD', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='ScenEdit_SpecialMessage("BLUE",bL3.BLUE.OPORD) return "","false"', description='Show the Operational Order'})

ScenEdit_AddSpecialAction({ActionNameOrID='RE_ReplayROE', side=bL3.SIDES.BLUE,isActive=true, isRepeatable=true, ScriptText='bL3.MSG.ROE1() return "","false"', description='Show last ROE'})
gKH.State.SaveTableToKey(bL3.BLUE,'BLUE')
gKH.State.SaveTableToKey(bL3.RED,'RED')


--CivSetup-lua


ScenEdit_SetEMCON('side','Civilian','Radar=Active')
ScenEdit_SetEMCON('side','Civilian ','Radar=Active')
bL3.SIDES.CIV = 'Civilian'
bL3.SIDES.CIVPLA = 'Civilian '

local ships = {
  ['FV']={
    {dbid=16, prefix='FV ', category ='Commercial'}, --Commercial Fishing Boat [23m]
    {dbid=328, prefix='FV ', category ='Commercial'}, --Commercial Fishing Boat [35m]
  },
  ['MV']={
    {dbid=775, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Feeder [1600 TEU, 20000 DWT]
		{dbid=2027, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Feedermax [3000 TEU, 30000 DWT]
		{dbid=2029, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - New Panamax [13500 TEU, 155000 DWT]
		{dbid=2028, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Panamax [4500 TEU, 65000 DWT]
		{dbid=2030, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Post Panamax [9500 TEU, 105000 DWT]
		{dbid=774, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Small Feeder [100 TEU, 5750 DWT]
		{dbid=2026, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Small Feeder [750 TEU, 9500 DWT]
		{dbid=2031, prefix='MV ', category ='Commercial'}, --Commercial Container Vessel - Ultra Large [15000 TEU, 160000 DWT]
		{dbid=2775, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Capesize Size 150000 DWT]
		{dbid=2023, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Handymax Size 45000 DWT]
		{dbid=773, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Handysize 35000 DWT]
		{dbid=2774, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Panamax Size 75000 DWT]
		{dbid=1001, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Small Handysize, Helo Deck 25000 DWT]
		{dbid=1374, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Small Handysize 25000 DWT]
		{dbid=2773, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Supramax Size 55000 DWT]
		{dbid=2776, prefix='MV ', category ='Commercial'}, --Commercial Dry-Bulk Carrier [Very Large Size 200000 DWT]
  },
  ['MT']={
    {dbid=144, prefix='MT ', category ='Commercial'}, --Commercial Tanker - General Purpose [20000 DWT]
		{dbid=339, prefix='MT ', category ='Commercial'}, --Commercial Tanker - Large Range 1 [75000 DWT]
		{dbid=275, prefix='MT ', category ='Commercial'}, --Commercial Tanker - Large Range 2 [150000 DWT]
		{dbid=145, prefix='MT ', category ='Commercial'}, --Commercial Tanker - Medium Range [40000 DWT]
  }
  
}
local center = {latitude=15.111683, longitude=114.78993}
local LuzonBay = {latitude=14.57789, longitude=120.789841}
local southR = {
  {latitude=12.8293, longitude=117.8790},
  {latitude=11.565, longitude=115.4040},
  {latitude=8.94183, longitude=115.8422},
  {latitude=4.54077, longitude=112.16482}
}
local eastR = {latitude=15.23497, longitude=134.78087}
local westR = {latitude=13.412514, longitude=109.9078}
local northR = {
  {latitude=21.6272, longitude=118.0016},
  {latitude=22.5797, longitude=118.53270},
  {latitude=25.759, longitude=120.70690},
  {latitude=31.0368, longitude=124.43103}
}

for i=1, math.random(1,3) do
  local p = World_GetPointFromBearing({latitude=LuzonBay.latitude, longitude=LuzonBay.longitude, bearing=math.random(359), distance=math.random(4)+math.random()})

  local u = ScenEdit_AddUnit({type='Ship',side=bL3.SIDES.CIVPLA, name='FV #'..bL3.AuxFunctions.RandomTxt(5), dbid=ships['FV'][math.random(2)].dbid, latitude=p.latitude, longitude = p.longitude})
  ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=6029})
  ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=1049})
  ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=4598})
  bL3.AuxFunctions.SetUnitCourse(u,'2N1SE3W1SW2NE1SW',5)
  p = World_GetPointFromBearing({latitude=LuzonBay.latitude, longitude=LuzonBay.longitude, bearing=math.random(359), distance=math.random(4)+math.random()})
  local u = ScenEdit_AddUnit({type='Ship',side=bL3.SIDES.CIV, name='FV #'..bL3.AuxFunctions.RandomTxt(6), dbid=ships['FV'][math.random(2)].dbid, latitude=p.latitude, longitude = p.longitude})
  
end

local pos = {
  {latitude=16.858738, longitude=119.6426544},
  {latitude=15.425242, longitude=119.5000559},
  {latitude=14.0813660, longitude=120.18045},
  {latitude=18.4086171, longitude=119.385867},
  {latitude=16.37702, longitude=119.3608},
  {latitude=14.276678, longitude=119.3501},
  {latitude=14.10608, longitude=120.3083},
  {latitude=13.404421, longitude=119.9265},
  {latitude=19.245060, longitude=120.7748},
}
for k,v in ipairs(pos) do
  if math.random() > 0.6 then goto continueFor end
  local autodetectable = true
  if math.random() > 0.9 then
    autodetectable = false
  end
  local u = ScenEdit_AddUnit({type='Ship',side=bL3.SIDES.CIVPLA, name='MV #'..bL3.AuxFunctions.RandomTxt(5), dbid=ships['MV'][math.random(2)].dbid, latitude=v.latitude+math.random(-100,100)/500, longitude = v.longitude+math.random(-100,100)/500, heading=math.random(359), autodetectable=autodetectable})
  ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=6029})
  ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=1049})
  ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=4598})
  ScenEdit_SetUnit({guid = u.guid, manualThrottle=1})
  u.speed = 5
  ::redoP2::
  local p = World_GetPointFromBearing({latitude=v.latitude, longitude=v.longitude, bearing=math.random(359), distance=math.random(5,10)+math.random()})
  if World_GetElevation(p) > -20 then goto redoP2 end
  bL3.AuxFunctions.SetUnitCourse(u,'15N25S15W12E25N12S25W12E25N13S15W9E7N7S11W25E11N25S25W25E',math.random(15,35))
  local autodetectable = true
  if math.random() > 0.9 then
    autodetectable = false
  end
  u = ScenEdit_AddUnit({type='Ship',side=bL3.SIDES.CIV, name='MV #'..bL3.AuxFunctions.RandomTxt(5), dbid=ships['MV'][math.random(2)].dbid, latitude=p.latitude, longitude = p.longitude, autodetectable=autodetectable})
  local course = {}
  local route
  if u.latitude > center.latitude then
    route = southR
  else
    route = northR
  end
   
  for _,r in ipairs(route) do
    p = {latitude=r.latitude + math.random(-1000,1000)/1500, longitude=r.longitude+ math.random(-1000,1000)/750}
    table.insert(course,p)
  end
  ScenEdit_SetUnit({guid = u.guid, course=course, manualThrottle=1})

  ::continueFor::
end

for i=1,math.random(24,96) do
  ::redoP::
  local p = World_GetPointFromBearing({latitude=center.latitude, longitude=center.longitude, bearing=math.random(359), distance=math.random(430)+math.random()})
  if World_GetElevation(p) > -10 then goto redoP end
  local ship = ships['MV'][math.random(#ships['MV'])]
  if math.random() > 0.2 then
    ship = ships['MV'][math.random(#ships['MV'])]
  else
    ship = ships['MT'][math.random(#ships['MT'])]
  end
  
  local autodetectable = true
  if math.random() > 0.9 then
    autodetectable = false
  end
  local u = ScenEdit_AddUnit({type='Ship',side=bL3.SIDES.CIV, name=ship.prefix..' #'..bL3.AuxFunctions.RandomTxt(6), dbid=ship.dbid, latitude=p.latitude, longitude = p.longitude, autodetectable=autodetectable, heading=math.random(359)})
  if not autodetectable then ScenEdit_SetEMCON('unit',u.guid,'Radar=Passive') end
  local course = {}
  local route
  if u.latitude > center.latitude then
    if u.longitude < center.longitude then
      bL3.AuxFunctions.SetUnitCourse(u,'20S35S20S20SE50S35SE20S20S40S35SE45SE15SW25SW',20)
    else
      bL3.AuxFunctions.SetUnitCourse(u,'40S20S35SE30S20S35SW40S25SE45S50S20S20S15SW25SW40SE15SE',20)
    end
  else
    bL3.AuxFunctions.SetUnitCourse(u,'50N5NE50NW5NE5NE35N5NE5NE34N5NE5E50N40NW25NE35NE45NW15N5N5NW35N25NW',20)
  end
  ScenEdit_SetUnit({guid = u.guid, manualThrottle=math.random(2,3)})
  
end
if math.random() > 0.5 then
  
  for i=1,math.random(2,5) do
    local autodetectable = true
    if math.random() < 0.2 then
      autodetectable = false
    end
    local position = {latitude='16.1767124332672', longitude='116.994991260388'}
    local c2guid = bL3.RED.UNITS.C2SHIP
    local p = {latitude=position.latitude+math.random(-50,50)/30, longitude=position.longitude+math.random(-100,100)/200}
    local area = bL3.AuxFunctions.NewArea(p,{side=bL3.SIDES.CIVPLA, shape='circle', distance=math.random(15,50)})
    local mission = ScenEdit_AddMission(bL3.SIDES.CIVPLA,'AGI #'..bL3.AuxFunctions.RandomTxt(5), 'patrol', {type='sea', zone=area})
    local u = ScenEdit_AddUnit({type='Ship',side=bL3.SIDES.CIVPLA, name='MV #'..bL3.AuxFunctions.RandomTxt(5), dbid=ships['MV'][math.random(2)].dbid, latitude=p.latitude+math.random(-100,100)/500, longitude = p.longitude+math.random(-100,100)/500, heading=math.random(359), autodetectable=autodetectable})
    ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=6029})
    ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=1049})
    ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'}, arc_track={'360'}, dbid=4598})
    ScenEdit_SetUnit({guid = u.guid, manualThrottle=1})
    ScenEdit_AssignUnitToMission(u.guid,mission.guid)
  end
  local th = 0.4
  if bL3.BLUE.NKE.HUMINT then
    th = th + math.random(20,30)/100
  end
  if math.random() > th then
    local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+ math.random(2,3)*60*60 + math.random(59)*60 )
    bL3.AuxFunctions.TimeEvent('HUMINT #1',time,"bL3.MSG.HUMINT1()",'add')
  end
end
local Biol_DBIDs = {
	354, --Fish
	354, --Orcas
	92, --Whale
  687,

}
local area = bL3.AuxFunctions.NewArea(center,{side='Biol', shape='circle', distance=450})
local mission = ScenEdit_AddMission('Biol','Wander','patrol',{type='sea', zone=area})
for i=1, math.random(20,60) do
  ::redoP1::
  local p = World_GetPointFromBearing({latitude=center.latitude, longitude=center.longitude, bearing=math.random(359), distance=math.random(450)+math.random()})
  if World_GetElevation(p) > -30 then goto redoP1 end
  local bio = Biol_DBIDs[math.random(#Biol_DBIDs)]
  local u = ScenEdit_AddUnit({type='submarine', name='Biol #'..bL3.AuxFunctions.RandomTxt(4), side='Biol', dbid=bio, latitude=p.latitude, longitude=p.longitude, depth=-math.random(5,100)})
  ScenEdit_AssignUnitToMission(u.guid,mission.guid)
end

ScenEdit_SetTrigger({name='RED CIV Detection Process'..'_trig',mode='add', type='UnitDetected', DetectorSideID=VP_GetSide({side=bL3.SIDES.CIVPLA}).guid})
ScenEdit_SetEventTrigger('RED Detection Process', { mode = 'add', name = 'RED CIV Detection Process_trig' })

--RedSetup-lua

--RED SETUP

--[[
 1. Choose main targets and secundary targets
 2. Deploy units, variable number of H-6s, J-15s + AKF, + DF-16/DF-11
 3. Choose a ToT, create ISR, SEAD and OCA missions based in ToT
 4. Assign unit to different missions
 5. Modify flight plan for strike missions + Relevant OCA
]]
-- ScenEdit_SetStartTime({Duration="0:2:0"})
bL3.AuxFunctions.ImprovedRandomseed()
bL3.COMPLEXITY = tonumber(bL3.COMPLEXITY)
-- Setup missions for each BLUE AB adding only Runways, Taxiways, Fuel deposits and some Hagnars

-- Function to select and enable capabilities based on weights
local function SelectCapabilities()
  -- Convert JSON string to table
  local jsonTable = gKH.json.parse(bL3.JSON.CARDS)

  -- Function to build weighted capabilities list
  local function buildWeightedList(jsonTable)
        local capability_mapping = {
          ["Electromagnetic-Attack"] = "EMAttack",
          ["Electromagnetic-Defense"] = "EMDefense",
          ["Network Resilience"] = "NetworkResilience",
          ["Satellite Intelligence"] = "SatelliteIntelligence",
          ["Secure Communications"] = "SecureComms",
          ["Network Infiltration"] = "NetworkInfiltration",
          ["Network Security"] = "NetworkSecurity",
          ["AI Targeting"] = "AITargeting",
          ["GPS Spoofing"] = "GPSSpoof",
          ["Comms Jamming"] = "CommJamm",
          ["Attack on C2"] = "C2Attack",
          ["Unmanned Hacking"] = "HackUAV",
          ["Tactical Cyber Attack"] = "CyberAttack",
          ["Enhanced EW Capabilities"] = "EnhancedEW"
      }
      local weighted_list = {}
      for _, domain in pairs(jsonTable) do
          for _, card in ipairs(domain) do
              if capability_mapping[card.title] then
                table.insert(weighted_list, { name = card.title, weight = card.value*0.8 })
              end
          end
      end
      return weighted_list
  end

  -- Function to perform weighted random selection
  local function weightedRandomSelection(weighted_list, num_to_select)
      -- Calculate total weight
      local total_weight = 0
      for _, item in ipairs(weighted_list) do
          total_weight = total_weight + item.weight
      end

      local selected_capabilities = {}
      local selected_names = {}

      -- Select capabilities
      while #selected_capabilities < num_to_select do
          local rand_value = math.random(1, total_weight)
          local running_weight = 0

          for _, item in ipairs(weighted_list) do
              running_weight = running_weight + item.weight
              if rand_value <= running_weight and not selected_names[item.name] then
                  table.insert(selected_capabilities, item.name)
                  selected_names[item.name] = true -- Avoid duplicates
                  break
              end
          end
      end

      return selected_capabilities
  end
 
  -- Function to enable selected capabilities in bL3.RED.NKE
  local function enableCapabilities(selected_capabilities)
      -- Reset all capabilities to false
      for _, cap in ipairs({
          "EMAttack", "EMDefense", "NetworkResilience", "SatelliteIntelligence",
          "SecureComms", "NetworkInfiltration", "NetworkSecurity", "AITargeting",
          "GPSSpoof", "CommJamm", "C2Attack", "HackUAV", "CyberAttack",'EnhancedEW'
      }) do
          bL3.RED.NKE[cap] = false
      end

      -- Map selected capabilities to bL3.RED.NKE
      local capability_mapping = {
          ["Electromagnetic-Attack"] = "EMAttack",
          ["Electromagnetic-Defense"] = "EMDefense",
          ["Network Resilience"] = "NetworkResilience",
          ["Satellite Intelligence"] = "SatelliteIntelligence",
          ["Secure Communications"] = "SecureComms",
          ["Network Infiltration"] = "NetworkInfiltration",
          ["Network Security"] = "NetworkSecurity",
          ["AI Targeting"] = "AITargeting",
          ["GPS Spoofing"] = "GPSSpoof",
          ["Comms Jamming"] = "CommJamm",
          ["Attack on C2"] = "C2Attack",
          ["Unmanned Hacking"] = "HackUAV",
          ["Tactical Cyber Attack"] = "CyberAttack",
          ["Enhanced EW Capabilities"] = 'EnhancedEW'
      }

      for _, cap_name in ipairs(selected_capabilities) do
          local mapped_name = capability_mapping[cap_name]
          if mapped_name then
              bL3.RED.NKE[mapped_name] = true
              bL3.NKE.LogAction('RED',string.format('Red select %s capability',cap_name))
          else
            print("Capability not mapped: "..cap_name)
          end
      end
  end
  bL3.RED.NumNKE = math.min(math.random(3,5)*bL3.COMPLEXITY,12)
  local weighted_list = buildWeightedList(jsonTable)
  local selected = weightedRandomSelection(weighted_list,bL3.RED.NumNKE) 
  enableCapabilities(selected)
end


--CAPABILITIES
bL3.RED.NKE = {}
SelectCapabilities()
-- bL3.RED.NKE.MilIntelligence = false 
-- bL3.RED.NKE.GPSSpoof = true

-- bL3.RED.NKE.C2Attack = true
-- bL3.RED.NKE.TactCyberAttack = true
-- bL3.RED.NKE.EMAttack = true
-- bL3.RED.NKE.CyberAttack = true
-- bL3.RED.NKE.DeployHelios = true

bL3.RED.MISSIONS = {}
bL3.RED.ActiveUnits = {}
bL3.RED.JammedUnits = {}
bL3.RED.EMUnits = {}
bL3.RED.UNITS = {}

bL3.SETUP = {}
local function GetTargetPriority(unit)

  if string.find(unit.name,'HEADQUARTERS') or string.find(unit.name,'Runway')  then
    return math.random(1,2)
  elseif not string.find(unit.name,'Uplink') and not string.find(unit.name, 'Power Plant') then
    return math.random(2,3)
  else
    return math.random(2,4)
  end

end
local function UnitIsATarget(unit) 
  if not unit then
    return false
  end
  
  -- Verificar cada término por separado
  if string.find(unit.name, 'Taxiway') or 
     string.find(unit.name, 'Runway') or 
     string.find(unit.name, 'Liter Tank') then
    return true
  elseif string.find(unit.name, 'Open Parking') or 
         string.find(unit.name, 'Tarmac') then
    return false
  elseif math.random() > 0.8 then
    return true
  end
  
  return false 
end
local function AITargeting(unit)
  local targeting = unit.OODA.targeting
  targeting = math.floor(targeting*(math.random(55,80)/100))
  unit.OODA = {detection = unit.OODA.detection, targeting = targeting, evasion = unit.OODA.evasion}
end
local function AddActiveUnit(unit, jam_resistance)
  local jr = 10
  if jam_resistance then jr = jam_resistance end
  local mission = '-'
  if unit.mission then
    mission = unit.mission.name
  end
  local row = {name=unit.name, type=unit.type, subtype=unit.subtype, guid=unit.guid,lat=unit.latitude, longitude=unit.longitude, mission=mission, OODA = unit.OODA, jamresistance = jr}
  bL3.RED.ActiveUnits[unit.guid]=row
end
local function SelectBeach()
  local beaches = {
    {latitude=16.22019487, longitude=120.220432},
    {latitude=14.293601828, longitude=120.503226},
    {latitude=14.731863565, longitude=120.044487},
    {latitude=14.04194, longitude=120.580255}
  }
  local destination = beaches[math.random(#beaches)]
  bL3.RED.BEACH = destination
end
SelectBeach()
local current_time = ScenEdit_CurrentTime()
local ToT_time = current_time + math.random(10,13)*60*60 + math.random(60)*60
bL3.RED.Dtime = ToT_time

local max_s1_strike

local max_s2_strike = math.random(2,5)

if bL3.COMPLEXITY == 1 then
  max_s1_strike = math.random(2,4)
  max_s2_strike = math.random(1,3)
elseif bL3.COMPLEXITY == 2 then
  max_s1_strike = math.random(3,7)
  max_s2_strike = math.random(2,4)
else
  max_s1_strike = math.random(6,9)
  max_s2_strike = math.random(3,6)
end
local n_s1_strike = 0
local n_s2_strike = 0
local total_targets = 0
bL3.RED.SETUP={BM=0,CM=0,F=0,B=0,NF=0,AAWF=0,s1strike=max_s1_strike,s2strike=max_s2_strike}

-- Strike Mission Creation
local blue_units = VP_GetSide({side='BLUE'}).units
ScenEdit_AddMission('RED', 'Strike Targets', '', {category='taskpool'})
ScenEdit_AddMission('RED', 'Strike AB', '', {category='taskpool'})

for k,v in ipairs(blue_units) do
  local u = SE_GetUnit({guid = v.guid})
  if u and u.type == 'Facility' and not u.group and n_s1_strike < max_s1_strike then -- Single Targets
    n_s1_strike = n_s1_strike +1
    local mission = ScenEdit_AddMission('RED', 'S1-'..u.name..'-#'..bL3.AuxFunctions.RandomTxt(3), 'Strike', {category='package',type='land',pool='Strike Targets'})
    ScenEdit_AssignUnitAsTarget(u.guid, mission.name)
    total_targets = total_targets + 1
    mission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, ToT_time)
    ScenEdit_SetMission('RED',mission.guid,{StrikeUseFlightSize=false, StrikeFlightSize=2})
    bL3.RED.MISSIONS[u.name]={name=mission.name, guid=mission.guid, targets={u.guid},priority=GetTargetPriority(u), lat=u.latitude, lon=u.longitude, tot=ToT_time, pool='StrikeT', type='StrikeLand'}
  elseif u and u.type ~= 'Group' and u.group and not string.find('Benito', u.group.name) and not string.find('Iloilo', u.group.name) then -- Airbase Targets
    local group = u.group.name
    local leader = SE_GetUnit({guid = u.group.lead})
    if not bL3.RED.MISSIONS[group] and n_s2_strike < max_s2_strike then
      local mission = ScenEdit_AddMission('RED', 'S2-'..group..'-#'..bL3.AuxFunctions.RandomTxt(3), 'Strike', {category='package',type='land',pool='Strike AB'})
      n_s2_strike = n_s2_strike + 1
      mission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, ToT_time)
      bL3.RED.MISSIONS[group]= {name=mission.name, guid=mission.guid, targets={}, priority=math.random(1,2), lat=leader.latitude, lon=leader.longitude, tot=ToT_time, pool='StrikeAB', type='StrikeLand'}
      ScenEdit_SetMission('RED',mission.guid,{StrikeUseFlightSize=false, StrikeFlightSize=2})
    end
    if bL3.RED.MISSIONS[group] and UnitIsATarget(u) and #bL3.RED.MISSIONS[group]['targets'] < 10 then
      local mission_name = bL3.RED.MISSIONS[group].name
      ScenEdit_AssignUnitAsTarget(u.guid, mission_name)
      table.insert(bL3.RED.MISSIONS[group]['targets'],u.guid)
      total_targets = total_targets + 1
    end
  end
end
local REDAIRBASESCLOSE = {
  {name='Shek Kong Airfield (Hong Kong)', lat=22.436667, lon=114.080278, LR = false},
  {name='Foluo Northeast Air Base (Hainan Island)', lat=18.692222, lon=109.161389, LR = false},
  {name='Guangzhou Baiyun Airport', lat=23.185556, lon=113.265278, LR = false},
  {name='Guangzhou East Airfield', lat=23.164722, lon=113.368889, LR = false},
  {name='Shadi Air Base', lat=23.083333, lon=113.070000, LR = false},
  {name='Haikou City (Hainan Island)', lat=20.018889, lon=110.346944, LR = false},
  {name='Haikou Meilan International Airport', lat=19.935556, lon=110.459444, LR = false},
  {name='Hong Kong International Airport', lat=22.208889, lon=113.919444, LR = false},
  {name='Huangtian Airport', lat=22.641944, lon=113.814167, LR = false},
  {name='Huiyang Air Base', lat=23.050000, lon=114.600000, LR = false},
  {name='Jialaishi Air Base (Hainan Island)', lat=19.697222, lon=109.726389, LR = false},
  {name='Lingshui Air Base (Hainan Island)', lat=18.494444, lon=109.987778, LR = false},
  {name='Macau International Airport', lat=22.149444, lon=113.591389, LR = false},
  {name='Mei-Xian Air Base', lat=24.265000, lon=116.100000, LR = false},
  {name='Sanya Phoenix International Airport', lat=18.303333, lon=109.411389, LR = false},
  {name='Shantou Northeast Airfield', lat=23.427222, lon=116.759167, LR = false},
  {name='Suixi Air Base', lat=21.395833, lon=110.200000, LR = false},
  {name='Yuen Long Airport', lat=22.436389, lon=114.080278, LR = false},
  {name='Zhanjiang Airport', lat=21.216944, lon=110.357778, LR = false},
  {name='Zhuhai Airport', lat=22.007500, lon=113.375833, LR = false},
}

local REDAIRBASES = {
  {name='Fouliang Air Base', lat=29.339444, lon=117.176667, LR = true},
  {name='Fuzhou Air Base', lat=26.004444, lon=119.312500, LR = true},
  {name='Ganzhou Airfield', lat=25.826944, lon=114.912500, LR = true},
  {name='Guiyang Air Base', lat=26.539444, lon=106.801389, LR = true},
  {name='Huian Air Base', lat=25.026111, lon=118.807222, LR = true},
  {name='Jinjiang Air Base', lat=24.797500, lon=118.588333, LR = true},
  {name='Liancheng Air Base Lianfeng', lat=25.674722, lon=116.747222, LR = true},
  {name='Lung-Tien Air Base', lat=25.572778, lon=119.460278, LR = true},
  {name='Longyou Air Base', lat=29.113056, lon=119.177222, LR = true},
  {name='Mahuiling Air Base', lat=29.477222, lon=115.801667, LR = true},
  {name='Nanchang New Airfield', lat=28.635556, lon=115.930000, LR = true},
  {name='Nanchang Xiangtang Air Base', lat=28.420833, lon=115.924444, LR = true},
  {name='Qingyang Air Base', lat=24.797222, lon=118.588333, LR = true},
  {name='Quzhou Airport', lat=28.967222, lon=118.898889, LR = true},
  {name='Taihe Air Base', lat=26.857222, lon=114.737222, LR = true},
  {name='Tunxi Airstrip', lat=29.732778, lon=118.257000, LR = true},
  {name='Wuyishan Air Base', lat=27.700278, lon=118.000000, LR = true},
  {name='Xiamen Gaoqi International Airport', lat=24.542500, lon=118.128611, LR = true},
  {name='Zhangshu Air Base', lat=28.021667, lon=115.550556, LR = true},
  {name='Zhangzhou Airfield', lat=24.562500, lon=117.653889, LR = true},
}
bL3.REDAIRBASES = {}
local function CreateAirbases()
  
  for i=1,math.random(3,5) do
    local dice = math.random(#REDAIRBASES)
    local base = REDAIRBASES[dice]
    table.remove(REDAIRBASES,dice)
    local ab = ScenEdit_AddUnit({type='Facility', side='RED', name=base.name, dbid=2415, latitude=26,longitude=111})
    ScenEdit_SetUnit({guid = ab.guid, latitude=base.lat, longitude=base.lon})
    for a=1,2 do
      ScenEdit_UpdateUnit({guid=ab.guid, mode='add_air_facility', dbid=22})
    end
    base['guid'] = ab.guid
    table.insert(bL3.REDAIRBASES,base)
  end
  for i=1,math.random(5,7) do
    local dice = math.random(#REDAIRBASESCLOSE)
    local base = REDAIRBASESCLOSE[dice]
    table.remove(REDAIRBASESCLOSE,dice)
    local ab = ScenEdit_AddUnit({type='Facility', side='RED', name=base.name, dbid=2415, latitude=26,longitude=111})
    ScenEdit_SetUnit({guid = ab.guid, latitude=base.lat, longitude=base.lon})
    for a=1,2 do
      ScenEdit_UpdateUnit({guid=ab.guid, mode='add_air_facility', dbid=22})
    end
    base['guid'] = ab.guid
    table.insert(bL3.REDAIRBASES,base)
  end
end
CreateAirbases()
bL3.AuxFunctions.shuffleTable(bL3.RED.MISSIONS)

bL3.POSITIONS = {}
bL3.POSITIONS.BM = {
  {latitude=19.161535, longitude=109.6572},
  {latitude=25.660, longitude=116.818019},
  {latitude=22.9880, longitude=112.7533},
  {latitude=26.41481, longitude=113.49506},
  {latitude=22.078051, longitude=107.94199},
  {latitude='25.7337247987803', longitude='118.836593841181'},
  {latitude='22.5028345285643', longitude='107.761028088366'},
  {latitude='27.212669687938', longitude='113.248191987357'}

}
bL3.POSITIONS.CM = {
  ['Facility']={ 
    {latitude=22.92504, longitude=110.7439},
    {latitude=26.15065, longitude=118.85950},
    {latitude='19.2070693040434', longitude='110.034700366132'},
    {latitude='23.5543143600411', longitude='113.966544860361'}
  },
  ['Submarine']={
    {latitude=15.28571, longitude=111.91297},
    {latitude=21.88625, longitude=127.7438},
    {latitude=21.54998, longitude=115.6293},
    {latitude=18.44851, longitude=113.8576},
  }
}
local squadronNicknames = {
  "Dragons",
  "Phoenix",
  "Eastern Hawks",
  "Tiger's Eye",
  "Viper Fang",
  "Iron Talons",
  "Red Blades",
  "Steel Storm",
  "Eagle Claw",
  "Thunder Knights",
  "Shadow Falcons",
  "Storm Dragons",
  "Silver Hawks",
  "Golden Arrows",
  "Wolf Pack",
  "Eastern Shield",
  "Tiger Squadron",
  "Sky Raiders",
  "Eagle's Nest",
  "Iron Fang",
  "Guardian Lions",
  "Falcon's Edge",
  "Dragon's Eye",
  "Black Talons",
  "Fire Blades",
  "Silver Falcons"
}

local function GetAB(LR)
  ::redoAB::
  local ab = bL3.REDAIRBASES[math.random(#bL3.REDAIRBASES)]
  if ab.LR ~= LR then goto redoAB else return ab end
  
end
local BMS = {
  -- CSS-2 Mod 1 [DF-3A, 480kg Conventional]
  {target="Facility-Mobile", unit_dbid=355, unit_name="SSM Bn (CSS-2 Mod 1 [DF-3A])", unit_type="Facility", weapon_dbid=34, weapon_type="Guided Weapon", max_range=1500, min_range=500, air_max_range=0,air_min_range=0,  weapon_name="CSS-2 Mod 1 [DF-3A, 480kg Conventional]", mount_id=1187, qty=1, max_altitude=0, damage_points=1959},
  -- CSS-18 [DF-26, Submunitions]
  {target="Facility-Mobile", unit_dbid=3907, unit_name="SSM Bn (CSS-18 [DF-26])", unit_type="Facility", weapon_dbid=4315, weapon_type="Guided Weapon", max_range=2160, min_range=500, air_max_range=0,air_min_range=0,  weapon_name="CSS-18 [DF-26, Submunitions]", mount_id=4010, qty=1, max_altitude=0, damage_points=4316},
  -- CSS-X-24 [DF-27, 500kg HE Conventional]
  {target="Facility-Mobile", unit_dbid=3908, unit_name="SSM Bn (CSS-X-24 [DF-27])", unit_type="Facility", weapon_dbid=4319, weapon_type="Guided Weapon", max_range=4320, min_range=500, air_max_range=0,air_min_range=0,  weapon_name="CSS-X-24 [DF-27, 500kg HE Conventional]", mount_id=4011, qty=1, max_altitude=0, damage_points=4320},
  -- CH-SS-22 [DF-17, 500kg Conventional]
  {target="Facility-Mobile", unit_dbid=3205, unit_name="SSM Bn (CH-SS-22 [DF-17])", unit_type="Facility", weapon_dbid=3574, weapon_type="Guided Weapon", max_range=1350, min_range=50, air_max_range=0,air_min_range=0,  weapon_name="CH-SS-22 [DF-17, 500kg Conventional]", mount_id=3085, qty=1, max_altitude=0, damage_points=3575},
  -- CSS-5 Mod 4 [DF-21C, 2000kg Conventional]
  {target="Facility-Mobile", unit_dbid=89, unit_name="SSM Bn (CSS-5 Mod 4 [DF-21C])", unit_type="Facility", weapon_dbid=569, weapon_type="Guided Weapon", max_range=915, min_range=270, air_max_range=0,air_min_range=0,  weapon_name="CSS-5 Mod 4 [DF-21C, 2000kg Conventional]", mount_id=1779, qty=1, max_altitude=0, damage_points=1964},
}
function bL3.SETUP.DeployBM(mission)

  local bm = BMS[math.random(#BMS)]
  local group_name = bm.unit_name..'-'..math.random(100)
  local p = bL3.POSITIONS.BM[math.random(#bL3.POSITIONS.BM)]
  local num_units = 0
  if string.find(mission.name,'S1') then
    local m = ScenEdit_GetMission('RED',mission.name)
    bL3.AuxFunctions.SetDoctrineMission(m,'RED',bm.weapon_dbid,{salvo='Max',shooters='Max', target='Land'})
  else
    local m = ScenEdit_GetMission('RED',mission.name)
    bL3.AuxFunctions.SetDoctrineMission(m,'RED',bm.weapon_dbid,{salvo=2,shooters=1, target='Land'})
  end
  if #mission.targets == 1 then
    if mission.priority <= 2 then
      num_units = 2
    else
      num_units = 1
    end
  else
    num_units = math.min(#mission.targets/2, 6)
  end
  bL3.RED.SETUP.BM = tonumber(bL3.RED.SETUP.BM + num_units*bm.qty)
  for i=1,num_units do
    local p1 = World_GetPointFromBearing({latitude=p.latitude, longitude=p.longitude, bearing=math.random(359), distance=bL3.AuxFunctions.RandomFloat(-15,15,3)})
    local unit = ScenEdit_AddUnit({type='Facility', side='RED', name=bm.unit_name..' #'..bL3.AuxFunctions.RandomTxt(4), dbid=bm.unit_dbid, latitude=p1.latitude, longitude=p1.longitude, holdposition=true})
    if unit then
      ScenEdit_AssignUnitToMission(unit.guid,mission.name)
      unit.group = group_name
      if bL3.RED.NKE.AITargeting then AITargeting(unit) end
      AddActiveUnit(unit)
    end
    bL3.AuxFunctions.RemoveMagazines(unit)
  end
  
end
local CMS ={
  -- CH-SSC-9 [CJ-10]
  {target="Facility", unit_dbid=1678, unit_name="SSM Bn (CH-SSC-9 [CJ-10])", unit_type="Facility", weapon_dbid=2122, weapon_type="Guided Weapon", max_range=1080, min_range=50, air_max_range=0,air_min_range=0,  weapon_name="CH-SSC-9 [CJ-10]", mount_id=1878, qty=24, max_altitude=0, damage_points=450},
  -- CH-SSC-9 [CJ-10]
  {target="Facility", unit_dbid=676, unit_name="Type 095 Sui", unit_type="Submarine", weapon_dbid=3716, weapon_type="Guided Weapon", max_range=1080, min_range=50, air_max_range=0,air_min_range=0,  weapon_name="CH-SSC-9 [CJ-10]", mount_id=3263, qty=8, max_altitude=0, damage_points=450},
  -- CH-SSC-13 Splinter [CJ-100, Conventional]
  {target="Facility-Mobile-Ship", unit_dbid=3224, unit_name="SSM Bn (CH-SSC-13 Splinter [CJ-100])", unit_type="Facility", weapon_dbid=3669, weapon_type="Guided Weapon", max_range=1350, min_range=50, air_max_range=0,air_min_range=0,  weapon_name="CH-SSC-13 Splinter [CJ-100, Conventional]", mount_id=3122, qty=8, max_altitude=0, damage_points=450},
}

function bL3.SETUP.DeployCM(mission)
  
  local cm = CMS[math.random(#CMS)]  
  local group_name = cm.unit_name..'#'..math.random(100)
  local p = bL3.POSITIONS.CM[cm.unit_type][math.random(#bL3.POSITIONS.CM[cm.unit_type])]
  local num_units = 1
  if cm.unit_type ~= 'Submarine' then
    if #mission.targets == 1 then
      num_units = 1
    else
      local total_missiles = #mission.targets * 4
      
      num_units = math.min(total_missiles/cm.qty, 10)
    end
  else
    bL3.SETUP.DeployAirStrike(mission)
  end
  if string.find(mission.name,'S1') then
    local m = ScenEdit_GetMission('RED',mission.name)
    bL3.AuxFunctions.SetDoctrineMission(m,'RED',cm.weapon_dbid,{salvo='Max',shooters='Max', target='Land'})
  else
    local m = ScenEdit_GetMission('RED',mission.name)
    bL3.AuxFunctions.SetDoctrineMission(m,'RED',cm.weapon_dbid,{salvo=4,shooters='Max', target='Land'})
  end
  bL3.RED.SETUP.CM = bL3.RED.SETUP.CM + num_units 
  for i=1,num_units do
    local p1 = World_GetPointFromBearing({latitude=p.latitude, longitude=p.longitude, bearing=math.random(359), distance=bL3.AuxFunctions.RandomFloat(-2,2,3)})
    if cm.unit_type == 'Submarine' then
      p1 = World_GetPointFromBearing({latitude=p.latitude, longitude=p.longitude, bearing=math.random(359), distance=math.random(65)})
    end
    local unit = ScenEdit_AddUnit({type=cm.unit_type, side='RED', name=cm.unit_name..'#'..bL3.AuxFunctions.RandomTxt(4), dbid=cm.unit_dbid, latitude=p1.latitude, longitude=p1.longitude, holdposition=true})
    if cm.unit_type ~= 'Submarine' then
      bL3.AuxFunctions.RemoveMagazines(unit)
    else
      ScenEdit_SetUnit({guid = unit.guid, speed=0, manualAltitude='Shallow'})
    end
    if unit then
      ScenEdit_AssignUnitToMission(unit.guid,mission.name)
      if bL3.RED.NKE.AITargeting then AITargeting(unit) end
      AddActiveUnit(unit)
      if num_units > 1 then
        unit.group = group_name
      end
    end
  end
  
  

end

function bL3.SETUP.DeployAirStrike(mission)
  local x = math.random(#squadronNicknames)
  local nick = table.remove(squadronNicknames,x)
  
  local units = {
    {target="Facility-Mobile-Ship", unit_dbid=4225, unit_name="J-16 ", unit_type="Aircraft",radius=500, loadoutid=33787, weapon_dbid=4462, max_range=430, min_range=10, weapon_name="AKF-98A", max_altitude=19812, qty=4, damage_points=400, profile="Hi-Hi-Hi"},
    {target="Facility", unit_dbid=7134, unit_name="H-6K ", unit_type="Aircraft",radius=2000, loadoutid=1103, weapon_dbid=2039, max_range=1080, min_range=50, weapon_name="CH-SSC-9 [CJ-10K]", max_altitude=19812, qty=6, damage_points=450, profile="Hi-Hi-Hi"},
  }
  local escorts = {

  }
  
  if string.find(mission.name, 'S2%-') then
    local num_units = (#mission.targets * 4) / 6
    num_units = math.min(num_units,6)
    ScenEdit_SetMission('RED', mission.guid, {StrikeFlightSize = num_units})
    local ab = bL3.REDAIRBASES[math.random(#bL3.REDAIRBASES)]
    for i=1,num_units do
      local u = ScenEdit_AddUnit({type='Air', side='RED', name=nick..' #'..i, dbid=units[2].unit_dbid, loadoutid=units[2].loadoutid, base=ab.name})
      ScenEdit_AssignUnitToMission(u.guid,mission.name)
      if bL3.RED.NKE.AITargeting then AITargeting(u) end
      AddActiveUnit(u)
    end
    local m = ScenEdit_GetMission('RED',mission.name)
    bL3.AuxFunctions.SetDoctrineMission(m,'RED',units[2].weapon_dbid,{salvo=4, target='Land'})
    bL3.RED.SETUP.B = bL3.RED.SETUP.B + num_units
    
  else
    local ab = GetAB(false)
    local num_units = 2
    for i=1,num_units do
      local u = ScenEdit_AddUnit({type='Air', side='RED', name=units[1].unit_name..' #'..bL3.AuxFunctions.RandomTxt(4), dbid=units[1].unit_dbid, loadoutid=units[1].loadoutid, base=ab.name})
      ScenEdit_AssignUnitToMission(u.guid,mission.name)
      if bL3.RED.NKE.AITargeting then AITargeting(u) end
      AddActiveUnit(u)
    end
    local m = ScenEdit_GetMission('RED',mission.name)
    bL3.AuxFunctions.SetDoctrineMission(m,'RED',units[1].weapon_dbid,{salvo=4,target='Land'})
    ScenEdit_SetMission('RED',mission.guid,{UseFlightSize=false})
    bL3.RED.SETUP.F = bL3.RED.SETUP.F + num_units
    
  end
end

local function CreateStrikeMissions()
  for k,mission in pairs(bL3.RED.MISSIONS) do
    local mission_name = mission.name
    local m = ScenEdit_GetMission('RED',mission.guid)
    if string.find(mission_name,'S1%-') then
      -- Create LBCM or BM units and assign it to the mission 
      if math.random() < 0.6 then -- Add BMs
        bL3.SETUP.DeployBM(mission)
      else
        bL3.SETUP.DeployCM(mission)
      end
    elseif string.find(mission_name,'S2%-') then
      -- Create ALCM or BM/CM units and assign it to the mission 
      if math.random() < 0.4 then
        if math.random() < 0.2 then
          bL3.SETUP.DeployBM(mission)
        else
          bL3.SETUP.DeployCM(mission)
        end
      else
        bL3.SETUP.DeployAirStrike(mission)
      end
    end
    ::continue::
  end
end
CreateStrikeMissions()
-- Create ISR Recon Missions

-- Create OCA + Tankers Missions
local function CreateOCA()
  ScenEdit_AddMission('RED', 'OCA', '', {category='taskpool'})
  local x = math.random(#squadronNicknames)
  local nick = table.remove(squadronNicknames,x)
  local tot = bL3.RED.Dtime
  local OCA_time = tot + math.random(10,20)*60 - 50*60
  
  local SUP_time = OCA_time + 25*60 
  

  local p = bL3.RED.BEACH
  local patrolArea = bL3.AuxFunctions.NewArea(p,{side='RED', shape='circle', distance=45})

  local centerProsec = World_GetPointFromBearing({latitude=p.latitude, longitude=p.longitude, bearing=math.random(80,120), distance=math.random(10,20)})
  local prosecArea = bL3.AuxFunctions.NewArea(centerProsec,{side='RED', shape='circle', distance=math.random(70,120)})
  local OCAmission = ScenEdit_AddMission('RED', '#OCA#1', 'Patrol', {category='package',type='aaw',pool='OCA',zone=patrolArea})
  ScenEdit_SetMission('RED',OCAmission.guid,{ProsecutionZone=prosecArea, CheckWWR=true, CheckOPA=true,starttime=os.date(bL3.DATEFORMAT, OCA_time), endtime= os.date(bL3.DATEFORMAT,OCA_time+ math.random(300,360)*60), FlightsToEngage=1,OneThirdRule=false, OnDeactivateRTB=true})
  -- OCAmission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, OCA_time)
  bL3.RED.MISSIONS[OCAmission.name] = {name=OCAmission.name, guid=OCAmission.guid, targets={}, priority=math.random(1,2), lat=p.latitude, lon=p.longitude,zone=patrolArea,ProsecutionZone=prosecArea, tot=OCA_time, pool='OCA',type='OCA'}

  local ab = GetAB(false)
  local OCA_Fighters = {
    -- CH-AA-10 Abaddon [PL-15]
		{target="Aircraft", unit_dbid=5014, unit_name="J-20A Fagin", unit_type="Aircraft",radius=300, loadoutid=28028, weapon_dbid=3413, max_range=108, min_range=2, weapon_name="CH-AA-10 Abaddon [PL-15]", max_altitude=19812, qty=4, damage_points=8, profile="nan"},
		-- CH-AA-12 Auger [PL-17]
		{target="Aircraft", unit_dbid=2463, unit_name="J-20B Fagin", unit_type="Aircraft",radius=1080, loadoutid=32380, weapon_dbid=4110, max_range=216, min_range=2, weapon_name="CH-AA-12 Auger [PL-17]", max_altitude=19812, qty=4, damage_points=8, profile="nan"},
  }
  local unit = OCA_Fighters[math.random(#OCA_Fighters)]
  local num_units
  if bL3.COMPLEXITY == 1 then
    num_units = bL3.AuxFunctions.RandomPar(6,10)
  else
    num_units = bL3.AuxFunctions.RandomPar(10,16)
  end

  bL3.RED.SETUP.F = bL3.RED.SETUP.F + num_units
  for i=1, num_units do
    local u = ScenEdit_AddUnit({type='Air', name=nick..' #'..i, side='RED', dbid=unit.unit_dbid, loadoutid=unit.loadoutid, base=ab.name})
    ScenEdit_AssignUnitToMission(u.guid,OCAmission.guid)
    if bL3.RED.NKE.AITargeting then AITargeting(u) end
    AddActiveUnit(u,math.random(25,40))
    ScenEdit_FillMagsForLoadout({name=ab.name, side='RED', loadoutid=unit.loadoutid, quantity=3})
  end
  if bL3.COMPLEXITY == 3 then
    x = math.random(#squadronNicknames)
    nick = table.remove(squadronNicknames,x)
    unit = OCA_Fighters[math.random(#OCA_Fighters)]
    num_units = bL3.AuxFunctions.RandomPar(6,12)
    for i=1, num_units do
      local u = ScenEdit_AddUnit({type='Air', name=nick..' #'..i, side='RED', dbid=unit.unit_dbid, loadoutid=unit.loadoutid, base=ab.name})
      ScenEdit_AssignUnitToMission(u.guid,OCAmission.guid)
      if bL3.RED.NKE.AITargeting then AITargeting(u) end
      AddActiveUnit(u,math.random(25,40))
      ScenEdit_FillMagsForLoadout({name=ab.name, side='RED', loadoutid=unit.loadoutid, quantity=3})
    end
    bL3.RED.SETUP.F = bL3.RED.SETUP.F + num_units
  end
  
  local bearing = Tool_Bearing({latitude=p.latitude, longitude=p.longitude}, ab.guid)
  
  local pSupport = World_GetPointFromBearing({latitude=p.latitude, longitude=p.longitude, bearing = bearing, distance =350 })

  local areaSupport = bL3.AuxFunctions.NewArea(pSupport, {side='RED', shape='square', distance=15})

  local support_mission = ScenEdit_AddMission('RED', '#AAR OCA', 'Support', {category='package',pool='OCA',zone=areaSupport})
  
  ScenEdit_SetMission('RED', support_mission.guid, {OneThirdRule=false,MinAircraftReq=2,starttime=os.date(bL3.DATEFORMAT, 
  SUP_time), endtime=os.date(bL3.DATEFORMAT, OCA_time + math.random(240,300)*60), OnDeactivateRTB=true, OnDeactivateUnassign=true})
  
  -- support_mission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, SUP_time)
  
  bL3.RED.MISSIONS[support_mission.name] = {name=support_mission.name, guid=support_mission.guid, targets={}, priority=math.random(1,2), lat=pSupport.latitude, lon=pSupport.longitude, tot=SUP_time, pool='OCA',type='AAR', zone=areaSupport}
  abS = bL3.REDAIRBASES[math.random(#bL3.REDAIRBASES)]
  local num_tankers = math.floor(bL3.RED.SETUP.F / 6)
  for i=1,num_tankers do
    local u = ScenEdit_AddUnit({type='Air', side='RED', name='TankA# '..i, dbid=4975, loadoutid=27886, base=abS.name})
    ScenEdit_AssignUnitToMission(u.guid, support_mission.guid)
    if bL3.RED.NKE.AITargeting then AITargeting(u) end
    AddActiveUnit(u,20)
  end

  -- SEAD
  local endTime = OCA_time+ math.random(240,300)*60
  local seadMission = ScenEdit_AddMission('RED', 'SEAD#'..bL3.AuxFunctions.RandomTxt(4), 'Patrol', {category='package',type='sead', pool='OCA',zone=patrolArea})
  ScenEdit_SetMission('RED',seadMission.guid, {ProsecutionZone=prosecArea,OneThirdRule=false, CheckWWR=true, CheckOPA=true, starttime=os.date(bL3.DATEFORMAT, OCA_time-5), endtime=os.date(bL3.DATEFORMAT,endTime), OnDeactivateRTB=true})
  -- seadMission.TimeOnTargetStation = os.date(bL3.DATEFORMAT, OCA_time-5)
  bL3.RED.MISSIONS[support_mission.name] = {name=support_mission.name, guid=support_mission.guid, targets={}, priority=math.random(1,2), lat=p.latitude, lon=p.longitude, tot=OCA_time-5, pool='OCA',type='SEAD', zone=patrolArea,ProsecutionZone=prosecArea}
  local units = {
    -- AS-17 Krypton C [Kh-31P, ARM]
		{target="Radar", unit_dbid=6450, unit_name="J-16 Flying Shark", unit_type="Aircraft",radius=500, loadoutid=21747, weapon_dbid=276, max_range=60, min_range=1, weapon_name="AS-17 Krypton C [Kh-31P, ARM]", max_altitude=19812, qty=4, damage_points=90, profile="Hi-Med-Hi"},
    -- YJ-91 [Kh-31P, ARM]
		{target="Radar", unit_dbid=7203, unit_name="Su-30MKK Flanker G", unit_type="Aircraft",radius=500, loadoutid=25372, weapon_dbid=2875, max_range=64, min_range=8, weapon_name="YJ-91 [Kh-31P, ARM]", max_altitude=15240, qty=4, damage_points=165, profile="Hi-Med-Hi"},
  }
  local num_units
  if bL3.COMPLEXITY == 1 then
    num_units = bL3.AuxFunctions.RandomPar(6,10)
  else
    num_units = bL3.AuxFunctions.RandomPar(10,16)
  end
  x = math.random(#squadronNicknames)
  nick = table.remove(squadronNicknames,x)
  local sead = units[math.random(#units)]
  for i = 1, num_units do
    local u = ScenEdit_AddUnit({type='Air', side='RED', name=nick..' #'..i, dbid=sead.unit_dbid, loadoutid=sead.loadoutid, base=ab.name})
    ScenEdit_AssignUnitToMission(u.guid,seadMission.guid)
    if bL3.RED.NKE.AITargeting then AITargeting(u) end
    AddActiveUnit(u,math.random(25,40))
    ScenEdit_FillMagsForLoadout({name=ab.name, side='RED', loadoutid=unit.loadoutid, quantity=1})
  end
  bL3.RED.SETUP.F = bL3.RED.SETUP.F + num_units
  ScenEdit_SetMission('RED', seadMission.guid, {TankerUsage=1, TankerMaxDistance_airborne=250, TankerMissionList={support_mission.name}})
  ScenEdit_SetMission('RED', OCAmission.guid, {TankerUsage=1, TankerMaxDistance_airborne=250, TankerMissionList={support_mission.name}})

end

CreateOCA()

local function QRF()
  bL3.RED.QRF = {}
  bL3.RED.QRF.SAG = {}
  
  bL3.RED.QRF.AKF = {}
  local unit = {target="Facility-Mobile-Ship", unit_dbid=6450, unit_name="J-16 Flying Shark [Su-30MKK Copy]", unit_type="Aircraft",radius=500, loadoutid=33788, weapon_dbid=4462, max_range=430, min_range=10, weapon_name="AKF-98A", max_altitude=19812, qty=2, damage_points=400, profile="Hi-Hi-Hi"}
  local ab = GetAB(false)
  local num_units
  if bL3.COMPLEXITY == 1 then
    num_units = bL3.AuxFunctions.RandomPar(6,10)
  elseif bL3.COMPLEXITY == 2 then
    num_units = bL3.AuxFunctions.RandomPar(10,14)
  else
    num_units = bL3.AuxFunctions.RandomPar(12,18)
  end
  bL3.RED.SETUP.F = bL3.RED.SETUP.F + num_units
  local x = math.random(#squadronNicknames)
  local nick = table.remove(squadronNicknames,x)
  for i=1,num_units do
    local u = ScenEdit_AddUnit({type='Air', side='RED', name=nick..' #QRF #'..i, dbid=unit.unit_dbid, loadoutid=unit.loadoutid, base=ab.name})
    AddActiveUnit(u,math.random(15,25))
    table.insert(bL3.RED.QRF.AKF,u.guid)
    bL3.RED.SETUP.F = bL3.RED.SETUP.F + 1
  end 

  bL3.RED.QRF.BM = {}
  local bm = BMS[math.random(#BMS)]
  
  
  for i=1,math.random(2,4)*bL3.COMPLEXITY do
    local p = bL3.POSITIONS.BM[math.random(#bL3.POSITIONS.BM)]
    local u = ScenEdit_AddUnit({type='Facility', side='RED', name=bm.unit_name..' #QRF #'..i, dbid=bm.unit_dbid, latitude=p.latitude+math.random(-100,100)/400, longitude=p.longitude+math.random(-100,100)/400})
    bL3.AuxFunctions.RemoveMagazines(u)
    table.insert(bL3.RED.QRF.BM,u.guid)
    
    bL3.RED.SETUP.BM = tonumber(bL3.RED.SETUP.BM + num_units*bm.qty)
  end

  bL3.RED.QRF.CM = {}
  local cm = CMS[3]
  
  

  for i=1,math.random(2,4)*bL3.COMPLEXITY do
    local p = bL3.POSITIONS.CM[cm.unit_type][math.random(#bL3.POSITIONS.CM[cm.unit_type])]
    local u = ScenEdit_AddUnit({type='Facility', side='RED', name=cm.unit_name..' #QRF #'..i, dbid=cm.unit_dbid, latitude=p.latitude+math.random(-100,100)/400, longitude=p.longitude+math.random(-100,100)/400})
    table.insert(bL3.RED.QRF.CM,u.guid)
    bL3.AuxFunctions.RemoveMagazines(u)
    bL3.RED.SETUP.CM = tonumber(bL3.RED.SETUP.CM + num_units)
  end

  bL3.RED.QRF.H6K = {}
  for i=1,2*bL3.COMPLEXITY do
    u = ScenEdit_AddUnit({type='Aircraft', side='RED', name='DRAGON  #QRF #'..i, dbid=7135, loadoutid=1103, base=ab.name})
    table.insert(bL3.RED.QRF.H6K,u.guid)
    AddActiveUnit(u,math.random(15,25))
  end
  bL3.RED.SETUP.B = bL3.RED.SETUP.B +2
  -- CH-AS-X-13 [KF-21] H6
  if math.random() > 0.5/bL3.COMPLEXITY then
    bL3.RED.QRF.H6N = {}
    unit = {target="Ship", unit_dbid=4837, unit_name="H-6N Badger", unit_type="Aircraft",radius=500, loadoutid=26388, weapon_dbid=3564, max_range=1650, min_range=100, weapon_name="CH-AS-X-13 [KF-21]", max_altitude=20000, qty=1, damage_points=3565, profile="Hi-Hi-Hi"}
    ab = GetAB(true)
    for i=1,math.random(2,4) do
      u = ScenEdit_AddUnit({type='Aircraft', side='RED', name='KAL  #QRF #'..i, dbid=unit.unit_dbid, loadoutid=unit.loadoutid, base=ab.name})
      AddActiveUnit(u,math.random(15,25))
      table.insert(bL3.RED.QRF.H6N,u.guid)
    end
    bL3.RED.SETUP.B = bL3.RED.SETUP.B + 4
  end
  bL3.RED.QRF.ASBM = {}
  if math.random() > 0.8/bL3.COMPLEXITY then -- CSS-18 Mod 1 [DF-26B, 1200kg Conventional]
    local position = {latitude=26.3753, longitude=109.1723}
    unit = {target="Ship", unit_dbid=2879, unit_name="SSM Bn (CSS-18 Mod 1 [DF-26B]", unit_type="Facility", weapon_dbid=3372, weapon_type="Guided Weapon", max_range=2160, min_range=500, air_max_range=0,air_min_range=0,  weapon_name="CSS-18 Mod 1 [DF-26B, 1200kg Conventional]", mount_id=2945, qty=1, max_altitude=0, damage_points=3371}
    local u = ScenEdit_AddUnit({type='Facility', side='RED', name='SSM DF-26B  #QRF #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.unit_dbid, latitude=position.latitude + math.random(-100,100)/80, longitude= position.longitude + math.random(-100,100)/80})
    table.insert(bL3.RED.QRF.ASBM, u.guid)
    bL3.AuxFunctions.RemoveMagazines(u)
    bL3.RED.SETUP.BM = bL3.RED.SETUP.BM + 1
  end
  if bL3.COMPLEXITY == 3 then
    local position = {latitude=26.3753, longitude=109.1723}
    unit = {target="Ship", unit_dbid=2879, unit_name="SSM Bn (CSS-18 Mod 1 [DF-26B]", unit_type="Facility", weapon_dbid=3372, weapon_type="Guided Weapon", max_range=2160, min_range=500, air_max_range=0,air_min_range=0,  weapon_name="CSS-18 Mod 1 [DF-26B, 1200kg Conventional]", mount_id=2945, qty=1, max_altitude=0, damage_points=3371}
    for i=1,2 do
      local u = ScenEdit_AddUnit({type='Facility', side='RED', name='SSM DF-26B  #QRF #'..bL3.AuxFunctions.RandomTxt(3), dbid=unit.unit_dbid, latitude=position.latitude + math.random(-100,100)/80, longitude= position.longitude + math.random(-100,100)/80})
      table.insert(bL3.RED.QRF.ASBM, u.guid)
      bL3.AuxFunctions.RemoveMagazines(u)
      bL3.RED.SETUP.BM = bL3.RED.SETUP.BM + 1
    end
  end
end
QRF()
local function DeploySAGC2()
  local function SAGDoctrine(unit)
    ScenEdit_SetDoctrine({guid=unit.guid}, {weapon_control_status_land=2, weapon_control_status_surface=2})
  end
  ScenEdit_AddMission('RED', 'ARG', '', {category='taskpool'})

  local areas = {
    {latitude=17.012113, longitude=114.41861},
    {latitude=17.217972, longitude=113.56363},
    {latitude=17.1642459, longitude=113.499050},
    {latitude=17.4645746, longitude=113.51322},
  }
  
  local destination = bL3.RED.BEACH
  local units = {['AAW']={3586,4719,3883,3586},['ASW']={3617,4596,2714,4722},['AMP']={2006,4602,2006} }
  
  local heading = 160
  
  local position = areas[1]
  bL3.RED.SAGPOS = position
  local bearing_course = Tool_Bearing(position, destination)
  local distance = Tool_Range(position,destination)
  local c2ship = ScenEdit_AddUnit({type='Ship', side=bL3.SIDES.RED, name='C2 Center #'..bL3.AuxFunctions.RandomTxt(5), dbid=4876, latitude=position.latitude, longitude=position.longitude, heading=bearing_course+45})
  bL3.RED.UNITS.C2SHIP = c2ship.guid
  AddActiveUnit(c2ship,70)
  local t_course = {}
  local t
  local steps = math.floor(distance / 20)
  for i = 1, steps do
    local offset
    if i % 2 == 0 then
      offset = math.random(-15,-5)
    else
      offset = math.random(5,15)
    end
    if not t then
      t = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearing_course+offset, distance=i*5+math.random()*5})  
    else
      t = World_GetPointFromBearing({latitude=t.latitude, longitude=t.longitude, bearing=bearing_course+offset, distance=math.random(15,25)})
      if World_GetElevation(t) > 0 then
        break
      end
    end
    local row = {latitude=t.latitude, longitude=t.longitude, presetThrottle=math.random(1,3),desiredSpeed=math.random(5,20), typeOf='ManualPlottedCourseWaypoint'}
    table.insert(t_course,row)
  end
  c2ship.group = 'ARG'
  local c2GroupGuid = SE_GetUnit({side='RED', name='ARG'}).guid
  bL3.RED.UNITS.C2GROUP = c2GroupGuid
  bL3.RED.SAGCOURSE = t_course
  ScenEdit_SetUnit({guid = c2ship.guid, course=t_course, manualSpeed=10})
  local npoints = #t_course
  local tpoint = t_course[npoints-math.random(4,6)]
  local amphArea = bL3.AuxFunctions.NewArea(tpoint,{side='RED', shape='circle', distance=10})
  bL3.AuxFunctions.UnitEntersAreaEvent('AMPH Close Beach',{TargetSide='RED', TargetType=2, SpecificUnitID=bL3.RED.UNITS.C2SHIP},amphArea,'bL3.Functions.AmphCloseBeach()','add',false,false,true)
  --OCA
  local tot = bL3.RED.Dtime
  local OCA_time = tot + math.random(15,25)*60 
  local endTime = OCA_time + math.random(280,370)*60
  local OCA_PLAAF = bL3.RED.MISSIONS['#OCA#1']
  local OCAMission = ScenEdit_AddMission('RED', '#OCA#SAG', 'patrol', {type='aaw', category='package', pool='ARG', zone=OCA_PLAAF.zone})
  ScenEdit_SetMission('RED', OCAMission.name, {starttime = os.date(bL3.DATEFORMAT, OCA_time),endtime= os.date(bL3.DATEFORMAT, endTime) , CheckWWR=true, CheckOPA=false, OneThirdRule=false, FlightsToEngage='1', ProsecutionZone=OCA_PLAAF.ProsecutionZone} )
  bL3.RED.MISSIONS[OCAMission.name] = {name=OCAMission.name, guid=OCAMission.guid, targets={}, priority=1, lat=OCA_PLAAF.latitude, lon=OCA_PLAAF.longitude, tot=OCA_time, pool='ARG',type='OCA'}
  --CAP
  local cap_area = bL3.AuxFunctions.NewArea(position,{shape='circle', side='RED', distance=55, relativeTo=c2GroupGuid})
  local prosec_center = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearing_course, distance=25})
  local cap_prosec = bL3.AuxFunctions.NewArea(prosec_center,{shape='circle', side='RED', distance=155, relativeTo=c2GroupGuid})
  local starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+180*60)
  local CAP = ScenEdit_AddMission('RED','SAG #CAP','patrol',{type='aaw', category='package', pool='ARG', zone=cap_area})
  ScenEdit_SetMission('RED', CAP.guid, {ProsecutionZone=cap_prosec, starttime=starttime,endtime= os.date(bL3.DATEFORMAT, endTime),OnStation=4 , CheckWWR=false})
  bL3.RED.MISSIONS[CAP.name] = {name=CAP.name, guid=CAP.guid, targets={}, priority=1, lat=position.latitude, lon=position.longitude, tot=nil, pool='ARG',type='DCA', PatrolZone=cap_area, ProsecutionZone=cap_prosec}
  --AEW
  local AEW_SAG = bL3.AuxFunctions.NewArea(position,{shape='square', side='RED', relativeTo=c2GroupGuid, distance=40})
  starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+180*60)
  local AEW1 = ScenEdit_AddMission('RED','SAG #AEW#1', 'support',{category='package', pool='ARG', zone=AEW_SAG})
  ScenEdit_SetEMCON('mission',AEW1.guid,'Radar=Active')  
  ScenEdit_SetMission('RED', AEW1.guid, {OnStation=1, OneThirdRule=false})
  bL3.RED.MISSIONS[AEW1.name] = {name=AEW1.name, guid=AEW1.guid, targets={}, priority=1, lat=position.latitude, lon=position.longitude, tot=nil, pool='ARG',type='AEW'}
  --ASW MISSION
  local asw_position = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearing_course, distance=80})
  local ASW_SAG = bL3.AuxFunctions.NewArea(asw_position,{shape='circle', side='RED', relativeTo=c2GroupGuid, distance=35})
  local ASW_Patrol = ScenEdit_AddMission('RED','ASW PATROL ARG', 'patrol',{type='asw', category='package', pool='ARG', zone=ASW_SAG})
  starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+math.random(180,260)*60)
  ScenEdit_SetMission('RED', ASW_Patrol.guid, {starttime=starttime,endtime=os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+48
  *60*60), CheckOPA=false, CheckWWR=false, OnStation=2, OneThirdRule=false})
  local ASW_Interception = ScenEdit_AddMission('RED','ASW INTER ARG', 'strike',{type='sub', category='package', pool='ARG'})
  ScenEdit_SetMission('RED', ASW_Interception.guid, {StrikeMaxDistAircraft=80,StrikeMax='2'})
  bL3.RED.MISSIONS[ASW_Patrol.name] = {name=ASW_Patrol.name, guid=ASW_Patrol.guid, targets={}, priority=1, lat=position.latitude, lon=position.longitude, tot=nil, pool='ARG',type='ASW Patrol'}
  bL3.RED.MISSIONS[ASW_Interception.name] = {name=ASW_Interception.name, guid=ASW_Interception.guid, targets={}, priority=1, lat=position.latitude, lon=position.longitude, tot=nil, pool='ARG',type='ASW Interception'}
  --4962/33934
  local num_units
  if bL3.COMPLEXITY == 1 then
    num_units = bL3.AuxFunctions.RandomPar(6,10)
  elseif bL3.COMPLEXITY == 2 then
    num_units = bL3.AuxFunctions.RandomPar(6,12)
  else
    num_units = bL3.AuxFunctions.RandomPar(12,18)
  end
  for i=1,num_units do
    local ag = ScenEdit_AddUnit({type='Air', name='INK #'..i, side=bL3.SIDES.RED, dbid=4962, loadoutid=33934, base=c2ship.guid})
    AddActiveUnit(ag)
    ScenEdit_AssignUnitToMission(ag.guid, OCAMission.name)
    ScenEdit_FillMagsForLoadout({guid=c2ship.guid, loadoutid=33934, quantity=4})
  end
  bL3.RED.SETUP.NF = bL3.RED.SETUP.NF + num_units
  local num_units
  if bL3.COMPLEXITY == 1 then
    num_units = bL3.AuxFunctions.RandomPar(6,10)
  elseif bL3.COMPLEXITY == 2 then
    num_units = bL3.AuxFunctions.RandomPar(8,12)
  else
    num_units = bL3.AuxFunctions.RandomPar(12,14)
  end
  for i=1,num_units do
    ag = ScenEdit_AddUnit({type='Air', name='LINK #'..i, side=bL3.SIDES.RED, dbid=6098, loadoutid=32137, base=c2ship.guid})
    AddActiveUnit(ag)
    ScenEdit_AssignUnitToMission(ag.guid, CAP.name)
    ScenEdit_FillMagsForLoadout({guid=c2ship.guid, loadoutid=32134, quantity=4})
    ScenEdit_FillMagsForLoadout({guid=c2ship.guid, loadoutid=32137, quantity=4})
  end
  bL3.RED.SETUP.NF = bL3.RED.SETUP.NF + num_units
  for i=1,4 do
    local heli = ScenEdit_AddUnit({type='Aircraft', side='RED', name='Helix #'..i, dbid=7357, loadoutid=17471, base=c2ship.name})
    ScenEdit_AssignUnitToMission(heli.guid,AEW1.guid)
    AddActiveUnit(heli,30)
    ScenEdit_FillMagsForLoadout({guid=c2ship.guid, loadoutid=33934, quantity=6})
  end
  for i=1,3 do
    local heli = ScenEdit_AddUnit({type='Aircraft', side='RED', name='Dolphin #'..i, dbid=7359, loadoutid=18368, base=c2ship.name})
    AddActiveUnit(heli)
    ScenEdit_AssignUnitToMission(heli.guid,ASW_Interception.guid)
    ScenEdit_FillMagsForLoadout({guid=c2ship.guid, loadoutid=33934, quantity=6})
  end
  for i=1,6*bL3.COMPLEXITY do
    local heli = ScenEdit_AddUnit({type='Aircraft', side='RED', name='Dolphin #'..i, dbid=5854, loadoutid=14701, base=c2ship.name})
    AddActiveUnit(heli)
    ScenEdit_AssignUnitToMission(heli.guid,ASW_Patrol.guid)
  end

  local internal_ASW = World_GetCircleFromPoint({latitude=position.latitude, longitude=position.longitude, numpoints=50, radius=15})
  local internal_AMP = World_GetCircleFromPoint({latitude=position.latitude, longitude=position.longitude, numpoints=60, radius=6})
  local bearings_AAW = {130,94,175,75,225,324,135,100,180,80}
  local bearings_ASW = {130,310,220,41,190,275,125,305,205,47}
  local b, k = 1, 1
  local p, u
  local heliAEW = 0
  local ddg_th = 0.18
  if bL3.COMPLEXITY == 1 then
    ddg_th = 0.18
  elseif bL3.COMPLEXITY == 2 then
    ddg_th = 0.14
  else
    ddg_th = 0.12
  end
  p = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=110, distance=math.random(15,25)})
  u = ScenEdit_AddUnit({type='Ship', side='RED', name='AAW Escort A #'..bL3.AuxFunctions.RandomTxt(4), dbid=3883, latitude=p.latitude+math.random(-100,100)/10^5, longitude=p.longitude+math.random(-100,100)/10^5, heading=bearing_course+45})
  AddActiveUnit(u,55)
  u.group = 'ARG' 
  SAGDoctrine(u)
  bL3.RED.SETUP['AAWF'] = bL3.RED.SETUP['AAWF'] + 2
  u.formation = {type='fixed', bearing=bearings_AAW[b]}
  if bL3.COMPLEXITY == 1 then
    num_units = 6
  elseif bL3.COMPLEXITY == 2 then
    num_units = math.random(6,8)
  else
    num_units = math.random(6,9)
  end
  local bearing = math.floor(360/num_units +0.5)
  for i=1,num_units do
    --AAW Ring
    if math.random() > ddg_th*b then
      p = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearings_AAW[b], distance=math.random(20,40)})
      u = ScenEdit_AddUnit({type='Ship', side='RED', name='AAW Escort '..b..' #'..bL3.AuxFunctions.RandomTxt(4), dbid=units['AAW'][math.random(#units['AAW'])], latitude=p.latitude+math.random(-100,100)/10^5, longitude=p.longitude+math.random(-100,100)/10^5, heading=bearing_course+45, SprintDrift=true})
      AddActiveUnit(u,55)
      u.group = 'ARG' 
      SAGDoctrine(u)
      u.formation = {type='fixed', bearing=bearings_AAW[b]}
      local heli
      if u.dbid == 3883 then
        bL3.RED.SETUP['AAWF'] = bL3.RED.SETUP['AAWF'] + 1
        heli = ScenEdit_AddUnit({type='Aircraft', side='RED', name='ASW #'..bL3.AuxFunctions.RandomTxt(3), dbid=4933, loadoutid=28012, base=u.name})
        if heli then
          AddActiveUnit(heli)
          ScenEdit_AssignUnitToMission(heli.guid,ASW_Patrol.guid)
          ScenEdit_FillMagsForLoadout({guid=u.guid, loadoutid=28012, quantity=3})
        end
      else
        heli = ScenEdit_AddUnit({type='Aircraft', side='RED', name='ASW #'..bL3.AuxFunctions.RandomTxt(3), dbid=4933, loadoutid=27643, base=u.name})
        if heli then
          AddActiveUnit(heli)
          ScenEdit_AssignUnitToMission(heli.guid,ASW_Interception.guid)
          ScenEdit_FillMagsForLoadout({guid=u.guid, loadoutid=27643, quantity=3})
        end
      end
      bL3.RED.SETUP['AAWF'] = bL3.RED.SETUP['AAWF'] + 1
      if b < 3 then
        table.insert(bL3.RED.QRF.SAG,u.guid)
      end
      b = b + 1
      
      
      
    end
    --ASW Ring
    if math.random() > 0.08*k then
      p = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearings_ASW[k], distance=math.random(8,15)})
      if p then
        u = ScenEdit_AddUnit({type='Ship', side='RED', name='ASW Escort '..k..' #'..bL3.AuxFunctions.RandomTxt(4), dbid=units['ASW'][math.random(#units['ASW'])], latitude=p.latitude+math.random(-100,100)/10^5, longitude=p.longitude+math.random(-100,100)/10^5, heading=bearing_course+45, SprintDrift=true})
        AddActiveUnit(u,45)
        SAGDoctrine(u)
        u.group = 'ARG'
        u.formation = {type='fixed', bearing=bearings_ASW[k], sprint=true, manualSpeed=true}
        for x=1,1 do
          local sq = bL3.AuxFunctions.RandomTxt(4)
          local heli = ScenEdit_AddUnit({type='Aircraft', side='RED', name='ASW '..sq..' #'..x, dbid=7349, loadoutid=27635, base=u.name})
          if heli then
            AddActiveUnit(heli)
            ScenEdit_AssignUnitToMission(heli.guid,ASW_Interception.guid)
            ScenEdit_FillMagsForLoadout({guid=u.guid, loadoutid=27635, quantity=3})
          end
        end
        k = k + 1
        ScenEdit_SetDoctrine({guid=u.guid},{weapon_control_status_surface=2})
        ScenEdit_SetDoctrine({guid=u.guid},{weapon_control_status_subsurface=0})
        ScenEdit_SetEMCON('unit',u.guid,'Sonar=Active')
      end
    end
    p = World_GetPointFromBearing({latitude=c2ship.latitude,longitude=c2ship.longitude, distance=math.random(5,8), bearing=(i-1)*bearing})
    u = ScenEdit_AddUnit({type='Ship', side='RED', name='AMPH Force #'..bL3.AuxFunctions.RandomTxt(4), dbid=units['AMP'][math.random(#units['AMP'])], latitude=p.latitude+math.random(-100,100)/10^5, longitude=p.longitude+math.random(-100,100)/10^5, heading=bearing_course+45})
    AddActiveUnit(u,30)
    u.group = 'ARG'
    u.formation ={type='fixed', bearing=Tool_Bearing(c2ship.guid,u.guid)}
  end
  bL3.RED.AMPH = num_units
  -- Replenishment, Cargo and Hospital
  for _, i in ipairs({4600,2927,2927,2005,4656,4656}) do
    local p = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude,bearing=math.random(266,330), distance=math.random(2,8)})
    local bearing = Tool_Bearing(c2ship.guid,p)
    local u = ScenEdit_AddUnit({type='Ship', side='RED', name='AUX #'..bL3.AuxFunctions.RandomTxt(4), dbid=i, latitude=p.latitude+math.random(-100,100)/10^5, longitude=p.longitude+math.random(-100,100)/10^5, heading=bearing_course+45})
    u.group = 'ARG'
    u.formation ={type='fixed', bearing=bearing}
  end
  
  
  for i=1,bL3.COMPLEXITY do
    if math.random() > 0.2*i then
      local p_sub = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearing_course, distance=math.random(55,80)*i})

      local sub_center = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearing_course+math.random(-2,2), distance=math.random(35,45)*i})
      local sub_area = bL3.AuxFunctions.NewArea(p_sub,{side='RED',shape='square', distance=4, relativeTo=c2GroupGuid})
      local sub_prosec = bL3.AuxFunctions.NewArea(p_sub,{side='RED',shape='circle', distance=70, relativeTo=c2GroupGuid})
      local ssn_seacontrol = ScenEdit_AddMission('RED', 'SSN Patrol #'..i, 'patrol', {type='SEA', zone=sub_area,category='package', pool='ARG'})
      ScenEdit_SetMission('RED',ssn_seacontrol.guid, {CheckWWR=false, CheckOPA=false, ProsecutionZone=sub_prosec, StationDepthSubmarinePreset = 'UnderLayer', StationThrottleSubmarine = 'Cruise', AttackThrottleSubmarine = 'Loiter'})
      bL3.RED.MISSIONS[ssn_seacontrol.name] = {name=ssn_seacontrol.name, guid=ssn_seacontrol.guid, targets={}, priority=1, lat=p_sub.latitude, lon=p_sub.longitude, tot=nil, pool='ARG',type='Sea Control Patrol', PatrolArea=sub_area, ProsecutionZone=sub_prosec}
    
      local p_sub = World_GetPointFromBearing({latitude=position.latitude, longitude=position.longitude, bearing=bearing_course+math.random(-10,10), distance=math.random(65,90)*i})
      local sub = ScenEdit_AddUnit({type='Submarine', side='RED', name='SSN #'..bL3.AuxFunctions.RandomTxt(4), dbid=776, latitude=p_sub.latitude, longitude=p_sub.longitude, depth=-200})
      ScenEdit_AssignUnitToMission(sub.guid,ssn_seacontrol.guid) 
    end
     
  end
  
  
  
  --PLAAF SUPPORT
  ScenEdit_AddMission('RED', 'PLAAF SAG Support', '', {category='taskpool'})
  local support_center = World_GetPointFromBearing({latitude = position.latitude, longitude=position.longitude, bearing=bearing_course+180, distance=math.random(45,60)})
  --AEW
  local AEW_Area = bL3.AuxFunctions.NewArea(support_center,{side='RED', shape='rectangle', relativeTo=c2GroupGuid, width=70, length=5, bear_offset = bearing_course+90 })
  local AEW_PLAAF = ScenEdit_AddMission('RED', '#C2 PLAAF', 'support',{zone=AEW_Area, category='package', pool='PLAAF SAG Support'})
  starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+150*60)
  ScenEdit_SetMission('RED', AEW_PLAAF.guid, {starttime=starttime, OnStation=1, OneThirdRule=false})
  ScenEdit_SetEMCON('mission',AEW_PLAAF.guid,'Radar=Active')
  bL3.RED.MISSIONS[AEW_PLAAF.name] = {name=AEW_PLAAF.name, guid=AEW_PLAAF.guid, targets={}, priority=1, lat=support_center.latitude, lon=support_center.longitude, tot=nil, pool='PLAAF SAG Support',type='AEW'}
  
  --AAR
  support_center = World_GetPointFromBearing({latitude = position.latitude, longitude=position.longitude, bearing=bearing_course+180, distance=math.random(55,70)})
  local AAR_Area = bL3.AuxFunctions.NewArea(support_center,{side='RED', shape='rectangle', relativeTo=c2GroupGuid,width=60, length=6, bear_offset = bearing_course+90 })
  local AAR_PLAAF = ScenEdit_AddMission('RED', '#AAR SAG', 'support',{zone=AAR_Area, category='package', pool='PLAAF SAG Support'})
  starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+160*60)
  ScenEdit_SetMission('RED', AAR_PLAAF.guid, {starttime=starttime, OnStation=2, OneThirdRule=false})
  bL3.RED.MISSIONS[AAR_PLAAF.name] = {name=AAR_PLAAF.name, guid=AAR_PLAAF.guid, targets={}, priority=1, lat=support_center.latitude, lon=support_center.longitude, tot=nil, pool='PLAAF SAG Support',type='AAR'}

  --SAG CAP2
  local areaSAGCAP = bL3.RED.MISSIONS['SAG #CAP'].PatrolZone
  local prosecSAGCAP = bL3.RED.MISSIONS['SAG #CAP'].ProsecutionZone

  local sagcap2 = ScenEdit_AddMission('RED', 'SAG SUPPORT #CAP', 'patrol',{type='aaw', zone=areaSAGCAP, category='package', pool='PLAAF SAG Support'})
  ScenEdit_SetMission('RED', 'SAG SUPPORT #CAP',{isactive=false, ProsecutionZone=prosecSAGCAP, FlightsToInvestigate=1, FlightsToEngage=1})
  starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+160*60)
  bL3.RED.MISSIONS[sagcap2.name] = {name=sagcap2.name, guid=sagcap2.guid, targets={}, priority=1, lat=bL3.RED.MISSIONS['SAG #CAP'].latitude, lon=bL3.RED.MISSIONS['SAG #CAP'].longitude, tot=nil, pool='PLAAF SAG Support',type='DCA', PatrolZone=areaSAGCAP, ProsecutionZone=prosecSAGCAP}
  --SAG ESCORT AR/C2
  local areaEscort = bL3.AuxFunctions.NewArea(support_center,{side='RED', shape='circle', distance=25, relativeTo=c2GroupGuid})
  local prosecEscort = bL3.AuxFunctions.NewArea(support_center,{side='RED', shape='circle', distance=145, relativeTo=c2GroupGuid})
  local sagC2escort = ScenEdit_AddMission('RED', 'SAG ESCORT #DCA', 'patrol',{type='aaw', zone=areaEscort, category='package', pool='PLAAF SAG Support'})
  starttime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+150*60)
  ScenEdit_SetMission('RED', 'SAG ESCORT #DCA', {isactive=false,ProsecutionZone=prosecEscort, FlightsToInvestigate=1, FlightsToEngage=1, starttime=starttime, CheckWWR=false,OnStation=4})
  bL3.RED.MISSIONS[sagC2escort.name] = {name=sagC2escort.name, guid=sagC2escort.guid, targets={}, priority=1, lat=support_center.latitude, lon=support_center.longitude, tot=nil, pool='PLAAF SAG Support',type='DCA', PatrolZone=areaEscort, ProsecutionZone=prosecEscort}
  

  local ab = GetAB(false)
  local support_guid = bL3.RED.MISSIONS['#AAR OCA'].guid
  --6004/18300
  if bL3.COMPLEXITY <= 2 then
    num_units = 3
  else
    num_units = math.random(3,5)
  end
  for i=1,num_units do
    u = ScenEdit_AddUnit({type='Air', side='RED', name='LINX #'..i, dbid=6004, loadoutid=18300, base=ab.name})
    if u then
      ScenEdit_AssignUnitToMission(u.guid,AEW_PLAAF.guid)
      AddActiveUnit(u,50)  
    end
  end
  if bL3.COMPLEXITY <= 2 then
    num_units = 12
  else
    num_units = 16
  end
  for i=1,num_units do
    u = ScenEdit_AddUnit({type='Air', side='RED', name='CUDA #'..i, dbid=3727, loadoutid=10420, base=ab.name})
    ScenEdit_AssignUnitToMission(u.guid,AAR_PLAAF.guid)
    AddActiveUnit(u,20)
  end
  for i=1,num_units do
    u = ScenEdit_AddUnit({type='Air', side='RED', name='ELE #'..i, dbid=3727, loadoutid=10420, base=ab.name})
    ScenEdit_AssignUnitToMission(u.guid,support_guid)
    
    AddActiveUnit(u,20)
  end
  
  ab = GetAB(false)
  if bL3.COMPLEXITY <= 2 then
    num_units = bL3.AuxFunctions.RandomPar(8,14)
  else
    num_units = bL3.AuxFunctions.RandomPar(12,16)
  end
  for i=1,num_units do
    u = ScenEdit_AddUnit({type='Air', side='RED', name='RUIN #'..i, dbid=5014, loadoutid=28028, base=ab.name})
    ScenEdit_AssignUnitToMission(u.guid,sagcap2.guid)
    bL3.AuxFunctions.SetDoctrineUnit(u,3413,{target='Fighter',range=math.random(40,50)})
    bL3.AuxFunctions.SetDoctrineUnit(u,3413,{target='Non-Fighter',range=math.random(60,80)})
    AddActiveUnit(u,20)
    bL3.RED.SETUP.F = bL3.RED.SETUP.F + 1
  end
  ScenEdit_FillMagsForLoadout({name=ab.name, side='RED', loadoutid=5014, quantity=24})
  ScenEdit_FillMagsForLoadout({name=ab.name, side='RED', loadoutid=28028, quantity=2})
  ab = GetAB(false)
  for i=1,bL3.AuxFunctions.RandomPar(4,8) do
    u = ScenEdit_AddUnit({type='Air', side='RED', name='ADE #'..i, dbid=5014, loadoutid=28028, base=ab.name})
    ScenEdit_AssignUnitToMission(u.guid,sagC2escort.guid)
    bL3.AuxFunctions.SetDoctrineUnit(u,3413,{target='Fighter',range=math.random(40,50)})
    bL3.AuxFunctions.SetDoctrineUnit(u,3413,{target='Non-Fighter',range=math.random(60,80)})
    AddActiveUnit(u,20)
    bL3.RED.SETUP.F = bL3.RED.SETUP.F + 1
  end
  ScenEdit_FillMagsForLoadout({name=ab.name, side='RED', loadoutid=5014, quantity=24})

  ScenEdit_SetMission('RED', OCAMission.guid, {TankerUsage=1, TankerMaxDistance_airborne=250, TankerMissionList={support_guid}})
  ScenEdit_SetMission('RED', AEW_PLAAF.guid, {TankerUsage=1, TankerMaxDistance_airborne=250, TankerMissionList={AAR_PLAAF.name}})
  ScenEdit_SetMission('RED', CAP.guid, {TankerUsage=1, TankerMaxDistance_airborne=250, TankerMissionList={AAR_PLAAF.name}})
end
DeploySAGC2()


local function CreateISR()
  local reconP = {
    {latitude=17.36435, longitude=121.2659},
    {latitude=15.29527, longitude=120.86899},
    {latitude=14.54398, longitude=121.039370},
    {latitude=12.90044, longitude=122.37643},
  }
  local WZ = {
    --WZ-8
    {unit_dbid = 6642, loadoutid = 32885},
    --WZ-7
    {unit_dbid = 7171, loadoutid = 25184}
  }
  local sigintP = {
    {latitude=18.24303, longitude=118.73104},
    {latitude=15.92598, longitude=117.54340},
    {latitude=14.04485, longitude=117.32267},
    {latitude=15.58283, longitude=117.90519}
  }
  
  local ab = GetAB(false)
  
  ScenEdit_AddMission('RED', 'ISR', '', {category='taskpool'})
  for x,p in ipairs(reconP) do
    if math.random() > 0.2*x then goto skipF1 end
    local reconArea = bL3.AuxFunctions.NewArea(p,{side='RED', shape='rectangle', width=50, length=100, bear_offset = 25, name='ISR'..x..'#'})
    local isr_mission = ScenEdit_AddMission('RED', 'LUZON #ISR#'..bL3.AuxFunctions.RandomTxt(4), 'Support', {category='package',pool='ISR',zone=reconArea})
    ScenEdit_SetMission('RED',isr_mission.guid,{TransitAltitudeAircraft='150000ft', StationAltitudeAircraft='150000ft', starttime=os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+math.random(25,125)*60), endtime=os.date(bL3.DATEFORMAT,ScenEdit_CurrentTime()+math.random(12,14)*3600), OnDeactivateRTB=true })
    ScenEdit_SetEMCON('mission',isr_mission.guid,'Radar=Active;OECM=Active')
    local u = ScenEdit_AddUnit({type='Air', side='RED', name='WZ-8#'..x, dbid=WZ[1].unit_dbid, loadoutid=WZ[1].loadoutid, base=ab.name})
    ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'PB1','PB2','SB1','SB2','PMF2','SMF1'}, arc_track={'PB2','SB1'}, dbid=6074})
    ScenEdit_AssignUnitToMission(u.guid, isr_mission.guid)
    if bL3.RED.NKE.AITargeting then AITargeting(u) end
    AddActiveUnit(u)
    ::skipF1::
  end
  local beach = bL3.RED.BEACH
  local reconArea = bL3.AuxFunctions.NewArea(beach,{side='RED', shape='rectangle', width=25, length=60, bear_offset = 350, name='ISR OND #BEACH'})
  local isr_mission = ScenEdit_AddMission('RED', 'LUZON #REC #BEACH', 'Support', {category='package',pool='ISR',zone=reconArea})
  local delay=math.random(50,125)
  ScenEdit_SetMission('RED',isr_mission.guid,{ActiveEMCON=true,TransitAltitudeAircraft='45000ft', StationAltitudeAircraft='45000ft', starttime=os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+delay*60), endtime=os.date(bL3.DATEFORMAT,ScenEdit_CurrentTime()+delay+24*3600), LoopType='1'})
  ScenEdit_SetEMCON('mission',isr_mission.guid,'Radar=Active')
  for i=1,4 do
    local u = ScenEdit_AddUnit({type='Aircraft', name='KRON #QRF #'..bL3.AuxFunctions.RandomTxt(4)..' #'..i, side='RED', dbid=WZ[1].unit_dbid, loadoutid=WZ[1].loadoutid, base=ab.name})
    if math.random() > 0.5 then
      ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'PB1','PB2','SB1','SB2','PMF2','SMF1'}, arc_track={'PB2','SB1'}, dbid=6074})
    end
    if i>1 then
      ScenEdit_SetUnit({guid = u.guid, TimeToReady_Minutes=delay+math.random(60,120)*(i^2)})
    end
    ScenEdit_AssignUnitToMission(u.guid,isr_mission.guid)
  end
  for x,p in ipairs(sigintP) do
    if math.random() > 0.75 then goto skipF2 end
    local reconArea = bL3.AuxFunctions.NewArea(p,{side='RED', shape='rectangle', width=8, length=115, bear_offset = 90, name='SIG'..x..'#'})
    local isr_mission = ScenEdit_AddMission('RED', 'LUZON #SIG#'..bL3.AuxFunctions.RandomTxt(4), 'Support', {category='package',pool='ISR',zone=reconArea})
    ScenEdit_SetMission('RED',isr_mission.guid,{OnDeactivateRTB=true, ActiveEMCON=true,TransitAltitudeAircraft='150000ft', StationAltitudeAircraft='150000ft', starttime=os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+math.random(35,155)*60), endtime=os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+24*3600)})
    ScenEdit_SetEMCON('mission',isr_mission.guid,'Radar=Active;OECM=Active')
    for i=1,3 do
      local u = ScenEdit_AddUnit({type='Air', side='RED', name='WZ-7#'..bL3.AuxFunctions.RandomTxt(3), dbid=WZ[2].unit_dbid, loadoutid=WZ[2].loadoutid, base=ab.name})
      ScenEdit_SetUnit({guid = u.guid, TimeToReady_Minutes=math.random(30,120)})
      ScenEdit_AssignUnitToMission(u.guid, isr_mission.guid)
      if bL3.RED.NKE.AITargeting then AITargeting(u) end
      AddActiveUnit(u)
    end
    ::skipF2::
  end

end
CreateISR()

local function DeployCapabilities()
  if bL3.RED.NKE.CommJamm then
  
    local activationCommJamm = os.date(bL3.DATEFORMAT, bL3.RED.Dtime + math.random(-30,-10)*60)
    bL3.AuxFunctions.TimeEvent('RED Activate Comm Jamm', activationCommJamm, 'bL3.Functions.JamComms("BLUE")', 'add')
    
  end
  
  if bL3.RED.NKE.C2Attack then
    
    local activationTime = os.date(bL3.DATEFORMAT, bL3.RED.Dtime + math.random(-30,10)*60)
    
    bL3.AuxFunctions.TimeEvent('RED Activate C2 Attack', activationTime, 'bL3.NKE.C2Attack("BLUE")', 'add')
    
  end
  
  if bL3.RED.NKE.HackUAV then
    
    local activationTime = os.date(bL3.DATEFORMAT, bL3.RED.Dtime + math.random(-60,-10)*60)
    local areas = {
      {latitude=15.152849, longitude=117.7273},
      {latitude=19.860304, longitude=119.3545},
      {latitude=14.421065, longitude=119.8613},
      {latitude=17.25766, longitude=118.2841}
    }
    local beach = bL3.RED.BEACH
    local position = areas[math.random(#areas)]
    local script
    if math.random() > 0.5 then
      script = 'bL3.Functions.HackUAV('..position.latitude..', '..position.longitude..', "BLUE")'  
    else
      script = 'bL3.Functions.HackUAV('..beach.latitude..', '..beach.longitude..', "BLUE")'  
    end
    
    bL3.AuxFunctions.TimeEvent('RED Activate Hack UAV',activationTime,script,'add')
  end
  
  if bL3.RED.NKE.GPSSpoof then
    
    local activationTime = os.date(bL3.DATEFORMAT, bL3.RED.Dtime + math.random(-60,60)*60)
    local areas = {
      {latitude=15.152849, longitude=117.7273},
      {latitude=19.860304, longitude=119.3545},
      {latitude=14.421065, longitude=119.8613},
      {latitude=17.06225, longitude=122.131683}
    }
    local position = areas[math.random(#areas)]
    local script = 'bL3.Functions.REDGPSSpoof()'
    bL3.AuxFunctions.TimeEvent('RED Activate GPS Spoof',activationTime,script,'add')
  end
  if bL3.RED.NKE.CyberAttack then
    
    local activationTime = os.date(bL3.DATEFORMAT, bL3.RED.Dtime + math.random(-25,20)*60)
    bL3.AuxFunctions.TimeEvent('RED Activate Cyber Attack',activationTime,'bL3.NKE.RedCyberAttack()','add')
  end
  if bL3.RED.NKE.EMAttack then
    
    local activationTime = os.date(bL3.DATEFORMAT, bL3.RED.Dtime + math.random(-25,60)*60)
    bL3.AuxFunctions.TimeEvent('RED Activate EM Attack',activationTime,'bL3.Functions.EMAttack("BLUE")','add')
  end
  if bL3.RED.NKE.EnhancedEW then
    local script = [[
    if bL3.BLUE.ActiveUnits and next(bL3.BLUE.ActiveUnits) then
    for k,v in pairs(bL3.BLUE.ActiveUnits) do
      v.jamresistance = v.jamresistance * 0.8
      bL3.BLUE.ActiveUnits[k] = v
    end
    end
    bL3.AuxFunctions.RemoveEvent('RED Enhanced EW')
    ]]
    local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + 10)
    bL3.AuxFunctions.TimeEvent('RED Enhanced EW',time,script,'add')
  end
  if bL3.RED.NKE.DeployHelios then
    
    local activationTime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + math.random(60,120)*60)
    local lat = bL3.RED.SAGPOS.latitude
    local lon = bL3.RED.SAGPOS.longitude
    bL3.AuxFunctions.TimeEvent('RED Deploy Helios',activationTime,'bL3.Functions.DeployHelios('..lat..','..lon..', "RED")','add')
  end
  if bL3.RED.NKE.SatelliteIntelligence then
    ScenEdit_AddUnit({type='Satellite', name="Whenchang-1", side=bL3.SIDES.RED, dbid=432, orbit='1'})
    ScenEdit_AddUnit({type='Satellite', name="LKW-1", side=bL3.SIDES.RED, dbid=133, orbit='1'})
  end
  ScenEdit_AddUnit({type='Satellite', name="Tianhui-2", side=bL3.SIDES.RED, dbid=413, orbit='2'})
end
-- print("Capabilities")
DeployCapabilities()
local function DeployHumint()
  local humint_locations = {
    {latitude='14.4607670814977', longitude='120.551036018358'},
    {latitude='14.4799356310929', longitude='120.892539777215'},
    {latitude='14.4838165075585', longitude='121.048229287009'},
    {latitude='15.1537237719589', longitude='120.543894686963'},
    {latitude='16.3244067401643', longitude='119.868421504699'},
    {latitude='18.1665024600428', longitude='120.52593541065'},
    {latitude='14.7953946138601', longitude='120.109962546105'},
  }
  for k,v in ipairs(humint_locations) do
    local u = ScenEdit_AddUnit({type='Facility', name='HUMINT #'..bL3.AuxFunctions.RandomTxt(3), side='RED', dbid=614, latitude=v.latitude, longitude=v.longitude, autodetectable=false})
    if u then
      ScenEdit_UpdateUnit({guid=u.guid, mode='add_sensor', arc_detect={'360'},arc_track={'360'}, dbid=6029})
    end
  end
end
DeployHumint()

local function DeployEWRadars()
  local position = {
    {latitude='18.9286354783879', longitude='110.204357976276'},
    {latitude='23.1917985469779', longitude='116.04341609583'}
  }
  for _,p in ipairs(position) do
    local u = ScenEdit_AddUnit({type='Facility', name='ABM EW #'..bL3.AuxFunctions.RandomTxt(3), side='RED', dbid=3060, latitude=p.latitude, longitude=p.longitude, autodetectable=false})
    ScenEdit_SetEMCON('unit', u.guid, 'Radar=Active')

    u = ScenEdit_AddUnit({type='Facility', name='EWR #'..bL3.AuxFunctions.RandomTxt(3), side='RED', dbid=3419, latitude=p.latitude, longitude=p.longitude, autodetectable=false})
    ScenEdit_SetEMCON('unit', u.guid, 'Radar=Active')
  end
  position = {latitude=18.4998039, longitude=110.9212}
  local u = ScenEdit_AddUnit({type='Ship', name='AGI EW #'..bL3.AuxFunctions.RandomTxt(3), side='RED', dbid=4608, latitude=position.latitude, longitude=position.longitude, autodetectable=false})
  ScenEdit_SetEMCON('unit', u.guid, 'Radar=Active')
end

DeployEWRadars()

bL3.MSG.BlueOPORD(bL3.RED.SETUP)
---TODO
---DOCTRINE
bL3.AuxFunctions.SetDoctrineSide('RED',3413,{target='Fighter',range=45})
bL3.AuxFunctions.SetDoctrineSide('RED',4110,{target='Fighter',range=105})
bL3.AuxFunctions.SetDoctrineSide('RED',4090,{target='Fighter',range=45})
bL3.AuxFunctions.SetDoctrineSide('RED',3413,{target='Non-Fighter',range=90})
bL3.AuxFunctions.SetDoctrineSide('RED',4110,{target='Non-Fighter',range=180})
bL3.AuxFunctions.SetDoctrineSide('RED',4090,{target='Non-Fighter',range=70})

ScenEdit_SetDoctrine({side='RED'},{weapon_control_status_subsurface=0})


bL3.AuxFunctions.UnitDetected('RED Detection Process','RED','bL3.Functions.REDDetection()',nil,nil)

-- local eval_time = os.date(bL3.DATEFORMAT, bL3.RED.Dtime - 120*60)
bL3.AuxFunctions.RegularEvent('RED 15m Trig', 6,'bL3.Functions.REDEval(); bL3.Functions.UpdateSSNPatrols();','add')

--Intelligence Report on RED ToT 
local time = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime() + math.random(3,4)*60*60 + math.random(59)*60)
bL3.AuxFunctions.TimeEvent('INTREP 1',time,"bL3.MSG.INTREPTOT()",'add',false)

--Assigning Strike missions for units
bL3.RED.DynStrikes = ScenEdit_CurrentTime() + math.random(4,5)*60*60 + math.random(59)*60
time = os.date(bL3.DATEFORMAT, bL3.RED.DynStrikes)

bL3.AuxFunctions.TimeEvent('DynStrikes RED',time,"bL3.Functions.DynamicStrikes(); bL3.AuxFunctions.RegularEvent('Update DynMissions', 5, 'bL3.Functions.UpdateTargetList()', 'add')",'add',false)

bL3.AuxFunctions.KillUnitEvent('bL3.Functions.UnitKilled()','add')

local filter = {TargetSide='BLUE', TargetType=4}
bL3.AuxFunctions.UnitDamaged('BlueFacUnitDamaged',filter,'bL3.Functions.BlueFacilityUnitDamaged()','add',75,true)

filter = {TargetSide='RED', TargetType=2}
bL3.AuxFunctions.UnitDamaged('RedShipUnitDamaged',filter,'bL3.Functions.RedShipUnitDamaged()','add',50,true)


bL3.RED.ATTRITION = {Aircraft={CURRENT=0, TOTAL=0},Land={CURRENT=0, TOTAL=0},Sea={CURRENT=0, TOTAL=0}}
local function CreateRedAttrition()
  local function AddUnit(unit)
    if unit.type ~= 'Satellite' and unit.type ~= 'Facility' then
      local row = bL3.REDUNITS[unit.dbid]
      if not row then ScenEdit_SpecialMessage('playerside','No ROW for unit: '..unit.classname) end
      local type = unit.type
      if type == 'Facility' then 
        type = 'Land' 
      elseif type == 'Submarine' or type == 'Ship' then 
        type = 'Sea'
      end
      bL3.RED.ATTRITION[type].TOTAL = bL3.RED.ATTRITION[type].TOTAL + row.points
    end
  end
  local unit_types = {'Ship','Submarine','Aircraft'}
  for _,unit_type in ipairs(unit_types) do
    local units = VP_GetSide({side='RED'}):unitsBy(unit_type)
    if units and next(units) then
      for k,v in ipairs(units) do
        local unit = SE_GetUnit({guid = v.guid})
        AddUnit(unit)
      end
      if unit_type == 'Ship' or unit_type =='Submarine' then
        bL3.RED.ATTRITION.Sea.CURRENT = bL3.RED.ATTRITION.Sea.TOTAL
      else
        bL3.RED.ATTRITION.Aircraft.CURRENT = bL3.RED.ATTRITION.Aircraft.TOTAL
      end
    end
  end
end
CreateRedAttrition()

--Shahed kind drones
local function AddSuicideDrones()
  local mission = ScenEdit_AddMission('RED','Shahed #'..bL3.AuxFunctions.RandomTxt(5), 'strike', {type='land'})
  local startTime = os.date(bL3.DATEFORMAT, ScenEdit_CurrentTime()+120)
  ScenEdit_SetMission('RED', mission.guid, {starttime=startTime})
  local time = os.date(bL3.DATEFORMAT, bL3.RED.Dtime - math.random(5,15)*60)
  mission.TimeOnTargetStation = time
  ScenEdit_SetDoctrine({mission=mission.guid, side='RED'},{engage_opportunity_targets=true, engaging_ambiguous_targets=0})
  local num_drones = math.random(2,bL3.COMPLEXITY*2)
  local drone_location = {
    {latitude=23.13296901, longitude=115.8598504},
    {latitude=22.193, longitude=112.672738},
    {latitude=20.615847583, longitude=110.12218212}
  }
  for i=1,num_drones do
    local position = drone_location[math.random(3)]
    local unit = ScenEdit_AddUnit({type='Facility', side='RED', name='Suicide TEL#'..bL3.AuxFunctions.RandomTxt(5), dbid=4276, latitude=position.latitude+math.random()/500, longitude=position.longitude+math.random(-100,100)/500})
    ScenEdit_AssignUnitToMission(unit.guid,mission.guid)
  end
end
AddSuicideDrones()
gKH.State.SaveTableToKey(bL3.RED,'RED')

