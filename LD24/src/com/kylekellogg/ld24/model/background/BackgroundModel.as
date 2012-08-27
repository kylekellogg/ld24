package com.kylekellogg.ld24.model.background
{
	import com.kylekellogg.ld24.model.Assets;

	public class BackgroundModel
	{
		public var collections:Vector.<BackgroundCollectionModel>;
		
		public function BackgroundModel()
		{
			collections = new Vector.<BackgroundCollectionModel>();
		}
		
		public function init():void
		{
			var col1:BackgroundCollectionModel = new BackgroundCollectionModel();
			col1.add( Assets.instance.bg11 );
			col1.add( Assets.instance.bg12 );
			col1.add( Assets.instance.bg13 );
			
			col1.next = col1.clone();
			col1.next.next = col1;
			
			var col2:BackgroundCollectionModel = new BackgroundCollectionModel();
			col2.add( Assets.instance.bg21 );
			col2.add( Assets.instance.bg22 );
			col2.add( Assets.instance.bg23 );
			
			col2.next = col2.clone();
			col2.next.next = col2;
			
			var col3:BackgroundCollectionModel = new BackgroundCollectionModel();
			col3.add( Assets.instance.bg31 );
			col3.add( Assets.instance.bg32 );
			col3.add( Assets.instance.bg33 );
			
			col3.next = col3.clone();
			col3.next.next = col3;
			
			var col4:BackgroundCollectionModel = new BackgroundCollectionModel();
			col4.add( Assets.instance.bg41 );
			col4.add( Assets.instance.bg42 );
			col4.add( Assets.instance.bg43 );
			col4.add( Assets.instance.bg44 );
			
			col4.next = col4.clone();
			col4.next.next = col4;
			
			collections.push( col1, col2, col3, col4 );
		}

	}
}