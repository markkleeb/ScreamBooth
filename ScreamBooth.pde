import processing.serial.*;
import httprocessing.*;
import gifAnimation.*;
import org.json.*;
import processing.video.*;
import org.seltar.Bytes2Web.*;
                    
                    
String postsite = "http://screambooth.herokuapp.com/photos/add";
//String postsite = "localhost:5000/photos/add";
String inString;                    
                
                   
Serial myPort; 
GifMaker gifExport;
Capture video;
int globalframecount = 0;
int countdowntimer = 10;
int imageName = 0;
int x = 100;  // x- position text
int y = height-50; // y- position text
int timestamp;
int lf = 10;
Date d = new Date();

boolean micInput = false;

float a = (0);
float b = (255);
float changea = 2.5;
float changeb = -2.5;

void setup() {
  size(640, 480, P2D);
  background(0);
  String[] cameras = Capture.list();
  rectMode(CENTER);
  video = new Capture(this, cameras[0]);
  video.start();
  
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
  textSize(80);
  image (video, 0, 0);
   
  
  

  if (globalframecount == 0) {
    fill(255);
    rect(640, 480, width*2, height*2);
    fill(0);
    text("SCREAM!", width/2, height/2);
    myPort.write('1');
  }
  if (globalframecount < 1100 && globalframecount > 0 ) {
    if (globalframecount == 100) {
      

      gifExport = new GifMaker(this, "images/" + d.getTime() + ".gif");
      gifExport.setQuality(256);
      gifExport.setRepeat(0);
    }
    
    if (globalframecount > 0 && globalframecount < 50) {
     fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("3", width/2, height/2);
     
    }
    if (globalframecount > 50 && globalframecount < 100) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("2", width/2, height/2);
    }
    if (globalframecount > 100 && globalframecount < 150) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("1", width/2, height/2);
    }
    if (globalframecount == 151) {
      fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 152) {
      gifExport.setDelay(300);
      gifExport.addFrame();
    }
    if (globalframecount > 160 && globalframecount < 210) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("3", width/2, height/2);
    }
    if (globalframecount > 210 && globalframecount < 260) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("2", width/2, height/2);
    }
    if (globalframecount > 260 && globalframecount < 310) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("1", width/2, height/2);
    }
    if (globalframecount == 311) {
      fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 312) {
      gifExport.setDelay(300);
      gifExport.addFrame();
    }
    if (globalframecount > 320 && globalframecount < 370) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("3", width/2, height/2);
    }
    if (globalframecount > 370 && globalframecount < 420) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("2", width/2, height/2);
    }
    if (globalframecount > 420 && globalframecount < 470) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("1", width/2, height/2);
    }
    if (globalframecount == 471) {
      fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 472) {
      gifExport.setDelay(300);
      gifExport.addFrame();
    }
    if (globalframecount > 480 && globalframecount < 530) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("3", width/2, height/2);
    }
    if (globalframecount > 530 && globalframecount < 580) {
       fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("2", width/2, height/2);
    }
    if (globalframecount > 580 && globalframecount < 630) {
      fill(0, 0, 0, 120);
      rectMode(CENTER);
      rect(width/2, height/2-30, 50, 100); 
      fill(255);
      text("1", width/2, height/2);
    }
    if (globalframecount == 631) {
      fill(255);
      rect(640, 480, width*2, height*2);
    }
    if (globalframecount == 632) {
      gifExport.setDelay(300);
      gifExport.addFrame();
    }
    if (globalframecount == 633) {
      gifExport.finish();
    }
    globalframecount++;
    if (globalframecount == 634) {
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
  
}

void postData() {
/*
  ImageToWeb img = new ImageToWeb(this);
    img.setType(ImageToWeb.GIF);
    img.save("gif",true);
    img.post("test",url,"gif-test",true);
  */
  
  
 
  
  JSONArray photo = new JSONArray();
  
  JSONObject img = new JSONObject();
  img.put("photo", d.getTime());
  photo.put(img);
  
  PostRequest post = new PostRequest(postsite);
  post.addData("stuff", photo.toString());

  post.send();
  println(post.toString());
  //check to make sure post is sent
  println("Reponse Content: " + post.getContent());
  //println("Reponse Content-Length Header: " + post.getHeader("Content-Length"));



}
