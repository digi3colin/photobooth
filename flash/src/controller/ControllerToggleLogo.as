package controller {
	import com.digi3studio.photobooth.ToggleLogo;

	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * @author Digi3
	 */
	public class ControllerToggleLogo {
		private var model:ToggleLogo;
		private var frameMsg:Sprite;
		private var frameLogo:Sprite;
		private var previewMsg:Sprite;
		private var previewLogo:Sprite;

		public function ControllerToggleLogo(btn:Sprite,frame:Sprite,preview:Sprite) {
			this.frameMsg    = frame['mc_message'];
			this.frameLogo   = frame['mc_logo'];
			this.previewMsg  = preview['mc_message'];
			this.previewLogo = preview['mc_logo'];

			model = new ToggleLogo(btn);
			model.when(ToggleLogo.EVENT_UPDATE, update);
			model.init();
		}

		private function update(e:Event):void{
			if(this.frameMsg==null||this.frameLogo==null||this.previewMsg==null||this.previewLogo==null)return;


			this.frameMsg.visible = !AppConfig.SHOW_LOGO;
			this.frameLogo.visible = AppConfig.SHOW_LOGO;
			this.previewMsg.visible = !AppConfig.SHOW_LOGO;
			this.previewLogo.visible = AppConfig.SHOW_LOGO;

/*			var line1:String = '<TEXTFORMAT LEADING="2"><P ALIGN="'+(AppConfig.SHOW_LOGO?'LEFT':'CENTER')+'"><FONT FACE="Veuve Clicquot Serif" SIZE="88" COLOR="#FFFFFF" LETTERSPACING="0" KERNING="0">'+unescape(AppConfig.MESSAGE['title'])+'</FONT></P></TEXTFORMAT>';
			var line2:String = '<TEXTFORMAT LEADING="2"><P ALIGN="'+(AppConfig.SHOW_LOGO?'LEFT':'CENTER')+'"><FONT FACE="Veuve Clicquot Serif" SIZE="50" COLOR="#FFFFFF" LETTERSPACING="0" KERNING="0">'+unescape(AppConfig.MESSAGE['sub'])+'</FONT></P></TEXTFORMAT>';*/

/*			TextField(this.frameMsg['txt_line1']).htmlText = line1;
			TextField(this.frameMsg['txt_line2']).htmlText = line2;
			TextField(this.previewMsg['txt_line1']).htmlText = line1;
			TextField(this.previewMsg['txt_line2']).htmlText = line2;*/
		}
	}
}
