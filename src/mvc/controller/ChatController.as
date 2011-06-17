package mvc.controller
{
	import chatevent.ChatEvent;
	
	import mvc.model.Chat;
	
	import mx.core.FlexGlobals;
	import mx.rpc.events.ResultEvent;
	
	import service.ChatService;

	public class ChatController
	{
		[Inject]
		public var chatService:ChatService;
		
		[Bindable]
		public var currentChat:Chat;
		
		[PostConstruct]
		public function createCurrentChat():void
		{
			currentChat = new Chat();
		}
				
		[EventHandler(event="ChatEvent.SEND_MESSAGE", properties="chat")]
		public function sendMessage(chat:Chat):void
		{
			
			chatService.sendMessage(chat);
		}
		
		[EventHandler(event="ChatEvent.RECEIVED_MESSAGE", properties="chat")]
		public function receivedMessage(chat:Chat):void
		{
			FlexGlobals.topLevelApplication.UserForm.txtOutput.text += chat.message;
		}
			
	}
}