package asset {
	import com.fastframework.core.FASTSpriteEventDispatcher;
	import com.fastframework.module.d3input.ISmartInput;
	import com.fastframework.module.d3input.TextFieldInput;
	import com.fastframework.module.d3input.TextInputValidator;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.IView;
	import com.fastframework.module.d3view.ShowHideView;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.events.Event;
	import flash.text.TextField;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class FormFieldFriendName extends FASTSpriteEventDispatcher {
		public static const EVENT_REMOVE:String = "EVENT_REMOVE";
	
		private static var tabGroup:int=0;
	
		private var stxfName:ISmartInput;
		private var stxfEmail : ISmartInput;
		private var viewWarnEmail : IView;
		private var viewWarnName : IView;
		
		private var btnDelete : ButtonClip;
		private var view :MCNameEmail;

		private var txtName:TextField;
		private var txtEmail:TextField;

		public function FormFieldFriendName() {
			this.addChild(view = new MCNameEmail());
			tabGroup++;

			//setup text fields;
			txtName = view.mc_name['txt'];
//			txtName.type = TextFieldType.DYNAMIC;
			txtName.tabIndex = tabGroup+1;

			txtEmail = view.mc_email['txt'];			
			txtEmail.tabIndex = tabGroup+2;
			txtEmail.restrict = 'a-z0-9._%-@';

//			txtName.addEventListener(FocusEvent.FOCUS_IN, onNameFocus);

			this.viewWarnEmail = new ShowHideView(view.mc_warn_email);
			this.viewWarnName = new ShowHideView(view.mc_warn_name);

			//textField to stageText

			stxfName = new TextInputValidator(new TextFieldInput(txtName), false, true);
			stxfName.when(TextInputValidator.EVENT_INVALID, onNameInvalid);
			stxfName.when(TextInputValidator.EVENT_VALID, onNameValid);
			stxfName.when(TextInputValidator.EVENT_CHANGE, onNameInput);
			stxfName.setValidateFunction(validateName);

			stxfEmail = new TextInputValidator(new TextFieldInput(txtEmail), false, true);
			stxfEmail.when(TextInputValidator.EVENT_INVALID, onEmailInvalid);
			stxfEmail.when(TextInputValidator.EVENT_VALID, onEmailChange);
			stxfEmail.when(TextInputValidator.EVENT_CHANGE, onEmailChange);
			stxfEmail.setValidateFunction(validateEmail);

			//delete button
			btnDelete = new ButtonClip(view.btn_delete).when(ButtonClipEvent.CLICK,onDelete);
		}

//		private function onNameFocus(event : FocusEvent) : void {
			//StageTextProxy.instance().replaceTextField(txtName);
//		}

		public function remove():void{
			this.dispatchEvent(new Event(FormFieldFriendName.EVENT_REMOVE));
			this.parent.removeChild(this);		
		}

		private function onDelete(e:Event) : void {
			remove();
		}

		public function getName():String{
			return stxfName.getValue();
		}
		
		public function getEmail():String{
			return stxfEmail.getValue();
		}
		
		private function validateName(str:String):Boolean{
			if(str==""){
				if(stxfEmail.getValue()!='')return false;
				return true;
			}
			return true;
		}

		private function onNameInput(event : Event) : void {
			viewWarnName.hide();
		}

		private function onNameValid(e:Event):void{
			viewWarnName.hide();
		}

		private function onNameInvalid(e:Event):void{
			viewWarnName.show();
		}

		private function validateEmail(str:String):Boolean{
			stxfName.validate();
			if(str==""){
				if(stxfName.getValue()!='')return false;
				return true;
			}
			if((str.match(/\b[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}\b/gi).length<=0))return false;
			return true;
		}

		private function onEmailChange(e:Event):void{
			viewWarnEmail.hide();
		}

		private function onEmailInvalid(e:Event):void{
			viewWarnEmail.show();
		}

		public function enableDelete(bool:Boolean):void{
			view.btn_delete.visible = bool;
		}
		
		public function focus():void{
			stxfName.focus();
		}

		public function validate() : Boolean {
			return (stxfEmail.validate()==true && stxfEmail.validate()==true);
		}
	}
}
