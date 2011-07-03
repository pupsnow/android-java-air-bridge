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

import java.io.InputStream;
import java.util.ArrayList;

import merapi.io.reader.IReader;
import merapi.messages.IMessage;
import javadz.util.ByteBuffer;

/**
 * The <code>BridgeListenerThread</code> listens for messages from a client socket and notifies
 * the bridge when a message is received.
 *
 * @see merapi.Bridge;
 * @see merapi.messages.IMessage;
 */
public class BridgeListenerThread extends Thread {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     * Constructor.
     */
    public BridgeListenerThread( InputStream inputStream, IReader reader ) 
    {
        super();
        
        __inputStream 	= inputStream;
        __reader 		= reader;
    }

    
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  @override 
	 * 
	 *  The run method of the thread that reads data from the input stream. When a messaged is
	 *  deserialized it is broadcasted from the bridge via <code>Bridge.dispatchEvent</code>.
	 *  Registered listeners are notified of the event.
	 */
	public void run() {
	    //  The buffer used to read in bytes from __inputStream
	    ByteBuffer byteBuffer = new ByteBuffer();
	
	    //  The first byte returned in a data message
	    int firstByte = 0;
	
	    //  When the first byte returns is equal to -1, the socket has been disconnected
	    //  we let the thread end at the point.
	    while ( firstByte != -1 ) 
	    {
	        try 
	        {
	            //  Read the first byte from the stream, this call will block synchronously until
	            //  there is data read to read.
	            firstByte = __inputStream.read();
	
	            System.out.println( __inputStream.available() );
	            
	         
	
	            //  If the first byte is -1, the socket is disconnected.... fall out of the
	            //  while loop...
	            if ( firstByte != -1 ) 
	            {
	                //  Read the rest of the bytes from the stream
	                int b = firstByte;
	
	                while ( __inputStream.available() > 0 ) 
	                {
	                    byteBuffer.appendByte( b );
	                    b = __inputStream.read();
	                }
	                byteBuffer.appendByte( b );
	
	                ArrayList<IMessage> messages = __reader.read( byteBuffer.elems );
	
	                for ( IMessage message : messages ) 
	                {
	                    //  Broadcast the Message from the Bridge
	                    Bridge.getInstance().dispatchMessage( message );
	                }
	               
	                byteBuffer.reset();
	            }
	        }
	
	        catch ( Exception exception ) 
	        {
	            //Log.v("[BridgeListenerThread]", exception.getMessage().toString() );
	            
	            System.out.println( "[BridgeListenerThread]" + exception.getMessage().toString() );
	        }
	    }
	
	    //__logger.info( this.getClass().toString() + " stopped running." );
	    
	    //Log.v("[BridgeListenerThread]", " stopped running." );
	    
	    System.out.println( "[BridgeListenerThread]" + " stopped running." );
	}


    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     * @private The input stream from the socket connected from Flex to the bridge.
     */
    private InputStream __inputStream = null;

    /**
     * @private The reader used to deserialize Objects sent across the bridge.
     */
    private IReader __reader = null;

    /**
     * @private An instance of the log4j logger to handle the logging.
     */
    //private Logger __logger = Logger.getLogger(BridgeListenerThread.class);
	
}
