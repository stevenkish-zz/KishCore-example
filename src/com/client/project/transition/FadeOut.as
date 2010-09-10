package com.client.project.transition
{
	import com.greensock.TweenLite;
	import com.kish.transition.AbstractTransition;

	import flash.display.DisplayObject;

	/**
	 * @author stevenkish
	 */
	public class FadeOut extends AbstractTransition
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
