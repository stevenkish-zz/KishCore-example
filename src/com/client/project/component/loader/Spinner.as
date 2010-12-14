package com.client.project.component.loader {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	/**
	 * @author stevenkish
	 */
	public class Spinner extends Sprite
	{
		private const RADIUS:uint = 15;
		private const NUMBER_OF_DOTS:uint = 12;
		private const DOT_RADIUS:uint = 2;
		private const CSS:String = 'h1{font-size:10px;color:#2b3b4b;font-family:_Arial}';
		
		// Embed basic Latin characters: L, O, A, D, I, N, G, C, T, S, R, E, M, .
		[Embed(source='/assets/ttf/Arial.ttf', mimeType="application/x-font", fontName='_Arial', embedAsCFF='false', unicodeRange='U+004c,U+004f,U+0049,U+004e,U+0047,U+0041,U+0044,U+0043,U+0054,U+0053,U+0045,U+004D,U+002E')]
		public var _Arial:Class;
	
		private var _spinner:Sprite;
		private var _txt:TextField;
		private var _label:String;
		private var _rotationDegressPerFrame:Number;
		
		public function Spinner()
		{
			super();
			
			_label = 'LOADING...';
			_rotationDegressPerFrame = 10;
			
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
			
			_spinner.cacheAsBitmap = true;
			addChild( _spinner );
			
			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( CSS );
			
			_txt = new TextField();
			_txt.styleSheet = styleSheet;
			_txt.embedFonts = true;
			_txt.autoSize = TextFieldAutoSize.CENTER;
			_setLabel();
			addChild( _txt );
		}
		
		private function _setLabel():void
		{
			_txt.htmlText = '<h1>'+_label+'</h1>';
			_txt.x = -int(_txt.textWidth*.5)-2;
			_txt.y = RADIUS+6;
		}
		
		private function _onEnterFrame( event:Event ):void
		{
			_spinner.rotation += _rotationDegressPerFrame;
		}
		
		public function play():void
		{
			addEventListener( Event.ENTER_FRAME, _onEnterFrame );
		}
		
		public function stop():void
		{
			removeEventListener( Event.ENTER_FRAME, _onEnterFrame );
		}
		
		public function set label( value:String ):void
		{
			_label = value;
			_setLabel();
		}
		
		public function dispose():void
		{
			while( this.numChildren > 0 )
				removeChildAt(0);
		}
	}
}
