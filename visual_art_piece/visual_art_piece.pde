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

void setup() {
  size(1024, 900);
  colorMode(HSB);
  minim = new Minim(this);
  player = minim.loadFile("Utada Hikaru & Skrillex - Face My Fears [Lyrics_Lyric Video].mp3", width);
  player.play();
  ai = minim.getLineIn(Minim.MONO, width, 44100, 16);
  buffer = player.left;
  fft = new FFT(width, 44100);

  buttonhozpos = 0;
  buttonvertpos = 0;
  buttonradius = 50;
}

void draw() {
  background(0);
  fill(#343232);
  rect(buttonhozpos, buttonvertpos, 100, 50);
  rect(buttonhozpos, buttonvertpos+50, 100, 50);
  rect(buttonhozpos, buttonvertpos+100, 100, 50);
  rect(buttonhozpos, buttonvertpos+150, 100, 50);
  //-------------------------------------------

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
    ellipse(width / 2, halfH, lerpedAverage * halfH *3, lerpedAverage * halfH *3);
    }
  }
}
