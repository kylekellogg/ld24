package com.kylekellogg.ld24.events
{
	import starling.events.Event;
	
	public class CharacterEvent extends Event
	{
		public static const STATE_CHANGED:String = 'CharacterEventStateChanged';
		public static const LEVEL_CHANGED:String = 'CharacterEventLevelChanged';
		public static const FIRE_BULLET:String = 'CharacterEventFireBullet';
		public static const DIED:String = 'CharacterEventDied';
		
		public function CharacterEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}