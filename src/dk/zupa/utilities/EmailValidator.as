package dk.zupa.utilities
{
	
	/**
	 * 
	 * Usage:
	 * import dk.zupa.utilities.EmailValidation;
	 * 
	 * trace(EmailValidation.check("icd2k3@gmail.com")); // true
	 * trace(EmailValidation.check("icd2k3gmail.com")); // false
	 * trace(EmailValidation.check("icd2k3@gmail.c")); // false
	 * 
	 */	
	
	
	public class EmailValidator
	{
		public static function check(email:String):Boolean
		{
			var myRegEx:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var myResult:Object = myRegEx.exec(email);
			if(myResult == null)
			{
				return false;
			}
			return true;
			
		}
	}
}

