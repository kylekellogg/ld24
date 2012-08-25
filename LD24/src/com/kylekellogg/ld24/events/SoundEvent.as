package com.kylekellogg.ld24.events
{
	import flash.media.Sound;
	
	import starling.events.Event;
	
	public class SoundEvent extends Event
	{
		public static const FIRE_SOUND:String = 'SoundEventFireSound';
		
		public var id:int = 0;
		
		
		public function SoundEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
		
		public function clone():SoundEvent
		{
			var evt:SoundEvent = new SoundEvent( this.type, this.bubbles, this.data );
			evt.id = this.id;
			return evt;
		}
	}
}