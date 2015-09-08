class Sound {
  AudioPlayer sound;
  int startTime = Integer.MAX_VALUE;
  int baseStartTime;
  int step;
  
  void play() {
    if (frameCount == startTime) {
      sound.play();
    }
  }
  
  void startSounds(int step) {
    if (this.step == step) {
      sound.pause();
      sound.rewind();
      startTime = baseStartTime + frameCount + 1;
    }
  }
}