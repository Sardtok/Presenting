interface Element {
  void draw();
}

class Rectangle implements Element {
  float x, y, w, h;
  color c;
  
  Rectangle(float x, float y, float w, float h, color c) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c = c;
  }
  
  void draw() {
    fill(c);
    noStroke();
    rect(x, y, w, h);
  }
}

