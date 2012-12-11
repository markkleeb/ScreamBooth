import processing.serial.*;
import httprocessing.*;
import gifAnimation.*;
import processing.video.*;
import org.seltar.Bytes2Web.*;
                    
                    
//String postsite = "http://screambooth.herokuapp.com/photos/add";
String postsite = "http://127.0.0.1:5000/photos/add";
String inString;                    
          
PFont font;

                   
Serial myPort; 
GifMaker gifExport;
Capture video;
int globalframecount = 0;
int countdowntimer = 10;
int imageName = 0;
int x = 100;  // x- position text
int y = height-50; // y- position text
long timestamp;
int lf = 10;
int meter;


boolean micInput = false;

float a = (0);
float b = (255);
float changea = 2.5;
float changeb = -2.5;

void setup() {
  size(1600, 900, P2D);
  background(0);
  font = createFont("Creepster-Regular.ttf", 100);
  textFont(font, 60);
  String[] cameras = Capture.list();
  rectMode(CENTER);
  video = new Capture(this, cameras[0]);
  video.start();
  
     //meter = 0;
  
  myPort = new Serial(this, Serial.list()[0], 115200);
  println(Serial.list());
  myPort.bufferUntil(lf); 
 
}
void captureEvent(Capture myCapture) {
  video.read();
  //fs.enter();
}

void draw() {
  background(0);
  rectMode(CENTER);
  noStroke();
  textAlign(CENTER);
  textSize(100);
  image (video, 200,0);
   

   
  pushStyle();
  fill(0);
  rectMode(CORNER);
  rect(0, 875, width, height);
  //fill(255, 0, 0);
  //rect(0, 875, meter, height);
  fill(255, 83, 53);
  text("ITP HALLOWEEN PARTY 2012", width/2, height-82);
  popStyle();
  
 
  
  if (globalframecount == 0) {
     PImage bck = loadImage("bkgd.jpg");
  image(bck, 200, 0);
   // fill(0);
  //  rect(640, 480, width*2, height*2);
    fill(255, 83, 53);
    text("SCREAM!", width/2, height/2);
    myPort.write('1');
  }
  if (globalframecount < 1100 && globalframecount > 0 ) {
    if (globalframecount == 40) {
      Date d = new Date();
      timestamp = d.getTime();

      gifExport = new GifMaker(this, "images/" + timestamp + ".gif");
      gifExport.setQuality(10 );
      //gifExport.setSize(640,480);
      gifExport.setRepeat(0);
    }
    
    if (globalframecount > 0 && globalframecount < 50) {
     fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 350, 150); 
      fill(255);
      text("SCREAM!", width/2, height/2);
     
    }
    if (globalframecount == 51) {
       fill(255);
      rect(640, 480, width*2, height*2);
    }

    if (globalframecount == 52) {
      saveFrame("img1.jpg");
      PImage img1 = loadImage("img1.jpg");
      img1.resize(640,480);
      gifExport.setDelay(300);
      gifExport.addFrame(img1);
    }
    if (globalframecount > 60 && globalframecount < 110) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 350, 150); 
      fill(255);
      text("SCREAM!", width/2, height/2);
    }
    if (globalframecount == 111) {
       fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 112) {
      saveFrame("img2.jpg");
      PImage img2 = loadImage("img2.jpg");
      img2.resize(640,480);
      gifExport.setDelay(300);
      gifExport.addFrame(img2);
    }
 
    if (globalframecount > 120 && globalframecount < 170) {
        fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 350, 150); 
      fill(255);
      text("SCREAM!", width/2, height/2);
    }
    if (globalframecount == 171) {
       fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 172) {
     saveFrame("img3.jpg");
      PImage img3 = loadImage("img3.jpg");
      img3.resize(640,480);
      gifExport.setDelay(300);
      gifExport.addFrame(img3);
    }
   
    if (globalframecount > 180 && globalframecount < 230) {
        fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 350, 150); 
      fill(255);
      text("SCREAM!", width/2, height/2);
    }
   
    if (globalframecount == 231) {
      fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 232) {
      saveFrame("img4.jpg");
      PImage img4 = loadImage("img4.jpg");
      img4.resize(640,480);
      gifExport.setDelay(300);
      gifExport.addFrame(img4);
    }
    if (globalframecount == 233) {
      gifExport.finish();
    }
    globalframecount++;
    if (globalframecount == 234) {
      postData();
      globalframecount = 0;
      micInput = false;
    }
  }
 // println(globalframecount);
}


void serialEvent(Serial myPort){

  inString = myPort.readString();
  println("received: " + inString);
  micInput = true;
  globalframecount = 1;
  myPort.write('0');
//  meter = int(map(Integer.parseInt("inString"), 0, 1023, 0, width));
  println("Meter: " + meter);
  
}

void keyPressed(){
  
 switch(key){
 
   case ' ':
   globalframecount =1;
   break;
 
 }
  
}

void postData() {

  
  PostRequest post = new PostRequest(postsite);
  post.addData("photo", String.valueOf(timestamp));
  post.addData("mic", String.valueOf(inString));
  post.addFile("img", "/Users/Kleeb2/Documents/Processing/ScreamBooth/images/" + timestamp + ".gif");

  post.send();
  //println(post.toString());
  //check to make sure post is sent
  println("Reponse Content: " + post.getContent());
  //println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));



}
