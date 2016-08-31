if TurnTimers == nil then
  print ( '[TurnTimers] creating TurnTimers' )
  TurnTimers = {}
  TurnTimers.timed_units = {}
  TurnTimers.activeUnit = nil -- denotes the unit taking its turn, is always nil unless StartTurn() has been called
  setmetatable(TurnTimers, {
    __call = function(t, ...)
      return t:CreateUnitWithTurnTimerForPlayer(...)
    end
  })
end

function TurnTimers:CreateUnitWithTurnTimerForPlayer(unitName, player)
	local unit = CreateUnitByName(unitName, Vector(0, 0, 0), true, nil, nil, player:GetTeamNumber())
    print("[DET] Speed of " .. unit:GetUnitName() .. " is " .. unit:GetKeyValue("DET_Speed"))

    unit.timerName = unitName .. "_" .. unit:GetEntityIndex()
    print("unit " .. unit.timerName .. " spawned")
    unit.destinations = {}
    unit.controller = player:GetPlayerID()
    table.insert(self.timed_units, unit)
    self:StartTimer(unit)
    return unit
end

function TurnTimers:StartTurn(unit)
	print("[TurnTimers] A unit is taking its turn: " .. unit.timerName)
	self.activeUnit = unit
	unit:Stop()
	unit.timerActive = false 
	self:PauseAllTimers()
	-- pause all turn timers here
	-- halt all movement and projectiles temporarily
end

-- function called after player input is confirmed
-- all timers should be running after this function is called
function TurnTimers:EndTurn()
	print("[TurnTimers] end turn")
	unit = self.activeUnit
	self.activeUnit = nil
	unit.timerActive = true
	ExecuteMoveOrders(unit)
	self:StartTimer(unit)
	self:ResumeAllTimers()
end

function TurnTimers:ComputeTimeToTurn(unitSpeed)
	finalSpeed = (200 - unitSpeed) / 10.0
	return finalSpeed
end

function TurnTimers:StartAllTimers()
	for unit in self.timed_units do
		self:StartTimer(unit)
	end
end

function TurnTimers:PauseAllTimers()
	for _,unit in pairs(self.timed_units) do
		self:PauseTimer(unit)
	end
end

function TurnTimers:ResumeAllTimers()
	for _,unit in pairs(self.timed_units) do
		self:ResumeTimer(unit)
	end
end

-- begin a timer for the given unit
function TurnTimers:StartTimer(unit)
	unitSpeed = unit:GetKeyValue("DET_Speed")
	timeToTurn = self:ComputeTimeToTurn(unitSpeed)

	-- at the end of the timer, it's the unit's turn to issue commands
	timerName = Timers:CreateTimer(unit.timerName, {
		endTime = timeToTurn,
		callback = function()
			print("starting turn for " .. unit.timerName .. " now")
			self:StartTurn(unit)
		end	
	})
	return timerName
end

function TurnTimers:PauseTimer(unit)
	Timers:PauseTimer(unit.timerName)
end

function TurnTimers:ResumeTimer(unit)
	Timers:ResumeTimer(unit.timerName)
end

GameRules.TurnTimers = TurnTimers