class Game{
  Player[] players;
  Map feild = new Map();
    
  Game(){
    
  }
  Game(int player){
    this.players = new Player[player];
    for(int i = 0; i < player; i++){
      players[i] = new Player(i+1, .05);
    }
  }
  
  void update(){
    players[0].update();
  }
  
  void keyDown(int val){
    players[0].keyAction(true, val);
    System.out.println("two");
  }
  
  void keyUp(int val){
    players[0].keyAction(false, val);
  }
  
  void display(){
    clear();
    feild.display();
    players[0].display();
  }
  
}
