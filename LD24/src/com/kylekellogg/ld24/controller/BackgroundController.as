package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.events.CharacterEvent;
	import com.kylekellogg.ld24.model.CharacterModel;
	import com.kylekellogg.ld24.model.background.BackgroundCollectionModel;
	import com.kylekellogg.ld24.model.background.BackgroundModel;
	import com.kylekellogg.ld24.view.Background;
	
	import flash.utils.Dictionary;
	
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
			
			CharacterModel.instance.backgroundController = this;
			
			addEventListener( CharacterEvent.LEVEL_CHANGED, handleLevelChanged );
		}
		
		override protected function handleAddedToStage( e:Event ):void
		{
			super.handleAddedToStage( e );
			
			//	Initialize backgrounds
			_model.init();
			
			//	Set current
			_current = new Vector.<Background>();
			replace( _model.collections[0] );
			
			//	Handle enter frame
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		protected function handleLevelChanged( e:CharacterEvent ):void
		{
			var collection:BackgroundCollectionModel;
			
			switch( CharacterModel.instance.level )
			{
				case CharacterModel.COOLER:
					collection = _model.collections.slice()[0];
					_model.collections.splice( 0, 1, collection.next );
					break;
				case CharacterModel.MINI:
					collection = _model.collections.slice(1)[0];
					_model.collections.splice( 1, 1, collection.next );
					break;
				case CharacterModel.STANDARD:
					collection = _model.collections.slice(2)[0];
					_model.collections.splice( 2, 1, collection.next );
					break;
				case CharacterModel.DELUXE:
					collection = _model.collections.slice(3)[0];
					_model.collections.splice( 3, 1, collection.next );
					break;
				default:
					collection = _model.collections.slice()[0];
					_model.collections.splice( 0, 1, collection.next );
					break;
			}
			
			replace( clearDisposalFlags( collection ) );
		}
		
		protected function clearDisposalFlags( collection:BackgroundCollectionModel ):BackgroundCollectionModel
		{
			for ( var i:int = collection.backgrounds.length - 1; i > -1; i-- )
			{
				collection.backgrounds[i].flaggedForDisposal = false;
			}
			return collection;
		}
		
		public function replace( collection:BackgroundCollectionModel ):void
		{
			var i:int = 0;
			var oldLength:int = _current.length;
			var n:int = int.MAX_VALUE;
			
			for ( i = 0; i < oldLength; i++ ) 
			{
				if ( _current[i].x > stage.stageWidth )
				{
					n = i < n ? i : n;
					removeChild( _current[i] );
				}
				else
				{
					_current[i].flaggedForDisposal = true;
				}
			}
			
			_current = _current.slice( 0, n );
			oldLength = _current.length;
			_current = _current.concat( collection.backgrounds.slice() );
			
			var length:int = _current.length;
			
			for ( i = 0; i < length; i++ )
			{
				if ( i > 0 )
				{
					_current[i].x = _current[i-1].x + _current[i-1].width;
				}
				if ( !_current[i].flaggedForDisposal )
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
						removeChild( _current.splice( i, 1 )[0] );
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