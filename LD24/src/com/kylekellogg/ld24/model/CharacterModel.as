package com.kylekellogg.ld24.model
{
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.view.Character;
	
	import starling.events.EventDispatcher;

	public class CharacterModel extends EventDispatcher
	{
		public static const instance:CharacterModel = new CharacterModel();
		
		//	Powerup states
		public static const DEFAULT:int = 0;
		public static const DOUBLE_FIRE_RATE:int = 1;
		public static const MAGNET:int = 2;
		
		//	Character level states
		public static const COOLER:int = 0;
		public static const MINI:int = 1;
		public static const STANDARD:int = 2;
		public static const DELUXE:int = 3;
		
		public var character:Character;
		
		protected var _beer:Number = 0;
		protected var _level:int = CharacterModel.COOLER;
		protected var _state:int = CharacterModel.DEFAULT;
		
		protected var _jumping:Boolean = false;;
		protected var _landed:Boolean = true;
		private var _shooting:Boolean;
		
		public function CharacterModel()
		{
			if ( instance )
				throw new Error( 'CharacterModel already instantiated. Get it from CharacterModel.instance instead.' );
		}

		public function get level():int
		{
			return _level;
		}

		public function set level(value:int):void
		{
			_level = value;
			
			var evt:CharacterEvent = new CharacterEvent( CharacterEvent.LEVEL_CHANGED );
			if ( character )
			{
				character.dispatchEvent( evt );
			}
			else
			{
				dispatchEvent( evt );
			}
		}

		public function get state():int
		{
			return _state;
		}

		public function set state(value:int):void
		{
			_state = value;
			
			var evt:CharacterEvent = new CharacterEvent( CharacterEvent.STATE_CHANGED );
			if ( character )
			{
				character.dispatchEvent( evt );
			}
			else
			{
				dispatchEvent( evt );
			}
		}

		public function get beer():Number
		{
			return _beer;
		}

		public function set beer(value:Number):void
		{
			var oldBeer:Number = _beer;
			_beer = value;
			
			if ( _beer >= 600 && this.level != CharacterModel.DELUXE )
			{
				this.level = CharacterModel.DELUXE;
			}
			else if ( _beer >= 300 && this.level != CharacterModel.STANDARD )
			{
				this.level = CharacterModel.STANDARD;
			}
			else if ( _beer >= 100 && this.level != CharacterModel.MINI )
			{
				this.level = CharacterModel.MINI;
			}
			else if ( this.level != CharacterModel.COOLER )
			{
				this.level = CharacterModel.COOLER;
			}
			else if ( this.level == CharacterModel.COOLER && (oldBeer == 0 && _beer == 0) )
			{
				var evt:CharacterEvent = new CharacterEvent( CharacterEvent.DIED );
				if ( character )
				{
					character.dispatchEvent( evt );
				}
				else
				{
					dispatchEvent( evt );
				}
			}
		}

		public function get jumping():Boolean
		{
			return _jumping;
		}

		public function set jumping(value:Boolean):void
		{
			_jumping = value;
		}

		public function get landed():Boolean
		{
			return _landed;
		}

		public function set landed(value:Boolean):void
		{
			_landed = value;
		}

		public function get shooting():Boolean
		{
			return _shooting;
		}

		public function set shooting(value:Boolean):void
		{
			_shooting = value;
		}


	}
}