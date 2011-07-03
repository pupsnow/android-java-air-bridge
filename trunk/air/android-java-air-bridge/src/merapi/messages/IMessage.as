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

package merapi.messages
{

[Bindable]
/**
 *  The <code>IMessage</code> interface describes a 'message' sent by the Merapi bridge.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.handlers.MessageHandler;
 *  @see merapi.messages.Message;
 */
public interface IMessage
{

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  type
    //----------------------------------

    /**
     *  The message type.
     */		
	function get type() : String;
	function set type( val : String ) : void;

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  A generic data property.
     */		
	function get data() : Object;
	function set data( val : Object ) : void;

		
} //  end interface
} //  end package