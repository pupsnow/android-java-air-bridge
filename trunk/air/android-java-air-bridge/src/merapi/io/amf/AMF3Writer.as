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

import merapi.io.writer.IWriter;
import merapi.messages.IMessage;

import mx.utils.ObjectUtil;
	


/**
 *  The <code>AMF3Reader</code> class serializes an IMessage into AMF 3 encoded  
 *  binary data.  
 * 
 *  @see merapi.io.reader.IWriter;
 */
public class AMF3Writer implements IWriter
{
   
    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     *  Constructor.
     */		
	public function AMF3Writer()
	{
		super();
	}
	

	//--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     *  Serializes <code>message</code> using <code>flash.utils.ByteArray</code> and
     *  returns the binary data.
     */		
	public function write( message : IMessage ) : ByteArray
	{
		var bytes : ByteArray = new ByteArray();
		bytes.writeObject( message );
		
		return bytes;
	}

} // end class
} // end package
