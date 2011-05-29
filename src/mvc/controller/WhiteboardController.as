package mvc.controller
{
	import flash.events.EventDispatcher;
	
	import mvc.model.EllipseData;
	import mvc.model.LineData;
	import mvc.model.RectangleData;
	
	import org.swizframework.utils.services.ServiceHelper;
	
	import service.DrawingService;
	
	import whiteboardevent.EllipseEvent;
	import whiteboardevent.LineEvent;
	import whiteboardevent.RectangleEvent;

	public class WhiteboardController extends EventDispatcher
	{
		[Inject]
		public var serviceHelper:ServiceHelper;
		
		[Inject]
		public var drawingService:DrawingService;
		
		[EventHandler( event = "RectangleEvent.ADDED" )]
		public function addRectange(event:RectangleEvent):void
		{
			drawingService.notifyRectangleDrawn(event.data);
		}
		
		[EventHandler( event = "LineEvent.ADDED" )]
		public function addLine(event:LineEvent):void
		{
			drawingService.notifyLineDrawn(event.data);
		}
		
		[EventHandler( event = "EllipseEvent.ADDED" )]
		public function addEllipse(event:EllipseEvent):void
		{
			drawingService.notifyEllipseDrawn(event.data);
		}
		
		[EventHandler( event = "RectangleEvent.REMOTE_ADDED" )]
		public function drawRemoteRectange(event:RectangleEvent):void
		{
			dispatchEvent(new RectangleEvent(event.type, RectangleData.rect(event.data)));
		}
		
		[EventHandler( event = "LineEvent.REMOTE_ADDED" )]
		public function drawRemoteLine(event:LineEvent):void
		{
			dispatchEvent(new LineEvent(event.type, LineData.line(event.data)));
		}
		
		[EventHandler( event = "EllipseEvent.REMOTE_ADDED" )]
		public function drawRemoteEllipse(event:EllipseEvent):void
		{
			dispatchEvent(new EllipseEvent(event.type, EllipseData.ellipse(event.data)));
		}
	}
}