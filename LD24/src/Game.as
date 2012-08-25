package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	
	import starling.display.Sprite;

	public class Game extends Sprite
	{
		protected var _backgroundController:BackgroundController;
		
		public function Game()
		{
			super();
			
			init();
		}
		
		protected function init():void
		{
			_backgroundController = new BackgroundController();
			addChild( _backgroundController );
		}
	}
}