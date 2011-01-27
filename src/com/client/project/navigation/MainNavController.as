package com.client.project.navigation 
{
	import kish.control.AbstractViewController;
	import kish.model.Node;
	import kish.navigation.NavigationManager;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class MainNavController extends AbstractViewController 
	{
		[View]
		public var mainNavView:MainNavView;
		
		public function MainNavController( host:DisplayObjectContainer ) 
		{
			super( null, host );
		}
		
		override public function show():void 
		{
			super.show();
			
			// create buttons
			var childNodes:Vector.<Node> = NavigationManager.instance.rootNode.children;
			for each( var node:Node in childNodes )
			{
				var btn:MainNavButton = new MainNavButton( mainNavView );
				btn.data = node;
				btn.initialize();
				btn.show();
			}
		}	
	}
}
