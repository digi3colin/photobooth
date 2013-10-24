package com.digi3studio.photobooth.form {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class CheckBoxView extends FASTEventDispatcher {
		public static const EVENT_INVALID : String = "EVENT_INVALID";

		private var view:MovieClip;
		private var button:ButtonClip;
		private var value:Boolean;
		private var required:Boolean;

		public function CheckBoxView(mc:MovieClip, value:Boolean = false, required:Boolean=true){
			this.view = mc;
			this.value = value;
			this.required = required;
			this.button = new ButtonClip(mc['button']);
			this.button.when(ButtonClipEvent.CLICK, onButtonClick);
			update();
		}

		private function onButtonClick(e:Event):void{
			this.value = !this.value;
			update();
		}

		private function update():void{
			this.view.gotoAndStop((this.value?'on':'off'));
		}

		public function getValue():Boolean{
			return value;
		}

		public function validate() : Boolean {
			if(this.required){
				if(value == false){
					dispatchEvent(new Event(CheckBoxView.EVENT_INVALID));
				}
				return value;
			}
			return true;
		}
	}
}