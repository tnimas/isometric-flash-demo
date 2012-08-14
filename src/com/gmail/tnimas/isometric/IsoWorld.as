package com.gmail.tnimas.isometric
{
	import flash.display.Sprite;
	import flash.geom.Point;

	public class IsoWorld extends Sprite
	{
		private var floorMap:Sprite;
		private var worldMap:Sprite;
		private var F:Array; //плитки
		private var W:Array; //объекты имеющие высоту
		
		//private var WMap:Array;;//2д массив, хранящий ссылки на объекты по координатам карты
		//нужен для оптимизиации сортировки
		
		private var mapWalk:Array //карта проходимости для алгоритма поиска пути
		private var a_star:AStar; //компонент для обсчета пути

		private var xMap:int; //размеры карты по х и у
		private var zMap:int;
		
		
		public function IsoWorld()
		{
			floorMap = new Sprite();
			addChild(floorMap);
			
			worldMap = new Sprite();
			addChild(worldMap);
			
			F = new Array();
			W = new Array();
			
			//WMap = new Array();
			//WMap[0] = new Array();
			
			mapWalk = new Array();
			a_star = new AStar();
			a_star.clippingType = a_star.P; // тип обхода http://savepic.ru/898236.jpg
		}
		public function Installed(x:int,z:int):void{
		
		a_star.setObstacleMap(MapWalk(x,z)); //задаем карту препятствий и ставим слушатель на метод findpath 
		sort();
		}
		
		
		
		public function get ObjectsMap():Sprite{
			return worldMap;
		}
		public function get ObjectsW():Array {
			// return WMap;
			return W;
		}

		
		public function get aStar():AStar{
			return a_star;
		}
		

		public function addToFloor(child:IsoObject):void
		{
			floorMap.addChild(child);
			F.push(child);	
		}
		public function addToWorld(child:IsoObject,Sort:Boolean=true):void
		{
			worldMap.addChild(child);
			W.push(child);	
			//addToMap(child);
			if (Sort) sort(); 
		}
		
		
		public function DelLastFloor():Boolean {
			if (F.length == 0) return false; 
			floorMap.removeChild( F[F.length-1]  );
			F.pop();
			return true;
		}
		public function DelLastWorld():Boolean {
			if (W.length == 0) return false; 
			worldMap.removeChild( W[W.length-1]  );
			//removeToMap(W[W.length-1]);
			W.pop();
			return true;
		}
		
		//удаление объекта на координате point в формате координат карты
		public function DelByMap(mPoint:Point):Boolean {
		 	for (var i:int=0; i<F.length; i++){
		 		if (F[i].xM == mPoint.x && F[i].yM == mPoint.y) {
		 			floorMap.removeChild(F[i]);
		 			
					F.splice(i,1);
					return true;
		 		}  
		 	}
		 	for (i=0; i<W.length; i++){
		 		if (W[i].xM == mPoint.x && W[i].yM == mPoint.y) {
		 			worldMap.removeChild(W[i]);
		 			
					W.splice(i,1);
					return true;
		 		}  
		 	}
		 	return false;

		}
		//вовзращаем карту проходимости
		public function MapWalk(xCount:int,yCount:int):Array {
		mapWalk = [];
		for (var i:int=0; i<xCount+1; i++){
			mapWalk[i] = [];
			for (var j:int=0; j<yCount+1;j++) {
				mapWalk[i][j] = true;
				}
			}
		for (i=0; i<W.length; i++){
			if (W[i].walkable) 
				mapWalk[W[i].xM][W[i].yM] = false;
			
			}
		for (i=0; i<F.length; i++){
			if (F[i].walkable) 
				mapWalk[F[i].xM][F[i].yM] = false;
			
			}	
		return mapWalk;	 
		}
		
		public function sort():void
		{
			W.sortOn("depth", Array.NUMERIC);
			for(var i:int = 0; i < W.length; i++)
			{
				
				worldMap.setChildIndex(W[i], i);
			}
		}
		private function addToMap(l:IsoObject):void {
		// if (l.yM == WMap[0].length) WMap[l.yM] = [];
		// WMap[l.xM][l.yM] = l;
		}
		private function removeToMap(l:IsoObject):void {
		//	WMap[l.xM][l.yM] = null;
		}

		

	/*	public function canMove(obj:IsoObject):Boolean
		{
			var rect:Rectangle = obj.rect;
			rect.offset(obj.vx, obj.vz);
			for(var i:int = 0; i < _objects.length; i++)
			{
				var objB:IsoObject = _objects[i] as IsoObject;
				if(obj != objB && !objB.walkable && rect.intersects(objB.rect))
				{
					return false;
				}
			}
			return true;
		} */
	}
}