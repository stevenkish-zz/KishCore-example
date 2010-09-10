package com.client.project.navigation
{
	import com.client.project.transition.FadeIn;
	import com.client.project.transition.FadeOut;
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.display.KSprite;

	import flash.display.DisplayObjectContainer;

	public class MainNavView extends AbstractView
	{
		[RevealEffect]
		public var fadeIn:FadeIn;
		
		[ConcealEffect]
		public var fadeOut:FadeOut;
		
		private var _btnLayer:KSprite;
			
		public function MainNavView( host:DisplayObjectContainer=null, init:Object=null )
		{
			trace( 'MainNavView::MainNavView() ' );
			super( host, init );
			alignment = Alignment.TOP;
		}
		
		public function addButton( btn:MainNavButton ):MainNavButton
		{
			if( !_btnLayer ) 
				_btnLayer = new KSprite( this );
				
			var space:int = _btnLayer.numChildren == 0 ? 0 : 80;
			var xPos:int = space + _btnLayer.width;
			
			btn.x = xPos;
			_btnLayer.addChild( btn );
			_btnLayer.x = -int(_btnLayer.width*.5);
			place();
			
			return btn;
		}
		
		override public function show():void
		{
			trace( 'MainNavView::show() ' );
			super.show();			
		}
		
		override public function hide():void
		{
			super.hide();
		}
	}
}