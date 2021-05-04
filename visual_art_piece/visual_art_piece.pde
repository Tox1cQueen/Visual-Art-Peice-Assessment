import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player;
AudioBuffer buffer;
AudioInput ai;
FFT fft;

int buttonhozpos;
int buttonvertpos;
int buttonradius;
float lerpedAverage = 0;
float[] lerpedBuffer;

int s = second();
int m = minute();

void setup() {
  size(1024, 900, P3D);
  colorMode(HSB);
  minim = new Minim(this);
  player = minim.loadFile("Utada Hikaru & Skrillex - Face My Fears [Lyrics_Lyric Video].mp3", width);
  player.play();
  ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.left;
  fft = new FFT(width, 44100);
  lerpedBuffer = new float[buffer.size()];

  buttonhozpos = 0;
  buttonvertpos = 0;
  buttonradius = 25;
}

void draw() {
  background(0);
  fill(#343232);
  rect(buttonhozpos, buttonvertpos, 100, 50);
  rect(buttonhozpos, buttonvertpos+50, 100, 50);
  rect(buttonhozpos, buttonvertpos+100, 100, 50);
  rect(buttonhozpos, buttonvertpos+150, 100, 50);

  //------------------------------------------------
  if (mousePressed) {
    if (dist(mouseX, mouseY, buttonhozpos, buttonvertpos)<buttonradius) {
      float halfH = height / 2;
      float total = 0;
      for (int i = 0; i < buffer.size(); i ++) {
        strokeWeight(2);
        total += abs(buffer.get(i));
        stroke(map(lerpedAverage, 0, 1, 0, 255), 255, 255);
      }
      float average = total / (float) buffer.size();
      lerpedAverage = lerp(lerpedAverage, average, 0.1f);
      rectMode(CENTER);
      noFill();
      ellipse(width/2, halfH, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(200, halfH - 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(200, halfH + 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(800, halfH - 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(800, halfH + 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
    }
  }
  //--------------------------------------------------------------------------------------
  if (mousePressed) {
    if (dist(mouseX, mouseY, buttonhozpos, buttonvertpos+50)<buttonradius) {
      for (int i = 0; i < buffer.size(); i ++) {
        stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
        lerpedBuffer[i] = lerp(lerpedBuffer[i], buffer.get(i), 0.1f);
        float sample = lerpedBuffer[i] * width * 2;    
        stroke(map(i, 0, buffer.size(), 0, 255), 255, 255);
        line(height / 2 - sample,-i,height/2 + sample, i);
      }
    }
  }
  //---------------------------------------------------------------------------------------
  if (mousePressed) {
    if (dist(mouseX, mouseY, buttonhozpos, buttonvertpos+100)<buttonradius) {
      float s = 1;
      float T=0;
      float S=0.01f;
      float LA=0;
    
  float sum=0;
  for(int i =0;i<buffer.size();i++){
   sum += abs(buffer.get(i)); 
  }
  float average = sum/(float)buffer.size();
  LA = lerp(LA, average,0.1f);
  background(0);
  strokeWeight(5);
  stroke(random(0,255),random(0,255),random(0,255));
  lights();
  noFill();
   T +=S;
   
  pushMatrix();
  translate(width/4,height/2,0);
  rotateY(T);
  rotateX(T);
  rotateZ(T);
  sphere(100 +(LA *2500));
    popMatrix();
  
  pushMatrix();
  translate(width*0.75,height/2,0);
  rotateY(T);
  rotateX(T);
  rotateZ(T);
  sphere(100+(LA *2500));
  popMatrix();
  z += s;
    }
  }
  //---------------------------------------------------------------------------------------
  if (mousePressed) {
    if (dist(mouseX, mouseY, buttonhozpos, buttonvertpos+150)<buttonradius) {
    float halfH = height / 2;
    float total = 0;
    for (int i = 0; i < buffer.size(); i ++) {
      strokeWeight(2);
      total += abs(buffer.get(i));
      stroke(map(lerpedAverage, 0, 1, 0, 255), 255, 255);
    }
    float average = total / (float) buffer.size();
    lerpedAverage = lerp(lerpedAverage, average, 0.1f);
    rectMode(CENTER);
    noFill();
    triangle(halfH, lerpedAverage * halfH *3, halfH, lerpedAverage * halfH *3, halfH, lerpedAverage * halfH *3);
  }
  }
  //---------------------------------------------------------------------------------------
}
