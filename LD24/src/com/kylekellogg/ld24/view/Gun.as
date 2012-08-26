package com.kylekellogg.ld24.view
{
	import flash.geom.Point;
	
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
		}
		
		public function fire():void
		{
			var bullet:Bullet = new Bullet();
			var point:Point = globalToLocal( new Point( this.parent.x, this.parent.y ) );
			bullet.x = point.x;
			bullet.y = point.y;
			addChild(bullet);
		}
	}
}