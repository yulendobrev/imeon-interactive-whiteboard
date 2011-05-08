package mvc.controller
{
	import whiteboardevent.RectangleEvent;

	public class WhiteboardController
	{
		[Inject]
		public var serviceHelper : ServiceHelper;
		
		[EventHandler( event = "RectangleEvent.ADDED" )]
		public function addRectange(event:RectangleEvent = null):void
		{
			Alert.show("Added rectangle.");
		}
	}
}