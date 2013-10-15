package com.digi3studio.photobooth {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.log.FASTLog;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class PhotoCapture extends FASTEventDispatcher {
		public static const EVENT_CAPTURE_DONE : String = 'EVENT_CAPTURE_DONE';
		private var photo : BitmapData;

		public function PhotoCapture() {
		}

		public function capture(mcPhoto:Sprite,camera_id:String,camera_width:Number,camera_height:Number,capture_width:Number,capture_height:Number):void{
			var vid:Video = mcPhoto['mc_video']['vid_camera'];
			var cam:Camera = Camera.getCamera(camera_id);

			var bdPhoto:BitmapData = new BitmapData(cam.width, cam.height,false);
			cam.drawToBitmapData(bdPhoto);
			/*draw to mc_film to add filter*/
			var bmp:Bitmap = new Bitmap(bdPhoto,PixelSnapping.NEVER,true);

			FASTLog.instance().log(bmp.height+','+vid.height+','+cam.height, FASTLog.LOG_LEVEL_ACTION);

			Sprite(mcPhoto['mc_video']).addChild(bmp);
			bmp.width = vid.width;
			bmp.height = vid.height;

			var m:Matrix = new Matrix();
			m.scale(capture_width/camera_width, capture_height/camera_height);

			photo = new BitmapData(capture_width, capture_height, false);
			photo.draw(mcPhoto,m,null,null,null,true);

			Sprite(mcPhoto['mc_video']).removeChild(bmp);

			dispatchEvent(new Event(PhotoCapture.EVENT_CAPTURE_DONE));
		}

		public function getPhotoBitmapData():BitmapData{
			return photo;
		}
	}
}
