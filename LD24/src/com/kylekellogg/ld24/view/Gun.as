package com.kylekellogg.ld24.view
{
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Gun extends Sprite
	{
		public function Gun()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			trace("Gets here");
		}
		
		public function fire():void
		{
			var bullet:Bullet = new Bullet();
			bullet.x = this.x;
			bullet.y = this.y;
			addChild(bullet);
		}
	}
}