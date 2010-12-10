//AS3///////////////////////////////////////////////////////////////////////////
// 
// Copyright Steven Kish, 2010 
// 
////////////////////////////////////////////////////////////////////////////////

package {
	import kish.core.IApplication;
	import kish.core.view.AbstractView;
	import kish.display.Draw;

	import com.client.project.application.ApplicationController;

	import org.osflash.signals.Signal;

	import flash.display.GraphicsSolidFill;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

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
		
		private var _resetSignal:Signal = new Signal();
		public function get resetSignal():Signal 
		{
			return _resetSignal;
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
			
			var hit:Sprite = new Sprite();
			Draw.rect(hit.graphics, new GraphicsSolidFill( 0xff00ff, 0 ), 0, 0, stage.stageWidth, stage.stageHeight );
			addChild( hit );
			hit.addEventListener( MouseEvent.CLICK, onClick );
			
			new ApplicationController( this ).initialize();
		}
		
		private function onClick( e:Event ):void
		{
			_resetSignal.dispatch();
		}
	}
}