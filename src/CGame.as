package {
	import com.gmail.tnimas.isometric.IsoUtils;
	import com.gmail.tnimas.isometric.IsoWorld;
	import com.gmail.tnimas.isometric.LifeArray;
	import com.gmail.tnimas.isometric.LifeObject;
	import com.gmail.tnimas.isometric.MapLoader;
	import com.gmail.tnimas.isometric.Point3D;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	[SWF(backgroundColor="0xddffff", width="823", height="700")]
	public class CGame extends Sprite
	{
		[Embed(source="pole.png")]
		private var Tile01:Class; //текстура плитки
		[Embed(source="dom.png")]
		private var Tile02:Class; //текстура блока
		[Embed(source="b.png")]
		private var Tile03:Class; //текстура блока
		
		public static const WORLD_C:int = 40; //размер плиток, менять уже нежелательно
		
		private var hero_ID:String = "1"; //ид героя, в будущем будет получаться при логине из бд
		
		private var _world:IsoWorld;		
		private var mapLoader:MapLoader; 
		//private var box:DrawnIsoBox; //игрок
		
		private var hero:LifeObject;
		private var lifeArr:LifeArray;;
		
		

	
		
		
		public function CGame()
		{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			/*stage.showDefaultContextMenu = false; // убирает опции типа приблизить-удалить из щелка правой кнопкой */
			mapLoader = new MapLoader(); //грузим карту из текстового файла в массивы внутри класса
			mapLoader.addEventListener(Event.COMPLETE, onMapComplete);
			mapLoader.loadMap("map.txt");
			
		}
			
		private function onMapComplete(event:Event):void
		{
			
			_world = mapLoader.makeWorld(WORLD_C); //на основе загруженных данных строим визуальный мир
			//и заносим карту препятствий в a_map
			//a_map = _world.MapWalk(mapLoader.mapZoom.x,mapLoader.mapZoom.y);
			
			//for (var i:int=0; i<a_map.length;i++)
			//for (var j:int=0; j<a_map.length;j++)
			//trace("map: i = "+i+" j = "+j+" : "+a_map[i][j]); 
			
			_world.x = stage.stageWidth / 2;
			_world.y = 100;
			
			addChild(_world); //отображаем мир
			
			//box = new DrawnIsoBox(40,0xffffff,34);
			hero = new LifeObject(40,Tile02,40,60,hero_ID);
			hero.position = new Point3D(200,0,200);
			//бага флеша не обновляет начальные координаты заданные от карты, приходится так ставить (ссуко)
			
			lifeArr = new LifeArray(_world.ObjectsMap,_world.ObjectsW,_world.aStar);
			lifeArr.Add(hero);
			
		 	 //создаем и помещаем игрока на экран
		 	var enemy:LifeObject = new LifeObject(40,Tile02,40,60,"100");
			enemy.position = new Point3D(160,0,160);
			lifeArr.Add(enemy);
		 	

			
			stage.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent):void
        {
        	
        	if  ((hero.x % WORLD_C != 0) || (hero.z % WORLD_C != 0)) return;
        	//если во время движения будет нажатие -
			//герой уедет за границу экрана или вылезет ошибка 
        	//_world.addChildToWorld(hero);
        	var p:Point = IsoUtils.screenToIso(new Point(_world.mouseX, _world.mouseY)).getMap;
			lifeArr.ObjectMove(hero_ID,p.x,p.y);

			
        }

		private function onEnterFrame(event:Event):void
		{

			if (lifeArr.ObjectsIsMove() ) {lifeArr.sort();}
					
		} 

	}
}
