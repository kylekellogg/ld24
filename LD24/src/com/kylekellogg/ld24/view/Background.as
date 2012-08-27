package com.kylekellogg.ld24.view
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Background extends Sprite
	{
		public var flaggedForDisposal:Boolean = false;
		
		protected var _image:Bitmap;
		
		public function Background()
		{
			super();
		}
		
		public function set image( bmp:Bitmap ):void
		{
			removeChildren();
			_image = bmp;
			addChild( Image.fromBitmap( _image ) );
		}
		public function get image():Bitmap
		{
			return _image;
		}
	}
}