package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.view.Bullet;
	import com.kylekellogg.ld24.view.Character;
	
	import flashx.textLayout.elements.BreakElement;
	
	import starling.events.Event;

	public class WeaponsController extends Controller
	{
		private static const MAX_BULLETS:int = 50;
		
		protected var _chamber:Vector.<Bullet>;
		protected var _fired:Vector.<Bullet>;
		
		public function WeaponsController()
		{
			super();
			addEventListener( CharacterEvent.FIRE_BULLET, handleFireBullet );
		}
		
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage( e );
			
			_chamber = new Vector.<Bullet>;
			_fired = new Vector.<Bullet>;
			
			for (var i:Number = 0; i < MAX_BULLETS; i++) {
				_chamber.push( new Bullet() );
			}
			
			addEventListener(Event.ENTER_FRAME, handleEnterFrame);
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			for (var i:int = _fired.length-1; i > -1; i--) {
				if (_fired[i].x >= stage.stageWidth) {
					_chamber.push( _fired.splice( i, 1 )[0] );
				}
			}
		}
		
		public function handleFireBullet( e:CharacterEvent ):void
		{
			var bullet:Bullet;
			bullet = _chamber.shift();
			
			var fridge:Character = CharacterModel.instance.character;
			var level:int = CharacterModel.instance.level;
			
			switch(level) {
				case CharacterModel.DELUXE:
				case CharacterModel.STANDARD:
				case CharacterModel.MINI:
				case CharacterModel.COOLER:
					bullet.x = fridge.gun.x;
					bullet.y = fridge.gun.y;
					break;
			}
			
			_fired.push( bullet );
			addChild(bullet);
		}
	}
}