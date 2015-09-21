import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import java.awt.event.KeyEvent;
import java.util.Scanner;
import processing.opengl.*;

float SCALE;
float RATIO;

int[] NEXT_CODES = {
  DOWN, RIGHT, KeyEvent.VK_PAGE_DOWN
};
char[] NEXT_CHARS = {
  ' '
};

int[] PREV_CODES = {
  UP, LEFT, KeyEvent.VK_PAGE_UP
};
char[] PREV_CHARS = {
};

Tweener[] tweeners = {
  new GeneralTweener(),
  new EaseInTweener(),
  new EaseOutTweener(),
  new EaseInOutTweener(),
  new LoopTweener(),
  new SineTweener()
};

PFont[] fonts;
Slide[] slides;
int slide;
HashMap<String, PImage> images = new HashMap<String, PImage>();
HashMap<String, AudioPlayer> sounds = new HashMap<String, AudioPlayer>();
Minim minim;

void setup() {
  fullScreen(P2D);
  minim = new Minim(this);
  
  // This is an ugly hack to turn on vertical sync
  // This removes tearing and choppy animation
  frameRate(-1);
  ((PJOGL)((PGraphicsOpenGL)getGraphics()).pgl).gl.setSwapInterval(1);
  
  RATIO = width / height;
  SCALE = width / 1920.0;
  strokeWeight(3 * SCALE);
  imageMode(CENTER);
  JSONObject presentation = loadJSONObject("data/demo-presentation.json");
  loadFonts(presentation.getJSONArray("fonts"));
  loadSlides(presentation.getJSONArray("slides"));
  slides[0].next();
}

void draw() {
  background(0);
  if (slide < slides.length) {
    slides[slide].draw();
  } else {
    textAlign(CENTER);
    textFont(fonts[0], 64 * SCALE);
    fill(255);
    text("That's all folks...", width / 2, height / 2);
  }
}

void loadFonts(JSONArray fontList) {
  fonts = new PFont[fontList.size()];

  for (int i = 0; i < fonts.length; i++) {
    JSONObject font = fontList.getJSONObject(i);
    fonts[i] = createFont(font.getString("name"), font.getFloat("size") * SCALE);
  }
}

void loadSlides(JSONArray slideList) {
  slides = new Slide[slideList.size()];

  for (int i = 0; i < slides.length; i++) {
    slides[i] = new Slide(slideList.getJSONObject(i), i > 0 ? slides[i - 1] : null);
  }
}

PImage getImage(String fileName) {
  if (!images.containsKey(fileName)) {
    images.put(fileName, loadImage(fileName));
  }

  return images.get(fileName);
}

AudioPlayer getSound(String fileName) {
  if (!sounds.containsKey(fileName)) {
    sounds.put(fileName, minim.loadFile(fileName));
  }

  return sounds.get(fileName);
}

color getColor(String c) {
  if (c.startsWith("#")) {
    int r = Integer.parseInt(c.substring(1, 3), 16);
    int g = Integer.parseInt(c.substring(3, 5), 16);
    int b = Integer.parseInt(c.substring(5, 7), 16);

    return color(r, g, b, c.length() > 7 ? Integer.parseInt(c.substring(7), 16) : 255);
  } else if (c.startsWith("rgb(")) {
    Scanner s = new Scanner(c);
    s.useDelimiter("[^0-9]+");

    int r = s.nextInt();
    int g = s.nextInt();
    int b = s.nextInt();

    return color(r, g, b, s.hasNextInt() ? s.nextInt() : 255);
  }

  return color(Integer.parseInt(c));
}

void next() {
  if (slide >= slides.length) {
    exit();
    return;
  }
  
  boolean slideIsDone = slides[slide].next();
  if (slideIsDone) {
    slide++;
    
    if (slide < slides.length) {
      slides[slide].next();
    }
  }
}

void prev() {
  if (slide >= slides.length) {
    slide--;
    slides[slide].prev();
  }
  
  boolean slideIsAtStart = slides[slide].prev();
  if (slideIsAtStart) {
    slide--;
    
    if (slide >= 0) {
      slides[slide].prev();
    }
  }
}

void keyReleased() {
  for (int nc : NEXT_CODES) {
    if (nc == keyCode) {
      next();
      return;
    }
  }

  for (char nc : NEXT_CHARS) {
    if (nc == key) {
      next();
      return;
    }
  }

  for (int pc : PREV_CODES) {
    if (pc == keyCode) {
      prev();
      return;
    }
  }

  for (char pc : PREV_CHARS) {
    if (pc == key) {
      prev();
      return;
    }
  }
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    next();
  } else if (mouseButton == RIGHT) {
    prev();
  }
}