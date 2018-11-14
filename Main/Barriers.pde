class Barriers{
  Barrier[] barriers;
  int curBarriers;
  
  Barriers(int size){
    barriers = new Barrier[size];
  }
  
  //---------------------------------------------------
  void addBarrier(int x, int y, int sizeX, int sizeY){
    barriers[curBarriers] = new Barrier(x, y, sizeX, sizeY);
    
    curBarriers++;
  }
  
  //---------------------------------------------------
  void show(){
    for(int i = 0; i < curBarriers; i++){
      barriers[i].show();
    }
  }
}
