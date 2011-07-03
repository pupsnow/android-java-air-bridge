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

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;

import merapi.io.reader.IReader;
import merapi.messages.IMessage;
import merapi.messages.Message;


import com.exadel.flamingo.flex.messaging.amf.io.AMF3Deserializer;

import flex.messaging.io.ASObject;


/**
 * The <code>AMF3Reader</code> class deserializes AMF 3 encoded binary data into an
 * <code>IMessage</code>. When a message has been received from the Flex bridge.
 *
 * @see merapi.io.reader.IReader;
 */
public class AMF3Reader implements IReader {

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    /**
     * Constructor.
     */
    public AMF3Reader() {
    }


  
    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     * @return Reads the binary data <code>bytes</code> and deserializes it into an
     *         <code>IMessage</code>.
     */
    public ArrayList<IMessage> read(byte[] bytes) throws ClassNotFoundException, IOException 
    
    {
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
    	
    	AMF3Deserializer amf3input = new AMF3Deserializer( byteArrayInputStream  );        

        Object decoded = amf3input.readObject();
        
        IMessage message = null;
        
        ArrayList<IMessage> al = new ArrayList<IMessage>();
        
        while (decoded != null) 
        {
            if (decoded instanceof IMessage) 
            {
                message = (IMessage) decoded;
            } 
            else if (decoded instanceof ASObject) 
            {
                ASObject aso = (ASObject) decoded;

                Message m = new Message();
                m.setType(aso.get("type").toString());
                m.setUid(aso.get("uid").toString());
                m.setData(aso.get("data"));

                message = m;
            }

            al.add(message);

            try {
                decoded = amf3input.readObject();
            }
            catch (Exception e) {
                decoded = null;
                //__logger.error(e.getMessage());
            }
        }

        return al;
    }

}
