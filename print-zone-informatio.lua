-- NOFLYZONE-Diagnostic-v01
-- This script lists ALL zones for Russia and checks their hidden properties.

local sideName = "Russia"
local side = VP_GetSide({name=sideName})

print("--- DIAGNOSTIC: LISTING ALL ZONES FOR " .. sideName:upper() .. " ---")

-- 1. Check No-Navigation Zones
print(">> NO-NAVIGATION ZONES:")
if side.nonavzones and #side.nonavzones > 0 then
    for i, z in ipairs(side.nonavzones) do
        print(string.format("[%d] NAME: '%s' | GUID: %s | ACTIVE: %s", i, z.description, z.guid, tostring(z.isactive)))
    end
else
    print("   (None found)")
end

-- 2. Check Exclusion Zones (In case the zone was created as 'Exclusion' by mistake)
print("\n>> EXCLUSION ZONES:")
if side.exclusionzones and #side.exclusionzones > 0 then
    for i, z in ipairs(side.exclusionzones) do
        print(string.format("[%d] NAME: '%s' | GUID: %s | ACTIVE: %s", i, z.description, z.guid, tostring(z.isactive)))
    end
else
    print("   (None found)")
end

print("\n--- DIAGNOSTIC COMPLETE ---")