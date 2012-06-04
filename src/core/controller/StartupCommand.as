package core.controller
{
	import config.app.AppConfig;
	import config.notifications.GeneralAppNotifications;
	
	import core.controller.registration.*;
	import core.model.proxies.DisplaySettingsProxy;
	
	import flash.display.Sprite;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import config.notifications.SocialNotifications;
	
	public class StartupCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("StartupCommand");
			var mainView:Sprite = notification.getBody() as Sprite;
			
			//register commands
			facade.registerCommand(GeneralAppNotifications.REGISTER_SOCIAL_COMMANDS, RegisterSocialCommand);
			facade.registerCommand(GeneralAppNotifications.REGISTER_APP_COMMANDS, RegisterAppCommand);
			
			sendNotification(GeneralAppNotifications.REGISTER_SOCIAL_COMMANDS);
			sendNotification(GeneralAppNotifications.REGISTER_APP_COMMANDS);
			
			//register proxies
			facade.registerProxy(new DisplaySettingsProxy(mainView.stage));
			
			//init social network
			//sendNotification(SocialNotifications.INIT_SOCIAL_NETWORK);
		}
	}
}