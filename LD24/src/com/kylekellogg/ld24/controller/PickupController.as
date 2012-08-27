package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.view.Pickup;
	import com.kylekellogg.ld24.view.Platform;
	
	import starling.events.Event;

	public class PickupController extends Controller
	{
		protected var _pickups:Vector.<Pickup>;
		protected var _canOffset:int = 5;
		
		public function PickupController()
		{
			super();
			_pickups = new Vector.<Pickup>();
		}
		
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage( e );
			
			var bottleRandom:Number = Math.random();
			var kegRandom:Number = Math.random();
			addPickups( 1, Pickup.CAN );
			addPickups( 1, bottleRandom > 0.33 ? bottleRandom > 0.66 ? Pickup.BOTTLE_AMERICAN : Pickup.BOTTLE_BAD : Pickup.BOTTLE_MEXICAN );
			addPickups( 1, Pickup.SIXPACK );
			addPickups( 1, kegRandom > 0.33 ? kegRandom > 0.66 ? Pickup.KEG_FIRERATE : Pickup.KEG_HEALTH : Pickup.KEG_MAGNET );
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			var speed:int = 5;
			for ( var i:int = _pickups.length-1; i > -1; i-- )
			{
				_pickups[i].x -= speed;
				if ( _pickups[i].x < -_pickups[i].width )
				{
					recycle( i );
				}
			}
		}
		
		public function recycle( index:int ):void
		{
			var pickup:Pickup = _pickups.splice( index, 1 )[0];
			removeChild( pickup );
			var type:int = getNewTypeFromFamily( pickup.family );
			addPickups( 1, type );
		}
		
		public function getNewTypeFromFamily( family:int ):int
		{
			var type:int = Pickup.CAN;
			var random:Number = Math.random();
			switch ( family )
			{
				case Pickup.FAMILY_CANS:
					break;
				case Pickup.FAMILY_BOTTLES:
					type = random > 0.33 ? random > 0.66 ? Pickup.BOTTLE_AMERICAN : Pickup.BOTTLE_BAD : Pickup.BOTTLE_MEXICAN;
					break;
				case Pickup.FAMILY_SIXPACK:
					type = Pickup.SIXPACK
					break;
				case Pickup.FAMILY_KEG:
					type = random > 0.33 ? random > 0.66 ? Pickup.KEG_MAGNET : Pickup.KEG_HEALTH : Pickup.KEG_FIRERATE;
					break;
			}
			return type;
		}
		
		protected function addPickups( num:int, type:int ):void
		{
			for ( var i:int = 0; i < num; i++ )
			{
				add( new Pickup( type ) );
			}
		}
		
		public function add( pickup:Pickup ):void
		{
			if ( _pickups.length )
				pickup.x = _pickups[ _pickups.length - 1 ].x + _pickups[ _pickups.length - 1 ].width + Math.floor( Math.random() * 400 + 400 );
			else
				pickup.x = stage.stageWidth + pickup.width + Math.floor( Math.random() * 400 + 400 );
			pickup.y = stage.stageHeight - (Math.random() * (CharacterModel.instance.character.height >> 1) + (CharacterModel.instance.character.height * 2));
			addChild( pickup );
			_pickups.push( pickup );
		}

		public function get pickups():Vector.<Pickup>
		{
			return _pickups;
		}

		public function set pickups(value:Vector.<Pickup>):void
		{
			_pickups = value;
		}

	}
}