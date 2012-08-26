package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.view.Pickup;
	import com.kylekellogg.ld24.view.Platform;
	
	import starling.events.Event;

	public class PickupController extends Controller
	{
		protected var _platformController:PlatformController;
		protected var _platforms:Vector.<Platform>;
		protected var _pickups:Vector.<Pickup>;
		protected var _canOffset:int = 5;
		
		public function PickupController( platformController:PlatformController )
		{
			super();
			_platformController = platformController;
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
					var pickup:Pickup = _pickups.splice( i, 1 )[0];
					removeChild( pickup );
					var type:int = Pickup.CAN;
					var random:Number = Math.random();
					switch ( pickup.family )
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
					addPickups( 1, pickup.type );
				}
			}
		}
		
		protected function addPickups( num:int, type:int ):void
		{
			var lastPos:int = 0;
			for ( var i:int = 0; i < num; i++ )
			{
				var pickup:Pickup = new Pickup( type );
				lastPos = addToPlatform( pickup, lastPos );
			}
		}
		
		protected function addToPlatform( pickup:Pickup, from:uint = 0 ):int
		{
			_platforms = _platformController.platforms;
			var random:Number = Math.floor( Math.random() * _platforms.length + from );
			var n:int = 0;
			for ( var i:int = random, l:int = random + _platforms.length; i < l; i++ )
			{
				n = i;
				if ( i >= _platforms.length )
					n -= _platforms.length;
				
				if ( !_platforms[n].hasPickup && _platforms[n].x >= stage.stageWidth )
				{
					_platforms[n].hasPickup = true;
					_pickups.push( pickup );
					var platformWidthMinusPickupWidth:Number = _platforms[n].width - pickup.width
					pickup.x = _platforms[n].x + ((Math.random() * platformWidthMinusPickupWidth + pickup.width) - pickup.width);
					pickup.y = (pickup.family == Pickup.FAMILY_CANS ? stage.stageHeight - Game.FLOOR_HEIGHT + _canOffset : _platforms[n].y) - pickup.height;
					addChild( pickup );
					return n;
				}
			}
			return 0;
		}
	}
}