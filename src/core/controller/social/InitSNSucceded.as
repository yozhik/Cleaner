package core.controller.social
{
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	
	import core.controller.StartupCommand;
	import core.model.VO.FlashVarsVO;
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.LocationChangeEvent;
	import flash.events.StatusEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.media.*;
	import flash.media.StageWebView;
	import flash.net.*;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	import utils.URLUtils;
	
	public class InitSNSucceded extends SimpleCommand
	{
		private var arrToDelete:Array;
		private var timer:Timer;
		private var delLoader:URLLoader;
		
		override public function execute(notification:INotification):void
		{
			trace("Success!");
			rights();
		}
		
		private function rights():void
		{			
			var str:String = "https://api.vk.com/method/getUserSettings?uid="+FlashVarsVO.user_id+"&access_token=" +FlashVarsVO.access_token;
			trace(str);
			var req:URLRequest = new URLRequest(str);
			var uLdr:URLLoader = new URLLoader(req);
			uLdr.addEventListener(Event.COMPLETE, onRightsComplete);
			uLdr.addEventListener(ErrorEvent.ERROR, onErrorHandler);
			uLdr.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function onRightsComplete(event:Event):void
		{
			var responseStr:String = event.currentTarget.data as String;
			postToWall("Только суровые винницкие программисты тратят 2 ночи на изучение API, чтобы посмотреть как комп за тебя будет чистить твою стенку за несколько минут:)");
			//getAllPosts();
		}
		
		private function getAllPosts():void
		{
			if (arrToDelete)
			{
			trace("getAllPosts");
			var str:String = "https://api.vk.com/method/wall.get?uid="+FlashVarsVO.user_id+"&count="+100+"&offset="+0+"&access_token=" +FlashVarsVO.access_token;
			trace(str);
			var req:URLRequest = new URLRequest(str);
			var uLdr:URLLoader = new URLLoader(req);
			uLdr.addEventListener(Event.COMPLETE, onComplete);
			uLdr.addEventListener(ErrorEvent.ERROR, onErrorHandler);
			uLdr.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			else
			{
				finish();
			}
		}
		
		private function finish():void
		{
			trace("finish");
		}
		
		private function onComplete(event:Event):void
		{
			trace("getAllPosts.Complete");
			var responseStr:String = event.currentTarget.data as String;
			var json_obj:Object = com.adobe.serialization.json.JSON.decode(responseStr);
			var response:Object = json_obj.response;
			var i:int = 1;
			var count:int = response[0];
			
			if (count == 0)
			{
				event.currentTarget.removeEventListener(Event.COMPLETE, onComplete);
				event.currentTarget.removeEventListener(ErrorEvent.ERROR, onErrorHandler);
				event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
				arrToDelete = null;
			}
			
			arrToDelete = new Array();
			
			while (i <= count)
			{
				var obj:Object = response[i.toString()];
				var idStr:int = obj.id;
				arrToDelete.push(idStr.toString());
				i++;
			}
			deleteWall();

		}
		
		private function deleteWall():void
		{
			trace("deleteWall");
			trace(arrToDelete.length);
			if (arrToDelete.length > 0)
			{
				var idStr:String = arrToDelete.pop() as String;
				deletePost(idStr);
			}
			else
			{
				//timer.reset();
				getAllPosts();
			}
		}
		
		private function postToWall(message:String):void
		{
			trace("postToWall: " + message);
			var str:String = "https://api.vk.com/method/wall.post?message="+message+ "&access_token="+ FlashVarsVO.access_token;
			
			var req:URLRequest = new URLRequest(str);
			var postLoader:URLLoader = new URLLoader();
			postLoader.load(req);
		}
		
		private function deletePost(postId:String):void
		{
			trace("deletePost: " + postId);
			var str:String = "https://api.vk.com/method/wall.delete?post_id="+postId+ "&access_token="+ FlashVarsVO.access_token;
			
			var req:URLRequest = new URLRequest(str);
			var delLoader:URLLoader = new URLLoader();
			delLoader.addEventListener(Event.COMPLETE, onPostRemoved);
			delLoader.addEventListener(ErrorEvent.ERROR, onErrorHandler);
			delLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			delLoader.load(req);
		}
		
		private function onPostRemoved(event:Event):void
		{
			trace("onPostRemoved");
			delLoader.removeEventListener(Event.COMPLETE, onPostRemoved);
			delLoader.removeEventListener(ErrorEvent.ERROR, onErrorHandler);
			delLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			deleteWall();
		}
		
		private function onErrorHandler(event:ErrorEvent):void
		{
			trace(event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			trace(event);
		}
		
	}
}