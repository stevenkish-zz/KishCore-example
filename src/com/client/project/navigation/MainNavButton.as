package com.client.project.navigation 
{
	import kish.event.INavigationEventActionDelegate;
	import kish.control.AbstractInteractiveController;
	import kish.event.NavigationEvent;
	import kish.model.NavigationNode;
	import kish.navigation.NavigationManager;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class MainNavButton extends AbstractInteractiveController implements INavigationEventActionDelegate
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
			NavigationManager.instance.registerAction( onActiveNodeChange, NavigationEvent.ACTIVE_NODE_CHANGE );
			mainNavButtonView.label = data.title;
		}
		
		override protected function click():void
		{
			NavigationManager.instance.activeNode = data as NavigationNode;
		}
		
		public function onActiveNodeChange( node:NavigationNode ):void
		{
			selected = node ? ( NavigationNode( data ).id == node.id ) : false;
			enabled = !selected;
		}		
		
		override public function set selected( value:Boolean ):void
		{
			super.selected = mainNavButtonView.selected = value;
		}
	}
}
