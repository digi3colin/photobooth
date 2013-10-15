package com.digi3studio {
	import flash.events.TimerEvent;
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;
	import flash.utils.Timer;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class CountDown extends FASTEventDispatcher {
		public static const EVENT_DONE : String = "EVENT_DONE";
		public static const EVENT_START:String = "EVENT_START";
		public static const EVENT_COUNTING:String = "EVENT_COUNTING";
		
		private var timer:Timer;
		private var maxCount:int;
		private var currentCount:int;

		public function CountDown(count:int=5) {
			maxCount = count;
			timer= new Timer(1000,count);
			timer.addEventListener(TimerEvent.TIMER, counting, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, countDone, false, 0, true);
		}

		public function start() : void {
			currentCount = maxCount;
			timer.reset();
			timer.start();
			dispatchEvent(new Event(CountDown.EVENT_START));
		}
		
		private function countDone(e:Event):void{
			dispatchEvent(new Event(CountDown.EVENT_DONE));
		}
		
		private function counting(e:Event):void{
			currentCount--;
			dispatchEvent(new Event(CountDown.EVENT_COUNTING));
		}

		public function getCount() : int {
			return currentCount;
		}
	}
}
