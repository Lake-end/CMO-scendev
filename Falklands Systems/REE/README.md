# Falklands 2027: Random Event Engine (REE)

The Random Event Engine (REE) is an automated, background Lua system designed to inject non-repeating dynamic encounters, operational friction, disinformation campaigns, and tactical dilemmas throughout the month-long Falklands 2027 campaign.

---

## 1. Core Architecture & Design Principles

* **Pacing & Frequency:** Delivers approximately 0–2 random events per in-game day across two 12-hour slots (00:00–12:00 and 12:00–24:00, 50% independent probability each).
* **Non-Repeating (Zero Reoccurrence):** Every event in the catalog can only trigger once per playthrough. Once executed, its unique ID is permanently recorded in the CMO Key-Value Store (`REE_EVENT_USED_<ID>` and `REE_EXECUTED_EVENTS`).
* **Configurable Duration:** The scenario event horizon defaults to 30 days (720 hours) and is configurable via `REE_CONFIG_MAX_DAYS` or at the top of `master-ticker.lua`.
* **Zero External Dependencies:** Packaged as clean, self-contained one-shot scripts compatible with CMO Event Actions without requiring external Lua libraries or filesystem modules.
* **Modal UI Presentation:** Major narrative, intelligence, and disinformation events are rendered directly to the player using `UI_CallAdvancedHTMLDialog` (responsive military dark theme) to guarantee player visibility and pause the simulation clock.

---

## 2. Progressive Milestone Unlocking (KeyValues)

The engine utilizes a 5-tier system. Tier 0 (Anytime) is available from scenario start. Additional tiers are unlocked when scenario triggers set specific milestone KeyValues to `"true"`:

| Tier | Required KeyValue | Campaign Phase | Unlocked Events |
| :--- | :--- | :--- | :--- |
| **Tier 0** | *(None / Baseline)* | Atlantic Transit / General | `EVT_01` – `EVT_12` |
| **Tier 1** | `UK_CARRIER_ARRIVES_ASCENSION` | Ascension Island Midway | `EVT_13` – `EVT_18` |
| **Tier 2** | `UK_CARRIER_ARRIVES_FALKLAND_APPROACHES` | Falklands Approaches (~600 NM) | `EVT_19` – `EVT_23` |
| **Tier 3** | `UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE` | Outer Falklands Perimeter | `EVT_24` – `EVT_27` |
| **Tier 4** | `UK_UNITS_SPOTTED_VICINITY_FALKLANDS` | Falklands Vicinity & Landings | `EVT_28` – `EVT_29` |

*(Note: The engine supports both `UK_CARRIER_ARRIVES_FALKLAND_APPROACHES` and `UK_CARRIER_ARRIVES_FALKLAND_APPROACES` for typo resilience).*

---

## 3. Event Catalog Overview

### Tier 0: Anytime (Atlantic Transit & General)
* **`EVT_01` - Suspicious Ship Intercept:** Spawns an unidentified merchant on intercept heading with the UK transport echelon; player dispatches ISR to achieve visual classification.
* **`EVT_02` - STUFT Navigation Failure:** A contracted merchant vessel suffers satellite transceiver failure and drops out of comms (`outofcomms = true`); restored when a friendly helicopter or escort closes within 0.2 NM.
* **`EVT_03` - Civilian Comms & Auxiliary Outage:** Auxiliary electrical trip slows a STUFT ship to 5 kts; restored when a technical team boards or closes within 0.5 NM.
* **`EVT_04` - Atlantic Storm Cargo Shift:** Severe South Atlantic swell causes cargo lashings to part; speed reduced to 6 kts for 8 hours while cargo is re-lashed.
* **`EVT_05` - Engine / Rudder Breakdown:** Hydraulic steering casualty degrades rudder authority on a UK ship; restored automatically after 4 hours of onboard repairs.
* **`EVT_06` - Disinformation: STUFT Morale:** Intercepted enemy social media broadcasts warning civilian merchant seamen that their ships are legimate war targets.
* **`EVT_07` - Unconfirmed News from Falklands:** Covert intelligence reports regarding Argentine fortifications, SAM and radar installations on East Falkland.
* **`EVT_08` - Faint Russian SSN Acoustic Transient:** Frigate towed array detects momentary narrow-band transient matching a Russian nuclear attack submarine shadowing the fleet in international waters.
* **`EVT_09` - In-Flight Engine Casualty:** Airborne UK aircraft suffers engine casualty, forcing emergency RTB and imposing a 24-hour maintenance penalty.
* **`EVT_10` - Base Ramp Ground Incident:** Ground handling collision aboard base or carrier deck damages aircraft stabilizer; 24-hour ready time delay.
* **`EVT_11` - Deepfake: Warship Attack on Civilians:** Fabricated video thumbnail alleging a Royal Navy destroyer shelled a commercial tanker.
* **`EVT_12` - Staged Falklands Liberation Celebrations:** Adversary propaganda video showing staged civilian rallies welcoming occupying forces in Stanley.

### Tier 1: Ascension Island (`UK_CARRIER_ARRIVES_ASCENSION`)
* **`EVT_13` - Ascension Anchorage Collision:** Minor docking collision between two UK ships in crowded Clarence Bay anchorage during refuelling operations.
* **`EVT_14` - Civilian Distress Call (SAR):** Emergency SOS from bulk carrier *MV Nordik* 60–80 NM out; dynamic SAR area created awarding +50 VP upon response.
* **`EVT_15` - Fake News: Astute SSN Sunk:** Disinformation communique claiming Argentine naval aviation destroyed a British *Astute-class* submarine.
* **`EVT_16` - Biologic Submarine False Contact:** Sonar transient investigated and classified as deep-diving whale pod mimicking diesel submarine propulsion.
* **`EVT_17` - Covert Sabotage Transmitter on STUFT Vessel:** SIGINT locates unauthorized tracking beacon on merchant cargo ship; Royal Marine boarding team neutralizes device.
* **`EVT_18` - Reports of Drones Spotted Near Ascension:** Intelligence alert of reconnaissance UAVs orbiting Ascension; activates Argentine AI mission "Ascension Drone Attack".

### Tier 2: Falkland Approaches (`UK_CARRIER_ARRIVES_FALKLAND_APPROACHES`)
* **`EVT_19` - Fake Social Media: Destroyed UK F-35:** Fabricated wreckage photos claiming first UK F-35B Lightning II shot down by Argentine IADS.
* **`EVT_20` - Deepfake Audio Smear Campaign:** Leaked synthetic audio purporting to show UK commanders ordering strikes on civilian infrastructure.
* **`EVT_21` - Fight on Cramped Troop Transport:** Severe overcrowding aboard Bay-class transport results in internal altercation; medical triage and order restored.
* **`EVT_22` - Long Range Reconnaissance Drone Spotted:** Argentine long-range surveillance UAV detected 140 NM out tracking towards the fleet; CAP scrambled to intercept.
* **`EVT_23` - Civilian Ship Mis-Identified as Hostile:** Fast radar return in transit corridor; RoE discipline advisory warning of score penalty if engaged without PID.

### Tier 3: Greater Falklands Zone (`UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE`)
* **`EVT_24` - Civilian Trawlers Harassing Fleet:** Non-responsive commercial fishing trawler maneuvers across bows to disrupt landing formation; cleared by boarding or warning passes.
* **`EVT_25` - Shadow Navy Ramming Incident:** Rogue trawler deliberately rams UK auxiliary before catching fire and breaking off; 10% damage to player ship.
* **`EVT_26` - Deepwater Submarine Detection:** Sonar detection with 50% chance of spawning neutral Allied US Navy SSN (do not engage) and 50% false alarm.
* **`EVT_27` - Disinformation: Cluster Munitions:** Fabricated diplomatic complaint at UN accusing UK forces of deploying cluster bomblets on Falklands settlements.

### Tier 4: Falklands Vicinity (`UK_UNITS_SPOTTED_VICINITY_FALKLANDS`)
* **`EVT_28` - Weapon Mount Diagnostic Failure:** Pre-combat power surge knocks out a primary weapon mount on an escort warship; repaired in 6–16 hours.
* **`EVT_29` - Fake News: HMS Queen Elizabeth Sunk:** High-impact enemy propaganda claiming UK flagship has been sunk by supersonic anti-ship missiles.

---

## 4. CMO Setup & Deployment Guide

1. **`ree-init-script.lua`**:
   - Trigger: Event 'Scenario is Loaded' or 'Time' trigger (1 second after scenario start).
   - Action: Paste entire `ree-init-script.lua`.
   - Seeds KVS with initial state and schedules Day 1 events.

2. **`master-ticker.lua`**:
   - Trigger: 'Regular Time' trigger set to **1 in-game hour**.
   - Action: Paste entire `master-ticker.lua`.
   - Automatically maintains hour/day clock, rolls daily slots, unlocks milestones, triggers events, and handles deferred repair timers.

---

## 5. Media Attachments & Video Integration

Accompanying images and video clips for disinformation and intelligence events are located in `<scenario-folder>/Attachments/` (and developed in `Attachments/`):

### Event Media Mapping Table

| Event ID | Title | Media Type | File Name | Resolution / Specs |
| :--- | :--- | :--- | :--- | :--- |
| **`EVT_06`** | Disinformation: STUFT Morale | Image | `EVT6.jpg` | 2816x1536 (720px web-optimized inlined) |
| **`EVT_07`** | Unconfirmed News from Falklands | Image | `EVT07.jpg` | 2752x1536 (720px web-optimized inlined) |
| **`EVT_11`** | Deepfake: Warship Attack on Civilians | Image | `EVT11.jpg` | 2816x1536 (720px web-optimized inlined) |
| **`EVT_12`** | Staged Falklands Liberation Celebrations | Video | `EVT12.mp4` | 1080p H.264 (5.95 MB) |
| **`EVT_15`** | Fake News: Astute SSN Sunk | Image | `EVT15.jpg` | 2752x1536 (720px web-optimized inlined) |
| **`EVT_19`** | Social Media Fake Images: Destroyed UK F-35 | Video | `EVT19.mp4` | 1080p H.264 (6.37 MB) |
| **`EVT_20`** | Deepfake Audio Smear Campaign | Image | `EVT20.jpg` | 2752x1536 (720px web-optimized inlined) |
| **`EVT_27`** | Disinformation: Cluster Munition Accusations | Image | `EVT27.jpg` | 1696x2528 (720px web-optimized inlined) |
| **`EVT_29`** | Fake News: HMS Queen Elizabeth Sunk | Image | `EVT29.jpg` | 2816x1536 (720px web-optimized inlined) |

### Video Playback & Streaming Architecture

1. **In-Game HTML Modal (`UI_CallAdvancedHTMLDialog`)**:
   - WebView2 `NavigateToString` uses an opaque `data:` origin; Chromium security **blocks local `file:///` video sources**.
   - Furthermore, `NavigateToString` enforces a **2 MB string limit**, preventing video files from being inlined as Base64.
   - **Streaming Solution (Recommended)**: Upload the videos to **YouTube** (preferred for adaptive bitrates and no bandwidth limits) or **Google Drive**. Enter the video ID in `master-ticker.lua` under `CONFIG.MEDIA`:
     ```lua
     CONFIG.MEDIA = {
         EVT_12_YOUTUBE = "YOUR_YT_ID_HERE",
         EVT_19_YOUTUBE = "YOUR_YT_ID_HERE",
         -- OR Google Drive File ID:
         EVT_12_GOOGLE_DRIVE = "YOUR_GDRIVE_ID_HERE",
         EVT_19_GOOGLE_DRIVE = "YOUR_GDRIVE_ID_HERE",
     }
     ```
     When set, a responsive embedded video player `<iframe ...>` will play directly inside the in-game modal popup.

2. **Offline Local Video (CMO Native Video Engine)**:
   - For offline players or scenarios without internet, `master-ticker.lua` automatically triggers local video playback via CMO's native video player:
     ```lua
     ScenEdit_PlayVideo("Attachments\\EVT12.mp4", false, 0)
     ScenEdit_UseAttachment("EVT12.mp4")
     ```
   - This launches CMO's built-in media overlay window to play the MP4 directly from disk.

