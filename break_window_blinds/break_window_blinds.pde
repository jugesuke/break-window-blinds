Game game;
// Font
PFont dotFont16_256;
PFont dotFont16_128;
PFont dotFont16_80;
PFont dotFont16_48;
PFont dotFont16_32;
// fps設定
int fps = 60;
// page設定
String page = "start";
void setup() {
  size(1280, 720);
  String dotFont = "font/JF-Dot-Shinonome16.ttf";
  dotFont16_256 = createFont(dotFont, 256);
  dotFont16_128 = createFont(dotFont, 128);
  dotFont16_80 = createFont(dotFont, 80);
  dotFont16_48 = createFont(dotFont, 48);
  dotFont16_32 = createFont(dotFont, 32);
  game = new Game();
  frameRate(fps);
}

void draw() {
  background(42);
  //ゲームを起動
  game.run();
  switch (page) {
  case "start":
    fill(255);
    rect(width / 2 - 112 - 4, height / 2 - 80, 560 + 4, 100);
    rect(width / 2 - 4, height / 2 + 100 - 32, 320 + 4, 40);
    fill(42);
    textFont(dotFont16_80);
    text("ブラインド崩し", width / 2 - 112, height / 2);
    textFont(dotFont16_32);
    text("Press SPACE to Start", width / 2, height / 2 + 100);
    break;
  case "game":
    break;
  }
}

void keyPressed() {
  switch (page) {
  case "start":
    if (key == ' ') {
      page = "game";
      //ゲームの開始
      game.start();
    }
    break;
  case "game":
    game.keyPressed();
    break;
  }
}
