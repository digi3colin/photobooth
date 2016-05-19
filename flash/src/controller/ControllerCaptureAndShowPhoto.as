package controller {
	import asset.MainView;

	import com.digi3studio.photobooth.BurstPreview;
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
		private var previews : Vector.<Bitmap>;
		private var mcCamera:Sprite;
		private var mcPhotoToCapture:Sprite;
		private var mcPreviewCapture:Sprite;
		private var burstPreviews:Vector.<BurstPreview>;
		
		private var burstCount:int;
		private var burstIndex:int;

		public function ControllerCaptureAndShowPhoto(mainView : MainView, photobooth : PhotoboothStates, photoCapture : PhotoCapture, burstCount:int) {
			this.mainView = mainView;
			this.mcCamera = mainView.mc_photobooth['mc_camera'];
			this.mcPhotoToCapture = this.mcCamera['mc_photo'];
			this.photobooth = photobooth;
			this.photoCapture = photoCapture;
			this.burstCount = burstCount;

			this.previews = new Vector.<Bitmap>();
			this.burstPreviews = new Vector.<BurstPreview>();

			//set the preview bitmap;
			this.mcPreviewCapture = mainView.mc_photopreview['mc_send_preview']['mc_preview_capture'];

			for(var i:int=0;i<burstCount;i++){
				this.previews[i] = new Bitmap(null,PixelSnapping.AUTO,true);
				mcPreviewCapture.addChild(this.previews[i]);
				this.burstPreviews[i] = new BurstPreview(this.mcCamera['burst'+i], AppConfig.CAMERA_WIDTH, AppConfig.CAMERA_HEIGHT);
			}

			this.photobooth.when(PhotoboothStates.EVENT_START_TO_SHOT, onPhotoShotStart);
			this.photobooth.when(PhotoboothStates.EVENT_SHOT, onPhotoboothShot);
		}

		private function onPhotoShotStart(e:Event):void{
			this.burstIndex = 0;

			//reset burst previews;
			for(var i:int=0;i<burstCount;i++){
				this.burstPreviews[i].reset();
			}
		}

		private function onPhotoboothShot(e:Event):void{
			//after shot, capture photo
			var targetSizeReference:Sprite = mainView.mc_photopreview['mc_send_preview']['mc_preview_capture']['mc_photo_size'];
			this.photoCapture.capture(
				this.mcPhotoToCapture, 
				AppConfig.CAMERA_ID, 
				AppConfig.CAMERA_WIDTH, 
				AppConfig.CAMERA_HEIGHT, 

				targetSizeReference.width, 
				targetSizeReference.height
			);

			//place the captured photo to mcPhotoPreview

			this.previews[this.burstIndex].bitmapData = this.photoCapture.getPhotoBitmapData();
			this.burstPreviews[this.burstIndex].draw(this.previews[this.burstIndex].bitmapData);

			this.burstIndex++;

			if(this.burstIndex >= this.burstCount){
				//after capture, photobooth show the preview
				this.photobooth.edit();				
			}else{
				this.photobooth.prepareShot();
			}
		}
	}
}
