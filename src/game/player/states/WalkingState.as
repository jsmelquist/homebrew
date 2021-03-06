﻿package game.player.states 
{
	import game.player.Player;
	import game.Constants;
	
	/**
	 * The state in which a player is walking (needs to be animated to visually represent its
	 * actions, etc...
	 * @author Jon Smelquist
	 */
	public class WalkingState extends IPlayerState {
		
		/*
		* Here we initialize any values that we need to as the state of our player has changed
		*/
		public function WalkingState(player:Player)
		{ 
			// Store player object
			super(player);
		}
		
		public override function update():void
		{
			// Amount to move in each direction this update
			var xmov:int = 0;
			var ymov:int = 0;

			if (_player.animRow > 1) {// East and west movement
				xmov = 8;//4 pixels for one step
			} else {// North and South movement
				ymov = 8;//4 pixels for one step
			}
			
			if (_player.animRow == Constants.EAST && xmov != 0) {
				_player.position.x += xmov;
			}
			else if (_player.animRow == Constants.WEST && xmov != 0) {
				_player.position.x -= xmov;
			}
			else if (_player.animRow == Constants.SOUTH && ymov != 0) {
				_player.position.y += ymov;
			}
			else if (_player.animRow == Constants.NORTH && ymov != 0) {
				_player.position.y -= ymov;
			}
			
			// Subtract amount of steps walked
			_player.animCount-=8;
			if (_player.animCount <= 0) {
				stand();
			}
		}
		
		public override function stand():void
		{
			_player.totalFrames = 1;
			_player.changeState(_player.standingState);
		}
		
		public override function walk(direction:int):void
		{
			// Nothing to do, you cannot initiate walking if you are already walking
		}
		
		public override function getClassName():String
		{
			return "WalkingState";
		}
	}
	
}