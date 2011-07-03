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
	
import flash.events.EventDispatcher;

import merapi.Bridge;
import merapi.handlers.IMessageHandler;
import merapi.messages.IMessage;
import merapi.messages.Message;

import mx.rpc.events.ResultEvent;

//--------------------------------------
//  Events
//--------------------------------------

/**
 *  The result of the event being listned for.
 *
 *  @type mx.rpc.events.ResultEvent.RESULT
 */
[Event(name="result", type="mx.rpc.events.ResultEvent")]	
	
[Bindable]
/**
 *  <code>MessageHandler</code> is a Flex-centric implementation of IMessageHandler to enable 
 *  features like binding and the Flex event model.
 * 
 *  The <code>MessageListener</code> class listens for and responds to a given Merapi Message
 *  type (or types). The last message to be returned is stored in the <code>lastMessage</code>
 *  property and it's data value is stored in the <code>data</code> property. <code>dataField</code>
 *  can be used to dynamically set what property from the Message to use to assign the
 *  value of <code>data</data>. The default value for <code>dataField</code> is "data". 
 * 
 *  The MessageListener class is intended for declaration in MXML. 
 * 
 *  @see merapi.messages.IMessage;
 *  @see merapi.messages.Message;
 *  @see merapi.handlers.IMessageHandler;
 *  @see merapi.handlers.MessageHandler;
 */
public class MessageHandler extends EventDispatcher implements IMessageHandler
{
    //--------------------------------------------------------------------------
    //
    //  Static Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  bridge
    //----------------------------------

	private static var bridge : Bridge = Bridge.getInstance();
	
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */
	public function MessageHandler( type : String = null )
	{
		this.type = type;
		super();
	}


    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------
    
    /**
     *  The last message recieved by this MessageListener instance
     */
	public var lastMessage : IMessage = null;
	
    /**
     *  The last data value that was part of the last Merapi Message
     */
	public var data : Object = null;

    /**
     *  The name of the property from the last message to use as the setter
     *  for the value of <code>data</code>
     */
	public var dataField : String = "data";

	/**
	 *  The message type to listen for
	 */
	public function get type() : String { return __type; }
	public function set type( type : String ) : void
	{
		if ( __type != null )
		{
			bridge.unRegisterMessageHandler( __type, this );
		}
		
		__type = type;
		
		if ( __type != null )
		{
			bridge.registerMessageHandler( __type, this );
		}
	}

	/**
	 *  The message types to listen for
	 */
	public function get types() : Object { return __types; }
	public function set types( types : Object ) : void
	{
		var type : String = null;
		
		if ( __types != null )
		{
			for each ( type in __types )
			{
				bridge.unRegisterMessageHandler( type, this );
			}
		}
		
		if ( types is Array )
		{
			__types = types as Array;
		}
		else if ( types is String )
		{
			__types = ( types as String ).split( "," )
		}
		
		if ( __types != null )
		{
			for each ( type in __types )
			{
				bridge.registerMessageHandler( type, this );
			}
		}
	}
	
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    
    /**
     *  Event handler; reponds to the ResultEvent for the Message type registered
     *  in the <code>type</code> property.
     */
	public function handleMessage( message : IMessage ) : void
	{
		dispatchEvent( new ResultEvent( ResultEvent.RESULT, false, true, message ) );
		dispatchEvent( new ResultEvent( message.type, false, true, message ) );
		
		if ( message is Message )	lastMessage = message as Message;
		else						lastMessage = message;

		try 
		{
			if ( dataField.indexOf( "." ) == -1 )
			{
				data = lastMessage[ dataField ];
			}
			else
			{
				var df : String = null;
				var ref : Object = lastMessage;
				var fields : Array = dataField.split( "." );
				for each ( df in fields )
				{
					ref = ref[ df ];
				}
				data = ref;
			}		
		}
		catch( e : Error ) {}			
	}
	
	
    //--------------------------------------------------------------------------
    //
    //  Variables
    //
    //--------------------------------------------------------------------------
    	
	private var __type  : String = null;
	private var __types : Array  = null;
	
} //  end class
} //  end package