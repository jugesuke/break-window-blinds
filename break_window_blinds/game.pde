class Game {
  int gameFrame;
  int startFrame;
  // mainWindowのサイズ設定
  int mainWindowX = 384;
  int mainWindowY = 32;
  int mainWindowW = 864;
  int mainWindowH = 656;
  // Blockの設定
  int row = 9;
  int col = 46;
  int blocksX = 64;
  int blocksY = 176;
  int blockW = 16;
  int blockH = 16;
  // GameObjectの宣言
  Ball ball;
  Racket racket;
  Wall wall;
  Block[][] blocks;
  // ゲーム状態変数
  boolean isClear = false;
  boolean isPause = true;
  int score = 0;
  //画像の読み込み準備
  PImage window;
  BackGround backGround;
  //SubWindowObjectの宣言
  GameSubWindow subWindow;
  //BGM のobject
  //SoundPlayer sound;
  Game() {
    init();
    window = loadImage("img/window.png");
    subWindow = new GameSubWindow(racket, ball, 5);
    backGround = new BackGround(mainWindowX, mainWindowY, mainWindowW, mainWindowH, 304);
    //sound = new SoundPlayer();
    //sound.bgmPlay();
  }
  void run() {
    if (!isPause) {
      gameFrame = frameCount - startFrame;
    }
    if (18450 <= gameFrame && gameFrame < 20250) {
      float t1 = (float(gameFrame) - 18450.0) / 1800;
      backGround.upColor = lerpColor(color(101, 152, 218), color(148, 164, 189), t1);
      backGround.downColor = lerpColor(color(101, 152, 218), color(216, 165, 138), t1);
    } else if (20250 <= gameFrame && gameFrame < 22050) {
      float t2 = (float(gameFrame) - 20250.0) / 1800;
      backGround.upColor = lerpColor(color(148, 164, 189), color(7, 4, 10), t2);
      backGround.downColor = lerpColor(color(216, 165, 138), color(7, 4, 10), t2);
      backGround.turfColor = lerpColor(color(192, 238, 26), color(68, 84, 8), t2);
    }
    runMainWindow(gameFrame);
    subWindow.run(gameFrame);
  }
  void init() {
    //block の初期化
    blocks = new Block[col][row];
    for (int i = 0; i < col; ++i) {
      for (int j = 0; j < row; ++j) {
        blocks[i][j] = new Block(
          mainWindowX + blocksX + i * blockW, j * blockH + blocksY, 
          blockW, blockH, 1);
      }
    }
    //ball の初期化
    ball = new Ball(
      mainWindowX + mainWindowW / 2 - 16, mainWindowY + mainWindowH /2 - 16, 
      0, 0, 
      16, 2, 3);
    //racket の初期化
    racket = new Racket(
      mainWindowX + mainWindowW / 2, 624, 96, 16, 
      mainWindowX, mainWindowX+mainWindowW);
    //wall の初期化
    wall = new Wall(
      mainWindowX, mainWindowY, mainWindowW, mainWindowH, 
      mainWindowX + 64, mainWindowX + mainWindowW - 64, blocksY);
  }
  void runMainWindow(int frame) {
    //Refresh
    fill(231);
    noStroke();
    backGround.draw();
    image(window, mainWindowX + blocksX - 64, mainWindowY + blocksY - 80);
    //Blockの描画
    boolean check = true;
    for (Block[] r : blocks) {
      for (Block block : r) {
        if (block.life > 0) {
          check = false;
          block.draw();
          int flag = block.reflect(ball);
          if (flag > 0) {
            score += 100;
            block.life -= 1;
            subWindow.score += 100;
            subWindow.money += 1;
            if (ball.power > 0) {
              ball.power -= 1;
            } else {
              ball.reflect(flag, gameFrame);
            }
          }
        }
      }
    }
    //クリア判定
    if (check) {
      isClear = true;
    }
    //Ballの描画
    ball.draw(gameFrame);
    //Racketの描画
    racket.center = mouseX;
    racket.draw(gameFrame);
    ball.reflect(racket.reflect(ball), gameFrame);
    //壁の反射
    int wallF = wall.reflect(ball);
    ball.reflect(wallF, gameFrame);
    if (wallF == -1) {
      ball.life -= 1;
      initBall();
    }
    //左右のバー
    wall.draw();
    //クリア処理
    if (isClear) {
      showClear();
    }
    //ゲームオーバー
    if (ball.life <=0 || frame  > 23400) {
      showGameOver();
    }
  }
  void keyPressed() {
    subWindow.keyInput(key, gameFrame);
  }
  void initBall() {
    ball.posX = mainWindowX + mainWindowW / 2 - 16;
    ball.posY = mainWindowY + mainWindowH / 2 - 16;
    ball.theta = 0;
    ball.speed = 6;
  }
  void start() {
    isPause = false;
    ball.stop = false;
    ball.isShow = true;
    startFrame = frameCount;
    initBall();
  }
  void showClear() {
    isPause = true;
    ball.stop = true;
    ball.isShow = false;
    ball.speed = 0;
    int _score = subWindow.ballLife * 50 + (23400 - gameFrame) + score;
    fill(42);
    textFont(dotFont16_256);
    text("CLEAR", width / 2 - 144, height / 2 + 20);
    textFont(dotFont16_32);
    text("Score: " + _score, width / 2 + 104, height / 2 + 100);
  }
  void showGameOver() {
    isPause = true;
    ball.stop = true;
    ball.isShow = false;
    fill(42);
    textFont(dotFont16_128);
    text("GAME OVER", width / 2 - 112, height / 2 + 20);
  }
}

class GameSubWindow {
  //subWindowのサイズ設定
  int subWindowX = 48;
  int subWindowY = 160;
  int subWindowW = 288;
  int subWindowH = 528;
  //Object宣言
  Panel panel;
  Racket racket;
  Ball ball;
  //Store Object宣言
  Cafeteria cafeteria;
  Shop shop;
  VendingMachine vendingMachine;
  Secoma secoma;
  //Game状態を保存する変数
  int ballLife;
  //timer
  Timer timer;
  //ScoreとMoney
  int score = 0;
  int money = 800;
  GameSubWindow(Racket r, Ball b, int ballLife) {
    racket = r;
    ball = b;
    cafeteria = new Cafeteria(r, b);
    shop = new Shop(r, b);
    vendingMachine = new VendingMachine(r, b);
    secoma = new Secoma(r, b);
    this.ballLife = ballLife;
    timer = new Timer(dotFont16_128);
    panel = new Panel(dotFont16_48, dotFont16_32);
  }
  void run(int frame) {
    //Refresh
    fill(231);
    noStroke();
    rect(subWindowX, subWindowY, subWindowW, subWindowH);
    //timer
    timer.draw(32, 144, frame);
    //Panel
    panel.life = ball.life;
    panel.money = money;
    panel.draw(cafeteria, shop, vendingMachine, secoma, frame);
  }
  void keyInput(char pressedKey, int frame) {
    Item item;
    switch (pressedKey) {
    case '1':
      print("1: 竜田丼 ");
      item = new TatsutaDon(racket, ball);
      itemUse(cafeteria, item, frame);
      break;
    case '2':
      print("2: ラーメン ");
      item = new Ramen(racket, ball);
      itemUse(cafeteria, item, frame);
      break;
    case 'q':
      print("q: ナポリン ");
      item = new Juice(racket, ball);
      itemUse(shop, item, frame);
      break;
    case 'w':
      print("w: チョコ ");
      item = new Chocolate(racket, ball);
      itemUse(shop, item, frame);
      break;
    case 'a':
      print("a: コーヒー ");
      item = new Coffee(racket, ball);
      itemUse(vendingMachine, item, frame);
      break;
    case 'z':
      print("z: おにぎり ");
      item = new Onigiri(racket, ball);
      itemUse(secoma, item, frame);
      break;
    case 'x':
      print("x: カツ丼 ");
      item = new KatsuDon(racket, ball);
      itemUse(secoma, item, frame);
      break;
    }
  }
  void itemUse(Store store, Item item, int frame) {
    if (store.availabilityCheck(frame) && panel.money - item.cost > 0) {
      println("accepted");
      money -= item.cost;
      ball.life = item.run(ball.life, frame);
    } else {
      println("rejected");
    }
  }
}
