package mvc.model
{
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.primitives.Rect;

	public class RectangleData
	{
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		/*public var borderWidth:Number;
		public var borderColor:uint;
		public var fillColor:uint;
		public var alpha:Number;*/
		
		public function RectangleData()
		{
		}
		
		public static function rect(data:RectangleData):Rect
		{
			var result:Rect = new Rect();
			
			result.stroke = new SolidColorStroke(0x800010, 2);
			result.fill = new SolidColor(0xff0000);
			result.x = data.x;
			result.y = data.y;
			result.width = data.width;
			result.height = data.height;
			
			return result;
		}
		
		public function set rect(value:Rect):void
		{
			if(value != null)
			{
				x = value.x;
				y = value.y;
				width = value.width;
				height = value.height;
			}
		}
	}
}