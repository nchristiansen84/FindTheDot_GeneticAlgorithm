class Barrier{
  PVector pos;
  int recLength = 10;
  int recWidth = 10;

  Barrier(int x, int y, int sizeX, int sizeY){
    pos = new PVector(x, y);
    
    if(sizeX != 0){
      recLength = sizeX;
    }
      
    if(sizeY != 0){
      recWidth = sizeY;
    }
  }
 
  //---------------------------------------------------
  void show(){
    fill(0, 0, 255);
    rect(pos.x, pos.y, recLength, recWidth);
  }
}
