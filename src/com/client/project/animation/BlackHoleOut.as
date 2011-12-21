package com.client.project.animation
{

	import kish.animation.AbstractAnimation;
	import kish.filter.BlackHoleFilter;

	import com.greensock.TweenLite;
	import com.greensock.easing.Strong;

	import flash.display.DisplayObject;

	/**
	 * @author stevenkish
	 */
	public class BlackHoleOut extends AbstractAnimation
	{
	
		private var _blackHoleFilter:BlackHoleFilter;

		function BlackHoleOut(target : DisplayObject, duration : Number = 0.5) 
		{
			super(target, duration );
		}

		override public function initialize() : void
		{
		}

		override public function start() : void
		{
			_blackHoleFilter = new BlackHoleFilter();
			_blackHoleFilter.progress = 0;
			_blackHoleFilter.force = 0;
			_blackHoleFilter.height = target.height;
			_blackHoleFilter.horizontal = target.width*.5;

			TweenLite.to( _blackHoleFilter, duration, { force:5, progress:1, onUpdate:onUpdate, onComplete:onComplete, ease:Strong.easeIn});
		}

		private function onUpdate():void
		{
			target.filters = [_blackHoleFilter];
		}	
	}
}
		