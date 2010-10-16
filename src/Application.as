//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright Steven Kish, 2010 
// 
////////////////////////////////////////////////////////////////////////////////

package
{
	import com.client.project.application.ApplicationController;
	import com.kish.core.IApplication;
	import com.kish.core.view.AbstractView;

	/*
	 * *
	 * Application entry point for unstrukt core project.
	 * 
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 10.0
	 * 
	 * @author Steven Kish
	 * @since 25.01.2010
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="40", width="320", height="480")]
	public class Application extends AbstractView implements IApplication
	{
		private static var _instance : Application;

		public static function get instance() : Application 
		{ 
			return _instance;
		}
	
		/**
		 * @constructor
		 */
		public function Application()
		{
			super();
			
			_instance = this;
			
			if( stage ) 
				start();
		}
		
		/**
		 * Although, typically with KishCore, a subclass of AbstractViewController will instantiate it's own view,
		 * here, the view is created firstly as a swf and then subsequently declares it's own controller
		 */
		public function start():void
		{
			trace( 'Application::start() ' );
			new ApplicationController( stage, { view:this } ).initialize();
		}
	}
}