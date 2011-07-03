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

package merapi.handlers.mxml
{
	
import merapi.error.MerapiErrorMessage;

import mx.rpc.events.ResultEvent;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  The result of the event being listned for.
 *
 *  @type mx.rpc.events.ResultEvent.RESULT
 */
[Event( name="result", type="mx.rpc.events.ResultEvent" )]	

/**
 *  A result event that signals a connectFailureError
 *
 *  @type merapi.error.MerapiErrorMessage.CONNECT_FAILURE_ERROR
 */
[Event( name="connectFailureError", type="mx.rpc.events.ResultEvent" )]	

/**
 *  A result event that signals a deserializeError
 *
 *  @type merapi.error.MerapiErrorMessage.DESERIALIZE_ERROR
 */
[Event( name="deserializeError", type="mx.rpc.events.ResultEvent" )]	

/**
 *  A result event that signals a serializeError
 *
 *  @type merapi.error.MerapiErrorMessage.SERIALIZE_ERROR
 */
[Event( name="serializeError", type="mx.rpc.events.ResultEvent" )]	

	
[Bindable]
/**
 *  <code>CoreErrorHandler</code> is a Flex-centric implementation of IMessageHandler that 
 *  reports the core Merapi error messages.
 * 
 *  The CoreErrorHandler class is intended for declaration in MXML. 
 * 
 *  @see merapi.messages.IMessage;
 *  @see merapi.messages.Message;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.handlers.MessageHandler;
 *  @see merapi.handlers.mxml.MessageHandler;
 */
public class CoreErrorHandler extends MessageHandler
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */	
	public function CoreErrorHandler( type : String = null )
	{
		super( type );
		
		super.types = [ MerapiErrorMessage.CONNECT_FAILURE_ERROR, 
					 	MerapiErrorMessage.DESERIALIZE_ERROR,
					    MerapiErrorMessage.SERIALIZE_ERROR ];
	}
	
	
} //  end class
} //  end package

