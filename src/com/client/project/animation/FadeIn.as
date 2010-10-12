package com.client.project.animation
{
	import com.greensock.TweenLite;
	import com.kish.animation.AbstractAnimation;

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

		override public function start() : void
		{
			TweenLite.to( target, duration, { alpha:1, onComplete:onComplete } );
		}
	}
}
