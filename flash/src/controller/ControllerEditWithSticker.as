package controller {
	import asset.IconBat;
	import asset.IconBeard;
	import asset.IconBeard2;
	import asset.IconHat;
	import asset.IconMask;

	import com.fastframework.module.d3mobile.CloneSprite;

	import flash.display.Sprite;
	/**
	 * @author Digi3
	 */
	public class ControllerEditWithSticker {
		public function ControllerEditWithSticker(mcEditor:Sprite,mcSendPreview:Sprite,cloneSprites:Vector.<CloneSprite>):void{
			var dropArea:Sprite      = mcSendPreview['mc_preview_frame'];
			var stickerCanvas:Sprite = mcSendPreview['mc_sticker_canvas'];
			cloneSprites.push(new CloneSprite(mcEditor['icon0'],IconBeard, stickerCanvas,dropArea));
			cloneSprites.push(new CloneSprite(mcEditor['icon1'],IconBeard2,stickerCanvas,dropArea));
			cloneSprites.push(new CloneSprite(mcEditor['icon2'],IconBat,   stickerCanvas,dropArea));
			cloneSprites.push(new CloneSprite(mcEditor['icon3'],IconHat,   stickerCanvas,dropArea));
			cloneSprites.push(new CloneSprite(mcEditor['icon4'],IconMask,  stickerCanvas,dropArea));
		}
	}
}
