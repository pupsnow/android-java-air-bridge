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

package merapi.handlers
{

import merapi.Bridge;
import merapi.messages.IMessage;


/**
 *  The <code>IEventHandler</code> interface defines the methods for receiving a 
 *  <code>Message</code> from the Bridge.
 * 
 *  @see merapi.Bridge
 *  @see merapi.handlers.IMessageHandler
 *  @see merapi.messages.IMessage
 *  @see merapi.messages.Message
 */
public class MessageHandler implements IMessageHandler 
{
    //--------------------------------------------------------------------------
    //
    //  Constructors
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Automatically registers the handler for message type <code>type</code>.
	 *  
	 *  @param type The type of message to handle.
	 */
	public function MessageHandler( type : String = null ) : void
	{
		if ( type != null )
		{
			addMessageType( type );
		}
	}
	
	
	//--------------------------------------------------------------------------
	//
	//  Methods
	//
	//--------------------------------------------------------------------------
	
	/**
	 *  Handles an <code>IMessage</code> dispatched from the Bridge. This method should
	 *  be overridden by MessageHandler sub class definitions.
	 */
	public function handleMessage( message : IMessage ) : void {}

	/**
	 *  Adds another message type to be listend for by this instance of MessageHandler.
	 */
	public function addMessageType( type : String ) : void
	{
		Bridge.getInstance().registerMessageHandler( type, this );
	}
	
	/**
	 *  Removes the handling of message type <code>type</code>.
	 */
	public function removeMessageType( type : String ) : void
	{
		Bridge.getInstance().unRegisterMessageHandler( type, this );
	}
	
} //  end class
} //  end package