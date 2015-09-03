class Slide {
  Element background;
  Element[] elements;

  Slide(JSONObject slide) {
    background = new Rectangle(0, 0, width, height, 0, getColor(slide.getString("background")), 0, false);
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
      float w = 1;
      float h = 1;
      float a = 0;
      color f = #ffffff;
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
      
      if (eJson.hasKey("a")) {
        a = radians(eJson.getFloat("a"));
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
        e = new TextElement(x, y, w, h, a, f, s, hS, eJson.getString("text"));
      } else if (type.equals("rect")) {
        e = new Rectangle(x, y, w, h, a, f, s, hS);
      } else if (type.equals("image")) {
        e = new Image(x, y, w, h, a, f, s, hS, eJson.getString("filename"));
      } else {
        throw new IllegalArgumentException("Unknown element type: " + type);
      }

      if (eJson.hasKey("animations")) {
        e.animations = loadAnimations(eJson.getJSONArray("animations"), e);
      }

      elements[i] = e;
    }
  }

  Animation[] loadAnimations(JSONArray animationList, Element e) {
    Animation[] animations = new Animation[animationList.size()];

    for (int i = 0; i < animations.length; i++) {
      Animation a = new Animation();
      JSONObject aJson = animationList.getJSONObject(i);

      a.e = e;

      if (aJson.hasKey("x")) {
        a.dX = aJson.getFloat("x") * width;
      }
      if (aJson.hasKey("y")) {
        a.dY = aJson.getFloat("y") * height;
      }
      if (aJson.hasKey("w")) {
        a.dW = aJson.getFloat("w") * SCALE;
      }
      if (aJson.hasKey("h")) {
        a.dH = aJson.getFloat("h") * SCALE;
      }
      if (aJson.hasKey("a")) {
        a.dA = radians(aJson.getFloat("a"));
      }

      if (aJson.hasKey("tweener")) {
        a.tweener = tweeners[aJson.getInt("tweener")];
      }

      a.duration = aJson.getInt("duration");

      animations[i] = a;
    }

    return animations;
  }
}