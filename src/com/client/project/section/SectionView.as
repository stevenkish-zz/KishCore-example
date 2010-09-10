package com.client.project.section
{
	import flash.display.GraphicsSolidFill;
	import com.client.project.transition.FadeIn;
	import com.client.project.transition.FadeOut;
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.display.Draw;

	import flash.display.DisplayObjectContainer;

	public class SectionView extends AbstractView 
	{		
		[RevealEffect]
		public var fadeIn:FadeIn;
		
		[ConcealEffect]
		public var fadeOut:FadeOut;
		
		public function SectionView( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
		
		override public function init():void
		{
			Draw.rect( graphics, new GraphicsSolidFill( Math.random()*0xffffff ) );
			alignment = Alignment.CENTER;
			
			super.init();
		}
	}
}