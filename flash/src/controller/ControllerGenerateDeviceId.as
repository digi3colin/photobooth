package controller {
	import com.fastframework.io.ISaveText;
	import com.fastframework.log.FASTLog;
	import com.fastframework.module.d3utils.UIDUtils;
	/**
	 * @author digi3colin
	 */
	public class ControllerGenerateDeviceId {
		public function ControllerGenerateDeviceId(textIO:ISaveText){
			var deviceFileName:String = 'device';
			var id:String = textIO.load(deviceFileName);
			if(id==""){
				textIO.save(deviceFileName, id = UIDUtils.createUID());
			}

			AppConfig.DEVICE_ID = id;
			FASTLog.instance().log('deviceId:'+id,FASTLog.LOG_LEVEL_ACTION);
		}
	}
}
