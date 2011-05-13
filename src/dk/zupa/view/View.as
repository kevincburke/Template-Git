package dk.zupa.view
{		
	import dk.zupa.controller.Controller;
	import dk.zupa.events.DataEvent;
	import dk.zupa.model.Model;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	public class View extends Sprite
	{
		// the View registers the Model
		private var model:Model;
		
		public function View(model:Model)
		{
			this.model = model;
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function init (e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.align = StageAlign.LEFT;
			
			this.x = this.stage.stageWidth/2;
			this.y = this.stage.stageHeight/2;
			
			var logo:ZupaLogo = new ZupaLogo;
			addChild(logo);
		}

	}
}