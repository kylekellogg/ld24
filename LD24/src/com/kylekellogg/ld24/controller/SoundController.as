package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.events.SoundEvent;
	import com.kylekellogg.ld24.model.Assets;
	
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	public class SoundController extends EventDispatcher
	{
		//	IDs of sounds
		public static const LOOP_PREFIX:int = 0;
		public static const MAIN_LOOP:int = 1;
		public static const JUMP:int = 2;
		public static const SHOOT_ICE:int = 3;
		public static var EXPLOSION:int = 4;
		public static var PICKUP:int = 5;
		public static var HURT:int = 6;
		public static var MENU_LOOP:int = 7;
		
		protected var _active:Vector.<SoundChannel>;
		
		public function SoundController()
		{
			super();
			
			_active = new Vector.<SoundChannel>();
			
			addEventListener( SoundEvent.FIRE_SOUND, handleFireSound );
		}
		
		protected function handleFireSound( e:SoundEvent ):void
		{
			//	Route & play sounds here
			var sound:Sound = Assets.instance.sounds[ e.id ];
			var throwaway:SoundChannel;
			
			//	Logic depending on id
			switch ( e.id )
			{
				case SoundController.EXPLOSION:
				case SoundController.PICKUP:
				case SoundController.SHOOT_ICE:
				case SoundController.HURT:
				case SoundController.JUMP:
					throwaway = sound.play();
					throwaway.addEventListener( flash.events.Event.SOUND_COMPLETE, handleRemove );
					break;
				case SoundController.MENU_LOOP:
				case SoundController.MAIN_LOOP:
					throwaway = sound.play( 0, int.MAX_VALUE );
					throwaway.addEventListener( flash.events.Event.SOUND_COMPLETE, handleRemove );
					break;
				case SoundController.LOOP_PREFIX:
					sound.addEventListener(flash.events.Event.COMPLETE, handlePrefixComplete);
					throwaway = sound.play();
					throwaway.addEventListener( flash.events.Event.SOUND_COMPLETE, handlePrefixComplete );
			}
			
			_active.push( throwaway );
		}
		
		public function stop():void
		{
			for ( var i:int = _active.length - 1; i > -1; i-- )
			{
				_active.splice( i, 1 )[0].stop();
			}
		}
		
		protected function handlePrefixComplete( e:flash.events.Event ):void
		{
			var evt:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			evt.id = SoundController.MAIN_LOOP;
			dispatchEvent( evt );
		}
		
		protected function handleRemove( e:flash.events.Event ):void
		{
			var channel:SoundChannel = e.target as SoundChannel;
			for ( var i:int = _active.length - 1; i > -1; i-- )
			{
				if ( channel == _active[i] )
				{
					channel.stop();
					_active.splice( i, 1 );
					return;
				}
			}
		}
	}
}