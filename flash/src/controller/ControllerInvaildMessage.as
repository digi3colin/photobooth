package controller {
	import com.digi3studio.photobooth.form.CheckBoxView;
	import com.digi3studio.photobooth.form.FieldGroup;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.fastframework.module.d3animate.Animator;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerInvaildMessage {
		private var msgCheckbox:Sprite;
		private var txt:TextField;
		private var timer:Timer;
		
		private var an:Animator;
		private var panel:Sprite;
		private var oy:Number;
		private var sy:Number;


		public function ControllerInvaildMessage(mc_message : Sprite, fieldGroup : FieldGroup, formNameAndEmail : FormNameAndEmail,photobooth:PhotoboothStates,consentBox:CheckBoxView) {
			timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, hide);
			txt = mc_message['txt'];
			msgCheckbox = mc_message['msg_checkbox'];
			msgCheckbox.visible = false;

			an = new Animator(panel = mc_message,'y', 500);
			this.oy = mc_message.y;
			this.sy = mc_message.y - mc_message.height;


			fieldGroup.when(FieldGroup.EVENT_FIELDS_INVALID, fieldsInvalid);
			formNameAndEmail.when(FormNameAndEmail.EVENT_INVALID_FORM_BLANK, formNameEmailBlankInvalid);

			photobooth.when(PhotoboothStates.EVENT_IDLE,hide);
			consentBox.when(CheckBoxView.EVENT_INVALID, formConsentBoxInvalid);
		}

		private function formConsentBoxInvalid(e:Event):void{
			txt.text = "Please accept the data collection policy.";
			msgCheckbox.visible = true;
			show();
		}

		private function formNameEmailBlankInvalid(e:Event) : void {
			txt.text="Please fill in your name and email";
			msgCheckbox.visible = false;
			show();
		}

		private function fieldsInvalid(e:Event) : void {
			txt.text="Please check your name and email";
			msgCheckbox.visible = false;
			show();
		}

		private function show():void{
			an.to(this.sy);
			timer.reset();
			timer.start();		
		}

		private function hide(e:Event):void{
			an.to(this.oy);
		}
	}
}
