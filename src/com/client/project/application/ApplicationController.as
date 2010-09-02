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
	import com.kish.util.PerformanceMonitor;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author stevenkish
	 */
	public class ApplicationController extends AbstractViewController 
	{
		ClassUtil.register( SectionController );
		ClassUtil.register( VideoController );
		
		public function ApplicationController(host : DisplayObjectContainer, props : Object = null) 
		{
			super(host, props);
			initializeSignal.addOnce( initializedResponse );
		}
		
		override public function init():void
		{
			var xmlLdr:KURLLoader = new KURLLoader( { url:Application.instance.stage.loaderInfo.parameters['navigation'], autoStart:true } );
	        xmlLdr.completeSignal.add( completeResponse );
		}

	 	private function completeResponse( data:String ):void
		{		
			NavigationManager.mapNavigationData( data );
			ApplicationInitializer.instance.init();
			super.init();
		}

		private function initializedResponse():void
		{
			new NodeTransitionController( NavigationManager.instance.rootNode.children, new KSprite( Application.instance ) );
			new MainNavController( new KSprite( Application.instance ) ).init();
			new PerformanceMonitor( new KSprite( Application.instance ));
			
			show();
		}
	}
}
