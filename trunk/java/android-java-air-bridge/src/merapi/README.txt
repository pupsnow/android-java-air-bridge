This package contains classes from the merapi project with changes as described below.

All references to org.apache.log4j.Logger and org.springframework.context.ApplicationContext have been removed.

merapi.Bridge
The code has been refactored so that it no longer uses external configuration
A new thread has been created for writing to the socket connection - using the main thread for this is not supported on Android 3.0.
The sendMessage has been refactored to delegate to the BridgeWriterThread


merapi.BridgeWriterThread 
New class - created in a similar pattern to the existing merapi.BridgeListenerThread

config
Removed this directory

merapi.io.amf.AMF3Reader
Creates a new instance of AMF3Deserializer for each read.


merapi.io.amf.AMFWriter
Creates a new instance of AMF3Serializer for each write.
