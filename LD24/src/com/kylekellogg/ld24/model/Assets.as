package com.kylekellogg.ld24.model
{
	import com.kylekellogg.ld24.controller.SoundManager;
	
	import flash.display.Bitmap;
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
		
		[Embed(source='assets/snd/main_loop.mp3')]
		protected var _MainLoop:Class;
		public var mainLoop:Sound;
		
		public var sounds:Dictionary;
		
		public function Assets()
		{
			if ( instance )
				throw new Error( 'Assets already exists. Try grabbing it from Assets.instance.' );
			
			blue = new _Blue() as Bitmap;
			green = new _Green() as Bitmap;
			red = new _Red() as Bitmap;
			
			mainLoop = new _MainLoop() as Sound;
			
			sounds = new Dictionary();
			sounds[ SoundManager.MAIN_LOOP ] = mainLoop;
		}
	}
}