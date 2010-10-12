package com.client.project.navigation
{
	import com.kish.core.control.AbstractViewController;
	import com.kish.core.control.NavigationManager;
	import com.kish.core.model.NavigationNode;
	import com.kish.core.model.Node;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class MainNavController extends AbstractViewController 
	{
		[View]
		public var view:MainNavView;
		
		private var _btns : Vector.<MainNavButton>;

		public function MainNavController(host : DisplayObjectContainer = null, init : Object = null) 
		{
			super( host, init );
		}
		
		override public function initialize():void 
		{
			_btns = new Vector.<MainNavButton>();
			
			// create buttons
			for each( var node:Node in NavigationManager.instance.rootNode.children )
				_btns.push( MainNavView( view ).addButton( new MainNavButton( null, { data:node as NavigationNode } ) ) );
				
			NavigationManager.instance.activeNodeSignal.add( activeNodeResponse );
			super.initialize();
		}	
		
		private function activeNodeResponse( node:NavigationNode ):void
		{
			for each( var btn:MainNavButton in _btns )
				btn.selected = node.friendly == null ? false : btn.data.friendly == node.friendly;
		}
	}
}
