package mvc.model
{
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import spark.primitives.Ellipse;

	public class EllipseData
	{
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		
		public function EllipseData()
		{
		}
		
		public static function ellipse(data:EllipseData):Ellipse
		{
			var result:Ellipse = new Ellipse();
			
			result.stroke = new SolidColorStroke(0x406030, 2);
			result.fill = new SolidColor(0x40c000);
			result.x = data.x;
			result.y = data.y;
			result.width = data.width;
			result.height = data.height;
			
			return result;
		}
		
		public function set ellipse(value:Ellipse):void
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