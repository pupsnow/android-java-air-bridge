////////////////////////////////////////////////////////////////////////////////
//
//  This program is free software; you can redistribute it and/or modify 
//  it under the terms of the GNU General Public License as published by the 
//  Free Software Foundation; either version 3 of the License, or (at your 
//  option) any later version.
//
//  This program is distributed in the hope that it will be useful, but 
//  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
//  or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
//  for more details.
//
//  You should have received a copy of the GNU General Public License along 
//  with this program; if not, see <http://www.gnu.org/licenses>.
//
////////////////////////////////////////////////////////////////////////////////

package merapi;

import java.io.OutputStream;

import merapi.io.amf.AMF3Writer;
import merapi.io.writer.IWriter;
import merapi.messages.IMessage;

/**
 * The <code>BridgeListenerThread</code> listens for messages from a client socket and notifies
 * the bridge when a message is received.
 *
 * @see merapi.Bridge;
 * @see merapi.messages.IMessage;
 */
public class BridgeWriterThread extends Thread {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     * Constructor.
     */
    public BridgeWriterThread() 
    {
        super();
    }
    
    private byte[] bytes;
    
    
    private Boolean bytesChanged = false;

    
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @override 
	 * 
	 *  The run method of the thread that reads data from the input stream. When a messaged is
	 *  deserialized it is writen to the output stream
	 */
	public void run() 
	{
		while (true) 
        {  
             
             if (bytesChanged && __outputStream != null) 
             {  
            	 try 
            	 {
            		//  Send the length of the message first
 	     	        __outputStream.write( bytes.length );
 	     	        
 	     	        //  Send the message
 	     	        __outputStream.write( bytes );
            		 
 	     	        __outputStream.flush();
 	     	        
 	     	       __outputStream = null;
           		 
            	 } 
            	 catch (Exception e) 
            	 {
         			// TODO Auto-generated catch block        	  
         			e.printStackTrace();
            	 }  
            	
            	bytes = null;
     	       	bytesChanged = false;
             }  
        } 
           
	}
	
	
	public void setMessage( IMessage message, OutputStream outputStream )
	{
		__outputStream 	= outputStream;
        __writer = new AMF3Writer();
		
		try 
		{  
			bytes = __writer.write( message );
			bytesChanged = true;
		 
		} 
		catch (Exception e) 
		{
			// TODO Auto-generated catch block        	  
			e.printStackTrace();
		}  	        
			
	}


    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     * @private The output stream from the socket connected to Flex to the bridge.
     */
    private OutputStream __outputStream = null;

    /**
     * @private The writer used to serialize Objects sent across the bridge.
     */
    private IWriter __writer = null;

    /**
     * @private An instance of the log4j logger to handle the logging.
     */
    //private Logger __logger = Logger.getLogger(BridgeListenerThread.class);
	
}
