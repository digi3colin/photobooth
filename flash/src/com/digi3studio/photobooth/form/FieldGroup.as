package com.digi3studio.photobooth.form {
	import asset.FormFieldFriendName;

	import com.fastframework.core.FASTEventDispatcher;

	import flash.events.Event;

	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class FieldGroup extends FASTEventDispatcher {
		public static const EVENT_ADD_ITEM:String = "EVENT_ADD_ITEM"; 
		public static const EVENT_REMOVE_ITEM:String = "EVENT_REMOVE_ITEM";
		public static const EVENT_FIELDS_VALID:String = "EVENT_FIELDS_VALID";
		public static const EVENT_FIELDS_INVALID:String = "EVENT_FIELDS_INVALID";

		private var fields : Vector.<FormFieldFriendName> = new Vector.<FormFieldFriendName>();
		private var allowEmpty : Boolean;

		public function FieldGroup(allowEmpty:Boolean = false) {
			this.allowEmpty = allowEmpty;
		}

		public function getCount():int{
			return fields.length;
		}

		public function getFieldAt(index:int):FormFieldFriendName{
			return fields[index];
		}

		public function addField(formFieldFriendName : FormFieldFriendName) : void {
			fields.push(formFieldFriendName);
			checkLastField();
			dispatchEvent(new Event(FieldGroup.EVENT_ADD_ITEM));
		}

		public function removeField(formFieldFriendName : FormFieldFriendName) : Boolean {
			var result:Boolean = false;
			for(var i:int=0;i<fields.length;i++){
				if(fields[i]==formFieldFriendName){
					fields.splice(i,1);
					result = true;
					i--;
				}
			}
			checkLastField();
			//something deleted
			if(result==true)dispatchEvent(new Event(FieldGroup.EVENT_REMOVE_ITEM));
			return result;
		}

		private function checkLastField():void{
			if(fields.length==0)return;
			if(allowEmpty==false){
				fields[0].enableDelete(
					(fields.length==1)?
						false:
						true);
			}
		}
		
		public function getInvalidFields():Array{
			var result:Array = [];
			for(var i:int=0;i<fields.length;i++){
				if(fields[i].validate()==false){
					result.push(i);
				};
			}
			return result;
		}
		
		public function validate():Boolean{
			if(getInvalidFields().length>0){
				dispatchEvent(new Event(FieldGroup.EVENT_FIELDS_INVALID));
				return false;
			}
			dispatchEvent(new Event(FieldGroup.EVENT_FIELDS_VALID));
			return true;
		}
	}
}
