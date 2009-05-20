package game.player.states 
{
	import game.player.Player;
	//import game.world.Map;
	import flash.geom.Point;
	//import it.homebrew.engine.base.sim.Sim;
	import game.Constants;
	
	/**
	 * ...
	 * @author Jon Smelquist
	 */
	public class StandingState extends IPlayerState{
		
		/*
		* Here we initialize any values that we need to as the state of our player has changed
		*/
		public function StandingState(player:Player)
		{ 
			// Store player object
			super(player);
		}

		public override function update():void
		{
			/* Here is a simple *goofy* animation to show the player with a "surprised" look
			* for a short period if the player has made him walk recently */
			
			// If we've counted up to 280, show the animation 
			if (_player.animCount >= 280)
			{
				_player.animRow = Constants.SOUTH;
				_player.animCol = 4;				
			}
			// at 300 we can stop the animation, and reset the counters
			if (_player.animCount >= 300)
			{
				_player.animCol = 0;
				_player.animCount = 0;
			}
			
			_player.animCount = _player.animCount+1;
		}
		
		public override function stand():void
		{
			// Nothing to do, you cannot stand if you are already standing
		}
		
		public override function walk(direction:int):void
		{
			
			_player.animRow = direction;
			_player.animCol = 0;
			_player.animCount = 0;
			var center:Point = new Point(_player.position.x + (_player.display.width*0.5), _player.position.y + (_player.display.height-4));
				
		/*	var map:Map = Sim.findObject("CurrentMap") as Map;
				
			if (direction == Constants.EAST) {
				// check the tile to the east
				if (!map.getTile(new Point(center.x + 32, center.y)).blocks) {
					_player.animCount = 32;
					_player.changeState(_player.walkingState);
				}
			}
			else if (direction == Constants. WEST) {
					// check the tile to the west
					if (!map.getTile(new Point(center.x - 32, center.y)).blocks) {
						_player.animCount = 32;
						_player.changeState(_player.walkingState);
					}					
			}
			else if (direction == Constants.SOUTH) {
					// check the tile to the north
					if (!map.getTile(new Point(center.x, center.y + 32)).blocks) {
						_player.animCount = 32;
						_player.changeState(_player.walkingState);
					}	
			}
			else if (direction == Constants.NORTH) {
					// check the tile to the north
					if (!map.getTile(new Point(center.x, center.y - 32)).blocks) {
						_player.animCount = 32;
						_player.changeState(_player.walkingState);
					}			
			}*/
		}
		
				
		public override function getClassName():String
		{
			return "StandingState";
		}
	}
	
}