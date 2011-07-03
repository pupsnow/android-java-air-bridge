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

package merapi
{

import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.Socket;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;

import merapi.error.MerapiErrorMessage;
import merapi.handlers.IMessageHandler;
import merapi.io.amf.AMF3Reader;
import merapi.io.amf.AMF3Writer;
import merapi.io.reader.IReader;
import merapi.io.writer.IWriter;
import merapi.messages.IMessage;

import mx.core.FlexGlobals;
import mx.rpc.IResponder;


/**
 *  The <code>Bridge</code> class is a singleton gateway to the native Merapi 
 *  <code>bridge</code>. <code>IMessages<code> are exchanged between this 
 *  client/ui <code>Bridge<code> instance and the native Merapi 
 *  <code>Bridge</code> counter part.
 * 
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.handlers.MessageHandler;
 *  @see merapi.handlers.mxml.CoreErrorHandler;
 *  @see merapi.messages.IMessage;
 *  @see merapi.messages.Message;
 */
public class Bridge
{
	//--------------------------------------------------------------------------
	//
	//  Constants
	//
	//--------------------------------------------------------------------------
	
	//--------------------------
	//  String literals
	//--------------------------
	
	private static const AUTO_CONNECT_STR   : String	= "autoConnect";
	private static const CLOSING            : String	= "closing";
	private static const EMPTY              : String	= ""; 
	private static const HOSTNAME           : String	= "hostname";
	private static const PORT_STR           : String	= "port";
	private static const READER             : String	= "reader";
	private static const TRUE               : String	= "true";
	private static const UID                : String	= "uid";
	private static const WRITER             : String	= "writer";
	

    //--------------------------------------------------------------------------
    //
    //  Static properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  PORT
    //----------------------------------
	
	/**
	 *  The port used to connect Merapi.
	 * 
	 *  (Configureable via merapi-client-config.xml)
	 */	
	public static var PORT : int 					= 12345; 		

    //----------------------------------
    //  HOST
    //----------------------------------
	
	/**
	 *  The host used to connect Merapi
	 * 
	 *  (Configureable via merapi-client-config.xml)
	 */	
	public static var HOST : String 				= "127.0.0.1";
	
    //----------------------------------
    //  READER_CLASS
    //----------------------------------
	
	/**
	 *  The <code>IReader</code> class to use for serialization
	 * 
	 *  (Configureable via merapi-client-config.xml)
	 */	
	public static var READER_CLASS : Class			= AMF3Reader;
	
    //----------------------------------
    //  WRITER_CLASS
    //----------------------------------
	
	/**
	 *  The <code>IWriter</code> class to use for deserialization
	 * 
	 *  (Configureable via merapi-client-config.xml)
	 */	
	public static var WRITER_CLASS : Class			= AMF3Writer;
	
    //----------------------------------
    //  CONFIG_PATH
    //----------------------------------
	
	/**
	 *  The path to the Merapi config xml
	 */
	public static var CONFIG_PATH : String		= "config/merapi-client-config.xml";
	
    //----------------------------------
    //  AUTO_CONNECT
    //----------------------------------

	/**
	 *  If true, the bridge will automatically connect on the first reference of the
	 *  instance. <code>Bridge.connect()</code> or the top level function <code>connectMerapi</code> 
	 *  may be invoked before the first reference of instance. In this case, AUTO_CONNECT 
	 *  is ignored. The default value is true.
	 */
	public static var AUTO_CONNECT : Boolean = true;
	
    //----------------------------------
    //  CONNECTED
    //----------------------------------

	public static function get CONNECTED() : Boolean
	{
		return __instance 						!= null 	&& 
			   __instance.__client			 	!= null		&& 
			   __instance.__client.connected	== true;
	}


    //--------------------------------------------------------------------------
    //
    //  Static methods
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Static code block that loads the Merapi config
	 */
	{ 
		readConfig(); 
	}

    /**
     *  The singleton instance of <code>Bridge</code>.
     */
	public static function getInstance() : Bridge 
	{ 
		if ( __instance == null ) 
		{
			__instance = new Bridge( new Bridge_SingletonBlocker );
		}
		return __instance; 
	}
	
	/**
	 *  Connects the Merapi Bridge. (If the Bridge is not connected.)
	 */
	public static function connect( port : int = -1, host : String = null ) : void
	{
		if ( Bridge.CONNECTED == false )
		{
			if ( port == -1   ) port = PORT;
			if ( host == null ) host = HOST;
			
			if ( __instance.__client != null )
			{
				__instance.__client.removeEventListener( IOErrorEvent.IO_ERROR, 
													     __instance.handleIOError );
			}

			try
			{			
				__instance.__client 	= new Socket( host, port );
				__instance.__client.addEventListener( IOErrorEvent.IO_ERROR, 
													  __instance.handleIOError );
				
				__instance.__client.addEventListener( ProgressEvent.SOCKET_DATA, 
													  __instance.handleReceiveSocketData );
			}
			catch ( error : Error )
			{
				__instance.dispatchMessage( new MerapiErrorMessage( MerapiErrorMessage.CONNECT_FAILURE_ERROR ) );
			}
		}
	}
	
	/**
	 *  Disconnects the Merapi Bridge. 
	 */
	public static function disconnect() : void
	{
		try 
		{
			getInstance().__client.close();
		}
		catch ( error : Error ) 
		{
			// error closing the bridge
		}
	}
	
	
    //--------------------------------------------------------------------------
    //
    //  Static variables
    //
    //--------------------------------------------------------------------------

	/**
	 *  @private
	 *  
	 *  Holds the single instance of the <code>Bridge</code>
	 */
	private static var __instance : Bridge = null;
	

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
	public function Bridge( blocker : Bridge_SingletonBlocker )
	{
		super();
		
		__handlers 		= new Dictionary();
		
		//  Try to initialize the __reader and __writer
		try
		{
			__reader 	= new READER_CLASS; 
			__writer 	= new WRITER_CLASS; 
		}
		catch( error : Error )
		{
			trace( error );
			return;
		}
		
		__respondersMap	= new Dictionary();
		
		//  Listens for the Event.CLOSING event of application and disconnect the 
		//  socket if this event is dispatched.	(Although this library does not 
		//  reference the AIR APIs directly, Event.CLOSING is only thrown by a 
		//  WindowedApplication. Alternate Application instance will not dipatch
		//  this Event and therefore will not close tidly.)
		FlexGlobals.topLevelApplication.addEventListener( CLOSING, handleApplicationClose, false, 0, true );
	}

	/**
	 *  @protected
	 * 
	 *  Reads the in the CONIFG_PATH location.
	 */
	protected static function readConfig() : void
	{
		var loader : URLLoader = new URLLoader();
			loader.addEventListener( IOErrorEvent.IO_ERROR, function( event : Event ) : void {} );
			loader.addEventListener( Event.COMPLETE, handleConfigLoadComplete );
			loader.load( new URLRequest( CONFIG_PATH ) );
	}
		
	/**
	 *  @protected
	 * 
	 *  Event handler; responds to the complete event of the config loader.
	 */
	protected static function handleConfigLoadComplete( e : Event ) : void
	{
		try
		{
			var loader 	: URLLoader = e.target as URLLoader;
			var xml 	: XML 		= new XML( loader.data as String );
				
			if ( isEmptyAttribute( xml.entry, PORT_STR ) == false )
			{
				Bridge.PORT = int( xml.entry.( @key == PORT_STR ).toString() );
			}
			
			if ( isEmptyAttribute( xml.entry, HOSTNAME ) == false )
			{
				Bridge.HOST = xml.entry.( @key == HOSTNAME ).toString();
			}
			
			if ( isEmptyAttribute( xml.entry, AUTO_CONNECT_STR ) == false )
			{
				Bridge.AUTO_CONNECT = xml.entry.( @key == AUTO_CONNECT_STR ).toString() == TRUE;
			}
			
			if ( isEmptyAttribute( xml.entry, READER ) == false )
			{
				var readerClassName : String = xml.entry.( @key == READER ).toString();
				Bridge.READER_CLASS = getDefinitionByName( readerClassName ) as Class;
			}
			
			if ( isEmptyAttribute( xml.entry, WRITER ) == false )
			{
				var writerClassName : String = xml.entry.( @key == WRITER ).toString();
				Bridge.WRITER_CLASS = getDefinitionByName( writerClassName ) as Class;
			}
		}
		catch ( error : Error ) 
		{
			trace( error ); 
		}
	}
	
	/**
	 *  @protected
	 *  
	 *  XML helper function
	 */
	protected static function isEmptyAttribute( xmlList : XMLList, key : String ) : Boolean
	{
		return xmlList.( @key == key ).toString() == EMPTY;
	}
	

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Sends a message to the java Merapi bridge.
     */	
	public function sendMessage( message : IMessage, responder : IResponder = null ) : void 
	{
		if ( Bridge.CONNECTED == false && AUTO_CONNECT == true ) 
			connect();
		
		if ( responder != null && message[ UID ] != null )
		{
			__respondersMap[ message[ UID ] ]   = responder;
		}
		
		//  Try to serialize the message using __writer. 
		try 
		{
			var bytes : ByteArray               = __writer.write( message );
		}
		
		//  If an error is caught, dispatch the MerapiErrorEvent.SERIALIZATION_ERROR event.
		catch( error : Error )
		{
			dispatchMessage( new MerapiErrorMessage( MerapiErrorMessage.SERIALIZE_ERROR, message ) );
		}
		
		//  Write the message on the socket and flush the packets.
		try 
		{
			__client.writeBytes( bytes );
			__client.flush();
		}
		
		//  If there is an error dispatch the MerapiErrorMessage.SERIALIZE_ERROR message
		catch ( error : Error )
		{
			dispatchMessage( new MerapiErrorMessage( MerapiErrorMessage.SERIALIZE_ERROR, message ) );
		}
	}

	/**
	 *  @private
	 * 
	 *  Event handler; responds to Event.CLOSING when dispatched by the application. Closes the
	 *  socket when this event has been dispatched.
	 */
	private function handleApplicationClose( e : Event ) : void
	{
		if ( Bridge.CONNECTED == true )
		{
			try
			{
				Bridge.disconnect();
			}
			catch ( error : Error )
			{
				//  Ignore any errors.. the application is closing.
			}
		}
	}

    /**
     *  @private 
     * 
     *  Event handler; Responds to IOErrorEvents from the __client socket.
     */	
	private function handleIOError( event : IOErrorEvent ) : void 
	{
		__client 				 = null;

		dispatchMessage( new MerapiErrorMessage( MerapiErrorMessage.CONNECT_FAILURE_ERROR ) ); 
	}
	
    /**
     *  @private 
     * 
     *  Event handler; Responds to data sent by the java bridge.
     */	
	private function handleReceiveSocketData( event : ProgressEvent ) : void 
	{
		//  The first byte sent by the native side of the bridge is the total
		//  packet size. This value is persisted and reset to -1 when a set 
		//  of messages have been read successfully.
		
		if ( __totalBytes == -1 )
		{
			__totalBytes 						= __client.readByte();
		}
		
		//  A buffer __byteBuffer is used to read the bytes. 
		if ( __byteBuffer == null )
		{
			__byteBuffer						= new ByteArray();
		}
		
		//  If __byteBuffer is not null, the buffer is cleared
		else
		{
			__byteBuffer.clear();
		}
		
		//  Read the bytes from the socket
		__client.readBytes( __byteBuffer, __byteBuffer.length, __client.bytesAvailable );
		
		//  If __byteBuffer.length is less than __totalBytes, that means there are more
		//  bytes to be read. (This will happen in the next frame in the case of large
		//  amounts of data sent across the bridge.)
		if ( __byteBuffer.length < __totalBytes ) return;
		
		try 
		{
			
			//  An array of 1 or more decoded messages. (Decoded by __reader)
        	var messages : Array = __reader.read( __byteBuffer ).reverse();
			
        	
        	//  A local var of the message currently being dispatched.
			var message : IMessage = messages.pop() as IMessage;
			
			//  While there are items in the array messages, dispatch the messages to
			//  registered IMessageHandlers. If any IResponders were registerd with 
			//  the call, their result methods are invoked as well.
        	while ( message != null )
        	{ 
				
        		try 
        		{
        			//  Check in __respondersMaps to see if an IResponder has been
        			//  registered for this message. (Mapped by Message.uid.) Notify
        			//  the IResponder by invoking the result method. 
	        		if ( __respondersMap[ message[ UID ] ] != null )
	        		{
	        			var responder : IResponder = 
	        				__respondersMap[ message[ UID ] ] as IResponder
	        		
	        			responder.result( message );
	        			
        				__respondersMap[ message[ UID ] ] = null;
	        		}
	        	}
	        	catch ( error : Error ) 
				{
					trace( "[Bridge] responders error", error.getStackTrace() );
				}
				
	        	
	        	//  Dispatchs the message to registered IMessageHandlers
	        	dispatchMessage( message );
				trace("[Bridge]Have dispatched the message");
        		
        		//  Get the next message in messages
            	message = messages.pop() as IMessage;
				trace("[Bridge]Have got the next message");
         	} 
         	
         	//  When all messages have been processed, reset __totalBytes to -1 
         	//  to prepare for the next packet of binary data
			__totalBytes						= -1;
			__byteBuffer						= null;
		}
		
		//  Catch any errors in deserialization.
		catch( e : Error )
		{
			trace( "[Bridge] deserialization error", e.getStackTrace() );
    		dispatchMessage( new MerapiErrorMessage( MerapiErrorMessage.DESERIALIZE_ERROR ) );
		}
	}
	
	/**
	 *  Registers an <code>IMessageHandler</code> to receive notifications when a certain 
	 *  message type is dispatched.
	 */		
	public function registerMessageHandler( type : String, handler : IMessageHandler ) : void
	{
		//  Get the list of handlers registered for the event type
		var list : Array = __handlers[ type ] as Array;
		
		//  If the list is null, create a new list to add 'handler' to
		if ( list == null )
		{
			list = [];
			__handlers[ type ] = list;
		}
		
		//  Add the handler to the list
		list.push( handler );
	}	
	
	/**
	 *  Unregisters a given handler.
	 */		
	public function unRegisterMessageHandler( type : String, handler : IMessageHandler ) : void
	{
		//  Get the list of handlers registered for the event type
		var list : Array = __handlers[ type ] as Array;
		
		//  If the list is not null and not empty, look for handler in the list and remove it
		//  if a match is found
		if ( list != null && list.length > 0 )
		{
			var activeHandler : IMessageHandler = null;
			for ( var idx : int = 0; idx < list.length; idx++ )
			{
				activeHandler = list[ idx ] as IMessageHandler;
				
				if ( activeHandler == handler )
				{
					list[ idx ] = null;
				}
			}
		}
	}
	
	/**
	 *  Dispatches an <code>IMessage</code> to registered listeners.
	 */
	public function dispatchMessage( message : IMessage ) : void
	{
		//  Get the list of handlers registered for the event type
		var list : Array = __handlers[ message.type ] as Array;
		
		//  If the list is not null and not empty notify the registered event handlers 
		if ( list != null && list.length > 0 )
		{
			for each ( var handler : IMessageHandler in list )
			{
				if ( handler != null )
				{
					handler.handleMessage( message );
				}
			}
		}
	}
	
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

	/**
	 *  @private
	 * 
	 *  The client socket that connects to the java Merapi bridge.
	 */
	private var __client 		: Socket 		= null;

	/**
	 *  @private
	 * 
	 *  The <code>IReader</code> used to deserialize data that comes across the bridge from Java.
	 */
	private var __reader 		: IReader 		= null;
	
	/**
	 *  @private
	 * 
	 *  The <code>IWriter</code> used to serialize data sent across the bridge to Java.
	 */
	private var __writer 		: IWriter 		= null;
	
	/**
	 *  @private
	 * 
	 *  A buffer used to batch up fragmented messages
	 */
	private var __byteBuffer 	: ByteArray 	= null;	

	/**
	 *  @private
	 *  
	 *  A map of responders keyed by Message uid. Used to callback
	 *  from a successful response. 
	 */
	private var __respondersMap	: Dictionary	= null;
	

	/**
	 *  @private
	 *  
	 *  The total number of bytes in the current packet being transmitted.
	 */
	private var __totalBytes    : int		 = -1;
	
	/**
	 *  @private
	 * 
	 *  A dictionary of message handlers
	 */
	 private var __handlers 	: Dictionary 	= null;
	
	
} //  end class
} //  end package


/**
 *  The <code>Bridge_SingletonBlocker</code> class is a private inner class
 *  used to block the instantiation of <code>Bridge</code> from outside of
 *  the <code>Bridge</code> class.
 */
class Bridge_SingletonBlocker {}
