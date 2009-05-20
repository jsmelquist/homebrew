package it.homebrew.engine.base {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	* This is the base class for anything that will be shown 
	* on screen.
	* @author Jon Smelquist
	*/
	public class SceneObject{
		
		protected var _display:BitmapData;
		protected var _source:BitmapData;
		protected var _position:Point;
		protected var _depth:int;

		protected var _animCol:int;
		protected var _animRow:int;
		protected var _animCount:int;
		
		public function set x(value:int):void { _position.x = value; }
		public function set y(value:int):void { _position.y = value; }
		public function get x():int { return _position.x; }
		public function get y():int { return _position.y; }
		public function get depth():int { return _depth; }
		public function get display():BitmapData { return _display; }
		public function get position():Point { return _position; }
		public function set position(value:Point):void { _position = value; }
		public function set animCol(value:int):void { _animCol = value; }
		public function get animCol():int { return _animCol; }
		public function set animRow(value:int):void { _animRow = value; }
		public function get animRow():int { return _animRow; }
		public function get animCount():int { return _animCount; }
		public function set animCount(value:int):void { _animCount = value; }	
		
		public function SceneObject() { }
	
		/**
		 * Draw the SceneObjects visual data to the specified surface.
		 * @param	surface		The surface to draw on.
		 */
		public function draw(surface:BitmapData, viewRect:Rectangle):void 
		{
			surface.copyPixels( _display, _display.rect, new Point(_position.x - viewRect.x, _position.y - viewRect.y));
		}
	
		
	}
	
}