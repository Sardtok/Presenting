class Animation {
  Tweener tweener;
  int duration;
  int startTime;
  Element e;
  
  float dX, dY, dW, dH;
  int dFR, dFG, dFB, dFA, dSR, dSG, dSB, dSA;
  
  void animate() {
    float delta = tweener.tween(frameCount - startTime, duration);
    e.dX += dX * delta;
    e.dY += dY * delta;
    e.dW += dW * delta;
    e.dH += dH * delta;
    
    e.dFR += dFR * delta;
    e.dFG += dFG * delta;
    e.dFB += dFB * delta;
    e.dFA += dFA * delta;
    
    e.dSR += dSR * delta;
    e.dSG += dSG * delta;
    e.dSB += dSB * delta;
    e.dSA += dSA * delta;
  }
}

