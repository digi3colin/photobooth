package controller {
	import com.fastframework.io.ISaveText;
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3utils.StringUtils;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	/**
	 * @author Digi3
	 */
	public class ControllerAdminEventName {
		private var textIO:ISaveText;
		
		private var fileName:String = 'message';
		private var txtEventName:TextField;
		private var txtSubTitle:TextField;
		private var btnSubmit:ButtonClip;
		private var msgShow:Sprite;
		private var msgPreview:Sprite;
		private var xMsg:XML;

		private var xmlTpl:String = "<msg><title>[$title]</title><sub>[$sub]</sub></msg>";

		public function ControllerAdminEventName(mc_admin : Sprite, mc_photobooth : Sprite, mc_photopreview : Sprite,textIO:ISaveText,xMsg:XML) {
			this.xMsg = xMsg;
			this.textIO = textIO;
			this.txtEventName 	= mc_admin['txt_event_name'];
			this.txtSubTitle 	= mc_admin['txt_event_subtitle'];
			this.msgShow 		= mc_photobooth['mc_message'];
			this.msgPreview 	= mc_photopreview['mc_send_preview']['mc_message'];

			this.txtEventName.addEventListener(FocusEvent.FOCUS_IN,clearText,false,0,false);
			this.txtSubTitle.addEventListener(FocusEvent.FOCUS_IN, clearText,false,0,false);
			this.txtEventName.addEventListener(FocusEvent.FOCUS_OUT,autoCapitalizeAll,false,0,false);
			this.txtSubTitle.addEventListener(FocusEvent.FOCUS_OUT, autoCapitalizeAll,false,0,false);

			this.btnSubmit 		= new ButtonClip(mc_admin['btn_confirm']);
			this.btnSubmit.when(ButtonClipEvent.CLICK, onAdminSubmit);

			load();
		}
		
		private function autoCapitalizeAll(e:Event):void{
			var txt:TextField = TextField(e.target);
			var str:String = txt.text;
			str = StringUtils.entityDecode(str);
			txt.text = str.toUpperCase();
		}

		private function clearText(e:Event):void{
			var txt:TextField = TextField(e.target);
			txt.text = "";
		}

		private function onAdminSubmit(e:Event):void{
			applyMessage(
				txtEventName.text,
				txtSubTitle.text
			);
			this.textIO.save(fileName, AppConfig.MESSAGE.toXMLString());
		}

		private function load():void{
			var result:String 	= this.textIO.load(fileName);
			var title:String 	= txtEventName.text;
			var sub:String 		= txtSubTitle.text;
			if(result!=''){
				//extract title and sub
				var xResult:XML = new XML(result);
				title = unescape(xResult.child('title').toString());
				sub = unescape(xResult.child('sub').toString());

				FASTLog.instance().log("load and parse message:"+title+","+sub,FASTLog.LOG_LEVEL_ACTION);
			}

			applyMessage(title,sub);

			this.txtEventName.text 	= title;
			this.txtSubTitle.text 	= sub;
		}

		private function applyMessage(title:String,sub:String):void{
			var msg:String = xmlTpl;

			msg = msg.replace(/\[\$title\]/gi,	escape(title));
			msg = msg.replace(/\[\$sub\]/gi,	escape(sub));

			xMsg.setChildren(new XML(msg).children());

//			AppConfig.MESSAGE 	= new XML(msg);
//			var line1:String = '<TEXTFORMAT LEADING="2"><P ALIGN="'+(AppConfig.SHOW_LOGO?'LEFT':'CENTER')+'"><FONT FACE="Veuve Clicquot Serif" SIZE="7" COLOR="#FFFFFF" LETTERSPACING="0" KERNING="0">'+unescape(title)+'</FONT></P></TEXTFORMAT>';
//			var line2:String = '<TEXTFORMAT LEADING="2"><P ALIGN="'+(AppConfig.SHOW_LOGO?'LEFT':'CENTER')+'"><FONT FACE="Veuve Clicquot Serif" SIZE="50" COLOR="#FFFFFF" LETTERSPACING="0" KERNING="0">'+unescape(sub)+'</FONT></P></TEXTFORMAT>';

			TextField(msgShow['txt_line1']).htmlText = title;
			TextField(msgShow['txt_line2']).htmlText = sub;

			TextField(msgPreview['txt_line1']).htmlText = title;
			TextField(msgPreview['txt_line2']).htmlText = sub;
		}
	}
}
