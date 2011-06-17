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
			nc.connect("rtmp:/whiteboard_chat");
		
			so = SharedObject.getRemote("message", nc.uri, false);
			so.addEventListener(SyncEvent.SYNC, soOnSync);
			so.client = this;
			so.connect(nc);
		
		}
	
		public function sendMessage(chat:Chat):void
		{
			nc.call("chat.sendMessage", null, chat.message); 
			
		}
	
		public function receiveMessage(mesg:String):void
		{
			var txtOutput:String;
			txtOutput = mesg+"\n";
			var eventChat:ChatEvent = new ChatEvent(ChatEvent.RECEIVED_MESSAGE);
			eventChat.chat = new Chat();
			eventChat.chat.message = txtOutput;
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
//			var eventChat:ChatEvent = new ChatEvent(ChatEvent.SEND_MESSAGE);
//			eventChat.chat = new Chat();
//			eventChat.chat.messageOutput = txtOutput;
//			dispatcher.dispatchEvent(eventChat);
		}
	
	
		private function netStatusHandler(event:NetStatusEvent):void 
		{

		}
		
	}
	
}