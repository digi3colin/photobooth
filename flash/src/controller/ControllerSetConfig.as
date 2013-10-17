package controller {
	import flash.display.Sprite;
	import flash.media.Video;
	/**
	 * @author Digi3
	 */
	public class ControllerSetConfig {
		public function ControllerSetConfig(mc_photobooth:Sprite){
			var vid:Video = Video(mc_photobooth['mc_photo']['mc_video']['vid_camera']);
			AppConfig.CAMERA_WIDTH  = vid.width;
			AppConfig.CAMERA_HEIGHT = vid.height;
		}
	}
}
