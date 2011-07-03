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

package merapi.error
{
import flash.utils.Dictionary;

import merapi.messages.IMessage;
import merapi.messages.Message;

/**
 *  The <code>MerapiErrorMessage</code> class is a sub class of <code>Message</code>
 *  that is used to communicate error messages from the <code>Bridge</code>. 
 * 
 *  @see merapi.Bridge
 *  @see merapi.handlers.mxml.CoreErrorHandler
 *  @see merapi.handlers.IMessageHandler
 *  @see merapi.handlers.MessageHandler
 *  @see merapi.messages.Message
 *  @see merapi.messages.IMessage
 */
public class MerapiErrorMessage extends Message
{
    
    //--------------------------------------------------------------------------
    //
    //  Constants
    //
    //--------------------------------------------------------------------------

    /**
     *  Event type for a serialization error.
     */
    public static const SERIALIZE_ERROR       : String 		= "serializeError";
     
    /**
     *  Event type for a deserialization error.
     */
    public static const DESERIALIZE_ERROR     : String 		= "deserializeError";
     
    /**
     *  Event type for a connect failure error.
     */
    public static const CONNECT_FAILURE_ERROR : String 		= "connectFailureError";
    
    /**
     *  Event type for an initialization error.
     */
    public static const INITIALIZATION_ERROR  : String 		= "initializationError";
    
    /**
     *  @private
     * 
     *  A map of event types -> error messages
     */
	private static const ERROR_MESAGES        : Dictionary  = new Dictionary();

	{
		 ERROR_MESAGES[ SERIALIZE_ERROR ]                   = "Merapi falied to serialize a "+
                                                              "message object using the "+
                                                              "specified IWriter class."
		 ERROR_MESAGES[ DESERIALIZE_ERROR ]                 = "Merapi falied to deserialize "+
                                                              "message data the specified "+
                                                              "IReader class."
		 ERROR_MESAGES[ CONNECT_FAILURE_ERROR ]             = "Merapi falied to connect to "+
                                                              "the java side of the bridge.";
		 ERROR_MESAGES[ INITIALIZATION_ERROR ]              = "Merapi falied to initialize the "+
                                                              "specified IWriter or IReader.";
	}
     		
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function MerapiErrorMessage( type : String = null, message : IMessage = null ) : void
	{
		super( type );

		this.message		= message;
	}
	
	
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  message
    //----------------------------------

    /**
     *  The message that failed to be seriliazed, in the case of a SERIALIZE_ERROR or
     *  DESERIALIZE_ERROR.
     */		
	public var message : IMessage = null;
	
    //----------------------------------
    //  type
    //----------------------------------

	/**
	 *  @override
	 *  
	 *  Updates the value of <code>data</code> with the matching error message based
	 *  on the message type.
	 */
	override public function set type( val : String ) : void
	{
		super.type   = val;
		data         = ERROR_MESAGES[ type ].toString();
	}
	
} //  end clas
} //  end package