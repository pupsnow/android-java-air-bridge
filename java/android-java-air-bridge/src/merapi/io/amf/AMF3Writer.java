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

package merapi.io.amf;

import merapi.io.writer.IWriter;
import merapi.messages.IMessage;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

import com.exadel.flamingo.flex.messaging.amf.io.AMF3Serializer;


/**
 * The <code>AMF3Reader</code> class deserializes AMF 3 encoded binary data into an Object.
 * When a message has been received from the Flex bridge.
 *
 * @see merapi.io.reader.IReader;
 */
public class AMF3Writer implements IWriter {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------
    /**
     * Constructor.
     */
    public AMF3Writer() 
    {
    }


    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------
    /**
     * Serializes <code>message</code> using 
     * <code>com.exadel.flamingo.flex.messaging.amf.io.AMF3Serializer</code>.
     */
    public byte[] write(IMessage message) throws IOException 
    {
    	ByteArrayOutputStream bas = new ByteArrayOutputStream();

    	AMF3Serializer amf3output = new AMF3Serializer( bas );
        amf3output.writeObject( message );
        amf3output.flush();
        
        return bas.toByteArray();
	}

}
