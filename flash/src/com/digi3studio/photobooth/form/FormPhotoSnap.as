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
	import flash.utils.ByteArray;


	/**
	 * @author Digi3Studio - Colin Leung
	 * 1st part of the form, Post the photo.
	 */
	public class FormPhotoSnap extends FASTEventDispatcher implements IForm{
		public static const EVENT_INVALID_FORM_BLANK:String = "EVENT_INVALID_FORM_BLANK";
		public static const EVENT_SUBMIT_SUCCESS:String = "EVENT_SUBMIT_SUCCESS";
		public static const EVENT_SUBMIT_FAIL : String = "EVENT_SUBMIT_FAIL";
		public static const EVENT_SUBMIT_START : String = "EVENT_SUBMIT_START";
		public static const EVENT_SUBMIT_END : String = "EVENT_SUBMIT_END";

		private var image:ByteArray;
		private var ld : URLLoader;
		private var submitTime : Number;
		private var event_id : String;
		private var submit_url : String;

		public function FormPhotoSnap(event_id:String,submit_url:String) {
			this.event_id = event_id;
			this.submit_url = submit_url;

			ld = new URLLoader();
			ld.dataFormat = URLLoaderDataFormat.TEXT;
			ld.addEventListener(Event.COMPLETE, onSubmitDone);
			ld.addEventListener(IOErrorEvent.IO_ERROR, onSubmitIOError);

			clear();
		}

		public function validate() : Boolean {
			if(this.image ==null){
				dispatchEvent(new Event(FormNameAndEmail.EVENT_INVALID_FORM_BLANK));
				return false;
			}
			return true;
		}

		public function setImage(img:ByteArray):void{
			this.image = img;
		}

		public function clear():void{
			stopPost();
			this.image = null;
		};

		public function getSubmitTime():Number{
			return submitTime;
		}

		public function submit(time:Number) : void {
			if(validate()==false)return;
			submitTime = time;
			dispatchEvent(new Event(FormPhotoSnap.EVENT_SUBMIT_START));
			//ld.load(new URLRequest('http://www.digi3studio.com/preview/doot/test'));
			//create url request
		
			var req:URLRequest = new URLRequest(this.submit_url+"&event_id="+this.event_id);
			req.contentType = 'application/octet-stream';
			req.method = URLRequestMethod.POST;
			req.data = image;
			
			ld.load(req);
		}

		private function onSubmitIOError(e:Event):void{
			FASTLog.instance().log('IOError', FASTLog.LOG_LEVEL_ERROR);
			dispatchEvent(new Event(FormPhotoSnap.EVENT_SUBMIT_FAIL));
			dispatchEvent(new Event(FormPhotoSnap.EVENT_SUBMIT_END));
		}

		private function onSubmitDone(e:Event):void{
			//do logging, check status
			FASTLog.instance().log('Snapshot Uploaded', FASTLog.LOG_LEVEL_DETAIL);
			FASTLog.instance().log(ld.data,FASTLog.LOG_LEVEL_RESULT);
			var result:XML = new XML(ld.data);

			var xFirstResult:XML = result.children()[0];
			var xStatus:XMLList = xFirstResult['status'];
			FormSession.id = XML(result.children()[1]).toString();

			if(xStatus.toString() == 'true'||xStatus.toString() == '1'){
				FASTLog.instance().log('Snapshot Uploaded Success', FASTLog.LOG_LEVEL_DETAIL);
				dispatchEvent(new Event(FormPhotoSnap.EVENT_SUBMIT_SUCCESS));
			}else{
				FASTLog.instance().log('Snapshot Uploaded Fail', FASTLog.LOG_LEVEL_ERROR);
				dispatchEvent(new Event(FormPhotoSnap.EVENT_SUBMIT_FAIL));
			}
			dispatchEvent(new Event(FormPhotoSnap.EVENT_SUBMIT_END));
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
