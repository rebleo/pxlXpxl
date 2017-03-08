PImage emo;

int binSize = 25;
float count = 0;

void setup(){
  size(850,600, P3D);
   emo = loadImage("24.png");
 
}

void draw(){
 background(0,160,0);
 lights();

 
 camera(100, 100, 700, width/2, height/2, 0, 0.0, 1.0, 0.0);

     for (int x = 0; x <= width; x += 25) {
      for (int y = 0; y <= height; y += 25) { 
      
        line(x, 0, x, height);
        line(0, y, width, y);  
      }
    }
     directionalLight(10, 10, 10, 10, 10, -1);
     for(int x = 0; x < width; x+= binSize) {
       for (int y = 0; y < height; y += binSize){
         float distanceToMouse = dist(x, y, mouseX, mouseY); 
         pushMatrix(); 
         translate(x, y); 
         rotateX(distanceToMouse/100.00);
         image(emo,distanceToMouse,distanceToMouse);
         popMatrix();
     }
   }
      //text("framerate="+frameRate, 100, 100);
 
}