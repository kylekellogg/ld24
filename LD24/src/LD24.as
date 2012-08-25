package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width="800",height="600",frameRate="60")]
	public class LD24 extends Sprite
	{
		protected var _starling:Starling;
		
		public function LD24()
		{
			_starling = new Starling( Game, stage );
			_starling.start();
		}
	}
}