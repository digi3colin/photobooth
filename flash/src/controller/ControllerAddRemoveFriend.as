package controller {
	import asset.FormFieldFriendName;

	import com.digi3studio.photobooth.form.FieldGroup;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerAddRemoveFriend {
		private var mcFields:Sprite;

		private var fieldGroup : FieldGroup;
		private var btnAddFriend:ButtonClip;

		public function ControllerAddRemoveFriend(mcPhotoPreview:Sprite,fieldGroup:FieldGroup,photobooth:PhotoboothStates){
			photobooth.when(PhotoboothStates.EVENT_SHOT, initForm);
			this.fieldGroup = fieldGroup;
			mcFields = mcPhotoPreview['form_fields'];
			btnAddFriend = new ButtonClip(mcPhotoPreview['btn_add_friend']).when(ButtonClipEvent.CLICK, clickAddFriend);
		}

		private function initForm(e:Event):void{
			var fieldsCount:int = fieldGroup.getCount();
			for(var i:int=0;i<fieldsCount;i++){
				fieldGroup.getFieldAt(0).remove();
			}

			for(i=0;i<AppConfig.FIELD_COUNT;i++){
				doAddFriend();			
			}
		}

		private function clickAddFriend(e:Event):void{
			doAddFriend().focus();
		}

		private function doAddFriend():FormFieldFriendName{
			var field:FormFieldFriendName = new FormFieldFriendName();
			field.name = "field$"+fieldGroup.getCount();
			field.y = fieldGroup.getCount()*AppConfig.FIELD_HEIGHT;
			field.once(FormFieldFriendName.EVENT_REMOVE, onRemoveFriend);
			fieldGroup.addField(field);
			mcFields.addChild(field);
			return field;
		}

		private function onRemoveFriend(e:Event) : void {
			fieldGroup.removeField(FormFieldFriendName(e.target));

			for(var i:int=0;i<fieldGroup.getCount();i++){
				fieldGroup.getFieldAt(i).y = i*AppConfig.FIELD_HEIGHT;
			}
		}
	}
}
