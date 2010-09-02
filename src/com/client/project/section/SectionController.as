package com.client.project.section
{
	import com.kish.core.control.AbstractViewController;

	import flash.display.DisplayObjectContainer;

	public class SectionController extends AbstractViewController
	{
		[View]
		public var view:SectionView;
		
		public function SectionController( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}	
		
		override public function init():void
		{
			trace( 'SectionController::init() ' );
			super.init();
		}
		
		override public function show():void
		{
			trace( 'SectionController::show() ' );
			super.show();
		}
		
		override public function hide():void
		{
			trace( 'SectionController::hide() ' );
			super.hide();
		}
		
		override public function dispose():void
		{
			trace( 'SectionController::dispose() ' );
			super.dispose();
		}
	}
}