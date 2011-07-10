package javadz.examples.androidbridge.infrastructure.messages
{
	import merapi.messages.Message;
	
	[RemoteClass( alias="javadz.examples.androidbridge.VoiceRecognitionResponseMessage" )]
	
	public class VoiceRecognitionResponseMessage extends Message
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 */
		public function VoiceRecognitionResponseMessage()
		{
			super( VoiceRecognitionResponseMessage.VOICE_RECOGNITION_RESPONSE );
		}
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		/**
		 *  Message type for a VoiceRecognitionResponseMessage message.
		 */
		public static const VOICE_RECOGNITION_RESPONSE : String = "voiceRecognitionResponse";
		
		
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

