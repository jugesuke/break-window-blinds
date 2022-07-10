class Racket extends GameObject {
  // 移動範囲
  float rangeStart, rangeEnd;
  // 中心x 座標
  float center;
  // ラケット幅変更関連
  boolean big;
  int bigEndFrameCount;
  float defaultSizeX;
  Racket(
    float posX, float posY, 
    float sizeX, float sizeY, 
    float rangeStart, float rangeEnd) {
    super(posX, posY, sizeX, sizeY);
    defaultSizeX = sizeX;
    this.rangeStart = rangeStart;
    this.rangeEnd = rangeEnd;
    big = false;
  }
  void draw(int frame) {
    posX = center - (sizeX / 2);
    fill(255);
    stroke(0);
    if (rangeStart >= posX) {
      posX = rangeStart;
    } else if (posX + sizeX >= rangeEnd) {
      posX = rangeEnd - sizeX;
    }
    if (big) {
      sizeX = defaultSizeX * 2;
      if (bigEndFrameCount < frame) {
        big = false;
      }
    } else {
      sizeX = defaultSizeX;
    }
    rect(posX, posY, sizeX, sizeY);
  }
  int reflect(Ball ball) {
    float speedX = ball.speed * sin(ball.theta);
    float speedY = ball.speed * cos(ball.theta);
    int flag = 0;
    if (isHit(ball.posX+speedX, ball.posY, ball.sizeX, ball.sizeY)) {
      flag += 1;
    }
    if (isHit(ball.posX, ball.posY+speedY, ball.sizeX, ball.sizeY)) {
      flag += 2;
    }
    if ((flag >> 1 & 1) == 1) {
      float theta = (PI / 4) * ( -1 * (center-ball.center) / (sizeX / 2));
      ball.theta = theta;
    }
    return flag;
  }
  boolean isHit(
    float x, float y, 
    float w, float h) {
    return
      posX < x+w &&
      x < posX+sizeX &&
      posY < y+h &&
      y < posY;
  }
}
