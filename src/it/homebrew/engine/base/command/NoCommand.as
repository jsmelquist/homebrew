﻿package it.homebrew.engine.base.command {
	
	/**
	* Basic "null command" object, used as a filler command for
	* when no logic is needed.
	* @author Jon Smelquist
	*/
	public class NoCommand implements ICommand
	{
		public function NoCommand() { }
		
		public function execute():void { }
		
		public function undo():void { }	
	}
	
}