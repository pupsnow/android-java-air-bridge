package javadz.examples.androidbridge.domain
{
	public class RecognisedResponse 
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 */
		public function RecognisedResponse()
		{
			
		}
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		//------------------------
		// responseText
		//------------------------
		/**
		 * @private
		 */
		private var _responseText : String;
		
		[Bindable]
		/**
		 * The response text
		 */
		public function get responseText():String
		{
			return _responseText;
		}

		/**
		 * @private
		 */
		public function set responseText(value:String):void
		{
			_responseText = value;
		}

	}
}

