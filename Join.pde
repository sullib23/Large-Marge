import java.util.Scanner;

class Join implements State {
  
  Client client = null;
  
  Join() {
    connect();
  }
  
  void connect() {
    //clear();
    //text("enter the ip in the console", 10, 20);
    String ip = "127.0.0.1";
    
    boolean success = false;
    do {
      System.out.println("Please enter the host ip");
      client = new Client(parent, ip, 1337);
      if (client.active()) {
        success = true;
      } else {
        System.out.println("Error, please try again!");
        exit();
        //return;
      }
    } while (!success);
    
    
  }
  
  void update() {
    client.write("hello");
    
  }
  void display() {
    clear();
    text("joined!", 10, 20);
  }
  void keyUp(int val) {
    
  }
  void keyDown(int val) {
    
  }
}
