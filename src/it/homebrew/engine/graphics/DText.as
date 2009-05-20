﻿package it.homebrew.engine.graphics{
    import flash.display.*;
    import flash.geom.*;
    public class DText {
        public static const LEFT:int = 0;
        public static const RIGHT:int = 1;
        public static const CENTER:int = 2;
        
        /* You need this image: http://kaioa.com/b/0808/console.png */
        [Embed(source = 'console.png')]
        private static var CSheet:Class;
        private static var chars:Bitmap = new CSheet();
        
        private static const DEFAULT_CHAR:Number = '?'.charCodeAt(0);
        private static const NEW_LINE:Number = '\n'.charCodeAt(0);
        private static var CHAR_RECTS:Object; 
		
		private static function getCharRects():Object
		{
			if (CHAR_RECTS == null) {
				CHAR_RECTS = new Object();
				var i:int;
				for (i = 32; i < 161; i++)
					CHAR_RECTS[i] = new Rectangle(((i - 32) % 16) * 16, (int)((i - 32) / 16) * 16, 9, 16);
			}
			return CHAR_RECTS;
		}
        
        public static function draw(buffer:BitmapData, text:String, x:int = 0, y:int = 0, align:int = DText.LEFT):void {
            var lines:Array = text.split('\n');
            for each(var line:String in lines) {
                if (align == LEFT)
                    drawLine(buffer, line, x, y);
                else if (align == RIGHT)
                    drawLine(buffer, line, x - line.length * 8, y);
                else // CENTER
                    drawLine(buffer, line, x - line.length * 8 / 2, y);
                y += 13;
            }
        }
        
        private static function drawLine(buffer:BitmapData, text:String, x:int, y:int):void {
            var p:Point = new Point(x, y);
            var len:int = text.length;
            for (var n:int = 0; n < len; n++) {
                var c:Number = text.charCodeAt(n);
                if (c > 160 || c < 32)
                    c = DEFAULT_CHAR;
                buffer.copyPixels(chars.bitmapData, getCharRects()[c], p);
                p.x += 8;
            }
        }
    }
}