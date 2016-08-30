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
	$.Msg('js: clicked at ' + pos)
	var RBPressedEvent = {
		"cursor_position": GameUI.GetCursorPosition(),
		"playerID": Players.GetLocalPlayer()
	}
	GameEvents.SendCustomGameEventToServer("right_click", RBPressedEvent)
}