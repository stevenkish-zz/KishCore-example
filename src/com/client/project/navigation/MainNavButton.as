package com.client.project.navigation
{
	import com.greensock.TweenLite;
	import com.kish.control.button.KButton;
	import com.kish.core.control.NavigationManager;
	import com.kish.display.Draw;
	import com.kish.text.KText;

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
			show();
		}
		
		private function build():void
		{
			Draw.rect(graphics);
			_txt = new KText( this, { alpha:.5 } );
			_txt.htmlText = String('<h2>').concat( _data.label ).concat('</h2>');
		}
		
		public function show():void
		{
			visible = true;
			TweenLite.to( this, .5, { alpha:1 } );
		}
	
		public function hide():void
		{
			visible = false;
		}
		
		override protected function click():void
		{
			NavigationManager.instance.activeNode = NavigationManager.instance.getNodeByFriendly( _data['friendly'] );
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
