package {
	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 * the states of the application
	 */
	public class PhotoboothStates extends FASTEventDispatcher {
		public static const EVENT_IDLE:String               = "EVENT_IDLE";
		public static const EVENT_START_TO_SHOT : String 	= "EVENT_START_TO_SHOT";
		public static const EVENT_PREPARE_SHOT :String      = "EVENT_PREPARE_SHOT";
		public static const EVENT_SHOT:String 				= "EVENT_SHOT";
		public static const EVENT_VIEW_INPUT_EMAIL : String = "EVENT_VIEW_INPUT_EMAIL";
		public static const EVENT_SEND : String 			= "EVENT_SEND";
		public static const EVENT_RESET : String 			= "EVENT_RESET";
		public static const EVENT_SAVE_START : String 		= "EVENT_SAVE_START";
		public static const EVENT_SAVE_POST : String 	    = "EVENT_SAVE_POST";
		public static const EVENT_EDIT : String 			= "EVENT_EDIT";
		private var saveTime : Number;
		private var state:String;


		public function PhotoboothStates() {
		}

		private function changeState(state:String):void{
			this.state = state;
			dispatchEvent(new Event(state));
		}

		public function init():void{
			saveTime = -1;
			changeState(PhotoboothStates.EVENT_IDLE);
		}

		public function start():void{
			changeState(PhotoboothStates.EVENT_START_TO_SHOT);
		}

		public function prepareShot():void{
			changeState(PhotoboothStates.EVENT_PREPARE_SHOT);
		}

		public function shot() : void {
			trace('shot');
			
			if(this.state == PhotoboothStates.EVENT_IDLE || this.state == PhotoboothStates.EVENT_RESET){
				return;
			}

			changeState(PhotoboothStates.EVENT_SHOT);
		}

		public function edit() :void{
			changeState(PhotoboothStates.EVENT_EDIT);				
			if(AppConfig.ENABLE_EDIT == false){
				view();
			}
		}

		public function view():void{
			changeState(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL);
		}
		
		public function send():void{
			changeState(PhotoboothStates.EVENT_SEND);
		}
		
		public function save(time:Number):void{
			saveTime = time;
			changeState(PhotoboothStates.EVENT_SAVE_START);
		}

		public function post():void{
			changeState(PhotoboothStates.EVENT_SAVE_POST);
		}
		
		public function getSaveTime():Number{
			return saveTime;
		}
		
		public function reset():void{
			changeState(PhotoboothStates.EVENT_RESET);
			this.init();
		}
	}
}
