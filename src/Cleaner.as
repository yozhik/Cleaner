package
{
	import air.net.URLMonitor;
	
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
	import core.controller.StartupCommand;
	import utils.URLUtils;
	
	
	public class Cleaner extends Sprite
	{
		public function Cleaner()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		private function init():void
		{
			AppFacade.getInstance().startup( StartupCommand, this );
		}
		
		
		
		
		
		
		
		
		/*private function playSong(playURL:String):void
		{
		song = new Sound();
		
		var r:URLRequest = new URLRequest(playURL);
		song.load(r);
		song.play();
		}
		
		private function download(downloadURL:String):void
		{
		loaderStream = new URLStream();
		loaderStream.addEventListener(Event.COMPLETE, onDownloaded);
		loaderStream.addEventListener(ProgressEvent.PROGRESS, assetsProgressHandler);
		
		
		var f:File = new File();
		var s:String = File.documentsDirectory.nativePath + "\\1.mp3";
		trace(s);
		f = f.resolvePath(s);
		
		fs = new FileStream();
		fs.open(f, FileMode.WRITE);
		
		var req:URLRequest = new URLRequest(downloadURL);
		req.cacheResponse = false;
		req.useCache = false;
		
		loaderStream.load(req);
		}
		
		private function onDownloaded(event:Event):void
		{
		//fs.writeBytes(loaderStream.data);
		fs.close();
		}
		
		private function assetsProgressHandler(event:ProgressEvent):void
		{
		//write loaded bytes directly to file
		var bArr:ByteArray = new ByteArray();
		loaderStream.readBytes(bArr, 0, loaderStream.bytesAvailable);
		fs.writeBytes(bArr, 0, bArr.length);
		
		dispatchEvent(event);
		}
		
		private function makeQueries(result:Object):void
		{
		trace(result);
		var str:String = "https://api.vkontakte.ru/method/audio.get?uid="+result.user_id+"&count="+10+"&offset="+0+"&access_token=" +result.access_token;
		trace(str);
		var req:URLRequest = new URLRequest(str);
		var uLdr:URLLoader = new URLLoader(req);
		uLdr.addEventListener(Event.COMPLETE, onComplete);
		uLdr.addEventListener(ErrorEvent.ERROR, onErrorHandler);
		uLdr.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		private function onComplete(event:Event):void
		{
		trace(event);
		}
		
		private function onErrorHandler(event:ErrorEvent):void
		{
		trace(event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
		trace(event);
		}*/
	}
}