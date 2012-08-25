package com.kylekellogg.ld24.model
{
	public class BackgroundModel
	{
		public var collections:Vector.<BackgroundCollectionModel>;
		
		public function BackgroundModel()
		{
			collections = new Vector.<BackgroundCollectionModel>();
		}
		
		public function add( collection:BackgroundCollectionModel ):void
		{
			collections.push( collection );
		}
	}
}