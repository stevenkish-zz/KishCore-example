package com.client.project.overview {
	import kish.control.AbstractViewController;
	import kish.view.AbstractView;

	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author stevenkish
	 */
	public class OverviewController extends AbstractViewController 
	{
		[View]
		public var overviewView:OverviewView;
	
		public function OverviewController(view : AbstractView = null, host : DisplayObjectContainer = null) 
		{
			super(view, host);
		}
		
		override public function initialize():void 
		{
			super.initialize();
			overviewView.visible = false;
			overviewView.title = data.title;
			overviewView.content = data.content;
			overviewView.addEventListener( MouseEvent.CLICK, _onViewClick );
		}
		
			private function _onViewClick( e:Event ):void
		{
			hide();
		}	
	}
}
