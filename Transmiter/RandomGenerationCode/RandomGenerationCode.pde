import java.util.Random;

int LENGTH = 1000;
System.out.println("GENERATING");
byte[] b = new byte[LENGTH];
new Random().nextBytes(b);
String words = "";
for(int i = 0; i < LENGTH; i++){
  char k = (char) b[i];
  words+=k;
}
String[] list = split(words, ' ');

// Writes the strings to a file, each on a separate line
System.out.println("DONE");
saveStrings("data", list);

noLoop();
exit();