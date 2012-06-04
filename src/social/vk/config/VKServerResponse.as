package social.vk.config
{
	public class VKServerResponse
	{
		public static const UNKNOWN_ERROR:int = 1;   //Unknown error occurred. 
		public static const APLICATION_DISABLED:int = 2;   //Application is disabled. Enable your application or use test mode. 
		public static const INCORRECT_SIGNATURE:int = 4;   //Incorrect signature.  
		public static const USER_AUTHORIZATION_FAILED:int = 5;   //User authorization failed.  
		public static const TOO_MANY_REQUESTS_PER_SECOND:int = 6;   //Too many requests per second. 
		public static const NEED_MORE_PERMISSIONS:int = 7;   //Permission to perform this action is denied by user.  
		public static const PAMAM_INVALID:int = 100;   //One of the parameters specified was missing or invalid. 
		public static const ACCESS_DENIED:int = 210;   //Access to wall's post denied.
 
	}
}