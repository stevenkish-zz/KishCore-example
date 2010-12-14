package com.client.project.application 
{
	import kish.Application;
	import kish.net.FlashVars;
	import kish.text.KText;

	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.text.Font;
	import flash.text.StyleSheet;
	import flash.utils.ByteArray;

	public class ApplicationInitializer 
	{
		// embed css
		[Embed(source="/assets/css/flash.css", mimeType="application/octet-stream")]
		private const FlashCSS:Class;
					
		// embed xml
		[Embed(source="/assets/xml/config.xml", mimeType="application/octet-stream")]
		private const ConfigXML:Class;
				
		// embed fonts embedAsCFF="false",
		[Embed(source='/assets/ttf/Arial.ttf', mimeType="application/x-font", fontName='_Arial', embedAsCFF="false", unicodeRange='U+0020-U+002F,U+0030-U+0039,U+003A-U+0040,U+0041-U+005A,U+005B-U+0060,U+0061-U+007A,U+007B-U+007E')]
		public var _Arial:Class;

		// property access
		private var _config:XML;
		public function get config():XML 
		{ 
			return _config;
		}		
			
		// construktor
		public function ApplicationInitializer( enforcer : SingletonEnforcer )
		{
			enforcer = null;
			super();
		}	

		// singleton instance
		private static var _instance : ApplicationInitializer;
		public static function get instance() : ApplicationInitializer
		{
			if ( _instance == null ) _instance = new ApplicationInitializer( new SingletonEnforcer() );
			return _instance;
		}

		public function initialize():void
		{
			var f:Array = Font.enumerateFonts();
			for( var i:int = 0; i<f.length; i++) 
				trace("ApplicationInitializer::initialize() embedded font #"+(i+1)+":", f[i].fontName + '; ' + f[i].fontStyle );
			
			populateFlashVars( Application.instance.stage );
			parseConfig();
			initStage( Application.instance.stage );
			parseStyleSheet();
			initTweenLite();
		}
								
		/**
		 * map flash vars
		 */  
		private function populateFlashVars( stage:Stage ):void
		{
			// populate map flash vars map
			var fvars:FlashVars = FlashVars.getInstance();
			var params:Object = stage.loaderInfo.parameters;

			for( var varStr:String in params ) 
				fvars.add( varStr, params[varStr] );
		}

		/**
		 * store reference to config
		 */  
		private function parseConfig():void
		{
			var byteArray:ByteArray = new ConfigXML() as ByteArray;
		    var configStr:String = byteArray.readUTFBytes( byteArray.length );
			_config = XML( configStr );
		}
		
		/**
		 * set stage properties
		 */  
		private function initStage( stage:Stage ):void
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}

		/**
		 *
		 */  
		private function parseStyleSheet():void
		{
			var byteArray:ByteArray = new FlashCSS() as ByteArray;
		    var stylesStr:String = byteArray.readUTFBytes( byteArray.length );

			var styleSheet:StyleSheet = new StyleSheet();
			styleSheet.parseCSS( stylesStr );
						
			KText.STYLESHEET = styleSheet;
		}

		/**
		 * 
		 */  
		private function initTweenLite():void
		{
			//properties set here are permanent in the SWF, so this line only needs to be run once.
			TweenLite.defaultEase = Strong.easeOut;
			
			/*TweenPlugin.activate([BlurFilterPlugin]);*/
			/*TweenPlugin.activate([ColorMatrixFilterPlugin])*/;
			/*TweenPlugin.activate([TintPlugin]);*/
			/*TweenPlugin.activate([BezierPlugin]);*/
			/*TweenPlugin.activate([VisiblePlugin]);*/
			/*TweenPlugin.activate([GlowFilterPlugin]);*/
		}
	}
}

internal class SingletonEnforcer {}