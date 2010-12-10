package com.client.project.animation {
	import com.greensock.TweenLite;
	import kish.animation.AbstractAnimation;

	import flash.display.DisplayObject;

	/**
	 * @author stevenkish
	 */
	public class FadeIn extends AbstractAnimation
	{
		
		public function FadeIn( target:DisplayObject )
		{
			super( target, .5 );
		}
		
		override public function initialize() : void
		{
			target.alpha = 0;
			target.visible = true;
		}

		override public function start() : void
		{
			TweenLite.to( target, duration, { alpha:1, onComplete:onComplete } );
		}
	}
}
