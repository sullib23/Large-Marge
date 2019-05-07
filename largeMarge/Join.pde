import java.util.Scanner;

class Coord {
  int x, y;
  Coord(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class CPlayer {
  int x, y;
  String health;
  CPlayer(int x, int y, String health) {
    this.x = x;
    this.y = y;
    this.health = health;
  }
}

class Join implements State {
  
  Client client = null;
  
  ArrayList<String> map = new ArrayList();
  ArrayList<CPlayer> players = new ArrayList();
  ArrayList<Coord> bullets = new ArrayList();
  
  int tileSize = 50;
  int pWidth = 10; // size in pixels
  int pHeight = 10; // size in pixels
  
  Join() {
    connect();
  }
  
  void connect() {
    //clear();
    //text("enter the ip in the console", 10, 20);
    String ip = "127.0.0.1";
    
    client = new Client(parent, ip, 1337);
    if (!client.active()) {
      System.out.println("Error, please try again!");
      exit();
    }
    
    while(client.available() < 1) {
      // wait for map to load
    }
    
    String mapData = client.readString();
    while (mapData.length() > 0) {
      String row;
      
      int rowEnd = mapData.indexOf(";");
      if (rowEnd == -1) {
        rowEnd = mapData.length()-1;
      }
      
      row = mapData.substring(0, rowEnd);
      map.add(row);
      
      mapData = mapData.substring(rowEnd + 1);
    }
    
  }
  
  void update() {
    if (client.available() > 0) {
      
      players.clear();
      bullets.clear();
      
      String coords = client.readString();
      while (coords.length() > 0) {
          
          int coordEnd = coords.indexOf(";");
          if (coordEnd == -1) {
            coordEnd = coords.length()-1;
          }
          
          String coord = coords.substring(0, coordEnd);
          
          // put all comma separated values into an arrayList
          ArrayList<String> values = new ArrayList();
          while (coord.length() > 0) {
            int sep = coord.indexOf(",");
            
            if (sep == -1) {
              values.add(coord);
              coord = "";
            } else {
              values.add(coord.substring(0, sep));
              coord = coord.substring(sep+1);
            }
            
          }
          
          switch (values.get(0)) {
            case "p":
              int playerX, playerY, playerHealth;
              try {
                playerX = parseInt(values.get(1));
                playerY = parseInt(values.get(2));
                players.add(new CPlayer(playerX, playerY, values.get(3)));
              } catch (NumberFormatException e) {}
              break;
            case "b":
              int bulletX, bulletY;
              try {
                bulletX = parseInt(values.get(1));
                bulletY = parseInt(values.get(2));
                bullets.add(new Coord(bulletX, bulletY));
              } catch (NumberFormatException e) {}
              break;
              
              
          }
          
          coords = coords.substring(coordEnd + 1);
       }
    }
    
    
    
  }
  
  
  void display() {
    clear();
    
    for(int i = 0; i < map.size(); i++){
      for(int j = 0; j < map.get(i).length(); j++){
        if(map.get(i).charAt(j) == '1'){
          stroke(255,200,200);
          fill(100,100,255);
          rect(tileSize*j,tileSize*i,tileSize,tileSize);
        }
      }
    }
    
    for (int i = 0; i < players.size(); i++) {
      CPlayer player = players.get(i);
      stroke(0,0,0);
      fill(200,30,30);
      rect((float)player.x, (float)player.y, pWidth, pHeight);
      fill(255, 255, 0);
      text(player.health, player.x, player.y - 10);
    }
    
    for (int i = 0; i < bullets.size(); i++) {
      Coord bullet = bullets.get(i);
      fill(0,255,0);
      stroke(0,255,0);
      rect((float)bullet.x, (float)bullet.y, 1, 1);
    }
    
    fill(255, 0, 0);
    text("joined!", 10, 20);
    
  }
  void keyUp(int val) {
    client.write("u"+(char)val);
  }
  void keyDown(int val) {
    client.write("d"+(char)val);
  }
}
