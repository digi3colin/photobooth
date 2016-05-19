package controller {
	import flash.utils.clearInterval;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setInterval;
	/**
	 * @author Digi3
	 */
	public class ControllerBurstLoop {
		private var mcPreview : Sprite;
		private var state : PhotoboothStates;
		private var iid: int;
		private var loopId: int;
		private var frames:Vector.<Bitmap>;
		
		public function ControllerBurstLoop(mcPhotoPreview:Sprite, state:PhotoboothStates){
			this.mcPreview = mcPhotoPreview['mc_send_preview']['mc_preview_capture'];
			this.state     = state;
			this.state.addEventListener(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL, this.preview);
			this.state.addEventListener(PhotoboothStates.EVENT_SAVE_POST, this.onSave);
		}
		
		private function preview(e:Event):void{
			loopId = 0;
			clearInterval(iid);
			iid = setInterval(this.loop, 500);
			this.frames = new Vector.<Bitmap>();

			for(var i:Number = 0; i<this.mcPreview.numChildren; i ++){
				var obj:DisplayObject = this.mcPreview.getChildAt(i);

				if(obj is Bitmap && obj.visible){
					this.frames.push(obj);
				}
			};
		}
		
		private function loop():void{
			for(var i:int = 0; i<this.frames.length; i++){
				this.frames[i].alpha = 0;
			}
			
			this.frames[this.loopId].alpha = 1;
			
			this.loopId++;
			if(this.loopId >= this.frames.length){
				this.loopId = 0;
			}
		}

		private function onSave(e:Event):void{
			clearInterval(iid);
			for(var i:int = 0; i<this.frames.length; i++){
				this.frames[i].alpha = 1;
			}
		}
	}
}
