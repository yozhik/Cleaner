package social.vk
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class VKSocialCallManager extends EventDispatcher
	{
		public function VKSocialCallManager(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}