import java.util.Scanner;

class Coord {
  int x, y;
  Coord(int x, int y) {
    this.x = x;
    this.y = y;
  }
}

class Join implements State {
  
  Client client = null;
  
  ArrayList<String> map = new ArrayList();
  ArrayList<Coord> players = new ArrayList();
  
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
      
      String coords = client.readString();
      while (coords.length() > 0) {
          String coord;
          
          int coordEnd = coords.indexOf(";");
          if (coordEnd == -1) {
            coordEnd = coords.length()-1;
          }
          
          coord = coords.substring(0, coordEnd);
          int sep = coord.indexOf(",");
          if (sep > 0 && sep < coord.length() - 2) {
            int coordX, coordY;
            try {
              coordX = parseInt(coord.substring(0, sep));
              coordY = parseInt(coord.substring(sep+1));
              players.add(new Coord(coordX, coordY));
            } catch (NumberFormatException e) {}
            
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
          fill(100,100,255);
          rect(tileSize*j,tileSize*i,tileSize,tileSize);
        }
      }
    }
    
    for (int i = 0; i < players.size(); i++) {
      Coord player = players.get(i);
      fill(200,30,30);
      rect((float)player.x, (float)player.y, pWidth, pHeight);
    }
    
    text("joined!", 10, 20);
    
  }
  void keyUp(int val) {
    client.write("u"+(char)val);
  }
  void keyDown(int val) {
    client.write("d"+(char)val);
  }
}
