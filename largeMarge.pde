Game game;
Map map;

void setup(){
  size(400,400);
  game = new Game(2);
  background(100,40,60);
}

void keyPressed(){
  game.keyDown(keyCode);
  System.out.println("one");
}

void keyReleased(){
  game.keyUp(keyCode);
}

void draw(){
  game.display();
  game.update();
}
