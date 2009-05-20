package engine.game.player.commands {
	import it.homebrew.engine.base.command.ICommand;
	import it.homebrew.engine.game.player.Player;
	
	/**
	* Command object for moving a player around the map.
	* @author Jon Smelquist
	*/
	public class WalkPlayer implements ICommand {
		
		private var _player:Player;
		private var _direction:int;
		
		public function WalkPlayer(player:Player, direction:int) {
			_player = player;
			_direction = direction;
		}
		
		/**
		 * Move the player in the chosen direction
		 */
		public function execute():void {
			_player.walk(_direction);
		}
		
		/**
		 * Leave the undo function blank for now
		 */
		public function undo():void { }
	}
	
}