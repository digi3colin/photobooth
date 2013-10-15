package 
{
	import asset.MainView;
	import com.digi3studio.utils.MainHelper;
	import flash.display.Sprite;

	public class Main extends Sprite implements IMain
	{
		private var mcVP:MainView;
		private var app:AppDelegate;

		public function Main(){
			//initalise the view;
			new MainHelper(this,mcVP=new MainView(),this);
			mcVP.scaleX = mcVP.scaleY = 0.5;
		}

		public function start():void{
			//place code here to make sure the view is complete loaded.
			app = new AppDelegate(mcVP);
		}
	}
}