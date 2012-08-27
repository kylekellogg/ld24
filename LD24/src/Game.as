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
	import com.kylekellogg.ld24.model.Assets;
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.view.Character;
	import com.kylekellogg.ld24.view.Floor;
	import com.kylekellogg.ld24.view.Pickup;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundCodec;
	import flash.ui.Keyboard;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
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
		
		protected static const MAGNET_RANGE:int = 100 * 100;
		
		protected var _backgroundController:BackgroundController;
		protected var _pickupController:PickupController;
		protected var _soundController:SoundController;
		protected var _enemyController:EnemyController;
		protected var _weaponsController:WeaponsController;
		
		protected var _floor:Floor;
		protected var _character:Character;
		protected var _beerLabel:TextField;
		protected var _currentState:String;
		
		protected var debugging:Boolean = true;
		
		private static const MENU_STATE:String = "MenuState";
		private static const GAME_STATE:String = "GameState";
		private static const END_STATE:String = "EndState";
		
		public function Game()
		{
			super();
			_currentState = GAME_STATE;
			init();
		}
		
		protected function init():void
		{
			_backgroundController = new BackgroundController();
			addChild( _backgroundController );
			
			_weaponsController = new WeaponsController();
			addChild( _weaponsController );
			
			_floor = new Floor();
			addChild( _floor );
			
			_pickupController = new PickupController();
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
		
		private function menu_init():void
		{
			var menu:Image = Image.fromBitmap( Assets.instance.menuScreen );
			menu.x = 0;
			menu.y = 0;
			addChild( menu );
		}
		
		private function game_init():void
		{
			_floor.x = 0;
			_floor.y = stage.stageHeight - Game.FLOOR_HEIGHT;
			
			_beerLabel = new TextField(200, 50, "Beer: " + CharacterModel.instance.beer, "Helvetica", 24, 0xff0000, true);
			_beerLabel.hAlign = HAlign.LEFT;
			_beerLabel.x = 20;
			addChild( _beerLabel );
			
			_character = new Character();
			_character.x = 25;
			_character.y = (stage.stageHeight - _character.height) - Game.FLOOR_HEIGHT + _character.offsets[CharacterModel.instance.level];
			addChild(_character);
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, handleKeyboardDown);
			stage.addEventListener( KeyboardEvent.KEY_UP, handleKeyboardUp);
		}
		
		private function end_init():void
		{
			// TODO Auto Generated method stub
			
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
			
			switch(_currentState)
			{
				case MENU_STATE:
					menu_init();
					break;
				case GAME_STATE:
					game_init();
					break;
				case END_STATE:
					end_init();
					break;
			}
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame);
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			_beerLabel.text = "Beer: " + CharacterModel.instance.beer;
			
			var char_bounds:Rectangle = _character.getBounds( this );
			var char_center:Point = new Point( char_bounds.x + (char_bounds.width >> 1), char_bounds.y + (char_bounds.height >> 1) );
			var bullet_bounds:Rectangle;
			var enemy_bounds:Rectangle;
			var pickup_bounds:Rectangle;
			
			var hurt_sound:SoundEvent;
			
			for ( var i:int = _enemyController.enemies.length - 1; i > -1; i-- )
			{
				enemy_bounds = _enemyController.enemies[i].getBounds( this );
				
				if ( enemy_bounds.intersects( char_bounds ) )
				{
					_enemyController.kill( i );
					CharacterModel.instance.beer -= 10;
					hurt_sound = new SoundEvent( SoundEvent.FIRE_SOUND );
					hurt_sound.id = SoundController.HURT;
					_soundController.dispatchEvent( hurt_sound );
				}
				else
				{
					for ( var j:int = _weaponsController.fired.length - 1; j > -1; j-- )
					{
						bullet_bounds = _weaponsController.fired[j].getBounds( this );
						if ( bullet_bounds.intersects( enemy_bounds ) )
						{
							_weaponsController.destroy( j );
							_enemyController.kill( i );
							var kill_sound:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
							kill_sound.id = SoundController.EXPLOSION;
							_soundController.dispatchEvent( kill_sound );
						}
					}
				}
			}
			
			var pickup_center:Point;
			var distanceX:Number;
			var distanceY:Number;
			for ( i = _pickupController.pickups.length - 1; i > -1; i-- )
			{
				pickup_bounds = _pickupController.pickups[i].getBounds( this );
				if ( CharacterModel.instance.state == CharacterModel.MAGNET )
				{
					pickup_center = new Point( pickup_bounds.x + (pickup_bounds.width >> 1), pickup_bounds.y + (pickup_bounds.height >> 1) );
					distanceX = char_center.x - pickup_center.x;
					distanceY = char_center.y - char_center.y;
					if ( ( distanceX*distanceX + distanceY*distanceY ) <= MAGNET_RANGE )
					{
						var pickup:Pickup = _pickupController.pickups.splice( i, 1 )[0];
						var tween:Tween = new Tween( pickup, 0.1, 'linear' );
						tween.animate( 'x', _character.x );
						tween.animate( 'y', _character.y );
						tween.onComplete = recycleMagnetPickup;
						tween.onCompleteArgs = [ pickup ];
						Starling.juggler.add( tween );
					}
				}
				else if ( pickup_bounds.intersects( char_bounds ) )
				{
					if ( _pickupController.pickups[i].type == Pickup.KEG_MAGNET )
					{
						CharacterModel.instance.state = CharacterModel.MAGNET;
					}
					recyclePickup( i );
				}
			}
		}
		
		protected function recycleMagnetPickup( pickup:Pickup ):void
		{
			CharacterModel.instance.beer += pickup.beer;
			var pickup_sound:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			pickup_sound.id = SoundController.PICKUP;
			_soundController.dispatchEvent( pickup_sound );
			
			_pickupController.removeChild( pickup );
			pickup.type = _pickupController.getNewTypeFromFamily( pickup.family );
			_pickupController.add( pickup );
		}
		
		protected function recyclePickup( index:int ):void
		{
			CharacterModel.instance.beer += _pickupController.pickups[index].beer;
			_pickupController.recycle( index );
			var pickup_sound:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			pickup_sound.id = SoundController.PICKUP;
			_soundController.dispatchEvent( pickup_sound );
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