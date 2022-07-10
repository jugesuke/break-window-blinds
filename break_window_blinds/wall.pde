class Wall {
  // マスクのサイズ
  float x, y, w, h;
  // メインウィンドウのサイズ
  float mainWindowX;
  float mainWindowY;
  float mainWindowW;
  float mainWindowH;
  // ラケットの範囲
  float rangeStart, rangeEnd;
  // 上の当たり判定位置
  float ceilingHeight;
  Wall(
    float x, float y, float w, float h, 
    float rangeStart, float rangeEnd, float ceilingHeight) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.rangeStart = rangeStart;
    this.rangeEnd = rangeEnd;
    this.ceilingHeight = ceilingHeight;
  }
  void draw() {
    fill(0, 64);
    noStroke();
    rect(x, y, rangeStart - x, h);
    rect(rangeEnd, y, (x+w)- rangeEnd, h);
    fill(42);
    noStroke();
    rect(x, y + h, w, height - y - h);
  }
  int reflect(Ball ball) {
    float speedX = ball.speed * sin(ball.theta);
    float speedY = ball.speed * cos(ball.theta);
    int flag = 0;
    if (
      ball.posX + speedX < rangeStart ||
      rangeEnd - ball.sizeX < ball.posX + speedX) {
      flag += 1;
    }
    if (ball.posY + speedY < ceilingHeight) {
      flag += 2;
    }
    if (y + h - ball.sizeY < ball.posY + speedY - ball.extent - ball.speed) {
      flag = -1;
    }
    return flag;
  }
}
