package it.homebrew.engine.base{
	
	import flash.errors.IllegalOperationError;
	import flash.geom.Point;
	
	/**
	* Base class for anything that acts on ticks in the game environment
	* @author Jon Smelquist
	*/
	public class GameBase extends SceneObject {
		
		protected var _msTick:int;
		protected var _msTotal:int;
		protected var _totalFrames:int;
		protected var _curFrame:int;
		protected var _isDirty:Boolean;
		protected var _changedItems:Object;
		
		public function get dirty():Boolean { return _isDirty; }
		public function clearDirty():void { _isDirty = false; }
		public function setDirty():void { _isDirty = true; }
		
		public function get totalFrames():int { return _totalFrames; }
		public function set totalFrames(value:int):void { _totalFrames = value; }
		
		public function get changedItems():Object
		{ 
			_changedItems.x = this._position.x;
			_changedItems.y = this._position.y;
			_changedItems.animCol = this._animCol;
			_changedItems.animRow = this._animRow;

			return _changedItems; 
		}
		
		public function GameBase(tick:int)
		{
			_msTick = tick;
			_msTotal = 0;
			_isDirty = false;
			_changedItems = {};
						
			// Intitialize SceneObject variables
			_position = new Point(0, 0);
			_animCount = 0;
			_curFrame = 0;
			_totalFrames = 1;
			_depth = 0;
		}
		
		
		protected function update():void
		{
			throw new IllegalOperationError("Abstract class method not implemented!");
		}
		
		/**
		 * Calculate to see whether this game object needs its update method
		 * called. We store the remainder of the tick interval to allow a more
		 * accurate timing sequence.
		 * @param	interval	Current interval value of the ticker.
		 */
		public final function processTick(interval:int):void
		{
			_msTotal += interval;
			if (_msTotal >= _msTick)
			{
				_msTotal -= _msTick;
				_curFrame += 1;
				if (_curFrame < 0) _curFrame = _totalFrames - 1;
				if (_curFrame > _totalFrames - 1) _curFrame = 0; 
				update();
			}
		}
		
	}
	
}