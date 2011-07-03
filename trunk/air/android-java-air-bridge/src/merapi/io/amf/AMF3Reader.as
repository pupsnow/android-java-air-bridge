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

package merapi.io.amf
{

import flash.utils.ByteArray;

import merapi.io.reader.IReader;


/**
 *  The <code>AMF3Reader</code> class deserializes AMF 3 encoded binary data into an 
 *  <code>IMessage</code>. 
 * 
 *  @see merapi.io.reader.IReader;
 */
public class AMF3Reader implements IReader
{
   
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function AMF3Reader()
	{
	}
	

	//--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Reads binary data serialized using the as AMF 3 protocol and deserializes 
     *  it into a set of <code>IMessage</code> instances.
     */		
	public function read( bytes : ByteArray ) : Array
	{
		var message  : Object = bytes.readObject();
		var messages : Array  = [];
		
		while ( message != null )
		{
			messages.push( message );
			try 
			{
				message = bytes.readObject();
			}
			catch ( error : Error )
			{
				message = null;
				return messages;
			}
		}
		
		return messages;
	}

} // end class
} // end package