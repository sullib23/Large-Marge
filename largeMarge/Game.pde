class Game implements State {
  
  Server server = null;
  
  ArrayList<Player> players = new ArrayList();
  //Map feild = new Map();
  
  String serverIP = Server.ip();
  
  void addPlayer(Client client) {
    Player player = new Player(this);
    player.client = client;
    players.add(player);
    client.write(mapToString(map));
  }
  
  void removePlayer(Client client) {
    for (int i = 0; i < players.size(); i++) {
      if (players.get(i).client == client) {
        players.remove(i);
        break;
      }
    }
  }
  
  ArrayList<String> map = new ArrayList();
  
  int tileSize = 50;
    
  Game(){
    players.add(new Player(this));
    server = new Server(parent, 1337);
    loadMap(map, "map.txt");
  }
  
  boolean handleCollision(Player p, dir direction){
    
    for (int y = (int)Math.floor(p.getY())/tileSize; y < ((int)Math.ceil(p.getY())+p.getH()-1)/tileSize + 1; y++) {
      for (int x = (int)Math.floor(p.getX())/tileSize; x < ((int)Math.ceil(p.getX())+p.getW()-1)/tileSize + 1; x++) {
        
        if (y >= 0 && y < map.size() && x >= 0 && x < map.get(y).length()) {
          
          if (map.get(y).charAt(x) == '1') {
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
    
    String playerCoords = "";
    for (int i = 0; i < players.size(); i++) {
      players.get(i).update();
      playerCoords += players.get(i).getX() + "," + players.get(i).getY() + ";";
    }
    
    server.write(playerCoords);
    
    Client client = server.available();
    // If the client is not null, and says something, display what it said
    while (client !=null) {
    
      for (int i = 1; i < players.size(); i++) {
        
        if (players.get(i).client == client) {
          
          String inputs = client.readString();
          while (inputs.length() > 0) {
            char inputType = inputs.charAt(0);
            if (inputs.length() >= 2) {
              switch(inputType) {
                case 'd':
                case 'u':
                  players.get(i).keyAction(inputType == 'd', inputs.charAt(1));
                  inputs = inputs.substring(2);
                  break;
                default:
                  inputs = inputs.substring(1);
              }
              
            } else {
              inputs = "";
            }
          }
          
          break;
        }
        
      }
      
      client = server.available();
      
    }
  }
  
  void keyDown(int val){
    players.get(0).keyAction(true, val);
  }
  
  void keyUp(int val){
    players.get(0).keyAction(false, val);
  }
  
  void display(){
    clear();
    //feild.display();
    //players.get(0).display();
    
    for(int i = 0; i < map.size(); i++){
      for(int j = 0; j < map.get(i).length(); j++){
        if(map.get(i).charAt(j) == '1'){
          fill(100,100,255);
          rect(tileSize*j,tileSize*i,tileSize,tileSize);
        }
      }
    }
    
    for (int i = 0; i < players.size(); i++) {
      players.get(i).display();
    }
    
    text("Host ip: " + serverIP, 10, 20);
  
    
  }
  
}
