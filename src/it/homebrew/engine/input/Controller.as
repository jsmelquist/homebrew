﻿package it.homebrew.engine.input
{
	import engine.base.command.ICommand;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Jon Smelquist
	 */
	public class Controller 
	{
		protected var _commands:Dictionary;
		
		public function Controller() 
		{
			_commands = new Dictionary();
		}
		
		public function bindCommand(key:uint, command:ICommand):void
		{
			_commands[key] = command;
		}
		
		public function executeCommand(key:uint):void
		{
			var command:ICommand = _commands[key] as ICommand;
			command.execute();
		}
		
	}
	
}