package com.client.project.video.controls {
	import kish.display.KSprite;
	import kish.video.IVideoControls;
	import kish.video.KVideoPlayer;

	import flash.display.DisplayObjectContainer;

	public class VideoControls extends KSprite implements IVideoControls
	{
		private var _vid:KVideoPlayer;
		public function set videoPlayer( v:KVideoPlayer ):void
		{
			_vid = v;
		}
		
		public function VideoControls( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
		
		public function initialize():void
		{
			new PlayPauseButton( this, {y:-15, videoPlayer:_vid } );
			new SeekBar( this, {x:15, y:-15, videoPlayer:_vid } );
			new MuteUnmuteButton( this, {x:305, y:-15, videoPlayer:_vid } );
		}
	}
}
import kish.control.button.KButton;
import kish.display.Draw;
import kish.display.KShape;
import kish.video.KVideoPlayer;

import flash.display.DisplayObjectContainer;
import flash.display.GraphicsSolidFill;

/**
 * @author stevenkish
 */
internal class PlayPauseButton extends KButton {

	private var _vid:KVideoPlayer;
	public function set videoPlayer( v:KVideoPlayer ):void
	{
		_vid = v;
	}

	public function PlayPauseButton(host : DisplayObjectContainer = null, init : Object = null) 
	{
		super(host, init);
		stateResponse( KVideoPlayer.STOPPED );
		_vid.stateSignal.add( stateResponse );
	}
	
	private function stateResponse( state:String ):void
	{
		switch( state )
		{
			case KVideoPlayer.STOPPED:
				drawForPlay();
				break;
				
			case KVideoPlayer.PAUSED:
				drawForPlay();
				break;
				
			case KVideoPlayer.PLAYING:
				Draw.rect( graphics, new GraphicsSolidFill( 0xff0000 ) );
				break;
				
			default:
		}
	}
	
	override protected function click():void
	{
		_vid.state == KVideoPlayer.PLAYING ? _vid.pause() : _vid.play();
	}
	
	public function drawForPlay():void
	{
		Draw.rect( graphics, new GraphicsSolidFill( 0x00ff00 ) );
	}
}

/**
 * @author stevenkish
 */
internal class SeekBar extends KButton 
{

	public static const WIDTH:int = 290;
	public static const HEIGHT:int = 15;
	
	private var _load:KShape;
	private var _playHead:KShape;
	private var _buffer:KShape;
	
	private var _vid:KVideoPlayer;
	public function set videoPlayer( v:KVideoPlayer ):void
	{
		_vid = v;
		_vid.progressSignal.add( progressResponse );
	}

	public function SeekBar(host : DisplayObjectContainer = null, init : Object = null) 
	{
		super(host, init);
		Draw.rect( graphics, new GraphicsSolidFill( 0x2b2b2b ), 0, 0, WIDTH, HEIGHT );
		
		_load = new KShape( this, { scaleX:0 } );
		Draw.rect( _load.graphics, new GraphicsSolidFill( 0x00ffff ), 0, 0, WIDTH, HEIGHT );
		
		_playHead = new KShape( this, { scaleX:0 } );
		Draw.rect( _playHead.graphics, new GraphicsSolidFill( 0x0f00ff ), 0, 0, WIDTH, HEIGHT );
		
		_buffer = new KShape( this );
		Draw.rect( _buffer.graphics, new GraphicsSolidFill( 0xff00ff, .35 ), 0, 0, WIDTH, HEIGHT );
		_buffer.width = 0;
	}
	
	private function progressResponse( time:Number,
										streamLength:Number, 
										bufferPercentage:Number, 
										bufferTime:Number, 
										bufferLength:Number, 
										bytesLoaded:uint, 
										bytesTotal:uint ):void
	{
		_playHead.scaleX = time/streamLength;
		_buffer.x = (time/streamLength)*WIDTH;

		var fullBufferWidth:Number = ( bufferTime/streamLength)*WIDTH;
		_buffer.width = fullBufferWidth*(bufferPercentage/100);

		_load.scaleX = bytesLoaded/bytesTotal;
	}
		
	override protected function click():void
	{
		_vid.seekToPercent( this.mouseX/WIDTH );
	}
}

/**
 * @author stevenkish
 */
internal class MuteUnmuteButton extends KButton 
{
	private var _vid:KVideoPlayer;
	public function set videoPlayer( v:KVideoPlayer ):void
	{
		_vid = v;
	}

	public function MuteUnmuteButton(host : DisplayObjectContainer = null, init : Object = null) 
	{
		super(host, init);
		
		Draw.rect( graphics );
	}
	
	override protected function click():void
	{
		_vid.toggleVolume();
	}
}