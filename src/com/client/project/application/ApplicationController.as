package com.client.project.application
{
	import com.client.project.navigation.MainNavController;
	import com.client.project.section.SectionController;
	import com.client.project.video.VideoController;
	import com.kish.core.control.AbstractViewController;
	import com.kish.core.control.NavigationManager;
	import com.kish.core.control.NodeTransitionController;
	import com.kish.display.KSprite;
	import com.kish.net.KURLLoader;
	import com.kish.util.ClassUtil;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class ApplicationController extends AbstractViewController 
	{
		// induce compilation of dynamically referenced classes
		ClassUtil.register( SectionController );
		ClassUtil.register( VideoController );
		
		public function ApplicationController(host : DisplayObjectContainer, props : Object = null) 
		{
			super(host, props);
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
		
			new NodeTransitionController( NavigationManager.instance.rootNode.children, new KSprite( Application.instance ) ).initialize();
	//		new PerformanceMonitor( new KSprite( Application.instance ));
			var nav:MainNavController = new MainNavController( new KSprite( Application.instance ) );
			nav.initialize();
			nav.show();

			super.initialize();
		}
	}
}
