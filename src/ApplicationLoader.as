package
{
	import com.kish.core.IApplication;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;

	public class ApplicationLoader extends Sprite
	{		
		// Embed basic Latin characters: L, O, A, D, I, N and G
		[Embed(source='/embeds/ttf/Arial.ttf', mimeType="application/x-font", fontName='_Arial', unicodeRange='U+004c, U+004f, U+0049, U+004e, U+0047, U+0041,U+0044')]
		public var _Arial:Class;

		private var css:String = 'h1{font-size:10px;color:#FF0000;font-family:_Arial}';
		
		private var _displayLayer:Sprite;
		private var _txt:TextField;
	
		public function ApplicationLoader()
		{
			trace( 'ApplicationLoader::ApplicationLoader() ' );
		    super();
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			build();
			startLoad();
		}
		
		private function build():void
		{
			_displayLayer = new Sprite();
			stage.addChild( _displayLayer );
			
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( css );
			
			_txt = new TextField();
			_txt.styleSheet = styleSheet;
			_txt.embedFonts = true;
			_txt.htmlText = '<h1>LOADING</h1>';
			_txt.x = -int(_txt.textWidth*.5);
			_txt.y = -int(_txt.textHeight*.5);
			_displayLayer.addChild( _txt );
			
			onStageResize( null );
			stage.addEventListener( Event.RESIZE, onStageResize );
		}
		
		private function startLoad():void
		{
			trace( 'ApplicationLoader::startLoad() ' );
			var url:String = stage.loaderInfo.parameters['application'];
			var ldr:Loader = new Loader();
			ldr.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
			ldr.load( new URLRequest( url ) );
		}
		
		private function onLoadComplete( e:Event ):void
		{
			trace( 'ApplicationLoader::onLoadComplete() ' );
			stage.removeChild( _displayLayer );
			stage.removeEventListener( Event.RESIZE, onStageResize );

			e.target.removeEventListener( Event.COMPLETE, onLoadComplete );
			var app:DisplayObject = e.target.content;
			stage.addChild( app )
			IApplication( app ).start();
		}
		
		private function onStageResize( e:Event ):void
		{
			_displayLayer.x = int( stage.stageWidth*.5 );
			_displayLayer.y = int( stage.stageHeight*.5 );
		}
	}
}