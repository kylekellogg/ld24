package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.model.platform.PlatformModel;
	
	import starling.events.Event;

	public class PlatformController extends Controller
	{
		protected var _model:PlatformModel;
		
		public function PlatformController()
		{
			super();
		}
		
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage( e );
			
			_model = new PlatformModel();
			updatePositionsFrom( 0 );
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			var speed:int = 5;
			for ( var i:int = _model.platforms.length-1; i > -1; i-- )
			{
				_model.platforms[i].x -= speed;
				if ( _model.platforms[i].x < -_model.platforms[i].width )
				{
					_model.platforms.splice( i, 1 );
					updatePositionsFrom( _model.generate( 1 ) );
				}
			}
		}
		
		protected function updatePositionsFrom( pos:int ):void
		{
			for ( var i:int = pos, l:int = _model.platforms.length; i < l; i++ )
			{
				var separator:uint = 10;
				if ( i > 0 )
				{
					var start:int = _model.platforms[i-1].x + _model.platforms[i-1].width;
					var diff:int = start % 50;
					if ( diff > 0 )
						start -= diff;
					separator = Math.floor(start / 50) + 1;
				}
				_model.platforms[i].x = Math.floor( Math.random() * 15 + separator ) * 50;
				_model.platforms[i].y = stage.stageHeight + (Math.floor( Math.random() * 10 + 1 ) * -50 + 25);	//	Offset by 25 b/c we halved platform height
				addChild( _model.platforms[i] );
			}
		}
	}
}