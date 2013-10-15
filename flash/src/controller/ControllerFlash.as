package controller {
	import com.fastframework.module.d3animate.Animator;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerFlash {
		private var mc:Sprite;
		private var an:Animator;

		public function ControllerFlash(mc : Sprite, photoSteps : PhotoboothStates) {
			this.mc = mc;

			an = new Animator(mc, 'alpha',1000);
			an.ease = Animator.EASE_LINEAR;
			an.to(0).skip().when(Animator.EVENT_END, hideSprite);

			photoSteps.when(PhotoboothStates.EVENT_VIEW_INPUT_EMAIL, flash);
		}
		
		private function flash(e:Event):void{
			mc.visible = true;
			mc.alpha = 1;
			an.to(0);
		}

		private function hideSprite(e:Event):void{
			mc.visible = false;
		}

	}
}
