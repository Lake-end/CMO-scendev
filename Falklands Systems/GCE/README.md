# Ground Control Engine (GCE) — Falklands 2027

An abstracted, logistics- and combat-power-based ground control engine designed for **Command: Modern Operations (CMO)**. 

The GCE replaces micromanagement of ground sub-units with a strategic tug-of-war system. Players deploy physical combat groups into coastal or inland zones, where they are consumed into numerical **Combat Power (CP)**. The engine continuously evaluates local air cover, naval gunfire support, situational awareness, and supply tethers to dynamically shift zone control percentages, update map labels, flip base facilities, and trigger AI counter-offensives.

---

## 1. Directory & File Structure

All GCE files are organized into two primary folders within your scenario project structure:

```text
Falklands Systems/
├── GCE/
│   ├── Script1_Master_Init.lua               -- Key-Value store baseline initialization
│   ├── Script2_Consumption_Infiltration.lua   -- Ground unit ingestion and CP conversion
│   ├── Script3_Core_Engine_Loop.lua          -- Hourly combat math, tether checks & base handovers
│   ├── Script4_HTML_SITREP.lua               -- On-demand HTML theater overview window
│   └── Script5_ARG_AI_CounterOffensive.lua   -- AI pushback, strategic shifts & physical threat spawns
└── Generic/
    └── Script6_UK_Loss_Tracker.lua           -- Global political loss score & defeat fail-state
```

> **Design Principle:** Every script is **self-contained** with zero external file dependencies or global variable requirements outside CMO's persistent Key-Value (`ScenEdit_SetKeyValue` / `ScenEdit_GetKeyValue`) store. This ensures 100% immunity to save/load memory wipes.

---

## 2. Strategic Mechanics & Operational Flow

```text
┌─────────────────────────┐
│  Physical Unit Deployment│  (Marines / Armor / Artillery land in Zone)
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ Consumption Infiltration │  (Script 2 converts unit into CP points & deletes map object)
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ Core Engine Loop (1 hr) │  (Script 3 applies CAS, NGFS, ISR, Morale & Supply Tether)
└────────────┬────────────┘
             │
             ├──────────────────────────┐
             ▼                          ▼
┌─────────────────────────┐  ┌─────────────────────────┐
│ Tug-of-War Shift (CP%)  │  │ Strategic Capture (85%) │ (Base & embarked assets flip side)
└────────────┬────────────┘  └─────────────────────────┘
             │
             ▼
┌─────────────────────────┐
│ ARG AI Counter-Attack   │  (Script 5 injects ARG power & spawns strike/SAM threats)
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ Victory / Defeat Checks │  (Script 3 Win Check / Script 6 Political Loss Score)
└─────────────────────────┘
```

### Key Operational Rules

* **Logistics & Consumption:** Ground facilities (e.g., Royal Marine Companies, Gun Batteries) entering a zone polygon are absorbed into the zone's persistent CP pool and deleted from the tactical map to preserve game performance.
* **Supply Tether (24-Hour Grace Period):** To push past 20% control into a beachhead breakout (<50% control), an Amphibious or Auxiliary ship must operate within the zone's polygon. Resting a ship in the zone grants **24 hours of supply grace**. If unsupplied when the timer expires, ground forces suffer a **90% combat effectiveness penalty**.
* **Dynamic Modifiers:**
  * **Close Air Support (CAS):** +25% CP bonus when Attack/Fighter aircraft or Utility/Naval Utility helicopters operate inside the zone polygon.
  * **Naval Gunfire Support (NGFS):** +15% CP bonus when surface combatants (FFG/DDG) are present inside the coastal zone polygon.
  * **Global ISR (`ZONE_FALKLANDS_ISR`):** +25% global CP bonus when AEW (Wedgetail), MPA (Poseidon), or UAV assets operate within 100 NM of the islands.
* **Base & Facility Handover (85%+ Threshold):** Once UK control hits 85%, the zone locks as `SECURED`, triggering a global Morale swing (+10% for Stanley/Pleasant, +5% for minor zones) and instantly re-flagging all enemy facilities—including hosted/embarked aircraft and boats—to the UK side.
* **Argentine AI Counter-Offensive:** Evaluates daily. Has a 25% chance to launch a counter-push against any zone with >50% UK control. Injects +150 ARG CP, drops UK control by 10%, resets secured status, and physically spawns:
  * 1x MANPADS Platoon at zone center.
  * 1x Coastal SSM (Exocet) Battery (if coastal zone).
  * 1x Mainland A-4AR Strike Flight 100 NM West, assigned to a dynamic zone patrol mission.

---

## 3. Map & Reference Point Setup Requirements

The GCE relies on strict Reference Point (RP) naming conventions to detect boundaries and update dynamic UI labels on the main map:

1. **Zone Polygons:** Each zone requires at least 3 outer RPs named using the prefix format `ZONE_NAME_1`, `ZONE_NAME_2`, etc. (e.g., `ZONE_SAN_CARLOS_1`). Do **NOT** include `[CTRL` in boundary RP names.
2. **Dynamic UI Label RP:** Place a single, locked RP near the center of each strategic zone named exactly:  
   `ZONE_NAME [CTRL: 0%]` *(e.g., `ZONE_SAN_CARLOS [CTRL: 0%]`)*.  
   The engine automatically renames this RP every hour with current control status and active modifiers (e.g., `ZONE_SAN_CARLOS [CTRL: 42%] - UK BEACHHEAD (CAS, NGFS)`).
3. **Global ISR Zone:** Create a 100 NM outer boundary surrounding the theater named `ZONE_FALKLANDS_ISR_1`, `ZONE_FALKLANDS_ISR_2`, etc.

### Strategic Zone Identifiers (11 Primary Zones)
* `ZONE_SAN_CARLOS`
* `ZONE_BLUFF_COVE`
* `ZONE_GOOSE_GREEN`
* `ZONE_MT_KENT`
* `ZONE_FALKLAND_SOUND`
* `ZONE_PORT_HOWARD`
* `ZONE_FOX_BAY`
* `ZONE_TEAL_INLET`
* `ZONE_PEBBLE_ISLAND`
* `ZONE_STANLEY`
* `ZONE_PLEASANT`

---

## 4. CMO Event Engine Integration & Wiring Table

Configure the following triggers, actions, and frequencies inside the CMO Event Editor UI:

| Script Name | Location | Event Trigger Type | Frequency / Condition | Target Side |
| :--- | :--- | :--- | :--- | :--- |
| **Script 1: Master Init** | `GCE/` | Time Trigger | `00:00:01` (Scenario Start) | Global |
| **Script 2: Consumption** | `GCE/` | Regular Time Trigger | Every **15 - 30 Minutes** | `UK` |
| **Script 3: Core Engine Loop** | `GCE/` | Regular Time Trigger | Every **1 Hour** | `UK` / `Argentina` |
| **Script 4: HTML SITREP** | `GCE/` | Special Action / Time | On-Demand (Menu) / Every **6 Hours** | `UK` |
| **Script 5: AI Counter-Attack**| `GCE/` | Regular Time Trigger | Every **12 - 24 Hours** | `Argentina` |
| **Script 6: UK Loss Tracker** | `Generic/` | Unit Destroyed Trigger | Target Filter: Side = `UK` | `UK` |

### Setting Up the On-Demand SITREP Special Action
To allow the player to open the HTML SITREP via the top menu at any time, execute this line once in the Scenario Editor Lua Console:

```lua
ScenEdit_SetSpecialAction({
    ActionName = "GCE_ViewSITREP",
    text = "GCE: View Strategic SITREP",
    location = "Falklands Systems\\GCE\\Script4_HTML_SITREP.lua",
    isRepeatable = true,
    isContainer = false
})
```

---

## 5. Script Breakdown & Database ID Configuration

### Database ID Configuration (`Script 5`)
Before running a scenario with physical threat spawns, open `Script5_ARG_AI_CounterOffensive.lua` and verify that the database IDs match your active DB3000 version:

```lua
local DBID_ARG_MANPADS = 3913 -- RBS-70 / Igla Platoon
local DBID_ARG_SSM     = 3913 -- Exocet Coastal Battery
local DBID_ARG_STRIKE  = 73   -- A-4AR Fightinghawk / Su-24
local DBID_ARG_LOADOUT = 390  -- Strike Loadout ID
```

### Fail-State Thresholds (`Script 6`)
Located in `Falklands Systems/Generic/Script6_UK_Loss_Tracker.lua`. The UK political collapse threshold is set to **250 points**:
* **Aircraft Carrier (CV/CVN):** +150 pts
* **Amphibious Assault (LHD/LPD):** +100 pts
* **Submarine (SSN):** +75 pts
* **Surface Combatant (DDG/FFG):** +50 pts
* **Auxiliary Supply Ship:** +40 pts
* **ISR Aircraft (AEW/MPA):** +30 pts
* **F-35 Fighter:** +20 pts
* **UAV / Drone:** +2 pts

---

## 6. Campaign Victory Condition

Victory is checked automatically at the end of every Core Engine Loop cycle (`Script 3`). Strategic Victory is declared when:
1. `ZONE_STANLEY` is **SECURED** (>=85% control).
2. `ZONE_PLEASANT` is **SECURED** (>=85% control).
3. At least **8 out of 11** total strategic zones are **SECURED**.