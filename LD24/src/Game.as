package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	import com.kylekellogg.ld24.controller.PlatformController;
	
	import starling.display.Sprite;

	public class Game extends Sprite
	{
		protected var _backgroundController:BackgroundController;
		protected var _platformController:PlatformController;
		
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
		}
	}
}