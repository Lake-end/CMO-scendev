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

### 11.7 WebView2 Media Integration: Images, Video, and Chromium Sandbox Limitations

When rendering custom HTML interfaces with images or videos via `UI_CallAdvancedHTMLDialog`:

1. **`NavigateToString` Security Boundary (`file:///` Sandboxing)**:
   - `Command.AdvancedDialog` renders HTML by passing raw strings to WebView2 via `CoreWebView2.NavigateToString(html)`.
   - Chromium assigns an opaque / `data:` origin to `NavigateToString`.
   - **Chromium strictly prohibits loading local file subresources (`file:///...`) from opaque/data origins** (`Not allowed to load local resource`).
   - Consequently, referencing `<img src="file:///...">` or `<video src="file:///...">` will silently fail or show broken media icons.

2. **The 2 MB Maximum String Limit on `NavigateToString`**:
   - WebView2's COM/WinRT interface enforces a strict hard ceiling of **2 MB (2,097,152 characters)** on the string argument passed to `NavigateToString`.
   - Passing an HTML payload larger than 2 MB throws:
     `System.ArgumentException: Value does not fall within the expected range`
     and causes the dialog window to crash or fail to open.

3. **Image Inlining Best Practice (Web-Optimization & Base64 Data URIs)**:
   - Full-resolution raw images (e.g., 2800x1500 camera frames at 2.5MB - 5MB) cannot be inlined as Base64 because they exceed the 2MB `NavigateToString` limit.
   - **Solution**: Downscale images to max 720px width with 80% JPEG quality (~60 KB - 80 KB).
   - Inlined as Base64 (`data:image/jpeg;base64,...`), the payload is ~80 KB - 110 KB. This is:
     - 100% offline (no internet connection required).
     - Immune to Chromium `file:///` sandbox restrictions.
     - Well below the 2MB WebView2 payload ceiling.
     - Fast and responsive inside the modal dialog.

4. **Video Handling: HTML Modal vs CMO Native Player**:
   - **Local Video in HTML Modal**: **Impossible**. Local MP4 files (typically 5MB - 50MB+) cannot be inlined via Base64 (violates 2MB limit) and cannot be loaded via `file:///` (blocked by Chromium sandbox).
   - **Online Video in HTML Modal (Recommended)**: Edge WebView2 supports HTTPS embeds.
     - **YouTube**: Use `<iframe src="https://www.youtube.com/embed/{VIDEO_ID}" allowfullscreen></iframe>`. Provides adaptive bitrates, responsive scaling, and zero Google Drive quota lockouts.
     - **Google Drive**: Use `<iframe src="https://drive.google.com/file/d/{FILE_ID}/preview" allow="autoplay"></iframe>`.
   - **Offline Local Video (CMO Native Engine)**: CMO has a dedicated native video overlay player:
     ```lua
     ScenEdit_PlayVideo("Attachments/EVT12.mp4", false, 0)
     -- or via Scenario Attachments:
     ScenEdit_UseAttachment("EVT12.mp4")
     ```
     This launches CMO's DirectShow/Windows Media Player overlay directly in-game, functioning 100% offline with local `.mp4` files.


## 13. Random Event Engine (REE) Mechanics & Long-Scenario Dynamic Event Architecture

Managing dynamic random events across long scenarios (e.g., 30 days / 720 hours) in CMO requires careful state isolation, time tracking, and event gating.

### 13.1 Non-Repeating State Management in CMO KVS
CMO does not provide persistent custom globals across engine restarts or save/load boundaries outside of the Key-Value Store (KVS).
To ensure an event never fires more than once:
1. Assign every event a unique immutable string ID (e.g. `EVT_01`, `EVT_02`).
2. Upon execution, record both an individual flag and an audit string:
   ```lua
   ScenEdit_SetKeyValue("REE_EVENT_USED_" .. selected.id, "true")
   local usedList = ScenEdit_GetKeyValue("REE_EXECUTED_EVENTS") or ""
   ScenEdit_SetKeyValue("REE_EXECUTED_EVENTS", usedList == "" and selected.id or (usedList .. "," .. selected.id))
   ```
3. Candidate queries must check `ScenEdit_GetKeyValue("REE_EVENT_USED_" .. evt.id) == "true"` before qualifying any event.

### 13.2 Progressive Milestone Tier Unlocking
Rather than static time-based event schedules, expeditionary campaigns require gating event pools behind operational milestones:
```lua
local function IsMilestoneActive(keyName)
    local val = ScenEdit_GetKeyValue(keyName)
    if val == "true" or val == "True" or val == "1" then return true end
    return false
end
```
When key milestone triggers occur (e.g., fleet arriving at Ascension Island or entering the Falkland Approaches), scenario events set their corresponding KVS flag to `"true"`. The REE master ticker automatically evaluates active tiers on every tick and expands the candidate pool dynamically.

### 13.3 Communications Manipulation (`outofcomms`)
CMO provides an `outofcomms` property to simulate units losing connection with side tactical networks:
- **Set out of comms**: `ScenEdit_SetUnit({ guid = unitGuid, outofcomms = true })`
- **Restore comms**: `ScenEdit_SetUnit({ guid = unitGuid, outofcomms = false })`
- **Visual & Tactical Impact**: The unit remains physically in the world, but drops off the player's networked tactical picture. Friendly sensors aboard the unit stop sharing contacts with the side until comms are restored.
- **Rendezvous Detection**: Ongoing tickers can check proximity via `Tool_Range(unitGuid, escortGuid) <= 0.25` NM to automatically restore comms when visual or UHF contact is established.

### 13.4 Timed Mechanical Failures & Repair Handlers
Component casualties and speed restrictions can be scheduled with future completion hours stored in KVS:
```lua
-- Apply component damage and schedule repair completion
ScenEdit_SetUnitDamage({ guid = shipGuid, components = { {'rudder', 'Medium'} } })
ScenEdit_SetKeyValue("REE_Timer_EngineFixHour", tostring(currentHour + 4))

-- Ticker checks each hour:
local fixHour = tonumber(ScenEdit_GetKeyValue("REE_Timer_EngineFixHour")) or -1
if fixHour > 0 and currentHour >= fixHour then
    ScenEdit_SetUnitDamage({ guid = shipGuid, components = { {'rudder', 'none'} } })
    ScenEdit_SetKeyValue("REE_Timer_EngineFixHour", "-1")
end
```

### 13.5 Organic Daily Two-Slot Scheduling
To distribute 0–2 events per day without predictable trigger intervals:
1. Divide each 24-hour day into two 12-hour slots (00:00–12:00 and 12:00–24:00).
2. At the beginning of each day, roll an independent 50% probability for each slot.
3. If a slot triggers, select a randomized hour offset within that slot's range:
   - Slot 1: `baseHour + math.random(1, 12)`
   - Slot 2: `baseHour + math.random(13, 24)`
4. This yields an average of 1.0 event/day (25% chance of 0, 50% chance of 1, 25% chance of 2) while keeping the exact trigger hour organic and unpredictable.

---

## 14. Reference Points API & Retrieval Mechanics

### Failure Mode: `ScenEdit_GetReferencePoints({ side = "..." })`
Calling `ScenEdit_GetReferencePoints({ side = "SideName" })` without specifying `area`, `name`, or `guid` triggers a fatal Lua engine error:
```text
Function:ScenEdit_GetReferencePoints (0) Error:Need to define a Side and Name to modify an RP. Or a Side and Guid. Or a set of RPs
```
**Cause:** In the CMO core C# engine, `ScenEdit_GetReferencePoints` shares parameter validation with RP modification logic. The engine strictly requires at least one selector beyond side:
1. `name` (string)
2. `guid` (string)
3. `area` (array of RP names or GUIDs, e.g. `area = { "RP-1", "RP-2" }`)

It **cannot** be used to retrieve all reference points for a side.

### The Correct Method: `VP_GetSide({ side = "..." }).rps`
To retrieve all reference points belonging to a side, use the `rps` property on the `CMO__Side` wrapper returned by `VP_GetSide()`:
```lua
local sideObj = VP_GetSide({ side = "UK" })
if sideObj and sideObj.rps then
    for _, rp in ipairs(sideObj.rps) do
        -- rp is a CMO__ReferencePoint wrapper:
        -- rp.name, rp.guid, rp.latitude, rp.longitude, rp.highlighted
        print(string.format("RP: %s (GUID: %s) at Lat: %f, Lon: %f", rp.name, rp.guid, rp.latitude, rp.longitude))
    end
end
```

### Reference Point Modification & Area Queries
- **Get Single RP:** `ScenEdit_GetReferencePoint({ side = "UK", name = "RP_NAME" })` or `{ guid = "..." }`
- **Set/Update RP:** `ScenEdit_SetReferencePoint({ side = "UK", guid = rp.guid, newname = "NEW_NAME", highlighted = true })`
- **Units in Polygon Area:** `sideObj:unitsInArea({ Area = { "RP_1", "RP_2", "RP_3" } })`

---

## 15. Dynamic Relative Task Events & Avoiding Duplicate Popups

### 15.1 Relative Reference Points Around Moving Vessels
To create a task zone (e.g., for comms restoration, boarding, or SAR) that moves synchronously with a vessel across the ocean:
```lua
local rpNames = { "RP_1", "RP_2", "RP_3", "RP_4" }
local bearings = { 45, 135, 225, 315 }
for i = 1, 4 do
    ScenEdit_AddReferencePoint({
        side = "UK",
        name = rpNames[i],
        relativeTo = targetUnitGuid,
        bearing = bearings[i],
        distance = 0.5, -- NM
        bearingType = 0, -- 0 = Fixed to true North, 1 = Rotating with heading
        highlighted = false
    })
end
```
*Setting `bearingType = 0` locks the relative coordinates to true North, creating a stable square bounding box around the moving ship.*

### 15.2 On-the-Fly Event Creation (`UnitEntersArea`)
When an objective expects player intervention, generating a dynamic CMO Event provides instant, real-time resolution the second a player's asset enters the zone:
```lua
ScenEdit_SetTrigger({
    mode = "add",
    name = trigName,
    description = trigName,
    type = "UnitEntersArea",
    TargetFilter = { TargetSide = "UK" },
    Area = rpNames,
    ExitArea = false
})

ScenEdit_SetAction({
    mode = "add",
    name = actName,
    description = actName,
    type = "LuaScript",
    ScriptText = actionLuaCode
})

ScenEdit_SetEvent(evtName, {
    mode = "add",
    description = evtName,
    isRepeatable = false,
    isActive = true,
    isShown = false
})
ScenEdit_SetEventTrigger(evtName, { mode = "add", name = trigName, description = trigName })
ScenEdit_SetEventAction(evtName, { mode = "add", name = actName, description = actName })
```

### 15.3 Dynamic Cleanup Inside the Triggered Action
The action script must clean up the reference points and deregister the temporary event/trigger/action:
```lua
for _, rpName in ipairs(rpList) do
    pcall(function() ScenEdit_DeleteReferencePoint({ side = "UK", name = rpName }) end)
end
pcall(function() ScenEdit_SetEvent(evtName, { mode = "remove" }) end)
pcall(function() ScenEdit_SetTrigger({ mode = "remove", name = trigName, description = trigName }) end)
pcall(function() ScenEdit_SetAction({ mode = "remove", name = actName, description = actName }) end)
```

### 15.4 Avoiding Duplicate Popup Windows
If a script calls both `UI_CallAdvancedHTMLDialog` and `ScenEdit_SpecialMessage`, CMO displays **two** windows: the rich HTML dialog and an unformatted raw message box. Dropping `ScenEdit_SpecialMessage` when using `UI_CallAdvancedHTMLDialog` leaves only the single styled HTML modal.

---

## 16. Summary Cheat Sheet for CMO Scenario Developers

1. **Always check `Multiple` on VLS weapons**: Quadpack weapons (CAMM, ESSM) have `Multiple = 4`. `MaxLoad = Cells * Multiple`.
2. **`ScenEdit_AddReloadsToUnit` removes/adds CELLS, not missiles**: Always divide desired missile count by `Multiple` before specifying `number`.
3. **Never pass raw missile counts to `remove = true` on a quadpack mount**: You will empty the entire launcher to `0/N`.
4. **Mount names are authoritative**: In DB3000, cell count is always in the mount name (e.g., `[6 Cells]`, `[48 Cells]`).
5. **Always provide both `guid` and `unitname`**: Maximizes compatibility across different CMO version patches.
6. **Magazines use individual weapon units**: `ScenEdit_AddWeaponToUnitMagazine` operates on raw weapon quantities, unlike VLS mounts.
7. **For guaranteed popup dialogs, use `UI_CallAdvancedHTMLDialog`**: `ScenEdit_SpecialMessage` defaults to the message log stream unless user options force popups.
8. **Always include full `<!DOCTYPE html><html lang="en">` wrappers**: CMO will not parse raw `<div>` snippets as HTML.
9. **Use `outofcomms = true/false` for communication outages**: Safely drops units from tactical network without deleting or corrupting unit records.
10. **Store non-repeating event IDs in KVS**: Zero-reoccurrence logic across multi-day campaigns should be tracked through `REE_EVENT_USED_<id>`.
11. **Always version script headers**: Every scenario script created or modified must include a version tag in its header comment (`-- SCRIPT <N>: <NAME> v1 --`), incrementing (`v1 -> v2 -> v3`) on every edit.
12. **Retrieve all side RPs via `VP_GetSide({side="Side"}).rps`**: Never call `ScenEdit_GetReferencePoints({ side = "..." })` without an `area` table; access `sideObj.rps` instead.
14. **Bind relative task zones with `bearingType = 0`**: Dynamic task boxes created relative to moving ships should use `bearingType = 0` to maintain true-North box alignment as the unit changes heading.
15. **Never use `rawget`, `rawset`, or `rawequal`**: CMO's NLua sandbox strips these from `_G`. Directly access globals (`if VAR == nil then ... end`).
16. **Scenario files (`.scen`) embed script code inline**: CMO scenario events execute `<ScriptText>` stored inside the scenario file. Updating files on disk does not update active scenario events until re-imported or repasted into CMO's Event Action editor.

---

## 17. CMO Lua Sandbox Quirks & Runtime Constraints

### 17.1 Stripped Metatable Functions (`rawget`, `rawset`, `rawequal`)
In the CMO sandboxed runtime (`Command_Core.Lua.LuaSandBox`), several standard Lua base functions are removed for security and isolation:
- `rawget` is **`nil`**
- `rawset` is **`nil`**
- `rawequal` is **`nil`**

Attempting to invoke `rawget(_G, "FOO")` throws a runtime exception:
```
Exception: [string "CachedChunk"]:41: attempt to call a nil value (global 'rawget')
Stack Trace:    at NLua.Lua.ThrowExceptionFromError(Int32 oldTop)
   at Command_Core.LuaUtility.DoString_Optimized(Lua lua, String chunk, String chunkName)
   at Command_Core.Lua.LuaSandBox.RunScript(String str, Boolean RunInteractively, String script, String fullPath)
```

**Safe Global Variable Access Pattern**:
```lua
-- WRONG (Crashes engine with nil value error):
if not rawget(_G, "MY_GLOBAL") then ... end

-- CORRECT (Safe across all CMO builds and standard Lua):
if MY_GLOBAL == nil then ... end
-- OR:
if _G["MY_GLOBAL"] == nil then ... end
```

### 17.2 Scenario Architecture: Inline `<ScriptText>` Execution
CMO scenarios (`.scen`) store all event actions inline inside their compressed XML structure:
```xml
<EventAction_LuaScript>
    <ID>W8V2DT-0HNOOC3A0PKDB</ID>
    <Description>REE master-ticker.lua</Description>
    <ScriptText>-- Entire script content is embedded here --</ScriptText>
</EventAction_LuaScript>
```
**Key Implication for Development**:
Editing a file under `Development\Global\Falklands Systems\` updates the source code on disk, but does **not** automatically update a scenario currently loaded or saved in CMO unless:
1. The script is repasted into **Editor -> Event Manager -> Actions -> Edit Script**, OR
2. The scenario event action is designed as a small runner calling `ScenEdit_RunScript("Development\\...\\script.lua")`.
If old event actions remain in the scenario, errors like `ScenEdit_GetReferencePoints({ side = "..." })` will continue to trigger even after being resolved in repository files.

### 17.3 Non-Existent API: `ScenEdit_Print`
In CMO's Lua environment, there is no function named `ScenEdit_Print`. Calling `ScenEdit_Print(...)` throws:
```
Lua script execution error: [string "CachedChunk"]: attempt to call a nil value (global 'ScenEdit_Print')
```
Always use standard Lua `print(...)` to log text to the scenario log and Lua console.

---

## 18. Global Developer Mode Architecture (`FALKL_DEV_MODE`)

### 18.1 Master Architecture & KVS Specification
To facilitate rapid scenario balance testing without impacting player immersion on release, all scenario subsystems are bound to a unified Key-Value flag:
* **Key:** `FALKL_DEV_MODE`
* **Default During Development:** `"true"`
* **Release Setting:** `"false"`

**Standard Detection Pattern**:
```lua
local function IsDevMode()
    local val = ScenEdit_GetKeyValue("FALKL_DEV_MODE")
    if val == "false" or val == "0" or val == "FALSE" then
        return false
    end
    return true -- Defaults to active if uninitialized
end
```

### 18.2 Subsystem Behaviors in Developer Mode

| Subsystem | Dev Mode Behavior (`FALKL_DEV_MODE = true`) | Production Release Behavior (`FALKL_DEV_MODE = false`) |
|---|---|---|
| **CTFS (Carrier Task Force Selector)** | Un-redacts points budget, displays exact hour delays, shows full threat matrix. Emits `[CTFS DEBUG]` initialization logs. | Redacts points budget and threat details; maintains classified immersion. |
| **GCE (Ground Control Engine)** | Dumps full tactical telemetry table every hour tick: all 11 zones with base power, modifiers (ISR, CAS, NGFS, Morale, Tether), effective power deltas, shift %, and victory thresholds. | Silent background loop. Only triggers game popups on strategic victory or base flips. |
| **GCE Consumption** | Prints unit-by-unit infiltration log (`[+] INFILTRATED: <Unit> -> +<N> PWR`) and map deletions. | Silent background processing. |
| **GCE AI Director** | Logs mainland reinforcement air-bridge drops to Western zones and defensive power diversions from Stanley. | Silent background processing. |
| **UK Loss Tracker** | Logs unit destruction category, penalty points assessed, and percentage toward withdrawal threshold. | Silent unless political casualty threshold is breached. |
| **REE (Random Event Engine)** | Exposes detailed candidate pool analysis, unlocks hourly testing modes (`REE_DEV_FORCE_EVENT_HOURLY`), and provides sequential event verification. | Two-slot randomized scheduling with zero debug log clutter. |

### 18.3 REE Developer Testing Flags & Test Suite
Scenario designers can manipulate REE behavior directly in the CMO Lua Console:
* **Force Event Every Hour:** `ScenEdit_SetKeyValue("REE_DEV_FORCE_EVENT_HOURLY", "true")`
* **Cycle All Events Sequentially (EVT_01 -> EVT_29):** `ScenEdit_SetKeyValue("REE_DEV_FORCE_SEQUENTIAL", "true")`
* **Clear Event Lockout History:** `ScenEdit_SetKeyValue("REE_EXECUTED_EVENTS", "")`
* **Interactive Test Runner:** Run `ree-test-runner.lua` to dump telemetry and trigger specific events on demand.

### 18.4 How to Toggle for Release
Prior to publishing or distributing the scenario:
```lua
ScenEdit_SetKeyValue("FALKL_DEV_MODE", "false")
ScenEdit_SetKeyValue("REE_DEV_FORCE_EVENT_HOURLY", "false")
ScenEdit_SetKeyValue("REE_DEV_FORCE_SEQUENTIAL", "false")
```
All debug console prints and un-redacted developer UI panels instantly deactivate.
