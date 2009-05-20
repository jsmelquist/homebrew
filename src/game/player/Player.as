package game.player {
	import game.player.states.*;
	import flash.events.Event;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//import it.homebrew.engine.base.sim.Sim;
	import game.Constants;
	import it.homebrew.engine.base.GameBase;
	//import it.homebrew.engine.game.world.Map;
	import flash.text.TextField;
	import it.homebrew.engine.graphics.DText;
	
	/**
	* ...
	* @author Jon Smelquist
	*/
	public class Player extends GameBase{
		
		protected var _state:IPlayerState;
		protected var _standingState:IPlayerState;
		protected var _walkingState:IPlayerState;
		protected var _playerID:String;
		protected var _playerNick:String;
		
		public function get id():String { return _playerID; }
		public function get standingState():IPlayerState { return _standingState; };
		public function get walkingState():IPlayerState { return _walkingState; };
		
		public function set state(klass:String):void 
		{
			if (klass == _standingState.getClassName())
			{
				this.stand();
			}
			else if (klass == _walkingState.getClassName())
			{
				this.walk(_animRow);
			}
		}
		
		public override function get changedItems():Object
		{ 
			_changedItems.x = this._position.x;
			_changedItems.y = this._position.y;
			_changedItems.animRow = this._animRow;
			_changedItems.state = _state.getClassName();

			return _changedItems; 
		}
		
		public function Player(imageSource:Class, playerID:String, playerNick:String) {
			// Initialize the player with a 60ms update rate
			super(60);
			// Animation column selection will be "states" of a player in a direction
			_animCol = 0;
			// Animation row selection dictate the "position" of the player (NWSE Direction)
			_animRow = 0;
			
			_playerID = playerID;
			_playerNick = playerNick;
			
			// Set up states
			_standingState = new StandingState(this);
			_walkingState = new WalkingState(this);
			
			var source:Bitmap = new imageSource();
			_source = new BitmapData( source.width, source.height, true, 0x00000000 );
			_source.draw( source );
			_display = new BitmapData( 32, 48, true, 0x00000000 );
			
			_state = _standingState;
		}
		
		public function setPlayerImageSource(imageSource:Class):void {
			var source:Bitmap = new imageSource();
			_source = new BitmapData( source.width, source.height, true );
			_source.draw( source );
		}
		
		public function setPlayerPosition(position:Point, direction:int):void {
			_position = position;
			_animRow = direction;
			setDirty();
		}
		
		public function stand():void {
			_totalFrames = 1;
			_state.stand();
		}
		
		public function changeState(state:IPlayerState):void
		{
			_state = state;
			setDirty();
		}
		
		public override function draw(surface:BitmapData, camRect:Rectangle):void
		{
			surface.copyPixels( _display, _display.rect, new Point( (_position.x - camRect.x), (_position.y - camRect.y) + 12 ));
			DText.draw(surface, _playerNick, (_position.x - camRect.x) + (_display.rect.width/2), (_position.y - camRect.y), DText.CENTER );
		}
		
		protected override function update():void
		{
			_state.update();

			// if state is not within repeating walking states (0-3) do not perform modulus modifications
			if (_curFrame <= 3)
				_display.copyPixels(_source, new Rectangle((_curFrame % 3) * _display.width, (_animRow * _display.height), _display.width, _display.height), new Point(0, 0));
			else	
				_display.copyPixels(_source, new Rectangle((_curFrame * _display.width), (_animRow * _display.height), _display.width, _display.height), new Point(0, 0));
		}
		
		public function walk(direction:int):void {	
			_totalFrames = 3;
			_state.walk(direction);
		}
		
	}
	
}