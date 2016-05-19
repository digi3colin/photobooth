package com.digi3studio.photobooth {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.log.FASTLog;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * @author Digi3
	 */
	public class ToggleLogo extends FASTEventDispatcher {
		public static const EVENT_UPDATE:String = 'onUpdate';
		private var btn:Sprite;
		public function ToggleLogo(btn:Sprite) {
			this.btn = btn;

			if(btn!=null)btn.addEventListener(MouseEvent.MOUSE_DOWN, toggleLogo,false,0,true);
		}
		
		public function init():void{
			load();
			update();
		}
		
		private function toggleLogo(e:Event):void{
			AppConfig.SHOW_LOGO = !AppConfig.SHOW_LOGO;
			update();
			save();
			//store setting?
		}
		
		private function update():void{
			this.dispatchEvent(new Event(ToggleLogo.EVENT_UPDATE));
		}

		private static var FILE_SETTING:String = 'setting2';
		private function load():void{
			var str:String = AppConfig.TEXT_IO.load(FILE_SETTING);
			if(str=='')return;
			var setting:Object = JSON.parse(str);
			//apply
			if(setting['showLogo']!=null)AppConfig.SHOW_LOGO = setting['showLogo'];
		}

		private function save():void{
			var settings:Object = {};
			settings['showLogo'] = AppConfig.SHOW_LOGO;

			AppConfig.TEXT_IO.save(FILE_SETTING, JSON.stringify(settings));
			FASTLog.instance().log("setting saved", FASTLog.LOG_LEVEL_ACTION);
		}
	}
}
