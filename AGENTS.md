# Project Guidelines & Memory Instructions

## Knowledge Preservation & Reference Files Rule

**MANDATORY INSTRUCTION**:
Whenever you learn, discover, or reverse-engineer anything new during any task or troubleshooting step in this workspace:
1. **Always document the findings** in one of the files under:
   `d:\SteamLibrary\steamapps\common\Command - Modern Operations\Lua\Development\Global\Falklands Systems\Reference files\`
2. **Choose the appropriate reference file**:
   - `cmo-engine-mechanics-reference.md`: Engine internals, Lua API quirks, database tables/schema, mount/VLS mechanics, magazine handling, SpecialMessage/MsgBox behavior, assembly/runtime mechanics.
   - `dbids.md`: Specific database IDs (DBIDs) for weapons, ships, aircraft, mounts, facilities.
   - `GUIDs.md`: Scenario entity GUIDs, reference points, and triggers.
   - `Design document.md`: Scenario architecture, event flows, scoring, and higher-level system design.
3. **If no suitable file exists**, create a new, well-named Markdown reference file in that folder (e.g., `Reference files/<topic>-reference.md`).
4. **Be thorough**: Include code examples, schema tables, edge cases, workarounds, and exact failure modes.
