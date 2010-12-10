package com.client.project.navigation {
	import kish.core.control.AbstractViewController;
	import kish.core.control.NavigationManager;
	import kish.core.model.NavigationNode;
	import kish.core.model.Node;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class MainNavController extends AbstractViewController 
	{
		[View]
		public var mainNavView:MainNavView;
		
		private var _btns : Vector.<MainNavButton>;

		public function MainNavController( host:DisplayObjectContainer ) 
		{
			super( null, host );
		}
		
		override public function initialize():void 
		{
			super.initialize();
			
			_btns = new Vector.<MainNavButton>();
			
			// create buttons
			for each( var node:Node in NavigationManager.instance.rootNode.children )
				_btns.push( mainNavView.addButton( new MainNavButton( null, { data:node as NavigationNode } ) ) );
				
			NavigationManager.instance.activeNodeSignal.add( activeNodeResponse );
		}	
		
		private function activeNodeResponse( node:NavigationNode ):void
		{
			
			for each( var btn:MainNavButton in _btns )
				btn.selected = !node || node.friendly == null ? false : btn.data.friendly == node.friendly;
		}
	}
}
