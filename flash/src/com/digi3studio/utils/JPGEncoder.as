package com.digi3studio.utils {
	import flash.display.BitmapData;
	import flash.display.JPEGEncoderOptions;
	import flash.utils.ByteArray;
	
	public final class JPGEncoder implements IBitmapDataEncoder
	{
		public function JPGEncoder(){
			
		}
		
		public function encode(img:BitmapData, meta:Object = null):ByteArray{
			var byteArray:ByteArray = new ByteArray();
			img.encode(img.rect, new JPEGEncoderOptions(), byteArray);
			return byteArray;
		}

		public function getMetaData(png:ByteArray):Object{
			return null;
		}
	}
}
