# Falklands 2027: Master Key-Value Store Reference

## Overview & Architecture

In **Command: Modern Operations (CMO)**, the scenario Key-Value Store (`ScenEdit_SetKeyValue` / `ScenEdit_GetKeyValue`) is the primary mechanism for persistent state storage:
- **Save/Load Immunity:** Variables stored in the Key-Value Store are serialized directly into the scenario file (`.scen`). Unlike Lua global variables (`_G`), they survive scenario saves, loads, engine pauses, and restarts.
- **Cross-Script IPC:** Acts as an inter-process communication bus connecting the **Carrier Task Force Selector (CTFS)**, **Random Event Engine (REE)**, and **Ground Control Engine (GCE)**.
- **Zero External Dependencies:** Eliminates file I/O requirements so scenarios run seamlessly on end-user machines.

> [!NOTE]
> All values stored in CMO's Key-Value Store are **strings**. Numerical values must be cast with `tonumber()` and boolean flags tested against `"true"` / `"false"` or `"TRUE"` / `"FALSE"`.

---

## 1. Global Developer Mode & Debug Toggles

These keys control developer mode, verbose diagnostic logging, and test harness execution across all scenario subsystems.

| Key | Type / Format | Default | Description & Usage |
| :--- | :--- | :--- | :--- |
| `FALKL_DEV_MODE` | `"true"` \| `"false"` | `"true"` (dev)<br>`"false"` (release) | **Master Developer Mode Flag.** When active:<br>• **CTFS:** Disables point cost limits, enables all force selection buttons, and un-redacts developer panels.<br>• **GCE:** Prints verbose telemetry dumps to console every cycle (morale, SA multipliers, zone power, and modifier shifts).<br>• **REE:** Enables the test runner and defaults to hourly event execution. |
| `REE_DEV_FORCE_EVENT_HOURLY` | `"true"` \| `"false"` | `"true"` (when dev) | Forces the Random Event Engine to execute a random event on **every single 1-hour tick**, bypassing the standard 0–2 events/day schedule. |
| `REE_DEV_HOURLY_OFF` | `"true"` \| `"false"` | `"false"` | Explicit override flag. Set to `"true"` to suppress the hourly event runner while keeping `FALKL_DEV_MODE = "true"` active for debugging. |
| `REE_DEV_FORCE_SEQUENTIAL` | `"true"` \| `"false"` | `"false"` | Forces the Random Event Engine to trigger events in strict sequential order (`EVT_01` &rarr; `EVT_29`) for comprehensive playtesting. |

---

## 2. CTFS: Carrier Task Force Selector

Written during scenario setup when the player submits their Task Force composition. Queried by logistics, campaign pacing, and narrative scripts.

| Key | Type / Format | Default | Description & Usage |
| :--- | :--- | :--- | :--- |
| `CTFS_COMPLETED` | `"true"` \| `"false"` | `"false"` | Set to `"true"` immediately after the player clicks **Deploy Task Force** and the force spawner successfully initializes all commissioned units. Prevents duplicate task force selection. |
| `CTFS_POINTS_SPENT` | Integer string (e.g. `"45"`) | `"0"` | Total commissioning points spent by the player on naval/aviation units (out of max 100). |
| `CTFS_HOURS_DELAYED` | Integer string (e.g. `"225"`) | `"0"` | Hours of departure delay incurred based on preparation points spent (`pointsSpent * 5` hours). |
| `CTFS_DEPARTURE_DATE` | Date string (e.g. `"2027-05-02 09:00:00"`) | `""` | Formatted Date-Time Group (DTG) reflecting the actual departure time of the Task Force from the UK. |
| `CTFS_TOTAL_UNITS` | Integer string (e.g. `"14"`) | `"0"` | Total count of commissioned ships and combat vessels successfully placed into the scenario. |

---

## 3. REE: Random Event Engine Tracking & State

Maintains scheduling, hour progression, and historical lockouts for all 29 dynamic narrative and tactical events.

| Key | Type / Format | Default | Description & Usage |
| :--- | :--- | :--- | :--- |
| `REE_INITIALIZED` | `"true"` | `"true"` | Set by `ree-init-script.lua` to indicate the REE subsystem has seeded initial keys. |
| `REE_CONFIG_MAX_DAYS` | Integer string (e.g. `"30"`) | `"30"` | Total planned campaign duration in days (30 days = 720 scenario hours). |
| `REE_SCENARIO_HOUR` | Integer string (e.g. `"1"`) | `"0"` | Current cumulative scenario hour counter. Incremented by +1 on every REE master ticker execution. |
| `REE_LAST_PLANNED_DAY` | Integer string (e.g. `"1"`) | `"0"` | The campaign day for which two 12-hour event slots were last scheduled. Generates new schedules when `currentDay > lastPlannedDay`. |
| `REE_SCHEDULED_HOURS` | Comma-delimited list (e.g. `"4,18"`) | `""` | Hours within the current day when an event is scheduled to trigger. Processed and cleared hour-by-hour. |
| `REE_EXECUTED_EVENTS` | Comma-delimited list (e.g. `"EVT_01,EVT_08"`) | `""` | Historical list of all event IDs that have already occurred. Prevents non-repeatable events from triggering twice. |
| `REE_EVENT_USED_<ID>` | `"true"` \| `"false"` | `"false"` | Per-event lockout flag (e.g. `REE_EVENT_USED_EVT_01 = "true"`). Fast-lookup key checked by `canTrigger` eligibility queries. |
| `REE_LAST_TRIGGERED_EVENT` | Text string | `""` | Human-readable log string detailing the most recent event and hour (e.g. `"[Hour 4] EVT_01: Suspicious Trawler / Shadow Vessel"`). |

---

## 4. Campaign Milestone Gates (REE Event Tier Gates)

Progressive milestone keys set by scenario triggers when the UK Task Force reaches geographic or operational boundaries. Used by REE to unlock progressively higher tiers of random events.

| Key | Unlocks | Campaign Phase | Trigger Condition / Event |
| :--- | :--- | :--- | :--- |
| *(None / Baseline)* | **Tier 0** | Atlantic Transit | Available immediately from scenario start (`EVT_01` – `EVT_12`). |
| `UK_CARRIER_ARRIVES_ASCENSION` | **Tier 1** | Ascension Island | Set to `"true"` when UK flagship enters the Ascension Island operating box (`EVT_13` – `EVT_18`). |
| `UK_CARRIER_ARRIVES_FALKLAND_APPROACHES`<br>*(also handles `UK_CARRIER_ARRIVES_FALKLAND_APPROACES`)* | **Tier 2** | Falkland Approaches | Set to `"true"` when UK task forces cross 45°S latitude into the combat theatre (`EVT_19` – `EVT_23`). |
| `UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE` | **Tier 3** | Greater Zone Contact | Set to `"true"` when Argentine long-range radar or MPA detects UK naval units in the outer theatre (`EVT_24` – `EVT_26`). |
| `UK_UNITS_SPOTTED_VICINITY_FALKLANDS` | **Tier 4** | Falklands Vicinity / Littoral | Set to `"true"` when UK combatants enter littoral waters within 100 NM of the islands (`EVT_27` – `EVT_29`). |

---

## 5. REE Dynamic Recovery Timers

Used by the REE master ticker to track multi-hour mechanical, electrical, and damage repairs without freezing the game engine.

| Key | Type / Format | Set By | Description & Usage |
| :--- | :--- | :--- | :--- |
| `REE_Timer_StormShipGUID` | GUID string | `EVT_04` | GUID of the cargo ship suffering shifted container lashings in heavy seas. |
| `REE_Timer_StormCompGUID` | GUID or `"engine"` | `EVT_04` | Component GUID of the damaged engine component set to 1 DP. |
| `REE_Timer_StormEndHour` | Integer string (`currentHour + 8`) | `EVT_04` | Scenario hour when cargo re-stowing completes, repairing propulsion and restoring speed. Set to `"-1"` when inactive. |
| `REE_Timer_EngineFixShipGUID` | GUID string | `EVT_05` | GUID of the escort or auxiliary suffering a mechanical propulsion/steering failure. |
| `REE_Timer_EngineFixHour` | Integer string (`currentHour + 4`) | `EVT_05` | Scenario hour when engineering parties restore propulsion. Set to `"-1"` when inactive. |
| `REE_Timer_MountRepairGUID` | GUID string | `EVT_27` | GUID of the ship suffering weapon mount / CIWS shock damage from sea skimming missile near-misses. |
| `REE_Timer_MountRepairMountGUID` | GUID string | `EVT_27` | Component GUID of the disabled weapon mount. |
| `REE_Timer_MountRepairHour` | Integer string (`currentHour + repairHours`) | `EVT_27` | Scenario hour when weapons technicians restore mount functionality. Set to `"-1"` when inactive. |

---

## 6. GCE: Global Strategic Modifiers

High-level operational metrics updated by the Ground Control Engine (`core-engine-loop.lua`) on every 6-hour execution cycle.

| Key | Type / Format | Default | Description & Usage |
| :--- | :--- | :--- | :--- |
| `GCE_GLOBAL_UK_MORALE` | Integer (0–120) | `100` | UK ground combat morale percentage. Affects combat power effectiveness across all zones. Adjusted by zone captures (+5%) and losses (-10%). |
| `GCE_GLOBAL_ARG_MORALE` | Integer (0–120) | `100` | Argentine garrison morale percentage. Reduced as UK forces liberate key strategic zones. |
| `GCE_GLOBAL_UK_SUPPLY` | Integer (0–100) | `100` | Overall UK logistical replenishment efficiency. Unsupplied zones degrade combat effectiveness over time. |
| `GCE_GLOBAL_UK_SA_BONUS` | Float multiplier (e.g. `1.0` – `1.25`) | `1.0` | Global Situational Awareness multiplier for UK troops. Set to `1.25` (+25% combat efficiency) when UK airborne AEW, MPA, or reconnaissance drones patrol inside `ZONE_FALKLANDS_ISR`. |
| `GCE_GLOBAL_ARG_SA_BONUS` | Float multiplier (e.g. `1.0`) | `1.0` | Situational Awareness multiplier for Argentine ground forces. |
| `GCE_LOSS_SCORE_UK` | Integer (0–250+) | `0` | Cumulative tactical attrition penalty points incurred by UK asset losses (updated by `uk-loss-tracker.lua`). If losses reach **250 points**, UK political fail-state is triggered. |

---

## 7. GCE: Per-Zone Tactical State Variables

For each of the **11 strategic zones**, the GCE maintains 10 dedicated Key-Value pairs prefixed by `ZCTRL_<ZONE_NAME>_`.

### Strategic Zone Identifiers

1. `ZONE_SAN_CARLOS`: Primary amphibious bridgehead (Ajax Bay / San Carlos Water).
2. `ZONE_BLUFF_COVE`: Southern amphibious landing corridor / Fitzroy settlement.
3. `ZONE_GOOSE_GREEN`: Darwin isthmus & airfield strongpoint.
4. `ZONE_MT_KENT`: Dominant artillery observation heights overlooking Stanley.
5. `ZONE_FALKLAND_SOUND`: Maritime transit channel dividing East and West Falkland.
6. `ZONE_PORT_HOWARD`: West Falkland Argentine garrison redoubt.
7. `ZONE_FOX_BAY`: Southern West Falkland port & garrison.
8. `ZONE_TEAL_INLET`: Northern East Falkland staging & logistics node.
9. `ZONE_PEBBLE_ISLAND`: Northern radar & forward airstrip installation.
10. `ZONE_STANLEY`: Capital city, deepwater port, & primary Argentine command node (**Mandatory Victory Zone**).
11. `ZONE_PLEASANT`: Mount Pleasant military airport & hardened runway complex (**Mandatory Victory Zone**).

### Zone Key-Value Definitions

| Key Template | Type / Format | Default | Description & Usage |
| :--- | :--- | :--- | :--- |
| `ZCTRL_<ZONE>_CTRL_PCT` | Integer (`0` – `100`) | `0` | **UK Control Percentage.** `0%` represents total Argentine control; `100%` represents complete UK liberation. Shifts dynamically based on relative ground combat power, CAS, and NGFS. |
| `ZCTRL_<ZONE>_UK_PWR` | Integer points | `0` | Active UK combat power points deployed into the zone (inserted via amphibious landing craft, helicopters, or consumption scripts). |
| `ZCTRL_<ZONE>_ARG_PWR` | Integer points | `100` (baseline) | Active Argentine garrison combat power points stationed in the zone. Augmented dynamically by the Argentine AI Director (`ai-director.lua`). |
| `ZCTRL_<ZONE>_SECURED` | `"TRUE"` \| `"FALSE"` | `"FALSE"` | Set to `"TRUE"` once UK control reaches **>= 85%**. Required for campaign victory check. |
| `ZCTRL_<ZONE>_SUPPLY_TIMER` | Integer turns | `0` | Counts consecutive cycles a zone has been isolated from supply corridors. At 3+ cycles, applies a -25% combat power penalty. |
| `ZCTRL_<ZONE>_SA_LOCAL` | Float multiplier | `1.0` | Local situational awareness modifier reflecting forward recon/scout presence. |
| `ZCTRL_<ZONE>_CAS_ACTIVE` | `"TRUE"` \| `"FALSE"` | `"FALSE"` | Indicates whether UK ground attack aircraft (F-35B, Typhoon) are airborne within the zone perimeter (+25% power bonus). |
| `ZCTRL_<ZONE>_NGFS_ACTIVE` | `"TRUE"` \| `"FALSE"` | `"FALSE"` | Indicates whether a UK frigate or destroyer (4.5" gun) is positioned within 12 NM of the zone (+20% power bonus). |
| `ZCTRL_<ZONE>_STATUS_TEXT` | Text string | `"ARG SECURED"` | Human-readable tactical status string displayed in SITREP modals (`"ARG SECURED"`, `"CONTESTED"`, `"UK ADVANCING"`, or `"UK SECURED"`). |
| `ZCTRL_<ZONE>_ACTIVE_MODS` | Text string | `""` | Pipe-delimited list of active environmental and support modifiers (e.g. `"CAS (+25%) \| NGFS (+20%) \| HIGH MORALE"`). |

---

## 8. Generic Tactical Proximity & Mission Triggers

Lightweight tracking variables used by standalone scripts in `Global/`.

| Key | Type / Format | Description & Usage |
| :--- | :--- | :--- |
| `Ticks_<GUID>` | Integer string | Incremental tick counter tracking how long an aircraft or vessel has dwelled within proximity of a target unit (`proximity-based-trigger.lua`). |
| `Approached_<GUID>` | `"Yes"` | Flag set when a unit has successfully closed within identification or rendezvous distance. |

---

## 9. DWE: Dynamic Weather Engine Tracking & State

Maintains persistent meteorological state, storm lifecycle, and temporary flight deck holds across scenario saves/loads.

| Key | Type / Format | Default | Description & Usage |
| :--- | :--- | :--- | :--- |
| `DWE_INITIALIZED` | `"true"` | `"true"` | Set by `weather-engine.lua` on first run. Signals that baseline weather states have been seeded. |
| `DWE_TICK_COUNT` | Integer string (e.g. `"4"`) | `"0"` | Incremented on each weather engine execution cycle (e.g. every 6 or 12 hours). |
| `DWE_Z_<ID>_TEMP` | Integer string (e.g. `"6"`) | Varies | Persistent ambient temperature in °C for zone `<ID>` or `"global"`. |
| `DWE_Z_<ID>_RAIN` | Integer string (e.g. `"15"`) | Varies | Persistent precipitation rate in mm/hr for zone `<ID>` or `"global"`. |
| `DWE_Z_<ID>_CLOUDS` | Float string (e.g. `"0.8"`) | Varies | Persistent cloud fraction (0.0 to 1.0) for zone `<ID>` or `"global"`. |
| `DWE_Z_<ID>_SEASTATE` | Integer string (0–9) | Varies | Persistent sea state (WMO / Beaufort scale) for zone `<ID>` or `"global"`. |
| `DWE_Z_<ID>_STORM_REMAINING`| Integer string (e.g. `"2"`) | `"0"` | Remaining execution ticks for an active storm front in zone `<ID>`. |
| `DWE_Z_<ID>_IN_STORM` | `"true"` \| `"false"` | `"false"` | Indicates whether zone `<ID>` is currently experiencing an active storm front. |
| `DWE_HELD_AC_<GUID>` | `"true"` \| `""` | `""` | Set to `"true"` on aircraft grounded strictly due to sea state (SS $\ge$ 6/8). When seas calm, DWE detects this flag and instantly restores `timetoready_minutes = 0`. |

---

## 10. Master Index & Cross-Reference Table

| Key Name | Subsystem | Value Format | Default Value | Mutated By |
| :--- | :--- | :--- | :--- | :--- |
| `FALKL_DEV_MODE` | Global | Boolean string | `"true"` | `gce-init-script.lua`, `ree-init-script.lua` |
| `REE_DEV_FORCE_EVENT_HOURLY` | REE | Boolean string | `"true"` (dev) | `ree-test-runner.lua`, `master-ticker.lua` |
| `REE_DEV_HOURLY_OFF` | REE | Boolean string | `"false"` | Manual debug toggle |
| `REE_DEV_FORCE_SEQUENTIAL` | REE | Boolean string | `"false"` | `ree-test-runner.lua`, `ree-init-script.lua` |
| `CTFS_COMPLETED` | CTFS | Boolean string | `"false"` | `core.lua` (on Task Force launch) |
| `CTFS_POINTS_SPENT` | CTFS | Integer string | `"0"` | `core.lua` |
| `CTFS_HOURS_DELAYED` | CTFS | Integer string | `"0"` | `core.lua` |
| `CTFS_DEPARTURE_DATE` | CTFS | Date string | `""` | `core.lua` |
| `CTFS_TOTAL_UNITS` | CTFS | Integer string | `"0"` | `core.lua` |
| `REE_INITIALIZED` | REE | Boolean string | `"true"` | `ree-init-script.lua` |
| `REE_CONFIG_MAX_DAYS` | REE | Integer string | `"30"` | `ree-init-script.lua` |
| `REE_SCENARIO_HOUR` | REE | Integer string | `"0"` | `master-ticker.lua` |
| `REE_LAST_PLANNED_DAY` | REE | Integer string | `"0"` | `master-ticker.lua`, `ree-init-script.lua` |
| `REE_SCHEDULED_HOURS` | REE | Comma-list | `""` | `master-ticker.lua`, `ree-init-script.lua` |
| `REE_EXECUTED_EVENTS` | REE | Comma-list | `""` | `master-ticker.lua` |
| `REE_EVENT_USED_<ID>` | REE | Boolean string | `"false"` | `master-ticker.lua` |
| `REE_LAST_TRIGGERED_EVENT` | REE | Text string | `""` | `master-ticker.lua` |
| `UK_CARRIER_ARRIVES_ASCENSION` | Scenario | Boolean string | `"false"` | CMO Area Trigger (Ascension Island) |
| `UK_CARRIER_ARRIVES_FALKLAND_APPROACHES` | Scenario | Boolean string | `"false"` | CMO Area Trigger (45°S Latitude) |
| `UK_UNITS_SPOTTED_GREATER_FALKLANDS_ZONE` | Scenario | Boolean string | `"false"` | CMO Detection Trigger (Outer Zone) |
| `UK_UNITS_SPOTTED_VICINITY_FALKLANDS` | Scenario | Boolean string | `"false"` | CMO Detection Trigger (Littoral Zone) |
| `REE_Timer_StormShipGUID` | REE | GUID string | `""` | `master-ticker.lua` (EVT_04) |
| `REE_Timer_StormCompGUID` | REE | GUID string | `""` | `master-ticker.lua` (EVT_04) |
| `REE_Timer_StormEndHour` | REE | Integer string | `"-1"` | `master-ticker.lua` (EVT_04) |
| `REE_Timer_EngineFixShipGUID` | REE | GUID string | `""` | `master-ticker.lua` (EVT_05) |
| `REE_Timer_EngineFixHour` | REE | Integer string | `"-1"` | `master-ticker.lua` (EVT_05) |
| `REE_Timer_MountRepairGUID` | REE | GUID string | `""` | `master-ticker.lua` (EVT_27) |
| `REE_Timer_MountRepairMountGUID` | REE | GUID string | `""` | `master-ticker.lua` (EVT_27) |
| `REE_Timer_MountRepairHour` | REE | Integer string | `"-1"` | `master-ticker.lua` (EVT_27) |
| `GCE_GLOBAL_UK_MORALE` | GCE | Integer string | `"100"` | `core-engine-loop.lua`, `gce-init-script.lua` |
| `GCE_GLOBAL_ARG_MORALE` | GCE | Integer string | `"100"` | `core-engine-loop.lua`, `gce-init-script.lua` |
| `GCE_GLOBAL_UK_SUPPLY` | GCE | Integer string | `"100"` | `core-engine-loop.lua`, `gce-init-script.lua` |
| `GCE_GLOBAL_UK_SA_BONUS` | GCE | Float string | `"1.0"` | `core-engine-loop.lua` |
| `GCE_GLOBAL_ARG_SA_BONUS` | GCE | Float string | `"1.0"` | `gce-init-script.lua` |
| `GCE_LOSS_SCORE_UK` | GCE | Integer string | `"0"` | `uk-loss-tracker.lua` |
| `ZCTRL_<ZONE>_CTRL_PCT` | GCE | Integer string | `"0"` | `core-engine-loop.lua`, `counter-offensive.lua` |
| `ZCTRL_<ZONE>_UK_PWR` | GCE | Integer string | `"0"` | `consumption.lua`, `gce-init-script.lua` |
| `ZCTRL_<ZONE>_ARG_PWR` | GCE | Integer string | `"100"` | `ai-director.lua`, `counter-offensive.lua` |
| `ZCTRL_<ZONE>_SECURED` | GCE | Boolean string | `"FALSE"` | `core-engine-loop.lua`, `counter-offensive.lua` |
| `ZCTRL_<ZONE>_SUPPLY_TIMER` | GCE | Integer string | `"0"` | `core-engine-loop.lua` |
| `ZCTRL_<ZONE>_SA_LOCAL` | GCE | Float string | `"1.0"` | `core-engine-loop.lua` |
| `ZCTRL_<ZONE>_CAS_ACTIVE` | GCE | Boolean string | `"FALSE"` | `core-engine-loop.lua` |
| `ZCTRL_<ZONE>_NGFS_ACTIVE` | GCE | Boolean string | `"FALSE"` | `core-engine-loop.lua` |
| `ZCTRL_<ZONE>_STATUS_TEXT` | GCE | Text string | `"ARG SECURED"` | `core-engine-loop.lua` |
| `ZCTRL_<ZONE>_ACTIVE_MODS` | GCE | Text string | `""` | `core-engine-loop.lua` |

---

## 10. Pre-Release Scenario Deactivation Script

Prior to packaging and publishing `Falklands 27.scen`, run the following snippet in the CMO Lua Console to deactivate developer test mode and reset hourly overrides for public gameplay:

```lua
-- ==============================================================================
-- FALKLANDS 2027: PRE-RELEASE KEY-VALUE STORE LOCKOUT
-- ==============================================================================
ScenEdit_SetKeyValue("FALKL_DEV_MODE", "false")
ScenEdit_SetKeyValue("REE_DEV_FORCE_EVENT_HOURLY", "false")
ScenEdit_SetKeyValue("REE_DEV_FORCE_SEQUENTIAL", "false")
ScenEdit_SetKeyValue("REE_DEV_HOURLY_OFF", "false")
print(">>> Developer mode deactivated. Realistic pacing & validation active.")
```
