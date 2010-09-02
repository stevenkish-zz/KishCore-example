package com.client.project.section
{
	import com.greensock.TweenLite;
	import com.kish.core.view.AbstractView;
	import com.kish.display.Alignment;
	import com.kish.display.Draw;
	import com.kish.display.KShape;

	import flash.display.DisplayObjectContainer;
	import flash.display.GraphicsSolidFill;

	public class SectionView extends AbstractView 
	{		
		private var _shape : KShape;

		public function SectionView( host:DisplayObjectContainer=null, init:Object=null )
		{
			super( host, init );
		}
		
		override public function init():void
		{
			_shape = new KShape( this );
			Draw.rect( _shape.graphics );
			alignment = Alignment.CENTER;
			super.init();
		}
		
		private function loop():void
		{
			TweenLite.to( _shape, .5, { alpha:1-_shape.alpha, onComplete:loop } );
		}
		
		private function introComplete():void
		{
			Draw.rect( _shape.graphics, new GraphicsSolidFill( 0x00ff00 ), 0, 0, 15, 15, true );
			super.show();
			loop();
		}
				
		override public function show():void
		{
			TweenLite.from( _shape, .5, { x:15, alpha:0, onComplete:introComplete } );		}
		
		override public function hide():void
		{
			TweenLite.killTweensOf(_shape);
			Draw.rect( _shape.graphics, new GraphicsSolidFill( 0x0000ff ), 0, 0, 15, 15, true );
			TweenLite.to( _shape, .5, { x:-15, alpha:0, onComplete:super.hide } );
		}		
	}
}