package com.kylekellogg.ld24.model
{
	import com.kylekellogg.ld24.controller.SoundController;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
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
		
		[Embed(source='assets/snd/main_loop.mp3')]
		protected var _MainLoop:Class;
		public var mainLoop:Sound;
		
		[Embed(source='assets/snd/jump.mp3')]
		protected var _Jump:Class;
		public var jump:Sound;
		
		[Embed(source='assets/snd/shoot_ice.mp3')]
		protected var _ShootIce:Class;
		public var shootIce:Sound;
		
		public var sounds:Dictionary;
		
		protected var _cached:Dictionary;
		
		public function Assets()
		{
			if ( instance )
				throw new Error( 'Assets already exists. Try grabbing it from Assets.instance.' );
			
			blue = new _Blue() as Bitmap;
			green = new _Green() as Bitmap;
			red = new _Red() as Bitmap;
			
			platform = new _Platform() as Bitmap;
			
			_atlas = new TextureAtlas( Texture.fromBitmap( new _Spritesheet() as Bitmap ), XML( new _SpritesheetData() ) );
			
			mainLoop = new _MainLoop() as Sound;
			jump = new _Jump() as Sound;
			shootIce = new _ShootIce() as Sound;
			
			sounds = new Dictionary();
			sounds[ SoundController.MAIN_LOOP ] = mainLoop;
			sounds[ SoundController.JUMP ] = jump;
			
			_cached = new Dictionary();
		}
		
		public function texture( name:String ):Texture
		{
			if ( _cached[ name ] )
				return _cached[ name ];
			
			_cached[ name ] = _atlas.getTexture( name );
			return _cached[ name ];
		}
		
		public function textures( prefix:String ):Vector.<Texture>
		{
			if ( _cached[ prefix ] )
				return _cached[ prefix ];
			
			_cached[ prefix ] = _atlas.getTextures( prefix );
			return _cached[ prefix ];
		}
	}
}