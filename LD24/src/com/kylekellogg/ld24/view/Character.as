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
		private var _vel:Number = 10;
		
		private var MAX_JUMP_HEIGHT:Number;
		
		
		public function Character()
		{
			super();
			CharacterModel.instance.character = this;
			
			image = new Image(Assets.instance.texture('cooler_closed'));
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			addEventListener(CharacterEvent.LEVEL_CHANGED, handleLevelChange);
			
			MAX_JUMP_HEIGHT = stage.stageHeight - (this.height * 2)
				
			var gun:Gun = new Gun();
			gun.x = this.x + ( this.width >> 1 ) + 10;
			gun.y = this.y - ( this.height >> 1 ) + 10;
			addChild(gun);
			CharacterModel.instance.gun = gun;
			
		}
		
		protected function handleLevelChange( e:CharacterEvent ):void
		{
			switch(CharacterModel.instance.level) {
				case CharacterModel.COOLER:
					image = new Image(Assets.instance.texture('cooler_closed'));
				default:
					break;
			}
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			// For Jumping
			if ( CharacterModel.instance.jumping ) 
			{
				if ( Math.floor(this.y) > MAX_JUMP_HEIGHT) {
					var dy:Number = this.y - MAX_JUMP_HEIGHT;
					var vy:Number = dy * 0.2;
					this.y -= vy;
				} else {
					CharacterModel.instance.jumping = false; 
					this.y = MAX_JUMP_HEIGHT;
				}
			} else {
				if ( !CharacterModel.instance.landed ) {
					if ( this.y < 475 ) {
						this.y += _vel;
					} else if ( this.y >= 475 ) {
						this.y = 475;
						CharacterModel.instance.landed = true;
					}
				}
			}
			
			// For Shooting
			if ( CharacterModel.instance.shooting ) {
				image = new Image(Assets.instance.texture('cooler_open'));
				CharacterModel.instance.gun.fire();
			} else {
				image = new Image(Assets.instance.texture('cooler_closed'));
			}
		}
		
		public function get image():Image
		{
			return _image;
		}

		public function set image(value:Image):void
		{
			removeChild(_image);
			_image = value;
			_image.alpha = 0.05;
			addChild(_image);
		}

	}
}