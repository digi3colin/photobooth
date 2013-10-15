package com.digi3studio {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class Scroller extends FASTEventDispatcher {
		public static var EVENT_SCROLL:String = 'EVENT_SCROLL';
		public static var EVENT_REACH_LAST:String = 'EVENT_REACH_LAST';
		public static var EVENT_REACH_FIRST:String = 'EVENT_REACH_FIRST';

		private var displayRange:Number;
		private var scroll : int = 0;
		private var itemHeight : Number;
		private var translate : Number;
		private var line:int=0;

		public function Scroller(displayRange:Number = 5,itemHeight:Number=100,translate:Number=0) {
			this.displayRange = displayRange;
			this.itemHeight = itemHeight;
			this.translate = translate;
			this.scroll = 0;
		}

		public function scrollTo(num:Number):void{
			scroll=(num<0)?0:num;
			dispatchEvent(new Event(Scroller.EVENT_SCROLL));
			if(scroll==0)dispatchEvent(new Event(Scroller.EVENT_REACH_FIRST));
			if(maxScroll()>=line)dispatchEvent(new Event(Scroller.EVENT_REACH_LAST));
		}

		public function currScrollPos():Number{
			return -(scroll*itemHeight)+translate;
		}

		public function setLineCount(line : int) : void {
			var oline:int = this.line;
			this.line = line;
			if(oline<line || maxScroll()>line)scrollTo(line-displayRange);
		}
		
		public function maxScroll():Number{
			return scroll+displayRange;
		}
		
		public function getScroll():Number{
			return scroll;
		}
	}
}
