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
		
		public function SoundController()
		{
			super();
			
			addEventListener( SoundEvent.FIRE_SOUND, handleFireSound );
		}
		
		protected function handleFireSound( e:SoundEvent ):void
		{
			//	Route & play sounds here
			var sound:Sound = Assets.instance.sounds[ e.id ];
			
			//	Logic depending on id
			switch ( e.id )
			{
				case SoundController.SHOOT_ICE:
				case SoundController.JUMP:
					sound.play();
					break;
				case SoundController.MAIN_LOOP:
					sound.play( 0, int.MAX_VALUE );
					break;
				case SoundController.LOOP_PREFIX:
					sound.addEventListener(flash.events.Event.COMPLETE, handlePrefixComplete);
					var throwaway:SoundChannel = sound.play();
					throwaway.addEventListener( flash.events.Event.SOUND_COMPLETE, handlePrefixComplete );
			}
		}
		
		protected function handlePrefixComplete( e:flash.events.Event ):void
		{
			var evt:SoundEvent = new SoundEvent( SoundEvent.FIRE_SOUND );
			evt.id = SoundController.MAIN_LOOP;
			dispatchEvent( evt );
		}
	}
}