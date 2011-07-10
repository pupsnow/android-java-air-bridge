package javadz.examples.androidbridge.presentation
{
	
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import javadz.examples.androidbridge.application.events.SpeakRequestEvent;
	import javadz.examples.androidbridge.domain.RecognisedResponse;
	
	import merapi.handlers.MessageHandler;
	import merapi.messages.IMessage;

	[Event(name="responseTextChanged", type="flash.events.Event")]
	[Event(name="speakRequest", type="javadz.examples.androidbridge.application.events.SpeakRequestEvent")]
	
	[ManagedEvents("speakRequest")]
	
	public class VoiceRecognitionResponsePM extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
		//
		//  Properties
		//
		//--------------------------------------------------------------------------
		
		
		//------------------------
		// dispatcher
		//------------------------
		[MessageDispatcher]
		/**
		 * Dispatches the events - makes testing possible
		 */
		public var dispatcher:Function;
		
		
		//------------------------
		// responseText
		//------------------------
		[Inject]
		[Bindable]				
		public var recognisedResponse:RecognisedResponse;
		
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		/**
		 * Dispatches the SpeakRequestEvent so that speech recognition can be 
		 * requested via merapi in the SpeakRequestCommand
		 * 
		 * @return void
		 */
		public function speakRequest():void
		{
			dispatcher( new SpeakRequestEvent() );
		}
	}
}