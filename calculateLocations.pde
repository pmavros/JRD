public void calculateLocations(){
  
  for(int j = 0; j<1; j++){
    // calculate three blocks of seven trials
    
    int[] startLocation = new int[0];
    
    for(int i=0; i<7; i++){
     
      int a,b,c;
    
       a = (int) random(0,7);
       
       b = (int) random(0,7);
       c = (int) random(0,7);
     
       boolean inStartLocationArray = false;
       boolean startLocationOK = false;

int[] kc = new int[7];

for (int f = 0; f<kc.length; f++)
{

 kc[f] = 8;
}

for (int f = 0; f<kc.length; f++)
{
  
  int o = (int) random(0,7);
  while(o==kc[f]){
      o = (int) random(0,7);
  }
  kc[f] = o;
  
    println("o "+o);
  
}

for (int f = 0; f<kc.length; f++)
{

 println(kc[f]);
}



//    
//   while(!startLocationOK){
//     
//      for(int s = 0; s < startLocation.length; s++){
//      if(startLocation[s] == a){
//        inStartLocationArray = true;
//      }
//    }      
//     
//    if(inStartLocationArray){
//      a = (int) random(0,7);
//    } else {
//      startLocationOK = true;
//      startLocation = append(startLocation, a);
//    } 
//     
//   }
//    while(a == startLocation[s]) {
//      a = (int) random(0,7);
//    }

//    startLocation[i] = a;
      
    while(a==b) {
      b = (int) random(0,7);
    }
    
    while(a==c || b==c) {
      c = (int) random(0,7);
    }
    
    println(a+" "+b+" "+c);
  }
  }

}
