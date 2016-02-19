int glyphwidth = 30, glyphheight = 40,
  pixelwidth = 10, pixelheight = 10,
  xpixels = glyphwidth / pixelwidth, ypixels = glyphheight / pixelheight,
  numglyphs = 26,
  xspacing = 5,
  yspacing = 10;
  
String text = "LOREM IPSUM DOLOR SIT AMET, CONSECTETUR ADIPISCING ELIT. SUSPENDISSE VULPUTATE FERMENTUM DUI, AT ELEIFEND LACUS MOLESTIE QUIS. PROIN RUTRUM NIBH JUSTO, SIT AMET EGESTAS ERAT VESTIBULUM IN. AENEAN PELLENTESQUE EROS PURUS, SIT AMET EUISMOD NISI TEMPOR VITAE.";
  
class Letter {
   int[][] pixels = new int[xpixels][ypixels];
   float noisecheck;
   float xnoise = random(100), ynoise = random(100), ystart;
   
   Letter() {
     int x, y;
     for ( x = 0; x < xpixels; x++ ) {
       ynoise = ystart;
       for ( y = 0; y < ypixels; y++ ) {
         
         noisecheck = noise(xnoise, ynoise);

         if ( noisecheck > 0.4 ) {
            pixels[x][y] = 1; 
         } else {
            pixels[x][y] = 0;
         }
         ynoise += 1;
       }
       xnoise += 1;
     }
   }
   
   void draw(int x, int y) {
     fill(0);
     int xpos, ypos;
     for ( xpos = 0; xpos < xpixels; xpos++ ) {
       for ( ypos = 0; ypos < ypixels; ypos++ ) {
         if ( pixels[xpos][ypos] != 0 ){
           /*
           rect(
              x + (xpos * pixelwidth), 
              y + (ypos * pixelheight),
              pixelwidth,
              pixelheight
             ); */
             
           ellipse(x + (xpos * (pixelwidth)), y + (ypos * (pixelheight)), pixelwidth, pixelheight); 
         }
       }
     }
     
   }
     
}

void setup() {
  size(1000, 500);
  background(255);
  smooth(1);
  Letter[] letters = new Letter[numglyphs];
  int letterPick, letterx, lettery, xpos, ypos, xstart;
  int strIndex = 0;
  float letternoise = random(100);
  
  for ( int i = 0; i < numglyphs; i++ ){
     letters[i] = new Letter(); 
  }
  
  //drawLetter(0, 0);
  xstart = 10;
  ypos = 10;
  
  for ( lettery = 0; lettery < 10; lettery++ ){
    xpos = xstart;
    for ( letterx = 0; letterx < 25; letterx++ ) {
       //drawLetter(letterx, lettery);
       if ( strIndex > ( text.length() - 1 ) ) {
         break;
       }
       //if ( random(10) < 7 ) {
         letterPick = text.charAt(strIndex) - 65;
         
         if ( letterPick > 0 ) {
  
           letters[letterPick].draw(xpos, ypos);
           //print("letterPick", letterPick, numglyphs, "\n");
         }
       //}
       letternoise += 10;
       xpos += glyphwidth + xspacing;  
       strIndex++;
     }
     ypos += glyphheight + yspacing;
  }
}