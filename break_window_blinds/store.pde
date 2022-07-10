class Store {
  // Object
  Racket racket;
  Ball ball;
  // 営業時間 (フレーム)
  int open;
  int close;
  Store(Racket racket, Ball ball, int open, int close) {
    this.racket = racket;
    this.ball = ball;
    this.open = open;
    this.close = close;
  }
  boolean availabilityCheck(int frame) {
    if (open <= frame && frame < close) {
      return true;
    } else {
      return false;
    }
  }
}
class Cafeteria extends Store {
  Cafeteria(Racket racket, Ball ball) {
    super(racket, ball, 6300, 9000);
  }
}
class Shop extends Store {
  Shop(Racket racket, Ball ball) {
    super(racket, ball, 4500, 16200);
  }
}
class VendingMachine extends Store {
  VendingMachine(Racket racket, Ball ball) {
    super(racket, ball, 0, 0);
  }
  boolean availabilityCheck(int frame) {
    return true;
  }
}
class Secoma extends Store {
  Secoma(Racket racket, Ball ball) {
    super(racket, ball, 0, 0);
  }
  boolean availabilityCheck(int frame) {
    return true;
  }
}
