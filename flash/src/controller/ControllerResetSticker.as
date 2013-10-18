package controller {
	import com.fastframework.module.d3mobile.CloneSprite;

	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerResetSticker {
		private var cloneSprites : Vector.<CloneSprite>;
		public function ControllerResetSticker(photobooth : PhotoboothStates, cloneSprites : Vector.<CloneSprite>) {
			this.cloneSprites = cloneSprites;
			photobooth.when(PhotoboothStates.EVENT_RESET, onReset);
		}
		private function onReset(e:Event):void{
			for(var i:int=0;i<this.cloneSprites.length;i++){
				cloneSprites[i].killClones();
			}
		}
	}
}
