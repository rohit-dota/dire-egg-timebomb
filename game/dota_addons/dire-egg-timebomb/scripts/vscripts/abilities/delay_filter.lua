delay_filter = class({})
local self = delay_filter

function delay_filter(keys)
	-- keys:
	-- unit
	-- caster (is nil???)
	-- caster_entindex (int)
	-- ScriptFile
	-- Function
	-- ability
	print("delay_filter called")
	for k,v in pairs(keys.unit) do
		print(k,v)
	end
	unit = keys.caster
	unit:Stop()

	if(unit.ordersEnabled) then
		if(not unit.orderDetected) then
			unit.orderDetected = true
			table.insert(unit.destinations, GameUI.GetCursorPosition())
			unit.orderDetected = false
		end
	end
end