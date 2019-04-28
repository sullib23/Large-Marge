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
  
  boolean touchingGround = true;
  
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
  
  void setX(double x) { xPos = x; }
  void setY(double y) { yPos = y; }
  
  Player(Game game, int number, double speed){
    this.game = game;
    this.number = number;
    acc = speed;
  }
  
  void keyAction(boolean down, int val){
      if(val == 'W' && down && touchingGround){ ySpeed -= jumpForce; touchingGround = false; }
      if(val == 'A'){ left = down; }
      if(val == 'S'){ crouch = down; }
      if(val == 'D'){ right = down; }
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
    
  }
  
  void display(){
    fill(200,30,30);
    rect((float)xPos, (float)yPos, pWidth, pHeight);
  }
}
