let theCanvas;
let thePortrait;

let redRed, greenGreen, blueBlue, alphaAlpha;

let vScale = 16;
let theSlider;

var redA;
var greenA;
var blueA;

let redTheRed;

function preload() {
    thePortrait = loadImage('business.png');
}

function setup() {
    theCanvas = createCanvas(640, 480);
    pixelDensity(1); //turn off retina display stuff // 4:1 pixel

    theSlider = createSlider(10, 250, 50);
    // redA = createSlider(0, 255, addRed())
    thePortrait.resize(200, 200);
    thePortrait.loadPixels();
    loadPixels();
}

function draw() {
    // background(255);
    for (var x = 0; x < thePortrait.width; x++) {
        for (var y = 0; y < thePortrait.height; y++) {

            // Calculate the 1D location from a 2D grid
            // var location = (x + y * thePortrait.width) * 4;
            let theIndex = (x + y * thePortrait.width) * 4; // rgb+a


            // Get the R,G,B values from image
            // var re, gr, bl;

            // var re = thePortrait.pixels[location];
            var allPixels = thePortrait.pixels[theIndex];
            let r, g, b;
            // change brightness based on proximity to the mouse
            var maxdist = 50;
            var d = dist(x, y, mouseX, mouseY);
            var adjustbrightness = 255 * (maxdist - d) / maxdist;
            // allPixels += adjustbrightness;

            // Constrain RGB to make sure they are within 0-255 color range
            r = constrain(r, 0, 255);
            g = constrain(g, 0, 255);
            b = constrain(b, 0, 255);

            // // notice leopold how this is NOT thePortrait.width...
            // this is the (new) location value of the pixel on the canvas
            // let c = color(r, g, b);

            let theLocation = (x + y * width) * 4;
            pixels[theLocation + 0] = r;
            pixels[theLocation + 1] = g;
            pixels[theLocation + 2] = b;
            pixels[theLocation + 3] = 255;

            // r = thePortrait.pixels[theIndex + 0];
            // g = thePortrait.pixels[theIndex + 1];
            // b = thePortrait.pixels[theIndex + 2];
            // a = thePortrait.pixels[theIndex + 3];

            // for (var i = 0; i < thePortrait.width; i++) {
            //     for (var j = 0; j < thePortrait.height; j++) {
            //         thePortrait.set(i, j, color(redA.value(), g, b));
            //     }
        }
    }



    // for (var y = 0; y < thePortrait.height; y++) {
    //     for (var x = 0; x < thePortrait.width; x++) {
    //         getPixels(x, y, thePortrait.pixels, thePortrait.width);
    //         // console.log(theTest)
    //     }
    // }


    // thePortrait.updatePixels();
    updatePixels();
    // image(thePortrait, 100, 200, theSlider.value(), theSlider.value());



} // this is the end of draw


// function getPixels(x, y, somePixels, theGrid) {
//     this.x = x;
//     this.y = y;
//     this.somePixels = somePixels;
//     this.theGrid = theGrid;
//
//     let thePixels = [];
//     thePixels = this.somePixels;
//     let thePixel = thePixels[(this.x + this.y * this.theGrid) * 4];
//
//     r = thePixel + 0;
//     g = thePixel + 1;
//     b = thePixel + 2;
//     a = thePixel + 3;
// }
// //
// function makePixels(x, y, r, g, b, a, somePixels, theGrid) {
//     this.x = x;
//     this.y = y;
//     this.r = r;
//     this.g = g;
//     this.b = b;
//     this.a = a;
//     this.somePixels = somePixels;
//     this.theGrid = theGrid;
//
//     let thePixels = [];
//     thePixels = this.somePixels;
//
//     a = this.a;
//     r = this.r;
//     g = this.g;
//     b = this.b;
//
//     argb = this.a | this.r | this.g | this.b;
//     thePixels[(this.x + this.y * this.theGrid) * 4] = argb;
//     // console.log(argb)
//
// }

// }
//
// function addRed() {
//
//     redTheRed = color(255, 0, 0);
//
//     r = r + redTheRed;
//
// }

// }

// }

// }

// }

// }
