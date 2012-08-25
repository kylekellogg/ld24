package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.model.Assets;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.events.Event;
	
	public class Floor extends DisplayObjectContainer
	{
		public function Floor()
		{
			super();
			
			addEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, handleAddedToStage );
			
			for ( var i:int = 0, l:int = stage.stageWidth/50; i < l; i++ )
			{
				var img:Image = Image.fromBitmap( Assets.instance.platform );
				img.x = i * 50;
				img.height = 10;
				addChild( img );
			}
		}
	}
}