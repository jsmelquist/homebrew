package it.homebrew.engine
{
	import it.homebrew.engine.base.GameBase;
	import it.homebrew.engine.ticker.Ticker;
	import it.homebrew.engine.ticker.TickerEvent;
	import it.homebrew.engine.input.Key;
	import flash.display.Stage;
	import flash.ui.Keyboard;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;

	/**
	 * Class that encapsulates the Game logic, handles
	 * input events and manages the main game loop.
	 * @author Jon Smelquist
	 */
	public class Game extends Sprite
	{
		protected var _gamePaused:Boolean;
		protected var _ticker:Ticker;
		protected var _displaySurface:Sprite;
		protected var _display:BitmapData;
		protected var _viewRect:Rectangle;
		protected var _sprites:Vector.<GameBase>;

		public function get displaySurface():Sprite { return _displaySurface; }
		public function pauseGame():void { _gamePaused = true; }
		public function resumeGame():void { _gamePaused = false; }
		
		public function Game(stage:Stage)
		{
			// Create a new ticker running at 21ms
			_ticker = new Ticker(21);
			_ticker.addEventListener( TickerEvent.TICK, update );
			
			// Initialized game to not be paused
			_gamePaused = false;
			
			// Initialize the game surface
			_displaySurface = new Sprite();
			_display = new BitmapData(672, 512, false, 0x00000000);
            _displaySurface.addChild( new Bitmap( _display ) );
			_viewRect = new Rectangle(0, 0, 640, 480);
			
			// Initialize sprites container
			_sprites = new Vector.<GameBase>();

			Key.initialize(stage);
			gameStartup();
		}
		
		/*
		 * Abstract methods to be implemented by Game subclass
		 */
		protected function gameStartup():void { throw new IllegalOperationError("Abstract class method not implemented!"); }
		protected function gameKeyDown(key:uint):void { throw new IllegalOperationError("Abstract class method not implemented!"); }
		
		private function sortSpriteDepth(s1:GameBase, s2:GameBase):Number { return s1.depth - s2.depth; }
		protected function addSprite(sprite:GameBase):void
		{
			_sprites.push(sprite);
			_sprites.sort(sortSpriteDepth);
		}
		
		protected function removeSprite(sprite:GameBase):void
		{
			var i:int;
			i = _sprites.indexOf(sprite);
			if (i >= 0)
				_sprites.splice(i,1);
		}

		protected function update(evt:TickerEvent):void
		{
			if (!_gamePaused)
			{
				_display.fillRect(_viewRect, 0x00000000);
				handleInput();
				updateSprites(evt.interval);
				drawSprites();
				trace(1000/evt.interval);
			}
		}
		
		protected function updateSprites(interval:int):void 
		{
			var size:int = _sprites.length;
			for (var i:int = 0; i < size; i++)
			{
				_sprites[i].processTick(interval);
			}
		}
		protected function drawSprites():void 
		{
			var size:int = _sprites.length;
			for (var i:int = 0; i < size; i++)
			{
				_sprites[i].draw(_display, _viewRect);
			}
		}
		
		protected function handleInput():void 
		{
			for (var s:String in Key.keysDown)
				gameKeyDown(uint(s));
		}
		
	}
	
}