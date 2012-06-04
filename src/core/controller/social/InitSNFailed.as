package core.controller.social
{
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class InitSNFailed extends SimpleCommand
	{
		override public function execute(notification:INotification):void
		{
			trace("Social network login failed");
		}
	}
}