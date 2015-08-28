import static java.awt.event.KeyEvent.*;
import java.util.Scanner;

float SCALE;
float RATIO;

int[] NEXT_CODES = {DOWN, RIGHT, VK_PAGE_DOWN};
char[] NEXT_CHARS = {' '};

int[] PREV_CODES = {UP, LEFT, VK_PAGE_UP};
char[] PREV_CHARS = {};

Presentation presentation;

void setup() {
  size(displayWidth, displayHeight);
  RATIO = width / height;
  SCALE = width / 1920.0;
  
  presentation = new Presentation("data/elk-presentation.json");
}

void draw() {
  background(0);
  presentation.draw();
}

color getColor(String c) {
  if (c.startsWith("#")) {
    int r = Integer.parseInt(c.substring(1,3), 16);
    int g = Integer.parseInt(c.substring(3,5), 16);
    int b = Integer.parseInt(c.substring(5,7), 16);
    
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
}

void prev() {
}

void keyReleased() {
  for (int nc : NEXT_CODES) {
    if (nc == keyCode) {
      next(); return;
    }
  }
  
  for (char nc : NEXT_CHARS) {
    if (nc == key) {
      next(); return;
    }
  }
  
  for (int pc : PREV_CODES) {
    if (pc == keyCode) {
      prev(); return;
    }
  }
  
  for (char pc : PREV_CHARS) {
    if (pc == key) {
      next(); return;
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

