abstract class Element {
  float x, y, w, h;
  color fillColor;
  color strokeColor;
  boolean hasStroke;

  float dX, dY, dW, dH;
  int dFR, dFG, dFB, dFA, dSR, dSG, dSB, dSA;
  
  Element(float x, float y, float w, float h, color fillColor, color strokeColor, boolean hasStroke) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.fillColor = fillColor;
    this.strokeColor = strokeColor;
    this.hasStroke = hasStroke;
  }
  
  void draw() {
    dX = 0; dY = 0; dW = 0; dH = 0;
    dFR = 0; dFG = 0; dFB = 0; dFA = 0;
    dSR = 0; dSG = 0; dSB = 0; dSA = 0;
    
    fill(fillColor);
    
    if (hasStroke) {
      stroke(strokeColor);
    } else {
      noStroke();
    }
  }
}

class Rectangle extends Element {
  Rectangle(float x, float y, float w, float h, color f, color s, boolean hS) {
    super(x, y, w, h, f, s, hS);
  }
  
  void draw() {
    super.draw();
    rect(x, y, w, h);
  }
}

