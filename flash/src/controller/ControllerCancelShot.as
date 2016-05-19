package controller {
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerCancelShot {
		private var model:PhotoboothStates;
		private var btn:ButtonClip;
		
		public function ControllerCancelShot(view:Sprite, model:PhotoboothStates){
			this.model = model;
			this.btn = new ButtonClip(view['mc_camera']['btn_delete']);
			this.btn.addEventListener(ButtonClipEvent.MOUSE_DOWN, this.onCancel);
		}

		private function onCancel(e:Event):void{
			this.model.reset();
		}
	}
}
