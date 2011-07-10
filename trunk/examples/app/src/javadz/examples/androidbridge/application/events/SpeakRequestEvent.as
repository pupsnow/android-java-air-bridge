package javadz.examples.androidbridge.application.events
{
	import flash.events.Event;
	
	public class SpeakRequestEvent extends Event
	{
		public function SpeakRequestEvent()
		{
			super(SpeakRequestEvent.SPEAK_REQUEST);
		}
		
		public static const SPEAK_REQUEST : String = "speakRequest";
	}
}