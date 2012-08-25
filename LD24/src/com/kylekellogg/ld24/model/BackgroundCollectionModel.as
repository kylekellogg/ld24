package com.kylekellogg.ld24.model
{
	import com.kylekellogg.ld24.view.Background;

	public class BackgroundCollectionModel
	{
		public var id:int = 0;
		public var backgrounds:Vector.<Background>;
		
		public function BackgroundCollectionModel()
		{
			backgrounds = new Vector.<Background>();
		}
		
		public function add( background:Background ):void
		{
			backgrounds.push( background );
		}
	}
}