package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	import com.kylekellogg.ld24.controller.PlatformController;
	import com.kylekellogg.ld24.view.Floor;
	import com.kylekellogg.ld24.controller.SoundController;
	import com.kylekellogg.ld24.events.SoundEvent;
	
	import starling.display.Sprite;

	public class Game extends Sprite
	{
		protected var _backgroundController:BackgroundController;
		protected var _platformController:PlatformController;
		protected var _soundController:SoundController;
		
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
			
			_soundController = new SoundController();
			//	Testing
			var evt:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			evt.id = SoundController.MAIN_LOOP;
			_soundController.dispatchEvent( evt );
			
			addEventListener( SoundEvent.FIRE_SOUND, handleFireSound );
		}
		
		protected function handleFireSound( e:SoundEvent ):void
		{
			_soundController.dispatchEvent( e.clone() );
		}
	}
}