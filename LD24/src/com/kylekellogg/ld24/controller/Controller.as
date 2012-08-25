package com.kylekellogg.ld24.controller
{
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	public class Controller extends DisplayObjectContainer
	{
		public function Controller()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
	}
}