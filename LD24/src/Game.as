package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	import com.kylekellogg.ld24.controller.PlatformController;
	import com.kylekellogg.ld24.controller.SoundController;
	import com.kylekellogg.ld24.events.SoundEvent;
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.view.Character;
	import com.kylekellogg.ld24.view.Floor;
	
	import flash.ui.Keyboard;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;

	public class Game extends Sprite
	{
		protected var _backgroundController:BackgroundController;
		protected var _platformController:PlatformController;
		protected var _soundController:SoundController;
		
		protected var _floor:Floor;
		protected var _character:Character;
		
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
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
			
			_character = new Character();
			_character.x = 25;
			_character.y = (stage.stageHeight - _character.height) - ( _floor.height >> 1);
			addChild(_character);
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.addEventListener( KeyboardEvent.KEY_UP, handleKeyboardUp);
		}
		
		protected function handleKeyboardUp( e:KeyboardEvent ):void
		{
			switch( e.keyCode )
			{
				case Keyboard.SPACE:
					CharacterModel.instance.shooting = false;
					break;
			}
		}
		
		protected function handleKeyboardDown( e:KeyboardEvent ):void
		{
			var evt:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			switch( e.keyCode ) {
				case Keyboard.SPACE:
					CharacterModel.instance.shooting = true;
						evt.id = SoundController.SHOOT_ICE; 
						_soundController.dispatchEvent( evt );
						// Don't break so that we can shoot and jump at the same time
				case Keyboard.W:
				case Keyboard.UP:
					if ( CharacterModel.instance.landed ) {
						CharacterModel.instance.jumping = true;
						CharacterModel.instance.landed = false;
						evt.id = SoundController.JUMP; 
						_soundController.dispatchEvent( evt );
					}
					break;
			}
		}
		
		protected function handleFireSound( e:SoundEvent ):void
		{
			_soundController.dispatchEvent( e.clone() );
		}
	}
}