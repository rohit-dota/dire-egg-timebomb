function OnConfirmTurnButtonPressed()
{
  $.Msg("confirm turn button pressed");
  var confirmTurnButtonEvent = {}
  GameEvents.SendCustomGameEventToServer("confirm_turn_button", confirmTurnButtonEvent)
}

function OnTestButtonPressed()
{
  $.Msg("'ESC' Pressed");
}

function OnTestButtonReleased()
{
  $.Msg("'ESC' Released");
}

(function() {
  Game.AddCommand( "ConfirmTurnButton", OnConfirmTurnButtonPressed, "", 0 );
  Game.AddCommand( "+CustomGameTestButton", OnTestButtonPressed, "", 0 );
  Game.AddCommand( "-CustomGameTestButton", OnTestButtonReleased, "", 0 );
})();