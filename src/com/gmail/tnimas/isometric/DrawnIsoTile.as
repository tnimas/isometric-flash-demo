package com.gmail.tnimas.isometric
{
public class DrawnIsoTile extends IsoObject
	{
		protected var _height:Number;
		protected var _color:uint;

		public function DrawnIsoTile(size:Number, color:uint, height:Number = 0)
		{
			super(size);
			_color = color;
			_height = height;
			draw();
		}

		/**
		 * Рисуем плитку.
		 */
		protected function draw():void
		{
			graphics.clear();
			graphics.beginFill(_color);
			graphics.lineStyle(0, 0, .5);
			graphics.moveTo(-size, 0);
			graphics.lineTo(0, -size * .5);
			graphics.lineTo(size, 0);
			graphics.lineTo(0, size * .5);
			graphics.lineTo(-size, 0);
		}

		/**
		 * Сеттер/геттер высоты этого объекта. Не используется в этом классе, но может использоваться в подклассах.
		 */
		override public function set height(value:Number):void
		{
			_height = value;
			draw();
		}
		override public function get height():Number
		{
			return _height;
		}

		/**
		 * Сеттер/геттер цвета этой плитки.
		 */
		public function set color(value:uint):void
		{
			_color = value;
			draw();
		}
		public function get color():uint
		{
			return _color;
		}
	}
}