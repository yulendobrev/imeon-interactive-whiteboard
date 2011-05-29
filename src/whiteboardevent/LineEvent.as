package whiteboardevent
{
	import flash.events.Event;
	
	import mvc.model.LineData;
	
	import spark.primitives.Line;
	
	public class LineEvent extends Event
	{
		public static const ADDED:String = "lineAdded";
		public static const REMOVED:String = "lineRemoved";
		public static const REMOTE_ADDED:String = "lineRemoteAdded";
		public static const REMOTE_REMOVED:String = "lineRemoteRemoved";
		
		public var data:LineData;
		
		public function LineEvent(type:String = ADDED, line:Line = null)
		{
			super(type, true);
			
			if(line != null)
			{
				data = new LineData();
				data.line = line;
			}
		}
	}
}