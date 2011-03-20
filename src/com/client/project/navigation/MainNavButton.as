package com.client.project.navigation 
{
	import kish.control.AbstractInteractiveController;
	import kish.event.NavigationEvent;
	import kish.model.NavigationNode;
	import kish.navigation.NavigationManager;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class MainNavButton extends AbstractInteractiveController 
	{
		[View]
		public var mainNavButtonView:MainNavButtonView;
		
		public function MainNavButton( host:DisplayObjectContainer ) 
		{
			super( null, host );
		}
		
		override public function initialize():void
		{
			super.initialize();
			NavigationManager.instance.registerAction( activeNodeResponse, NavigationEvent.ACTIVE_NODE_CHANGE );
			mainNavButtonView.label = data.title;
		}
		
		override protected function click():void
		{
			NavigationManager.instance.activeNode = data as NavigationNode;
		}
		
		private function activeNodeResponse( node:NavigationNode ):void
		{
			if( !node )
			{
				enabled = true;
				selected = false;
				return;
			}
			
			enabled = NavigationNode( data ).id != node.id;
			selected = NavigationNode( data ).id == node.id;
		}		
		
		override public function set selected( value:Boolean ):void
		{
			super.selected = mainNavButtonView.selected = value;
		}
	}
}
