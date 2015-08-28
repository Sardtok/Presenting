class Presentation {

  PFont[] fonts;
  
  Presentation(String fileName) {
    JSONObject presentation = loadJSONObject(fileName);
    loadFonts(presentation.getJSONArray("fonts"));
  }
  
  
  void loadFonts(JSONArray fontList) {
    fonts = new PFont[fontList.size()];
  
    for (int i = 0; i < fonts.length; i++) {
      fonts[i] = createFont(fontList.getString(i), 48);
    }
  }
}

