package com.kylekellogg.ld24.controller
{
	import com.kylekellogg.ld24.model.BackgroundModel;

	public class BackgroundController
	{
		protected var _model:BackgroundModel;
		
		public function BackgroundController()
		{
		}
		
		public function init():void
		{
			if ( _model )
			{
				//	Initialize backgrounds
			}
		}
		
		public function set model( value:BackgroundModel ):void
		{
			_model = value;
		}
		public function get model():BackgroundModel
		{
			return _model;
		}
	}
}