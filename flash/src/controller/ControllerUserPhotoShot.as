package controller {
	import asset.MainView;

	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerUserPhotoShot {
		private var mainView:MainView;
		private var photobooth:PhotoboothStates;
		private var btnShot : ButtonClip;
		private var btnNext : ButtonClip;

		public function ControllerUserPhotoShot(mainView:MainView,photobooth:PhotoboothStates){
			this.mainView = mainView;
			this.photobooth = photobooth;
			btnShot = new ButtonClip(mainView.mc_photobooth['btn_shot']).when(ButtonClipEvent.CLICK,clickShotButton);
			btnNext = new ButtonClip(mainView.mc_photopreview['mc_editor']['btn_next']).when(ButtonClipEvent.CLICK, clickNextAfterEdit);
		}

		private function clickShotButton(e:Event):void{
			//prepare to shot. do real shot after preparation. for example: countdown
			photobooth.prepareShot();
		}
		
		private function clickNextAfterEdit(e:Event):void{
			photobooth.view();
		}
	}
}
