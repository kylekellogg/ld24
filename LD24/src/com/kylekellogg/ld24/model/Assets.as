package com.kylekellogg.ld24.model
{
	import com.kylekellogg.ld24.controller.SoundController;
	
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

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
			sounds[ SoundController.SHOOT_ICE ] = shootIce;
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