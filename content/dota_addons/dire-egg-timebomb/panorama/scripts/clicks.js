GameUI.SetMouseCallback(function(eventName, arg){
	var CONSUME_EVENT = true;
	var RIGHT_CLICK = (arg === 1);
	if(eventName == "pressed" || eventName == "doublepressed"){
		if(RIGHT_CLICK){
			OnRightButtonPressed()
		}
	}
	return CONSUME_EVENT;
});

function OnRightButtonPressed(){
	var mPos = GameUI.GetCursorPosition()
	var gamePosition = Game.ScreenXYToWorld(mPos[0], mPos[1])

	$.Msg('cursor position is ' + mPos)
	$.Msg('game world position is ' + gamePosition)
	var RBPressedEvent = {
		"cursor_position": gamePosition, // what is the accurate way to determine the map position?
		"playerID": Players.GetLocalPlayer()
	}
	GameEvents.SendCustomGameEventToServer("right_click", RBPressedEvent)
}