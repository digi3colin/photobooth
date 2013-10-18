package controller {
	import com.digi3studio.PhotoComposition;
	import com.digi3studio.photobooth.form.FieldGroup;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;




	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerSaveData {
		private var formNameAndEmail:FormNameAndEmail;
		private var formPhotoSnap : FormPhotoSnap;

		private var photobooth : PhotoboothStates;
		private var fieldGroup : FieldGroup;
		private var mcPreview : Sprite;

		private var photoComposition : PhotoComposition;

		private var timerPost:Timer;

		//collect data
		//handing 2 step submit

		public function ControllerSaveData(mc:Sprite, photobooth :PhotoboothStates, fieldGroup : FieldGroup, formNameAndEmail:FormNameAndEmail,formPhotoSnap:FormPhotoSnap,photoComposition:PhotoComposition) {
			this.mcPreview 			= mc['mc_send_preview'];
			this.photobooth 		= photobooth;
			this.fieldGroup 		= fieldGroup;
			this.formNameAndEmail 	= formNameAndEmail;
			this.formPhotoSnap 		= formPhotoSnap.when(FormPhotoSnap.EVENT_SUBMIT_SUCCESS, onPhotoUploaded);
			this.photoComposition	= photoComposition;

			this.timerPost 			= new Timer(500,1);
			timerPost.addEventListener(TimerEvent.TIMER_COMPLETE, doSend,false, 0, true);

			photobooth.when(PhotoboothStates.EVENT_SEND, onPhotoStepSend);
		}

		private function onPhotoStepSend(e:Event):void{
			photobooth.save(new Date().time);
			timerPost.reset();
			timerPost.start();
		}

		private function doSend(e:Event):void{
			//the text require change color 
			TextField(mcPreview['mc_message']['txt_line1']).textColor=0xFAA61A;
			//uploadPhoto
			formPhotoSnap.setImage(
				photoComposition.composeAsByteArray(mcPreview,{timestamp:photobooth.getSaveTime()})
			);
			TextField(mcPreview['mc_message']['txt_line1']).textColor=0xFFFFFF;

			formPhotoSnap.submit(photobooth.getSaveTime());		
			photobooth.post();
		}

		private function onPhotoUploaded(e:Event):void{
			formPhotoSnap.clear();
			formNameAndEmail.submit(photobooth.getSaveTime());
		}
	}
}