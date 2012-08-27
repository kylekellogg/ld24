package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.model.Assets;
	import com.kylekellogg.ld24.model.enemy.EnemyModel;
	import com.kylekellogg.ld24.view.Enemy;
	
	import flash.utils.Dictionary;
	
	import starling.events.Event;

	public class EnemyController extends Controller
	{
		protected var _model:EnemyModel;
		protected var _prefixes:Vector.<String>;
		
		public function EnemyController()
		{
			super();
			
			_model = new EnemyModel();
			_prefixes = new Vector.<String>();
			_prefixes.push( 'toaster', 'blender', 'stove' );
		}
		
		override protected function handleAddedToStage(e:Event):void
		{
			super.handleAddedToStage( e );
			
			add( 10 );
			
			addEventListener( Event.ENTER_FRAME, handleEnterFrame );
		}
		
		public function add( num:int ):void
		{
			for ( var i:int = 0; i < num; i++ )
			{
				var enemy:Enemy = new Enemy( Assets.instance.textures( _prefixes[ Math.floor( Math.random() * _prefixes.length ) ] ) );
				enemy.x = stage.stageWidth + enemy.width + Math.floor( Math.random() * 4000 );
				enemy.y = stage.stageHeight - enemy.height - Game.FLOOR_HEIGHT;
				addChild( enemy );
				_model.enemies.push( enemy );
			}
		}
		
		protected function handleEnterFrame( e:Event ):void
		{
			var speed:int = 5;
			for ( var i:int = _model.enemies.length-1; i > -1; i-- )
			{
				_model.enemies[i].x -= speed;
				if ( _model.enemies[i].x < -_model.enemies[i].width )
				{
					_model.enemies[i].x = stage.stageWidth + _model.enemies[i].width + Math.floor( Math.random() * 4000 );
					_model.enemies.push( _model.enemies.splice( i, 1 )[0] );
				}
			}
		}
	}
}