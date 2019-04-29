class Title implements State {
  
  Title() {
  }
  
  void update() {
    
  }
  void display() {
    clear();
    textFont(f, 16);
    text("Press 1 to host", 10, 20);
    text("Press 2 to join", 10, 50);
  }
  void keyUp(int val) {
    
  }
  void keyDown(int val) {
    switch (val) {
      case '1':
        gameState = new Game();
        setState(gameState);
        break;
      case '2':
        joinState = new Join();
        setState(joinState);
        break;
    }
  }
}
