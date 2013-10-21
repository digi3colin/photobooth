package 
{
	import asset.MainView;

	import com.digi3studio.utils.MainHelper;
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3crossplatform.IMain;
	import com.fastframework.module.d3crossplatform.IPlatform;
	import com.fastframework.module.d3crossplatform.PlatformAND;
	import com.fastframework.module.d3crossplatform.PlatformIOS;
	import com.fastframework.module.d3crossplatform.PlatformWIN;
	import com.fastframework.module.d3storage.SaveBinAIR;
	import com.fastframework.module.d3storage.SaveTextAIR;

	import flash.display.Sprite;
	import flash.system.Capabilities;

	public class Main extends Sprite implements IMain
	{
		private var mcVP:MainView;
		private var app : AppDelegate;
		private var platform : IPlatform;

		public function Main(){
			FASTLog.instance().addGlobalError(this.loaderInfo);
			//initalise the view;
			new MainHelper(this,mcVP=new MainView(),this);

			switch (Capabilities.version.split(' ')[0]){
				case "IOS":
					platform = new PlatformIOS();
					AppConfig.TEXT_IO = new SaveTextAIR();
					AppConfig.BINARY_IO = new SaveBinAIR();
					AppConfig.CAMERA_ID= "1";
					break;
				case "AND":
					platform = new PlatformAND();
					AppConfig.TEXT_IO = new SaveTextAIR();
					AppConfig.BINARY_IO = new SaveBinAIR();
					AppConfig.CAMERA_ID= "0";
					break;
				default:
					platform = new PlatformWIN();
					AppConfig.TEXT_IO = new SaveTextAIR();
					AppConfig.BINARY_IO = new SaveBinAIR();
					AppConfig.CAMERA_ID= "0";
			}
		}

		public function start():void{
			//place code here to make sure the view is complete loaded.
			platform.setup(mcVP);
			app = new AppDelegate(mcVP);
		}
	}
}