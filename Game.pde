class Game{
  Player[] players;
  //Map feild = new Map();
  
  int[][] map = new int[][]{
      {0,0,0,0,0,0,0,0},
      {0,0,1,0,1,0,1,0},
      {0,0,0,0,0,0,0,0},
      {0,1,0,1,0,1,0,1},
      {0,0,0,0,0,0,0,0},
      {1,0,1,0,1,0,1,0},
      {0,0,0,0,0,0,0,0},
      {1,1,1,1,1,1,1,1}
   };
  
  int tileSize = 20;
    
  Game(){
    
  }
  
  Game(int player){
    this.players = new Player[player];
    for(int i = 0; i < player; i++){
      players[i] = new Player(this, i+1, .05);
    }
  }
  
  boolean handleCollision(Player p, dir direction){
    
    for (int y = (int)Math.floor(p.getY())/tileSize; y < ((int)Math.ceil(p.getY())+p.getH()-1)/tileSize + 1; y++) {
      for (int x = (int)Math.floor(p.getX())/tileSize; x < ((int)Math.ceil(p.getX())+p.getW()-1)/tileSize + 1; x++) {
        
        if (y >= 0 && y < map.length && x >= 0 && x < map[y].length) {
          
          if (map[y][x] == 1) {
            switch (direction) {
                  case up:
                    p.setY( (y+1)*tileSize );
                    break;
                  case down: // down
                    p.setY( y*tileSize - p.getH() );
                    break;
                  case left: // left
                    p.setX( (x+1)*tileSize );
                    break;
                  case right: // right
                    p.setX( x*tileSize - p.getW() );
                    break;
            }
            return true;
          }
          
        }
        
      } 
    }
    return false;
  }
  
  void update(){
    players[0].update();
  }
  
  void keyDown(int val){
    players[0].keyAction(true, val);
  }
  
  void keyUp(int val){
    players[0].keyAction(false, val);
  }
  
  void display(){
    clear();
    //feild.display();
    players[0].display();
    
    for(int i = 0; i < map.length; i++){
      for(int j = 0; j < map[i].length; j++){
        if(map[i][j] == 1){
          fill(100,100,255);
          rect(tileSize*j,tileSize*i,tileSize,tileSize);
        }
      }
    }
  }
  
}
