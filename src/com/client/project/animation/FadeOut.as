package com.client.project.animation
{
	import com.greensock.TweenLite;
	import com.kish.animation.AbstractAnimation;

	import flash.display.DisplayObject;

	/**
	 * @author stevenkish
	 */
	public class FadeOut extends AbstractAnimation
	{
		
		public function FadeOut( target:DisplayObject )
		{
			super( target, .5 );
		}
		
		override public function start() : void
		{
			TweenLite.to( target, duration, { alpha:0, onComplete:onComplete } );
		}
	}
}
