package com.client.project.video
{
	import com.kish.core.control.AbstractViewController;

	import flash.display.DisplayObjectContainer;

	public class VideoController extends AbstractViewController
	{
		[View]
		public var view:VideoView;
		
		public function VideoController( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}		
	}
}