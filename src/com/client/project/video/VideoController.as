package com.client.project.video {
	import kish.core.control.AbstractViewController;

	import flash.display.DisplayObjectContainer;

	public class VideoController extends AbstractViewController
	{
		[View]
		public var view:VideoView;
		
		public function VideoController( host:DisplayObjectContainer=null )
		{
			super( null, host );
		}		
	}
}