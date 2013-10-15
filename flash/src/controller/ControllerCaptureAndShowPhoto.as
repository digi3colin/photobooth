package controller {
	import asset.MainView;

	import com.digi3studio.photobooth.PhotoCapture;

	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerCaptureAndShowPhoto {
		private var mainView:MainView;
		private var photobooth:PhotoboothStates;
		private var photoCapture : PhotoCapture;
		private var preview : Bitmap;
		private var mcPreviewCapture:Sprite;

		public function ControllerCaptureAndShowPhoto(mainView : MainView, photobooth : PhotoboothStates, photoCapture : PhotoCapture) {
			this.mainView = mainView;
			this.photobooth = photobooth;
			this.photoCapture = photoCapture;

			//set the preview bitmap;
			this.mcPreviewCapture = mainView.mc_photopreview['mc_send_preview']['mc_preview_capture'];
			mcPreviewCapture.addChild(this.preview = new Bitmap(null,PixelSnapping.AUTO,true));

			this.photobooth.when(PhotoboothStates.EVENT_SHOT, onPhotoboothShot);
		}
		
		private function onPhotoboothShot(e:Event):void{
			//after shot, capture photo
			var targetSizeReference:Sprite = mainView.mc_photopreview['mc_send_preview']['mc_preview_capture']['mc_photo_size'];
			this.photoCapture.capture(
				mainView.mc_photobooth['mc_photo'], 
				AppConfig.CAMERA_ID, 
				AppConfig.CAMERA_WIDTH, 
				AppConfig.CAMERA_HEIGHT, 

				targetSizeReference.width, 
				targetSizeReference.height
			);

			//place the captured photo to mcPhotoPreview
			this.preview.bitmapData = this.photoCapture.getPhotoBitmapData();
			//after capture, photobooth show the preview
			this.photobooth.view();
		}
	}
}
