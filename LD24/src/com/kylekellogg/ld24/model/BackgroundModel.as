package com.kylekellogg.ld24.model
{
	public class BackgroundModel
	{
		public var collections:Vector.<BackgroundCollectionModel>;
		public var current:Vector.<BackgroundCollectionModel>;
		
		public function BackgroundModel()
		{
			collections = new Vector.<BackgroundCollectionModel>();
			current = new Vector.<BackgroundCollectionModel>();
		}
		
		public function init():void
		{
			var col1:BackgroundCollectionModel = new BackgroundCollectionModel();
			col1.add( Assets.instance.blue );
			col1.add( Assets.instance.green );
			col1.add( Assets.instance.red );
			collections.push( col1 );
		}
		
		public function randomize():void
		{
			var clone:Vector.<BackgroundCollectionModel> = collections.slice();
			current = new Vector.<BackgroundCollectionModel>();
			while ( clone.length ) {
				var cloned:BackgroundCollectionModel = clone.splice( Math.floor( Math.random() * clone.length ), 1 )[0];
				cloned.randomize();
				current.push( cloned );
			}
		}
	}
}