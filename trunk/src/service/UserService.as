package service
{
	
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	
	import mvc.model.User;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.events.ResultEvent;
	
	import org.swizframework.utils.services.MockDelegateHelper;
	
	import userevent.UserEvent;
	
	public class UserService
	{
		
		private var nc:NetConnection;
		private var so:SharedObject;
		
		[Dispatcher]
		/**
		 * The [Dispatcher] metadata tag instructs Swiz to inject an event dispatcher.
		 * Event's dispatched via this dispatcher can trigger event mediators.
		 */ 
		public var dispatcher : IEventDispatcher;
		
		/**
		 * To avoid a live server dependency, we use a Swiz
		 * helper class to let us create fake AsyncTokens
		 */ 

		private var allUsers:ArrayCollection = new ArrayCollection();
		
		public function UserService()
		{
			nc = new NetConnection();
			nc.client = this;
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.connect("rtmpt://87.121.97.85/whiteboard_users");
		
		}
		
		public function close(...args):void
		{
			//trace("close: "+args);
		}
		
		protected function netStatusHandler(event:NetStatusEvent):void
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					trace("NetConnection.Connect.Success")
						so = SharedObject.getRemote("userList", nc.uri, false);
						so.client = this;
						so.connect(nc);
						so.addEventListener(SyncEvent.SYNC, syncHandler);
					break;
				case "NetConnection.Connect.Rejected":
					trace("NetConnection.Connect.Rejected")
					break;
				case "NetConnection.Connect.Failed":
					trace("NetConnection.Connect.Failed")
					break;
			}
		}
		
		protected function syncHandler(event:SyncEvent):void
		{
//			var txtOutput:String = "";
//			
//			for (var prop:String in so.data.listUsers) 
//			{
//				txtOutput += prop +"\n";
//			}
//			var eventUser:UserEvent = new UserEvent(UserEvent.SAVED_USER); 
//			eventUser.user = new User();
//			eventUser.user.nickName = txtOutput;
//			dispatcher.dispatchEvent(eventUser);
		}
		
		/**
		 * In a real app, we'd invoke a RemoteObject, HTTPService, etc.
		 * For this simple example, we'll set a random ID on the User
		 * to simulate the process of saving a User.
		 */ 
		public function saveUser(user:User, resultSaveUser:Function) : void
		{

			nc.call("user.saveUser", null, user.firstName, user.lastName, user.nickName);
			
			resultSaveUser.call(this, new ResultEvent("save"));
			
//			if (so != null)
//			{					
//				if (so.data.hasOwnProperty("listUsers"))
//					{
//					allUsers = so.data.listUsers;
//					allUsers.addItem(user);
//
//					so.setProperty("listUsers", allUsers);
//				}
//				else 
//				{
//					allUsers.addItem(user);
//
//					so.setProperty("listUsers", allUsers);
//				}
//			}
			
		}
		
		public function savedUser(first:String, last:String, forwarder:String):void
		{
			var eventUser:UserEvent = new UserEvent(UserEvent.SAVED_USER); 
			eventUser.user = new User();
			eventUser.user.firstName = first;
			eventUser.user.lastName = last;
			eventUser.user.nickName = forwarder;
			dispatcher.dispatchEvent(eventUser);
		}

	}
}