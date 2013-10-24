package controller {
	import flash.display.MovieClip;
	import com.fastframework.module.d3animate.Animator;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;



	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerTerms {
		private var btnEN:ButtonClip;
		private var btnKR:ButtonClip;
		private var btnClose:ButtonClip;

		private var an:Animator;
		private var panel:Sprite;
		private var mcTxt:MovieClip;

		public function ControllerTerms(mcTermsButtonEN : Sprite, mcTermsButtonKR:Sprite, mcTerms:Sprite) {
			mcTxt = mcTerms['txt_terms'];

			btnEN = new ButtonClip(mcTermsButtonEN);
			btnKR = new ButtonClip(mcTermsButtonKR);
			btnClose = new ButtonClip(mcTerms['btn_close']);

			an = new Animator(panel = mcTerms,'y',500);
			btnEN.when(ButtonClipEvent.CLICK, showEN);
			btnKR.when(ButtonClipEvent.CLICK, showKR);
			btnClose.when(ButtonClipEvent.CLICK, hide);
		}

		private function showEN(e:Event):void{
			mcTxt.gotoAndStop('en');
			an.to(AppConfig.KIOSK_HEIGHT - panel.height);
		}

		private function showKR(e:Event):void{
			mcTxt.gotoAndStop('kr');
			an.to(AppConfig.KIOSK_HEIGHT - panel.height);
		}

		private function hide(e:Event):void{
			an.to(AppConfig.KIOSK_HEIGHT);
		}
	}
}
