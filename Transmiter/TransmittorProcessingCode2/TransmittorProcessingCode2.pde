//Processing, Actual Tranmittor readingin code
//Written by Sky Johnson

import processing.serial.*;
import java.io.*;
import javax.swing.JFileChooser;
import java.util.Random;
int index = 0;
int LENGTH = 10;
int datafiles = 10;
int currentdatafile;
boolean canSend;
byte[] b = new byte[LENGTH];
ArrayList<String> subtext;

File indata;
Serial outPort;
Serial inPort;

void setup(){
 subtext = new ArrayList<String>();
 canSend = true;
 for(int i = 0; i < LENGTH+6; i++){
  subtext.add(""); 
 }
 //System.out.println(subtext);
 //indata = new File("C:\\Users\\Development 101\\Documents\\github\\ExtendedEssay\\Transmiter\\TransmitterProcessingCode\\tempData1");
 //JFileChooser chooser = new JFileChooser();
 //int returnValue = chooser.showOpenDialog(null);
 //if(returnValue == JFileChooser.APPROVE_OPTION){
 //System.out.println(chooser.getSelectedFile());
 //indata = chooser.getSelectedFile();
 //}
 currentdatafile = 0;
 nextDataFile();
 inPort = new Serial(this, "COM6", 9600); //RECIEVER
 outPort = new Serial(this, "COM5", 9600);//TRANSMITTER COM
 outPort.bufferUntil('\n');
}

void draw(){
 if(!canSend && index<subtext.size()){
   outPort.write(subtext.get(index));
 }else if(index<subtext.size() && canSend){
  //System.out.println(subtext.get(index));
  canSend = false;
  System.out.println("out "+index+" "+subtext.get(index));
  outPort.write(subtext.get(index));
  index++;
 }else if(nextDataFile() && ! (index<subtext.size())){
  index = 0;
 }else{
   
 }
 if(inPort.available() > 0){
   canSend = true;
   System.out.println("in "+index+" "+inPort.readString());
 }
}
boolean nextDataFile(){
  if(currentdatafile < datafiles){
    new Random().nextBytes(b);
    String words = "";
    for(int i = 0; i < LENGTH; i++){
     char k = (char) b[i];
     words+=k;
    }
    words += "AAAAAA"; //Random checker variables if finds 3 A's in a row, will start next data line in reciever
    String[] list = split(words,' ');
    //System.out.println(currentdatafile+" "+printLineArray(list));
    for(int i = 0; i < words.length(); i++){
     // String indeString = 
     subtext.set(i, words.substring(i,i+1)); 
    }
    
    String datafilename = "data_"+currentdatafile;
    saveStrings(datafilename, list);
    String fileString = "E:\\GitHub\\ExtendedEssay\\Transmiter\\TransmittorProcessingCode2\\"+datafilename;
    indata = new File(fileString);
    currentdatafile++;
    return true;
  }
  return false;
}

String printLineArray(String[] indata){ //returns a string of an array
   String k = "";
   for(int i = 0; i < indata.length; i++){
    k += " \t" + indata[i]; 
   }
   return k;
  }