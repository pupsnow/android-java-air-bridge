package javadz.examples.androidbridge;

import merapi.messages.Message;

public class VoiceRecognitionResponseMessage extends Message
{

	public VoiceRecognitionResponseMessage()
	{
		super( VoiceRecognitionResponseMessage.VOICE_RECOGNITION_RESPONSE );
	}
	
	public static final String VOICE_RECOGNITION_RESPONSE = "voiceRecognitionResponse";
	
	private String _responseText;

	/**
	 * @return the _responseText
	 */
	public String getResponseText() {
		return _responseText;
	}

	/**
	 * @param value the _responseText to set
	 */
	public void setResponseText(String value) {
		_responseText = value;
	}
}
