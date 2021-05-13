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
      float x = 200;
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
      ellipse(x, halfH - 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(x, halfH + 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(x + 600, halfH - 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
      ellipse(x + 600, halfH + 250, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
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
        line(height / 2 - sample, -i, height/2 + sample, i);
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
      for (int i =0; i<buffer.size(); i++) {
        sum += abs(buffer.get(i));
      }
      float average = sum/(float)buffer.size();
      LA = lerp(LA, average, 0.1f);
      background(0);
      strokeWeight(5);
      stroke(random(0, 255), random(0, 255), random(0, 255));
      lights();
      noFill();
      T +=S;

      pushMatrix();
      translate(width/4, height/2, 0);
      rotateY(T);
      rotateX(T);
      rotateZ(T);
      sphere(100 +(LA *2500));
      popMatrix();

      pushMatrix();
      translate(width*0.75, height/2, 0);
      rotateY(T);
      rotateX(T);
      rotateZ(T);
      sphere(100+(LA *2500));
      popMatrix();
    }
  }
  //---------------------------------------------------------------------------------------
  if (mousePressed) {
    if (dist(mouseX, mouseY, buttonhozpos, buttonvertpos+150)<buttonradius) {
   
    }
  }
  //---------------------------------------------------------------------------------------
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
  line(halfH, lerpedAverage * halfH *3 +189, halfH -131, lerpedAverage * halfH *3, halfH-165, lerpedAverage * halfH *3 +1);
  line(lerpedAverage *halfH +986, halfH +84, halfH *3 +297, lerpedAverage *halfH+258, lerpedAverage * halfH *3+439, halfH-566);
  line(halfH, lerpedAverage * halfH *3, halfH, lerpedAverage * halfH *3, halfH, lerpedAverage * halfH *3);
  line(halfH +235, lerpedAverage * halfH *3, halfH -87, lerpedAverage * halfH *3, halfH, lerpedAverage * halfH *3);
  line(halfH -1, lerpedAverage * halfH *3 -1, halfH-1, lerpedAverage * halfH *3 +400, halfH +551, lerpedAverage * halfH *3 +500);
  line(halfH +495, lerpedAverage * halfH *3 +39, halfH + -35, lerpedAverage * halfH *3, halfH+342, lerpedAverage * halfH *3 -1333);
  line(halfH-1275, lerpedAverage * halfH *3+1107, halfH+131, lerpedAverage * halfH *3+164, halfH+74, lerpedAverage * halfH *3-111);
  line(halfH+137, lerpedAverage * halfH *3+581, halfH+57, lerpedAverage * halfH *3+962, halfH-1, lerpedAverage * halfH *3+1);
  line(halfH+39, lerpedAverage * halfH *3+622, halfH+14, lerpedAverage * halfH *3-1145, halfH+1, lerpedAverage * halfH *3-1);
  line(halfH+-267, lerpedAverage * halfH *3+1, halfH-1, lerpedAverage * halfH *3+705, halfH+1498, lerpedAverage * halfH *3-1435);
  line(halfH+245, lerpedAverage * halfH *3, halfH+-432, lerpedAverage * halfH *3+364, halfH+-247, lerpedAverage * halfH *3+-1244);
  line(halfH+-13, lerpedAverage * halfH *3, halfH+844, lerpedAverage * halfH *3+837, halfH+61, lerpedAverage * halfH *3+-270);
  line(halfH+2537, lerpedAverage * halfH *3, halfH+-723, lerpedAverage * halfH *3+1, halfH+1, lerpedAverage * halfH *3+1);
  line(halfH+346, lerpedAverage * halfH *3, halfH+85, lerpedAverage * halfH *3+1, halfH+405, lerpedAverage * halfH *3+1);
  line(halfH+7, lerpedAverage * halfH *3, halfH+-630, lerpedAverage * halfH *3+666, halfH+477, lerpedAverage * halfH *3+170);
}
