package controller {
	import com.digi3studio.CountDown;
	import com.fastframework.module.d3animate.Animator;
	import com.fastframework.module.d3animate.AnimatorScale;
	import com.fastframework.module.d3animate.MCEnum;
	import com.fastframework.module.d3view.ShowHideView;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerCountdown {
		private var mc:Sprite;
		private var mcStar:Sprite;
		private var countDown:CountDown;

		private var viewSprite:ShowHideView;

		private var anStar : Animator;
		private var photobooth : PhotoboothStates;

		public function ControllerCountdown(mcCountDown : Sprite, countDown : CountDown, photobooth:PhotoboothStates) {
			this.mc = mcCountDown;
			this.viewSprite = new ShowHideView(mc);
			this.photobooth = photobooth;
			this.mcStar = mc['mc_star'];
			
			anStar = new Animator(mcStar, MCEnum.scale);
			anStar.imp = new AnimatorScale();

			photobooth.when(PhotoboothStates.EVENT_START_TO_SHOT, hide);
			photobooth.when(PhotoboothStates.EVENT_PREPARE_SHOT, startCount);

			this.countDown = countDown;
			countDown.when(CountDown.EVENT_COUNTING, counting);
			countDown.when(CountDown.EVENT_START, doStartCount);
			countDown.when(CountDown.EVENT_DONE, countEnd);
		}

		private function startCount(e:Event):void{
			countDown.start();
		}

		private function doStartCount(e:Event):void{
			anStar.fromTo(3,1);
			counting(e);
		}

		private function counting(e:Event):void{
			TextField(mc['mc_count_num']['txt']).text = String(countDown.getCount());
			viewSprite.show();
		}
		
		private function countEnd(e:Event):void{
			photobooth.shot();
		}
		
		private function hide(e:Event):void{
			this.mcStar.visible = false;
			TextField(mc['mc_count_num']['txt']).text = "";
			viewSprite.hide();
		}
	}
}
