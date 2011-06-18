package service
{
	import flash.events.IEventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SyncEvent;
	import flash.net.NetConnection;
	import flash.net.SharedObject;
	import flash.net.registerClassAlias;
	
	import mvc.model.EllipseData;
	import mvc.model.ImageData;
	import mvc.model.LineData;
	import mvc.model.RectangleData;
	import mvc.view.renderers.ImageRenderer;
	
	import spark.primitives.Ellipse;
	import spark.primitives.Line;
	import spark.primitives.Rect;
	
	import whiteboardevent.EllipseEvent;
	import whiteboardevent.LineEvent;
	import whiteboardevent.RectangleEvent;

	public class DrawingService
	{
		private var nc:NetConnection;
		private var so:SharedObject;
		
		[Dispatcher]
		public var dispatcher:IEventDispatcher;
		
		public static const ADDRESS:String =
			//"rtmpt://87.121.97.85/drawing";
			"rtmpt://localhost/drawing";
		
		public function DrawingService()
		{
			registerClassAlias("RectangleData", RectangleData);
			registerClassAlias("LineData", LineData);
			registerClassAlias("EllipseData", EllipseData);
			
			nc = new NetConnection();
			nc.addEventListener(NetStatusEvent.NET_STATUS, statusReady);
			nc.client = this;
			nc.connect(ADDRESS);
		}
		
		protected function statusReady(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success":
					so = SharedObject.getRemote("Drawing", nc.uri, true);
					so.client = this;
					so.addEventListener(SyncEvent.SYNC, syncDrawing);
					so.connect(nc);
					break;
				case "NetConnection.Connect.Closed":
				case "NetConnection.Connect.Failed":
				case "NetConnection.Connect.Rejected":
					break;
			}
		}
		
		protected function syncDrawing(event:SyncEvent):void
		{
			var changes:Array = event.changeList;
			for each(var change:* in changes)
			{
			}
		}
		
		private var id:String;
		public function setID(id:String = "0"):void
		{
			this.id = id;
		}
		
		public function rectangleDrawn(ID:String, data:RectangleData):void
		{
			if(id == ID)
				return;
			
			var type:String = RectangleEvent.REMOTE_ADDED;
			var rect:Rect = RectangleData.rect(data);
			dispatcher.dispatchEvent(new RectangleEvent(type, rect));
		}
		
		public function lineDrawn(ID:String, data:LineData):void
		{
			if(id == ID)
				return;
			
			var type:String = LineEvent.REMOTE_ADDED;
			var line:Line = LineData.line(data);
			dispatcher.dispatchEvent(new LineEvent(type, line));
		}
		
		public function ellipseDrawn(ID:String, data:EllipseData):void
		{
			if(id == ID)
				return;
			
			var type:String = EllipseEvent.REMOTE_ADDED;
			var ellipse:Ellipse = EllipseData.ellipse(data);
			dispatcher.dispatchEvent(new EllipseEvent(type, ellipse));
		}
		
		public function imageAdded(ID:String, data:ImageData):void
		{
			if(id == ID)
				return;
			
			var type:String = ImageEvent.REMOTE_ADDED;
			dispatcher.dispatchEvent(new ImageEvent(type, data));
		}
		
		public function notifyRectangleDrawn(data:RectangleData):void
		{
			if(so)
				so.send("rectangleDrawn", id, data);
		}
		
		public function notifyLineDrawn(data:LineData):void
		{
			if(so)
				so.send("lineDrawn", id, data);
		}
		
		public function notifyEllipseDrawn(data:EllipseData):void
		{
			if(so)
				so.send("ellipseDrawn", id, data);
		}
		
		public function notifyImageAdded(data:ImageData):void
		{
			if(so)
				so.send("imageAdded", id, data);
		}
	}
}