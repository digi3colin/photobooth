package controller {
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
		private var txt:TextField;
		private var timer:Timer;
		
		private var an:Animator;
		private var panel:Sprite;

		public function ControllerInvaildMessage(mc_message : Sprite, fieldGroup : FieldGroup, formNameAndEmail : FormNameAndEmail,photobooth:PhotoboothStates) {
			timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, hide);
			txt = mc_message['txt'];

			an = new Animator(panel = mc_message,'y',500);

			fieldGroup.when(FieldGroup.EVENT_FIELDS_INVALID, fieldsInvalid);
			formNameAndEmail.when(FormNameAndEmail.EVENT_INVALID_FORM_BLANK, formNameEmailBlankInvalid);

			photobooth.when(PhotoboothStates.EVENT_START_TO_SHOT,hide);
		}

		private function formNameEmailBlankInvalid(e:Event) : void {
			txt.text="Please fill in your name and email";
			show();
		}

		private function fieldsInvalid(e:Event) : void {
			txt.text="Please check your name and email";
			show();
		}

		private function show():void{
			an.to(AppConfig.KIOSK_HEIGHT-panel.height);
			timer.reset();
			timer.start();		
		}

		private function hide(e:Event):void{
			an.to(AppConfig.KIOSK_HEIGHT);
		}
	}
}
