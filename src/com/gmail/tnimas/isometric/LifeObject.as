package com.gmail.tnimas.isometric
{
	import flash.events.Event;
	import flash.geom.Point;
										
	public class LifeObject extends GraphicTile
	{
		/**
		 * Предполагается, что сервер будет посылать вместе с описанием объекта последнюю точку маршрута, если он есть.
		 * Вместе с этим сервер будет отправлять координаты объекта.
		 * Соответственно клиент будет отправлять конечную точку маршрута персонажа серверу.
		 * Если сервер точку, не соответствующую текущей, то в клиенте меняются координаты объекта
		 * и формируется новый путь.*/
		private var _ID:String; //уникальный идентификатор 
		private var array_p:Array = []; //путь объекта с обходом
		private var _shag:int = 1;    //шаг обхода
		private var _endP:Point = new Point(-1,-1); //последняя точка маршрута.
		private var _nowP:Point3D = new Point3D(); //текущий путь относительно карты
		private var _aStar:AStar;
		private var _goMove:Boolean = false; //для координации enterframe и текущего класса
		//конструктор, отправляющий данные о изображении и резмере (WORLD_C = size) предку.		 
		
		
		public function LifeObject(size:Number, classRef:Class, xoffset:Number, yoffset:Number,ID:String=null):void
		{
			if (ID != null)
				this._ID = ID;
			else {
				var __int:int = 15600700+Math.random()*15600700;
				this._ID = __int.toString(); 
			} //предполагается что значение будет всегда
			//задаваться, но если оно не задано будет сгенерировано число от 15 до 30 млн.
			super(size,classRef,xoffset,yoffset);
		}
		
		public function get ID():String {
			return _ID;
		}
		public function get end_p():Point { return _endP; }
		public function set end_p(value:Point):void { _endP = value; }
		public function get goMove():Boolean { return this._goMove; }
		//функция движения объекта по конечной координате
		
		public function beginMove(aStar:AStar,endX:int,endY:int):void{
		end_p.x = endX;
		end_p.y = endY;		
				
		if (_aStar == null) aStarInit(aStar); 
		else _aStar = aStar;
		
		_aStar.findPath(super.xM,super.yM,_endP.x,_endP.y);
			
		}
		
		private function aStarInit(aStar:AStar):void {
		_aStar = aStar;
		_aStar.addEventListener(Event.COMPLETE,onStarComplete);
		_aStar.addEventListener(_aStar.ERROR,onStarError); //ошибки обхода пути
		}
		
		private function onStarComplete(e:Event):void {
		array_p = _aStar.getPath();
		if (array_p.length == 0) return;
		_shag = 1;
		_goMove = true; //отслеживаем наличие движения объекта
		Next();
		}
		private function onStarError(e:Event):void {
		trace("Объект "+this.ID+_aStar.lastError);
		}
		
		public function Next():void {
		
		if (super.xM == _endP.x && super.yM == _endP.y ) 
		{_goMove = false; return;} //не кончился ли путь
		
			_nowP.setMap =  new Point(array_p[_shag]._x,_nowP.y = array_p[_shag]._y);
			//установили ближайшую координату пути
			IsoUtils.speedInstall(this,_nowP.getMap);
			//задали направление движения
			addEventListener(Event.ENTER_FRAME, onEnterFrame);	
				
		}
		
		private function onEnterFrame(e:Event):void {
		
		super.x = super.x + super.vx;
		super.z = super.z + super.vz;
		
		
		if ( (super.x == _nowP.x) && (super.z == _nowP.z) )
				{
					super.vx = 0;
			    	super.vz = 0;
					_shag++; //шаг пройден, переходим к следующему
					removeEventListener(Event.ENTER_FRAME, onEnterFrame);	
					Next();
				}
		}
		


		
		
		
		
	}
}