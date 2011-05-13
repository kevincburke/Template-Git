package
{
	import dk.zupa.controller.Controller;
	import dk.zupa.model.Model;
	import dk.zupa.view.View;
	
	import flash.display.Sprite;
	
	[SWF(width='1000',height='800',backgroundColor='#FFFFFF',frameRate='31',pageTitle="Zupa Template")]
	public class Template extends Sprite
	{
		private var model:Model;
		private var view:View;
		private var controller:Controller;
		
		public function Template()
		{
			model = new Model();
			view = new View(model);
			controller = new Controller(model, view);
			addChild(view);
		}
	}
}