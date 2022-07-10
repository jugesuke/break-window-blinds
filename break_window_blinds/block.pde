class Block extends GameObject {
  // ブロックの残機
  int life;
  Block(
    float posX, float posY, 
    float sizeX, float sizeY, int life) {
    super(posX, posY, sizeX, sizeY);
    this.life = life;
  }
  void draw() {
    fill(255);
    stroke(0);
    rect(posX, posY, sizeX, sizeY);
  }
}
