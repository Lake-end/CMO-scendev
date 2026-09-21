# Argentine Escalation and Boons - Falklands 2027

## 1. Core Concept
For every 5 hours (1 point) the UK delays their Task Force launch, Argentina gains additional time to fortify, deploy, and receive international assistance. 
Max delay is 500 hours (approx. 21 days).

## 2. Threshold Escalations
As the UK accumulates points (hours delayed), specific triggers 
fire for the Argentine side.

### Phase 0: Player sails without any delays
* *Idea:* Argentina has no additional boons, units spawned by default will be created elsewhere or placed manually on map(by me).


### Phase 1: Early Warnings (0 - 25 points / 0 - 5 Days)
*   *Idea:* Basic reinforcement of the islands.
*   *Trigger 10 pts:* Argentina deploys additional SPYDER-SR SAM batteries to Stanley.
*   *Trigger 20 pts:* Airstrips are extended; additional combat aircraft are moved to the Falklands from the mainland.

### Phase 2: Entrenchment (26 - 50 points / 5 - 10 Days)
*   *Idea:* Digging in and receiving short-term foreign military sales.
*   *Trigger 30 pts:* Additional coastal defense SSM batteries (MM.40 Blk III Exocet) arrive at key chokepoints.
*   *Trigger 40 pts:* Mining operations commence in the approaches to San Carlos Water and Falkland Sound.
*   *Trigger 50 pts:* Argentina side proficiency increases from Regular -> Veteran (see CMO__SideOptions:table - > @field proficiency string )

### Phase 3: Regional Support (51 - 75 points / 10 - 16 Days)
*   *Idea:* Heavy fortifications and advanced sensors.
*   *Trigger 60 pts:* SPYDER-MR SAM batteries become operational.
*   *Trigger 70 pts:* Advanced diesel-electric submarine complete maintenance and are deployed to intercept the Royal Navy TF.

### Phase 4: Maximum Readiness (76 - 100 points / 16 - 21 Days)
*   *Idea:* The window closes; Argentina is fully prepared.
*   *Trigger 80 pts:* Maximum air patrols; mainland strike aircraft are fully loaded and fueled, awaiting the UK fleet.
*   *Trigger 75 pts:* Second Advanced diesel-electric submarine complete maintenance and are deployed to intercept the Royal Navy TF.
*   *Trigger 95 pts:* Widespread deployment of RBS 70 NG MANPADS across all tactical zones.
*   *Trigger 99 pts:* Argentina side proficiency increases from Veteran -> Ace

## 3. Dynamic Scripting Notes
*   (Add any specific thoughts here on how you want the Lua script to handle these spawns—e.g., randomizing exact locations within a zone to keep replayability high).