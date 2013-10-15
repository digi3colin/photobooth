package {
	import asset.MainView;

	import com.digi3studio.photobooth.PhotoCapture;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	final public class AppDelegate {
		public function AppDelegate(mainView:MainView) {
			//initalize core models
			var photobooth:PhotoboothStates 		= new PhotoboothStates();
			var photoCapture:PhotoCapture 			= new PhotoCapture();
			var formNameAndEmail:FormNameAndEmail 	= new FormNameAndEmail(AppConfig.DEVICE_ID,AppConfig.MESSAGE.toXMLString(),AppConfig.SEND_PATH,AppConfig.EVENT_ID);
			var formPhotoSnap:FormPhotoSnap 		= new FormPhotoSnap(AppConfig.EVENT_ID,AppConfig.UPLOAD_PATH);

			photobooth.start();
		}
	}
}