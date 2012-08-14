package com.gmail.tnimas.isometric
{
	import flash.geom.Point;
	
	public class Point3D
	{
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public function Point3D(x:Number = 0, y:Number = 0, z:Number = 0)
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		public function get getMap():Point {
		return new Point(
		Math.round(this.x/IsoUtils.WORLD_C),
		Math.round(this.z/IsoUtils.WORLD_C) );
		}
		public function set setMap(value:Point):void {
		this.x = value.x*IsoUtils.WORLD_C;
		
		this.z = value.y*IsoUtils.WORLD_C; 
		}

	}
}