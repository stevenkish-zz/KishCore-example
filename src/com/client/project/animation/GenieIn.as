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
	public class GenieIn extends AbstractAnimation 
	{
		private var _blackHoleFilter:BlackHoleFilter;

		public function GenieIn(target : DisplayObject, duration : Number = 0.5) 
		{
			super(target, duration );
		}
		
		override public function start() : void
		{
			_blackHoleFilter = new BlackHoleFilter();
			_blackHoleFilter.progress = 1;
			_blackHoleFilter.force = 5;
			_blackHoleFilter.height = target.height;
			_blackHoleFilter.horizontal = target.width*.5;
			target.filters = [_blackHoleFilter];
			
			target.visible = true;
	
			TweenLite.to( _blackHoleFilter, duration, { force:0, progress:0, onUpdate:onUpdate, onComplete:onComplete, ease:Strong.easeOut});
		}
		
		private function onUpdate():void
		{
			target.filters = [_blackHoleFilter];
		}	
	}		
}
