//Sky Johnson ExtendEssay Code
//This file will Generate a random set of data in the form of files for each HAMING(x,y)
//then it will randomly add "error" to those data sets, 
//Then it will save them as new sets, and everything will work so much better than with arduino!
import java.io.*;
import javax.swing.JFileChooser;
import java.util.Random;
int LENGTHOFDATAFILES = 1000;
int NUMBERXOFDATAFILES = 1;
int DATACORRUPTIONSTAGS = 5;
int NUMBERYOFDATAFILES = 5; //Y VARIABLE IS THE TYPE OF ENCODING
//y = 0, is no encoding
//y = 1, is hamming(7,4)
//y = 2, is turbocode
//y = 3, is repition(3,1)
int NUMBEROFREPEATS = 5;
int currentcorruption;
int currentrep;
int currentx;
int currenty;
byte[] b = new byte[LENGTHOFDATAFILES];

File currentdata;
void setup(){
  currentcorruption = 0;
  currentrep = 0;
  currentx = 0;
  currenty = 0;
  
}
void draw(){
 
  if(dataNextFile()){
    String incoming = "";
    for(int i = 0; i < LENGTHOFDATAFILES; i++){
      incoming+=(char)b[i]+",";
    }
    //System.out.println("Curx "+currentx+" Cury "+ currenty+" "+printStringStuff(incoming,12));
    String datafilename = "data_"+currentrep+"_"+currentx+"_"+(currenty)+"_"+(currentcorruption * ((LENGTHOFDATAFILES/DATACORRUPTIONSTAGS)/4));
    //System.out.println(printStringStuff(incoming, 6));
    String incomingf[] = split(incoming,',');
    saveStrings(datafilename+".data",incomingf);
    //Convert just made code into binary for conversion
    for(int i = 0; i < incomingf.length-1; i++){
     byte temp = (byte) incomingf[i].charAt(0); 
     incomingf[i] = String.format("%8s", Integer.toBinaryString(temp & 0xFF)).replace(' ', '0');
    }
    datafilename+="_binary";
    saveStrings(datafilename+".bin",incomingf);
    //Encoding process now (Each x is going to be some verion of rep, each y is going to dictact the kind of encoding?)
    if(currenty ==0){
      //System.out.println("NO ENCODING");
    }else if(currenty == 1){
      //System.out.println("Haming(7,4)"); 
    }else if(currenty == 2){
      //System.out.println("TurboCode");
    }else if(currenty == 3){
      //System.out.println("Repition(3,1)"); 
    }
    //Error inducing process now
    //System.out.println(currentcorruption*((LENGTHOFDATAFILES/DATACORRUPTIONSTAGS)/4));
    int bitstoflip = LENGTHOFDATAFILES;//currentcorruption*((LENGTHOFDATAFILES/DATACORRUPTIONSTAGS)/4);
    while(bitstoflip != 0){
      
      int i =(int) random((float)LENGTHOFDATAFILES);
      int k =(int) random((float)(incomingf[i].length()));
      
      StringBuilder temp = new StringBuilder(incomingf[i]);
      //System.out.println(incomingf[i]);
      if(temp.charAt(k) == '1'){
        temp.setCharAt(k,'0');
      }else{
        temp.setCharAt(k,'1');
      }
      incomingf[i] = temp.toString();
      //System.out.println(incomingf[i]);
      bitstoflip--;
    }
    saveStrings(datafilename+".cor",incomingf);
    //Decoding process now (Dependant on the encoding?)
    
    //Comparison Values
  }else{
    exit();
  }
}
boolean dataNextFile(){
  if(currentcorruption<DATACORRUPTIONSTAGS){
    if(currentrep<NUMBEROFREPEATS){
      if(currentx<NUMBERXOFDATAFILES){
        if(currenty<NUMBERYOFDATAFILES){
          
          for(int i = 0; i < LENGTHOFDATAFILES; i++){
            b[i] = (byte)random(97,122);
          }
          
          currenty++;
          return true;
        }
           currentx++;
           currenty = 0;
           return true;
      }
       currenty = 0;
       currentx = 0;
       currentrep++;
       return true;
      
    }
    currenty = 0;
    currentx = 0;
    currentrep = 0;
    currentcorruption++;
    return true;
  }
  System.out.println("Finished Gen");
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
 String printLineArray(String[] indata, int a){ //returns a string of an array
   String k = "";
   for(int i = 0; i < a; i++){
    k += " \t" + indata[i]; 
   }
   return k;
 }