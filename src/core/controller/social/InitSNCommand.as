package core.controller.social
{
	import core.model.proxies.DisplaySettingsProxy;
	
	import flash.events.*;
	import flash.events.LocationChangeEvent;
	import flash.geom.Rectangle;
	import flash.media.*;
	import core.model.VO.FlashVarsVO;
	
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.URLUtils;
	import config.notifications.SocialNotifications;
	
	public class InitSNCommand extends SimpleCommand
	{
		private var browser:StageWebView;
		
		override public function execute(notification:INotification):void
		{
			initVK();
		}
		
		private function initVK():void
		{
			var dispProxy:DisplaySettingsProxy = null;
			if (facade.hasProxy(DisplaySettingsProxy.NAME))
				dispProxy = facade.retrieveProxy(DisplaySettingsProxy.NAME) as DisplaySettingsProxy;
			
			//vk init params
			FlashVarsVO.app_id = "2903905";
			var scope:String = "friends,video,audio,wall";//,wall,groups,messages";
			var appID:String = FlashVarsVO.app_id;//"2819344";//2819407
			var redirect_uri:String = "http://oauth.vk.com/blank.html";//"http://api.vk.com/blank.html";//"http://oauth.vkontakte.ru/blank.html";
			var browserType:String = "popup";
			var response_type:String = "token";
			var baseURL:String = "http://oauth.vk.com/authorize?client_id=";//"http://api.vk.com/oauth/authorize?client_id="; //"http://oauth.vk.com/authorize?client_id=";
			//http://api.vk.com/oauth/authorize
			//var initUrl:String = baseURL + appID + "&scope=" + scope + "&redirect_uri="+redirect_uri+"&display="+browserType+"&response_type="+response_type;
			var initUrl:String = baseURL + appID + "&scope=" + scope + "&redirect_uri="+redirect_uri+"&display="+browserType+"&response_type="+response_type;
			trace(initUrl);
			
			browser = new StageWebView();
			
			browser.addEventListener(LocationChangeEvent.LOCATION_CHANGE, onWebViewURLChange);	
			
			browser.stage = dispProxy.appStage;
			browser.assignFocus();
			browser.viewPort = new Rectangle(0, 0, dispProxy.appStage.stageWidth - 20, dispProxy.appStage.stageHeight -20 );
			
			browser.loadURL(initUrl);
		}
		
		
		private function onWebViewURLChange(event:LocationChangeEvent):void
		{
			var locationStr:String = event.location;
			
			var isTokenAvailable:int = locationStr.search("access_token");
			//var iVKAvailable:int = locationStr.search("vkontakte.ru");
			var isTimerAvailable:int = locationStr.search("expires_in");
			var isUserIDAvailable:int = locationStr.search("user_id");
			
			var idxSharpSymbol:int = 0;
			var idxQuaterSymbol:int = 0;
			
			//check if all params available
			if(isTokenAvailable >= 0 &&
				isTimerAvailable >= 0 &&
				isUserIDAvailable >= 0)
			{
				trace(event.location);
				
				var result:Object = URLUtils.parseGETParams(event.location);
				
				browser.removeEventListener(LocationChangeEvent.LOCATION_CHANGE, onWebViewURLChange);
				browser.stop();
				browser.dispose();
				
				FlashVarsVO.user_id = result["user_id"] as String;
				FlashVarsVO.access_token = result["access_token"] as String;
				sendNotification(SocialNotifications.INIT_SN_OK);
			}
			else
				sendNotification(SocialNotifications.INIT_SN_FAILED);

		}
		
	}
}