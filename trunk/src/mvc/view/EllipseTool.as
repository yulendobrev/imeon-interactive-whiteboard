package mvc.view
{
	import mx.core.IVisualElement;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.components.Group;
	import spark.primitives.Ellipse;
	
	import whiteboardevent.EllipseEvent;

	public class EllipseTool extends TwoPointsTool
	{
		private var _currentEllipse:Ellipse;
		
		public function EllipseTool()
		{
			super();
		}
		
		protected override function createElement(x:Number, y:Number):IVisualElement
		{
			_currentEllipse = new Ellipse();
			_currentEllipse.stroke = new SolidColorStroke(0x406030, 2);
			_currentEllipse.fill = new SolidColor(0x40c000);
			_currentEllipse.x = x;
			_currentEllipse.y = y;
			_currentEllipse.width = 0;
			_currentEllipse.height = 0;
			
			return _currentEllipse;
		}
		
		protected override function updateElement(x:Number, y:Number):void
		{
			_currentEllipse.width = x - _currentEllipse.x;
			_currentEllipse.height = y - _currentEllipse.y;
		}
		
		protected override function dispatchElementDrawn():void
		{
			var event:EllipseEvent =
				new EllipseEvent(EllipseEvent.ADDED, _currentEllipse);
			
			dispatchEvent(event);
		}
	}
}