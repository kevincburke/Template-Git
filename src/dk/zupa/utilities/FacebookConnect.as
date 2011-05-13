package dk.zupa.utilities
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.FacebookDesktop;
	
	import dk.zupa.events.FacebookConnectEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.SharedObject;
	
	public class FacebookConnect extends EventDispatcher
	{
		public var FacebookClass;
		public var web:Boolean;
		public var appID:String;
		public var uid:String;
		
		public function FacebookConnect()
		{
			web = true;
		}
		
		public function init():void
		{
			FacebookClass.init(appID, initHandler);
		}
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		// Private methods
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		private function getMe():void
		{
			FacebookClass.api("/me", getMeHandler);
		}
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		// Public methods
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		public function login(permissions:String=""):void
		{
			if(web)
			{
				FacebookClass.login(loginHandler, {perms:permissions});
			}
			else
			{
				FacebookClass.login(loginHandler, new Array(permissions));
			}
		}
		public function logout(appOrigin:String=null):void
		{
			if(web)
			{
				FacebookClass.logout(logoutHandler);
			}
			else
			{
				FacebookClass.logout(logoutHandler, appOrigin);
			}
		}
		public function publishCall(method:String, params:Object=null, requestMethod:String="POST"):void
		{
			FacebookClass.api(method, publishCallHandler, params, requestMethod);
		}
		public function getImageURL(id:Number, size:String="small"):String
		{
			return FacebookClass.getImageUrl(id,size);
		}
		public function sendFriendRequest(title:String, message:String, restrictions:Array):void
		{
			var data:Object = new Object();
			data.title   = title;
			data.message = message;
			data.filters = restrictions;
			
			FacebookClass.ui("apprequests", data, sendFriendRequestHandler, "popup"); 
		}
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		// Handlers
		//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
		private function initHandler(success:Object, fail:Object):void
		{
			var evt:FacebookConnectEvent;
			if(success)
			{
				if(web)
				{
					trace("WEB GET ME");
					getMe();
				}
				else
				{
					uid = success.uid;
					trace("NOT WEB");
					evt = new FacebookConnectEvent(FacebookConnectEvent.USER_LOGGED_IN);
					evt.data = success;
					dispatchEvent(evt);
				}
			}
			else
			{
				uid = null;
				evt = new FacebookConnectEvent(FacebookConnectEvent.READY_TO_LOG_IN);
				evt.data = fail;
				trace("FACEBOOK FAIL");
				dispatchEvent(evt);
			}
		}
		private function loginHandler(success:Object, fail:Object):void
		{
			var evt:FacebookConnectEvent;
			if(success)
			{
				if(web)
				{
					getMe();
				}
				else
				{
					uid = success.uid;
					evt = new FacebookConnectEvent(FacebookConnectEvent.USER_LOGGED_IN);
					evt.data = success;
					dispatchEvent(evt);
				}
			}
			else
			{
				uid = null;
				evt = new FacebookConnectEvent(FacebookConnectEvent.LOG_IN_FAILED);
				evt.data = fail;
				dispatchEvent(evt);
			}
		}
		private function getMeHandler(success:Object, fail:Object):void
		{
			var evt:FacebookConnectEvent;
			if(success)
			{
				uid = success.id;
				evt = new FacebookConnectEvent(FacebookConnectEvent.USER_LOGGED_IN);
				evt.data = {user:success};
				dispatchEvent(evt);
			}
			else
			{
				uid = null;
				evt = new FacebookConnectEvent(FacebookConnectEvent.LOG_IN_FAILED);
				evt.data = fail;
				dispatchEvent(evt);
			}
		}
		private function publishCallHandler(success:Object, fail:Object):void
		{
			var evt:FacebookConnectEvent;
			if(success)
			{
				evt = new FacebookConnectEvent(FacebookConnectEvent.PUBLISH_CALL);
				evt.data = success;
				dispatchEvent(evt);
			}
			else
			{
				evt = new FacebookConnectEvent(FacebookConnectEvent.PUBLISH_CALL_FAIL);
				evt.data = fail;
				dispatchEvent(evt);
			}
		}
		private function sendFriendRequestHandler(result:Object):void
		{
			var evt:FacebookConnectEvent = new FacebookConnectEvent(FacebookConnectEvent.SEND_FRIEND_REQUEST);
			if(result == null)
			{
				evt.data = "User closed the pop up window without inviting any friends";
			}
			else
			{
				evt.data = result;
			}
			dispatchEvent(evt);
		}
		private function logoutHandler(success):void
		{
			uid = null;
			dispatchEvent(new FacebookConnectEvent(FacebookConnectEvent.USER_LOGGED_OUT));
		}
	}
}