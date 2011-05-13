package dk.zupa.events
{
	import flash.events.Event;
	
	public class FacebookConnectEvent extends Event
	{
		static public const USER_LOGGED_IN:String = "userLoggedIn";
		static public const LOG_IN_FAILED:String = "logInFailed";
		static public const READY_TO_LOG_IN:String = "readyToLogIn";
		static public const USER_LOGGED_OUT:String = "userLoggedOut";
		static public const PUBLISH_CALL:String = "publishCall";
		static public const PUBLISH_CALL_FAIL:String = "publishCallFail";
		static public const SEND_FRIEND_REQUEST:String = "sendFriendRequest";
		
		public var data:Object;
		
		public function FacebookConnectEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new FacebookConnectEvent(type, data, bubbles, cancelable);
		}
	}
}