package controller {
	import com.fastframework.module.d3input.HoldButton;
	import com.fastframework.module.d3view.ButtonClip;
	import com.fastframework.module.d3view.IView;
	import com.fastframework.module.d3view.ShowHideView;
	import com.fastframework.module.d3view.events.ButtonClipEvent;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	/**
	 * @author Digi3
	 */
	public class ControllerShowAdminPanel {
		private var viewAdminPanel : IView;
		private var viewControl:IView;
//		private var btnLogin:ButtonClip;

		private var txtPass : TextField;
		private var btnClose : ButtonClip;
		private var btnConfirm:ButtonClip;

		private var holdButton:HoldButton;

		public function ControllerShowAdminPanel(mc_admin : Sprite, btn_admin : Sprite) {
			viewAdminPanel 	= new ShowHideView(mc_admin,true,300);
			viewControl		= new ShowHideView(mc_admin['mc_control'],true,300);
			txtPass			= mc_admin['txt_password'];

			btnClose		= new ButtonClip(mc_admin['btn_close']);
			btnConfirm		= new ButtonClip(mc_admin['btn_confirm']);

			holdButton 		= new HoldButton(btn_admin['btn'],4000);

			btnClose.when(ButtonClipEvent.CLICK, close);
			btnConfirm.when(ButtonClipEvent.CLICK, onSubmit);

			holdButton.when(HoldButton.EVENT_ACTIVATE, activate);
		}

		private function close(...e):void{
			viewAdminPanel.hide();
		}

		private function activate(...e):void{
			viewAdminPanel.show();
		}

		private function onSubmit(e:Event):void{
			if(txtPass.text=="digi3"){
				loginReady();
			}else{
				viewControl.hide();
				close();
			}
		}

		private function loginReady():void{
			viewControl.show();
		}
	}
}