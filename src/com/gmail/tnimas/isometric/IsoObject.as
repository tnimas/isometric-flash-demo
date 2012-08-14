package com.gmail.tnimas.isometric
{
import flash.display.Sprite;
import flash.geom.Point;
import flash.geom.Rectangle;

	public class IsoObject extends Sprite
	{
		protected var _position:Point3D;
		protected var _size:Number;
		protected var _walkable:Boolean = false;
		protected var _vx:Number = 0;
		protected var _vy:Number = 0;
		protected var _vz:Number = 0;

	
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

		public function IsoObject(size:Number)
		{
			_size = size;
			_position = new Point3D();
			updateScreenPosition();
		}

		/**
		 * Преобразование трехмерной позиции объекта в двухмерную
		 * и его размещение на экране.
		 */
		protected function updateScreenPosition():void
		{
			var screenPos:Point = IsoUtils.isoToScreen(_position);
			super.x = screenPos.x;
			super.y = screenPos.y;
		}

		/**
		 * Строковое представление объекта.
		 */
		override public function toString():String
		{
			return "[IsoObject (x:" + _position.x + ", y:" + _position.y + ", z:" + _position.z + ")]";
		}

		/**
		 * Сеттер/геттер координаты х в трехмерном пространстве.
		 */
		override public function set x(value:Number):void
		{
			_position.x = value;
			updateScreenPosition();
		}
		override public function get x():Number
		{
			return _position.x;
		}

		/**
		 * Сеттер/геттер координаты у в трехмерном пространстве.
		 */
		override public function set y(value:Number):void
		{
			_position.y = value;
			updateScreenPosition();
		}
		override public function get y():Number
		{
			return _position.y;
		}

		/**
		 * Сеттер/геттер координаты z в трехмерном пространстве.
		 */
		 override public function set z(value:Number):void
		{
			_position.z = value;
			updateScreenPosition();
		}
		 override public function get z():Number
		{
			return _position.z;
		}

		/**
		 * Сеттер/геттер позиции в трехмерном пространстве как экземпляра Point3D.
		 */
		public function set position(value:Point3D):void
		{
			_position = value;
			updateScreenPosition();
		}
		public function get position():Point3D
		{
			return _position;
		}

		/**
		 * Возвращает глубину объекта.
		 */
		public function get depth():Number
		{
			return (_position.x + _position.z) * .866 - _position.y * .707;
		}

		/**
		 * Указывает, может ли место, занятое этим объектом, быть занято другим объектом.
		 */
		public function set walkable(value:Boolean):void
		{
			_walkable = value;
		}
		public function get walkable():Boolean
		{
			return _walkable;
		}

		/**
		 * Возвращает размер объекта
		 */
		public function get size():Number
		{
			return _size;
		}

		/**
		 * Возвращает квадратную область на x-z плоскости, которую занимает этот объект.
		 */
		public function get rect():Rectangle
		{
			return new Rectangle(x - size / 2, z - size / 2, size, size);
		}

		/**
		 * Сеттер/геттер скорости по оси х.
		 */
		public function set vx(value:Number):void
		{
			_vx = value;
		}
		public function get vx():Number
		{
			return _vx;
		}

		/**
		 * Сеттер/геттер скорости по оси у.
		 */
		public function set vy(value:Number):void
		{
			_vy = value;
		}
		public function get vy():Number
		{
			return _vy;
		}

		/**
		 * Сеттер/геттер скорости по оси z.
		 */
		public function set vz(value:Number):void
		{
			_vz = value;
		}
		public function get vz():Number
		{
			return _vz;
		}
		/**
		 * координаты объекта относительно плиток
		 */

	 	public function get xM():int
		{
			return Math.round(x/IsoUtils.WORLD_C);
		}

		public function get yM():int
		{
			return Math.round(z/IsoUtils.WORLD_C);
		}
	}
}