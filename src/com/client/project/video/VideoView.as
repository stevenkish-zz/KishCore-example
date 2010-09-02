package com.client.project.video
{
	import com.client.project.video.controls.VideoControls;
	import com.greensock.TweenLite;
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.garbage.Garbage;
	import com.kish.video.KVideoPlayer;

	import flash.display.DisplayObjectContainer;
	import flash.system.System;

	public class VideoView extends AbstractView
	{		
		
		private var _vid:KVideoPlayer;
		private var _controls:VideoControls;
		
		public function VideoView( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
		
		override public function init():void
		{			
			_vid = new KVideoPlayer( this, { displayWidth:stage.stageWidth, displayHeight:stage.stageHeight, url:'../flv/AT&T_Gretchen_Bleiler_768_FLV-matt.flv' } );
			_controls = new VideoControls( this, { y:stage.stageHeight, videoPlayer:_vid } );
			alignment = Alignment.TOP_LEFT;
			super.init();
		}
		
		override protected function place():void
		{
			_vid.resize( stage.stageWidth, stage.stageHeight );
			_controls.y = stage.stageHeight;
			super.place();
		}
				
		override public function show():void
		{
			TweenLite.from( this, .5, { alpha:0, onComplete:super.show } );
		}
		
		override public function hide():void
		{
			_vid.pause();
			_vid.killStream();
			TweenLite.to( this, .5, { alpha:0, onComplete:super.hide } );
		}
		
		override public function dispose():void
		{
			trace( 'VideoView::dispose() ' );
			_vid.dispose();
			_controls.dispose();
			
			Garbage.dispose( _vid );
			Garbage.dispose( _controls );

			_vid = null;
			_controls = null;
			
			System.gc();
			super.dispose();
		}
	}
}