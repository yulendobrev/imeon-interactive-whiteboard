package chatevent
{
	import flash.events.Event;
	
	import mvc.model.Chat;
	
	public class ChatEvent extends Event
	{
		public static const SEND_MESSAGE:String = "sendMessage"; 
		public static const RECEIVED_MESSAGE:String = "receivedMessage";
		public var chat:Chat;
		
		/**
		 * This is just a normal Flex event. The only thing to note is that we set 'bubbles' to true,
		 * so that the event will bubble up the display list, allowing Swiz to listen for your events.
		 */ 
		public function ChatEvent( type:String )
		{
			super( type, true );
		}
	}
}