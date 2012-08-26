package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.events.SoundEvent;
	import com.kylekellogg.ld24.model.Assets;
	
	import flash.media.Sound;
	
	import starling.events.EventDispatcher;
	
	public class SoundController extends EventDispatcher
	{
		//	IDs of sounds
		public static const MAIN_LOOP:int = 0;
		public static const JUMP:int = 1;
		
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
				case SoundController.JUMP:
					sound.play();
					break;
				default:
					sound.play( 0, int.MAX_VALUE );
					break;
			}
		}
	}
}