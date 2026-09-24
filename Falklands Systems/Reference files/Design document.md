# MASTER SCENARIO DESIGN DOCUMENT
## Project: Falklands 2027 / 2028 (Hypothetical Conflict)

**Engine:** Command: Modern Operations (CMO)
**Architecture:** Lua Key-Value (KV) Store, Zero-External-Dependency "One-Shot" Scripts
**Measurement Standard:** Nautical Miles (NM) exclusively

---

## 1. OVERVIEW & CORE CONCEPT
The scenario simulates a hypothetical late-2020s Argentine attempt to reclaim the Falkland Islands. Unlike standard CMO scenarios that require intense micromanagement of ground troops, this project utilizes a custom **Ground Control Engine (GCE)** to abstract the land war. The player assumes the role of the UK Task Force Commander. Their primary responsibilities are controlling the sea, establishing air superiority, protecting the vulnerable amphibious supply chain, and providing fire support (CAS/NGFS) to enable the abstracted ground forces to secure the islands. 

The strategic backdrop features accelerated global rearmament, meaning late-2020s assets (e.g., E-7 Wedgetail, advanced F-35 block capabilities, updated Argentine stand-off munitions) are fully operational and deployed.

---

## 2. COMPLETED SYSTEM: THE GROUND CONTROL ENGINE (GCE)
The GCE is a fully automated, background Lua engine handling the operational ground war. It is feature-complete and housed within the `Falklands Systems\GCE` and `Falklands Systems\Generic` folders.

### 2.1 Zone Architecture
The map is divided into 11 strategic ground zones and 1 global ISR zone. Each zone is defined by a polygon of Reference Points (RPs) and features a central dynamic UI label.
*   **Primary Zones:** San Carlos, Bluff Cove, Goose Green, Mt Kent, Falkland Sound, Port Howard, Fox Bay, Teal Inlet, Pebble Island, Stanley, Pleasant.
*   **Global ISR Zone:** `ZONE_FALKLANDS_ISR` (100 NM ring around the islands). This on side:GCE_logic

### 2.2 Operational Mechanics
*   **Combat Power (CP) & Infiltration:** UK ground units dropped into a zone are permanently deleted from the physical map and converted into numerical CP points within the KV store to preserve engine performance.
*   **The Math Loop (Tug-of-War):** Runs every hour in-game. It compares UK Effective CP vs. Argentine CP to shift the control percentage (0-100%).
*   **The Supply Tether (20% Breakout Rule):** To push past a beachhead phase (under 50% control), UK troops require a supply tether. An Amphibious or Auxiliary ship inside the coastal zone grants a 24-hour grace period. If the timer expires, UK troops suffer a 90% CP penalty.
*   **Combat Multipliers:**
    *   **CAS:** +25% CP (Fighters, Attack aircraft, or Utility helos in the zone).
    *   **NGFS:** +15% CP (Surface Combatants in the zone).
    *   **ISR:** +25% Global CP (Wedgetail, Poseidon, or UAVs operating within the 100 NM ISR Zone).

### 2.3 Dynamic Events & States
*   **Base Handover (85% Threshold):** When UK control reaches 85%, the zone is flagged as `SECURED`. All surviving enemy facilities (and their nested embarked aircraft/boats) dynamically flip to the UK side.
*   **ARG AI Counter-Offensive:** Checks daily with a 25% chance to trigger. Targets a zone where UK control is >50%. Instantly injects +150 ARG CP, drops UK control by 10%, resets secured status, and physically spawns MANPADS, Exocet batteries, and incoming Strike Aircraft to threaten the player.
*   **UK Political Fail State:** Expeditionary warfare is politically fragile. A background script tracks physical UK asset losses. If the penalty score reaches 250 points (e.g., losing a Carrier [150] and an Amphibious ship [100]), the UK government orders a withdrawal, resulting in immediate scenario defeat.
*   **Strategic Victory:** Achieved when Stanley, Mount Pleasant, and at least 6 other minor zones are secured simultaneously.

---

# BEFORE IMPLEMNTATION
## 3. PENDING DEVELOPMENT: UK TASK FORCE SELECTOR 
To complete the scenario, the physical Order of Battle must be established. The UK forces can be split into several distinct groups. These groups will be formed by players choice in the beginning of he scenario, player can trade time for more resources in a kind of buy-dialog.

### 3.1 General principles of TF Selector
* **Currency** player spends is "time" ie. moving the "I am ready to sail" forward
* **Gain** for spending time is extra capabilities: additional ships (warships, RFA, contracted mechants, more VLS cells loaded since peactime loadsouts are not combat ready, more munitions for the aircraft in carriers magazines etc etc)
* **Downside** for taking more time, ie. spending the currency: Argentinian has more forces on the island every day, they become more entrenched and the get more bonuses relating to the GCE (control of the island fight), they get more of their aircraft, ships, subs, SAMs, SSM batteries, artillery etc in place. Also Argentinian-side "Proficiency" goes up every few days or week liberation is delayd. At somepoint the TF Selecor informs player the mission becomes untenable due to enemy getting too strong to dislodge.

### 3.2 What player can select to "buy"
*   **More escort ships (carrier and two bay-class are always in):** Type 23´s, Type 45´s and HMS Glasgow, submarines.
*   **Support Ships:** RFA Tide-class or Wave-class fleet tankers (chartered) and RFA Fort Victoria.
*   **STUFT Merchant Ships:** These ships will carry helicopers, armys stores, vehices, artillery and other heavy equipment etc.
*   **Helicopter detachments:**  The player can choose to embark extra support helicopters (Wildcats for ASW/Utility and Chinooks for heavy lift) for the campaign. Also Army Apaches for fire support.
*   **Aircraft:** Carrier Airwing starts with 12 F-35B´s but second squadron can be activated given some time. Also additional short range and long range UAVs, additional Tanker aircraft.
*   **Munitions:** Carrier magazines have more weapons for the F-35s, warships will have more missiles loaded in their magazines (normally ships dont sail with full silos during peace time)
*   **Other/Misc:** Stuff that I didn't think of yet.

### 3.3 The interface
*   Use HTML frontend that is both informative, usable and visually appealing with militarizes flair. CMO scenarios like "Defend Luzon" have great example of such UI design.
*   It will show a picture of the scenario, the current date, the current time, it should show a dynamic timeline where you can see the effect of your "spending" like sailing date, when the first troops are expected to land, when the first air mission can take off etc. Also it should display the predicted effects of the spending choices.
*   There should be a buy menu of some sort that has pictures of the things player can buy and mention its role, name, for ships cruising speed.
*   ALso possibly useful is to show buffs and debufs for both sides and their effect on the battlefield based on the timeline of the missions (the longer player spends in port gathering forces the more stronger enemy is waiting: better bonuses, better morale, more and stronger troops etc.)
*   When player finally accepts the task force and supporting forces compisition and cliks "Proceed" or something like that game will spawn his forces, adjust the game date and time to match with the spent currency (time in port) and also setup the hostile forces, bonuses, zones etc.
*   If viable, player could use the interface to create several fleets eg. Main TF with Carrier and escorts, multiple transport TFs some with escort maybe based on speed or purpose, forward TF with a submarine or two and some fast ships that sail ahead. Interface should allow creation of several task forces and when spawning the units group and name them accordingly. 

# AFTER IMPLEMNTATION
## 3. COMPLETED SYSTEM: CARRIER TASK FORCE SELECTOR (CTFS)
The CTFS is a custom UI and logic engine that establishes the physical UK Order of Battle. Players use an interactive HTML frontend to design their task force composition, exchanging scenario time for increased military capability[cite: 8].

### 3.1 General Principles & Core Mechanics
*   **Currency & Conversion:** The player spends "points" to purchase assets. 1 Point = 5 Hours of delay in sailing[cite: 8].
*   **The Hard Limit:** The player has a maximum budget of 100 points (approx. 21 days). Exceeding this threshold renders the liberation mission politically and militarily untenable. 
*   **The Escalation Downside:** The time spent assembling the UK fleet directly benefits the Argentine defenders. An automated Escalation Matrix tracks the delay and grants Argentina progressive boons, including fortified IADS, deployed diesel-electric submarines (Type 209-1200), F-16AM air wings, MDM-5 minefields, and side proficiency upgrades[cite: 8].

### 3.2 Task Force Composition & Assets
The player can construct multiple distinct surface groups (e.g., Carrier Strike Group, Amphibious Task Group, Forward ASW screen) which spawn dynamically at pre-designated Reference Points (`FLEET_SPAWN1-5`) upon execution[cite: 8].
*   **Default Assets (0 pts):** HMS Queen Elizabeth, HMS St Albans, HMS Daring, RFA Lyme Bay, RFA Tideforce, and base RAF assets[cite: 8].
*   **Escorts & Subs:** Upgrades include Type 23s, Type 45s (varying Sea Viper capabilities), Type 26 (HMS Glasgow), and Astute-class submarines[cite: 8].
*   **Airwing & RAF:** Activates the second F-35B squadron, E-7A Wedgetail, and additional rotorcraft[cite: 8].
*   **Logistics & Munitions:** Fills peacetime VLS silos and carrier magazines to wartime capacity. Integrates charted STUFT merchant ships and Wave-class fleet tankers[cite: 8].

### 3.3 The UI / UX Experience
*   **Interactive Frontend:** A custom HTML dialog with a militarized aesthetic, categorized by tabs (Airwing & RAF, Escorts & Subs, Support)[cite: 8].
*   **Dynamic Timeline:** A visual timeline tracks the scenario start date (Dec 26, 2027) against the delayed departure date. An indicator shifts from blue to yellow to red as the 100-point failure threshold approaches, giving the player real-time threat feedback[cite: 8].
*   **Execution:** Scenario time remains static while in the UI. Upon clicking "Launch," the Lua backend calculates the total hour delay, advances the CMO epoch clock via `ScenEdit_SetTime`, applies all Argentine boons, and seamlessly spawns the purchased UK forces[cite: 8].


## 4. PENDING DEVELOPMENT: ARGENTINE FORCES & AI
The Argentine AI requires robust, event-driven behaviors outside of the GCE to provide a credible multi-domain threat.

### 4.1 Argentine Air Force (FAA) & Naval Aviation
*   **Mainland Bases:** Rio Gallegos, Rio Grande, Comodoro Rivadavia.
*   **Assets:** F-16s (if simulating recent acquisitions), modernized A-4AR Fightinghawks, Super Etendards (or equivalents with modern anti-ship missiles).
*   **AI Logic Required:** 
    *   Continuous randomized Combat Air Patrols (CAP) over West Falkland.
    *   Trigger-based Anti-Surface Warfare (ASuW) strikes launching when the UK CSG is detected.
    *   Dynamic Lua scripts to rotate mainland squadrons to prevent the AI from exhausting its airframes in the first 24 hours.

### 4.2 Integrated Air Defense System (IADS)
*   **Deployment:** Heavy SAM coverage around Stanley and Pleasant. Pop-up MANPADS and SHORAD in the valleys.
*   **AI Logic Required:** Radar-discipline scripts (blinking emissions to avoid SEAD/HARM strikes until UK aircraft are within the lethal engagement zone).

### 4.3 Naval & Submarine Threat
*   **Surface Fleet:** MEKO 360 destroyers and corvettes attempting hit-and-run Exocet attacks.
*   **Submarines:** Type 209 (or updated SSK variants) lurking in the Falkland Sound and San Carlos approaches. 
*   **AI Logic Required:** Prosecution areas restricting submarines to shallow-water choke points where UK ASW is degraded.

---

## 5. PENDING DEVELOPMENT: LOGISTICS & THEATER PROGRESSION
The scenario must support sustained operations over several days or weeks.

*   **Reinforcement Pipeline:** Scripts to spawn incoming RAF logistics flights (C-17s) from Ascension Island once Mount Pleasant is captured (as established in the GCE).
*   **Tanker Tracks:** Establishing automated A330 MRTT orbits to allow UK carrier aircraft to remain on station longer.
*   **Ammunition Constraints:** The CSG will have finite magazines. Sea-replenishment logic or strict magazine management will force the player to use expensive effectors (e.g., Aster 30s, Spear 3) judiciously.

---

## 6. PENDING DEVELOPMENT: NARRATIVE & ENVIRONMENT
*   **Briefings:** Comprehensive HTML briefings for the UK player detailing the political stakes (Loss Score threshold), the mechanics of the GCE, and RoE (Rules of Engagement).
*   **Environment:** Set in late Autumn (simulating the brutal South Atlantic weather). High sea states, heavy cloud cover, and frequent squalls to complicate ISR and CAS operations.
*   **Scoring & Evaluation:** Beyond the hard fail state, standard CMO scoring will be awarded for destroying Argentine high-value targets (Command bunkers, SSKs, strike aircraft) to evaluate player efficiency.

---

## 7. COMPLETED SYSTEM: GLOBAL DEVELOPER MODE & TELEMETRY SUITE
To accelerate balancing and verification without leaking classified mechanics or cluttering player logs upon release, all scenario subsystems are tied to a single Global Developer Mode key:
*   **Key-Value Flag:** `FALKL_DEV_MODE` (Boolean string: `"true"` or `"false"`).
*   **Default State:** Set to `"true"` automatically on initialization. Set to `"false"` manually for release.

### 7.1 Cross-System Integrations
*   **CTFS (Carrier Task Force Selector):** Dynamically toggles `CTFS.DEBUG_MODE`. When active, reveals exact hour calculations, point budgets, and un-redacts the complete Argentine escalation matrix.
*   **GCE (Ground Control Engine):** Emits an exhaustive tabular diagnostics report to the console every hour tick: all 11 zones, base power, multipliers (CAS, NGFS, ISR, Morale, Tether), effective power deltas, shift percentages, unit counts, and strategic victory progress.
*   **GCE Consumption:** Logs unit-by-unit infiltration events with matched power points and physical map deletions.
*   **GCE AI Director:** Logs mainland reinforcement flights to West Falkland and strategic power diversions from Stanley.
*   **Generic UK Loss Tracker:** Logs casualty category, penalty points assessed, and threshold progress percentage.
*   **REE (Random Event Engine):** Exposes candidate pool analytics and unlocks the hourly sequential test runner (`REE_DEV_FORCE_EVENT_HOURLY` and `REE_DEV_FORCE_SEQUENTIAL`), managed via `ree-test-runner.lua`.

---

## 8. SCENARIO DEVELOPMENT WORKFLOW & RELEASE PACKAGING

To balance fast iteration with a completely self-contained final product, the project follows a two-stage lifecycle:

### 8.1 Active Development & Testing Phase (Current Workflow)
During active development, testing, and balancing:
1. **Use `ScenEdit_RunScript` in CMO Event Actions:**
   Events in CMO trigger a lightweight loader stub pointing to disk files:
   ```lua
   -- Example: Event Action (A_Open_CTFS_Dialog)
   if ScenEdit_RunScript("Development\\Global\\Falklands Systems\\CTFS\\core.lua") then
       CTFS.OpenDialog()
   end
   ```
2. **Always Use `CTFS.OpenDialog()` Instead of `CTFS.OpenUI()`:**
   - `CTFS.OpenDialog()` invokes the modal HTML dialog, which **automatically pauses the CMO simulation clock** and prevents time from elapsing while the player configures the fleet.
   - `CTFS.OpenUI()` creates a modeless dialog where the game clock continues to tick in the background.
3. **Developer Mode Flag:**
   Keep `FALKL_DEV_MODE = "true"` active in the Key-Value store to enable verbose logging, full GCE telemetry, and REE test facilities.
4. **Instant Iteration:**
   Edits made in external IDEs take effect immediately on scenario reload or tick without needing to copy-paste scripts into CMO after every change.

### 8.2 Final Scenario Release Packaging (One-Time Pre-Release Sweep)
Before distributing the scenario to players:
1. **One-Time Inline Script Paste:**
   CMO scenario files (`.scen`) are XML packages containing embedded `<ScriptText>` tags. For release, do a single comprehensive sweep where the full contents of each completed `.lua` file are pasted directly into its corresponding Lua Script Action in the CMO Event Manager.
2. **Zero-Dependency Guarantee:**
   Pasting inline removes all references to `Development\` paths on disk, ensuring the scenario runs out-of-the-box for any player downloading `Falklands 27.scen` on Steam Workshop or the Matrix Games forums.
3. **Deactivate Developer Mode:**
   Prior to saving the release `.scen` file, execute in the Lua console:
   ```lua
   ScenEdit_SetKeyValue("FALKL_DEV_MODE", "false")
   ScenEdit_SetKeyValue("REE_DEV_FORCE_EVENT_HOURLY", "false")
   ScenEdit_SetKeyValue("REE_DEV_FORCE_SEQUENTIAL", "false")
   ```
   This ensures end-users see clean military UI, standard combat telemetry, and organic randomized event scheduling without debug messages.

### 8.3 In-Game Event Action to Script Mapping Reference

| In-Game Event Action Name | Source Script on Disk | Release Inline Mode |
| :--- | :--- | :--- |
| **A_Init_Scenario_KVS** | `REE\ree-init-script.lua` | Paste inline |
| **A_Open_CTFS_Dialog** | `CTFS\core.lua` (calls `CTFS.OpenDialog()`) | Paste inline |
| **A_GCE_Master_Loop** | `GCE\core-engine-loop.lua` | Paste inline |
| **A_GCE_Unit_Consumption** | `GCE\consumption.lua` | Paste inline |
| **A_GCE_Counter_Offensive** | `GCE\counter-offensive.lua` | Paste inline |
| **A_REE_Master_Ticker** | `REE\master-ticker.lua` | Paste inline |
| **A_UK_Loss_Tracker** | `Generic\uk-loss-tracker.lua` | Paste inline |
