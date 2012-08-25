package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	import com.kylekellogg.ld24.controller.PlatformController;
	import com.kylekellogg.ld24.view.Floor;
	
	import starling.display.Sprite;

	public class Game extends Sprite
	{
		protected var _backgroundController:BackgroundController;
		protected var _platformController:PlatformController;
		
		protected var _floor:Floor;
		
		public function Game()
		{
			super();
			
			init();
		}
		
		protected function init():void
		{
			_backgroundController = new BackgroundController();
			addChild( _backgroundController );
			
			_platformController = new PlatformController();
			addChild( _platformController );
			
			_floor = new Floor();
			_floor.x = 0;
			_floor.y = 590;
			addChild( _floor );
		}
	}
}