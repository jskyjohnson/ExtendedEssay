//Processing, Actual Tranmittor readingin code
//Written by Sky Johnson

import processing.serial.*;
import java.io.*;
import javax.swing.JFileChooser;
boolean gloswitch;
int index = 0;
ArrayList<String> subtext;
File indata;
Serial outPort;

void setup(){
 gloswitch = true;
 subtext = new ArrayList<String>();
 //indata = new File("C:\\Users\\Development 101\\Documents\\github\\ExtendedEssay\\Transmiter\\TransmitterProcessingCode\\tempData1");
 JFileChooser chooser = new JFileChooser();
 int returnValue = chooser.showOpenDialog(null);
 if(returnValue == JFileChooser.APPROVE_OPTION){
 System.out.println(chooser.getSelectedFile());
 indata = chooser.getSelectedFile();
 }
 outPort = new Serial(this, "COM6", 9600);
 outPort.bufferUntil('\n');
}

void draw(){
 if(gloswitch){
   System.out.println("Data in");
   loadData(indata);
   gloswitch = false;
 }
 if(index<subtext.size()){
  System.out.println(subtext.get(index));
  outPort.write(subtext.get(index));
  index++;
 }else{
  //gloswitch = false;
  //index = 0;
 }
}

void loadData(File infile){
  File file = infile;
  BufferedReader br = null;
  try{
    br = new BufferedReader(new FileReader(file));
    String text = null;
    while((text = br.readLine())!=null){
      System.out.println(text);
      for(int i = 0; i < text.length(); i++){
        subtext.add(text.substring(i,i+1));
      }
    }
  }catch(FileNotFoundException e){
   e.printStackTrace();
  }catch(IOException e){
   e.printStackTrace();
  }finally{
   try{
     if(br != null){
      br.close(); 
     }
   }catch(IOException e){
    e.printStackTrace(); 
   }
  }
}