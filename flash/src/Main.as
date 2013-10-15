package 
{
	import asset.MainView;
	import com.digi3studio.utils.MainHelper;
	import flash.display.Sprite;

	public class Main extends Sprite implements IMain
	{
		private var mcVP:MainView;

		public function Main(){
			//initalise the view;
			new MainHelper(this,mcVP=new MainView(),this);
		}

		public function start():void{
			//place code here to make sure the view is complete loaded.
		}
	}
}