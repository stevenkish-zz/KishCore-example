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
	public class Application extends AbstractView implements IApplication
	{
		private static var _instance : Application;

		public static function get instance() : Application { return _instance }
	
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
		
		public function start():void
		{
			trace( 'Application::start() ' );
			new ApplicationController( stage, { view:this } ).init();
		}

		/**
		 * Initialize
		 */
		override public function init():void
		{
			trace( 'Application::init()' );
			super.init();
		}
		
		override public function show():void
		{
			trace( 'Application::show() ' );
			super.show();
		}
	}
}