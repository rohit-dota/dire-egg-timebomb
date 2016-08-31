CustomGameEventManager:RegisterListener("right_click", Dynamic_Wrap(GameMode, 'OnRightClick'))
-- ListenToGameEvent("right_click", Dynamic_Wrap(GameMode, 'OnRightClick'), self)

CustomGameEventManager:RegisterListener("confirm_turn_button", Dynamic_Wrap(GameMode, 'OnConfirmTurn'))