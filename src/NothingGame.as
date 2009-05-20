package  
{
	import it.homebrew.engine.Game;
	import flash.display.Stage;
	import game.player.Player;
	import flash.ui.Keyboard;
	
	/**
	 * Nothing Game
	 * @author Jon Smelquist
	 */
	public class NothingGame extends Game
	{
		[Embed(source='/assets/yheti.png')]
		public static const GUARD:Class;
		private var _player:Player;
		
		public function NothingGame(stage:Stage) 
		{
			super(stage);
		}
		
		protected override function gameStartup():void
		{
			_player = new Player(GUARD, "nothing", "nothing");
			addSprite(_player);
			
			// Start our internal ticker
			_ticker.start();
		}
		
		protected override function gameKeyDown(key:uint):void
		{
			if (key == Keyboard.DOWN)
				_player.x = _player.x +1;
		}
	}
	
}