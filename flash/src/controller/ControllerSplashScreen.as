package controller {
	import com.fastframework.module.d3animate.Animator;

	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerSplashScreen {
		private var mcPhotoBooth:Sprite;
		private var state:PhotoboothStates;
		
		private var aniCamera:Animator;
		private var aniControl:Animator;
		
		private var btnShot:Sprite;

		public function ControllerSplashScreen(mcPhotoBooth:Sprite, state:PhotoboothStates){
			this.mcPhotoBooth = mcPhotoBooth;
			this.state = state;

			var mcCamera:Sprite = this.mcPhotoBooth['mc_camera'];
			this.btnShot = this.mcPhotoBooth['btn_shot'];
			mcCamera.alpha = 0;

			aniCamera  = new Animator(mcCamera, 'alpha');
			aniControl = new Animator(btnShot, 'alpha');
			
			this.state.addEventListener(PhotoboothStates.EVENT_IDLE, onIdle);
			this.state.addEventListener(PhotoboothStates.EVENT_START_TO_SHOT, onStart);
		}
		
		private function onIdle(e:Event):void{
			SimpleButton(this.btnShot['btn']).visible = true;
			this.btnShot.mouseEnabled = false;
			this.aniCamera.to(0);
			this.aniControl.to(1);
		}
		
		private function onStart(e:Event):void{
			SimpleButton(this.btnShot['btn']).visible = false;
			this.btnShot.mouseEnabled = true;
			this.aniCamera.to(1);
			this.aniControl.to(0);
		}
	}
}
