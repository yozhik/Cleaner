package core.controller.registration
{
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	import core.controller.social.*;
	import config.notifications.SocialNotifications;
	
	public class RegisterSocialCommand extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			facade.registerCommand(SocialNotifications.INIT_SOCIAL_NETWORK, InitSNCommand);
			facade.registerCommand(SocialNotifications.INIT_SN_OK, InitSNSucceded);
			facade.registerCommand(SocialNotifications.INIT_SN_FAILED, InitSNFailed);
		}
	}
}