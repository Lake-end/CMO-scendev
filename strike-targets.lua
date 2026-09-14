-- ============================================================
-- Helper: Find existing Contact GUID for a Unit GUID
-- ============================================================
function GetContactGuid(observerSide, targetUnitGuid)
    local contacts = ScenEdit_GetContacts(observerSide)
    if contacts then
        for _, c in pairs(contacts) do
            if c.actualunitid == targetUnitGuid then
                return c.guid
            end
        end
    end
    return nil
end

-- ============================================================
-- STRIKE PLAN CONFIGURATION
-- Edit this table for different event payloads
-- ============================================================
--[[ SHOOTERS:
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGSL6'} //4
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGSJM'} //4
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGSKE'} //4
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGAKQ'} //8
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGAIH'} //8
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGALE'} //8

{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGD00'}
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGD2T'}
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGD29'}

{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPG62V'}
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPG76R'}
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPG60M'}
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGQ5H'} //4
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGPP1'} //4
{name='SSM Bn (SS-26 Stone [9K720 Iskander-M] TEL)', guid='W8V2DT-0HNJH4GEPGQ69'} //4


]]


--[[ TARGETS:
{name='Runway (3200m)', guid='W8V2DT-0HNHJ3HMMI8DD'}  HKI
{name='Runway (3200m)', guid='W8V2DT-0HNHJ3HMMI8D5'}  HKI
{name='Runway-Grade Taxiway (2000m)', guid='W8V2DT-0HNHJ3HMMB7SM'} HKI
{name='Runway (3200m)', guid='W8V2DT-0HNHJ3HMMQ448'} TMP
{name='Runway (3200m)', guid='W8V2DT-0HNHJ3HMMS2SM'} KUO
{name='Runway (2600m)', guid='W8V2DT-0HNHJ3HMMRQCC'} JYVÄ
{name='Runway (2600m)', guid='W8V2DT-0HNHJ3HMMRE75'} HALLI
{name='Runway (3200m)', guid='W8V2DT-0HNHJ3HMMSMBV'} ROVA
{name='Runway (2000m)', guid='W8V2DT-0HNHJ3HMMR8MI'} UTTI
{name='Runway Access Point (Very Large Aircraft)', guid='W8V2DT-0HNHJ3HMMB63T'} UTTI
{name='Runway Access Point (Very Large Aircraft)', guid='W8V2DT-0HNHJ3HMMB63O'} UTTI
{name='Runway (2600m)', guid='W8V2DT-0HNHJ3HMMS8ML'} KAJAANI
{name='Runway (2600m)', guid='W8V2DT-0HNHJ3HMMSAOM'} OULU
{name='Runway (2000m)', guid='W8V2DT-0HNHJ3HMMT47C'} ENO
{name='Runway (2000m)', guid='W8V2DT-0HNHJ3HMMRBF9'} MIKKELI
{name='Runway (2600m)', guid='W8V2DT-0HNHJ3HMMP0HS'} TURKU



]]
local strikePlan = {
    --ROVA RUNWAY STRIKES
    { 
        shooter = "W8V2DT-0HNJH4GEPGSL6", -- Russian Missile Battery A
        targets = {
            "W8V2DT-0HNHJ3HMMSMBV" -- ROVA Runway
        },
        mountID = 2774, 
        weaponID = 1235,
        qty = 4 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGSJM", -- Russian Missile Battery A
        targets = {
            "W8V2DT-0HNHJ3HMMSMBV" -- ROVA Runway
        },
        mountID = 2774, 
        weaponID = 1235,
        qty = 4 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGSKE", -- Russian Missile Battery A
        targets = {
            "W8V2DT-0HNHJ3HMMSMBV" -- ROVA Runway
        },
        mountID = 2774, 
        weaponID = 1235,
        qty = 4 -- 
    },

    -- KAJAANI, OULU, ENO RUNWAY STRIKES
    { 
        shooter = "W8V2DT-0HNJH4GEPGAKQ", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMS8ML"  -- KAJAANI Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGAIH", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMSAOM"  -- OULU Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGALE", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMT47C"  -- ENO Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    -- KUOPIO, MIKKELI, JYVÄSKYLÄ RUNWAY STRIKES 
    { 
        shooter = "W8V2DT-0HNJH4GEPGD00", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMS2SM"  -- KUOPIO Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGD2T", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMRBF9"  -- MIKKELI Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGD29", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMRQCC"  -- JYVÄSKYLÄ Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    --SOUTH1 TURKU,
    { 
        shooter = "W8V2DT-0HNJH4GEPG62V", -- Russian Missile Battery A
        targets = {
            "W8V2DT-0HNHJ3HMMP0HS" -- TURKU Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPG76R", -- Russian Missile Battery A
        targets = {
            "W8V2DT-0HNHJ3HMMRE75" -- HALLI Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPG60M", -- Russian Missile Battery A
        targets = {
            "W8V2DT-0HNHJ3HMMRQCC" -- JYVÄ Runway
        },
        mountID = 755, 
        weaponID = 1235,
        qty = 8 -- 
    },

    -- KAJAANI, OULU, ENO RUNWAY STRIKES
    { 
        shooter = "W8V2DT-0HNJH4GEPGQ5H", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMR8MI"  -- UTTI Runway
        },
        mountID = 2774, 
        weaponID = 1235,
        qty = 4 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGPP1", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMQ448"  -- TMP Runway
        },
        mountID = 2774, 
        weaponID = 1235,
        qty = 4 -- 
    },
    { 
        shooter = "W8V2DT-0HNJH4GEPGQ69", -- Russian Missile Battery B
        targets = {
            "W8V2DT-0HNHJ3HMMB7SM"  -- HKI3 Runway
        },
        mountID = 2774, 
        weaponID = 1235,
        qty = 4 -- 
    }
}

-- ============================================================
-- EXECUTION ENGINE
-- ============================================================
print("--- STARTING SCRIPTED STRIKE SEQUENCE ---")

for _, plan in ipairs(strikePlan) do
    local shooter = plan.shooter
    
    for _, targetUnitGuid in ipairs(plan.targets) do
        -- 1. Identify the Contact for the Shooter's side
        local targetContactGuid = GetContactGuid("Russia", targetUnitGuid)
        
        if targetContactGuid then
            -- 2. Configure Attack Options
            local success = ScenEdit_AttackContact(shooter, targetContactGuid, {
                mode = 1,        -- Manual Allocation
                mount = plan.mountID,
                weapon = plan.weaponID, -- Crucial: Links the specific missile to the mount
                qty = plan.qty
            })
            
            if success then
                print(string.format("SUCCESS: Shooter [%s] firing %d rounds at Target [%s]", shooter, plan.qty, targetUnitGuid))
            else
                print(string.format("ERROR: Shooter [%s] failed to engage Target [%s]", shooter, targetUnitGuid))
            end
        else
            print(string.format("SKIP: No contact found for NATO unit [%s]. Targeted by [%s]", targetUnitGuid, shooter))
        end
    end
end

print("--- STRIKE SEQUENCE FINISHED ---")