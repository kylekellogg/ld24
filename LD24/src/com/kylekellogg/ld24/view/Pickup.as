package com.kylekellogg.ld24.view
{
	import com.kylekellogg.ld24.model.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Pickup extends Sprite
	{
		public static const CAN:int = 0;
		public static const BOTTLE_AMERICAN:int = 1;
		public static const BOTTLE_BAD:int = 2;
		public static const BOTTLE_MEXICAN:int = 3;
		public static const SIXPACK:int = 4;
		public static const KEG_FIRERATE:int = 5;
		public static const KEG_HEALTH:int = 6;
		public static const KEG_MAGNET:int = 7;
		
		public static const FAMILY_CANS:int = 8;
		public static const FAMILY_BOTTLES:int = 9;
		public static const FAMILY_SIXPACK:int = 10;
		public static const FAMILY_KEG:int = 11;
		
		protected var _pickups:Vector.<String>;
		
		public var type:int;
		public var family:int;
		
		public function Pickup( id:int )
		{
			if ( id < 0 || id > 7 )
				throw new Error( 'Try a good ID for the Pickup, next time.' );
			
			type = id;
			family = type < 5 ? type < 4 ? type < 1 ? Pickup.FAMILY_CANS : Pickup.FAMILY_BOTTLES : Pickup.FAMILY_SIXPACK : Pickup.FAMILY_KEG;
			
			_pickups = new Vector.<String>();
			_pickups.push( 'beer_can', 'beer_bottle_american', 'beer_bottle_bad', 'beer_bottle_mexican', 'beer_six_pack', 'firepower_keg', 'health_keg', 'magnet_keg' );
			
			var texture:Texture = Assets.instance.texture( _pickups[ id ] );
			addChild( new Image( texture ) );
		}
	}
}