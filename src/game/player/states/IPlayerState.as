package game.player.states 
{
	import game.player.Player;
	import flash.errors.IllegalOperationError;
	
	/**
	 * This is the base class for all player states. It contains the methods
	 * that the player class will wrap, to perform contextual logic.
	 * @author Jon Smelquist
	 */
	public class IPlayerState 
	{
	
		// This is the reference to the player object that instantiated and stored the
		// state object. Concrete state classes must call super(player) to store the object.
		protected var _player:Player;
	
		public function IPlayerState(player:Player)
		{ 
			_player = player;
		}
		
		/**
		* This function is the main update function that gets called every time the processTick
		* function calculates that it is time. In this function we perform any animation counting
		* or logic that needs to be executed for the respective state.
		*
		* @param player The player object reference to perform the logic on
		**/
		public function update():void
		{
			throw new IllegalOperationError("Abstract class method not implemented!");
		}
		
		/**
		* This function will perform the required logic to stop the player and return to a base
		* state of just standing. Note: A StandingState for example would execute no logic here
		* since the player is already standing.
		* 
		* @param player The player object reference to perform the logic on
		**/
		public function stand():void
		{
			throw new IllegalOperationError("Abstract class method not implemented!");
		}
		
		/**
		* This function performs the logic to initiate a walk movement in the specified
		* direction. Note: A WalkingState for example would execute no logic here since
		* the player is already walking.
		*
		* @param player The player object reference to perform the logic on
		* @param direction The direction in which to walk the player
		**/
		public function walk(direction:int):void
		{
			throw new IllegalOperationError("Abstract class method not implemented!");
		}
		
		
		public function getClassName():String
		{
			throw new IllegalOperationError("Abstract class method not implemented!");
		}
	}
	
}