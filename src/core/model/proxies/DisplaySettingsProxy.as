package core.model.proxies
{
	import flash.display.Stage;
	
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	public class DisplaySettingsProxy extends Proxy
	{
		public static const NAME:String = 'DisplaySettingsProxy';
		
		public function DisplaySettingsProxy(stage:Stage)
		{
			super(NAME, stage);
		}
		
		public function get appStage():Stage
		{
			return data as Stage;
		}
	}
}