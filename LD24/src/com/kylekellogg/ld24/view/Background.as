package com.kylekellogg.ld24.view
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Background extends Sprite
	{
		public var flaggedForDisposal:Boolean = false;
		
		public function Background()
		{
			super();
		}
		
		public function set image( bmp:Bitmap ):void
		{
			removeChildren();
			addChild( Image.fromBitmap( bmp ) );
		}
	}
}