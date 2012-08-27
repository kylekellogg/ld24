package com.kylekellogg.ld24.model.background
{
	import com.kylekellogg.ld24.view.Background;
	
	import flash.display.Bitmap;

	public class BackgroundCollectionModel
	{
		public var id:int = 0;
		public var backgrounds:Vector.<Background>;
		
		public var next:BackgroundCollectionModel;
		
		public function BackgroundCollectionModel()
		{
			backgrounds = new Vector.<Background>();
		}
		
		public function add( bmp:Bitmap ):void
		{
			var background:Background = new Background();
			background.image = bmp;
			backgrounds.push( background );
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
	}
}