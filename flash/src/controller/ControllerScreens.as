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
		private var viewForm:IView;
		private var viewEditor:IView;

		public function ControllerScreens(mc : MainView, photobooth : PhotoboothStates) {
			viewPhotoBooth 		= new ShowHideView(mc.mc_photobooth);
			viewPhotoPreview	= new ShowHideView(mc.mc_photopreview);
			viewForm 			= new ShowHideView(mc.mc_photopreview['mc_form']);
			viewEditor			= new ShowHideView(mc.mc_photopreview['mc_editor']);

			photobooth.when(PhotoboothStates.EVENT_EDIT, showCard);
			photobooth.when(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL, showForm);
			photobooth.when(PhotoboothStates.EVENT_IDLE, readyToShot);
		}

		private function readyToShot(e:Event):void{
			viewPhotoBooth.show();
			viewPhotoPreview.hide();
		}

		private function showCard(e:Event):void{
			viewPhotoBooth.getView().visible = false;
			viewPhotoBooth.getView().alpha = 0;
			viewPhotoBooth.hide();
			viewPhotoPreview.show();

			viewForm.getView().visible=false;
			viewForm.getView().alpha=0;
			viewForm.hide();
			
			viewEditor.show();
		}
		
		private function showForm(e:Event):void{
			viewEditor.hide();
			viewForm.show();
		}
	}
}
