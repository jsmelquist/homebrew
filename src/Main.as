import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import engine.ticker.*;


protected var _ticker:Ticker;
protected var _viewport:Sprite;

/**
 * ...
 * @author Jon Smelquist
 */

public function init():void
{
	// Initialize new sprite to allow rendering
	_viewport = new Sprite();
	// Create a new ticker running at 21ms
    _ticker = new Ticker(21);
    _ticker.addEventListener( TickerEvent.TICK, tick );
}

private function tick(evt:TickerEvent):void
{
	trace("yaya");
	_viewport.addChild(new Bitmap(new BitmapData(672, 512, false, 0xFFFFFFFF)));
}
/**
 * 
 */

public function backToLoginScreen():void
{
	viewstack.selectedChild = view_login;
}

public function onGameViewReady():void
{
	trace("Game starting...");
	viewport.addChild(_viewport);
	_ticker.start();
	
	
}