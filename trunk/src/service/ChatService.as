package service
{
	import chatevent.ChatEvent;
	
	import flash.events.*;
	import flash.net.*;
	
	import mvc.model.Chat;
	
	import mx.events.FlexEvent;
	import mx.rpc.events.ResultEvent;
	
	public class ChatService
	{
		private var nc:NetConnection;
		private var so:SharedObject;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher; 
	
		public function ChatService()
		{
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			nc.client = this;
			nc.connect("rtmpt://87.121.97.85:1935/whiteboard_chat"); //87.121.97.85
		
//			so = SharedObject.getRemote("message", nc.uri, false);
//			so.addEventListener(SyncEvent.SYNC, soOnSync);
//			so.client = this;
//			so.connect(nc);
		
		}
	
		public function sendMessage(chat:Chat):void
		{
			nc.call("chat.sendMessage", null, chat.message, chat.forwarder, chat.time.getHours(),
									chat.time.getMinutes(), chat.time.getSeconds()); 
			
		}
	
		public function receiveMessage(mesg:String, forwarder:String, hh:uint, mm:uint, ss:uint):void
		{
			var eventChat:ChatEvent = new ChatEvent(ChatEvent.RECEIVED_MESSAGE);
			eventChat.chat = new Chat();
			eventChat.chat.message = mesg+"\n";
			eventChat.chat.forwarder = forwarder;
			eventChat.chat.time = new Date();
			eventChat.chat.time.hours = hh;
			eventChat.chat.time.minutes = mm;
			eventChat.chat.time.seconds = ss;
			dispatcher.dispatchEvent(eventChat);
		}
	
		private function soOnSync(event:SyncEvent):void
		{
//			var txtOutput:String;
//			
//			for (var prop:String in so.data) 
//			{
//				txtOutput += "prop "+prop+" = "+so.data[prop]+"\n";
//			}
//			var eventChat:ChatEvent = new ChatEvent(ChatEvent.RECEIVED_MESSAGE);
//			eventChat.chat = new Chat();
//			eventChat.chat.message = txtOutput;
//			eventChat.chat.forwarder = forwarder;
//			dispatcher.dispatchEvent(eventChat);
		}
	
//		public function close(...args):void
//		{
//			//trace("close: "+args);
//		}	
		
		private function netStatusHandler(event:NetStatusEvent):void 
		{
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
					trace("NetConnection.Connect.Success")
					so = SharedObject.getRemote("message", nc.uri, false);
					so.addEventListener(SyncEvent.SYNC, soOnSync);
					so.client = this;
					so.connect(nc);
					break;
				case "NetConnection.Connect.Rejected":
					trace("NetConnection.Connect.Rejected")
					break;
				case "NetConnection.Connect.Failed":
					trace("NetConnection.Connect.Failed")
					break;
			}
		}
		


		
	}
	
}