package com.kylekellogg.ld24.model
{
	import flash.display.Bitmap;

	public class Assets
	{
		public static const instance:Assets = new Assets();
		
		[Embed(source='assets/blue.png')]
		protected var _Blue:Class;
		public var blue:Bitmap;
		
		[Embed(source='assets/green.png')]
		protected var _Green:Class;
		public var green:Bitmap;
		
		[Embed(source='assets/red.png')]
		protected var _Red:Class;
		public var red:Bitmap;
		
		public function Assets()
		{
			if ( instance )
				throw new Error( 'Assets already exists. Try grabbing it from Assets.instance.' );
			
			blue = new _Blue() as Bitmap;
			green = new _Green() as Bitmap;
			red = new _Red() as Bitmap;
		}
	}
}