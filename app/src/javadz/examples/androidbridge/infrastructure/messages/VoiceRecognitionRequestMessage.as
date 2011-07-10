package javadz.examples.androidbridge.infrastructure.messages
{
	import merapi.messages.Message;

	[RemoteClass( alias="javadz.examples.androidbridge.VoiceRecognitionRequestMessage" )]
	
	public class VoiceRecognitionRequestMessage extends Message
	{
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		/**
		 * Constructor
		 */
		public function VoiceRecognitionRequestMessage()
		{
			super( VoiceRecognitionRequestMessage.REQUEST_VOICE_RECOGNITION );
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Constants
		//
		//--------------------------------------------------------------------------
		/**
		 *  Message type for a VoiceRecognitionRequestMessage message.
		 */
		public static const REQUEST_VOICE_RECOGNITION : String = "requestVoiceRecognition";
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		
		//------------------------
		// execute
		//------------------------
		/**
		 * @private
		 */
		private var _execute : Boolean;

		[Bindable]
		/**
		 * execute flag to request voice recognition when true
		 */
		public function get execute():Boolean
		{
			return _execute;
		}
		
		/**
		 * @private
		 */
		public function set execute(value:Boolean):void
		{
			_execute = value;
		}

	}
}