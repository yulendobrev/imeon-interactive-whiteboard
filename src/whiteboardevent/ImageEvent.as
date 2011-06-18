package whiteboardevent
{
	import flash.events.Event;
	
	import mvc.model.ImageData;
	
	public class ImageEvent extends Event
	{
		public static const ADDED:String = "imageAdded";
		public static const REMOVED:String = "imageRemoved";
		public static const REMOTE_ADDED:String = "imageRemoteAdded";
		public static const REMOTE_REMOVED:String = "imageRemoteRemoved";
		
		public var data:ImageData;
		
		public function ImageEvent(type:String, bubbles:Boolean=true)
		{
			super(type, bubbles);
		}
	}
}