class Population{
  Person[] persons;
  float fitnessSum;
  int gen = 1;
  int bestPerson = 0;
  int minSteps = 400;
  
  Population(int size){
    persons = new Person[size];
    
    for(int i = 0; i < size; i++){
      persons[i] = new Person();
    }
  }
  
  //---------------------------------------------------
  void show(){
    for(int i = 1; i < persons.length; i++){
      if(persons[i].brain.step > minSteps){
        persons[i].dead = true;
      }else{
        persons[i].show();
      }
    }
    persons[0].show();
  }
  
  //---------------------------------------------------
  void update(){
    for(int i = 0; i < persons.length; i++){
      persons[i].update();
    }
  }
  
  //---------------------------------------------------
  void calcFitness(){
    for(int i = 0; i < persons.length; i++){
      persons[i].calcFitness();
    }
  }
  
  void calcFitnessSum(){
    fitnessSum = 0;
    for(int i = 0; i < persons.length; i++){
      fitnessSum += persons[i].fitness;
    }
  }
  
  //---------------------------------------------------
  boolean allPersonsDead(){
    for(int i = 0; i < persons.length; i++){
      if(!persons[i].dead && !persons[i].reachedGoal){
        return false;
      }
    }
    
    return true;
  }
  
  //---------------------------------------------------
  void naturalSelection(){
    Person[] nextGen = new Person[persons.length];
    
    saveBestPerson();
    calcFitnessSum();
    
    nextGen[0] = persons[bestPerson].createChild();
    nextGen[0].isBest = true;
    for(int i = 1; i < nextGen.length; i++){
      // Select Parent from Fitness
      Person parent = selectParent();
      
      // Create Child
      nextGen[i] = parent.createChild();
    }
    
    persons = nextGen.clone();
    gen++;
    println("Gen:", gen);
  }
  
  Person selectParent(){
    float rand = random(fitnessSum);
    float runningSum = 0;
    
    for(int i = 0; i < persons.length; i++){
      runningSum += persons[i].fitness;
      if(runningSum > rand){
        return persons[i]; 
      }
    }
    
    // Should never reach
    return null;
  }
  
  void saveBestPerson(){
    float max = 0;
    int maxIndex = 0;
    
    for(int i = 0; i < persons.length; i++){
      if(persons[i].fitness > max){
        max = persons[i].fitness;
        maxIndex = i;
      }
    }
    
    bestPerson = maxIndex;
    
    if(persons[bestPerson].reachedGoal){
      minSteps = persons[bestPerson].brain.step;
      println("Steps:", minSteps);
    }
  }
  //---------------------------------------------------
  void mutate(){
    for(int i = 1; i < persons.length; i++){
      persons[i].brain.mutate();
    }
  }
}
