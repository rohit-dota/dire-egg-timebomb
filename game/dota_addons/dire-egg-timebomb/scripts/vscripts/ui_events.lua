-- This function is called whenever any player right clicks
function GameMode:OnRightClick(keys)
  -- if it's the player's turn, then register a move order
  for k,v in pairs(keys.cursor_position) do
  	print(k,v)
  end
  local playerID = keys.playerID
  print("right click")
  local activeUnit = TurnTimers.activeUnit
  if(activeUnit and playerID == activeUnit.controller) then
	  print("begin register")
    RegisterMoveOrder(keys.cursor_position)
  end
end

function GameMode:OnConfirmTurn(keys)
	if(TurnTimers.activeUnit) then
		TurnTimers:EndTurn()
	end
end
