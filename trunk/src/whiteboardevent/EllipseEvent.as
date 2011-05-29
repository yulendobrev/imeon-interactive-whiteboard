package whiteboardevent
{
	import flash.events.Event;
	
	import mvc.model.EllipseData;
	
	import spark.primitives.Ellipse;
	
	public class EllipseEvent extends Event
	{
		public static const ADDED:String = "ellipseAdded";
		public static const REMOVED:String = "ellipseRemoved";
		public static const REMOTE_ADDED:String = "ellipseRemoteAdded";
		public static const REMOTE_REMOVED:String = "ellipseRemoteRemoved";
		
		public var data:EllipseData;
		
		public function EllipseEvent(type:String = ADDED, ellipse:Ellipse = null)
		{
			super(type, true);
			
			if(ellipse != null)
			{
				data = new EllipseData();
				data.ellipse = ellipse;
			}
		}
	}
}