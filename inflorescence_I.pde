/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/181712*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
ArrayList seeds;
Seed s;
int numSeeds, seedspacing, seedsize, counter, savecounter;
PImage img;
PFont f;

void setup() 
{
  size(350, 350);
  smooth();
  img = loadImage("seed.png"); // Load the image
  frameRate(10);
  counter = 0;

  seeds = new ArrayList();
  numSeeds = 4500;
  seedspacing = 50;
  savecounter = 0;
  seedsize = 20;
  for (int i = 0; i < numSeeds; i++)
  {
    seeds.add(new Seed(i, seedspacing, seedsize, img));
  }
}

void draw() 
{
  background(0);
  for (int i = 0; i < seeds.size(); i++)
  {
    s = (Seed)seeds.get(i);
    //stop updating the seeds positions when 
    // the frameCount exceeds the total number of seeds
    if (counter < numSeeds)
    {
      //move this seed out from origen
      s.update();
      // tell this seed how to calculate its position
      s.setCounter(counter);
    }
    s.drawSeed();
  }
  counter++;
  stroke(255);
}

// save image
void mouseClicked() 
{
  savecounter = savecounter + 1;
  save("inflorescence" + savecounter + ".png");
}

class Seed
{
  float x, y, r, theta, cosResult, sinResult;
  int counter, seedNum, seedSpacing, seedSize;
  PImage img;

  /* CONSTRUCTOR */

  Seed(int _seedNum, int _seedSpacing, int _seedSize, PImage _img ) 
  {
    seedNum = _seedNum;
    img = _img;
    counter = 0;
    seedSpacing = _seedSpacing;
    seedSize = _seedSize;
    r = 0.0;
    x = width/2; 
    y = height/2;
    // set the angle for this seed
    //theta = 0.61803399*seedNum;
    theta = 0.618034*seedNum;
    cosResult = cos(2*PI*theta);
    sinResult = sin(2*PI*theta);
  }

  /* METHODS */

  void update() 
  {
    // seed will only be updated if the counter variable is 
    // equal to or exceeds the seedNum
    if (counter >= seedNum)
    {
      // distance from the center
      r = sqrt(seedSpacing*(counter - seedNum));
      // calculate the x and y coords of the center of the seed.
      x = r* cosResult +  width/2;
      y = r* sinResult + height/2;
    }
  }

  void drawSeed() 
  {
    // dont show the birth of a new seed
    // it overlaps subsequent seeds and spoils the illusion
    // of growth radiating from the center.
    if (r !=0)
      image(img, x, y);
  }

  void  setCounter(int _counter) { 
    counter = _counter;
  }
}
