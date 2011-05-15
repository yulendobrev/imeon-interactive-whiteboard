package mvc.view
{
	import mx.core.IVisualElement;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.primitives.Rect;
	
	import whiteboardevent.RectangleEvent;
	
	public class RectTool extends TwoPointsTool
	{
		private var _currentRect:Rect;
		
		public function RectTool()
		{
			super();
		}

		protected override function createElement(x:Number, y:Number):IVisualElement
		{
			_currentRect = new Rect();
			
			_currentRect.stroke = new SolidColorStroke(0x800010, 2);
			_currentRect.fill = new SolidColor(0xff0000);
			_currentRect.x = x;
			_currentRect.y = y;
			_currentRect.width = _currentRect.height = 1;
			
			return _currentRect;
		}
		
		protected override function updateElement(x:Number, y:Number):void
		{
			_currentRect.width = x - _currentRect.x;
			_currentRect.height = y - _currentRect.y;
		}
		
		protected override function dispatchElementDrawn():void
		{
			var rectEvent:RectangleEvent = new RectangleEvent(RectangleEvent.ADDED);
			
			rectEvent.x = _currentRect.x;
			rectEvent.y = _currentRect.y;
			rectEvent.width = _currentRect.width;
			rectEvent.height = _currentRect.height;
			rectEvent.borderWidth = _currentRect.stroke.weight;
			rectEvent.alpha = _currentRect.alpha;
			
			dispatchEvent(rectEvent);
		}
	}
}