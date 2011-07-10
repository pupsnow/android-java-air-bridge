package javadz.examples.androidbridge;

import merapi.handlers.MessageHandler;
import merapi.messages.IMessage;
import android.util.Log;


public class VoiceRecognitionRequestHandler extends MessageHandler 
{
	public VoiceRecognitionRequestHandler()
	{
		super( VoiceRecognitionRequestMessage.REQUEST_VOICE_RECOGNITION );
	}
	
	
	private IVoiceRecognitionActivity _caller;


	/**
	 * @param _caller the _caller to set
	 */
	public void setCaller(IVoiceRecognitionActivity value) {
		_caller = value;
	}


	/**
     *  Handles the VoiceRecognitionRequestMessage.REQUEST_VOICE_RECOGNITION message type.
     */ 
    public void handleMessage( IMessage message )
    {
    	Log.v("[VoiceRecognitionRequestHandler]", "in handleMessage");
		
    	if ( message instanceof VoiceRecognitionRequestMessage )
        {
    		VoiceRecognitionRequestMessage msg = ( VoiceRecognitionRequestMessage ) message;
    		
    		_caller.startVoiceRecognitionActivity();
    		
    		Log.v("[VoiceRecognitionRequestHandler]", "received VoiceRecognitionRequestMessage");
    		
        } 
    	else 
    	{
        	Log.v("[VoiceRecognitionRequestHandler]", "handleMessage not a VoiceRecognitionRequestMessage");
        }
    }
    
}





