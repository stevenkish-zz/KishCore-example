package com.client.project.navigation {
	import kish.component.button.KButton;
	import kish.control.NavigationManager;
	import kish.text.KText;

	import com.greensock.TweenLite;

	import flash.display.DisplayObjectContainer;
	import flash.events.TextEvent;

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
			_txt = new KText( this );
			_txt.addEventListener(TextEvent.LINK, onLink);
			_txt.mouseEnabled = true;
			_txt.selectable = true;
			_txt.alpha = .5;
			_txt.tags = "p,a@href=event:message";
			_txt.label = _data.label;
		}
		
		private function onLink( e:TextEvent ):void 
		{
			trace('onLink', e.text );
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
			if( !enabled ) 
				return;
				
			TweenLite.to( _txt, .5, { alpha:1 } );
		}
		
		override protected function rollOut():void
		{
			if( !enabled ) 
				return;
				
			TweenLite.to( _txt, .5, { alpha:.5 } );
		}
	
	}
}
