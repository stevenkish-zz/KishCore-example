package com.client.project.navigation
{
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.display.KSprite;

	import flash.display.DisplayObjectContainer;

	public class MainNavView extends AbstractView
	{
		
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
			var n:int = _btnLayer.numChildren;
			for ( var i:int=0; i<n; i++ )
				MainNavButton( _btnLayer.getChildAt( i ) ).show();
				
			super.show();			
		}
		
		override public function hide():void
		{
			var n:int = _btnLayer.numChildren;
			for ( var i:int=0; i<n; i++ ) 
				MainNavButton( _btnLayer.getChildAt( i ) ).hide();
				
			super.hide();
		}
	}
}