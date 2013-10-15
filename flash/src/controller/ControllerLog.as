package controller {
	import com.fastframework.log.FASTLog;
	/**
	 * @author Digi3
	 */
	public class ControllerLog {
		public function ControllerLog(){
			FASTLog.instance().level = FASTLog.LOG_LEVEL_ALL;
			FASTLog.instance().setLogger(new LogTrace());
		}
	}
}

import com.fastframework.log.ILog;

class LogTrace implements ILog {
	public function log(arg0 : String, arg1 : int = 0) : void {
		trace(arg0);
	}

	public function setLogger(arg0 : ILog) : void {
	}
	
}