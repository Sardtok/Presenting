class Slide {
  Element background;
  Element[] elements;
  Sound[] sounds;
  int steps;
  int step = -1;

  Slide(JSONObject slide, Slide previous) {
    background = new Rectangle(0, 0, width, height, 0, getColor(slide.getString("background")), 0, false);
    
    if (previous != null) {
      Element pbg = previous.background;
      previous.steps++;
      
      Animation transition = new Animation();
      transition.duration = 15;
      transition.baseStartTime = 15;
      transition.dFR = background.fR - pbg.fR;
      transition.dFG = background.fG - pbg.fG;
      transition.dFB = background.fB - pbg.fB;
      transition.step = previous.steps;
      pbg.animations.add(transition);
      
      transition = new Animation();
      transition.duration = 15;
      transition.dFA = -255;
      transition.step = previous.steps;
      
      for (Element e : previous.elements) {
        e.animations.add(transition);
      }
    }
    
    loadElements(slide.getJSONArray("elements"));
    
    if (slide.hasKey("sounds")) {
      loadSounds(slide.getJSONArray("sounds"));
    } else {
      sounds = new Sound[0];
    }
  }

  void draw() {
    background.draw();
    for (Element e : elements) {
      e.draw();
    }
    for (Sound s : sounds) {
      s.play();
    }
  }

  boolean next() {
    step++;
    background.startAnimations(step);
    for (Element e : elements) {
      e.startAnimations(step);
    }
    for (Sound s : sounds) {
      s.startSounds(step);
    }
    
    return step > steps;
  }
  
  boolean prev() {
    if (step < 0) {
      return false;
    }
    
    background.stopAnimations(step);
    for (Element e : elements) {
      e.stopAnimations(step);
    }
    step--;
    
    return step < 0;
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
        int align = LEFT;
        int font = 0;
        if (eJson.hasKey("align")) {
          align = eJson.getInt("align");
        }
        if (eJson.hasKey("font")) {
          font = eJson.getInt("font");
        }
        e = new TextElement(x, y, w, h, a, f, s, hS, align, font, eJson.getString("text"));
      } else if (type.equals("rect")) {
        e = new Rectangle(x, y, w, h, a, f, s, hS);
      } else if (type.equals("image")) {
        e = new Image(x, y, w, h, a, f, s, hS, eJson.getString("filename"));
      } else {
        throw new IllegalArgumentException("Unknown element type: " + type);
      }

      if (eJson.hasKey("animations")) {
        loadAnimations(eJson.getJSONArray("animations"), e);
      }

      elements[i] = e;
    }
  }

  void loadAnimations(JSONArray animationList, Element e) {
    for (int i = 0; i < animationList.size(); i++) {
      Animation a = new Animation();
      JSONObject aJson = animationList.getJSONObject(i);

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
      
      if (aJson.hasKey("fr")) {
        a.dFR = aJson.getInt("fr");
      }
      if (aJson.hasKey("fg")) {
        a.dFG = aJson.getInt("fg");
      }
      if (aJson.hasKey("fb")) {
        a.dFB = aJson.getInt("fb");
      }
      if (aJson.hasKey("fa")) {
        a.dFA = aJson.getInt("fa");
      }
      
      if (aJson.hasKey("sr")) {
        a.dSR = aJson.getInt("sr");
      }
      if (aJson.hasKey("sg")) {
        a.dSG = aJson.getInt("sg");
      }
      if (aJson.hasKey("sb")) {
        a.dSB = aJson.getInt("sb");
      }
      if (aJson.hasKey("sa")) {
        a.dSA = aJson.getInt("sa");
      }

      if (aJson.hasKey("tweener")) {
        a.tweener = tweeners[aJson.getInt("tweener")];
      }
      if (aJson.hasKey("step")) {
        a.step = aJson.getInt("step");
        
        if (a.step > steps) {
          steps = a.step;
        }
      }
      if (aJson.hasKey("start")) {
        a.baseStartTime = aJson.getInt("start");
      }

      a.duration = aJson.getInt("duration");

      e.animations.add(a);
    }
  }
  
  void loadSounds(JSONArray soundList) {
    sounds = new Sound[soundList.size()];
    
    for (int i = 0; i < sounds.length; i++) {
      JSONObject s = soundList.getJSONObject(i);
      Sound sound = new Sound();
      sounds[i] = sound;
      
      sound.sound = getSound(s.getString("filename"));
      
      if (s.hasKey("start")) {
        sound.baseStartTime = s.getInt("start");
      }
      if (s.hasKey("step")) {
        sound.step = s.getInt("step");
        
        if (sound.step > steps) {
          steps = sound.step;
        }
      }
    }
  }
}