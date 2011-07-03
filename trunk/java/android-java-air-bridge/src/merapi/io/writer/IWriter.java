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

package merapi.io.writer;

import merapi.messages.IMessage;

/**
 *  The <code>IWriter</code> interface describes a class for reading binary data from 
 *  the Merapi bridge.
 * 
 *  @see merapi.Bridge;
 *  @see merapi.io.AMF3Writer;
 */
public interface IWriter {

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Serializes the <code>message</code> and returns a the data as an Array of bytes.
     */	
	byte[] write( IMessage message ) throws Exception;
	
}
