//Sky Johnson ExtendEssay Code
//This file will Generate a random set of data in the form of files for each HAMING(x,y)
//then it will randomly add "error" to those data sets, 
//Then it will save them as new sets, and everything will work so much better than with arduino!
import java.io.*;
import javax.swing.JFileChooser;
import java.util.Random;
int LENGTHOFDATAFILES = 1000;
int NUMBERXOFDATAFILES = 5;
int NUMBERYOFDATAFILES = 5;
int currentx;
int currenty;
byte[] b = new byte[LENGTHOFDATAFILES];

File currentdata;
void setup(){
  currentx = 0;
  currenty = 0;
  
}
void draw(){
 
  if(dataNextFile()){
    String incoming = "";
    
    for(int i = 0; i < LENGTHOFDATAFILES; i++){
      incoming+=(char)b[i]+",";
    }
    System.out.println(printStringStuff(incoming,12));
  }
}
boolean dataNextFile(){
  
  if(currentx<NUMBERXOFDATAFILES){
    if(currenty<NUMBERYOFDATAFILES){
      for(int i = 0; i < LENGTHOFDATAFILES; i++){
        b[i] = (byte)random(97,122);
      }
      System.out.println(printLineArray(b,6));
      currenty++;
      return true;
    }else{
       currentx++;
       currenty = 0;
       return false;
    }
  }
  return false;
}

String printLineArray(byte[] indata){ //returns a string of an array
   String k = "";
   for(int i = 0; i < indata.length; i++){
    k += " \t" + indata[i]; 
   }
   return k;
 }
 String printStringStuff(String indata, int a){
   String k = "";
   for(int i = 0; i < a; i+=2){
    k += " \t" + indata.substring(i,i+1); 
   }
   return k;
 }
 String printLineArray(byte[] indata, int a){ //returns a string of an array
   String k = "";
   for(int i = 0; i < a; i++){
    k += " \t" + indata[i]; 
   }
   return k;
 }