package com.kylekellogg.ld24.events
{
	import starling.events.Event;
	
	public class PickupEvent extends Event
	{
		public function PickupEvent(type:String, bubbles:Boolean=false, data:Object=null)
		{
			super(type, bubbles, data);
		}
	}
}