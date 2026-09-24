---@diagnostic disable: undefined-global
-- ==============================================================================
-- FALKLANDS 2027: RANDOM EVENT ENGINE (REE)
-- SCRIPT 2: MASTER TICKER & EVENT EXECUTION ENGINE v8
-- ==============================================================================
-- PURPOSE:
-- Dynamic, zero-dependency, month-long random event engine for the Falklands 2027
-- scenario. Evaluates in-game time, schedules 0-2 non-repeating events per day
-- across two 12-hour slots, checks campaign milestone KeyValues to progressively
-- unlock event tiers, executes tactical and narrative events, and displays
-- responsive modal dialogs to the player with accompanying image/video media.
--
-- CMO EVENT ENGINE INTEGRATION:
-- 1. Trigger: 'Regular Time' trigger set to exactly 1 in-game hour.
-- 2. Action: Lua Script Action (paste this entire file).
-- 3. Condition: None required.
-- ==============================================================================

local function REE_RunMasterTicker()
    -- ==========================================================================
    -- 1. CONFIGURATION & STATE INITIALIZATION
    -- ==========================================================================
    local devVal = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    local isDevMode = (devVal ~= "false" and devVal ~= "0" and devVal ~= "FALSE")

    -- Developer Mode: Hourly execution is active by default when FALKL_DEV_MODE is true.
    -- To disable hourly runs while keeping Dev Mode active, set 'REE_DEV_HOURLY_OFF'='true'.
    local devHourlyOff = (ScenEdit_GetKeyValue("REE_DEV_HOURLY_OFF") == "true")
    local devForceHourly = (isDevMode and not devHourlyOff) or (ScenEdit_GetKeyValue("REE_DEV_FORCE_EVENT_HOURLY") == "true")

    local CONFIG = {
        SCENARIO_MAX_DAYS    = tonumber(ScenEdit_GetKeyValue("REE_CONFIG_MAX_DAYS")) or 30,
        SLOT1_PROBABILITY    = 0.50, -- 50% chance for Slot 1 (00:00 - 12:00)
        SLOT2_PROBABILITY    = 0.50, -- 50% chance for Slot 2 (12:00 - 24:00)
        PLAYER_SIDE          = "UK",
        OPPOSING_SIDE        = "Argentina",
        NEUTRAL_SIDE         = "Neutral",
        DEV_MODE             = isDevMode,
        DEV_FORCE_HOURLY     = devForceHourly,
        DEV_FORCE_SEQUENTIAL = (ScenEdit_GetKeyValue("REE_DEV_FORCE_SEQUENTIAL") == "true"),
        MEDIA                = {
            ATTACHMENTS_REL_PATH        = "Attachments\\",
            ENABLE_LOCAL_VIDEO_PLAYBACK = true,
            -- Video streaming IDs for HTML modal if user uploads (YouTube / Google Drive):
            EVT_12_YOUTUBE              = "",
            EVT_12_GOOGLE_DRIVE         = "https://drive.google.com/file/d/1dFBCuXf1UqftoPD74k5A-KfB6S5jKIsd/preview",
            EVT_19_YOUTUBE              = "",
            EVT_19_GOOGLE_DRIVE         = "https://drive.google.com/file/d/1dVpsgScXySy_zMVX0ghHeykQiVGi934V/preview"
        }
    }

    -- Load pre-packaged web-optimized media assets (base64 image tables) if present
    local REE_MEDIA_DATA = _G["REE_MEDIA_DATA"]
    if REE_MEDIA_DATA == nil then
        pcall(function()
            ScenEdit_RunScript("Development\\Global\\Falklands Systems\\REE\\ree-media-data.lua")
        end)
        REE_MEDIA_DATA = _G["REE_MEDIA_DATA"]
        if REE_MEDIA_DATA == nil and ScenEdit_UseAttachment then
            pcall(ScenEdit_UseAttachment, "ree-media-data.lua")
            REE_MEDIA_DATA = _G["REE_MEDIA_DATA"]
        end
    end

    local function LogREE(msg)
        local h = ScenEdit_GetKeyValue("REE_SCENARIO_HOUR") or "0"
        print(string.format("[REE Ticker Hr %s] %s", h, msg))
    end

    local function DevLog(msg)
        if CONFIG.DEV_MODE then
            local h = ScenEdit_GetKeyValue("REE_SCENARIO_HOUR") or "0"
            print(string.format("[REE DEBUG Hr %s] %s", h, msg))
        end
    end

    -- Update scenario hour counter
    local currentHour = (tonumber(ScenEdit_GetKeyValue("REE_SCENARIO_HOUR")) or 0) + 1
    ScenEdit_SetKeyValue("REE_SCENARIO_HOUR", tostring(currentHour))
    local currentDay = math.floor((currentHour - 1) / 24) + 1

    LogREE(string.format("--- Clock Tick: Hour %d (Day %d of %d) ---", currentHour, currentDay, CONFIG.SCENARIO_MAX_DAYS))

    -- ==========================================================================
    -- 2. MODAL DIALOG PRESENTER & TEMPLATE BUILDER
    -- ==========================================================================
    local function BuildModalHtml(categoryBadge, title, contentHtml, hourStr, mediaConfig)
        local badgeClass = "badge-" .. (categoryBadge:lower())

        local mediaHtml = ""
        if mediaConfig then
            if mediaConfig.type == "image" then
                local imgData = (REE_MEDIA_DATA and REE_MEDIA_DATA[mediaConfig.key]) or mediaConfig.url
                local caption = mediaConfig.caption or "Classified Intelligence Media"
                if imgData and imgData ~= "" then
                    mediaHtml = string.format([[
        <div class="media-card">
            <img src="%s" alt="Tactical Media" />
            <div class="media-caption">
                <span>%s</span>
                <span class="media-badge">CLASSIFIED RECON</span>
            </div>
        </div>]], imgData, caption)
                else
                    mediaHtml = string.format([[
        <div class="media-card">
            <div class="media-caption">
                <span>[ATTACHMENT: %s] %s</span>
                <span class="media-badge">MEDIA ASSET</span>
            </div>
        </div>]], mediaConfig.file or "Image", caption)
                end
            elseif mediaConfig.type == "video" then
                local caption = mediaConfig.caption or "Classified Video Intercept"
                local rawYt = mediaConfig.youtubeId or (CONFIG.MEDIA and CONFIG.MEDIA[mediaConfig.key .. "_YOUTUBE"]) or ""
                local rawGDrive = mediaConfig.googleDriveId or (CONFIG.MEDIA and CONFIG.MEDIA[mediaConfig.key .. "_GOOGLE_DRIVE"]) or ""

                -- Resolve YouTube embed URL
                local ytUrl = ""
                if rawYt ~= "" then
                    if rawYt:find("^https?://") then
                        local ytCode = rawYt:match("v=([%w_%-]+)") or rawYt:match("youtu%.be/([%w_%-]+)") or rawYt:match("embed/([%w_%-]+)")
                        if ytCode then
                            ytUrl = "https://www.youtube.com/embed/" .. ytCode
                        else
                            ytUrl = rawYt
                        end
                    else
                        ytUrl = "https://www.youtube.com/embed/" .. rawYt
                    end
                end

                -- Resolve Google Drive embed URL
                local gDriveUrl = ""
                if rawGDrive ~= "" then
                    if rawGDrive:find("^https?://") then
                        -- Convert standard share/view URLs to /preview embed
                        gDriveUrl = rawGDrive:gsub("/view%??[^/]*$", "/preview")
                        if not gDriveUrl:find("/preview$") and not gDriveUrl:find("/preview%?") then
                            gDriveUrl = gDriveUrl:gsub("/?$", "/preview")
                        end
                    else
                        gDriveUrl = "https://drive.google.com/file/d/" .. rawGDrive .. "/preview"
                    end
                end

                if ytUrl ~= "" then
                    mediaHtml = string.format([[
        <div class="media-card">
            <iframe src="%s" title="Video Intercept" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            <div style="text-align: center; padding: 8px 12px; background: #161b22; border-top: 1px solid #21262d; font-size: 13px; color: #58a6ff;">
                <strong>Click play to watch the video</strong>
            </div>
            <div class="media-caption">
                <span>%s</span>
                <span class="media-badge">VIDEO INTERCEPT</span>
            </div>
        </div>]], ytUrl, caption)
                elseif gDriveUrl ~= "" then
                    mediaHtml = string.format([[
        <div class="media-card">
            <iframe src="%s" title="Video Intercept" allow="autoplay" allowfullscreen></iframe>
            <div style="text-align: center; padding: 8px 12px; background: #161b22; border-top: 1px solid #21262d; font-size: 13px; color: #58a6ff;">
                <strong>Click play to watch the video</strong>
            </div>
            <div class="media-caption">
                <span>%s</span>
                <span class="media-badge">VIDEO INTERCEPT</span>
            </div>
        </div>]], gDriveUrl, caption)
                else
                    mediaHtml = string.format([[
        <div class="media-card">
            <div class="video-fallback-box">
                <div class="video-fallback-title">&#9658; CLASSIFIED VIDEO INTERCEPT: %s</div>
                <div class="video-fallback-desc">Tactical Video Recording (1080p H.264) | South Atlantic Electronic Intercept</div>
                <div style="font-size: 11px; color: #58a6ff; font-family: monospace;">Packaged in: &lt;scenario-folder&gt;\Attachments\%s</div>
            </div>
            <div style="text-align: center; padding: 8px 12px; background: #161b22; border-top: 1px solid #21262d; font-size: 13px; color: #58a6ff;">
                <strong>Click play to watch the video</strong>
            </div>
            <div class="media-caption">
                <span>%s</span>
                <span class="media-badge">LOCAL VIDEO ATTACHMENT</span>
            </div>
        </div>]], mediaConfig.file or "Video", mediaConfig.file or "Video", caption)
                end
            end
        end

        local finalBody = contentHtml
        if mediaHtml and mediaHtml ~= "" then
            finalBody = finalBody .. mediaHtml
        end

        return string.format([[<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>%s</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            background-color: #0d1117;
            color: #c9d1d9;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            padding: 16px;
            display: flex;
            justify-content: center;
        }
        .container {
            width: 100%%;
            max-width: 820px;
            background: #161b22;
            border: 1px solid #30363d;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.6);
        }
        .content {
            padding: 24px;
            font-size: 14px;
            line-height: 1.6;
            color: #e6edf3;
        }
        .content p { margin-bottom: 12px; }
        .quote-box {
            background: #0d1117;
            border-left: 4px solid #58a6ff;
            padding: 12px 16px;
            margin: 14px 0;
            font-style: italic;
            color: #8b949e;
            border-radius: 0 4px 4px 0;
        }
        .quote-box.disinfo {
            border-left-color: #f85149;
            color: #ffa198;
            background: #221213;
        }
        .media-card {
            margin: 16px 0 8px 0;
            background: #0d1117;
            border: 1px solid #30363d;
            border-radius: 6px;
            overflow: hidden;
        }
        .media-card img {
            width: 100%%;
            max-height: 380px;
            object-fit: cover;
            display: block;
        }
        .media-card iframe {
            width: 100%%;
            height: 280px;
            border: none;
            display: block;
        }
        .media-caption {
            padding: 8px 14px;
            font-size: 11px;
            color: #8b949e;
            background: #161b22;
            border-top: 1px solid #21262d;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .media-badge {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            padding: 2px 6px;
            border-radius: 3px;
            background: #30363d;
            color: #c9d1d9;
        }
        .video-fallback-box {
            padding: 20px 16px;
            text-align: center;
            background: linear-gradient(180deg, #1c2128 0%%, #0d1117 100%%);
        }
        .video-fallback-title {
            font-size: 13px;
            font-weight: 700;
            color: #58a6ff;
            margin-bottom: 6px;
            letter-spacing: 0.5px;
        }
        .video-fallback-desc {
            font-size: 12px;
            color: #8b949e;
            margin-bottom: 8px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="content">
            %s
        </div>
    </div>
</body>
</html>]], title, finalBody)
    end

    local function ShowModalDialog(categoryBadge, title, contentHtml, btnLabel, mediaConfig)
        local button = btnLabel or "Acknowledge"
        local html = BuildModalHtml(categoryBadge, title, contentHtml, tostring(currentHour), mediaConfig)

        pcall(function()
            UI_CallAdvancedHTMLDialog(title, html, { button })
        end)
    end

    -- ==========================================================================
    -- 2.1 DYNAMIC RELATIVE TASK EVENT GENERATOR
    -- ==========================================================================
    -- Dynamically creates 4 Reference Points (relative to a friendly unit or static search box),
    -- registers a UnitEntersArea trigger for side UK, and executes dynamic resolution when
    -- another friendly unit enters the zone (guarding against self-triggering).
    local function CreateDynamicRelativeTask(params)
        local evtName = string.format("REE_Task_%s_%d", params.taskType, currentHour)
        local trigName = string.format("REE_Trig_%s_%d", params.taskType, currentHour)
        local actName = string.format("REE_Act_%s_%d", params.taskType, currentHour)
        local prefix = string.format("RP_%s_%d", params.taskType, currentHour)

        local rpNames = {
            prefix .. "_1",
            prefix .. "_2",
            prefix .. "_3",
            prefix .. "_4"
        }
        local bearings = { 45, 135, 225, 315 }
        local distNM = params.distanceNM or 0.5

        if params.centerLat and params.centerLon then
            -- Create 4 static geographic reference points forming a visible search box
            local dLat = (distNM / 60)
            local dLon = (distNM / (60 * math.cos(math.rad(params.centerLat))))
            local rpCoords = {
                { lat = params.centerLat + dLat, lon = params.centerLon - dLon },
                { lat = params.centerLat + dLat, lon = params.centerLon + dLon },
                { lat = params.centerLat - dLat, lon = params.centerLon + dLon },
                { lat = params.centerLat - dLat, lon = params.centerLon - dLon }
            }
            for i = 1, 4 do
                pcall(function()
                    ScenEdit_AddReferencePoint({
                        side = CONFIG.PLAYER_SIDE,
                        name = rpNames[i],
                        latitude = rpCoords[i].lat,
                        longitude = rpCoords[i].lon,
                        highlighted = true
                    })
                end)
            end
        else
            -- Create relative reference points anchored to friendly unit
            for i = 1, 4 do
                pcall(function()
                    ScenEdit_AddReferencePoint({
                        side = CONFIG.PLAYER_SIDE,
                        name = rpNames[i],
                        relativeTo = params.targetGuid,
                        bearing = bearings[i],
                        distance = distNM,
                        bearingType = 0,
                        bearingtype = 0,
                        highlighted = true
                    })
                end)
            end
        end

        local quotedRps = {}
        for _, n in ipairs(rpNames) do
            table.insert(quotedRps, string.format("%q", n))
        end
        local rpsArrayCode = "{" .. table.concat(quotedRps, ", ") .. "}"

        local completionModalHtml = BuildModalHtml(params.badge or "FLEET", params.title, params.completionHtml,
            tostring(currentHour))

        local trigCreatedTime = 0
        pcall(function() trigCreatedTime = tonumber(ScenEdit_CurrentTime()) or 0 end)

        local actionScriptCode = string.format([[
-- REE Dynamic Task Execution Script
local uX = ScenEdit_UnitX()
if not uX then return end

local targetGuid = %q
local uGuid = tostring(uX.guid or ""):lower()
local tGuid = tostring(targetGuid or ""):lower()

if tGuid ~= "" and (uGuid == tGuid or (uX.group and tostring(uX.group.guid or ""):lower() == tGuid)) then
    -- Distressed/target unit itself is within its own area; ignore and wait for rescue/support unit
    return
end

-- Minimum elapsed time guard for surface ships:
-- Prevents ships that were already sailing adjacent in formation from instantly resolving the task.
-- Helicopters/aircraft dispatched to the datum can resolve at any time.
local createdTime = %d
local now = tonumber(ScenEdit_CurrentTime()) or 0
if uX.type == "Ship" and createdTime > 0 and (now - createdTime) < 600 then
    return
end

local rps = %s
for _, rpName in ipairs(rps) do
    pcall(function() ScenEdit_DeleteReferencePoint({ side = %q, name = rpName }) end)
end
pcall(function() ScenEdit_SetEvent(%q, { mode = 'remove' }) end)
pcall(function() ScenEdit_SetTrigger({ mode = 'remove', name = %q, description = %q }) end)
pcall(function() ScenEdit_SetAction({ mode = 'remove', name = %q, description = %q }) end)

%s

pcall(function()
    local dlgHtml = %q
    UI_CallAdvancedHTMLDialog(%q, dlgHtml, { "Acknowledge" })
end)
]], params.targetGuid or "", trigCreatedTime, rpsArrayCode, CONFIG.PLAYER_SIDE, evtName, trigName, trigName, actName, actName, params.extraActionLua or "",
            completionModalHtml, params.title)

        local tgFilter = {
            TargetSide = CONFIG.PLAYER_SIDE,
            TARGETSIDE = CONFIG.PLAYER_SIDE
        }
        if params.targetTypeFilter then
            tgFilter.TargetType = params.targetTypeFilter
            tgFilter.TARGETTYPE = params.targetTypeFilter
        end

        pcall(function()
            ScenEdit_SetTrigger({
                mode = "add",
                name = trigName,
                description = trigName,
                type = "UnitEntersArea",
                TargetFilter = tgFilter,
                Area = rpNames,
                ExitArea = false
            })
        end)

        pcall(function()
            ScenEdit_SetAction({
                mode = "add",
                name = actName,
                description = actName,
                type = "LuaScript",
                ScriptText = actionScriptCode
            })
        end)

        pcall(function()
            ScenEdit_SetEvent(evtName, {
                mode = "add",
                description = evtName,
                isRepeatable = true,
                isActive = true,
                isShown = false
            })
            ScenEdit_SetEventTrigger(evtName, { mode = "add", name = trigName, description = trigName })
            ScenEdit_SetEventAction(evtName, { mode = "add", name = actName, description = actName })
        end)

        if params.centerLat and params.centerLon then
            LogREE(string.format("DYNAMIC EVENT CREATED: [%s] static search box at (%.2f, %.2f) (radius: %.2f NM)", evtName,
                params.centerLat, params.centerLon, distNM))
        else
            LogREE(string.format("DYNAMIC EVENT CREATED: [%s] relative to unit %s (boundary: %.2f NM)", evtName,
                tostring(params.targetGuid), distNM))
        end
    end

    -- ==========================================================================
    -- 3. CAMPAIGN MILESTONE EVALUATION
    -- ==========================================================================
    local function IsMilestoneActive(keyName)
        local val = ScenEdit_GetKeyValue(keyName)
        if val == "true" or val == "True" or val == "1" then return true end
        -- Resilient check for spelling variants
        if keyName == "UK_CARRIER_ARRIVES_FALKLAND_APPROACHES" then
            local altVal = ScenEdit_GetKeyValue("UK_CARRIER_ARRIVES_FALKLAND_APPROACES")
            if altVal == "true" or altVal == "True" or altVal == "1" then return true end
        end
        return false
    end

    local unlockedTiers = {
        [0] = true, -- Tier 0 (Anytime / Atlantic transit) is always active
        [1] = IsMilestoneActive("UK_CARRIER_ARRIVES_ASCENSION"),
        [2] = IsMilestoneActive("UK_CARRIER_ARRIVES_FALKLAND_APPROACHES"),
        [3] = IsMilestoneActive("UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE"),
        [4] = IsMilestoneActive("UK_UNITS_SPOTTED_VICINITY_FALKLANDS")
    }

    LogREE(string.format(
        "Milestone Tiers: [T0: %s, T1 (Ascension): %s, T2 (Approaches): %s, T3 (Greater Zone): %s, T4 (Vicinity): %s]",
        tostring(unlockedTiers[0]), tostring(unlockedTiers[1]), tostring(unlockedTiers[2]), tostring(unlockedTiers[3]),
        tostring(unlockedTiers[4])))

    -- ==========================================================================
    -- 4. UNIT DISCOVERY & GEOGRAPHIC HELPERS
    -- ==========================================================================
    local function GetUKUnits()
        local side = VP_GetSide({ side = CONFIG.PLAYER_SIDE })
        if side and side.units then return side.units end
        return {}
    end

    local function FindUKConvoyLeadOrCenter()
        local units = GetUKUnits()
        local sumLat, sumLon, count = 0, 0, 0
        local leadUnit = nil

        for _, uDescriptor in ipairs(units) do
            local u = ScenEdit_GetUnit({ guid = uDescriptor.guid })
            if u and u.type == "Ship" then
                if u.name:find("Queen Elizabeth") or (u.group and u.group.lead == u.guid) then
                    leadUnit = u
                end
                sumLat = sumLat + u.latitude
                sumLon = sumLon + u.longitude
                count = count + 1
            end
        end

        if leadUnit then
            return leadUnit.latitude, leadUnit.longitude, leadUnit
        elseif count > 0 then
            return (sumLat / count), (sumLon / count), nil
        else
            return 5.0, -20.0, nil -- Fallback mid-Atlantic coordinates
        end
    end

    local function FindUKUnitMatching(filterFn)
        local units = GetUKUnits()
        local matches = {}
        for _, uDescriptor in ipairs(units) do
            local u = ScenEdit_GetUnit({ guid = uDescriptor.guid })
            if u and filterFn(u) then
                table.insert(matches, u)
            end
        end
        if #matches > 0 then
            return matches[math.random(1, #matches)]
        end
        return nil
    end

    -- ==========================================================================
    -- 5. DAILY TWO-SLOT SCHEDULER
    -- ==========================================================================
    local lastPlannedDay = tonumber(ScenEdit_GetKeyValue("REE_LAST_PLANNED_DAY")) or 0

    if currentDay > lastPlannedDay and currentDay <= CONFIG.SCENARIO_MAX_DAYS then
        LogREE(string.format("Generating new event schedule for Day %d...", currentDay))
        local baseHour = (currentDay - 1) * 24
        local scheduledList = {}

        -- Slot 1 (00:00 - 12:00)
        if math.random() <= CONFIG.SLOT1_PROBABILITY then
            local h1 = baseHour + math.random(1, 12)
            table.insert(scheduledList, h1)
            LogREE(string.format("Day %d Slot 1: Event planned at Hour %d", currentDay, h1))
        else
            LogREE(string.format("Day %d Slot 1: No event rolled", currentDay))
        end

        -- Slot 2 (12:00 - 24:00)
        if math.random() <= CONFIG.SLOT2_PROBABILITY then
            local h2 = baseHour + math.random(13, 24)
            table.insert(scheduledList, h2)
            LogREE(string.format("Day %d Slot 2: Event planned at Hour %d", currentDay, h2))
        else
            LogREE(string.format("Day %d Slot 2: No event rolled", currentDay))
        end

        table.sort(scheduledList)
        local schedStr = table.concat(scheduledList, ",")
        ScenEdit_SetKeyValue("REE_SCHEDULED_HOURS", schedStr)
        ScenEdit_SetKeyValue("REE_LAST_PLANNED_DAY", tostring(currentDay))
        LogREE(string.format("Day %d Scheduled Hours: [%s]", currentDay, schedStr))
    end

    -- Check if an event is scheduled for the current hour
    local scheduledHoursStr = ScenEdit_GetKeyValue("REE_SCHEDULED_HOURS") or ""
    local isEventScheduledNow = false
    local remainingHours = {}

    for hourStr in string.gmatch(scheduledHoursStr, "([^,]+)") do
        local h = tonumber(hourStr)
        if h == currentHour then
            isEventScheduledNow = true
        elseif h and h > currentHour then
            table.insert(remainingHours, h)
        end
    end
    ScenEdit_SetKeyValue("REE_SCHEDULED_HOURS", table.concat(remainingHours, ","))

    -- Developer Mode: Force Hourly Execution
    if CONFIG.DEV_MODE and CONFIG.DEV_FORCE_HOURLY then
        isEventScheduledNow = true
        DevLog("DEV MODE HOURLY RUNNER ACTIVE: Forcing random event execution for Hour " .. currentHour)
    end

    -- ==========================================================================
    -- 6. DEFERRED / ONGOING TIMERS HANDLER
    -- ==========================================================================
    -- 6.1 Cargo Storm Speed Restriction & Engine Casualty
    local stormEndHour = tonumber(ScenEdit_GetKeyValue("REE_Timer_StormEndHour")) or -1
    if stormEndHour > 0 and currentHour >= stormEndHour then
        local shipGuid = ScenEdit_GetKeyValue("REE_Timer_StormShipGUID")
        local compGuid = ScenEdit_GetKeyValue("REE_Timer_StormCompGUID")
        if shipGuid and shipGuid ~= "" then
            if compGuid and compGuid ~= "" and compGuid ~= "engine" then
                ScenEdit_SetUnitDamage({ guid = shipGuid, dp = 0, components = { { compGuid, 'none' } } })
            else
                ScenEdit_SetUnitDamage({ guid = shipGuid, dp = 0, components = { { 'type', type = 'engine', 0 } } })
            end
            ScenEdit_SetUnit({ guid = shipGuid, manualSpeed = "Off" })
            LogREE("ONGOING RESOLVED: Cargo restowing complete and engine casualties cleared on vessel " .. shipGuid .. ". Full speed restored.")
            ShowModalDialog("FLEET", "Cargo Restowing Completed",
                "<p>Deck crews report all cargo lashings have been reinforced and container locks secured following recent Atlantic heavy seas. Engine plant is cleared for normal operations and standard cruising speed is resumed across the formation.</p>",
                "Understood", "FLEET ADVISORY: Cargo secured. Speed restrictions lifted.")
            ScenEdit_SetKeyValue("REE_Timer_StormShipGUID", "")
            ScenEdit_SetKeyValue("REE_Timer_StormCompGUID", "")
            ScenEdit_SetKeyValue("REE_Timer_StormEndHour", "-1")
        end
    end

    -- 6.2 Engine/Rudder Mechanical Repair
    local engineFixHour = tonumber(ScenEdit_GetKeyValue("REE_Timer_EngineFixHour")) or -1
    if engineFixHour > 0 and currentHour >= engineFixHour then
        local shipGuid = ScenEdit_GetKeyValue("REE_Timer_EngineFixShipGUID")
        if shipGuid and shipGuid ~= "" then
            local u = ScenEdit_GetUnit({ guid = shipGuid })
            if u then
                ScenEdit_SetUnitDamage({ guid = shipGuid, dp = 0, components = { { 'rudder', 'none' }, { 'type', type = 'engine', 0 } } })
                ScenEdit_SetUnit({ guid = shipGuid, manualSpeed = "Off" })
                LogREE("ONGOING RESOLVED: Engineering repairs finished on " .. u.name)
                ShowModalDialog("FLEET", "Mechanical Repairs Complete: " .. u.name,
                    string.format(
                        "<p>Chief Engineer aboard <strong>%s</strong> reports replacement hydraulic valves and coupling linkages have been fitted. Propulsion and steering gear have tested fully operational.</p>",
                        u.name),
                    "Understood", "FLEET NOTICE: " .. u.name .. " mechanical casualties resolved.")
            end
            ScenEdit_SetKeyValue("REE_Timer_EngineFixShipGUID", "")
            ScenEdit_SetKeyValue("REE_Timer_EngineFixHour", "-1")
        end
    end

    -- 6.3 Weapon Mount Repair
    local mountRepairHour = tonumber(ScenEdit_GetKeyValue("REE_Timer_MountRepairHour")) or -1
    if mountRepairHour > 0 and currentHour >= mountRepairHour then
        local shipGuid = ScenEdit_GetKeyValue("REE_Timer_MountRepairGUID")
        local mountGuid = ScenEdit_GetKeyValue("REE_Timer_MountRepairMountGUID")
        if shipGuid and shipGuid ~= "" then
            local u = ScenEdit_GetUnit({ guid = shipGuid })
            if u then
                ScenEdit_SetUnitDamage({ guid = shipGuid, dp = 0, components = { { mountGuid or 'mount', 'none' } } })
                LogREE("ONGOING RESOLVED: Mount repairs finished on " .. u.name)
                ShowModalDialog("FLEET", "Weapon Mount Restored: " .. u.name,
                    string.format(
                        "<p>Weapons engineering teams on <strong>%s</strong> have completed electronic diagnostic rebuilds. The affected weapon mount is once again green across all fire-control boards.</p>",
                        u.name),
                    "Understood", "FLEET NOTICE: " .. u.name .. " weapon systems returned to service.")
            end
            ScenEdit_SetKeyValue("REE_Timer_MountRepairGUID", "")
            ScenEdit_SetKeyValue("REE_Timer_MountRepairMountGUID", "")
            ScenEdit_SetKeyValue("REE_Timer_MountRepairHour", "-1")
        end
    end

    -- Note: Active interactive tasks (Comms, Aux Power, SAR, Intercept, Boarding)
    -- are dynamically managed via CMO Event Triggers (UnitEntersArea) and relative RPs.

    -- ==========================================================================
    -- 7. MASTER EVENT CATALOG (29 EVENTS)
    -- ==========================================================================
    local EVENT_CATALOG = {

        -- ----------------------------------------------------------------------
        -- TIER 0: ANYTIME (Atlantic Transit & General Scenario)
        -- ----------------------------------------------------------------------
        {
            id = "EVT_01",
            tier = 0,
            name = "Suspicious Ship Intercept",
            canTrigger = function() return true end,
            execute = function()
                local cLat, cLon, leadUnit = FindUKConvoyLeadOrCenter()
                local leadHdg = (leadUnit and leadUnit.heading and leadUnit.heading > 0) and leadUnit.heading or 195
                local distNM = math.random(50, 100)
                local spawnBrg = (leadHdg + math.random(-20, 20)) % 360
                local radBrg = math.rad(spawnBrg)
                local dLat = (distNM * math.cos(radBrg)) / 60
                local dLon = (distNM * math.sin(radBrg)) / (60 * math.cos(math.rad(cLat)))
                local spawnLat = cLat + dLat
                local spawnLon = cLon + dLon

                local trawler = ScenEdit_AddUnit({
                    type = "Ship",
                    name = "Unknown Merchant",
                    dbid = 2357,
                    side = CONFIG.NEUTRAL_SIDE,
                    latitude = spawnLat,
                    longitude = spawnLon
                })
                if trawler then
                    local retHdg = (spawnBrg + 180) % 360
                    ScenEdit_SetUnit({ guid = trawler.guid, newheading = retHdg, newspeed = 12 })
                    ScenEdit_SetUnit({ guid = trawler.guid, course = { { lat = cLat, lon = cLon } } })

                    CreateDynamicRelativeTask({
                        taskType = "Intercept",
                        targetGuid = trawler.guid,
                        distanceNM = 3.0,
                        badge = "INTEL",
                        title = "Visual Classification: MV Mar Azul",
                        completionHtml =
                        "<p>Task Force reconnaissance asset has closed to visual range and positively classified the contact.</p><p>Vessel is <strong>MV Mar Azul</strong>, a commercial refrigerated cargo vessel registered in Panama. Visual sweeps confirm standard merchant deck layout with no military radar arrays, surveillance domes, or covert launch equipment. Contact designated neutral non-combatant.</p>",
                        extraActionLua = string.format(
                        "pcall(function() ScenEdit_SetUnit({ guid = %q, newname = 'MV Mar Azul (Neutral Reefer)' }) end)",
                            trawler.guid)
                    })
                end
                ShowModalDialog("INTEL", "Suspicious Merchant Heading for Task Force",
                    "<p>Electronic surveillance and maritime tracking algorithms have flagged an unidentified surface vessel tracking directly on an intercept heading with our transport echelon.</p><p>Intelligence cannot rule out ELINT gathering or forward reporting for Argentine reconnaissance assets.</p><p><strong>Action Required:</strong> A designated identification zone has been established ahead of our formation. <strong>Dispatch an air or surface asset into the zone to visually classify and verify the vessel.</strong></p>",
                    "Acknowledge Orders")
            end
        },

        {
            id = "EVT_02",
            tier = 0,
            name = "STUFT Navigation Failure",
            canTrigger = function()
                return FindUKUnitMatching(function(u)
                        return u.type == "Ship" and
                            (u.subtype == "3002" or u.name:find("Point") or u.name:find("STUFT") or u.name:find("Bay"))
                    end) ~=
                    nil
            end,
            execute = function()
                local stuft = FindUKUnitMatching(function(u)
                    return u.type == "Ship" and
                        (u.subtype == "3002" or u.name:find("Point") or u.name:find("STUFT") or u.name:find("Bay"))
                end)
                if not stuft then return end
                ScenEdit_SetUnit({ guid = stuft.guid, outofcomms = true, group = "none", manualSpeed = "8" })

                CreateDynamicRelativeTask({
                    taskType = "STUFT_Comms",
                    targetGuid = stuft.guid,
                    distanceNM = 0.5,
                    badge = "FLEET",
                    title = "STUFT Communications Restored: " .. stuft.name,
                    completionHtml = string.format(
                        "<p>A friendly unit has rendezvoused inside the designated support zone with <strong>%s</strong>.</p><p>Visual light signalling and close-range tactical UHF relay have re-aligned the merchant vessel's encrypted communications and satellite receivers. <strong>%s has rejoined the networked Tactical Picture.</strong></p>",
                        stuft.name, stuft.name),
                    extraActionLua = string.format(
                    "pcall(function() ScenEdit_SetUnit({ guid = %q, outofcomms = false, manualSpeed = 'Off' }) end)", stuft.guid)
                })

                ShowModalDialog("WARNING", "STUFT Vessel Out of Comms: " .. stuft.name,
                    string.format(
                        "<p>The commercial master of <strong>%s</strong> reports total failure of their primary satellite transceiver and encrypted tactical link. The ship has dropped off our networked tactical picture.</p><p><strong>Action Required:</strong> A dynamic rendezvous zone has been marked around the ship. <strong>Dispatch an escort warship or helicopter into the zone to re-establish visual/UHF contact and guide them back into formation.</strong></p>",
                        stuft.name),
                    "Dispatch Guide")
            end
        },

        {
            id = "EVT_03",
            tier = 0,
            name = "Civilian Comms & Auxiliary Outage",
            canTrigger = function()
                return FindUKUnitMatching(function(u)
                        return u.type == "Ship" and
                            (u.subtype == "3002" or u.name:find("Point") or u.name:find("Tide") or u.name:find("STUFT"))
                    end) ~=
                    nil
            end,
            execute = function()
                local civShip = FindUKUnitMatching(function(u)
                    return u.type == "Ship" and
                        (u.subtype == "3002" or u.name:find("Point") or u.name:find("Tide") or u.name:find("STUFT"))
                end)
                if not civShip then return end
                ScenEdit_SetUnit({ guid = civShip.guid, group = "none", manualSpeed = "5" })

                CreateDynamicRelativeTask({
                    taskType = "AuxPower",
                    targetGuid = civShip.guid,
                    distanceNM = 0.5,
                    badge = "FLEET",
                    title = "Technical Assistance Complete: " .. civShip.name,
                    completionHtml = string.format(
                        "<p>Engineering specialists have successfully reached <strong>%s</strong> and boarded the vessel.</p><p>The auxiliary electrical breaker trip has been cleared, main generator cooling loops purged, and automation systems restored. <strong>Full convoy transit speed has been restored.</strong></p>",
                        civShip.name),
                    extraActionLua = string.format(
                    "pcall(function() ScenEdit_SetUnit({ guid = %q, manualSpeed = 'Off' }) end)", civShip.guid)
                })

                ShowModalDialog("FLEET", "Auxiliary Power Failure: " .. civShip.name,
                    string.format(
                        "<p>Critical auxiliary electrical trip aboard <strong>%s</strong> has knocked out cooling pumps and automated shipboard networks. The vessel has been forced to reduce speed to emergency crawl (<strong>5 knots</strong>).</p><p><strong>Action Required:</strong> A support zone has been established around the vessel. <strong>Deploy a helicopter or surface boat team into the zone to deliver technical specialist personnel and restore power.</strong></p>",
                        civShip.name),
                    "Deploy Support")
            end
        },

        {
            id = "EVT_04",
            tier = 0,
            name = "Atlantic Storm Cargo Shift",
            canTrigger = function()
                return FindUKUnitMatching(function(u)
                        return u.type == "Ship" and
                            (u.name:find("Point") or u.name:find("Bay") or u.name:find("STUFT") or u.subtype == "3002")
                    end) ~=
                    nil
            end,
            execute = function()
                local cargoShip = FindUKUnitMatching(function(u)
                    return u.type == "Ship" and
                        (u.name:find("Point") or u.name:find("Bay") or u.name:find("STUFT") or u.subtype == "3002")
                end)
                if not cargoShip then return end

                local engComp = nil
                local uFull = ScenEdit_GetUnit({ guid = cargoShip.guid })
                if uFull and uFull.components then
                    for _, comp in ipairs(uFull.components) do
                        local ct = tostring(comp.comp_type or comp.type or ""):lower()
                        local cn = tostring(comp.comp_name or comp.name or ""):lower()
                        if ct:find("engine") or ct:find("propulsion") or cn:find("engine") or cn:find("propulsion") or cn:find("diesel") or cn:find("turbine") or cn:find("shaft") then
                            engComp = comp.comp_guid or comp.guid
                            break
                        end
                    end
                end

                if engComp then
                    ScenEdit_SetUnitDamage({ guid = cargoShip.guid, dp = 0, components = { { engComp, '1' } } })
                    ScenEdit_SetKeyValue("REE_Timer_StormCompGUID", engComp)
                else
                    ScenEdit_SetUnitDamage({ guid = cargoShip.guid, dp = 0, components = { { 'type', type = 'engine', 1 } } })
                    ScenEdit_SetKeyValue("REE_Timer_StormCompGUID", "engine")
                end

                ScenEdit_SetUnit({ guid = cargoShip.guid, manualSpeed = "6" })
                ScenEdit_SetKeyValue("REE_Timer_StormShipGUID", cargoShip.guid)
                ScenEdit_SetKeyValue("REE_Timer_StormEndHour", tostring(currentHour + 8))
                ShowModalDialog("WARNING", "Severe Atlantic Swell: Cargo Shift on " .. cargoShip.name,
                    string.format(
                        "<p>Heavy South Atlantic swells exceeding Sea State 6 have caused container lashings on the forward deck of <strong>%s</strong> to part. Shifted cargo threatens hull stability.</p><p>Propulsion has been reduced to minimum steerageway while damage-control parties re-stow and weld security stays. Estimated repair time: <strong>8 hours</strong>.</p>",
                        cargoShip.name),
                    "Acknowledge", "WEATHER ALERT: " .. cargoShip.name .. " slowed for cargo re-lashing.")
            end
        },

        {
            id = "EVT_05",
            tier = 0,
            name = "Engine / Rudder Breakdown",
            canTrigger = function()
                return FindUKUnitMatching(function(u) return u.type == "Ship" end) ~= nil
            end,
            execute = function()
                local ship = FindUKUnitMatching(function(u) return u.type == "Ship" end)
                if not ship then return end
                ScenEdit_SetUnitDamage({ guid = ship.guid, dp = 0, components = { { 'rudder', 'Medium' } } })
                ScenEdit_SetUnit({ guid = ship.guid, manualSpeed = "8" })
                ScenEdit_SetKeyValue("REE_Timer_EngineFixShipGUID", ship.guid)
                ScenEdit_SetKeyValue("REE_Timer_EngineFixHour", tostring(currentHour + 4))
                ShowModalDialog("FLEET", "Engineering Casualty: " .. ship.name,
                    string.format(
                        "<p>Casualty report from <strong>%s</strong>: A ruptured high-pressure hydraulic steering actuator has degraded rudder authority. Speed restricted to 8 knots.</p><p>Chief Engineer predicts repairs will take approximately <strong>4 hours</strong> using onboard spare components.</p>",
                        ship.name),
                    "Monitor Repairs", "FLEET CASUALTY: " .. ship.name .. " suffering hydraulic steering casualty.")
            end
        },

        {
            id = "EVT_06",
            tier = 0,
            name = "Disinformation: STUFT Morale",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Disinformation Targeting Merchant Crews",
                    "<p>Naval Intelligence has intercepted coordinated disinformation broadcasts and targeted social media pushes aimed directly at contracted merchant sailors aboard our STUFT vessels:</p><div class=\"quote-box disinfo\">\"WARNING TO ALL COMMERCIAL MARINERS: You are sailing into a declared military exclusion zone under illegal orders. London cannot protect you. Any merchant vessel carrying military cargo is designated a combatant and will be engaged without warning by Argentine Naval Forces.\"</div><p>Task Force chaplains and liaison officers are liaising with merchant masters to reassure crews and maintain formation discipline.</p>",
                    "Dismiss Propaganda",
                    {
                        type = "image",
                        key = "EVT_06",
                        file = "EVT6.jpg",
                        caption = "INTERCEPT: Social media disinformation graphic targeting commercial STUFT mariners."
                    })
            end
        },

        {
            id = "EVT_07",
            tier = 0,
            name = "Unconfirmed News from Falklands",
            canTrigger = function() return true end,
            execute = function()
                local reports = {
                    "Covert resistance relay: Argentine engineering units spotted installing mobile radar masts and camouflaged revetments along the high ridgelines of Mount Kent.",
                    "Civilian radio dispatch: Heavy container convoys observed moving nightly between Stanley harbour and Mount Pleasant airfield under strict blackout.",
                    "Signals intercept: Argentine FAA units at Stanley airfield have completed crater repairs and are conducting short-range taxi trials with light observation aircraft."
                }
                local chosenReport = reports[math.random(1, #reports)]
                ShowModalDialog("INTEL", "Unconfirmed Theatre Intelligence Brief",
                    string.format(
                        "<p>The following unconfirmed tactical report has been received via classified civilian intelligence relays in the South Atlantic:</p><div class=\"quote-box\">%s</div><p>Confidence rating: <strong>B3 (Fairly reliable source, unverified information)</strong>. Tactical planners should incorporate this data into forthcoming operational strikes.</p>",
                        chosenReport),
                    "File Intel",
                    {
                        type = "image",
                        key = "EVT_07",
                        file = "EVT07.jpg",
                        caption = "RECON IMAGERY: Smuggled civilian surveillance frame from occupied Falkland Islands."
                    })
            end
        },

        {
            id = "EVT_08",
            tier = 0,
            name = "Faint Russian SSN Acoustic Transient",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("INTEL", "Acoustic Intelligence: Submerged Transient",
                    "<p>Acoustic processing teams on our ASW frigate screen report a brief, high-confidence narrow-band sonar transient 28 NM on our deep-ocean flank. Spectral signature closely matches a <strong>Project 971 Akula / Project 885 Yasen SSN</strong> operating at quiet transit speed.</p><p>Contact was lost abruptly beneath a heavy seasonal thermocline. Allied intelligence assesses Russian naval forces are maintaining passive standoff surveillance of UK Task Force movements in international waters. ASW screens are placed on heightened passive watch.</p>",
                    "Acknowledge", "ASW NOTICE: Faint foreign nuclear submarine acoustic transient logged.")
            end
        },

        {
            id = "EVT_09",
            tier = 0,
            name = "In-Flight Engine Casualty",
            canTrigger = function()
                return FindUKUnitMatching(function(u) return u.type == "Aircraft" and u.airborne == true end) ~= nil
            end,
            execute = function()
                local jet = FindUKUnitMatching(function(u) return u.type == "Aircraft" and u.airborne == true end)
                if not jet then return end
                ScenEdit_SetUnitDamage({ guid = jet.guid, dp = 0, components = { { 'type', type = 'engine', 1 } } })
                ScenEdit_SetUnit({ guid = jet.guid, RTB = true, timetoready_minutes = 1440 })
                ShowModalDialog("WARNING", "In-Flight Emergency: " .. jet.name,
                    string.format(
                        "<p>Mayday call from pilot of <strong>%s</strong>: Severe engine turbine vibration and oil pressure decay. The aircraft has aborted its assigned mission and declared an emergency RTB.</p><p>Upon recovery, the airframe will require a comprehensive powerplant inspection, imposing a <strong>24-hour maintenance turnaround penalty</strong>.</p>",
                        jet.name),
                    "Expedite Recovery",
                    "AIR EMERGENCY: " .. jet.name .. " declaring emergency RTB due to engine casualty.")
            end
        },

        {
            id = "EVT_10",
            tier = 0,
            name = "Base Ramp Ground Incident",
            canTrigger = function()
                return FindUKUnitMatching(function(u) return u.type == "Aircraft" and (not u.airborne or u.altitude == 0) end) ~=
                    nil
            end,
            execute = function()
                local plane = FindUKUnitMatching(function(u)
                    return u.type == "Aircraft" and
                        (not u.airborne or u.altitude == 0)
                end)
                if not plane then return end
                ScenEdit_SetUnit({ guid = plane.guid, timetoready_minutes = 1440 })
                ShowModalDialog("FLEET", "Ground Handling Collision: " .. plane.name,
                    string.format(
                        "<p>Ground operations report: A deck tractor collision during high-tempo repositioning has caused composite skin damage to the horizontal stabilizer of <strong>%s</strong>.</p><p>Damage is non-structural but requires ultrasonic composite scanning before flight clearance. Ready time extended by <strong>24 hours</strong>.</p>",
                        plane.name),
                    "Acknowledge Delay",
                    "MAINTENANCE DELAY: " .. plane.name .. " readiness delayed 24h by ramp incident.")
            end
        },

        {
            id = "EVT_11",
            tier = 0,
            name = "Deepfake: Warship Attack on Civilians",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Adversary Information Campaign: Deepfake BBC Broadcast",
                    "<p>A sophisticated AI-generated video styled as an authentic <em>BBC Breaking News</em> broadcast is currently circulating across international social media networks:</p><div class=\"quote-box disinfo\">\"BREAKING: Unverified video appears to show Royal Navy Type 45 Destroyer HMS Daring opening fire on a neutral Panama-flagged refrigerated cargo vessel in the Atlantic. International maritime bodies condemn 'unprovoked strike'.\"</div><p>Ministry of Defence communications directors have issued immediate digital forensics debunks confirming the footage was completely synthetic.</p>",
                    "Dismiss Disinformation",
                    {
                        type = "image",
                        key = "EVT_11",
                        file = "EVT11.jpg",
                        caption =
                        "FORENSIC ANALYSIS: High-resolution deepfake broadcast frame fabricated by hostile psyop units."
                    })
            end
        },

        {
            id = "EVT_12",
            tier = 0,
            name = "Staged Falklands Liberation Celebrations",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Adversary Media Push: Staged Stanley Footage",
                    "<p>Argentine state television and diplomatic channels have released staged video packages showing ostensible Falkland Island civilians waving Argentine flags and welcoming occupying forces in front of the Secretariat building in Stanley.</p><p>Intelligence analysis indicates the participants are plainclothes military intelligence personnel flown in from Comodoro Rivadavia. Local British citizens remain under strict military curfew.</p>",
                    "Acknowledge",
                    {
                        type = "video",
                        key = "EVT_12",
                        file = "EVT12.mp4",
                        caption =
                        "ADVERSARY VIDEO INTERCEPT: Staged propaganda footage from occupied Stanley Secretariat."
                    })

                if CONFIG.MEDIA and CONFIG.MEDIA.ENABLE_LOCAL_VIDEO_PLAYBACK then
                    pcall(function()
                        if ScenEdit_PlayVideo then
                            ScenEdit_PlayVideo(CONFIG.MEDIA.ATTACHMENTS_REL_PATH .. "EVT12.mp4", false, 0)
                        end
                    end)
                    pcall(function()
                        if ScenEdit_UseAttachment then
                            ScenEdit_UseAttachment("EVT12.mp4")
                        end
                    end)
                end
            end
        },

        -- ----------------------------------------------------------------------
        -- TIER 1: ASCENSION ISLAND (UK_CARRIER_ARRIVES_ASCENSION)
        -- ----------------------------------------------------------------------
        {
            id = "EVT_13",
            tier = 1,
            name = "Ascension Port Anchorage Collision",
            canTrigger = function()
                local ships = {}
                for _, uDesc in ipairs(GetUKUnits()) do
                    local u = ScenEdit_GetUnit({ guid = uDesc.guid })
                    if u and u.type == "Ship" then table.insert(ships, u) end
                end
                if #ships < 2 then return false end
                for i = 1, #ships - 1 do
                    for j = i + 1, #ships do
                        local rng = Tool_Range(ships[i].guid, ships[j].guid)
                        if rng and rng <= 10 then
                            return true
                        end
                    end
                end
                return false
            end,
            execute = function()
                local ships = {}
                for _, uDesc in ipairs(GetUKUnits()) do
                    local u = ScenEdit_GetUnit({ guid = uDesc.guid })
                    if u and u.type == "Ship" then table.insert(ships, u) end
                end
                local pairs = {}
                for i = 1, #ships - 1 do
                    for j = i + 1, #ships do
                        local rng = Tool_Range(ships[i].guid, ships[j].guid)
                        if rng and rng <= 10 then
                            table.insert(pairs, { s1 = ships[i], s2 = ships[j], dist = rng })
                        end
                    end
                end
                if #pairs > 0 then
                    local chosen = pairs[math.random(1, #pairs)]
                    local s1 = chosen.s1
                    local s2 = chosen.s2
                    local dp1 = s1.damage.startdp * 0.05
                    local dp2 = s2.damage.startdp * 0.05
                    ScenEdit_SetUnitDamage({ guid = s1.guid, dp = dp1, components = {} })
                    ScenEdit_SetUnitDamage({ guid = s2.guid, dp = dp2, components = {} })
                    ShowModalDialog("FLEET", "Ascension Anchorage Collision",
                        string.format(
                            "<p>Harbour Master incident report from Clarence Bay, Ascension Island: During congested refuelling operations in dense tidal swell, <strong>%s</strong> and <strong>%s</strong> (operating within %.1f NM of each other) made physical contact.</p><p>Both vessels have sustained minor hull scraping and superficial plating indentations. Watertight integrity remains intact and propulsion and combat systems remain fully operational.</p>",
                            s1.name, s2.name, chosen.dist),
                        "Review Damage", "PORT ACCIDENT: Minor docking collision reported at Ascension anchorage.")
                end
            end
        },

        {
            id = "EVT_14",
            tier = 1,
            name = "Civilian Distress Call (SAR)",
            canTrigger = function() return true end,
            execute = function()
                local cLat, cLon = FindUKConvoyLeadOrCenter()
                local vLat = cLat - (math.random(50, 80) / 60)
                local vLon = cLon + (math.random(-30, 30) / 60)
                local dist = math.floor(Tool_Range({ latitude = cLat, longitude = cLon },
                    { latitude = vLat, longitude = vLon }))

                local distressed = ScenEdit_AddUnit({
                    type = "Ship",
                    name = "Distressed Vessel MV Nordik",
                    dbid = 1474,
                    side = CONFIG.NEUTRAL_SIDE,
                    latitude = vLat,
                    longitude = vLon
                })
                if distressed then
                    ScenEdit_SetUnit({ guid = distressed.guid, newspeed = 0 })

                    CreateDynamicRelativeTask({
                        taskType = "SAR",
                        targetGuid = distressed.guid,
                        distanceNM = 2.0,
                        badge = "INTEL",
                        title = "SAR Mission Accomplished: MV Nordik",
                        completionHtml =
                        "<p>Task Force SAR helicopters and rescue swimmers have entered the search box and completed survivor recovery operations.</p><p>All 24 civilian crew members from <em>MV Nordik</em> have been safely airlifted aboard for emergency medical evaluation. The maritime community and Ministry of Defence commend the Task Force's prompt humanitarian action.</p>",
                        extraActionLua = string.format([[
pcall(function()
    local s = ScenEdit_GetScore(%q) or 0
    ScenEdit_SetScore(%q, s + 50, "SAR MV Nordik Completed")
end)
]], CONFIG.PLAYER_SIDE, CONFIG.PLAYER_SIDE)
                    })
                end

                ShowModalDialog("WARNING", "MAYDAY: Civilian Vessel in Distress",
                    string.format(
                        "<p>Emergency SOS broadcast intercepted from commercial bulk carrier <strong>MV Nordik</strong> approx <strong>%d NM</strong> from our formation.</p><p>The vessel reports catastrophic flooding in the engine spaces following a submerged container strike and is taking on water rapidly.</p><p><strong>Search and Rescue response requested:</strong> A designated search box has been marked around the vessel's last reported position. <strong>Dispatch an air or surface asset into the search box to assist survivors.</strong></p>",
                        dist),
                    "Authorize SAR")
            end
        },

        {
            id = "EVT_15",
            tier = 1,
            name = "Fake News: Astute SSN Sunk",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Argentine MoD Communique: False Astute Kill Claim",
                    "<p>Argentine Armed Forces General Staff has held an international press conference in Buenos Aires claiming that Argentine Navy P-3C maritime patrol aircraft have depth-charged and sunk a British <em>Astute-class</em> nuclear-powered submarine in the South Atlantic.</p><div class=\"quote-box disinfo\">\"We have broken the myth of British underwater invulnerability. The enemy submarine was detected and destroyed with all hands.\"</div><p>Permanent Joint Headquarters confirms all deployed submarine units are accounted for, on station, and operating normally.</p>",
                    "Acknowledge",
                    {
                        type = "image",
                        key = "EVT_15",
                        file = "EVT15.jpg",
                        caption =
                        "PROPAGANDA INTERCEPT: Fabricated press release graphic claiming destruction of UK nuclear submarine."
                    })
            end
        },

        {
            id = "EVT_16",
            tier = 1,
            name = "Subsurface Sonar Transient",
            canTrigger = function() return true end,
            execute = function()
                local ukShips = {}
                for _, uDesc in ipairs(GetUKUnits()) do
                    local u = ScenEdit_GetUnit({ guid = uDesc.guid })
                    if u and u.type == "Ship" then table.insert(ukShips, u) end
                end

                local targetFleetUnit = nil
                if #ukShips > 0 then
                    local candidates = {}
                    for _, s in ipairs(ukShips) do
                        if s.name:find("Queen Elizabeth") or (s.group and s.group.lead == s.guid) then
                            table.insert(candidates, s)
                        end
                    end
                    if #candidates > 0 then
                        targetFleetUnit = candidates[math.random(1, #candidates)]
                    else
                        targetFleetUnit = ukShips[math.random(1, #ukShips)]
                    end
                end

                local fleetName = "the Carrier Strike Group"
                local cLat, cLon = 5.0, -20.0
                if targetFleetUnit then
                    cLat = targetFleetUnit.latitude
                    cLon = targetFleetUnit.longitude
                    if targetFleetUnit.group and targetFleetUnit.group.name and targetFleetUnit.group.name ~= "" then
                        fleetName = targetFleetUnit.group.name
                    elseif targetFleetUnit.name:find("Queen Elizabeth") then
                        fleetName = "Carrier Strike Group (HMS Queen Elizabeth)"
                    else
                        fleetName = string.format("Task Group (%s)", targetFleetUnit.name)
                    end
                else
                    cLat, cLon = FindUKConvoyLeadOrCenter()
                end

                local sLat = cLat + 0.25
                local sLon = cLon - 0.25
                local isBiologic = (math.random(1, 2) == 1)

                if isBiologic then
                    local bio = ScenEdit_AddUnit({
                        type = "Submarine",
                        name = "Biological Contact (Whale Pod)",
                        dbid = 92,
                        side = CONFIG.NEUTRAL_SIDE,
                        latitude = sLat,
                        longitude = sLon,
                        depth = -100
                    })
                    if bio then
                        ScenEdit_SetUnit({ guid = bio.guid, newspeed = 3, newheading = math.random(0, 359) })
                    end
                else
                    local sub = ScenEdit_AddUnit({
                        type = "Submarine",
                        name = "ARA Salta (Type 209)",
                        dbid = 671,
                        side = CONFIG.OPPOSING_SIDE,
                        latitude = sLat,
                        longitude = sLon,
                        depth = -120
                    })
                    if sub then
                        ScenEdit_SetUnit({ guid = sub.guid, newspeed = 4, newheading = math.random(180, 270) })
                    end
                end

                ShowModalDialog("INTEL", "Sonar Contact Alert: Unconfirmed Transient",
                    string.format(
                        "<p>Towed-array and hull sonar operators on the ASW picket screen for <strong>%s</strong> detected an unconfirmed submerged acoustic transient approx 15 NM Northwest of the formation (Lat: %.2f, Lon: %.2f).</p><p>The contact was very brief and has since disappeared from tactical displays, slipping beneath the local thermal layer. Acoustic processing recorded brief blade-rate harmonics consistent with either deep-diving marine biologics or a slow-moving diesel-electric submarine operating on battery.</p><p><strong>Action Required:</strong> The contact is no longer painted on tactical displays. <strong>Dispatch ASW helicopters or escort frigates to prosecute the datum with sonobuoys and dipping sonar to reacquire and classify the contact.</strong></p>",
                        fleetName, sLat, sLon),
                    "Verify Contact", "ASW NOTICE: Submerged acoustic transient detected near " .. fleetName)
            end
        },

        {
            id = "EVT_17",
            tier = 1,
            name = "Sabotage Suspicion on STUFT Ship",
            canTrigger = function()
                return FindUKUnitMatching(function(u)
                    return u.type == "Ship" and
                        (u.name:find("Point") or u.name:find("STUFT") or u.subtype == "3002")
                end) ~= nil
            end,
            execute = function()
                local stuft = FindUKUnitMatching(function(u)
                    return u.type == "Ship" and
                        (u.name:find("Point") or u.name:find("STUFT") or u.subtype == "3002")
                end)
                if not stuft then return end

                CreateDynamicRelativeTask({
                    taskType = "SabotageSweep",
                    targetGuid = stuft.guid,
                    distanceNM = 0.5,
                    badge = "INTEL",
                    title = "Royal Marine Security Sweep Complete: " .. stuft.name,
                    completionHtml = string.format(
                        "<p>Royal Marine boarding team has boarded <strong>%s</strong> and conducted a comprehensive tactical sweep.</p><p>The unauthorized satellite tracking transmitter was discovered concealed inside a refrigerated container hold and neutralized. Clandestine tracking threat permanently eliminated.</p>",
                        stuft.name)
                })

                ShowModalDialog("INTEL", "SIGINT Warning: Unauthorized Beacon on " .. stuft.name,
                    string.format(
                        "<p>GCHQ signals intelligence analysts have identified periodic burst transmissions on non-standard frequencies emanating from aboard <strong>%s</strong>.</p><p>Intelligence suspects a covert satellite tracking beacon planted during dockside loading in the UK.</p><p><strong>Action Required:</strong> A boarding rendezvous zone has been marked around the ship. <strong>Deploy a Royal Marine boarding party via helicopter or boat into the zone to board the vessel, locate the transmitter, and destroy it.</strong></p>",
                        stuft.name),
                    "Deploy Boarding Team")
            end
        },

        {
            id = "EVT_18",
            tier = 1,
            name = "Reports of Drones Spotted Near Ascension",
            canTrigger = function() return true end,
            execute = function()
                pcall(function()
                    ScenEdit_SetMission(CONFIG.OPPOSING_SIDE, "Ascension Drone Attack", { active = true })
                end)
                ShowModalDialog("WARNING", "Air Intelligence: Drones Shadowing Ascension",
                    "<p>Wideawake Airfield radar stations at Ascension Island have detected faint radar cross-section contacts matching commercial long-range reconnaissance drones operating off the island's coastal shelf.</p><p>Intelligence warns that merchant ships flying neutral flags in the region may be launching forward observation UAVs to cue adversary strike operations. <strong>Air defense alert level at Ascension has been elevated to RED.</strong></p>",
                    "Elevate Air Defense",
                    "INTEL ALERT: Unidentified reconnaissance drones detected near Ascension Island.")
            end
        },

        -- ----------------------------------------------------------------------
        -- TIER 2: FALKLAND APPROACHES (UK_CARRIER_ARRIVES_FALKLAND_APPROACHES)
        -- ----------------------------------------------------------------------
        {
            id = "EVT_19",
            tier = 2,
            name = "Social Media Fake Images: Destroyed UK F-35",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Adversary Media Campaign: Fabricated F-35 Wreckage",
                    "<p>Argentine Telegram and social media channels have flooded global networks with AI-generated photographic reels ostensibly displaying burning wreckage of a British F-35B Lightning II bearing RAF squadron insignia.</p><div class=\"quote-box disinfo\">\"IMPERIAL AGGRESSOR DOWNED: First Royal Air Force F-35 stealth fighter shot down by Argentine anti-air missile batteries during reconnaissance over South Atlantic.\"</div><p>Carrier Air Wing confirms 100%% of UK aircraft are secure and fully mission capable aboard HMS Queen Elizabeth.</p>",
                    "Dismiss Propaganda",
                    {
                        type = "video",
                        key = "EVT_19",
                        file = "EVT19.mp4",
                        caption = "MEDIA INTERCEPT: Viral video reel claiming downed Royal Air Force F-35B Lightning II."
                    })

                if CONFIG.MEDIA and CONFIG.MEDIA.ENABLE_LOCAL_VIDEO_PLAYBACK then
                    pcall(function()
                        if ScenEdit_PlayVideo then
                            ScenEdit_PlayVideo(CONFIG.MEDIA.ATTACHMENTS_REL_PATH .. "EVT19.mp4", false, 0)
                        end
                    end)
                    pcall(function()
                        if ScenEdit_UseAttachment then
                            ScenEdit_UseAttachment("EVT19.mp4")
                        end
                    end)
                end
            end
        },

        {
            id = "EVT_20",
            tier = 2,
            name = "Deepfake Audio Smear Campaign",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Adversary Information Warfare: Leaked Strike Audio",
                    "<p>An audio recording purported to be leaked operational radio comms of the UK Task Force Commander ordering unrestricted missile strikes on civilian fuel farms and port infrastructure in Stanley has been distributed to South American news outlets.</p><p>Permanent Joint Headquarters has released cryptographic voice analysis certifying the recording as a computer-generated speech clone. Rules of Engagement remain strictly focused on designated military targets.</p>",
                    "Acknowledge",
                    {
                        type = "image",
                        key = "EVT_20",
                        file = "EVT20.jpg",
                        caption =
                        "FORENSIC TELEMETRY: Voice-stress and spectral harmonic analysis proving deepfake synthetic audio."
                    })
            end
        },

        {
            id = "EVT_21",
            tier = 2,
            name = "Fight on Cramped Troop Transport",
            canTrigger = function()
                return FindUKUnitMatching(function(u)
                    return u.type == "Ship" and (u.name:find("Lyme") or u.name:find("Bay"))
                end) ~= nil
            end,
            execute = function()
                local bay = FindUKUnitMatching(function(u)
                    return u.type == "Ship" and (u.name:find("Lyme") or u.name:find("Bay"))
                end)
                local shipName = bay and bay.name or "RFA Lyme Bay"
                ShowModalDialog("FLEET", "Internal Incident: Cramped Quarters on " .. shipName,
                    string.format(
                        "<p>Logistics and medical report from <strong>%s</strong>: Following the rapid staging embarkation at Ascension, troop accommodation has exceeded design density by over 140%%.</p><p>Prolonged heavy weather and restricted space caused a physical altercation between embarked infantry elements. Ship medical staff treated minor abrasions; commanding officers have instituted staggered exercise rotations to defuse morale tension.</p>",
                        shipName),
                    "Order Enforced", "LOGISTICS REPORT: Overcrowding friction resolved aboard " .. shipName .. ".")
            end
        },

        {
            id = "EVT_22",
            tier = 2,
            name = "Long Range Reconnaissance Drone Spotted",
            canTrigger = function() return true end,
            execute = function()
                local cLat, cLon = FindUKConvoyLeadOrCenter()
                local dLat = cLat - (math.random(120, 160) / 60)
                local dLon = cLon + (math.random(-50, 50) / 60)

                local drone = ScenEdit_AddUnit({
                    type = "Aircraft",
                    name = "Unidentified Air Contact",
                    dbid = 4724,
                    loadoutid = 13989,
                    side = CONFIG.OPPOSING_SIDE,
                    latitude = dLat,
                    longitude = dLon,
                    altitude = 25000
                })
                if drone then
                    ScenEdit_SetUnit({ guid = drone.guid, newheading = 0, newspeed = 180 })
                    ScenEdit_SetUnit({ guid = drone.guid, course = { { lat = cLat, lon = cLon } } })
                end

                ShowModalDialog("WARNING", "Tactical Air Contact: Unidentified Air Contact",
                    "<p>Air defense surveillance radars have detected an unidentified high-altitude, medium-speed air contact approximately 140 NM to the South, tracking directly towards the carrier task group.</p><p>The contact has not squawked an IFF transponder and remains unclassified. Combat Air Patrols (F-35B) or escort fighters are directed to vector toward the contact and achieve visual or electronic identification.</p><p><strong>Rules of Engagement:</strong> If positive identification confirms an Argentine military reconnaissance platform or hostile surveillance asset, weapons release is authorized immediately to neutralize the threat and preserve Task Force emission security.</p>",
                    "Scramble Interceptors", "AIR CONTACT: Unidentified long-range air contact tracking toward Task Force.")
            end
        },

        {
            id = "EVT_23",
            tier = 2,
            name = "Civilian Ship Mis-Identified as Hostile",
            canTrigger = function() return true end,
            execute = function()
                local cLat, cLon = FindUKConvoyLeadOrCenter()
                local sLat = cLat + (math.random(20, 40) / 60)
                local sLon = cLon + (math.random(15, 35) / 60)

                local civShip = ScenEdit_AddUnit({
                    type = "Ship",
                    name = "Commercial Trawler Stella del Sur",
                    dbid = 2357,
                    side = CONFIG.NEUTRAL_SIDE,
                    latitude = sLat,
                    longitude = sLon
                })
                if civShip then
                    ScenEdit_SetUnit({ guid = civShip.guid, newheading = 220, newspeed = 10 })
                end

                ShowModalDialog("INTEL", "Radar Contact: Unidentified Fast Surface Target",
                    "<p>Surface search radar has picked up an intermittent contact exhibiting anomalous radar reflectivity in our forward transit corridor.</p><p><strong>Rules of Engagement Reminder:</strong> Ensure visual or forward-looking infrared (FLIR) verification prior to weapons release. Neutral shipping continues to traverse South Atlantic routes; destruction of innocent civilian vessels will cause severe diplomatic and political backlash.</p>",
                    "Enforce Strict RoE", "SURFACE WARNING: Contact detected in transit corridor. Strict RoE in effect.")
            end
        },

        -- ----------------------------------------------------------------------
        -- TIER 3: GREATER FALKLANDS ZONE (UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE)
        -- ----------------------------------------------------------------------
        {
            id = "EVT_24",
            tier = 3,
            name = "Civilian Trawlers Harassing Fleet",
            canTrigger = function() return true end,
            execute = function()
                local cLat, cLon = FindUKConvoyLeadOrCenter()
                local tLat = cLat + (math.random(5, 12) / 60)
                local tLon = cLon + (math.random(5, 12) / 60)

                local trawler = ScenEdit_AddUnit({
                    type = "Ship",
                    name = "Aggressive Trawler Mar de Plata",
                    dbid = 2357,
                    side = CONFIG.NEUTRAL_SIDE,
                    latitude = tLat,
                    longitude = tLon
                })
                if trawler then
                    ScenEdit_SetUnit({ guid = trawler.guid, newheading = 180, newspeed = 14 })
                    ScenEdit_SetUnit({ guid = trawler.guid, course = { { lat = cLat, lon = cLon } } })

                    CreateDynamicRelativeTask({
                        taskType = "TrawlerHarass",
                        targetGuid = trawler.guid,
                        distanceNM = 2.0,
                        badge = "WARNING",
                        title = "Harassment Intercepted: Mar de Plata",
                        completionHtml =
                        "<p>Task Force asset entered the warning zone around fishing vessel <em>Mar de Plata</em>, conducting low warning passes and stern radio challenges.</p><p>The vessel has abruptly altered course to the East away from the Task Force and reduced speed. Amphibious corridor cleared of harassment.</p>",
                        extraActionLua = string.format([[
pcall(function()
    ScenEdit_SetUnit({ guid = %q, newheading = 90, newspeed = 10, course = {} })
end)
]], trawler.guid)
                    })
                end

                ShowModalDialog("WARNING", "Maritime Harassment: Aggressive Civilian Fishing Vessels",
                    "<p>A non-responsive commercial fishing trawler has aggressively maneuvered across the bows of our amphibious group, attempting to disrupt landing convoy station-keeping.</p><p>Adversary maritime militia tactics suspected. <strong>Action Required:</strong> A warning zone has been designated around the trawler. <strong>Dispatch an armed helicopter or escort into the zone to conduct low-altitude warning passes or deploy boarding personnel to force the vessel to alter course away from the fleet.</strong></p>",
                    "Dispatch Warning")
            end
        },

        {
            id = "EVT_25",
            tier = 3,
            name = "Shadow Navy Ramming Incident",
            canTrigger = function()
                return FindUKUnitMatching(function(u)
                        return u.type == "Ship" and
                            (u.subtype == "3002" or u.name:find("Point") or u.name:find("Tide") or u.name:find("Bay"))
                    end) ~=
                    nil
            end,
            execute = function()
                local playerShip = FindUKUnitMatching(function(u)
                    return u.type == "Ship" and
                        (u.subtype == "3002" or u.name:find("Point") or u.name:find("Tide") or u.name:find("Bay"))
                end)
                if not playerShip then return end

                local newDp = playerShip.damage.startdp * 0.10
                ScenEdit_SetUnitDamage({ guid = playerShip.guid, dp = newDp, components = {} })

                ShowModalDialog("DANGER", "Collision Incident: Shadow Trawler Ramming",
                    string.format(
                        "<p>Emergency casualty report from <strong>%s</strong>: An unflagged steel-hulled fishing vessel deliberately cut across the ship's port quarter, glancing off the hull before drifting clear with heavy engine fires.</p><p><strong>%s</strong> sustained minor structural plating damage, but hull integrity is secure. The rogue trawler has broken off and is dead in the water.</p>",
                        playerShip.name, playerShip.name),
                    "Assess Damage",
                    "COLLISION CASUALTY: " .. playerShip.name .. " damaged in glancing strike by rogue vessel.")
            end
        },

        {
            id = "EVT_26",
            tier = 3,
            name = "Submarine Contact (50% Neutral SSN / 50% False)",
            canTrigger = function() return true end,
            execute = function()
                local roll = math.random(1, 2)
                local cLat, cLon = FindUKConvoyLeadOrCenter()

                if roll == 1 then
                    local sLat = cLat + (math.random(20, 35) / 60)
                    local sLon = cLon + (math.random(20, 35) / 60)
                    local sub = ScenEdit_AddUnit({
                        type = "Submarine",
                        name = "Unidentified Submerged Contact",
                        dbid = 837,
                        side = CONFIG.NEUTRAL_SIDE,
                        latitude = sLat,
                        longitude = sLon,
                        depth = -180
                    })
                    if sub then
                        ScenEdit_SetUnit({ guid = sub.guid, newheading = 270, newspeed = 6 })
                    end
                    ShowModalDialog("INTEL", "Acoustic Detection: Submerged Contact",
                        "<p>Subsurface acoustic signature detected by escort sonobuoys approximately 25 NM from the Task Force. Hydrophone analysis indicates a submerged contact on a quiet westerly transit.</p><p>Tactical classification remains unconfirmed. <strong>Maintain tracking and verify contact identity prior to any escalation.</strong></p>",
                        "Acknowledge", "ASW NOTICE: Unidentified submerged contact detected on flank.")
                else
                    ShowModalDialog("INTEL", "ASW Prosecution: False Transient",
                        "<p>P-8A Poseidon and Merlin HM.2 ASW aircraft investigated an anomalous passive sonar transient 30 NM ahead of the Task Force.</p><p>Multiple active sonobuoy drops and MAD passes yielded zero magnetic or acoustic returns. Contact classified as false alarm caused by deep ocean internal waves.</p>",
                        "Resume Patrol", "ASW UPDATE: Acoustic transient prosecuted and cleared as false alarm.")
                end
            end
        },

        {
            id = "EVT_27",
            tier = 3,
            name = "Disinformation: Cluster Munition Accusations",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Diplomatic Disinformation: Cluster Munition Allegations",
                    "<p>Argentine delegates to the United Nations have formally submitted emergency complaint files claiming British F-35B strike aircraft deployed prohibited cluster munitions near Goose Green and San Carlos.</p><p>Foreign Office spokespersons have forcefully rejected the fabricated claims, reaffirming UK forces are utilizing precision-guided munitions (Paveway IV, SPEAR 3) strictly adhering to the Laws of Armed Conflict.</p>",
                    "Acknowledge",
                    {
                        type = "image",
                        key = "EVT_27",
                        file = "EVT27.jpg",
                        caption =
                        "DIPLOMATIC EXHIBIT: Fabricated ordnance casing photographs presented in bad faith to UN observers."
                    })
            end
        },

        -- ----------------------------------------------------------------------
        -- TIER 4: FALKLANDS VICINITY (UK_UNITS_SPOTTED_VICINITY_FALKLANDS)
        -- ----------------------------------------------------------------------
        {
            id = "EVT_28",
            tier = 4,
            name = "Weapon Mount Diagnostic Failure",
            canTrigger = function()
                return FindUKUnitMatching(function(u) return u.type == "Ship" and u.mounts and #u.mounts > 0 end) ~= nil
            end,
            execute = function()
                local ship = FindUKUnitMatching(function(u) return u.type == "Ship" and u.mounts and #u.mounts > 0 end)
                if not ship then return end

                local mount = ship.mounts[math.random(1, #ship.mounts)]
                local mountGuid = mount.mount_guid or mount.guid
                local mountName = mount.mount_name or mount.name or "Primary Mount"
                local repairHours = math.random(6, 16)

                ScenEdit_SetUnitDamage({ guid = ship.guid, dp = 0, components = { { mountGuid, 'Damaged' } } })
                ScenEdit_SetKeyValue("REE_Timer_MountRepairGUID", ship.guid)
                ScenEdit_SetKeyValue("REE_Timer_MountRepairMountGUID", mountGuid)
                ScenEdit_SetKeyValue("REE_Timer_MountRepairHour", tostring(currentHour + repairHours))

                ShowModalDialog("FLEET", "Fire Control Failure: " .. ship.name,
                    string.format(
                        "<p>Pre-combat electronic diagnostics aboard <strong>%s</strong> have failed on <strong>%s</strong> due to power bus surge.</p><p>The mount has been taken offline while weapons technicians replace blown digital control boards. Estimated repair turnaround: <strong>%d hours</strong>.</p>",
                        ship.name, mountName, repairHours),
                    "Monitor Repair", "WEAPONS CASUALTY: " .. ship.name .. " reports " .. mountName .. " offline.")
            end
        },

        {
            id = "EVT_29",
            tier = 4,
            name = "Fake News: HMS Queen Elizabeth Sunk",
            canTrigger = function() return true end,
            execute = function()
                ShowModalDialog("PSYOP", "Major Disinformation Push: False Carrier Sinking",
                    "<p>Argentine media broadcasts and South American news reels have interrupted regular programming claiming a saturation salvo of BrahMos / Exocet anti-ship missiles has hit and sunk <strong>HMS Queen Elizabeth</strong> in Falkland waters.</p><div class=\"quote-box disinfo\">\"THE PRIDE OF THE ROYAL NAVY HAS BEEN SENT TO THE OCEAN FLOOR: Argentine naval aviation strikes strike the death blow to British naval power.\"</div><p>HMS Queen Elizabeth reports all carrier strike wings fully operational, radar sweeps clear, and combat air patrols maintaining relentless air superiority.</p>",
                    "Broadcast Confirmation",
                    {
                        type = "image",
                        key = "EVT_29",
                        file = "EVT29.jpg",
                        caption =
                        "BROADCAST INTERCEPT: Fabricated television graphic claiming catastrophic loss of HMS Queen Elizabeth."
                    })
            end
        }
    }

    -- ==========================================================================
    -- 8. EVENT SELECTION & EXECUTION LOOP
    -- ==========================================================================
    if isEventScheduledNow then
        LogREE("Hour " .. currentHour .. " is a scheduled event trigger! Assembling candidate pool...")

        local selected = nil

        if CONFIG.DEV_MODE and CONFIG.DEV_FORCE_SEQUENTIAL then
            local seqIndex = ((currentHour - 1) % #EVENT_CATALOG) + 1
            selected = EVENT_CATALOG[seqIndex]
            DevLog(string.format("DEV SEQUENTIAL OVERRIDE: Selected Event %d of %d: [%s] %s (Tier %d)",
                seqIndex, #EVENT_CATALOG, selected.id, selected.name, selected.tier))
        else
            local candidatePool = {}
            local blockedReport = {}

            for _, evt in ipairs(EVENT_CATALOG) do
                local isUsed = (ScenEdit_GetKeyValue("REE_EVENT_USED_" .. evt.id) == "true")
                local isTierUnlocked = (unlockedTiers[evt.tier] == true)
                local canTrigger = true
                if evt.canTrigger then
                    local ok, res = pcall(evt.canTrigger)
                    canTrigger = ok and res
                end

                if not isUsed and isTierUnlocked and canTrigger then
                    table.insert(candidatePool, evt)
                elseif CONFIG.DEV_MODE then
                    local reasons = {}
                    if isUsed then table.insert(reasons, "Used") end
                    if not isTierUnlocked then table.insert(reasons, "Tier" .. evt.tier .. "Locked") end
                    if not canTrigger then table.insert(reasons, "ConditionFalse") end
                    table.insert(blockedReport, string.format("%s(%s)", evt.id, table.concat(reasons, "+")))
                end
            end

            DevLog(string.format("Pool Breakdown: %d eligible candidates. Blocked/Locked (%d): [%s]",
                #candidatePool, #blockedReport, table.concat(blockedReport, ", ")))

            if #candidatePool > 0 then
                selected = candidatePool[math.random(1, #candidatePool)]
            end
        end

        LogREE(string.format("Candidate Pool: %s selected.", selected and ("[" .. selected.id .. "] " .. selected.name) or "NONE"))

        if selected then
            LogREE(string.format(">>> TRIGGERING EVENT: [%s] %s (Tier %d)", selected.id, selected.name, selected.tier))

            local execOk, execErr = pcall(selected.execute)
            if execOk then
                ScenEdit_SetKeyValue("REE_EVENT_USED_" .. selected.id, "true")
                local usedList = ScenEdit_GetKeyValue("REE_EXECUTED_EVENTS") or ""
                if usedList == "" then
                    usedList = selected.id
                else
                    usedList = usedList .. "," .. selected.id
                end
                ScenEdit_SetKeyValue("REE_EXECUTED_EVENTS", usedList)
                ScenEdit_SetKeyValue("REE_LAST_TRIGGERED_EVENT",
                    string.format("[%s] %s (Hour %d)", selected.id, selected.name, currentHour))
                LogREE(string.format("Event %s successfully executed and locked against repeating.", selected.id))
            else
                LogREE(string.format("ERROR executing Event %s: %s", selected.id, tostring(execErr)))
            end
        else
            LogREE("No eligible unexecuted events available in current tier pool. Skipping slot.")
        end
    else
        if CONFIG.DEV_MODE then
            DevLog(string.format("No event scheduled for Hour %d. (Dev Mode hourly runner can be toggled via 'REE_DEV_HOURLY_OFF'='true')", currentHour))
        end
    end

    LogREE("--- REE Ticker Cycle Completed ---")
end

-- Execute Master Ticker
REE_RunMasterTicker()
