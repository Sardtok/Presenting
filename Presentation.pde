class Presentation {

  PFont[] fonts;
  Slide[] slides;
  
  Presentation(String fileName) {
    JSONObject presentation = loadJSONObject(fileName);
    loadFonts(presentation.getJSONArray("fonts"));
    loadSlides(presentation.getJSONArray("slides"));
  }
  
  void draw() {
    slides[0].draw();
  }
  
  void loadFonts(JSONArray fontList) {
    fonts = new PFont[fontList.size()];
  
    for (int i = 0; i < fonts.length; i++) {
      fonts[i] = createFont(fontList.getString(i), 48);
    }
  }
  
  void loadSlides(JSONArray slideList) {
    slides = new Slide[slideList.size()];
    
    for (int i = 0; i < slides.length; i++) {
      slides[i] = new Slide(slideList.getJSONObject(i));
    }
  }
}

