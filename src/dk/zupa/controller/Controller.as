package dk.zupa.controller
{
	import dk.zupa.events.DataEvent;
	import dk.zupa.model.Model;
	import dk.zupa.view.View;
	
	import flash.events.MouseEvent;
	
	/**
	 *
	 * The Controller updates the Model when user input is received.
	 * 
	 */	
	
	public class Controller
	{
		// the Controller registers the Model and View
		private var model:Model;
		private var view:View;
		
		public function Controller(model:Model, view:View)
		{
			this.model = model;
			this.view = view;
		}
		
		public function saveTextToModel(e:DataEvent):void
		{
		}
	}
}