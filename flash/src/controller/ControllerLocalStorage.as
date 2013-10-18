package controller {
	import com.fastframework.io.ISaveText;
	import asset.FormFieldFriendName;
	import com.digi3studio.PhotoComposition;
	import com.digi3studio.photobooth.form.FieldGroup;
	import com.fastframework.io.ISaveBinary;
	import com.fastframework.log.FASTLog;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.ByteArray;


	/**
	 * @author Digi3Studio - Colin Leung
	 */
	public class ControllerLocalStorage {
		private var mcPreview:Sprite;
		private var photoComposition:PhotoComposition;
		private var fieldGroup:FieldGroup;
		private var photobooth : PhotoboothStates;
		private var binaryIO : ISaveBinary;
		private var textIO : ISaveText;

		public function ControllerLocalStorage(mcPhotoPreview : Sprite, photobooth : PhotoboothStates, photoComposition : PhotoComposition, fieldGroup : FieldGroup,binaryIO:ISaveBinary,textIO:ISaveText) {
			this.mcPreview 	= mcPhotoPreview['mc_send_preview'];
			this.photobooth = photobooth;
			this.photoComposition = photoComposition;
			this.fieldGroup = fieldGroup;
			this.binaryIO   = binaryIO;
			this.textIO		= textIO;

			photobooth.when(PhotoboothStates.EVENT_SAVE_POST, onSave);
		}

		private function onSave(e:Event) : void {
			//save file
			var baPhoto:ByteArray = photoComposition.getCompositionByteArray();

			this.binaryIO.save(photobooth.getSaveTime()+'.png', baPhoto);

			//save data
			var record:String='';
			for(var i:int=0;i<fieldGroup.getCount();i++){
				var field:FormFieldFriendName = fieldGroup.getFieldAt(i);
				if(field.getName()=='')continue;
				
				var myQuery:String = 'INSERT INTO friends (Name, Email, SaveTime) VALUES ("'+escape(field.getName())+'", "'+escape(field.getEmail())+'", "'+escape(String(photobooth.getSaveTime()))+'")';

				record = record+myQuery+'\n';
				FASTLog.instance().log('SQL:'+myQuery,FASTLog.LOG_LEVEL_DETAIL);
//				mdm.Database.SQLite.runQuery(myQuery);
			}

			this.textIO.save(photobooth.getSaveTime()+'.txt',record);
		}
	}
}
