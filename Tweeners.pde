interface Tweener {
  float tween(float delta);
  float tween(float time, float duration);
  float tween(float time, float duration, float change);
  float tween(float time, float duration, float start, float change);
}

abstract class GeneralTweener implements Tweener {
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

class LinearTweener extends GeneralTweener {
  public float tween(float delta) {
    return delta;
  }
}

class EaseInTweener extends GeneralTweener {
  public float tween(float delta) {
    return delta * delta;
  }
}

class EaseOutTweener extends GeneralTweener {
  public float tween(float delta) {
    return delta * (2.0 - delta);
  }
}

class EaseInOutTweener extends GeneralTweener {
  public float tween(float delta) {
    if (delta < 0.5) {
      return 2.0 * delta * delta;
    }
    
    return 2.0 * delta * (2.0 - delta) - 1.0;
  }
}

