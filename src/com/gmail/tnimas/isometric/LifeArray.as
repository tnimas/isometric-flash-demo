package com.gmail.tnimas.isometric
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public  class LifeArray extends Sprite
	{
		private var A:Array; //массив объектов
		public var lifeMap:Sprite; //будем ставить из этого класса живые объекты на карту
		

		private var a_star:AStar;
		private var W:Array; //ссылка на world объекты, необходимо для корректного отображения
		//участвуют в перерисовке
		
		public function LifeArray(map:Sprite,worldObjects:Array,aStar:AStar)
		{
			A = new Array();
			W = worldObjects;
			lifeMap = map;
			a_star = aStar;
			
		
			
		}

		
		public function ObjectMove(ID:String,endX:int,endY:int):Boolean {
			var L:LifeObject = getByID(ID);
			if (L == null) return false;
			L.beginMove(a_star,endX,endY);
			return true;
		}
		

		public function DelByID(ID:String):Boolean{
		for (var i:int=0; i<A.length; i++) {
			if (A[i].ID == ID) { 
				lifeMap.removeChild(A[i]);
				A.splice(i,1);
				return true;
			}
		}
		return false;
		}
		

		
		public function getByID(ID:String):LifeObject{
			for (var i:int=0; i<A.length; i++) {
			if (A[i].ID == ID)  
				return A[i] as LifeObject;
			}
			return null;
		}
		

		public function setByElem(L_Object:LifeObject,Sort:Boolean=true):Boolean {
		 for (var i:int=0; i<A.length; i++) {
			if (A[i].ID == L_Object.ID) {  
				A[i] = L_Object;
				if (Sort) sort();
				return true; 
			}		
		 }
		return false;
		}
		
		public function Add(L_Object:LifeObject,Sort:Boolean=true):void {
		A.push(L_Object);
		lifeMap.addChild(L_Object);
		if (Sort) sort();
		}
		
		public function DelLast():void {
		if (A.length > 0) {
			lifeMap.removeChild(A[A.length-1]);
			A.pop();
			}
		}
		
		public function getByMap(point:Point):LifeObject {
			for (var i:int = 0; i<A.length; i++) {
			if (point.x == A[i].xM && point.y == A[i].yM ) 
				return A[i] as LifeObject; 
			}
			return null;
		}
		
		public function ObjectsIsMove():Boolean {
			for (var i:int = 0; i<A.length; i++) {
			if (A[i].goMove) return true; 
			}
			return false;
		}
		
		public function sort():void
		{
			var X:Array = W.concat(A); 
			X.sortOn("depth", Array.NUMERIC);
			for(var i:int = 0; i < X.length; i++)
			{
				lifeMap.setChildIndex(X[i], i);
			}

		}
		/*private function ArrGenerate():Array {
		var X:Array = new Array();
		for (var i:int = 0; i<A.length; i++) {
			if (A[i].goMove) {
				var x:int = A[i].xM;
				var y:int = A[i].yM;
				
			    if (WMap[x+1][y] != null) X.push(WMap[x+1][y]);
			    if (WMap[x-1][y] != null) X.push(WMap[x-1][y]);
			    if (WMap[x][y+1] != null) X.push(WMap[x][y+1]);
			    if (WMap[x][y-1] != null) X.push(WMap[x][y-1]);
			    if (WMap[x+1][y+1] != null) X.push(WMap[x+1][y+1]);
			    if (WMap[x+1][y-1] != null) X.push(WMap[x+1][y-1]);
			    if (WMap[x-1][y+1] != null) X.push(WMap[x-1][y+1]);
			    if (WMap[x-1][y-1] != null) X.push(WMap[x-1][y-1]);
				}
			}
		for (var i:int=0; i<WMap.length; i++){
			for (var j:int=0; j<WMap[0].length; j++) {
				if (WMap[i][j] != null) X.push(WMap[i][j]);
			}
		}
		for (i = 0; i<A.length; i++) { X.push(A[i]); }
			
			return X; 
		}*/
		
			

	}
}