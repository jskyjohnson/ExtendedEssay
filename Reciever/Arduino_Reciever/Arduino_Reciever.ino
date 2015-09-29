
/*
SimpleReceive
This sketch displays text strings received using VirtualWire
Connect the Receiver data pin to Arduino pin 11
*/
#include <VirtualWire.h>
byte message[VW_MAX_MESSAGE_LEN]; // a buffer to store the incoming messages
byte messageLength = VW_MAX_MESSAGE_LEN; // the size of the message
int currentdatafile;
int maxdatafile = 10;
String currentin = "";
void setup()
{
  currentdatafile = 0;
Serial.begin(9600);
// Initialize the IO and ISR
vw_setup(2000); // Bits per sec
vw_rx_start(); // Start the receiver
}
int serialcounter = 0;
void loop()
{
  if (vw_get_message(message, &messageLength)) // Non-blocking
  {
    for(int i = 0; i < messageLength; i++){
     char inc = message[i];
     Serial.write(inc); 
    }
  }
}  
