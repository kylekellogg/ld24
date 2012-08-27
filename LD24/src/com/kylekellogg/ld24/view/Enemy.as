package com.kylekellogg.ld24.view
{
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	
	public class Enemy extends MovieClip
	{
		public function Enemy(textures:Vector.<Texture>, fps:Number=6)
		{
			super(textures, fps);
			Starling.juggler.add( this );
		}
	}
}