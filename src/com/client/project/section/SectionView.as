package com.client.project.section
{
	import com.client.project.animation.FadeIn;
	import com.client.project.animation.FadeOut;
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.display.Draw;

	import flash.display.DisplayObjectContainer;
	import flash.display.GraphicsSolidFill;
	
	public class SectionView extends AbstractView 
	{		
		[Reveal]
		public var fadeIn:FadeIn;
		
		[Conceal]
		public var fadeOut:FadeOut;
		
		public function SectionView( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
		
		override public function initialize():void
		{
			alpha = 0;
			Draw.rect( graphics, new GraphicsSolidFill( Math.random()*0xffffff ) );
			alignment = Alignment.CENTER;
			
			super.initialize();
		}
	}
}