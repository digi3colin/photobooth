package {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 * the states of the application
	 */
	public class PhotoboothStates extends FASTEventDispatcher {
		public static const EVENT_START_TO_SHOT : String 	= "EVENT_START_TO_SHOT";
		public static const EVENT_PREPARE_SHOT :String      = 'EVENT_PREPARE_SHOT';
		public static const EVENT_SHOT:String 				= "EVENT_SHOT";
		public static const EVENT_VIEW_INPUT_EMAIL : String = "EVENT_VIEW_INPUT_EMAIL";
		public static const EVENT_SEND : String 			= "EVENT_SEND";
		public static const EVENT_RESET : String 			= "EVENT_RESET";
		public static const EVENT_SAVE_START : String 		= "EVENT_SAVE_START";
		public static const EVENT_SAVE_POST : String 	    = "EVENT_SAVE_POST";
		public static const EVENT_EDIT : String 			= "EVENT_EDIT";
		private var saveTime : Number;

		public function PhotoboothStates() {
		}

		public function start():void{
			saveTime = -1;
			dispatchEvent(new Event(PhotoboothStates.EVENT_START_TO_SHOT));
		}

		public function prepareShot():void{
			dispatchEvent(new Event(PhotoboothStates.EVENT_PREPARE_SHOT));
		}

		public function shot() : void {
			dispatchEvent(new Event(PhotoboothStates.EVENT_SHOT));
		}

		public function edit() :void{
			dispatchEvent(new Event(PhotoboothStates.EVENT_EDIT));
		}

		public function view():void{
			dispatchEvent(new Event(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL));
		}
		
		public function send():void{
			dispatchEvent(new Event(PhotoboothStates.EVENT_SEND));
		}
		
		public function save(time:Number):void{
			saveTime = time;
			dispatchEvent(new Event(PhotoboothStates.EVENT_SAVE_START));
		}

		public function post():void{
			dispatchEvent(new Event(PhotoboothStates.EVENT_SAVE_POST));
		}
		
		public function getSaveTime():Number{
			return saveTime;
		}
		
		public function reset():void{
			dispatchEvent(new Event(PhotoboothStates.EVENT_RESET));
			start();
		}
	}
}
