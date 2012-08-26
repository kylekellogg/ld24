package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.controller.SoundController;
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.events.SoundEvent;
	import com.kylekellogg.ld24.model.Assets;
	import com.kylekellogg.ld24.model.CharacterModel;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Character extends Sprite
	{
		private var _image:Image;
		private var _vel:Number = 5;
		
		public function Character()
		{
			super();
			CharacterModel.instance.character = this;
			image = new Image(Assets.instance.texture('cooler_closed'));
			addChild(image);
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			addEventListener(CharacterEvent.LEVEL_CHANGED, handleLevelChange);
		}
		
		protected function handleLevelChange( e:CharacterEvent ):void
		{
			switch(CharacterModel.instance.level) {
				case CharacterModel.COOLER:
				default:
					break;
			}
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			if ( CharacterModel.instance.jumping ) 
			{
				if ( this.y > (stage.stageHeight - (this.height * 2))) {
					this.y -= _vel;
				} else {
					CharacterModel.instance.jumping = false; 
				}
			} else {
				if ( !CharacterModel.instance.landed ) {
					if ( this.y < 475 ) {
						this.y += _vel;
					} else if ( this.y == 475 ) {
						CharacterModel.instance.landed = true;
					}
				}
			}
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