package com.client.project.navigation
{
	import com.greensock.TweenLite;
	import kish.control.button.KButton;
	import kish.core.control.NavigationManager;
	import kish.text.KText;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class MainNavButton extends KButton 
	{
		private var _txt:KText;
		
		public function MainNavButton( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
			build();
		}
		
		private function build():void
		{
			_txt = new KText( this, { alpha:.5 } );
			_txt.htmlText = String('<h2>').concat( _data.label ).concat('</h2>');
		}
		
		override protected function click():void
		{
			NavigationManager.instance.activeNode = _data;
		}
		
		override protected function setSelected():void
		{
			rollOver();
			enabled = false;
		}
		
		override protected function setUnselected():void
		{
			enabled = true;
			rollOut();
		}
		
		override protected function rollOver():void
		{
			if( !enabled ) return;
			TweenLite.to( _txt, .5, { alpha:1 } );
		}
		
		override protected function rollOut():void
		{
			if( !enabled ) return;
			TweenLite.to( _txt, .5, { alpha:.5 } );
		}
	
	}
}
