class BackGround {
  // 背景サイズと位置
  float x, y, w, h;
  // 色変更位置
  float gradationStart = 100;
  float ground;
  // 各種色
  color upColor = color(101, 152, 218);
  color downColor = color(101, 152, 218);
  color turfColor = color(192, 238, 26);
  BackGround(float x, float y, float w, float h, float ground) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.ground = ground;
  }
  void draw() {
    fill(upColor);
    rect(x, y, w, gradationStart);
    for (float t = 0; t < ground - gradationStart; t += 5) {
      color c = lerpColor(upColor, downColor, t / (ground - gradationStart));
      fill(c);
      rect(x, y + t + gradationStart, w, 5);
    }
    fill(turfColor);
    rect(x, y + ground + 1, w, h - ground);
  }
}
