# Command: Modern Operations (CMO) Engine & Lua Scripting Reference Manual
**Authoritative Internal Mechanics, Database Structures, Mount/VLS Architecture, and Reverse-Engineered Findings**

---

## 1. Executive Overview & System Architecture

This reference document compiles the reverse-engineered architectural mechanics, database relationships, and runtime execution behaviors of **Command: Modern Operations (CMO)** (Build v1.06+ / DB3000 v519+).

### Core Components & Tech Stack
- **Executable**: 64-bit .NET Windows application (`Command.exe`, `CommandHost.exe`).
- **Lua Engine**: Lua 5.4 embedded via **NLua** and **KeraLua** interfacing through native C runtime `lua54.dll`.
- **Database**: SQLite 3 relational database located at `DB\DB3K_519.db3` (and `DB\CWDB_*.db3`).
- **Obfuscation / JIT Mechanics**: Binary utilizes runtime method encryption (.NET Reactor). Methods in static reflection display empty IL stubs (`00 00 16 2A`: `nop, nop, ldc.i4.0, ret`) which are dynamically decrypted and JIT-compiled in memory by native bootstrap loaders at runtime.
- **Primary Core Namespaces**:
  - `Command_Core`: Primary simulation kernel (`ActiveUnit`, `Mount`, `WeaponRec`, `Scenario`, `Weapon`, `Damage`, `Magazine`).
  - `Command_Core.Lua`: Lua sandboxing, dispatchers, and wrappers (`LuaSandBox`, `PrivateMethods`, `LuaWrapper_ActiveUnit`, `LuaWrapper_Device_Mount`, `LuaWrapper_Device_Weapon`, `LuaWrapper_Device_Magazine`).
  - `Command`: WinForms/WPF UI and ViewModel presenters.

---

## 2. DB3000 Database Architecture & Relational Schema

The CMO weapon/mount/ship data model is defined in `DB3K_519.db3`. The relationship between ships, mounts, weapon records, and weapons follows a strict 5-tier relational model:

```
[ DataShip ] 
     │
     ▼ (via DataShipMounts: ID=ShipID, ComponentID=MountID)
[ DataMount ] (Name, Capacity, MagazineCapacity)
     │
     ▼ (via DataMountWeapons: ID=MountID, ComponentID=WeaponRecordID)
[ DataWeaponRecord ] (DefaultLoad, MaxLoad, Multiple, ROF)
     │
     ▼ (via ComponentID=WeaponID)
[ DataWeapon ] (Name, Type, Guidance, Range, Warhead)
```

### Table Definitions & Primary Columns

#### 1. `DataShipMounts`
Maps a ship hull to its installed physical mounts:
- `ID`: Target ship DBID (`DataShip.ID`).
- `ComponentID`: Installed mount DBID (`DataMount.ID`).

#### 2. `DataMount`
Defines the physical launcher hardware on the vessel:
- `ID`: Mount DBID.
- `Name`: Full mount descriptor string (e.g., `"GWS.35 Sea Ceptor VLS [6 Cells]"`, `"GWS.45 Sea Viper VLS [48 Cells]"`).
- `Capacity`: **Physical cell/silo count** (e.g., 6, 8, 12, 24, 48).
- `MagazineCapacity`: Internal storage capacity (0 for standard deck VLS).

#### 3. `DataMountWeapons`
Maps a mount to its allowable weapon records:
- `ID`: Mount DBID (`DataMount.ID`).
- `ComponentID`: Weapon record ID (`DataWeaponRecord.ID`).

#### 4. `DataWeaponRecord`
**The most critical table for munitions capacity and packing**:
- `ID`: Weapon record ID.
- `ComponentID`: Weapon DBID (`DataWeapon.ID`).
- `DefaultLoad`: Default number of missiles spawned into the mount.
- `MaxLoad`: Maximum number of missiles the mount can hold for this weapon record.
- `Multiple`: **The packing factor per cell** (e.g., 1 for single-pack, 4 for quadpack).
- `ROF`: Rate of fire (burst cycle / cooldown).

---

## 3. The "Multiple" Packing Factor & VLS Silo Mechanics

### The Golden Formula of CMO Mounts
$$\text{MaxLoad} = \text{DataMount.Capacity (Cells)} \times \text{DataWeaponRecord.Multiple}$$

| Ship Class | Mount Name | Mount ID | Cells (`Capacity`) | Weapon | Weapon DBID | `Multiple` | Max Missiles (`MaxLoad`) |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Type 45 Batch 2** | `GWS.45 Sea Viper VLS [48 Cells]` | 3461 | **48** | Aster 30 PAAMS | 133 | **1** | **48** |
| **Type 45 Batch 2** | `GWS.35 Sea Ceptor VLS [6 Cells]` | 3462 | **6** | CAMM | 2783 | **4** | **24** |
| **Type 23 Duke** | `GWS.35 Sea Ceptor VLS [8 Cells]` | 2360 | **8** | CAMM | 2783 | **4** | **32** |
| **Type 26 City** | `GWS.35 Sea Ceptor VLS [12 Cells]` | 2480 | **12** | CAMM | 2783 | **4** | **48** |
| **Type 26 City** | `Mk41 VLS [24 Cells]` | 2717 | **24** | Tomahawk Blk IV | 586 | **1** | **24** |
| **Type 31 Inspiration** | `GWS.35 Sea Ceptor VLS [12 Cells]` | 2480 (x2) | **12 (ea)** | CAMM | 2783 | **4** | **48 (ea)** |
| **Arleigh Burke IIA** | `Mk41 VLS [32 Cells]` | 71 | **32** | RIM-162A ESSM | 15 | **4** | **128** (or 32/32 SM-2) |

### In-Memory .NET Representation (`Command_Core`)
- **`Command_Core.Mount`**:
  - `ObservableList<WeaponRec> MountWeapons`: Collection of active weapon records.
  - `Int32 CurrentCapacity`: Total current load across mounts.
- **`Command_Core.WeaponRec`**:
  - `Int32 DefaultLoad`: Default capacity.
  - `Int32 MaxLoad`: Maximum missile load.
  - `Int32 Multiple`: Silo pack multiplier (1 = single, 4 = quadpack).
  - `Int32 CurrentLoad`: **Actual missile count** currently loaded in the silo. While in-game firing decrements `CurrentLoad` by 1 missile per launch, scenario editing reload functions operate strictly on **cells**!

---

## 4. CMO Lua Runtime Architecture & Mount Descriptors

When querying a unit via `unit = ScenEdit_GetUnit({ guid = unitGuid })`, CMO constructs a table hierarchy backed by `LuaWrapper_ActiveUnit`:

```lua
unit = {
    guid = "...",
    name = "HMS Dragon",
    side = "UK",
    mounts = {
        [1] = {
            mount_guid = "GNRIJH-0HM7B6IC7IPUR",
            mount_name = "GWS.35 Sea Ceptor VLS [6 Cells]",
            mount_dbid = 3462,
            mount_capacity = 6,     -- Physical cell count (or mount.capacity)
            mount_weapons = {
                [1] = {
                    wpn_guid = "...",
                    wpn_dbid = 2783,
                    wpn_name = "CAMM",
                    wpn_current = 24, -- Current loaded missiles
                    wpn_maxcap = 24,  -- Max missile capacity
                    wpn_default = 24, -- Default spawn load
                    wpn_type = 2001
                }
            }
        }
    }
}
```

> [!NOTE]
> In some versions of CMO, `mount.mount_capacity` may be omitted from the Lua table representation. However, **every VLS mount in DB3000 contains `[X Cells]` or `[X-Cell]` in its name**, making regex extraction `mName:match("(%d+)%s*cells?")` 100% reliable.

---

## 5. The "0/24 Quadpack Trap" in `ScenEdit_AddReloadsToUnit`

### The Bug Mechanism
`ScenEdit_AddReloadsToUnit` is the official Lua function used to modify weapons loaded into mounts:
```lua
ScenEdit_AddReloadsToUnit({
    side = unit.side,
    guid = unit.guid,
    unitname = unit.name,
    mount_guid = mount.mount_guid,
    wpn_dbid = weaponDbid,
    number = N,
    remove = true  -- If true, deducts weapons; if false, adds weapons
})
```

### The Engine Trap
On a VLS mount, **the `number` parameter represents the NUMBER OF CELLS / SILOS, NOT the raw count of individual missiles!**

1. **Why Sea Viper (Sylver A50) Worked**:
   - `Multiple = 1` (1 Aster missile per cell).
   - Capacity = 48 cells, 48 missiles.
   - Reducing to 25% called `number = 36, remove = true`.
   - CMO deducted 36 cells. $48 - 36 = 12$ cells remained ($12/48$ missiles). **Success**.

2. **Why Sea Ceptor (GWS.35) Emptied to 0/24**:
   - `Multiple = 4` (4 CAMM missiles per cell).
   - Capacity = 6 cells, 24 missiles.
   - Intended reduction to 25% computed: $24 \times 0.25 = 6$ missiles target $\rightarrow$ remove 18 missiles.
   - The script passed `number = 18, remove = true`.
   - **CMO interpreted `number = 18` as "remove 18 cells"**.
   - Because the launcher only has 6 physical cells, $18 \ge 6$. CMO removed all 6 cells, completely zeroing out the mount to **0/24**!
   - On Type 23 ($8 \text{ cells} \times 4 = 32 \text{ CAMMs}$), passing `number = 24` removed 24 cells, wiping the launcher to **0/32**!

---

## 6. The Standardized Cell-Aware VLS Reduction Algorithm

To safely reduce any VLS mount to a target fraction (e.g., 25% peacetime readiness) without zeroing quadpacked canisters:

```lua
function ConfigureShipVLS(unit, hasVlsUpgrade)
    if not unit or hasVlsUpgrade then return end
    if unit.guid then
        local refreshed = ScenEdit_GetUnit({ guid = unit.guid })
        if refreshed then unit = refreshed end
    end
    if not unit.mounts then return end

    local vlsKeywords = { "vls", "sylver", "cell", "silo", "gws", "ceptor", "vertical", "mk 41", "mk41", "aster", "camm" }

    for _, mount in pairs(unit.mounts) do
        local mName = (mount.mount_name or mount.name or ""):lower()
        local isVls = false
        for _, kw in ipairs(vlsKeywords) do
            if string.find(mName, kw, 1, true) then
                isVls = true
                break
            end
        end

        local weapons = mount.mount_weapons or mount.weapons
        if isVls and weapons then
            -- 1. Determine physical cell count of the launcher
            local cellCount = tonumber(mount.mount_capacity) or tonumber(mount.capacity)
            if not cellCount or cellCount <= 0 then
                local numStr = mName:match("(%d+)%s*cells?") or mName:match("%[(%d+)%s*cells?%]")
                if numStr then cellCount = tonumber(numStr) end
            end

            for _, w in pairs(weapons) do
                local wpnDbid = tonumber(w.wpn_dbid)
                local maxCap = tonumber(w.wpn_maxcap) or tonumber(w.wpn_capacity) or tonumber(w.wpn_current) or 0
                local current = tonumber(w.wpn_current) or maxCap

                if wpnDbid and maxCap > 0 then
                    -- 2. Determine packing ratio (e.g. 4 for quadpack, 1 for single-pack)
                    local multiple = 1
                    if cellCount and cellCount > 0 and maxCap >= cellCount then
                        multiple = math.floor(maxCap / cellCount)
                        if multiple < 1 then multiple = 1 end
                    else
                        multiple = 1
                        if not cellCount or cellCount <= 0 then cellCount = maxCap end
                    end

                    -- 3. Calculate current cells and target cells
                    local currentCells = math.ceil(current / multiple)
                    local targetCells = math.max(1, math.floor(cellCount * 0.25 + 0.5))
                    local cellsToRemove = currentCells - targetCells

                    -- 4. Clamp to prevent over-removal
                    if cellsToRemove > currentCells then cellsToRemove = currentCells end

                    -- 5. Execute removal in physical cell units
                    if cellsToRemove > 0 then
                        local mountGuid = mount.mount_guid or mount.guid
                        pcall(function()
                            ScenEdit_AddReloadsToUnit({
                                side = unit.side,
                                guid = unit.guid,
                                unitname = unit.name,
                                mount_guid = mountGuid,
                                wpn_dbid = wpnDbid,
                                number = cellsToRemove,
                                remove = true
                            })
                        end)
                    end
                end
            end
        end
    end
end
```

### Mathematical Results for British Warships
- **Type 45 Sea Viper (48 cells)**: $48 \times 0.25 = 12$ cells retained ($12/48$ Asters) $\rightarrow$ remove 36 cells.
- **Type 45 Sea Ceptor (6 cells)**: $\lfloor 6 \times 0.25 + 0.5 \rfloor = 2$ cells retained ($8/24$ CAMMs, 33%) $\rightarrow$ remove 4 cells.
- **Type 23 Sea Ceptor (8 cells)**: $8 \times 0.25 = 2$ cells retained ($8/32$ CAMMs, exactly 25%) $\rightarrow$ remove 6 cells.
- **Type 26 Sea Ceptor (12 cells)**: $12 \times 0.25 = 3$ cells retained ($12/48$ CAMMs, exactly 25%) $\rightarrow$ remove 9 cells.
- **Type 26 Mk41 (24 cells)**: $24 \times 0.25 = 6$ cells retained ($6/24$ Tomahawks, exactly 25%) $\rightarrow$ remove 18 cells.
- **Type 31 Sea Ceptor (2x 12-cell mounts)**: 3 cells retained per mount ($12/48$ CAMMs each, $24/96$ total, exactly 25%) $\rightarrow$ remove 9 cells per mount.

---

## 7. The Two Recognized VLS Management Paradigms

### Paradigm A: Direct Cell Deduction (Used in CTFS)
Compute the delta in cells: `cellsToRemove = currentCells - targetCells`. Call `ScenEdit_AddReloadsToUnit({ ..., number = cellsToRemove, remove = true })`.
- **Pros**: Preserves partial loads without completely flushing the mount. Fast and atomic.
- **Cons**: Requires accurate calculation of cell counts and multiples.

### Paradigm B: Flush and Re-Add (Luzon Pattern)
Used extensively in official community campaigns such as *Defend Luzon*:
```lua
-- Step 1: Flush all existing missiles from the mount
for _, w in ipairs(mount.mount_weapons) do
    ScenEdit_AddReloadsToUnit({
        side = unit.side,
        guid = unit.guid,
        mount_guid = mount.mount_guid,
        wpn_dbid = w.wpn_dbid,
        number = w.wpn_current, -- Passing missile count >= cell count guarantees flush to 0
        remove = true
    })
end

-- Step 2: Add exact target number of cells
ScenEdit_AddReloadsToUnit({
    side = unit.side,
    guid = unit.guid,
    mount_guid = mount.mount_guid,
    wpn_dbid = 15, -- ESSM (Multiple = 4)
    number = 8     -- Adds 8 cells = 32 missiles
})
ScenEdit_AddReloadsToUnit({
    side = unit.side,
    guid = unit.guid,
    mount_guid = mount.mount_guid,
    wpn_dbid = 1194, -- SM-2MR (Multiple = 1)
    number = 24      -- Adds 24 cells = 24 missiles
})
```
- **Pros**: Completely eliminates residual state or partial canister issues.
- **Cons**: Requires explicit knowledge of every desired weapon DBID and cell allocation for mixed mounts.

---

## 8. Carrier Magazines vs Ship Mounts

CMO treats ship mounts and ship magazines as completely separate subsystems:

| Feature | Ship Mounts (`unit.mounts`) | Ship Magazines (`unit.magazines`) |
| :--- | :--- | :--- |
| **Physical Role** | Ready-to-fire launchers (VLS, turrets, CIWS) | Internal deep storage / ammo lockers / flight deck armories |
| **Access Property** | `unit.mounts[i].mount_weapons` | `unit.magazines[i].mag_weapons` |
| **Add Function** | `ScenEdit_AddReloadsToUnit` | `ScenEdit_AddWeaponToUnitMagazine` |
| **Deduct Function** | `ScenEdit_AddReloadsToUnit` (`remove = true`) | `ScenEdit_AddWeaponToUnitMagazine` (`remove = true`) |
| **Flush All** | Iterate mounts with `remove = true` | `ScenEdit_ClearAllMagazines({ guid = unit.guid })` |
| **Unit of Measure** | **Cells/Silos** (for VLS) or bursts/rounds | **Individual weapon count** |

### Carrier Magazine Manipulation Example
```lua
-- Flushing carrier magazine completely
ScenEdit_ClearAllMagazines({ guid = carrier.guid })

-- Adding specific quantities of air munitions to carrier
ScenEdit_AddWeaponToUnitMagazine({
    side = carrier.side,
    guid = carrier.guid,
    mag_guid = carrier.magazines[1].mag_guid,
    wpn_dbid = 3144, -- Meteor BVRAAM
    number = 48,     -- Exactly 48 missiles added
    max_cap = 100
})
```

---

## 9. Embarked Aviation Hosting & Group Pre-Numbering

### Host Naming Precedence
When adding aircraft to carrier or ship decks via `ScenEdit_AddUnit`:
- If `base = "HMS Queen Elizabeth"` or `base = unitGuid`, aircraft are placed directly into the ship's hangar / flight deck.
- If `base` is an airfield (e.g. `"RAF Brize Norton"`), aircraft spawn in that base's hangars.

### Uniform Aviation Naming Rule
To prevent naming collisions (such as `#1` repeating when additional units are purchased):
```lua
-- Calculate total count per aircraft type across both baseline and purchased assets
local groupTotals = {}
for _, entry in ipairs(allAirToSpawn) do
    local key = entry.hostName .. "::" .. entry.shortName .. "::" .. (entry.squadron or "")
    groupTotals[key] = (groupTotals[key] or 0) + entry.qty
end

-- Generate uniform names:
-- Single instance: "RFA Lyme Bay Chinook H-47"
-- Multiple instances: "617 Sqn F-35B Lightning II #1", "617 Sqn F-35B Lightning II #2", etc.
```

---


---

## 11. In-Game Communications, Special Messages & UI Mechanics

CMO provides two distinct mechanisms for delivering messages to players during scenario execution, with substantially different rendering capabilities and execution behaviors:

### 11.1 `ScenEdit_SpecialMessage(side, textOrHtml)`
- **Window Title**: Automatically titled **`"Incoming message"`** by the CMO engine.
- **Visual Presentation**: Native non-blocking message teletype / log entry.
- **Audio Cue**: Plays the scenario incoming transmission alert tone.
- **Message Log Routing vs Pop-Up Window**: `ScenEdit_SpecialMessage` sends messages to the side's message stream. In CMO, whether a `SpecialMessage` pops up into a floating window or is merely written to the scrolling **Message Log** panel depends on the player's in-game settings (`Game Options -> Message Log -> Special Messages -> [Raw / In Window / None]`). If not configured to pop up, it **only prints to the message log**.
- **HTML Doctype Requirement**: CMO's internal string inspector (`CheckForExternalHTML`) requires a complete, well-formed HTML5 document:
  ```html
  <!DOCTYPE html>
  <html lang="en">
  <head><meta charset="UTF-8"><title>Incoming message</title></head>
  <body>...</body>
  </html>
  ```
  Passing a raw `<div>` fragment without `<!DOCTYPE html>` or `<html>` causes CMO to treat the content as unformatted text, printing raw HTML tags into the message log.
- **The `[LOADDOC]` Tag Pattern**: CMO natively supports referencing HTML attachment documents packed in the scenario attachment folder via `[LOADDOC]` tags:
  ```lua
  ScenEdit_SpecialMessage(PlayerSide, '[LOADDOC]Briefing_Notes.html[/LOADDOC]')
  ```
  (See `iran strike 2030.lua` line 14141).
- **Side Targeting & Fallbacks**: The `side` parameter must match the exact side name configured in the scenario (e.g., `"UK"`, `"NATO"`, or `"PlayerSide"`). If targeted to a non-existent side, it will raise a runtime Lua error. Always detect via `ScenEdit_PlayerSide()` with fallback wrappers:
```lua
local playerSide = ScenEdit_PlayerSide()
if not playerSide or playerSide == "" then playerSide = "UK" end
pcall(function() ScenEdit_SpecialMessage(playerSide, htmlContent) end)
```

### 11.2 `UI_CallAdvancedHTMLDialog(title, html, button_array)` (Guaranteed Modal Popup)
- **Visual Presentation**: **Guaranteed modal popup window** rendered via Microsoft Edge WebView2 control in the center of the screen.
- **Scenario Impact**: Fully pauses the scenario simulation clock while open.
- **Window Sizing & Geometry Mechanics**:
  - **Form Implementation**: Implemented by `Command.AdvancedDialog` (a standard Windows Forms dialog).
  - **Resizable (`FormBorderStyle: Sizable`)**: The window is fully resizable by the player. The player can click-and-drag any border or corner to resize the dialog, or click the native Windows Maximize button on the title bar.
  - **Default Size**: Initial default client geometry is `569 x 405` pixels.
  - **Lua API Parameters**: Accepts only 3 parameters: `Title` (string), `Html` (string), and `Interactions` (Lua table of button strings). There are **no width or height parameters** in the Lua API signature.
  - **HTML/CSS Responsive Layout**: Because the window is resizable, the HTML container should use fluid, responsive CSS (e.g., `width: 100%; max-width: 960px; box-sizing: border-box;`). This allows the content to fit cleanly into the default ~550px viewport while seamlessly stretching across wide screens when the player enlarges or maximizes the window.
- **Button Array**: Expects a Lua table of string button labels, e.g. `{ "Acknowledge Orders" }` or `{ "Done" }` or `{ "Launch", "Cancel" }`.
- **Return Value**: Returns a Lua table containing `return_table["pressed"]` (the button clicked) and keys for any input fields.
- **Best Use Case**: Briefings, operational orders (OPORDs), setup dialogs, and critical decision events where a dialog **must unconditionally rise into view** regardless of the user's Message Log display options (see `iran strike 2030.lua` lines 13663 and 15956, and `AI-html-lua-reference.txt` lines 11-38).


### 11.3 `ScenEdit_MsgBox(text, style)`
- **Visual Presentation**: Standard Win32/WPF modal alert dialog box with an `OK` button.
- **Scenario Impact**: Blocks scenario progression until clicked.
- **HTML Support**: **None**. Renders plain unformatted text only. Passing HTML tags displays raw strings (`<div>...</div>`).
- **Best Use Case**: Safe emergency fallback for error messages or when both WebView2 engines fail.

### 11.4 Dialog Spawning & Geometry (`UI_CallAdvancedHTMLDialog` vs `ScenEdit_SpecialMessage`)
- **Guaranteed Modal Spawning Requirement**:
  - `UI_CallAdvancedHTMLDialog` is the **only** Lua function that unconditionally forces a dialog window to spawn into the player's view regardless of their CMO game options.
  - `ScenEdit_SpecialMessage` sends a message to the player side, but CMO defaults to writing it directly to the scrolling **Message Log panel** on the main map. It only opens a pop-up window if the player has manually enabled pop-ups under `Game Options -> Message Log`. Therefore, dispatches and orders requiring guaranteed visual presentation must call `UI_CallAdvancedHTMLDialog`.
- **Window Geometry & Sizing**:
  - `Command.AdvancedDialog` has a hardcoded default initial client size of **`569 x 405` pixels** in `Command.exe`. The Lua API `UI_CallAdvancedHTMLDialog(Title, Html, Interactions)` accepts no width or height arguments.
  - The dialog has `FormBorderStyle: Sizable` and includes a native Windows **Maximize button `[ ]`** on the title bar. Players can click `[ ]` to immediately expand the dialog to full screen, or drag any border to enlarge it.
  - HTML documents passed to `UI_CallAdvancedHTMLDialog` should use responsive CSS (`width: 100%; max-width: 960px; margin: 0 auto; box-sizing: border-box;`) so the content is cleanly structured in the default viewport and expands across the full display when maximized.
- **Dual-Delivery Best Practice**:
  - Call `UI_CallAdvancedHTMLDialog` to guarantee the modal dialog pops up on screen for the player.
  - Concurrently call `ScenEdit_SpecialMessage` to permanently archive the operational order in the in-game Message Log with the radio alert sound.

### 11.5 Embedded WebView2 UI State Management & IPC
When building rich custom HTML/JS dialogs embedded into CMO (via WebView2 or browser controls):
1. **Button State Transitions & View Replacement**: Any execution button (such as a launch button) should immediately disable itself and either transition visually (e.g., red to green, updated action text) or transition the entire DOM into the post-action operational report.
2. **IPC Messaging (`DIALOG_OK`)**: Post the bridge message (`window.chrome.webview.postMessage("DIALOG_OK" + ...)`) concurrently or immediately after DOM mutations to ensure the user sees confirmation even if the bridge closes or unloads the view.

### 11.6 Headless Testing & NLua Engine in PowerShell
When running automated unit tests for CMO Lua scripts on Windows outside the game client:
- **Assembly Loading Order**: Always load `KeraLua.dll` before `NLua.dll` into the AppDomain:
  ```powershell
  [System.Reflection.Assembly]::LoadFrom("$cmoPath\KeraLua.dll") | Out-Null
  [System.Reflection.Assembly]::LoadFrom("$cmoPath\NLua.dll") | Out-Null
  ```
- **Instantiation**: Instantiate NLua via reflection to avoid parameter resolution mismatches:
  ```powershell
  $lua = [Activator]::CreateInstance([NLua.Lua], @($true))
  ```

---

## 12. Summary Cheat Sheet for CMO Scenario Developers

1. **Always check `Multiple` on VLS weapons**: Quadpack weapons (CAMM, ESSM) have `Multiple = 4`. `MaxLoad = Cells * Multiple`.
2. **`ScenEdit_AddReloadsToUnit` removes/adds CELLS, not missiles**: Always divide desired missile count by `Multiple` before specifying `number`.
3. **Never pass raw missile counts to `remove = true` on a quadpack mount**: You will empty the entire launcher to `0/N`.
4. **Mount names are authoritative**: In DB3000, cell count is always in the mount name (e.g., `[6 Cells]`, `[48 Cells]`).
5. **Always provide both `guid` and `unitname`**: Maximizes compatibility across different CMO version patches.
6. **Magazines use individual weapon units**: `ScenEdit_AddWeaponToUnitMagazine` operates on raw weapon quantities, unlike VLS mounts.
7. **For guaranteed popup dialogs, use `UI_CallAdvancedHTMLDialog`**: `ScenEdit_SpecialMessage` defaults to the message log stream unless user options force popups.
8. **Always include full `<!DOCTYPE html><html lang="en">` wrappers**: CMO will not parse raw `<div>` snippets as HTML.


