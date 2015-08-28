class Slide {
  Element background;
  Element[] elements;

  Slide(JSONObject slide) {
    background = new Rectangle(0, 0, width, height, getColor(slide.getString("background")), 0, false);
    loadElements(slide.getJSONArray("elements"));
  }

  void draw() {
    background.draw();
    for (Element e : elements) {
      e.draw();
    }
  }

  void loadElements(JSONArray elementList) {
    elements = new Element[elementList.size()];

    for (int i = 0; i < elements.length; i++) {
      JSONObject eJson = elementList.getJSONObject(i);
      Element e = null;
      float x = 0;
      float y = 0;
      float w = 0;
      float h = 0;
      color f = 0;
      color s = 0;
      boolean hS = false;

      if (eJson.hasKey("x")) {
        x = eJson.getFloat("x") * width;
      }

      if (eJson.hasKey("y")) {
        y = eJson.getFloat("y") * height;
      }

      if (eJson.hasKey("w")) {
        w = eJson.getFloat("w") * SCALE;
      }

      if (eJson.hasKey("h")) {
        h = eJson.getFloat("h") * SCALE;
      }

      if (eJson.hasKey("fillColor")) {
        f = getColor(eJson.getString("fillColor"));
      }

      if (eJson.hasKey("strokeColor")) {
        s = getColor(eJson.getString("strokeColor"));
        hS = true;
      }

      String type = eJson.getString("type");
      if (type.equals("text")) {
        e = new TextElement(x, y, w, h, f, s, hS, eJson.getString("text"));
      }

      e.animations = new Animation[0];

      elements[i] = e;
    }
  }
}

