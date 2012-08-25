package com.kylekellogg.ld24.model.platform
{
	import com.kylekellogg.ld24.view.Platform;

	public class PlatformModel
	{
		public var platforms:Vector.<Platform>;
		
		public function PlatformModel()
		{
			platforms = new Vector.<Platform>();
			generate( 10 );
		}
		
		public function generate( num:uint ):int
		{
			var length:int = platforms.length;
			
			if ( num == 0 )
				return length == 0 ? 0 : length-1;
			
			for ( var i:int = 0; i < num; i++ )
			{
				var random:Number = Math.random();
				if ( random < 0.875 )
				{
					if ( random > 0.125 )
					{
						if ( random < 0.25 || random > 0.75 )
						{
							platforms.push( new Platform( Platform.SHORT ) );
						}
						else
						{
							platforms.push( new Platform( Platform.NORMAL ) );
						}
					}
					else
					{
						platforms.push( new Platform( Platform.BLOCK ) );
					}
				}
				else
				{
					platforms.push( new Platform( Platform.LONG ) );
				}
			}
			
			return length;
		}
	}
}