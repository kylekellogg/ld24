package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.model.BackgroundCollectionModel;
	import com.kylekellogg.ld24.model.BackgroundModel;
	import com.kylekellogg.ld24.view.Background;
	
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;

	public class BackgroundController extends Controller
	{
		protected var _model:BackgroundModel;
		protected var _current:Vector.<Background>;
		
		public function BackgroundController()
		{
			super();
			_model = new BackgroundModel();
		}
		
		override protected function handleAddedToStage( e:Event ):void
		{
			super.handleAddedToStage( e );
			
			//	Initialize backgrounds
			_model.init();
			
			//	Mix them up?
			_model.randomize();
			
			//	Set current
			_current = new Vector.<Background>();
			replace( _model.current[0] );
			
			//	Handle enter frame
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		public function replace( collection:BackgroundCollectionModel ):void
		{
			var i:int = 0;
			var oldLength:int = _current.length;
			
			_current = _current.concat( collection.current );
			
			var length:int = _current.length;
			
			for ( i = 0; i < length; i++ )
			{
				if ( i < oldLength )
					_current[i].flaggedForDisposal = true;
				
				if ( i > 0 )
				{
					_current[i].x = _current[i-1].x + _current[i-1].width;
				}
				addChild( _current[i] );
			}
			
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			var speed:int = 5;
			for ( var i:int = _current.length-1; i > -1; i-- )
			{
				_current[i].x = Math.floor( _current[i].x - speed );
				if ( _current[i].x <= -_current[i].width )
				{
					if ( _current[i].flaggedForDisposal )
					{
						_current.splice( i, 1 );
					}
					else
					{
						_current[i].x = _current[_current.length-1].x + _current[_current.length-1].width;
						_current.push( _current.splice( i, 1 )[0] );
					}
				}
			}
		}
	}
}