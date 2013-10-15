package controller {
	import asset.MainView;

	import com.fastframework.module.d3view.IView;
	import com.fastframework.module.d3view.ShowHideView;

	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerScreens {
		private var viewPhotoBooth:IView;
		private var viewPhotoPreview:IView;

		private var photobooth:PhotoboothStates;

		public function ControllerScreens(mc : MainView, photobooth : PhotoboothStates) {
			viewPhotoBooth 		= new ShowHideView(mc['mc_photobooth']);
			viewPhotoPreview	= new ShowHideView(mc['mc_photopreview']);

			this.photobooth = photobooth;

			photobooth.when(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL,viewCard);
			photobooth.when(PhotoboothStates.EVENT_START_TO_SHOT, readyToShot);
		}

		private function readyToShot(e:Event):void{
			viewPhotoBooth.show();
			viewPhotoPreview.hide();
		}

		private function viewCard(e:Event):void{
			viewPhotoBooth.getView().visible=false;
			viewPhotoBooth.getView().alpha=0;
			viewPhotoBooth.hide();
			viewPhotoPreview.show();
		}
	}
}
