class Ball extends GameObject {
  // 極座標速度
  float speed, theta;
  // 円の径
  float extent;
  // 中心x座標
  float center;
  // 一回に消えるブロック数の設定
  int maxPower;
  int power;
  // ボールの残機
  int life;
  // 一回に消えるブロック数の変更用
  boolean powerful;
  int defaultMaxPower;
  int powerfulEndFrameCount;
  // 表示切り替え
  boolean stop = true;
  boolean isShow = false;
  boolean pause = false;
  // セコマ用変数
  int pauseEndFrameCount;
  Ball(
    float posX, float posY, 
    float speed, float theta, 
    float extent, int power, int life) {
    super(posX, posY, extent, extent);
    this.speed = speed;
    this.theta = theta;
    this.extent = extent;
    this.center = posX + extent/2;
    maxPower = power;
    defaultMaxPower = maxPower;
    this.power = power;
    this.life = life;
  }
  void draw(int frame) {
    //powerfulのとき色を変更
    if (powerful) {
      fill(35, 170, 242);
    } else {
      fill(255);
    }
    stroke(0);
    //pause stop のときボールを止める
    if (stop || pause) {
      speed = 0;
    } else if (!pause) {
      speed = 6;
    }
    if (isShow) {
      circle(posX + extent/2, posY + extent/2, extent);
    }
    //極座標から直交座標に変換
    posX += speed * sin(theta);
    posY += speed * cos(theta);
    center = posX + extent/2;
    //pauseを元に戻す
    if (pause) {
      if (pauseEndFrameCount < frame) {
        pause = false;
      }
    }
  }
  void reflect(int flag, int frame) {
    // flag: 跳ね返らないとき: 0 00(2)
    //          x軸方向に反射: 1 01(2)
    //          y軸方向に反射: 2 10(2)
    //        x,y軸方向に反射: 3 11(2)
    if (flag > 0) {
      power = maxPower;
    }
    if (flag == -1) {
      speed = 0;
    }
    if ((flag >> 0 & 1) == 1) {
      theta = -theta;
    }
    if ((flag >> 1 & 1) == 1) {
      theta = PI - theta;
    }
    //power調整
    if (powerful) {
      maxPower = defaultMaxPower * 2;
      if (powerfulEndFrameCount < frame) {
        maxPower = defaultMaxPower;
        power = min(defaultMaxPower, power);
        powerful = false;
      }
    }
  }
}
