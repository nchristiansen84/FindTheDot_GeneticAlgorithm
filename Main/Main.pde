Population persons;
Goal goal;
Barriers barriers;

void setup(){
  size(800, 800);
  persons = new Population(1000);
  goal = new Goal(400, 10);
  barriers = new Barriers(8);
  
  barriers.addBarrier(150, 200, 100, 10);
  barriers.addBarrier(350, 200, 100, 10);
  barriers.addBarrier(550, 200, 100, 10);
  barriers.addBarrier(250, 400, 100, 10);
  barriers.addBarrier(450, 400, 100, 10);
  barriers.addBarrier(150, 600, 100, 10);
  barriers.addBarrier(350, 600, 100, 10);
  barriers.addBarrier(550, 600, 100, 10);
}

void draw(){
  background(255);
  PFont f = createFont("Arial", 16, true);
    
  goal.show();
  barriers.show();
  
  if(persons.allPersonsDead()){
    // Genetic Algorithm
    persons.calcFitness();
    persons.naturalSelection();
    persons.mutate();
  }else{
    persons.update();
    persons.show();
  }
  
  textFont(f, 40);
  fill(100, 100, 100);
  text("Gen: "+persons.gen, 10, 40);
  text("Steps: "+persons.minSteps, 10, 80);
}
