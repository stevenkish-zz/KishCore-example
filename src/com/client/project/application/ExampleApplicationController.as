package com.client.project.application 
{
	import kish.Application;
	import kish.ApplicationController;
	import kish.navigation.NavigationManager;
	import kish.navigation.NavigationNodeSequentialTransitionController;

	import com.client.project.navigation.MainNavController;

	import flash.utils.ByteArray;

	/**
	 * @author stevenkish
	 */
	public class ExampleApplicationController extends ApplicationController 
	{
		// embed xml
		[Embed(source="/assets/xml/navigation.xml", mimeType="application/octet-stream")]
		private const NavigationXML:Class;

		public function ExampleApplicationController( application:Application ) 
		{
			super( application );
		}

		override public function initialize():void 
		{
			super.initialize();

			var byteArray:ByteArray = new NavigationXML() as ByteArray;
		    var navigationStr:String = byteArray.readUTFBytes( byteArray.length );
			var navigationData:XML = XML( navigationStr );
			
			NavigationManager.instance.mapNavigationData( navigationData );
		
			new NavigationNodeSequentialTransitionController( NavigationManager.instance.rootNode.children, Application.instance ).initialize();
			var nav:MainNavController = new MainNavController( Application.instance );
			nav.initialize();
			nav.show();

			ExampleApplication( Application.instance ).goHomeSignal.add( resetResponse );
		}
		
		private function resetResponse():void
		{
			NavigationManager.instance.activeNode = null;
		}
	}
}
