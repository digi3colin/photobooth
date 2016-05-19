package controller {
	import flash.utils.clearInterval;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;
	import com.digi3studio.photobooth.form.FormSession;
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerReset {
		private var btnRetry:ButtonClip;
		private var photobooth:PhotoboothStates;

		private var btnCancel : ButtonClip;
		private var formNameAndEmail : FormNameAndEmail;
		private var formPhotoSnap : FormPhotoSnap;
		private var btnRetryOnEdit : ButtonClip;
		
		private var iid:int;

		public function ControllerReset(mcPhotoPreview : Sprite, photobooth : PhotoboothStates, formNameAndEmail : FormNameAndEmail, formPhotoSnap : FormPhotoSnap) {
			this.photobooth = photobooth;
			this.formNameAndEmail = formNameAndEmail;
			this.formPhotoSnap = formPhotoSnap;
			this.photobooth.when(PhotoboothStates.EVENT_SAVE_POST, onEmailSend);
			
			btnRetry = new ButtonClip(mcPhotoPreview['mc_form']['btn_retry']).when(ButtonClipEvent.CLICK, userReset);
			btnRetryOnEdit = new ButtonClip(mcPhotoPreview['mc_editor']['btn_retry']).when(ButtonClipEvent.CLICK, userReset);
			btnCancel = new ButtonClip(mcPhotoPreview['mc_status']['btn_cancel']).when(ButtonClipEvent.CLICK, userCancel);
		}

		private function onEmailSend(e:Event):void{
			clearInterval(iid);
			iid = setTimeout(onEmailSendTimeout,5000);//5sec timeout

			formNameAndEmail.when(FormNameAndEmail.EVENT_SUBMIT_END, onNameSubmitEnd);
		}

		private function onEmailSendTimeout():void{
			//giveup to wait the response..
			this.formNameAndEmail.submitPending();
			clearInterval(iid);
			iid = setTimeout(doReset, 2000);
		}

		private function onNameSubmitEnd(e:Event):void{
			clearInterval(iid);
			iid = setTimeout(doReset, 2000);
		}

		private function userReset(e:Event):void{
			FASTLog.instance().log('ACTION : USER RESET at '+new Date().time, FASTLog.LOG_LEVEL_ACTION);
			doReset();
		}

		private function userCancel(e:Event):void{
			formNameAndEmail.clear();
			formPhotoSnap.clear();
			FASTLog.instance().log('ACTION : USER CANCEL at '+new Date().time, FASTLog.LOG_LEVEL_ACTION);
			doReset();
		}

		private function doReset() : void {
			clearInterval(iid);
			formNameAndEmail.removeEventListener(FormNameAndEmail.EVENT_SUBMIT_END, onNameSubmitEnd);
			photobooth.reset();
			FormSession.id = "";
		}
	}
}
