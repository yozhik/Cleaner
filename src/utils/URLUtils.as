package utils
{
	public class URLUtils
	{
		public function URLUtils()
		{
		}
		
		public static function parseGETParams(urlString:String):Object
		{
			//link scheme with GET params: http://site.com{?,#}param1=value&param2=value2
			var idxSharpSymbol:int = urlString.search("#");
			var idxQuaterSymbol:int = urlString.search("?");
			var getParamsIndex:int = -1;
			
			if (idxSharpSymbol >=0 && idxQuaterSymbol >= 0)
			{
				//choose the first symbol after url
				getParamsIndex = Math.min(idxSharpSymbol, idxQuaterSymbol);
			}
			else if (idxSharpSymbol < 0 && idxQuaterSymbol < 0)
			{
				//no GET params available in url
				getParamsIndex = -1;
			}
			else if (idxSharpSymbol < 0)
			{
				//http://site.com?param1=value&param2=value2
				getParamsIndex = idxQuaterSymbol;
			}
			else
			{
				//http://site.com#param1=value&param2=value2
				getParamsIndex = idxSharpSymbol;
			}
			
			//fetch key=values from GET params if we have GET params
			var result:Object = null;
			
			if (getParamsIndex > -1)
			{
				getParamsIndex += 1;
				
				var paramsStr:String = urlString.substring(getParamsIndex, urlString.length);
				
				result = new Object();
				
				var paramsArr:Array = paramsStr.split("&");
				for each (var keyValue:String in paramsArr)
				{
					var tmpArr:Array = keyValue.split("=");
					var key:String = tmpArr[0] as String;
					var value:String = tmpArr[1] as String;
					
					result[key] = value;
				}
			}
			
			return result;
			
		}//end of method
		
		
	}//end of class
}//end of package