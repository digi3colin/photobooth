package {
	import controller.ControllerUserRetry;
	import asset.MainView;

	import controller.ControllerCamera;
	import controller.ControllerCaptureAndShowPhoto;
	import controller.ControllerUserPhotoShot;
	import controller.ControllerScreens;

	import com.digi3studio.photobooth.PhotoCapture;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	final public class AppDelegate {
		private var controllers:Array = [];
		
		public function AppDelegate(mainView:MainView) {
			//initalize core models
			var photobooth:PhotoboothStates 		= new PhotoboothStates();
			var photoCapture:PhotoCapture 			= new PhotoCapture();
//			var formNameAndEmail:FormNameAndEmail 	= new FormNameAndEmail(AppConfig.DEVICE_ID,AppConfig.MESSAGE.toXMLString(),AppConfig.SEND_PATH,AppConfig.EVENT_ID);
//			var formPhotoSnap:FormPhotoSnap 		= new FormPhotoSnap(AppConfig.EVENT_ID,AppConfig.UPLOAD_PATH);

			//mock up the application
			controllers.push(new ControllerScreens(mainView, photobooth));
			//bind the camera
			controllers.push(new ControllerCamera(mainView.mc_photobooth['mc_photo']));
			//add the photoshot interaction
			controllers.push(new ControllerUserPhotoShot(mainView,photobooth));
			controllers.push(new ControllerCaptureAndShowPhoto(mainView,photobooth,photoCapture));

			controllers.push(new ControllerUserRetry(mainView,photobooth));
			controllers.push(new ControllerDebugScreens(photobooth));


			photobooth.start();
		}
	}
}