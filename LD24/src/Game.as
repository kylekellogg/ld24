package
{
	import com.kylekellogg.ld24.controller.BackgroundController;
	import com.kylekellogg.ld24.controller.EnemyController;
	import com.kylekellogg.ld24.controller.PickupController;
	import com.kylekellogg.ld24.controller.PlatformController;
	import com.kylekellogg.ld24.controller.SoundController;
	import com.kylekellogg.ld24.controller.WeaponsController;
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.events.SoundEvent;
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.view.Character;
	import com.kylekellogg.ld24.view.Floor;
	
	import flash.ui.Keyboard;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class Game extends Sprite
	{
		public static const FLOOR_HEIGHT:int = 50;
		
		protected var _backgroundController:BackgroundController;
		protected var _platformController:PlatformController;
		protected var _pickupController:PickupController;
		protected var _soundController:SoundController;
		protected var _enemyController:EnemyController;
		
		protected var _floor:Floor;
		protected var _character:Character;
		protected var _beerLabel:TextField;
		
		protected var debugging:Boolean = true;
		private var _weaponsController:WeaponsController;
		
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
			
			_weaponsController = new WeaponsController();
			addChild( _weaponsController );
			
			_floor = new Floor();
			addChild( _floor );
			
			_pickupController = new PickupController( _platformController );
			addChild( _pickupController );
			
			_enemyController = new EnemyController();
			addChild( _enemyController );
			
			_soundController = new SoundController();
			//	Testing
			var evt:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			evt.id = SoundController.LOOP_PREFIX;
			_soundController.dispatchEvent( evt );
			
			addEventListener( SoundEvent.FIRE_SOUND, handleFireSound );
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
			
			_floor.x = 0;
			_floor.y = stage.stageHeight - Game.FLOOR_HEIGHT;
			
			_beerLabel = new TextField(200, 50, "Beer: " + CharacterModel.instance.beer, "Helvetica", 24, 0, true);
			_beerLabel.hAlign = HAlign.LEFT;
			_beerLabel.x = 20;
			addChild( _beerLabel );
			
			_character = new Character();
			_character.x = 25;
			_character.y = (stage.stageHeight - _character.height) - Game.FLOOR_HEIGHT + _character.offsets[CharacterModel.instance.level];
			addChild(_character);
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.addEventListener( KeyboardEvent.KEY_UP, handleKeyboardUp);
			addEventListener( Event.ENTER_FRAME, handleEnterFrame);
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			_beerLabel.text = "Beer: " + CharacterModel.instance.beer;
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
				case Keyboard.E:
					// Debugging only
					if (debugging) {
						CharacterModel.instance.evolve();
					}
					break;
				case Keyboard.W:
				case Keyboard.UP:
					if ( CharacterModel.instance.landed ) {
						CharacterModel.instance.jumping = true;
						CharacterModel.instance.landed = false;
						evt.id = SoundController.JUMP; 
						_soundController.dispatchEvent( evt );
					}
					break;
				case Keyboard.SPACE:
					CharacterModel.instance.shooting = true;
					evt.id = SoundController.SHOOT_ICE; 
					_soundController.dispatchEvent( evt );
					var cevt:CharacterEvent = new CharacterEvent( CharacterEvent.FIRE_BULLET );
					_weaponsController.dispatchEvent( cevt );
					break;
			}
		}
		
		protected function handleFireSound( e:SoundEvent ):void
		{
			_soundController.dispatchEvent( e.clone() );
		}
	}
}