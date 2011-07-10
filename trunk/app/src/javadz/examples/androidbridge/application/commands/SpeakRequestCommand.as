package javadz.examples.androidbridge.application.commands
{
	import javadz.examples.androidbridge.application.events.SpeakRequestEvent;
	import javadz.examples.androidbridge.infrastructure.messages.VoiceRecognitionRequestMessage;
	
	import merapi.handlers.MessageHandler;
	import merapi.messages.IMessage;

	public class SpeakRequestCommand 
	{
		
		
		//--------------------------------------------------------------------------
		//
		//  Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * The execute event that dispatches the navigation message
		 * 
		 * @param event Event
		 * @return void
		 */
		public function execute(event:SpeakRequestEvent):void
		{
			var requestMessage : VoiceRecognitionRequestMessage =  new VoiceRecognitionRequestMessage();
			requestMessage.execute = true;
			requestMessage.send();
		}
		
	}
}