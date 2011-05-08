package mvc.view
{
	import flash.events.ContextMenuEvent;
	import flash.events.MouseEvent;
	
	import mx.core.mx_internal;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import mx.states.OverrideBase;
	
	import spark.components.Group;
	import spark.components.ToggleButton;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.primitives.Rect;
	
	import whiteboardevent.RectangleEvent;
	
	public class RectTool extends SkinnableComponent
	{
		private var _currentRect:Rect;
		
		private var _board:Group;
		public function get board():Group
		{
			return _board;
		}
		
		public function set board(value:Group):void
		{
			_board = value;
		}
		
		[SkinPart]
		public var toolButton:ToggleButton;
		
		public function RectTool()
		{
			super();
		}
		
		protected override function partAdded(partName:String, instance:Object):void
		{
			if(instance === toolButton)
			{
				toolButton.addEventListener(MouseEvent.CLICK, determineToolMode);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void
		{
			if(instance === toolButton)
			{
				detachToolHandlers();
				toolButton.removeEventListener(MouseEvent.CLICK, determineToolMode);
			}
		}
		
		protected function determineToolMode(event:MouseEvent):void
		{
			if(toolButton.selected)
			{
				attachToolHandlers();
			}
			else
			{
				detachToolHandlers();
			}
		}
		
		protected function attachToolHandlers():void
		{
			if(_board != null)
			{
				_board.addEventListener(MouseEvent.CLICK, startDraw);
			}
		}
		
		protected function detachToolHandlers():void
		{
			if(_board != null)
			{
				_board.removeEventListener(MouseEvent.CLICK, startDraw);
				_board.removeEventListener(MouseEvent.MOUSE_MOVE, updateRect);
				_board.removeEventListener(MouseEvent.CLICK, stopDraw);
			}
		}
		
		protected function startDraw(event:MouseEvent):void
		{
			_currentRect = new Rect();
			
			_currentRect.stroke = new SolidColorStroke(0x800010, 2);
			_currentRect.fill = new SolidColor(0xff0000);
			_currentRect.x = event.localX;
			_currentRect.y = event.localY;
			_currentRect.width = _currentRect.height = 1;
			
			_board.addElement(_currentRect);
			
			_board.removeEventListener(MouseEvent.CLICK, startDraw);
			_board.addEventListener(MouseEvent.MOUSE_MOVE, updateRect);
			_board.addEventListener(MouseEvent.CLICK, stopDraw);
		}
		
		protected function updateRect(event:MouseEvent):void
		{
			_currentRect.width = event.localX - _currentRect.x;
			_currentRect.height = event.localY - _currentRect.y;
		}
		
		protected function stopDraw(event:MouseEvent):void
		{
			var rectEvent:RectangleEvent = new RectangleEvent(RectangleEvent.ADDED);
			
			_board.removeEventListener(MouseEvent.CLICK, stopDraw);
			_board.removeEventListener(MouseEvent.MOUSE_MOVE, updateRect);
			_board.addEventListener(MouseEvent.CLICK, startDraw);
			
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