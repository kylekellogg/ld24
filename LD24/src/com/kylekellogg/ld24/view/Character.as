package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.model.CharacterModel;
	
	import starling.display.Sprite;
	
	public class Character extends Sprite
	{
		public function Character()
		{
			super();
			CharacterModel.instance.character = this;
		}
	}
}