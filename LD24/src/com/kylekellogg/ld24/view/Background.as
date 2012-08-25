package com.kylekellogg.ld24.view
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Background extends Sprite
	{
		protected var _image:Image;
		
		public function Background()
		{
			super();
			
			_image = new Image( new Texture() );
			addChild( _image );
		}
		
		public function set image( bmp:Bitmap ):void
		{
			_image = Image.fromBitmap( bmp );
		}
	}
}