package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.model.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Platform extends Sprite
	{
		public static const LONG:int	= 3;
		public static const NORMAL:int	= 2;
		public static const SHORT:int	= 1;
		public static const BLOCK:int	= 0;
		
		public var flaggedForDisposal:Boolean = false;
		
		public function Platform( type:int )
		{
			super();
			if ( type > 3 || type < 0 )
				throw new Error( 'Way to specify a bogus platform type. Use the constants next time.' );
			
			for ( var i:int = 0; i < type; i++ )
			{
				var img:Image = Image.fromBitmap( Assets.instance.platform );
				img.x = i * 50;
				addChild( img );
			}
		}
	}
}