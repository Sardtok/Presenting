abstract class Element {
  float x, y, w, h, a;
  float fR, fG, fB, fA, sR, sG, sB, sA;
  boolean hasStroke;

  Animation[] animations = new Animation[0];
  float dX, dY, dW, dH, dA;
  float dFR, dFG, dFB, dFA, dSR, dSG, dSB, dSA;

  Element(float x, float y, float w, float h, float a, color fillColor, color strokeColor, boolean hasStroke) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.a = a;
    this.fR = red(fillColor);
    this.fG = green(fillColor);
    this.fB = blue(fillColor);
    this.fA = alpha(fillColor);
    this.sR = red(strokeColor);
    this.sG = green(strokeColor);
    this.sB = blue(strokeColor);
    this.sA = alpha(strokeColor);
    this.hasStroke = hasStroke;
  }

  abstract void render();

  void draw() {
    dX = 0;
    dY = 0;
    dW = 0;
    dH = 0;
    dA = 0;
    dFR = 0;
    dFG = 0;
    dFB = 0;
    dFA = 0;
    dSR = 0; 
    dSG = 0;
    dSB = 0;
    dSA = 0;

    for (Animation a : animations) {
      a.animate(frameCount);
    }
    
    fill(fR + dFR, fG + dFG, fB + dFB, fA + dFA);

    if (hasStroke) {
      stroke(sR + dSR, sG + dSG, sB + dSB, sA + dSA);
    } else {
      noStroke();
    }
    
    pushMatrix();
    translate(x + dX, y + dY);
    scale((w + dW) / w, (h + dH) / h);
    rotate(a + dA);
    render();
    popMatrix();
  }

  void startAnimations() {
    for (Animation a : animations) {
      a.startTime += a.baseStartTime + frameCount;
    }
  }
}

class Rectangle extends Element {
  Rectangle(float x, float y, float w, float h, float a, color f, color s, boolean hS) {
    super(x, y, w, h, a, f, s, hS);
  }

  void render() {
    rect(0, 0, w, h);
  }
}

class TextElement extends Element {
  String text;

  TextElement(float x, float y, float w, float h, float a, color f, color s, boolean hS, String text) {
    super(x, y, w, h, a, f, s, hS);
    this.text = text;
  }

  void render() {
    textFont(fonts[0], w);
    text(text, 0, 0);
  }
}

class Image extends Element {
  PImage img;

  Image(float x, float y, float w, float h, float a, color f, color s, boolean hS, String fileName) {
    super(x, y, w, h, a, f, s, hS);
    this.img = getImage(fileName);
  }

  void render() {
    image(img, 0, 0, w, h);
  }
}