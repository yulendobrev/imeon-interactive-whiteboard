package whiteboardevent
{
	import flash.events.Event;
	
	public class RectangleEvent extends Event
	{
		public static const ADDED:String = "rectangleAdded";
		public static const REMOVED:String = "rectangleRemoved";
		
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		public var borderWidth:Number;
		public var borderColor:uint;
		public var fillColor:uint;
		public var alpha:Number;
		
		public function RectangleEvent(type:String)
		{
			super(type, true);
		}
	}
}