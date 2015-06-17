String [] trial;
void start(){
  
  trial = new String[0];
   
  for(int t=0; t<3; t++){
  
   int [] a = randomise();
   int [] b = randomise();
   int [] c = randomise();

  
  boolean done = false;
  while(!done){
    done = true;
  for(int i=0; i<b.length; i++){
    if(a[i] == b[i]){
      b = randomise();
      done= false;
    }
  }
  }
  
  
  done = false;
  while(!done){
    done = true;
  for(int i=0; i<b.length; i++){
    if(a[i] == c[i] || b[i] == c[i]  ){
      c = randomise();
      done= false;
    }
  }
  }
  
  
  
     
  for(int i=0; i<7; i++){
     String tempTrial =  a[i]+""+b[i]+""+c[i] ;       
     trial = append(trial,tempTrial);
  }
  
  for(int i=0; i<trial.length; i++){
      println(trial[i]);
  }
  
  }
//println(trial[0]);  
println(trial.length);

  // check there are no repetitions.
  for(int i=0; i< trial.length; i++){
    for(int j=0; j< trial.length; j++){
      if(trial[i] == trial[j] && i!=j)
      {
        println("same"+trial[i]+" "+trial[j]);
      }
   
    }
  }

}











int[] randomise() {
  
  int[] a = new int[7];
  a[0] = (int)random(0,7);
  for(int i = 1; i<a.length; i++){
  
   boolean done = false;
   int temp = (int)random(0,7);
   while(!done){
     done = true;
     
    for(int j = 0; j<i; j++){
     
      if(temp==a[j]){
        done = false;
        temp = (int)random(0,7);
      }  
    }
  }
   a[i] = temp;
  }
  return a;
}
  
