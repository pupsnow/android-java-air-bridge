package javadz.examples.androidbridge;

import java.util.ArrayList;

import merapi.Bridge;
import air.app.AppEntry;
import android.content.Intent;
import android.os.Bundle;
import android.speech.RecognizerIntent;

public class MainApp extends AppEntry implements IVoiceRecognitionActivity
{
	
	private static final int REQUEST_CODE = 1234;	
	
	private VoiceRecognitionRequestHandler requestHandler = new VoiceRecognitionRequestHandler();
	
	private VoiceRecognitionResponseMessage responseMessage = new VoiceRecognitionResponseMessage();
	
    
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        
        Bridge.open();        
        
        requestHandler.setCaller( this );
    }
    
    
    @Override
    public void onDestroy() 
    {
    	Bridge.close();
    }
	 
    
	/**
     * Handle the results from the voice recognition activity.
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data)
    {
        if (requestCode == REQUEST_CODE && resultCode == RESULT_OK)
        {
            // Fill the list view with the strings the recognizer thought it could have heard
            ArrayList<String> matches = data.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS);   
            
            responseMessage.setResponseText( matches.get(0) );	
            
            try
			{
            	responseMessage.send();
			} 
            catch (NullPointerException np1) 
            {
				System.out.println(np1.getMessage());
			}
           
        }
        
        super.onActivityResult(requestCode, resultCode, data);
    }
    
    
    
    
    public void startVoiceRecognitionActivity()
	{
    	Intent intent = new Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH);
        intent.putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM);
        startActivityForResult(intent, REQUEST_CODE);
	}
    
    
    
}