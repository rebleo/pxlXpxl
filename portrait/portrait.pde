PImage thePortrait;
int r, g, b, a;


HScrollbar hs1, hs2, hs3;

color scrollRed, scrollGreen, scrollBlue;
int newR = 0;
int newG = 0;
int newB = 0;

void setup() {
  size(500, 700);
  thePortrait = loadImage("construct.png");
  thePortrait.resize(250, 250);
  thePortrait.loadPixels();

  scrollRed = color(255, 0, 0);
  scrollGreen = color(0, 255, 0);
  scrollBlue = color(0, 0, 255);

  hs1 = new HScrollbar(0, height - 100, width, 16, 16, scrollRed);
  hs2 = new HScrollbar(0, height - 60, width, 16, 16, scrollGreen);
  hs3 = new HScrollbar(0, height - 20, width, 16, 16, scrollBlue);
}       
void draw() {
  background (0);
  loadPixels();
  update(mouseX, mouseY);

  float rValue = hs1.getPos();
  newR = int(  map(rValue, 0, width, -100, 100)  );
  float gValue = hs2.getPos();
  newG = int(map(gValue, 0, width, -100, 100));
  float bValue = hs3.getPos();
  newB = int(map(bValue, 0, width, -100, 100));

  for (int i = 0; i < thePortrait.width; i++) {
    for (int j = 0; j < thePortrait.height; j++) {
      getPixels(i, j, thePortrait.pixels, thePortrait.width);
      makePixels(i, j + 100, r, g, b, 255, pixels, width);

      if (keyCode == UP) {
        //println("up");
        r = r + 100;
      }

      if (keyCode == LEFT) {
        r = r - 100;
      }
      if (keyCode == DOWN) {
        //println("up");
        g = g + 100;
      }

      if (keyCode == RIGHT) {
        //println("up");
        b = b + 100;
      }
      if (a==0) { //if alpha == transparent
        makePixels(i + 250, j + 100,0, 0, 0, 255, pixels, width);
      } else {
        makePixels(i + 250, j + 100,   r + newR,   g + newG,   b + newB, 255, pixels, width);
      }
    }
  }


  updatePixels();
  //image(thePortrait, 0, 0, 50, 50);

  hs1.update();
  hs1.display();
  hs2.update();
  hs2.display();
  hs3.update();
  hs3.display();
}


void getPixels(int x, int y, int[] thePixels, int theGrid) {

  int thisPixel = thePixels[ x + y * theGrid];     // getting the colors as an int from the pixels[]

  a = (thisPixel >> 24) & 0xFF;                  // we need to shift and mask to get each component alone
  r = (thisPixel >> 16) & 0xFF;                  // this is faster than calling red(), green() , blue()
  g = (thisPixel >> 8) & 0xFF;   
  b = thisPixel & 0xFF;

  //if (r + g + b == 765) {
  //  a = 255;
  //}
}


////our function for setting color components RGB into the pixels[] , we need to efine the XY of where
//// to set the pixel, the RGB values we want and the pixels[] array we want to use and it's width

void makePixels(int x, int y, int r, int g, int b, int a, int[] pixelArray, int pixelsWidth) {
  a = (a << 24);                       
  r = r << 16;                       // We are packing all 4 composents into one int
  g = g << 8;                         // so we need to shift them to their places
  color argb = a | r | g | b;        // binary "or" operation adds them all into one int
  pixelArray[ x + y * pixelsWidth] = argb;   // finaly we set the int with te colors into the pixels[]
  //if (r + g + b == 765) {
  //  a = 0;
  //}
}


void update(int x, int y) {
}

void mousePressed() {
}

boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
    mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}


class HScrollbar {
  int swidth, sheight;    // width and height of bar
  float xpos, ypos;       // x and y position of bar
  float spos, newspos;    // x position of slider
  float sposMin, sposMax; // max and min values of slider
  int loose;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  color sliderColor;

  HScrollbar (float xp, float yp, int sw, int sh, int l, color theColor) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
    loose = l;
    sliderColor = theColor;
  }

  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if (abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  boolean overEvent() {
    if (mouseX > xpos && mouseX < xpos+swidth &&
      mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    noStroke();
    fill(0);
    rect(xpos, ypos, swidth, sheight);
    if (over || locked) {
      fill(sliderColor);
    } else {
      fill(255);
    }
    rect(spos, ypos, sheight, sheight);
  }

  float getPos() {
    // Convert spos to be values between
    // 0 and the total width of the scrollbar
    return spos * ratio;
  }
}