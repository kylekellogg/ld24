package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.view.Bullet;
	import com.kylekellogg.ld24.view.Character;
	
	import flashx.textLayout.elements.BreakElement;

	public class WeaponsController extends Controller
	{
		private static const MAX_BULLETS:int = 10;
		
		protected var _bullets:Vector.<Bullet>;
		
		public function WeaponsController()
		{
			super();
			_bullets = new Vector.<Bullet>;
			addEventListener( CharacterEvent.FIRE_BULLET, handleFireBullet);
		}
		
		public function handleFireBullet( e:CharacterEvent ):void
		{
			var bullet:Bullet;
			
			if ( _bullets.length < MAX_BULLETS ) {
				bullet = new Bullet();
			} else {
				bullet = _bullets.pop();
			}
			
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
			
			_bullets.push( bullet );
			addChild(bullet);
		}
	}
}