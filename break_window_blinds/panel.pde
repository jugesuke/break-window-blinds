class Panel {
  // Font
  PFont fontScore;
  PFont fontMenu;
  // 表示内容
  int life = 0;
  int money = 0;
  Panel(PFont fontScore, PFont fontMenu) {
    this.fontScore = fontScore;
    this.fontMenu = fontMenu;
  }
  void draw(Store s1, Store s2, Store s3, Store s4, int frame) {
    drawScores(life, money);
    drawMenus(
      s1.availabilityCheck(frame), 
      s2.availabilityCheck(frame), 
      s3.availabilityCheck(frame), 
      s4.availabilityCheck(frame));
  }
  void drawScores(int life, int money) {
    textFont(fontScore);
    fill(42);
    text("○×" + life, 64, 208);
    text("Money", 64, 256);
    text(money + "pt", 192, 256);
  }
  void drawMenus(
    boolean cafe, boolean store, 
    boolean vendingMachine, boolean secoma) {
    textFont(fontMenu);
    //食堂
    int x = 64;
    int y = 304;
    text("食堂", x, y);
    if (cafe) {
      text("1:竜田丼", x+8, y+32);
      text("506pt", 240, y+32);
      text("2:ラーメン", x+8, y+64);
      text("440pt", 240, y+64);
    } else {
      text("Close", x+8, y+32);
    }
    //購買
    y += 112;
    text("購買", x, y);
    if (store) {
      text("q:ナポリン", x+8, y+32);
      text("118pt", 240, y+32);
      text("w:チョコ", x+8, y+64);
      text("100pt", 240, y+64);
    } else {
      text("Close", x+8, y+32);
    }
    //自動販売機
    y += 112;
    text("自動販売機", x, y);
    if (vendingMachine) {
      text("a:コーヒー", x+8, y+32);
      text("150pt", 240, y+32);
    } else {
      text("Close", x+8, y+32);
    }
    //コンビニ
    y += 80;
    text("コンビニ", x, y);
    if (secoma) {
      text("z:おにぎり", x+8, y+32);
      text("108pt", 240, y+32);
      text("x:カツ丼", x+8, y+64);
      text("540pt", 240, y+64);
    } else {
      text("Close", x+8, y+32);
    }
  }
}
