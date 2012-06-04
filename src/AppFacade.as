package
{
	import org.puremvc.as3.patterns.facade.Facade;
	import config.notifications.GeneralAppNotifications;
	import flash.display.Sprite;
	
	public class AppFacade extends Facade
	{
		
		private static var instance:AppFacade;
		
		public function AppFacade()
		{
			super();
		}
		
		public static function getInstance():AppFacade	
		{
			if(!instance)
				instance = new AppFacade();
			return instance;
		}
		
		public function startup( command:Class, root:Sprite ):void 
		{
			registerCommand( GeneralAppNotifications.STARTUP, command );
			sendNotification( GeneralAppNotifications.STARTUP, root );
		}
	}
}