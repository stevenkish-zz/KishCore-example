package com.client.project.application 
{
	import kish.Application;
	import kish.core.control.ApplicationController;
	import kish.core.control.NavigationManager;
	import kish.core.control.NavigationNodeTransitionController;
	import kish.display.KSprite;
	import kish.net.KURLLoader;

	import com.client.project.navigation.MainNavController;

	/**
	 * @author stevenkish
	 */
	public class KishCoreExampleController extends ApplicationController 
	{
		public function KishCoreExampleController( application:KishCoreExample ) 
		{
			super( application );
		}

		override public function initialize():void 
		{
			var navigationDataPath:String = Application.instance.stage.loaderInfo.parameters['navigation'];
			var xmlLdr:KURLLoader = new KURLLoader( { url:navigationDataPath, autoStart:true } );
	        xmlLdr.completeSignal.add( completeResponse );
			KishCoreExample( Application.instance ).goHomeSignal.add( resetResponse );
		}

	 	private function completeResponse( data:String ):void
		{		
			super.initialize();
			
			NavigationManager.instance.mapNavigationData( data );
			ApplicationInitializer.instance.initialize();
		
			new NavigationNodeTransitionController( NavigationManager.instance.rootNode.children, new KSprite( Application.instance ) ).initialize();
			var nav:MainNavController = new MainNavController( new KSprite( Application.instance ) );
			nav.initialize();
			nav.show();
		}
		
		private function resetResponse():void
		{
			NavigationManager.instance.activeNode = null;
		}
	}
}
