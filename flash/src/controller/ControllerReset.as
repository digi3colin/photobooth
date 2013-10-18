package controller {
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;
	import com.digi3studio.photobooth.form.FormSession;
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerReset {
		private var btnRetry:ButtonClip;
		private var photobooth:PhotoboothStates;
		private var timer : Timer;
		private var btnCancel : ButtonClip;
		private var formNameAndEmail : FormNameAndEmail;
		private var formPhotoSnap : FormPhotoSnap;

		public function ControllerReset(mcPhotoPreview : Sprite, photobooth : PhotoboothStates, formNameAndEmail : FormNameAndEmail, formPhotoSnap : FormPhotoSnap) {
			timer = new Timer(2000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, doReset,false, 0, true);
			this.photobooth = photobooth;
			this.formNameAndEmail = formNameAndEmail;
			this.formPhotoSnap = formPhotoSnap;
			formNameAndEmail.when(FormNameAndEmail.EVENT_SUBMIT_END, submitEnd);
			formPhotoSnap.when(FormPhotoSnap.EVENT_SUBMIT_END, submitEnd);

			btnRetry = new ButtonClip(mcPhotoPreview['mc_form']['btn_retry']).when(ButtonClipEvent.CLICK, userReset);
			btnCancel = new ButtonClip(mcPhotoPreview['mc_status']['btn_cancel']).when(ButtonClipEvent.CLICK, userCancel);
		}

		private function submitEnd(e:Event):void{
			timer.reset();
			timer.start();
		}

		private function userReset(e:Event):void{
			FASTLog.instance().log('ACTION : USER RESET at '+new Date().time, FASTLog.LOG_LEVEL_ACTION);
			doReset(e);
		}

		private function userCancel(e:Event):void{
			formNameAndEmail.clear();
			formPhotoSnap.clear();
			FASTLog.instance().log('ACTION : USER CANCEL at '+new Date().time, FASTLog.LOG_LEVEL_ACTION);
			doReset(e);
		}

		private function doReset(e : Event) : void {
			photobooth.reset();
			FormSession.id = "";
		}
	}
}
