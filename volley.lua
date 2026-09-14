--[[
===============================================================
README — Multi‑Ship Manual Weapon Allocation Script
===============================================================

Purpose:
--------
This script orders three Russian‑side ships to manually fire a
specific weapon (DBID 4439) from a specific mount (ID 4196) at
a NATO‑side target (Ariane 6 Launchpad). It uses the CMO API
function ScenEdit_AttackContact(), which requires a CONTACT
GUID, not a UNIT GUID.

Key Features:
-------------
1. Converts a UNIT GUID into a CONTACT GUID for the Russia side.
   - If Russia already has a contact on the target, it is used.
   - If not, the script automatically creates one.

2. Issues a manual weapon allocation attack:
   mode   = 1      → manual allocation
   mount  = 4196   → mount ID on the firing ships
   weapon = 4439   → weapon DBID
   qty    = 25     → number of rounds to fire per ship

3. Sends debug messages to the Message Log using
   ScenEdit_SpecialMessage(), since print() is not supported in
   modern CMO builds.

How to Adapt:
-------------
• To change firing ships:
  - Replace the GUIDs in the "ships" table.

• To change the target:
  - Replace targetUnitGuid with the new unit GUID.
  - The script will automatically create a contact if needed.

• To change weapons or mounts:
  - Update the "attackOptions" table with new mount/weapon IDs.
  - Ensure the ships actually have those mounts/weapons.

• To fire multiple mounts:
  - Loop through mount IDs and call ScenEdit_AttackContact()
    for each one.

Important Notes:
----------------
• ScenEdit_AttackContact() ONLY works with CONTACT GUIDs.
  Passing a UNIT GUID will always fail.

• Civilian ships normally have no weapons. Ensure your ships
  have the correct mounts and weapons before using this script.

• If an attack fails, the script logs a clear error message
  identifying which ship failed.

===============================================================
END OF README
===============================================================
]]


-- ============================================================
-- Helper: Convert UNIT GUID → CONTACT GUID (create if needed)
-- ============================================================
function GetOrCreateContact(side, unitGuid)
    local contacts = ScenEdit_GetContacts(side)
    if contacts then
        for _, c in pairs(contacts) do
            if c.actualunitid == unitGuid then
                return c.guid
            end
        end
    end

    local u = ScenEdit_GetUnit({guid=unitGuid})
    if not u then
        ScenEdit_SpecialMessage("Russia", "ERROR: Unit not found: " .. tostring(unitGuid))
        return nil
    end

    local newContact = ScenEdit_AddContact({
        side = side,
        name = u.name,
        guid = u.guid
    })

    return newContact.guid
end


-- ============================================================
-- Fire weapons from three Russian ships at NATO target
-- ============================================================

local ships = {
    "W8V2DT-0HNIOBJ367BSI",
    "W8V2DT-0HNIL407V5J00",
    "W8V2DT-0HNIL407V5J0A"
}

local targetUnitGuid = "W8V2DT-0HNIL407V5BAO"

local targetContactGuid = GetOrCreateContact("Russia", targetUnitGuid)

if not targetContactGuid then
    ScenEdit_SpecialMessage("Russia", "ERROR: Could not create or find target contact.")
    return
end

local attackOptions = {
    mode = 1,
    mount = 4196,
    weapon = 4439,
    qty = 25
}

for _, ship in ipairs(ships) do
    local ok = ScenEdit_AttackContact(ship, targetContactGuid, attackOptions)
    if ok then
        ScenEdit_SpecialMessage("Russia", "Attack assigned from ship " .. ship)
    else
        ScenEdit_SpecialMessage("Russia", "ERROR: Attack failed for ship " .. ship)
    end
end
