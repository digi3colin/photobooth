package {
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerDebugScreens {
		private var photobooth : PhotoboothStates;
		public function ControllerDebugScreens(photobooth : PhotoboothStates) {
			this.photobooth = photobooth;
			this.photobooth.when(PhotoboothStates.EVENT_EDIT, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_PREPARE_SHOT, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_RESET, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_SAVE_POST, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_SAVE_START, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_SEND, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_SHOT, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_START_TO_SHOT, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL, onStatus);
			this.photobooth.when(PhotoboothStates.EVENT_IDLE, onStatus);
		}

		private function onStatus(e:Event):void{
			trace(e.type);
		}
	}
}
