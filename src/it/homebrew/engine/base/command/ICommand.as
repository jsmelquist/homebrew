package it.homebrew.engine.base.command {
	
	/**
	* Interface for commands sent to objects in the game system
	* @author Jon Smelquist
	*/
	public interface ICommand {
		
		function execute():void;
		
		function undo():void;
		
	}
	
}