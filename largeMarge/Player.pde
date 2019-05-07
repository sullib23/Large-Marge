enum dir {
  up,
  down,
  left,
  right
}

class Player{
  double xPos, yPos, ySpeed = 0, xSpeed = 0, acc, maxSpeed = 1.0, gravity = 0.098, jumpForce = 6;
  int weapon, number;
  boolean left = false, right = false, crouch = false;
  
  boolean direction; // true = left
  
  boolean touchingGround = true;
  
  int health = 100;
  
  Client client = null;
  
  Game game;
  
  int pWidth = 10; // size in pixels
  int pHeight = 10; // size in pixels
  
  Player(Game game){
    this.game = game;
    acc = 0.05;
  }
  
  int getW() { return pWidth; }
  int getH() { return pHeight; }
  
  double getX() { return xPos; }
  double getY() { return yPos; }
  
  int getHealth() { return health; }
  
  void setX(double x) { xPos = x; }
  void setY(double y) { yPos = y; }
  
  Player(Game game, int number, double speed){
    this.game = game;
    this.number = number;
    acc = speed;
  }
  
  void keyAction(boolean down, int val){
    switch (val) {
      case 'W':
        if (down && touchingGround) {
          ySpeed -= jumpForce;
          touchingGround = false;
        }
        break;
      case 'A':
        left = down;
        direction = true;
        break;
      case 'S':
        crouch = down;
        break;
      case 'D':
        right = down;
        direction = false;
        break;
      case ' ':
        double bulletX = direction ? (xPos-1) : (xPos+pWidth+1);
        game.addBullet(new Bullet(bulletX, yPos, direction));
        break;
    }
  }
  
  void update(){
    if(right && xSpeed < maxSpeed){ xSpeed = Math.min(xSpeed + acc, maxSpeed);  }
    if(!right && xSpeed > 0){  xSpeed = Math.max(xSpeed - acc, 0);  }
    if(left && xSpeed > -maxSpeed){  xSpeed = Math.max(xSpeed - acc, -maxSpeed);  }
    if(!left && xSpeed < 0){ xSpeed = Math.min(xSpeed + acc, 0);  }
    
    if (xSpeed != 0) {
      xPos += xSpeed;
      if (game.handleCollision(this, xSpeed < 0 ? dir.left : dir.right)) {
        xSpeed = 0;
      }
    }
    
    ySpeed += gravity;
    
    if (ySpeed != 0) {
      yPos += ySpeed;
      
      if (ySpeed > 0) {
        touchingGround = game.handleCollision(this, dir.down);
        if (touchingGround) {
          ySpeed = 0;
        }
      } else {
        touchingGround = false;
        if (game.handleCollision(this, dir.up)) {
          ySpeed = 0;
        }
      }
      
    }
    
    
    for (int i = 0; i < game.bullets.size(); i++) {
      Bullet b = game.bullets.get(i);
      if (b.x >= xPos && b.y >= yPos && b.x <= xPos + pWidth && b.y <= yPos + pHeight) {
        health--;
      }
    }
    
  }
  
  void display(){
    fill(200,30,30);
    stroke(0,0,0);
    rect((float)xPos, (float)yPos, pWidth, pHeight);
      fill(255, 255, 0);
      text(health, (float)xPos, (float)yPos - 10);
  }
}
