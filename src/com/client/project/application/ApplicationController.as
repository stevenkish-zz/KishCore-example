package com.client.project.application {
	import kish.core.control.AbstractViewController;
	import kish.core.control.NavigationManager;
	import kish.core.control.NavigationNodeTransitionController;
	import kish.display.KSprite;
	import kish.net.KURLLoader;
	import kish.util.ClassUtil;

	import com.client.project.navigation.MainNavController;
	import com.client.project.section.SectionController;
	import com.client.project.video.VideoController;

	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author stevenkish
	 */
	public class ApplicationController extends AbstractViewController 
	{
		// induce compilation of dynamically referenced classes
		ClassUtil.register( SectionController );
		ClassUtil.register( VideoController );
		
		public function ApplicationController( view:Application ) 
		{
			super( view );
			view.resetSignal.add( resetResponse );
		}
		
		override public function initialize():void
		{
			var navigationDataPath:String = Application.instance.stage.loaderInfo.parameters['navigation'];
			var xmlLdr:KURLLoader = new KURLLoader( { url:navigationDataPath, autoStart:true } );
	        xmlLdr.completeSignal.add( completeResponse );
		}

	 	private function completeResponse( data:String ):void
		{		
			NavigationManager.instance.mapNavigationData( data );
			ApplicationInitializer.instance.initialize();
		
			new NavigationNodeTransitionController( NavigationManager.instance.rootNode.children, new KSprite( Application.instance ) ).initialize();
	//		new PerformanceMonitor( new KSprite( Application.instance ));
			var nav:MainNavController = new MainNavController( new KSprite( Application.instance ) );
			nav.initialize();
			nav.show();

			super.initialize();
		}
		
		private function resetResponse():void
		{
			NavigationManager.instance.activeNode = null;
		}
	}
}
