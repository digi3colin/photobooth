package controller {
	import asset.MainView;

	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerUserRetry {
		private var btnRetry:ButtonClip;
		private var photobooth:PhotoboothStates;
		public function ControllerUserRetry(mainView : MainView, photobooth : PhotoboothStates) {
			this.photobooth = photobooth;
			btnRetry = new ButtonClip(mainView.mc_photopreview['btn_retry']).when(ButtonClipEvent.CLICK, onClickRetry);
		}
		
		private function onClickRetry(e:Event):void{
			photobooth.reset();
		}
	}
}
