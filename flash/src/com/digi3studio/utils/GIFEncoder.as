package com.digi3studio.utils {
	import org.bytearray.gif.encoder.GIFEncoder;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.utils.ByteArray;
	/**
	 * @author Digi3
	 */
	public class GIFEncoder implements IBitmapDataEncoder{
		public function GIFEncoder(){
		}

		public function encode(img:BitmapData, meta:Object = null):ByteArray{
			var gif:org.bytearray.gif.encoder.GIFEncoder = new org.bytearray.gif.encoder.GIFEncoder();
			gif.setRepeat(0);
			gif.setDelay(500);
			gif.start();

			var bursts:Number = meta['bursts'];

			for(var i:int=0;i<bursts;i++){
				var bmp:BitmapData = new BitmapData(meta['frame_width'], meta['frame_height'], false);
				var mtx:Matrix = new Matrix();
				mtx.tx = -meta['frame_width'] * i;
				bmp.draw(img, mtx);
				gif.addFrame(bmp);
			}

			return gif.stream;
		}

		public function getMetaData(png:ByteArray):Object{
			return null;
		}
	}
}
