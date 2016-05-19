package {
	import controller.ControllerCancelShot;
	import controller.ControllerSendPreview;
	import asset.MainView;

	import controller.ControllerAddRemoveFriend;
	import controller.ControllerAdminEventName;
	import controller.ControllerBurstLoop;
	import controller.ControllerCamera;
	import controller.ControllerCaptureAndShowPhoto;
	import controller.ControllerCountdown;
	import controller.ControllerEditBurst;
	import controller.ControllerFlash;
	import controller.ControllerFormSubmitStatus;
	import controller.ControllerGenerateDeviceId;
	import controller.ControllerInvaildMessage;
	import controller.ControllerLocalStorage;
	import controller.ControllerReset;
	import controller.ControllerSaveData;
	import controller.ControllerScreens;
	import controller.ControllerScrollFields;
	import controller.ControllerSetConfig;
	import controller.ControllerShowAdminPanel;
	import controller.ControllerSplashScreen;
	import controller.ControllerSwapCamera;
	import controller.ControllerTerms;
	import controller.ControllerUserPhotoShot;
	import controller.ControllerValidateForm;

	import com.digi3studio.CountDown;
	import com.digi3studio.PhotoComposition;
	import com.digi3studio.photobooth.PhotoCapture;
	import com.digi3studio.photobooth.form.CheckBoxView;
	import com.digi3studio.photobooth.form.FieldGroup;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;
	import com.digi3studio.utils.JPGEncoder;

	import flash.display.Sprite;

	
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	final public class AppDelegate {
		private var controllers:Array = [];
		
		public function AppDelegate(mainView:MainView) {
//			controllers.push(new ControllerLog());
			controllers.push(new ControllerGenerateDeviceId(AppConfig.TEXT_IO));

			//initalize core models
			var photoCamera:Sprite                  = mainView.mc_photobooth['mc_camera'];

			var photobooth:PhotoboothStates 		= new PhotoboothStates();
			var photoCapture:PhotoCapture 			= new PhotoCapture();
			var formNameAndEmail:FormNameAndEmail 	= new FormNameAndEmail(AppConfig.DEVICE_ID,AppConfig.MESSAGE,AppConfig.BASE_URL+AppConfig.SEND_PATH,AppConfig.EVENT_ID);
			var formPhotoSnap:FormPhotoSnap 		= new FormPhotoSnap(AppConfig.EVENT_ID, AppConfig.BASE_URL+AppConfig.UPLOAD_PATH, 'jpg');
			var consentBox:CheckBoxView				= new CheckBoxView(mainView.mc_photopreview['mc_form']['mc_checkbox'],AppConfig.DEFAULT_PRIVACY_CHECKBOX_VALUE);

			var fieldGroup:FieldGroup				= new FieldGroup();
			var countDown:CountDown					= new CountDown(AppConfig.SHOT_COUNTDOWN);

			var photoComposition:PhotoComposition   = new PhotoComposition(new JPGEncoder(), AppConfig.CARD_SIZE_SCALE, AppConfig.CARD_SIZE_WIDTH, AppConfig.CARD_SIZE_HEIGHT);
//			var cloneSprites:Vector.<CloneSprite>   = new Vector.<CloneSprite>();

			//adjust the AppConfig
			controllers.push(new ControllerSetConfig(photoCamera));
			//mock up the application
			controllers.push(new ControllerScreens(mainView, photobooth));
			//add the photoshot interaction
			controllers.push(new ControllerUserPhotoShot(mainView, photobooth));

			//flashing 
			controllers.push(new ControllerFlash(mainView.mc_flash,photobooth));
			controllers.push(new ControllerCountdown(photoCamera['mc_countdown'], countDown, photobooth));

			//bind the camera
			controllers.push(new ControllerCamera(photoCamera['mc_photo']));
			controllers.push(new ControllerCaptureAndShowPhoto(mainView, photobooth, photoCapture, AppConfig.BURST_COUNT));
			controllers.push(new ControllerSwapCamera(mainView.mc_photobooth['btn_flipcam'], photoCamera['mc_photo']));

			//form ui
			controllers.push(new ControllerAddRemoveFriend(mainView.mc_photopreview['mc_form'], fieldGroup, photobooth,AppConfig.FIELD_COUNT,AppConfig.FIELD_HEIGHT));
			controllers.push(new ControllerScrollFields(mainView.mc_photopreview['mc_form'],fieldGroup,AppConfig.FIELD_COUNT,AppConfig.FIELD_HEIGHT));
			controllers.push(new ControllerValidateForm(mainView.mc_photopreview['mc_form'],photobooth,formNameAndEmail,formPhotoSnap,fieldGroup,consentBox));

			//validate message and form submit status
			controllers.push(new ControllerInvaildMessage(mainView.mc_photopreview['mc_message'],fieldGroup,formNameAndEmail,photobooth,consentBox));
			controllers.push(new ControllerFormSubmitStatus(mainView.mc_photopreview['mc_status'],formNameAndEmail,formPhotoSnap,photobooth));

			//terms agreement
			controllers.push(new ControllerTerms(
				mainView.mc_photopreview['mc_form']['btn_tems_en'], 
				mainView.mc_photopreview['mc_form']['btn_tems_kr'],
				mainView.mc_photopreview['mc_terms']));


			//edit the photo
			controllers.push(new ControllerEditBurst(mainView.mc_photopreview['mc_editor'], mainView.mc_photopreview['mc_send_preview'], photobooth, AppConfig.BURST_COUNT));
			controllers.push(new ControllerSendPreview(mainView.mc_photopreview['mc_send_preview'], photobooth));
//			controllers.push(new ControllerResetSticker(photobooth,cloneSprites));
//			controllers.push(new ControllerDragOutDelete(cloneSprites));

			//save data
			controllers.push(new ControllerSaveData(mainView.mc_photopreview, photobooth, fieldGroup, formNameAndEmail, formPhotoSnap, photoComposition,AppConfig.CARD_TITLE_COLOR));

			//save data to local device
			controllers.push(new ControllerLocalStorage(mainView.mc_photopreview, photobooth, photoComposition, fieldGroup, AppConfig.BINARY_IO, AppConfig.TEXT_IO));

			//reset after submit data timeout
			controllers.push(new ControllerReset(mainView.mc_photopreview, photobooth, formNameAndEmail, formPhotoSnap));

			//administrator features
			controllers.push(new ControllerShowAdminPanel(mainView.mc_admin,mainView.btn_admin));
			controllers.push(new ControllerAdminEventName(mainView.mc_admin,mainView.mc_photobooth,mainView.mc_photopreview,AppConfig.TEXT_IO,AppConfig.MESSAGE));

			//splash screen like mobile version
			controllers.push(new ControllerSplashScreen(mainView.mc_photobooth, photobooth));
			controllers.push(new ControllerBurstLoop(mainView.mc_photopreview, photobooth));
			
			//cancel shot
			controllers.push(new ControllerCancelShot(mainView.mc_photobooth,photobooth));
			
			controllers.push(new ControllerDebugScreens(photobooth)); 
			photobooth.init();
		}
	}
}