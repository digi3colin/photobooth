package controller {
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;
	import com.fastframework.module.d3animate.Animator;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;



	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerFormSubmitStatus {
//		private var motion:MotionTween;
		private var txt:TextField;
		private var an:Animator;
		private var panel:Sprite;
		
		private var oy:Number;
		private var sy:Number;

		public function ControllerFormSubmitStatus(mc : Sprite, formNameAndEmail : FormNameAndEmail, formPhotoSnap:FormPhotoSnap, photobooth : PhotoboothStates) {
			txt = mc['txt'];

			this.oy = mc.y;
			this.sy = mc.y - mc.height;

			an = new Animator(panel = mc, 'y', 500);
			
			formPhotoSnap.when(FormPhotoSnap.EVENT_SUBMIT_START, 		startPhotoUpload);
			formNameAndEmail.when(FormNameAndEmail.EVENT_SUBMIT_START, 	startNameEmailUpload);
			formNameAndEmail.when(FormNameAndEmail.EVENT_SUBMIT_END, 	endNameEmailUpload);
			formNameAndEmail.when(FormNameAndEmail.EVENT_SUBMIT_PENDING, pendingEmailUpload);

			photobooth.when(PhotoboothStates.EVENT_IDLE,hide);
			photobooth.when(PhotoboothStates.EVENT_SAVE_START, startUpload);
		}

		private function startUpload(e:Event):void{
			txt.text="Please wait.";
			show();
		}

		private function startPhotoUpload(e:Event) : void {
			txt.text="Please wait. Uploading photo...";
		}

		private function startNameEmailUpload(e:Event) : void {
			txt.text="Please wait. Submitting name and email...";
		}

		private function pendingEmailUpload(e:Event) : void {
			txt.text="Photo Submitted. Thank you!";
		}

		private function endNameEmailUpload(e:Event) : void {
			txt.text="Completed. Thank you!";
		}

		private function show():void{
			an.to(this.sy);
		}

		private function hide(e:Event):void{
			an.to(this.oy);
		}
	}
}
