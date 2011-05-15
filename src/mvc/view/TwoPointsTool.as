package mvc.view
{
	import flash.events.MouseEvent;
	
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	import spark.components.ToggleButton;
	import spark.components.supportClasses.SkinnableComponent;
	
	internal class TwoPointsTool extends SkinnableComponent
	{
		public function TwoPointsTool()
		{
			super();
		}
		
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
		
		protected override function partAdded(partName:String, instance:Object):void
		{
			if(instance === toolButton)
			{
				toolButton.addEventListener(MouseEvent.CLICK, determineToolMode);
			}
			
			super.partAdded(partName, instance);
		}
		
		protected override function partRemoved(partName:String, instance:Object):void
		{
			if(instance === toolButton)
			{
				detachToolHandlers();
				toolButton.removeEventListener(MouseEvent.CLICK, determineToolMode);
			}
			
			super.partRemoved(partName, instance);
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
				_board.removeEventListener(MouseEvent.MOUSE_MOVE, rawUpdateElement);
				_board.removeEventListener(MouseEvent.CLICK, stopDraw);
			}
		}
		
		private function startDraw(event:MouseEvent):void
		{
			var element:IVisualElement;
			element = createElement(event.localX, event.localY);
			
			if(element != null)
				_board.addElement(element);
			
			_board.removeEventListener(MouseEvent.CLICK, startDraw);
			_board.addEventListener(MouseEvent.MOUSE_MOVE, rawUpdateElement);
			_board.addEventListener(MouseEvent.CLICK, stopDraw);
		}
		
		protected function createElement(x:Number, y:Number):IVisualElement
		{
			return null;
		}
		
		private function rawUpdateElement(event:MouseEvent):void
		{
			updateElement(event.localX, event.localY);
		}
		
		protected function updateElement(x:Number, y:Number):void
		{	
		}
		
		private function stopDraw(event:MouseEvent):void
		{
			_board.removeEventListener(MouseEvent.CLICK, stopDraw);
			_board.removeEventListener(MouseEvent.MOUSE_MOVE, rawUpdateElement);
			_board.addEventListener(MouseEvent.CLICK, startDraw);
			
			dispatchElementDrawn();
		}
		
		protected function dispatchElementDrawn():void
		{
		}
	}
}