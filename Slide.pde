class Slide {
  Element background;
  Element[] elements;
  
  Slide(JSONObject slide) {
    background = new Rectangle(0, 0, width, height, getColor(slide.getString("background")), 0, false);
    elements = new Element[0];
  }
  
  void draw() {
    background.draw();
    for (Element e : elements) {
      e.draw();
    }
  }
}

