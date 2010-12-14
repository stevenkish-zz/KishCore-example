package com.client.project.section {
	import kish.control.AbstractViewController;

	import flash.display.DisplayObjectContainer;

	public class SectionController extends AbstractViewController
	{
		[View]
		public var view:SectionView;
		
		public function SectionController( host:DisplayObjectContainer=null )
		{
			super( null, host );
		}
	}
}