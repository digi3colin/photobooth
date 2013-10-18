package controller {
	import asset.FormFieldFriendName;

	import com.digi3studio.photobooth.form.FieldGroup;
	import com.digi3studio.photobooth.form.FormNameAndEmail;
	import com.digi3studio.photobooth.form.FormPhotoSnap;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerValidateForm {
		private var photobooth:PhotoboothStates;
		private var btn_send : ButtonClip;
		private var formNameAndEmail : FormNameAndEmail;
		private var formPhotoSnap : FormPhotoSnap;
		private var fieldGroup : FieldGroup;

		public function ControllerValidateForm(mcForm : Sprite, photobooth : PhotoboothStates,formNameAndEmail:FormNameAndEmail,formPhotoSnap:FormPhotoSnap,fieldGroup:FieldGroup) {
			this.photobooth = photobooth;
			this.formNameAndEmail = formNameAndEmail;
			this.formPhotoSnap = formPhotoSnap;
			this.fieldGroup = fieldGroup;

			this.btn_send = new ButtonClip(mcForm['btn_send']).when(ButtonClipEvent.CLICK, onClickSend);
		}
		
		private function onClickSend(e:Event):void{
			//clear the form every time before sent;
			formNameAndEmail.clear();
			formPhotoSnap.clear();

			//if one of the fields invalid. stop;
			if(fieldGroup.validate()==false)return;

			//all fields pass, add to form
			for(var i:int=0;i<fieldGroup.getCount();i++){
				var field:FormFieldFriendName = fieldGroup.getFieldAt(i);
				if(field.getName()=='')continue;
				formNameAndEmail.add(field.getName(), field.getEmail());
			}

			if(formNameAndEmail.validate()==false)return;
			photobooth.send();
		}
	}
}
