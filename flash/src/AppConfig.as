package {
	import com.fastframework.io.IBitmapDataEncoder;
	import com.fastframework.io.ISaveBinary;
	import com.fastframework.io.ISaveText;
	/**
	 * @author Digi3Studio - Colin Leung
	 */
	//config for application
	public class AppConfig {
		public static var DEVICE_ID : String = "";
		public static var REMOTE_SERVER : String = "";
		public static var BASE_URL : String = 'http://vc.digi3studio.com/kr_kr/sayitwithclicquot2016-kr/';
		public static var EVENT_ID : String = 'kr_sayitwithclicquot2016';

		public static var SEND_PATH : String = "card/send.xml?format=gif&sessionid=";
		public static var UPLOAD_PATH : String = "file/upload.xml?name=asset&folder=card";

		public static var SHOT_COUNTDOWN:Number = 5;
		public static var BURST_COUNT:int = 4;

		public static var CARD_SIZE_WIDTH:Number = 640;
		public static var CARD_SIZE_HEIGHT:Number = 640;
		public static var CARD_SIZE_SCALE : Number = 640/768;

		public static var KIOSK_WIDTH : Number = 1536;
		public static var KIOSK_HEIGHT : Number = 2048;

		public static var FIELD_HEIGHT : Number = 100;

		public static var CAMERA_WIDTH : int	=768;//404;
		public static var CAMERA_HEIGHT : int	=768;//734;
		public static var CAMERA_ID : String = "0";

		public static var IMG_ENCODER : IBitmapDataEncoder;
		public static var TEXT_IO : ISaveText;
		public static var BINARY_IO: ISaveBinary;

		public static var MESSAGE : XML = new XML('<msg/>');
		public static var SHOW_LOGO : Boolean = false;
		public static var FIELD_COUNT : Number = 5;
		public static var CARD_TITLE_COLOR : int = 0xFFFFFF;
		public static var DEFAULT_PRIVACY_CHECKBOX_VALUE : Boolean = false;
		public static var ENABLE_EDIT:Boolean = true;

		public static var FIRST_BURST_EXTRA_COUNT:Number = 0;
	}
}
