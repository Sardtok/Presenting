import static java.awt.event.KeyEvent.*;

float SCALE;
float RATIO;

int[] NEXT_CODES = {DOWN, RIGHT, VK_PAGE_DOWN};
char[] NEXT_CHARS = {' '};

int[] PREV_CODES = {UP, LEFT, VK_PAGE_UP};
char[] PREV_CHARS = {};

void setup() {
  size(displayWidth, displayHeight);
  RATIO = width / height;
  SCALE = width / 1920;
}

void draw() {
  background(0);
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

