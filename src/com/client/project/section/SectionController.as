package com.client.project.section 
{
	import kish.control.AbstractViewController;

	import flash.display.DisplayObjectContainer;

	public class SectionController extends AbstractViewController
	{
		[View]
		public var sectionView:SectionView;
		
		public function SectionController( host:DisplayObjectContainer=null )
		{
			super( null, host );
		}
		
		override public function initialize():void 
		{
			super.initialize();
			sectionView.title = data.title;
			sectionView.content = data.content;
		}
	}
}