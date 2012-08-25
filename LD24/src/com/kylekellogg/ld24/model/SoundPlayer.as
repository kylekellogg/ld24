package com.kylekellogg.ld24.model
{
	import flash.net.URLRequest;

	public class SoundPlayer
	{
		private var _files:Array;
		private var _clips:Vector.<URLRequest>
		
		public function SoundPlayer()
		{
			// Big ol' array of clip paths
			_files = ['assets/snd/explosion.mp3', 'assets/snd/jump.mp3',
					  'assets/snd/main_loop_prefix.mp3', 'assets/snd/main_loop.mp3',
					  'assets/snd/pickup.mp3', 'assets/snd/player_damage.mp3',
					  'assets/snd/powerup.mp3', 'assets/snd/shoot_ice.mp3'];
			_clips = new Vector.<URLRequest>;
		}
		
		public function init():void
		{
			// Load up all known sounds
			for each (var i:int in _files) 
			{
				var req:URLRequest = new URLRequest(_files[i]);
				// Save them for later
				_clips.push(req);
			}
		}
	}
}