package mvc.view
{
	import flash.display.DisplayObject;

	public interface IBoardElementFactory
	{
		function createElement(data:Object):DisplayObject
	}
}