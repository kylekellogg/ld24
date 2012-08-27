package com.kylekellogg.ld24.model.background
{
	import com.kylekellogg.ld24.view.Background;
	
	import flash.display.Bitmap;

	public class BackgroundCollectionModel
	{
		public var id:int = 0;
		public var backgrounds:Vector.<Background>;
		public var current:Vector.<Background>;
		
		public function BackgroundCollectionModel()
		{
			backgrounds = new Vector.<Background>();
			current = new Vector.<Background>();
		}
		
		public function add( bmp:Bitmap ):void
		{
			var background:Background = new Background();
			background.image = bmp;
			backgrounds.push( background );
			
			current.push( background );
		}
		
		public function clone():BackgroundCollectionModel
		{
			var backgroundCollectionModel:BackgroundCollectionModel = new BackgroundCollectionModel();
			for ( var i:int = 0, l:int = backgrounds.length; i < l; i++ )
			{
				backgroundCollectionModel.add( backgrounds[i].image );
			}
			return backgroundCollectionModel;
		}
		
		public function randomize():void
		{
			var clone:Vector.<Background> = backgrounds.slice();
			current = new Vector.<Background>();
			while ( clone.length ) {
				current.push( clone.splice( Math.floor( Math.random() * clone.length ), 1 )[0] );
			}
		}
	}
}