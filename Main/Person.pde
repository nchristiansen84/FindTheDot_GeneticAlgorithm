class Person{
  PVector pos;
  PVector vel;
  PVector acc;
  
  Brain brain;
  boolean dead = false;
  float fitness = 0;
  boolean reachedGoal = false;
  boolean isBest = false;
  
  Person(){
    brain = new Brain(400);
    
    pos = new PVector(width/2, height-10);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  //---------------------------------------------------
  void show(){
    if(isBest){
      fill(0,255,0);
      ellipse(pos.x, pos.y, 4, 4);
    }else{
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }
  
  void move(){
    if(brain.directions.length > brain.step){
      acc = brain.directions[brain.step];
      brain.step++;
    }else{
      dead = true;
    }
    
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }
  
  void update(){
    if(!dead && !reachedGoal){
      move();
      if(pos.x < 2 || pos.y < 2 || pos.x > width-2 || pos.y > height-2){
        // Reached End of Screen
        dead = true;
      }else if(dist(pos.x, pos.y, goal.pos.x, goal.pos.y) < 5){
        // Reached Goal
        reachedGoal = true;
      }
      
      for(int i = 0; i<barriers.curBarriers; i++){
        if(pos.x > barriers.barriers[i].pos.x && pos.y > barriers.barriers[i].pos.y && pos.x < barriers.barriers[i].pos.x+barriers.barriers[i].recLength && pos.y < barriers.barriers[i].pos.y+barriers.barriers[i].recWidth){
          dead = true;
        }
      }
    }
  }
  
  //---------------------------------------------------
  void calcFitness(){
    if(reachedGoal){
      fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
    }else{
      float distanceToGoal = dist(pos.x, pos.y, goal.pos.x, goal.pos.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }
  
  //---------------------------------------------------
  Person createChild(){
    Person child = new Person();
    child.brain = brain.clone();
    return child;
  }  
}
