//Arduino, Transmitter code, Yay!
// by Sky Johnson

/* This program was created by ScottC on 8/5/2012 to receive serial 
signals from a computer to turn on/off 1-9 LEDs */
#include <VirtualWire.h>
void setup() { 
 pinMode(6, OUTPUT);
 pinMode(7, OUTPUT);
// Turn the Serial Protocol ON
 Serial.begin(9600);
 vw_setup(2000);
}
char charer[1];
void loop() {
 /* check if data has been sent from the computer: */
  
  if(Serial.available()){ 
    char k[1];
     k[0] = Serial.read();
    Serial.println(k[0]);
    send(k);
    digitalWrite(6, HIGH);
    digitalWrite(7, LOW);
  }else{
    digitalWrite(7, HIGH);
    digitalWrite(6, LOW);
  }
}
void send (char *message){
  //Serial.println(*message);
  vw_send((uint8_t *)message, strlen(message));
  vw_wait_tx(); // Wait until the whole message is gone
}
