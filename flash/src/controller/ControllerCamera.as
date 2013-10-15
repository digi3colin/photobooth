package controller {
	import com.fastframework.log.FASTLog;

	import flash.display.Sprite;
	import flash.media.Camera;
	import flash.media.Video;
	/**
	 * @author Digi3
	 */
	public class ControllerCamera {
		private var camera : Camera;
		private var mcPhoto : Sprite;
		private var video : Video;

		public function ControllerCamera(mcPhoto:Sprite){
			this.mcPhoto = mcPhoto;
			video = mcPhoto['mc_video']['vid_camera'];
			video.deblocking = 0;
			video.smoothing = true;
			video.height = AppConfig.CAMERA_HEIGHT;

//			if(btnSwap!=null)btnSwap.addEventListener(MouseEvent.MOUSE_DOWN, swapCamera);
			updateCamera();
		}
		
/*		private function swapCamera(e:Event):void
		{
			//change camera id
			//flip video object;
			AppConfig.CAMERA_ID = AppConfig.CAMERA_ID=="0"?"1":"0";
			updateCamera();
		}*/
		
		private function updateCamera():void{
            camera = Camera.getCamera(AppConfig.CAMERA_ID);

            if (!camera) {
				FASTLog.instance().log('camera cannot connect', FASTLog.LOG_LEVEL_ERROR);
                return;
            }
			FASTLog.instance().log('camera info[w:'+camera.width+',h:'+camera.height+']', FASTLog.LOG_LEVEL_ACTION);
            camera.setQuality(0, 100);
            camera.setMode(AppConfig.CAMERA_WIDTH, AppConfig.CAMERA_HEIGHT, 30, false);
			FASTLog.instance().log('camera new setting[w:'+camera.width+',h:'+camera.height+',request:'+AppConfig.CAMERA_WIDTH+','+AppConfig.CAMERA_HEIGHT+']', FASTLog.LOG_LEVEL_ACTION);

			//adjust video ratio
			var preferRatio:Number = Math.round(AppConfig.CAMERA_WIDTH/AppConfig.CAMERA_HEIGHT*100);
			var currRatio:Number = Math.round(camera.width/camera.height*100);
			FASTLog.instance().log('ratio:0.'+preferRatio+',0.'+currRatio,FASTLog.LOG_LEVEL_ACTION);
			if(currRatio!=preferRatio){
				FASTLog.instance().log('adject camera ratio to:'+currRatio,FASTLog.LOG_LEVEL_ACTION);
				video.height = AppConfig.CAMERA_WIDTH/(currRatio/100);
			}

			video.attachCamera(camera);
		}
	}
}
