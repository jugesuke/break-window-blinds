class Item {
  // 値段
  int cost;
  // Objects
  Racket racket;
  Ball ball;
  //Config
  int interval = 900;
  Item(Racket racket, Ball ball, int cost) {
    this.racket = racket;
    this.ball = ball;
    this.cost = cost;
  }
  void ballPowerIncrement(int frame) {
    ball.powerful = true;
    ball.powerfulEndFrameCount = frame + interval;
  }
  void racketWiden(int frame) {
    racket.big = true;
    racket.bigEndFrameCount = frame + interval;
  }
  int ballLifeIncrement(int ballLife, int inc) {
    return ballLife + inc;
  }
  void pause(int frame) {
    ball.pause = true;
    ball.pauseEndFrameCount = frame + interval;
  }
  int run(int ballLife, int frame) {
    return ballLife;
  }
}
class TatsutaDon extends Item {
  TatsutaDon(Racket racket, Ball ball) {
    super(racket, ball, 506);
  }
  int run(int ballLife, int frame) {
    println("use TatsutaDon");
    ballPowerIncrement(frame);
    ballLife = ballLifeIncrement(ballLife, 2);
    return ballLife;
  }
}
class Ramen extends Item {
  Ramen(Racket racket, Ball ball) {
    super(racket, ball, 440);
  }
  int run(int ballLife, int frame) {
    ballPowerIncrement(frame);
    racketWiden(frame);
    return ballLife;
  }
}
class Juice extends Item {
  Juice(Racket racket, Ball ball) {
    super(racket, ball, 118);
  }
  int run(int ballLife, int frame) {
    ballLife = ballLifeIncrement(ballLife, 1);
    return ballLife;
  }
}
class Chocolate extends Item {
  Chocolate(Racket racket, Ball ball) {
    super(racket, ball, 100);
  }
  int run(int ballLife, int frame) {
    racketWiden(frame);
    return ballLife;
  }
}
class Coffee extends Item {
  Coffee(Racket racket, Ball ball) {
    super(racket, ball, 150);
  }
  int run(int ballLife, int frame) {
    ballPowerIncrement(frame);
    return ballLife;
  }
}
class Onigiri extends Item {
  Onigiri(Racket racket, Ball ball) {
    super(racket, ball, 108);
  }
  int run(int ballLife, int frame) {
    ballLife = ballLifeIncrement(ballLife, 1);
    pause(frame);
    return ballLife;
  }
}
class KatsuDon extends Item {
  KatsuDon(Racket racket, Ball ball) {
    super(racket, ball, 540);
  }
  int run(int ballLife, int frame) {
    racketWiden(frame + interval);
    ballPowerIncrement(frame + interval);
    pause(frame);
    return ballLife;
  }
}
