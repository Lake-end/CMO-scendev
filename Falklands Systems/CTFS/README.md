# Carrier Task Force Selector (CTFS) — Falklands 2027

An interactive, HTML-driven Task Force assembly and dynamic setup engine for **Command: Modern Operations (CMO)**.

The CTFS replaces pre-fixed scenario Order of Battle (OOB) setups with a strategic risk-versus-reward deployment menu. Players build custom Task Forces using an embedded HTML UI frontend, exchanging time (departure delays) for enhanced surface combatants, expanded carrier airwings, logistics capacity, and full missile/magazine fills. In turn, the backend engine converts spent points into scenario delay time and scales Argentine defensive preparations and proficiency across a four-tiered escalation matrix.

---

## 1. Directory & File Structure

All CTFS files are organized within your scenario project structure as follows:

```text
Falklands Systems/
└── CTFS/
    ├── ctfs_ui.html                  -- Player-facing HTML UI frontend & interactive dashboard
    ├── core.lua                      -- Master backend logic, time control & dynamic unit spawner
    └── GUIDs.md                      -- Reference manifest for UK mainland airbase GUIDs
```

> **Design Principle:** The CTFS uses CMO's native WebView interface. The HTML frontend compiles user selections into a JSON payload transmitted to the Lua backend via `window.chrome.webview.postMessage`. The engine parses this string in `CTFS_ProcessUIResponse`, advancing scenario time, executing Argentine escalation boons, and spawning forces via explicit GUIDs and Reference Points—ensuring zero post-run manual setup.

---

## 2. Strategic Mechanics & Operational Flow

```text
┌─────────────────────────┐
│ Interactive HTML Menu   │  (Player opens CTFS UI in-game via Special Action)
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ Task Force Customization│  (Selects escorts, subs, RAF aircraft, airwing & magazine fills)
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ JSON Payload Handshake  │  (Frontend passes structured choices & point tally to CMO Lua)
└────────────┬────────────┘
             │
             ▼
┌─────────────────────────┐
│ Time Jump Calculation   │  (Core engine converts points to hours: 1 Pt = 5 Hours delay)
└────────────┬────────────┘
             │
             ├──────────────────────────┐
             ▼                          ▼
┌─────────────────────────┐  ┌─────────────────────────┐
│ Argentine Escalation    │  │ UK Fleet & RAF Spawns   │
│ Matrix (Boons Applied)  │  │ (Assigned to RPs/GUIDs) │
└────────────┬────────────┘  └─────────────────────────┘
             │
             ▼
┌─────────────────────────┐
│ Scenario Launch         │  (Clock advanced via ScenEdit_SetTime, forces ready)
└─────────────────────────┘
```

### Key Operational Rules

* **Currency & Time Conversion:** The player spends **Points** to buy additional assets.  
  $\text{Delay Time} = \text{Points Spent} \times 5 \text{ Hours}$
* **The 100-Point Budget Limit:** The maximum operational budget is **100 Points** (500 Hours / ~21 Days). Exceeding this threshold is prohibited by the UI, as excessive delay renders the liberation attempt politically and militarily untenable.
* **Baseline Forces (0 Points):**  
  * **Carrier Strike Group:** HMS *Queen Elizabeth* (with 12x F-35B, 2x Wildcat HMA.2, 2x Merlin HM.2, 2x Merlin ASaC.5 Crowsnest, 2x Merlin HC.4, 2x Peregrine UAVs), HMS *St Albans* (Type 23), and HMS *Daring* (Type 45).
  * **Support & Auxiliary:** RFA *Lyme Bay*, RFA *Tideforce*, and HMS *Medway* (Falklands patrol).
  * **Baseline RAF (Mainland UK):** 2x Poseidon MRA.1 (Lossiemouth), 4x Voyager KC.3, 4x Globemaster III, 10x Atlas C.1 (Brize Norton), and 1x Protector RG.1 (Marham).
* **Mainland RAF Routing:** Purchased RAF aircraft additions (e.g., additional Poseidons, Voyagers, or Transports) bypass sea spawn reference points and automatically deploy directly to their native UK mainland base GUIDs.
* **Magazine & VLS Refills:** Ships sail at peacetime capacity (25% filled) by default. Players can purchase nested +25% capacity upgrades in the UI. The Lua engine iterates through the unit's `magazines` table and injects exact missile/ammunition quantities via `ScenEdit_AddWeaponToUnitMagazine`.

---

## 3. Map & Reference Point Setup Requirements

The CTFS dynamically generates or references specific map elements for task force grouping and deployment:

### Dynamic Staging Reference Points (UK Side)
* `FLEET_SPAWN1`: Primary Carrier Strike Group (CSG) spawn location.
* `FLEET_SPAWN2`: Advance Escort Task Group spawn location.
* `FLEET_SPAWN3`: Support & Amphibious Task Group spawn location.
* `FLEET_SPAWN4`: Forward Submarine & ASW Screen spawn location.
* `FLEET_SPAWN5`: STUFT / Merchant Logistic Convoy spawn location.
* `BASE_ASCENSION`: Staging location for forward-deployed aircraft.

### UK Mainland Airbase GUID Identifiers
The engine routes air assets directly to physical installations using exact GUID references:

| Airbase Name | GUID Identifier | Standard Stationed Aircraft |
| :--- | :--- | :--- |
| **RAF Lossiemouth** | `W8V2DT-0HNODCG173JA6` | P-8 Poseidon MRA.1 |
| **RAF Coningsby** | `W8V2DT-0HNODCG173JB4` | (Mainland Air Defense) |
| **RAF Marham** | `W8V2DT-0HNODCG173JC2` | Protector RG.1 UAV |
| **RAF Brize Norton** | `W8V2DT-0HNODCG173J98` | Voyager KC.3, C-17 Globemaster, A400M Atlas |

---

## 4. CMO Event Engine Integration & Execution Options

The CTFS supports both standard CMO WebView IPC architectures:

### Option A: Bridge 1 — Synchronous Modal Dialog (`CTFS.OpenDialog()`) [RECOMMENDED]
Pauses the simulation clock completely while the player configures forces. Optimal for scenario start (pre-game setup).
* **Trigger:** Time Trigger at `00:00:01` (Scenario Start).
* **Action (Lua Script):**
```lua
local candidates = {
    "Development\\Global\\Falklands Systems\\CTFS\\core.lua",
    "Global\\Falklands Systems\\CTFS\\core.lua",
    "Falklands Systems\\CTFS\\core.lua",
    "CTFS\\core.lua"
}
local loaded = false
for _, path in ipairs(candidates) do
    if ScenEdit_RunScript(path) then
        loaded = true
        break
    end
end
-- Fallback for distributed scenarios using CMO Scenario Attachments
if not loaded and ScenEdit_UseAttachment then
    loaded = pcall(ScenEdit_UseAttachment, "CTFS_core.lua") or pcall(ScenEdit_UseAttachment, "core.lua")
end

if CTFS and CTFS.OpenDialog then
    CTFS.OpenDialog()
else
    ScenEdit_MsgBox("CTFS Error: Could not load core.lua via ScenEdit_RunScript or Scenario Attachment.", 1)
end
```
* **Mechanism:** CMO invokes `UI_CallAdvancedHTMLDialog`, freezes the game clock, scrapes `<input type="hidden" name="ctfs_payload">` when the player clicks "Launch Task Force", sanitizes inputs, verifies the math server-side, advances the clock, triggers Argentine boons, and spawns all assets.

### Option B: Bridge 2 — Asynchronous Dashboard (`CTFS.OpenUI()`)
Runs as a non-modal message window without pausing the game clock. Optimal if invoked mid-game or as a Special Action.
* **Special Action Registration:**
```lua
ScenEdit_SetSpecialAction({
    ActionName = "CTFS_OpenSelector",
    text = "CTFS: Assemble Task Force",
    ScriptText = [[
        if ScenEdit_RunScript("Development\\Global\\Falklands Systems\\CTFS\\core.lua") or (ScenEdit_UseAttachment and pcall(ScenEdit_UseAttachment, "core.lua")) then
            if CTFS and CTFS.OpenUI then CTFS.OpenUI() end
        end
    ]],
    isRepeatable = false,
    isContainer = false
})
```
* **Mechanism:** CMO renders via `ScenEdit_SpecialMessage`. The in-page "LAUNCH TASK FORCE" button fires `window.chrome.webview.postMessage("DIALOG_OKCTFS_ProcessUIResponse('...')")`, invoking the global Lua callback `CTFS_ProcessUIResponse`.

### Scenario Key-Value Store Variables
Upon launch, CTFS writes persistent telemetry to CMO's global Key-Value store (`ScenEdit_SetKeyValue`):
* `CTFS_COMPLETED`: `"true"`
* `CTFS_POINTS_SPENT`: Total validated points spent (e.g. `"35"`)
* `CTFS_HOURS_DELAYED`: Total hours delayed (e.g. `"175"`)
* `CTFS_DEPARTURE_DATE`: Formatted Zulu departure timestamp
* `CTFS_TOTAL_UNITS`: Total count of spawned unit records
Other scenario scripts (e.g. Ground Control Engine / GCE) can query these values using `ScenEdit_GetKeyValue("CTFS_POINTS_SPENT")`.


---

## 5. Database ID & Escalation Matrix Configuration

### Database ID Manifest (`core.lua`)
Verify that the database IDs in `core.lua` match your active DB3000 version before scenario deployment:

```lua
-- UK Primary DB IDs
local DB_QE             = 1008  -- HMS Queen Elizabeth
local DB_TYPE45_BASE    = 3200  -- Type 45 Destroyer (Base)
local DB_TYPE45_SEACEPT = 3438  -- Type 45 Destroyer (Sea Ceptor Upgrade)
local DB_TYPE23         = 3199  -- Type 23 ASW Frigate
local DB_TYPE26         = 2795  -- Type 26 Frigate
local DB_ASTUTE         = 725   -- Astute-Class SSN
local DB_F35B           = 1095  -- F-35B Lightning (Loadout #25647)

-- Argentine DB IDs
local DB_ARG_SPYDER_SR  = 3010  -- SPYDER-SR Battery
local DB_ARG_SPYDER_MR  = 4037  -- SPYDER-MR Battery
local DB_ARG_EXOCET     = 4532  -- Coastal SSM Battery (MM.40)
local DB_ARG_SUB209     = 671   -- Chang Bogo Type 209-1200
local DB_ARG_F16AM      = 7227  -- F-16AM Falcon MLU (A2A: #33847 / A2G: #33848)
local DB_ARG_MINE_MDM5  = 3406  -- MDM-5 Naval Mine
```

### Argentine Defensive Escalation Matrix
As the player spends points to delay departure, `CTFS.ApplyArgentineBoons` automatically triggers defensive additions:

| Delay Points | Hour Delay | Argentine Escalation Boon | Location / Effect |
| :---: | :---: | :--- | :--- |
| **10 pts** | +50 hrs | SPYDER-SR SAM Battery | Formed at Stanley Canopus |
| **20 pts** | +100 hrs | 2x F-16AM Fighter Patrols (A2A) | Stationed at Mount Pleasant Airport |
| **30 pts** | +150 hrs | Coastal Exocet SSM Battery | Deployed at Fanning Head |
| **40 pts** | +200 hrs | 15x MDM-5 Naval Minefield | Mapped across San Carlos approaches (2.0 NM radius) |
| **50 pts** | +250 hrs | Side Proficiency Increase | Argentina side upgraded to **Veteran** |
| **60 pts** | +300 hrs | SPYDER-MR SAM Battery | Formed at Stanley Tumbledown |
| **70 pts** | +350 hrs | ARA *Salta* (Type 209 Submarine) | Deployed on forward patrol grid |
| **75 pts** | +375 hrs | ARA *San Luis* (Type 209 Submarine) | Deployed on secondary patrol grid |
| **80 pts** | +400 hrs | 4x Mainland F-16AM Strike Aircraft (A2G) | Inbound strike vector from mainland |
| **95 pts** | +475 hrs | RBS 70 NG MANPADS Unit | Stationed at Stanley Port |
| **99 pts** | +495 hrs | Maximum Side Proficiency | Argentina side upgraded to **Ace** |

---

## 6. Hard Fail-State & Limit Verification

* **Hard Budget Enforcement:** `ctfs_ui.html` strictly caps selection totals at **100 Points**. Attempting to add an asset that pushes the total beyond 100 points triggers an immediate alert and resets the input control.
* **Epoch Clock Safety:** Time jumps convert elapsed hours into Unix epoch seconds (`hours * 3600`) and format them into explicit string tables (`Date = "DD.MM.YYYY"`, `Time = "HH:MM:SS"`) required by `ScenEdit_SetTime`, preventing scenario date corruptions across month/year boundaries.