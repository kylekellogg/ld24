package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.model.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Bullet extends Sprite
	{
		protected var _image:Image;
		
		public function Bullet()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			image = new Image(Assets.instance.texture('ice_cube'));
			image.x = this.x;
			image.y = this.y;
			addChild(image);
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}

		public function get image():Image
		{
			return _image;
		}

		public function set image(value:Image):void
		{
			_image = value;
		}

	}
}