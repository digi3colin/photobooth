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

	import flash.display.Sprite;
	import flash.system.Capabilities;

	public class Main extends Sprite implements IMain
	{
		private var mcVP:MainView;
		private var app : AppDelegate;
		private var platform : IPlatform;

		public function Main(){
			//initalise the view;
			new MainHelper(this,mcVP=new MainView(),this);
			FASTLog.instance().addGlobalError(this.loaderInfo);

			switch (Capabilities.version.split(' ')[0]){
				case "IOS":
					platform = new PlatformIOS();
					AppConfig.CAMERA_ID= "1";
					break;
				case "AND":
					platform = new PlatformAND();
					AppConfig.CAMERA_ID= "0";
					break;
				default:
					platform = new PlatformWIN();
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