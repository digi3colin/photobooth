﻿package {
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
		public static var BASE_URL : String = "BASE_URL";
		
		public static var SEND_PATH : String = "card/send.xml?sessionid=";
		public static var UPLOAD_PATH : String = "file/upload.xml?name=asset&folder=card";
	
		public static var SHOT_COUNTDOWN:int = 3;

		public static var CARD_MAX_WIDTH:Number;
		public static var CARD_MAX_HEIGHT:Number;

		public static var CARD_SIZE_WIDTH:Number = 580;
		public static var CARD_SIZE_HEIGHT:Number = 357;
		public static var CARD_SIZE_SCALE : Number = 0.5686;
		public static var KIOSK_HEIGHT : Number = 1920;
		public static var KIOSK_WIDTH : Number = 1080;
		public static var FIELD_HEIGHT : Number = 100;
		public static var EVENT_ID : String ="testing";

		public static var CAMERA_WIDTH : int	=404;
		public static var CAMERA_HEIGHT : int	=734;
		public static var CAMERA_ID : String = "0";

		public static var IMG_ENCODER : IBitmapDataEncoder;
		public static var TEXT_IO : ISaveText;
		public static var BINARY_IO: ISaveBinary;

		public static var MESSAGE : XML;
		public static var SHOW_LOGO : Boolean = false;
		public static var FIELD_COUNT : Number = 5;

	}
}
