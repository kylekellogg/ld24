package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	import com.kylekellogg.ld24.model.BackgroundModel;
	
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		protected var _backgroundModel:BackgroundModel;
		protected var _backgroundController:BackgroundController;
		
		public function Game()
		{
			super();
			
			init();
		}
		
		protected function init():void
		{
			_backgroundModel = new BackgroundModel();
			_backgroundController = new BackgroundController();
			_backgroundController.model = _backgroundModel;
			_backgroundController.init();
		}
	}
}