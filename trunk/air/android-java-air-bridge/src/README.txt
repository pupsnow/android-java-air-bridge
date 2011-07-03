The merapi project can be found here http://code.google.com/p/merapi/.

03/07/2011 Minor changes made to the current project

merapi.Bridge 
	Uses mx.core.FlexGlobals and not mx.core.Application.
	Line 457 clears the byteBuffer rather than setting its position to 0
	
merapi.io.amf.AMFReader
	Removes unnecessary super() in the constructor
				