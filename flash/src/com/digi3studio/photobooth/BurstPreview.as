package com.digi3studio.photobooth {
	import flash.display.PixelSnapping;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	/**
	 * @author Digi3
	 */
	public class BurstPreview{
		private var pic:Bitmap;
		private var w:Number;
		private var h:Number;

		public function BurstPreview(mc:Sprite, w:Number, h:Number) {
			this.w = w;
			this.h = h;
			this.pic = new Bitmap(null, PixelSnapping.AUTO, true);
			mc.addChildAt(this.pic, 1);
			this.reset();
		}
		
		public function reset():void{
			this.pic.bitmapData = new BitmapData(this.w, this.h, false, 0xFF333333);
		}
		
		public function draw(bmp:BitmapData):void{
			this.pic.bitmapData.draw(bmp);
		}
	}
}
