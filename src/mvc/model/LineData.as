package mvc.model
{
	import mx.graphics.SolidColorStroke;
	
	import spark.primitives.Line;

	public class LineData
	{
		public var x0:Number;
		public var y0:Number;
		public var x1:Number;
		public var y1:Number;
		
		public function LineData()
		{
		}
		
		public static function line(data:LineData):Line
		{
			var result:Line = new Line();
			
			result.stroke = new SolidColorStroke(0x805000, 2);
			result.xFrom = data.x0;
			result.yFrom = data.y0;
			result.xTo = data.x1;
			result.yTo = data.y1;
			
			return result;
		}
		
		public function set line(value:Line):void
		{
			if(value != null)
			{
				x0 = value.xFrom;
				y0 = value.yFrom;
				x1 = value.xTo;
				y1 = value.yTo;
			}
		}
	}
}