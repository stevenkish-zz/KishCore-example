package com.client.project.application 
{
	import kish.Application;
	import kish.ApplicationController;
	import kish.control.TransitionPhase;
	import kish.model.NavigationNode;
	import kish.model.Node;
	import kish.navigation.NavigationManager;
	import kish.navigation.NavigationNodeSequentialTransitionController;

	import com.client.project.navigation.MainNavController;
	import com.client.project.overview.OverviewController;

	import flash.utils.ByteArray;

	/**
	 * @author stevenkish
	 */
	public class ExampleApplicationController extends ApplicationController 
	{
		// embed css
		[Embed(source="/assets/css/flash.css", mimeType="application/octet-stream")]
		private const ThemeCSS:Class;

		// embed fonts embedAsCFF="false"
		[Embed(source='/assets/ttf/Arial.ttf', mimeType="application/x-font", fontName='_Arial', embedAsCFF="false", unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public var _Arial:Class;
			
		// embed xml
		[Embed(source="/assets/xml/navigation.xml", mimeType="application/octet-stream")]
		private const NavigationXML:Class;
		
		private var _navigationManager:NavigationManager;
		private var _application : ExampleApplication;
		private var _overview : OverviewController;

		public function ExampleApplicationController( application:Application ) 
		{
			super( application );
		}

		override public function initialize():void 
		{
			super.initialize();
			
			// register theme stylesheet
			theme = ThemeCSS;
			
			// make internal references
			_application = Application.instance as ExampleApplication;
			_navigationManager = NavigationManager.instance;
			
			// parse navigation data
			var byteArray:ByteArray = new NavigationXML() as ByteArray;
		    var navigationStr:String = byteArray.readUTFBytes( byteArray.length );
			var navigationData:XML = XML( navigationStr );

			// map navigation data to singleton manager
			_navigationManager.mapNavigationData( navigationData );

			// create transition controller
			var mainNodeSet:Vector.<Node> = _navigationManager.rootNode.children;
			var transitionController:NavigationNodeSequentialTransitionController = new NavigationNodeSequentialTransitionController( mainNodeSet, _application );
			transitionController.initialize();
			
			// create main navigation UI
 			var nav:MainNavController = new MainNavController( _application );
			nav.initialize();
			nav.show();
			
			// set first section manually
			_navigationManager.activeNode = mainNodeSet[0] as NavigationNode;
			
			// show overview manually over first section
			showOverviewClicked();
		}
		
		public function showOverviewClicked():void
		{
			_application.enabled = false;
			if( !_overview )
			{
				_overview = new OverviewController(null, _application);
				_overview.data = _navigationManager.rootNode;
				_overview.registerAction( _onOverviewConcealed, TransitionPhase.CONCEALED );
				_overview.initialize();
			}
			_overview.show();			
		}
		
		private function _onOverviewConcealed():void 
		{
			_application.enabled = true;
		}		
	}
}
