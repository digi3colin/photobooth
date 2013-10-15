﻿package {
	import asset.MainView;

	import controller.ControllerAddRemoveFriend;
	import controller.ControllerCamera;
	import controller.ControllerCaptureAndShowPhoto;
	import controller.ControllerCountdown;
	import controller.ControllerFlash;
	import controller.ControllerLog;
	import controller.ControllerSaveData;
	import controller.ControllerScreens;
	import controller.ControllerScrollFields;
	import controller.ControllerUserPhotoShot;
	import controller.ControllerUserRetry;
	import controller.ControllerValidateForm;

	import com.digi3studio.CountDown;
	import com.digi3studio.PhotoComposition;
	import com.digi3studio.photobooth.PhotoCapture;
	import com.digi3studio.photobooth.form.FieldGroup;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;
	import com.digi3studio.utils.PNGEncoder;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	final public class AppDelegate {
		private var controllers:Array = [];
		
		public function AppDelegate(mainView:MainView) {
			controllers.push(new ControllerLog());
			//initalize core models
			var photobooth:PhotoboothStates 		= new PhotoboothStates();
			var photoCapture:PhotoCapture 			= new PhotoCapture();
			var formNameAndEmail:FormNameAndEmail 	= new FormNameAndEmail(AppConfig.DEVICE_ID,AppConfig.MESSAGE.toXMLString(),AppConfig.BASE_URL+AppConfig.SEND_PATH,AppConfig.EVENT_ID);
			var formPhotoSnap:FormPhotoSnap 		= new FormPhotoSnap(AppConfig.EVENT_ID, AppConfig.BASE_URL+AppConfig.UPLOAD_PATH);

			var fieldGroup:FieldGroup				= new FieldGroup();
			var countDown:CountDown					= new CountDown(AppConfig.SHOT_COUNTDOWN);

			var photoComposition:PhotoComposition   = new PhotoComposition(new PNGEncoder());
			//mock up the application
			controllers.push(new ControllerScreens(mainView, photobooth));
			//add the photoshot interaction
			controllers.push(new ControllerUserPhotoShot(mainView,photobooth));
			controllers.push(new ControllerUserRetry(mainView,photobooth));
			//bind the camera
			controllers.push(new ControllerCamera(mainView.mc_photobooth['mc_photo']));
			controllers.push(new ControllerCaptureAndShowPhoto(mainView,photobooth,photoCapture));

			//form ui
			controllers.push(new ControllerAddRemoveFriend(mainView.mc_photopreview, fieldGroup, photobooth));
			controllers.push(new ControllerScrollFields(mainView.mc_photopreview,fieldGroup));
			controllers.push(new ControllerValidateForm(mainView.mc_photopreview,photobooth,formNameAndEmail,formPhotoSnap,fieldGroup));

			//flashing 
			controllers.push(new ControllerFlash(mainView.mc_flash,photobooth));
			controllers.push(new ControllerCountdown(mainView.mc_photobooth['mc_countdown'], countDown, photobooth));

			//save data
			controllers.push(new ControllerSaveData(mainView.mc_photopreview, photobooth, fieldGroup, formNameAndEmail, formPhotoSnap, photoComposition));
	
			photobooth.start();
		}
	}
}