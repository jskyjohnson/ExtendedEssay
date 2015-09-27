//Arduino, Transmitter code, Yay!
// by Sky Johnson

/* This program was created by ScottC on 8/5/2012 to receive serial 
signals from a computer to turn on/off 1-9 LEDs */
#include <VirtualWire.h>
void setup() { 
 // initialize the digital pins as an output.
 pinMode(2, OUTPUT);
 pinMode(3, OUTPUT);
 pinMode(4, OUTPUT);
 pinMode(5, OUTPUT);
 pinMode(6, OUTPUT);
 pinMode(7, OUTPUT);
 pinMode(8, OUTPUT);
 pinMode(9, OUTPUT);
 pinMode(10, OUTPUT);
// Turn the Serial Protocol ON
 Serial.begin(9600);
 vw_setup(2000);
}

void loop() {
 byte byteRead;

 /* check if data has been sent from the computer: */
 if (Serial.available()) {
 
 /* read the most recent byte */
   byteRead = Serial.read();
 //You have to subtract '0' from the read Byte to convert from text to a number.
   byteRead=byteRead - '0';
 
 //Turn off all LEDs if the byte Read = 0
   if(byteRead==0){  
     //Turn off all LEDS
     digitalWrite(2, LOW);
     digitalWrite(3, LOW);
     digitalWrite(4, LOW);
     digitalWrite(5, LOW);
     digitalWrite(6, LOW);
     digitalWrite(7, LOW);
     digitalWrite(8, LOW);
     digitalWrite(9, LOW);
     digitalWrite(10, LOW);
   }
 
 //Turn LED ON depending on the byte Read.
    if(byteRead!=0){
       Serial.println(byteRead);
       send("hellolllofon");
       digitalWrite((byteRead), HIGH); // set the LED on
     }
   }
 }
 
void send (char *message){
  Serial.println(*message);
  vw_send((uint8_t *)message, strlen(message));
  vw_wait_tx(); // Wait until the whole message is gone
}
