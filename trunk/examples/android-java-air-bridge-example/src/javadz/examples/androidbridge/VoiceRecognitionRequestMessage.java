package javadz.examples.androidbridge;

import merapi.messages.Message;
 
public class VoiceRecognitionRequestMessage extends Message
{
	public VoiceRecognitionRequestMessage()
	{
		super( VoiceRecognitionRequestMessage.REQUEST_VOICE_RECOGNITION );
	}
	
	public static final String REQUEST_VOICE_RECOGNITION = "requestVoiceRecognition";
	
	
	private Boolean _execute;


	/**
	 * @return the _execute
	 */
	public Boolean getExecute() {
		return _execute;
	}


	/**
	 * @param _execute the _execute to set
	 */
	public void setExecute(Boolean value) {
		_execute = value;
	}
	

}
