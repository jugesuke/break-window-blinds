class GameObject {
  // 左上座標
  float posX, posY;
  // サイズ
  float sizeX, sizeY;
  GameObject(
    float posX, float posY, 
    float sizeX, float sizeY) {
    this.posX = posX;
    this.posY = posY;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  boolean isHit(
    float x, float y, 
    float w, float h) {
    return
      posX < x+w &&
      x < posX+sizeX &&
      posY < y+h &&
      y < posY+sizeY;
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
    return flag;
  }
}
