interface Tweener {
  float tween(float delta);
  float tween(float time, float duration);
  float tween(float time, float duration, float change);
  float tween(float time, float duration, float start, float change);
}

class GeneralTweener implements Tweener {
  public float tween(float delta) {
    return max(min(delta, 1.0), 0.0);
  }
  
  public float tween(float time, float duration) {
    return tween(time / duration);
  }
  
  public float tween(float time, float duration, float change) {
    return change * tween(time / duration);
  }
  
  public float tween(float time, float duration, float start, float change) {
    return start + change * tween(time / duration);
  }
}

class CompositeTweener extends GeneralTweener {
  Tweener[] tweeners;
  
  CompositeTweener(Tweener ... tweeners) {
    this.tweeners = tweeners;
  }
  
  public float tween(float delta) {
    for (Tweener t : tweeners) {
      delta = t.tween(delta);
    }
    
    return delta;
  }
}

class LoopTweener extends GeneralTweener {
  public float tween(float delta) {
    return abs(delta) % 1.0;
  }
}

class SineTweener extends GeneralTweener {
  public float tween(float delta) {
    return (1 - cos(delta * PI)) * 0.5;
  }
}

class EaseInTweener extends GeneralTweener {
  public float tween(float delta) {
    delta = super.tween(delta);
    return delta * delta;
  }
}

class EaseOutTweener extends GeneralTweener {
  public float tween(float delta) {
    delta = super.tween(delta);
    return delta * (2.0 - delta);
  }
}

class EaseInOutTweener extends GeneralTweener {
  public float tween(float delta) {
    delta = super.tween(delta);
    
    if (delta < 0.5) {
      return 2.0 * delta * delta;
    }
    
    return 2.0 * delta * (2.0 - delta) - 1.0;
  }
}