package whiteboardevent
{
	import flash.events.Event;
	
	import mvc.model.RectangleData;
	
	import spark.primitives.Rect;

	public class RectangleEvent extends Event
	{
		public static const ADDED:String = "rectangleAdded";
		public static const REMOVED:String = "rectangleRemoved";
		public static const REMOTE_ADDED:String = "rectangleRemoteAdded";
		public static const REMOTE_REMOVED:String = "rectangleRemoteRemoved";
		
		public var data:RectangleData;
		
		public function RectangleEvent(type:String = ADDED, rect:Rect = null)
		{
			super(type, true);
			
			if(rect != null)
			{
				data = new RectangleData();
				data.rect = rect;
			}
		}
	}
}