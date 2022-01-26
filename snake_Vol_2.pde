//Generar el espacio para la snake
ArrayList<Integer> pX =  new ArrayList<Integer>();
ArrayList<Integer> pY =  new ArrayList<Integer>();

//Direcciones de la snake
char op;//casos de direcciones
int [] dirX  = {0,0,-1,1};//movimiento en x
int [] dirY = {-1,1,0,0};//movimiento en y

//valores para el mapa(bordes)
//R: horizontal/fila
//C: vertical/columna
float R0a=50,R0b=550,R1=550,C0a=50,C0b=550,C1=550;

//Datos del score
int score=0, total_apple=0,crono=60,life=3;

boolean go, gameOver=false,timer=false;
int dir, w=25,h=25, max_size = 500,time = 0, v=20;

//Fruta
int appleX, appleY;
int R=231, G=15,B=15;//Colores para la fruta

void setup(){
 size(600,600);
  frameRate(10);
  //Dar las coordenas iniciales de la snake
  pX.add(15);
  pY.add(15);
  
  //Dar las coordenas iniciales de la fruta
  appleX = (int)random(5,w);
  appleY = (int)random(5,h);
}

void draw(){
  if (gameOver==true){
    
    if(life < 0){ GameOver();}//Ya no hay vidas
    else{restart();}//si aún tiene vidas
   
  }else{
    background(0);
    textAlign(LEFT); //score
    textSize(25);
    fill(255);
    text("Score: " + score, 10, 10, width - 20, 50);
    text("Manzanas: "+ total_apple, 120,10,width-20,50);
    text("Vidas Perdidas: "+life,260,10,width-20, 50);
    text("Tiempo: "+crono, 460,10, width -20, 50);
    world();
    snake();
    move();
    apple();
    eat();
    death();
    timer();
    addBody();
  }
}
void snake(){
  stroke(0,86,0);//Dar color al perimetro de la snake
  fill(0, 255, 0);//Dar color al centro de la snake
  //Dibuar la snake 
  for(int i = 0; i < pX.size(); i++){
    rect(pX.get(i)*v,pY.get(i)*v,v,v);
  }
}
void erase(){
  //Agregar un nuevo elemento
    pX.add(0, pX.get(0)+dirX[dir]);
    pY.add(0, pY.get(0)+dirY[dir]);
    //Remover el ultimo elemento
    pX.remove(pX.size()-1);
    pY.remove(pY.size()-1);
}
void apple(){
  //color
  stroke(R,G,B);
  fill(R,G,B);
  //forma
  ellipse(appleX*v+10,appleY*v+10,v,v);
}
void eat(){
  if((pX.get(0)==appleX && pY.get(0)==appleY)){
    //Nueva ubicacion de la fruta
    appleX = (int)random(5,w);
    appleY = (int)random(5,h);
    //Nuevo color fruta
    R=(int)random(255);G=(int)random(255);B=(int)random(255);
    //Aumentar tamaño snake
    pX.add(pX.get(pX.size()-1));
    pY.add(pY.get(pY.size()-1));
    //Score
    score+=5;
    total_apple ++;
  }
}
void death(){
  for (int i=2; i<pX.size(); i++){ 
     if (pX.get(0)== pX.get(i)&& pY.get(0)== pY.get(i)) 
       gameOver=true; 
    }
    //restar vidas
   if(gameOver==true){life-=1;}
}
void GameOver(){
  background(0);
  fill(16, 191, 2); 
  textSize(80); 
  textAlign(CENTER); 
  text("\nGAME OVER", width/2, height/5);
  textSize(15);
  textAlign(CENTER);
  text("\n\n\n\nPUNTUACION: "+score + "\nMANZANAS COMIDAS: "+ total_apple,width/2, height/3);
  textSize(20);
  text("\n\n\n\n\n\nPRESIONA  [ENTER]  PARA CONTINUAR...",width/2, height/2);
  if (keyCode == ENTER) { 
    pX.clear(); 
    pY.clear(); 
    pX.add(15);
    pY.add(15);
    
    appleX = (int)random(5,w);
    appleY = (int)random(5,h);
    R=(int)random(255);G=(int)random(255);B=(int)random(255);
    
    gameOver = false;
    go=false;
    op = ' ';
    score=0;
    total_apple=0;
    crono=60;
    timer=false;
    life = 3;
  }
} 
void borde(){
  if(pX.get(0)<3||pY.get(0)<3||pX.get(0)>=27 || pY.get(0)>=27){
    gameOver=true;
  }
}
void move(){
  if(go){
    if(op=='d'){//derecha
      dir=3;
      erase();
      //colision de borde
      borde();
    }
    else if(op=='a'){//izquierda
      dir=2;
      erase();
      //colision de borde
      borde();
    }
    else if(op=='w'){//arriba
      dir=0;
       erase();
      //Colision de borde
      borde();
    }
  
    else if (op=='s'){//abajo
      dir=1;
      erase();
      //Colosion de borde
      borde();
    }
  }
}
void keyPressed(){
  if(keyCode == ' '){
    go=false;
    timer=false;
  }else{
    go=true; 
    timer=true;
    //Para evitar que se mueva al lado opuesto 
    if (keyPressed && key == CODED) { 
      switch(keyCode){
        case RIGHT:
          if(op != 'a'){
            op = 'd';
          }
        break;
        
        case LEFT:
          if(op != 'd'){
            op = 'a';
          }
        break;
        case UP:
          if(op != 's'){
            op = 'w';
          }
        break;
        case DOWN:
          if(op != 'w'){
            op = 's';
          }
        break;
        
      }
    }
  }
}

void addBody(){
  int i=1;
  if(i <= max_size && go==true){
    if(time == 50){//pasados 5 seg (10*5)
      
        pX.add(pX.get(pX.size()-1));
        pY.add(pY.get(pY.size()-1));
      
      time = 0; //resetaer la variable de tiempo
      i*=10;//aumentar el verificador para el tamaño
    }
    time ++;//ir aumentando la variable de tiempo
  }
}

void world(){
  stroke(255,255,255);
  strokeWeight(5);
  //Izquierda
  line(R0a,R0a,R0b,R0a);//Horizontal
  line(C0a,C0b,C0a,C0a);//Vertical 
  //Derecha
  line(R0a,R1,R0b,R1);//Horizontal
  line(C1,C0a,C1,C0b);//Vertical 
}

void timer(){
  if(timer==true){
    if(frameCount % 10 == 0){
      crono--;//restar tiempo al cronometro
    }
  } 
  if(crono == 0){gameOver=true;life-=1;}//Tiempo agotado
}

void restart(){
  //Snake
  pX.clear(); 
  pY.clear(); 
  pX.add(15);
  pY.add(15);
  
  //Fruta
  appleX = (int)random(5,w);
  appleY = (int)random(5,h);
  R=(int)random(255);G=(int)random(255);B=(int)random(255);
  
  gameOver = false;
  go=false;
  op = ' ';
  timer=false;
  //Reiniciar el temporizador si llego al 0
  if(crono == 0){crono=60;}
}
