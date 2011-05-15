package mvc.view
{
	import mx.core.IVisualElement;
	import mx.graphics.SolidColorStroke;
	
	import spark.primitives.Line;

	public class LineTool extends TwoPointsTool
	{
		private var _currentLine:Line;
		
		public function LineTool()
		{
			super();
		}
		
		protected override function createElement(x:Number, y:Number):IVisualElement
		{
			_currentLine = new Line();
			_currentLine.stroke = new SolidColorStroke(0x805000, 2);
			_currentLine.xFrom = x;
			_currentLine.xTo = x;
			_currentLine.yFrom = y;
			_currentLine.yTo = y;
			
			return _currentLine;
		}
		
		protected override function updateElement(x:Number, y:Number):void
		{
			_currentLine.xTo = x;
			_currentLine.yTo = y;
		}
		
		protected override function dispatchElementDrawn():void
		{
		}
	}
}