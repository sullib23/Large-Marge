class Player{
  double xPos, yPos, ySpeed = 0, xSpeed = 0, walkSpeed;
  int weapon, number;
  boolean left = false, right = false, crouch = false;
  
  Player(){
    walkSpeed = 0.05;
  }
  Player(int number, double speed){
    this.number = number;
    walkSpeed = speed;
  }
  
  void keyAction(boolean down, int val){
      if(val == 'W' && down && collide(1)){ ySpeed += 1; }
      if(val == 'A'){ left = down; }
      if(val == 'S'){ crouch = down; }
      if(val == 'D'){ right = down; }
  }
  
  boolean collide(int side){
    
    return false;
  }
  
  void update(){
    if(left == true && xSpeed < 1){  xSpeed += walkSpeed;  }
    if(left == false && xSpeed > 0){  xSpeed -= walkSpeed;  }
    if(right == true && xSpeed > -1){  xSpeed -= walkSpeed;  }
    if(right == false && xSpeed <= 0){  xSpeed += walkSpeed;  }
    //if(!collide()){
      
    //}
    xPos += xSpeed;
    
  }
  
  void display(){
    fill(200,30,30);
    rect((float)xPos, (float)yPos, 20.0, 20.0);
  }
}
