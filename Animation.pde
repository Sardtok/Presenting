class Animation {
  Tweener tweener = tweeners[0];
  int duration;
  int startTime = Integer.MAX_VALUE;
  int baseStartTime;
  int step;
  
  float dX, dY, dW, dH, dA, dFR, dFG, dFB, dFA, dSR, dSG, dSB, dSA;
  
  void animate(int frame, Element e) {
    if (frame < startTime) {
      return;
    }
    
    float delta = tweener.tween(frame - startTime, duration);
    e.dX += dX * delta;
    e.dY += dY * delta;
    e.dW += dW * delta;
    e.dH += dH * delta;
    e.dA += dA * delta;
    
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