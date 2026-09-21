-- ==============================================================================
-- FALKLANDS 2027: ABSTRACTED GROUND CONTROL ENGINE (GCE)
-- SCRIPT 4: HTML SITREP BRIEFING GENERATOR
-- ==============================================================================
-- README & IMPLEMENTATION GUIDE
--
-- PURPOSE:
-- Pulls all current state data, control percentages, active modifiers (CAS, NGFS), 
-- and troop strengths from the Key-Value store, and generates a formatted 
-- HTML briefing window for the player using `ScenEdit_SpecialMessage`.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: Can be linked to a Special Action button, a regular time trigger 
--    (e.g., every 6 hours), or fired automatically after the Core Engine Loop.
-- 2. Action: Lua Script Action (paste this entire block).
-- ==============================================================================

local GCE_Zones = {
    "ZONE_SAN_CARLOS",
    "ZONE_BLUFF_COVE",
    "ZONE_GOOSE_GREEN",
    "ZONE_MT_KENT",
    "ZONE_FALKLAND_SOUND",
    "ZONE_PORT_HOWARD",
    "ZONE_FOX_BAY",
    "ZONE_TEAL_INLET",
    "ZONE_PEBBLE_ISLAND",
    "ZONE_STANLEY",
    "ZONE_PLEASANT"
}

function GCE_GenerateSITREP()
    -- 1. Fetch Global Variables
    local ukMorale = ScenEdit_GetKeyValue("GCE_GLOBAL_UK_MORALE") or "100"
    local argMorale = ScenEdit_GetKeyValue("GCE_GLOBAL_ARG_MORALE") or "100"
    local ukSupply = ScenEdit_GetKeyValue("GCE_GLOBAL_UK_SUPPLY") or "100"
    local ukLosses = ScenEdit_GetKeyValue("GCE_LOSS_SCORE_UK") or "0"

    -- 2. Construct HTML Header & Global Status Panel
    local html = [[
    <body bgcolor="#121212" text="#E0E0E0" style="font-family: Arial, sans-serif; font-size: 12px;">
        <h2 style="color: #4A90E2; border-bottom: 2px solid #4A90E2; padding-bottom: 5px; margin-top: 0;">
            FALKLANDS 2027: STRATEGIC SITREP
        </h2>
        
        <table width="100%" bgcolor="#1E1E1E" cellpadding="6" cellspacing="0" style="border: 1px solid #333333; margin-bottom: 12px;">
            <tr style="background-color: #262626; color: #FFFFFF; font-weight: bold;">
                <td>UK MORALE</td>
                <td>ARG MORALE</td>
                <td>UK SUPPLY LINE</td>
                <td>UK LOSS SCORE</td>
            </tr>
            <tr>
                <td><span style="color: #50E3C2;">]] .. ukMorale .. [[%</span></td>
                <td><span style="color: #FF5A5F;">]] .. argMorale .. [[%</span></td>
                <td><span style="color: #F5A623;">]] .. ukSupply .. [[%</span></td>
                <td><span style="color: #FF5A5F;">]] .. ukLosses .. [[ pts</span></td>
            </tr>
        </table>

        <h3 style="color: #F5A623; margin-bottom: 6px;">THEATER ZONAL CONTROL</h3>
        <table width="100%" cellpadding="6" cellspacing="0" style="border: 1px solid #333333;">
            <tr style="background-color: #1F2A38; color: #FFFFFF; text-align: left;">
                <th>ZONE</th>
                <th>CONTROL</th>
                <th>UK PWR</th>
                <th>ARG PWR</th>
                <th>ACTIVE MODIFIERS</th>
                <th>STATUS</th>
            </tr>
    ]]

    -- 3. Loop Through Zones and Add Rows
    for _, zoneName in ipairs(GCE_Zones) do
        local ctrlPct = tonumber(ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_CTRL_PCT")) or 0
        local ukPwr = ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_UK_PWR") or "0"
        local argPwr = ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_ARG_PWR") or "0"
        local activeMods = ScenEdit_GetKeyValue("ZCTRL_" .. zoneName .. "_ACTIVE_MODS") or ""
        
        -- Determine color coding for control percentage
        local color = "#FF5A5F" -- Red (ARG)
        if ctrlPct >= 20 and ctrlPct < 85 then
            color = "#F5A623" -- Yellow (Contested / Beachhead)
        elseif ctrlPct >= 85 then
            color = "#50E3C2" -- Green (UK Secured)
        end

        -- Format active modifiers text
        local modsDisplay = activeMods
        if modsDisplay == "" then
            modsDisplay = "-"
        end

        html = html .. string.format([[
            <tr style="border-bottom: 1px solid #262626;">
                <td><b>%s</b></td>
                <td><span style="color: %s; font-weight: bold;">%d%%</span></td>
                <td>%s pts</td>
                <td>%s pts</td>
                <td style="color: #4A90E2;">%s</td>
                <td>%s</td>
            </tr>
        ]], zoneName, color, ctrlPct, ukPwr, argPwr, modsDisplay, (ctrlPct >= 85 and "SECURED" or (ctrlPct >= 20 and "BEACHHEAD" or "ARG HOLDING")))
    end

    html = html .. [[
        </table>
        <p style="font-size: 10px; color: #888888; margin-top: 10px; text-align: center;">
            Abstracted Ground Control Engine (GCE) v1.0 &bull; Automated Logistical Feed
        </p>
    </body>
    ]]

    -- 4. Display the HTML Window to the UK Player Side
    ScenEdit_SpecialMessage("UK", html)
end

-- Execute the function to open the SITREP
GCE_GenerateSITREP()