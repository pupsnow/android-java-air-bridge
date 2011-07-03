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

package merapi.io.reader
{

import flash.utils.ByteArray;


/**
 *  The <code>IReader</code> interface describes a class for reading binary data from the Merapi
 *  bridge.
 * 
 *  @see merapi.Bridge
 *  @see merapi.io.AMF3Reader
 *  @see merapi.messages.IMessage
 */
public interface IReader
{

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Deserializes the binary data <code>bytes</code> and returns a the data as a
     *  set of <code>IMessage</code> instances.
     */	
	function read( bytes : ByteArray ) : Array;
	

} // end interface
} // end package
