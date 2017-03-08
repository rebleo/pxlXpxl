// Daniel Rozin, The world pixel by pixel 2016
// paint with video & adjusting colors of an image
// https://github.com/dannyrozin

PImage theEmoji;  // you must have these global varables to use the PxPGetPixel()
int theElements = 500;
int R, G, B, A; 

void setup() {
  size(800, 800);
  theEmoji = loadImage("emo.png");
  theEmoji.resize(width, height);

  background(0);
}

void draw() {
  loadPixels();
   theEmoji.loadPixels();
  //image(theEmoji, 0, 0);
  if (mousePressed) {
    for (int x = mouseX - 25; x< mouseX + 25; x++) {
      for (int y = mouseY - 25; y < mouseY + 25; y++) {
          int useX =  constrain(x, 0, width-1);                                // make sure were not acceesing pixels out side of the pixels array
          int useY =  constrain(y, 0, height-1);
       PxPGetPixel(useX, useY, theEmoji.pixels, width); // GEt the RGB values for the image  
        PxPSetPixel(useX, useY, R, G+mouseX, B+mouseY, 255, pixels, width);
      }
    }

    updatePixels();
  }
}

// our function for getting color components , it requires that you have global variables
// R,G,B   (not elegant but the simples way to go, see the example PxP methods in object for 
// a more elegant solution
      
void PxPGetPixel(int x, int y, int[] pixelArray, int pixelsWidth) {
  int thisPixel=pixelArray[x+y*pixelsWidth];     // getting the colors as an int from the pixels[]
  A = (thisPixel >> 24) & 0xFF;                  // we need to shift and mask to get each component alone
  R = (thisPixel >> 16) & 0xFF;                  // this is faster than calling red(), green() , blue()
  G = (thisPixel >> 8) & 0xFF;   
  B = thisPixel & 0xFF;
}


//our function for setting color components RGB into the pixels[] , we need to efine the XY of where
// to set the pixel, the RGB values we want and the pixels[] array we want to use and it's width

void PxPSetPixel(int x, int y, int r, int g, int b, int a, int[] pixelArray, int pixelsWidth) {
  a =(a << 24);                       
  r = r << 16;                       // We are packing all 4 composents into one int
  g = g << 8;                        // so we need to shift them to their places
  color argb = a | r | g | b;        // binary "or" operation adds them all into one int
  pixelArray[x+y*pixelsWidth]= argb;    // finaly we set the int with te colors into the pixels[]
}