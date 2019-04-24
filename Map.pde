class Map{
  
  int[][] map = new int[][]{
                          {0,0,0,0,0,0,0,0},
                          {1,0,1,0,1,0,1,0},
                          {0,0,0,0,0,0,0,0},
                          {0,1,0,1,0,1,0,1},
                          {0,0,0,0,0,0,0,0},
                          {1,0,1,0,1,0,1,0},
                          {0,0,0,0,0,0,0,0},
                          {1,1,1,1,1,1,1,1}
                       };
  int size = height/map.length;
  Map(){
    
  }
  void display(){
    for(int i = 0; i < map.length; i++){
      for(int j = 0; j < map[i].length; j++){
        if(map[i][j] == 1){
          fill(100,100,255);
          rect(size*j,size*i,size,size);
        }
      }
    }
  }
}
