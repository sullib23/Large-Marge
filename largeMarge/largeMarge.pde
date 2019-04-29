import processing.net.*;

State state;

void setState(State s) {
  state = s;
}

Game gameState;
Title titleState;
Join joinState;

PApplet parent = null;

PFont f;

void setup(){
  
  parent = this;
  
  titleState = new Title();
  
  size(400,400);
  state = titleState;
  background(100,40,60);
  f = createFont("Arial", 16);
}

void keyPressed(){
  state.keyDown(keyCode);
}

void keyReleased(){
  state.keyUp(keyCode);
}

void draw(){
  state.display();
  state.update();
}

void serverEvent(Server server, Client client) {
  //System.out.println("sjfkdjsfl");
  gameState.addPlayer(client);
}

void disconnectEvent(Client client) {
  
  if (state == gameState) {
    gameState.removePlayer(client);
  }
  
}
