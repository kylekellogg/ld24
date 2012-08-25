package com.kylekellogg.ld24.model
{
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

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
		
		[Embed(source='assets/platform.png')]
		protected var _Platform:Class;
		public var platform:Bitmap;
		
		[Embed(source='assets/spritesheet.xml', mimeType='application/octet-stream')]
		protected var _SpritesheetData:Class;
		
		[Embed(source='assets/spritesheet.png')]
		protected var _Spritesheet:Class;
		
		protected var _atlas:TextureAtlas;
		
		public function Assets()
		{
			if ( instance )
				throw new Error( 'Assets already exists. Try grabbing it from Assets.instance.' );
			
			blue = new _Blue() as Bitmap;
			green = new _Green() as Bitmap;
			red = new _Red() as Bitmap;
			
			platform = new _Platform() as Bitmap;
			
			_atlas = new TextureAtlas( Texture.fromBitmap( new _Spritesheet() as Bitmap ), XML( new _SpritesheetData() ) );
		}
		
		public function texture( name:String ):Texture
		{
			return _atlas.getTexture( name );
		}
		
		public function textures( name:String ):Vector.<Texture>
		{
			return _atlas.getTextures( name );
		}
	}
}