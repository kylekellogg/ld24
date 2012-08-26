package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.controller.SoundController;
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.events.SoundEvent;
	import com.kylekellogg.ld24.model.Assets;
	import com.kylekellogg.ld24.model.CharacterModel;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Character extends Sprite
	{
		private var _image:Image;
		private var _vel:Number = 10;
		
		private var MAX_JUMP_HEIGHT:Number;
		
		protected var _closed:Image;
		protected var _open:Image;
		
		protected var _gun:Point;
		
		private static const COOLER_OPEN:String = "cooler_open";
		private static const COOLER_CLOSED:String = "cooler_closed";
		private static const MINI_OPEN:String = "mini_open";
		private static const MINI_CLOSED:String = "mini_closed";
		private static const STANDARD_OPEN:String = "standard_open";
		private static const STANDARD_CLOSED:String = "standard_closed";
		private static const DELUXE:String = "deluxe";
		
		private var hasEvolved:Boolean = false;
		private var gunOffsetY:Number = 40;
		
		public function Character()
		{
			super();
			CharacterModel.instance.character = this;
			
			setNewCharacterStates(COOLER_OPEN, COOLER_CLOSED);
			addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
		}
		
		protected function handleAddedToStage( e:Event ):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			addEventListener(CharacterEvent.LEVEL_CHANGED, handleLevelChange);
			
			MAX_JUMP_HEIGHT = stage.stageHeight - (this.height * 2.5)
			var gunx:Number = (this.x + (this.width >> 1)) + 20;
			var guny:Number = (this.y + (this.height >> 1)) - 20;
			gun = new Point(x, y);
		}
		
		protected function handleLevelChange( e:CharacterEvent ):void
		{
			switch(CharacterModel.instance.level) {
				case CharacterModel.DELUXE:
					gunOffsetY = 0;
					setNewCharacterStates(null, DELUXE);
					break;
				case CharacterModel.STANDARD:
					setNewCharacterStates(STANDARD_OPEN, STANDARD_CLOSED);
					gunOffsetY = 60;
					break;
				case CharacterModel.MINI:
					gunOffsetY = 20;
					setNewCharacterStates(MINI_OPEN, MINI_CLOSED);
					break;
				case CharacterModel.COOLER:
					gunOffsetY = 40;
					setNewCharacterStates(COOLER_OPEN, COOLER_CLOSED);
					break;
				default:
					break;
			}
			
			MAX_JUMP_HEIGHT = stage.stageHeight - (this.height * 2.5)
			hasEvolved = true;
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			if ( hasEvolved ) {
				this.y = (stage.stageHeight - this.height) - 50;
				hasEvolved = false;
			}
			
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
					if ( this.y < (stage.stageHeight - this.height) - 50) {
						this.y += _vel;
					} else if ( this.y >= (stage.stageHeight - this.height) - 50 ) {
						this.y = (stage.stageHeight - this.height) - 50;
						CharacterModel.instance.landed = true;
					}
				}
			}
			
			// For Shooting
			if ( CharacterModel.instance.shooting ) {
				image = _open;
			} else {
				image = _closed;
			}
			
			gun.x = (this.x + (this.width >> 1)) + 10;
			gun.y = (this.y + (this.height >> 1)) - gunOffsetY;
		}
		
		protected function setNewCharacterStates(open:String, closed:String):void
		{
			if (_open)
				_open.dispose();
			if (_closed)
				_closed.dispose();
			
			if ( open == null ) {
				_open = _closed = new Image(Assets.instance.texture(closed));
			} else {
				_open = new Image(Assets.instance.texture(open));
				_closed = new Image(Assets.instance.texture(closed));
			}
			
			image = _closed;
		}
		
		public function get image():Image
		{
			return _image;
		}

		public function set image(value:Image):void
		{
			removeChild(_image);
			_image = value;
			addChild(_image);
		}

		public function get gun():Point
		{
			return _gun;
		}

		public function set gun(value:Point):void
		{
			_gun = value;
		}

	}
}