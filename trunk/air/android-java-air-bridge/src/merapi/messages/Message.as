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

import merapi.Bridge;

import mx.rpc.IResponder;
import mx.utils.UIDUtil;
	

[Bindable]
[RemoteClass( alias="merapi.messages.Message" )]
/**
 *  The <code>Message</code> class implements IMessage, a 'message' sent from the Merapi 
 *  UI layer.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.messages.IMessage;
 */
public class Message implements IMessage
{
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function Message( type : String = null, data : Object = null ) : void
	{
		super();
		
		this.type   = type;
		this.data   = data;
		this.uid    = UIDUtil.createUID();
	}
	
	
    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  uid
    //----------------------------------

    /**
     *  A unique ID for the message.
     */		
	public var uid	 				: String			= null;

    //----------------------------------
    //  type
    //----------------------------------

    /**
     *  The type of the message.
     */		
	public function get type() 		: String 			{ return __type };
	public function set type( val 	: String ) : void 	{ __type = val; };

    //----------------------------------
    //  data
    //----------------------------------

    /**
     *  The data carried by this message.
     */		
	public function get data() 		: Object 			{ return __data };
	public function set data( val 	: Object ) : void 	{ __data = val };
	

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
	
	/**
	 *  Redirects toString to the data property
	 */
	public function toString() : String
	{
		return data.toString();
	}
	
	/**
	 *  Sends the event across the Merapi bridge.
	 */
	public function send( responder : IResponder = null ) : void
	{
		Bridge.getInstance().sendMessage( this, responder );
	}


    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------

    /**
     *  Used by the getters/setters.
     */	
	private var __type		 		: String			= null;
	private var __data 				: Object			= null;
	
		
} //  end class
} //  end package