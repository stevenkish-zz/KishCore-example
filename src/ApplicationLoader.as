package
{
	import flash.display.LoaderInfo;
	import flash.events.IEventDispatcher;
	import com.kish.core.IApplication;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	[SWF(backgroundColor="#FFFFFF", frameRate="32", width="320", height="480")]
	public class ApplicationLoader extends Sprite
	{		
		private var _displayLayer:Sprite;
		private var _spinner:Spinner;
		
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
			_spinner = new Spinner();
			_displayLayer.addChild( _spinner );
			stage.addChild( _displayLayer );
			
			onStageResize( null );
			stage.addEventListener( Event.RESIZE, onStageResize );
		}
		
		private function startLoad():void
		{
			trace( 'ApplicationLoader::startLoad() ' );
			try{
				var url:String = stage.loaderInfo.parameters['application'];
				var ldr:Loader = new Loader();
				ldr.contentLoaderInfo.addEventListener( Event.COMPLETE, _onComplete );
				ldr.load( new URLRequest( url ) );
			}
			catch( e:Error )
			{
				throw new Error('** please specify the URL of the SWF to load by specifying the FlashVar "application"');
			}
		}
		
		private function _onComplete( e:Event ):void
		{
			trace( 'ApplicationLoader::onLoadComplete() ' );

			_spinner.stop();

			stage.removeChild( _displayLayer );
			stage.removeEventListener( Event.RESIZE, onStageResize );

			IEventDispatcher( e.target ).removeEventListener( Event.COMPLETE, _onComplete );
			
			var app:DisplayObject = LoaderInfo( e.target ).content;
			stage.addChild( app );
			IApplication( app ).start();
		}
		
		private function onStageResize( e:Event ):void
		{
			_displayLayer.x = int( stage.stageWidth*.5 );
			_displayLayer.y = int( stage.stageHeight*.5 );
		}
	}
}

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.StyleSheet;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
	
/**
 * @author stevenkish
 */
internal class Spinner extends MovieClip
{
	private const MESSAGE:String = '<h1>LOADING...</h1>';
	private const RADIUS:uint = 14;
	private const NUMBER_OF_DOTS:uint = 12;
	private const DOT_RADIUS:uint = 2;
	private const CSS:String = 'h1{font-size:10px;color:#2b3b4b;font-family:_Arial}';
	
	// Embed basic Latin characters: L, O, A, D, I, N, G, C, T, S, R, E, M, .
	[Embed(source='/assets/ttf/Arial.ttf', mimeType="application/x-font", fontName='_Arial', embedAsCFF='false', unicodeRange='U+004c,U+004f,U+0049,U+004e,U+0047,U+0041,U+0044,U+0043,U+0054,U+0053,U+0045,U+004D,U+002E')]
	public var _Arial:Class;

	private var _spinner:Sprite;
	private var _txt:TextField;
	private var _rotationDegressPerFrame:Number;
	
	public function Spinner()
	{
		super();
		super.stop();
		addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}
	
	private function onAddedToStage( e:Event ):void
	{
		removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		
		_rotationDegressPerFrame = 7;	
		_spinner = new Sprite();
		
		var pos:Number;
		var degreeIncrement:Number = ( (Math.PI*2)/NUMBER_OF_DOTS );
		var alphaIncrement:Number = 1/NUMBER_OF_DOTS;
		
		// draw each dot
		for( var i:uint = 1; i<=NUMBER_OF_DOTS; i++ )
		{	
			// caluclate position in circle
			pos = degreeIncrement*i;
			
			// draw dot
			_spinner.graphics.beginFill( 0x2b3b4b, (alphaIncrement*i) );
			_spinner.graphics.drawCircle( Math.cos(pos)*RADIUS, Math.sin(pos)*RADIUS, DOT_RADIUS );
			_spinner.graphics.endFill();
		}
		
		addChild( _spinner );
		
		var styleSheet:StyleSheet = new StyleSheet();
		styleSheet.parseCSS( CSS );
		
		_txt = new TextField();
		_txt.styleSheet = styleSheet;
		_txt.embedFonts = true;
		_txt.autoSize = TextFieldAutoSize.CENTER;
		_txt.htmlText = MESSAGE;
		_txt.x = -int(_txt.textWidth*.5)-2;
		_txt.y = RADIUS+9;
		addChild( _txt );
		
		play();
	}
	
	private function _onEnterFrame( event:Event ):void
	{
		_spinner.rotation += _rotationDegressPerFrame;
	}
	
	override public function play():void
	{
		addEventListener( Event.ENTER_FRAME, _onEnterFrame );
		super.play();
	}
	
	override public function stop():void
	{
		super.stop();
		removeEventListener( Event.ENTER_FRAME, _onEnterFrame );
	}
}
