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

package merapi.io.writer
{

import flash.utils.ByteArray;

import merapi.messages.IMessage;


/**
 *  The <code>IWriter</code> interface describes a class for reading binary data sent 
 *  from the Merapi bridge.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.io.AMF3Writer;
 */
public interface IWriter
{
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Serializes the <code>message</code> and returns the data as a ByteArray.
     */	
	function write( data : IMessage ) : ByteArray;
	
} // end interface
} // end package
