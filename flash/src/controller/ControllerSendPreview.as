package controller {
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerSendPreview {
		private var mc:Sprite;
		public function ControllerSendPreview(mcSendPreview : Sprite, photobooth : PhotoboothStates){
			this.mc = mcSendPreview;
			photobooth.addEventListener(PhotoboothStates.EVENT_EDIT, this.onEdit);
			photobooth.addEventListener(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL, onForm);
		}
		
		private function onEdit(e:Event):void{
			this.mc.visible = false;
		}
		
		private function onForm(e:Event):void{
			this.mc.visible = true;
		}
	}
}
