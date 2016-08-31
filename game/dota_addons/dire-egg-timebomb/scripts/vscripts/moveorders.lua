function ExecuteMoveOrders(unit)
	for _,d in pairs(unit.destinations) do
		local xPos = d["0"]
		local yPos = d["1"]
		local zPos = d["2"]
		print(unit.timerName .. " is moving to (" .. xPos .. "," .. yPos .. "," .. zPos .. ")")
		local dest = Vector(xPos, yPos, zPos)
		order = {
			UnitIndex = unit:GetEntityIndex(),
			OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
			Position = dest,
			Queue = 1
		}
		-- ExecuteOrderFromTable(order)
		unit:MoveToPosition(dest)
	end
	unit.destinations = {}
end


function RegisterMoveOrder(cursor_position)
	-- TODO: use GridNav:CanFindPath to check if the move is valid
	local activeUnit = TurnTimers.activeUnit
	table.insert(activeUnit.destinations, cursor_position)
	print(activeUnit.timerName .. "'s move order to " .. "(" .. cursor_position["0"] .. "," .. cursor_position["1"] .. "," .. cursor_position["2"] .. ") registered")
end