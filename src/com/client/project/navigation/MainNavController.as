package com.client.project.navigation {
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
		public var view:MainNavView;
		
		public function MainNavController( host:DisplayObjectContainer ) 
		{
			super( null, host );
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			// create buttons
			var childNodes:Vector.<Node> = NavigationManager.instance.rootNode.children;
			for each( var node:Node in childNodes )
			{
				var btn:MainNavButton = new MainNavButton( view );
				btn.data = node;
				btn.initialize();
			}
		}	
	}
}
