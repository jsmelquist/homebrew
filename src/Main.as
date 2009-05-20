
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import it.homebrew.engine.ticker.*;
import it.gotoandplay.smartfoxserver.*;


protected var _viewport:Sprite;
protected var _smartFox:SmartFoxClient;
protected var _game:NothingGame;

/**
 * ...
 * @author Jon Smelquist
 */

private function init():void
{
	// Initialize Smart Fox Client
	_smartFox = new SmartFoxClient();
	_smartFox.addEventListener(SFSEvent.onConnection, onConnected);
	_smartFox.addEventListener(SFSEvent.onExtensionResponse, onExtResponse);
	
	// Initialize new game object
	_game = new NothingGame(stage);
	
	_smartFox.connect("67.23.25.65");
}

private function bt_login():void
{
	_smartFox.login("nothing", tf_name.text, tf_password.text);
}

private function onConnected(success:Boolean):void 
{
	if (success)
    {
		viewstack.selectedChild = view_login;
	}
}

protected function onExtResponse(evt:SFSEvent):void
{
    var type:String = evt.params.type;
    var data:Object = evt.params.dataObj;
    var command:String = data._cmd;
                        
    switch(type)
    {
        case "xml":
            if (command == "logOK")
            {
                viewstack.selectedChild = view_game;                                
            }
            else if (command == "logKO")
            {
                
			}
			break;
   }
                        
}


public function backToLoginScreen():void
{
	viewstack.selectedChild = view_login;
}

public function onGameViewReady():void
{
	trace("Game starting...");
	viewport.addChild(_game.displaySurface);
	
}