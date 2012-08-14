package com.gmail.tnimas.isometric
{	import flash.geom.Point;

	public class IsoUtils
	{
		// более точное значение 1.2247...
		public static const Y_CORRECT:Number = Math.cos(-Math.PI / 6) * Math.SQRT2;
		public static const WORLD_C:int = 40;


		/**
		 * Из трехмерного пространства в двухмерное.
		 * @arg pos точка трехмерного пространства.
		 */
		public static function isoToScreen(pos:Point3D):Point
		{
			var screenX:Number = pos.x - pos.z;
			var screenY:Number = pos.y * Y_CORRECT + (pos.x + pos.z) * .5;
			return new Point(screenX, screenY);
		}

		/**
		 * Из двухмерного пространства в трехмерное, высота у равна нулю.
		 * @arg point точка в двухмерном пространстве.
		 */
		public static function screenToIso(point:Point):Point3D
		{
			var xpos:Number = point.y + point.x * .5;
			var ypos:Number = 0;
			var zpos:Number = point.y - point.x * .5;
			return new Point3D(xpos, ypos, zpos);
		}
		/** 
		 * Из трехмерного пространства в координаты карты
		 */
		public static function isoToMap(point3D:Point3D):Point
		{
			var xmap:int = Math.round(point3D.x / WORLD_C); 
			var ymap:int = Math.round(point3D.z / WORLD_C);
			return new Point(xmap,ymap);
		} 
		
		/** 
		 * Из координат карты в 3D
		 */
		public static function mapToIso(point:Point):Point3D
		{
			var xpos:int = point.x * WORLD_C; 
			var ypos:int = 0;
			var zpos:int = point.y * WORLD_C;
			return new Point3D(xpos,ypos,zpos);
		} 
		
		private static var _p:Point = new Point();
		private static var _o:Point = new Point();
		public static var speed:int = 5;
		public static var speed1:int = 5;
		
		public static function speedInstall(isoObject:IsoObject,targetInMap:Point):void {
			

		
			_p.x = targetInMap.x; 
			_p.y = targetInMap.y;
			_o.x = isoObject.xM
			_o.y = isoObject.yM;
			
		if ( (_p.x != _o.x) || (_p.y != _o.y) ) { 
		
		if (_p.x > _o.x && _p.y == _o.y) isoObject.vx =  speed else
		if (_p.x < _o.x && _p.y == _o.y) isoObject.vx = -speed else
		if (_p.y > _o.y && _p.x == _o.x) isoObject.vz =  speed else 
		if (_p.y < _o.y && _p.x == _o.x) isoObject.vz = -speed else 
		//двигаем обе координаты
		if (_p.x > _o.x && _p.y > _o.y) { isoObject.vx =  speed1; isoObject.vz =  speed1; } else
		if (_p.x < _o.x && _p.y > _o.y) { isoObject.vx = -speed1; isoObject.vz =  speed1; } else
		if (_p.x > _o.x && _p.y < _o.y) { isoObject.vx =  speed1; isoObject.vz = -speed1; } else
		if (_p.x < _o.x && _p.y < _o.y) { isoObject.vx = -speed1; isoObject.vz = -speed1; }
	
		}
		}
	}
}