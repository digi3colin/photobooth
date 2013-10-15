package {
	import com.digi3studio.photobooth.form.FieldGroup;
	import controller.ControllerAddRemoveFriend;
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

			var fieldGroup:FieldGroup				= new FieldGroup();

			//mock up the application
			controllers.push(new ControllerScreens(mainView, photobooth));
			//add the photoshot interaction
			controllers.push(new ControllerUserPhotoShot(mainView,photobooth));
			controllers.push(new ControllerUserRetry(mainView,photobooth));
			//bind the camera
			controllers.push(new ControllerCamera(mainView.mc_photobooth['mc_photo']));
			controllers.push(new ControllerCaptureAndShowPhoto(mainView,photobooth,photoCapture));

			//form
			controllers.push(new ControllerAddRemoveFriend(mainView.mc_photopreview, fieldGroup, photobooth));


			photobooth.start();
		}
	}
}