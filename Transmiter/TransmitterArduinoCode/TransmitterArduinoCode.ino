//Arduino, Transmitter code, Yay!
// by Sky Johnson

#include <VirtualWire.h>
void setup() { 
 pinMode(6, OUTPUT);
 pinMode(7, OUTPUT);
 Serial.begin(9600);
 Serial.println("This is the Transmitter");
 vw_setup(2000);
}
char charer[1];
void loop() {

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
