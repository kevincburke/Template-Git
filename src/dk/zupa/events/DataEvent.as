package dk.zupa.events
{
	import flash.events.Event;
	
	public class DataEvent extends Event
	{
		//public static const INIT:String = "Initialize";
		public var data:Object;
		
		public function DataEvent(type:String, bubbles:Boolean=false, data:Object=null, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new DataEvent(type, bubbles, data, cancelable);
		}

	}
}