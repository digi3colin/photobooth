package {
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerDebugScreens {
		private var photobooth : PhotoboothStates;
		public function ControllerDebugScreens(photobooth : PhotoboothStates) {
			this.photobooth = photobooth;
			this.photobooth.when(PhotoboothStates.EVENT_SHOT, onShot);
		}
		
		private function onShot(e:Event):void{
			trace('shot');
		}
	}
}
