package com.digi3studio.photobooth.form {
	import com.fastframework.core.FASTEventDispatcher;
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3form.IForm;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * @author Digi3Studio - Colin Leung
	 * the 2nd part of the form, for name and email posting.
	 */
	public class FormNameAndEmail extends FASTEventDispatcher implements IForm{
		public static const EVENT_INVALID_FORM_BLANK:String = "EVENT_INVALID_FORM_BLANK";
		public static const EVENT_SUBMIT_SUCCESS:String = "EVENT_SUBMIT_SUCCESS";
		public static const EVENT_SUBMIT_FAIL:String = "EVENT_SUBMIT_FAIL";
		public static const EVENT_SUBMIT_START:String = "EVENT_SUBMIT_START";
		public static const EVENT_SUBMIT_END:String = "EVENT_SUBMIT_END";

		private var nameAndEmails:Array;
		private var ld : URLLoader;
		private var submitTime : Number;
		private var device_id:String;
		private var message:String;
		private var submit_url:String;
		private var event_id : String;

		public function FormNameAndEmail(device_id:String,message:String,submit_url:String,event_id:String) {
			this.device_id = device_id;
			this.message = message;
			this.submit_url = submit_url;
			this.event_id = event_id;

			ld = new URLLoader();
			ld.dataFormat = URLLoaderDataFormat.TEXT;
			ld.addEventListener(Event.COMPLETE, onSubmitDone);
			ld.addEventListener(IOErrorEvent.IO_ERROR, onSubmitIOError);

			clear();
		}

		public function validate() : Boolean {
			if(nameAndEmails.length==0){
				dispatchEvent(new Event(FormNameAndEmail.EVENT_INVALID_FORM_BLANK));
				return false;
			}
			return true;
		}

		public function add(name:String, email:String):void{
			//assume all data input are validated.
			nameAndEmails.push(new FieldNameEmail(name,email));
		}

		public function clear():void{
			stopPost();
			nameAndEmails = [];
		};

		public function getSubmitTime():Number{
			return submitTime;
		}

		public function submit(time:Number) : void {
			if(validate()==false)return;
			submitTime = time;

			var postData:URLVariables = new URLVariables();

			var friendNames:Array = [];
			var friendEmails:Array = [];
			for(var i:int = 0;i<nameAndEmails.length;i++){
				var field:FieldNameEmail = nameAndEmails[i];
				friendNames[i] = field.name;
				friendEmails[i]= field.email;
			}

			postData['friend_name[]']	= friendNames;
			postData['friend_email[]']	= friendEmails;
			postData['timestamp']		= time;
			postData['device_id'] 		= this.device_id;//KioskSetting.DEVICE_ID;
			postData['message']			= this.message;//AppConfig.MESSAGE.toXMLString();

			//create url request
			//var url:String = AppConfig.SEND_PATH+KioskSetting.SESSION+"&event_id="+AppConfig.EVENT_ID;
			
			var url:String = this.submit_url+FormSession.id+"&event_id="+this.event_id;
			FASTLog.instance().log('submit to '+url, FASTLog.LOG_LEVEL_DETAIL);
			
			var req:URLRequest = new URLRequest(url);
			req.method = URLRequestMethod.POST;
			req.data = postData;
			
			ld.load(req);
			dispatchEvent(new Event(FormNameAndEmail.EVENT_SUBMIT_START));
		}

		private function onSubmitIOError(e:Event):void{
			FASTLog.instance().log('IOError', FASTLog.LOG_LEVEL_ERROR);
			dispatchEvent(new Event(FormNameAndEmail.EVENT_SUBMIT_FAIL));
			dispatchEvent(new Event(FormNameAndEmail.EVENT_SUBMIT_END));
		}

		private function onSubmitDone(e:Event):void{
			//do logging, check status
			FASTLog.instance().log('Friend List Uploaded', FASTLog.LOG_LEVEL_DETAIL);
			FASTLog.instance().log(ld.data,FASTLog.LOG_LEVEL_RESULT);
			var result:XML = new XML(ld.data);
			
			var xFirstResult:XML = result.children()[0];
			var xStatus:XMLList = xFirstResult['status'];

			if(xStatus.toString() == 'true'){
				FASTLog.instance().log('Friend List Uploaded Success', FASTLog.LOG_LEVEL_DETAIL);
				dispatchEvent(new Event(FormNameAndEmail.EVENT_SUBMIT_SUCCESS));
			}else{
				FASTLog.instance().log('Friend List Uploaded Fail', FASTLog.LOG_LEVEL_ERROR);
				dispatchEvent(new Event(FormNameAndEmail.EVENT_SUBMIT_FAIL));
			}
			dispatchEvent(new Event(FormNameAndEmail.EVENT_SUBMIT_END));
		}

		public function stopPost() : void {
			try{
				ld.close();
			}catch(e:Error){
				//no stream. 
			}
		}
	}
}

class FieldNameEmail {
	public var name:String;
	public var email : String;

	public function FieldNameEmail(name : String, email : String) {
		this.name = name;
		this.email = email;
	}
}
