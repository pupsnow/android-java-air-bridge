package javadz.examples.androidbridge.infrastructure.handlers
{
	
	import javadz.examples.androidbridge.domain.RecognisedResponse;
	import javadz.examples.androidbridge.infrastructure.messages.VoiceRecognitionResponseMessage;
	
	import merapi.handlers.MessageHandler;
	import merapi.messages.IMessage;

	public class VoiceRecognitionResponseHandler extends MessageHandler
	{
		public function VoiceRecognitionResponseHandler()
		{
			super( VoiceRecognitionResponseMessage.VOICE_RECOGNITION_RESPONSE );
		}
		
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		[Inject]
		[Bindable]		
		/**
		 * Publishes the response text that gets set in handleMessage method below
		 */
		public var recognisedResponse:RecognisedResponse;
		
		
		/**
		 * @inheritDoc
		 */
		override public function handleMessage( message : IMessage ) : void
		{
			trace( "[VoiceRecognitionResponseHandler] handleMessage" )
			if ( message is VoiceRecognitionResponseMessage )
			{
				
				recognisedResponse.responseText = VoiceRecognitionResponseMessage(message).responseText;
				
				trace( "[VoiceRecognitionResponseHandler] handleMessage " + recognisedResponse.responseText);
			}
		}
	}
}