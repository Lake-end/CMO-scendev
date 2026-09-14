-- >>> REPLACE THESE WITH YOUR VALUES <<<
local UNIT_GUID  = "W8V2DT-0HNBD41023RLD"
local SENSOR_ID  = 6954   -- Replace with actual sensor ID
-- >>> END OF USER VALUES <<<

-- Hybrid sabotage: damage one random sensor component
ScenEdit_SetUnitDamage({
    guid = UNIT_GUID,
    components = {
        {'type', type='sensor', 1}
    }
})
