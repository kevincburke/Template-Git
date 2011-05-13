package dk.zupa.view.components
{	
	import com.greensock.TweenLite;
	
	import dk.zupa.interfaces.IMain;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;

	public class Preloader extends MovieClip
	{
		private var mc:MovieClip;
		private var mainContent:IMain;
		//private var percent_txt:TextField;
		
		public function Preloader()
		{
			super();
			trace("This is a message from the Preloader Class");
			addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		public function init(e:Event=null):void
		{			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var loader:Loader = new Loader();
			var request:URLRequest = new URLRequest("Template.swf");
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError, false, 0, true);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete, false, 0, true);
			loader.load(request);
		}
		
		private function onComplete(event:Event):void
		{
			TweenLite.to(percent_txt, .5, {alpha:0});
			addChild(event.currentTarget.content);
		}
		
		private function onIOError(event:Event):void
		{
			
		}
		
		private function progressHandler (e:ProgressEvent):void
		{
			percent_txt.text = Math.round((e.bytesLoaded/e.bytesTotal) * 100).toString();
		}
	}
}