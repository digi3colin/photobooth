package com.digi3studio.utils {
	import asset.MainView;

	import com.fastframework.module.d3crossplatform.IMain;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	//MainHelper to make sure application start after all asset loaded.
	public class MainHelper implements IMain {
		private var delegate:IMain;
		private var main:Sprite;
		private var mainView:MainView;

		public function MainHelper(main:Sprite,mainView:MainView, delegate:IMain) {
			//setup stage align
			this.delegate = delegate;
			this.mainView = mainView;
			this.main = main;
			this.main.addChild(mainView);

			main.stage.align 	 = StageAlign.TOP_LEFT;
			main.stage.scaleMode = StageScaleMode.NO_SCALE;

			main.addEventListener(Event.EXIT_FRAME, doNextFrame);
		}

		private function doNextFrame(e : Event) : void {
			main.removeEventListener(Event.EXIT_FRAME, doNextFrame);
			start();
		}

		public function start() : void {
			delegate.start();
			main = null;
			delegate = null;
		}
	}
}
