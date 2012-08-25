package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
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