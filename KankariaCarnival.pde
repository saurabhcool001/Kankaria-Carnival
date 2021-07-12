import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

import processing.opengl.*;
import codeanticode.glgraphics.*;
import codeanticode.gsvideo.*;

Minim minim;
AudioPlayer player;
AudioInput input;

GSCapture cam;
GSMovie[] movie=new GSMovie[6];
GLTexture[] tex=new GLTexture[6];

PImage prevFrame;
void setup() {
  size(1040, 800, GLConstants.GLGRAPHICS);
  frameRate(30);

  cam = new GSCapture(this, 960, 720);
  cam.start();
  
    minim = new Minim(this);
  player = minim.loadFile("Little.mp3");
  input = minim.getLineIn();
  player.loop();
//  player.setVolume(1);
player.setGain(-10);

  // Use texture tex as the destination for the camera pixels.
  tex[0] = new GLTexture(this);
  tex[1] = new GLTexture(this);
  tex[2] = new GLTexture(this);
  tex[3] = new GLTexture(this);
  tex[4] = new GLTexture(this);
  tex[5] = new GLTexture(this);

  movie[0]=new GSMovie(this, "snake.mov");
  movie[0].frameRate(30);
  movie[1]=new GSMovie(this, "Ferrari.mov");
  movie[1].frameRate(30);
  movie[2]=new GSMovie(this, "Ship.mov");
  movie[2].frameRate(30);
  movie[3]=new GSMovie(this, "cloud.mov");
  movie[3].frameRate(30);
  movie[4]= new GSMovie(this, "T_rex.mov");
  movie[4].frameRate(30);
  movie[5]= new GSMovie(this, "Lion.mov");
  movie[5].frameRate(30);

  for (int i=0;i<movie.length;i++) {
    movie[i].setPixelDest(tex[i]);
    movie[i].frameRate(30);
  }

  prevFrame = createImage(cam.width, cam.height, RGB);
}

void captureEvent(GSCapture cam) {
  cam.read();
}
void movieEvent(GSMovie movie) {

  movie.read();
}


void draw() {
  println("frameRate: "+frameRate);
  // background(255);
  //  image(cam, 0, 0, 960, 600);


  MovieonMovementDisplay();

  for (int i=0;i<tex.length;i++) {
    if (tex[i].putPixelsIntoTexture()) {
      image(tex[i], 0, 0);
    }
  }
}
void MovieonMovementDisplay() {
  if (cam.available()) {
    prevFrame.copy(cam, 0, 0, cam.width, cam.height, 0, 0, cam.width, cam.height);
    prevFrame.updatePixels();
    cam.read();
  }

  pushMatrix();

  scale(-1, 1);
  translate(-cam.width, 0);
 // image(cam, 0, 0, 960, 720); 
 //image(cam, 0, 0, 1080, 800); 
  popMatrix();

  loadPixels();
  cam.loadPixels();
  prevFrame.loadPixels();

  float hig1 = cam.height/1.5;
  int hig11 = (int)hig1; // PRINT VALUE 480

  float hig2 = cam.height/3;
  int hig22 = (int)hig2; // PRINT VALUE 240

  float wid1 = cam.width/1.5;
  int wid11 = (int)wid1; // PRINT VALUE 853

  float wid2 = cam.width/3;
  int wid22 = (int)wid2; // PRINT VALUE 426

  //  fill(0);
  //  stroke(204, 102, 0);
  //  line ((cam.width/1.5), 0, (cam.width/1.5), (cam.height));
  //
  //  fill(0);
  //  stroke(204, 102, 0);
  //  line (0, (cam.height/1.5), (cam.width), (cam.height/1.5));
  //
  //  fill(0);
  //  stroke(204, 102, 0);
  //  line (0, (cam.height/3), (cam.width), (cam.height/3));
  //
  //  fill(0);
  //  stroke(204, 102, 0);
  //  line ((cam.width/3), 0, (cam.width/3), (cam.height));


  float totalMotion=0;

  for (int x = wid22; x < wid11; x++ ) {
    for (int y = 0; y < cam.height; y++ ) {

      color current = cam.pixels[x+y*cam.width];


      color previous = prevFrame.pixels[x+y*cam.width];


      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);

      float diff = dist(r1, g1, b1, r2, g2, b2);
      totalMotion =totalMotion+ diff;
    }
  }
  float avgMotion = ((totalMotion) / (cam.pixels.length)); 
  float a258 = avgMotion * 100;

  float time0=movie[0].time();
  float time1=movie[1].time();
  float time2=movie[2].time();
  float time3=movie[3].time();
  float time4=movie[4].time();
  float time5=movie[5].time();

  int index=int(random(movie.length));
  println("Index Number Is::"+index);

  println("AvgMotion is :"+avgMotion);
  println("AvgMotion is :"+ a258);
  
  if (movie[0].isPlaying() || movie[1].isPlaying() || movie[2].isPlaying() || movie[3].isPlaying() || movie[4].isPlaying() || movie[5].isPlaying()) {
                player.setGain(-5.0);
      }else{
              player.setGain(1.0);
      }

  if (a258>550) {
    if (movie[0].isPlaying() || movie[1].isPlaying() || movie[2].isPlaying() || movie[3].isPlaying() || movie[4].isPlaying() || movie[5].isPlaying()) {

      if (movie[0].isPlaying()) {
        println("Playing 0");
        if (time0== 30.7) {
          movie[0].jump(0);
        }
      }

      else if (movie[1].isPlaying()) {
        println("Playing 1");
        //if (time1==11.033334) { For Ferrari0
        if (time1 == 12.4) {
          movie[1].jump(0);
        }
      }

      else if (movie[2].isPlaying()) {
        println("Playng 2");
        //if (time2==15.000) { //For Old Ship
        if (time2==13.333333) {
          movie[2].jump(0);
        }
      }

      else if (movie[3].isPlaying()) {
        println("Playing 3");
        if (time3==16.083334) {
          movie[3].jump(0);
        }
      }

      else if (movie[4].isPlaying()) {
        println("Playing 4");
        if (time4==11.866667) {
          movie[4].jump(0);
        }
      }

      else if (movie[5].isPlaying()) {
        println("Playing 5");
        if (time5==20.0) {
          movie[5].jump(0);
        }
      }
    }

    else {
      switch(index) {
      case 0: 
        if (movie[0].isPlaying()) {
          if (time0== 30.7) {
            movie[0].jump(0);
          }
        }
        else { 
          movie[0].play();
        }
        break;

      case 1:
        if (movie[2].isPlaying()) {
          // if (time2==15.000) { //For Old Ship
          if (time2==13.333333) {
            movie[2].jump(0);
          }
        }
        else { 
          movie[2].play();
        }
        break;

      case 2:
        if (movie[1].isPlaying()) {
          if (time1==12.4) {
            // if (time1==11.033334) { For Ferrari0
            movie[1].jump(0);
          }
        }
        else {
          movie[1].play();
        }
        break;

      case 3:
        if (movie[3].isPlaying()) {
          if (time3==16.083334) {
            movie[3].jump(0);
          }
        }
        else {
          movie[3].play();
        }
        break;

      case 4:
        if (movie[4].isPlaying()) {
          if (time4==11.866667) {
            movie[4].jump(0);
          }
        }
        else {
          movie[4].play();
        }
        break;

      case 5:
        if (movie[5].isPlaying()) {
          if (time5==20.0) {
            movie[5].jump(0);
          }
        }
        else {
          movie[5].play();
        }
        break;
      }
    }
  }
}

