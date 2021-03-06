import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Orbituary extends PApplet {


/*declare variables*/
ArrayList <Orbiter> dots = new ArrayList <Orbiter>();

/*collectables ArrayLists*/
ArrayList <Freezer> freezers = new ArrayList <Freezer>();
ArrayList <PointMultiplier> pointMultipliers = new ArrayList <PointMultiplier>();
ArrayList <Igniter> igniters = new ArrayList <Igniter>();
//ArrayList <RadiusCompiler> radiusCompilers = new Arraylist <RadiusCompiler>();
/**/
specialOrbiter gideon;
boolean canShift;
int points;
/*collectable functions*/
boolean freezeAll;
int freezeTimer;

int multiplier;
int multiplierTimer;

int igniteCounter;
/**/

boolean isSlowed;

/*declare sounds*/

Minim minim;
AudioPlayer soundtrack1, soundtrack2, goodDing, badSnap, step, freezeCrack, moneySound, explosionSound, burnUpSound, timeWarp, demonGrowl;
/**/

PFont font;

public void setup()
{
  size(500, 500);
  background(255);

  /*initialize variables*/
  canShift = true;
  points = 0;


  /*initialize collectable variables*/

  freezeAll = false;
  freezeTimer = 0;

  multiplierTimer = 0;
  multiplier = 1;

  igniteCounter = 1;
  /**/

  isSlowed = false;

  /*initialize objects*/
  gideon = new specialOrbiter(20, 180, 30);
  dots.add(new Orbiter(12, (float)(Math.random()*361), (float)(Math.random()*.5f)));

  /**/

  /*initialize sounds*/
  minim = new Minim(this);

  /*background music*/
  soundtrack1 = minim.loadFile("soundtrack-1.mp3");
  soundtrack2 = minim.loadFile("soundtrack-2.mp3");


  /*trigger sounds*/
  goodDing = minim.loadFile("good-ding.mp3");
  badSnap = minim.loadFile("bad-snap.mp3");
  step = minim.loadFile("step.mp3");

  /*collectables sounds*/
  freezeCrack = minim.loadFile("freeze-crack.mp3");
  moneySound = minim.loadFile("money-sound.mp3");
  explosionSound = minim.loadFile("explosion-sound.mp3");
  burnUpSound = minim.loadFile("burn-up-sound.mp3");
  /**/
  //  timeWarp = minim.loadFile("time-warp-1.mp3");
  //  demonGrowl = minim.loadFile("demon-growl.mp3");

  soundtrack1.loop();
  soundtrack2.loop();


  font = loadFont("CalifornianFB-Reg-48.vlw");
  textFont(font);
}
public void draw() {

  /*display title*/
  fill(0);
  textSize(50);
  textAlign(CENTER, CENTER);
  if (Math.random()>.35f)
  {
    text("O  ", 50, 60+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("R  ", 110, 70+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("B  ", 160, 60+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("I  ", 211, 70+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("T  ", 264, 60+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("U  ", 317, 70+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("A  ", 370, 60+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("R  ", 423, 70+(int)(Math.random()*4-2));
  }
  if (Math.random()>.35f)
  {
    text("Y  ", 472, 60+(int)(Math.random()*4-2));
  }
  /**/

  /*display points*/
  textSize(31);
  fill(0);
  if (Math.random()>.35f)
  {
    text(points, 250, 21);
    if (multiplier != 1)
    {
      fill(255, 209, 86);
      text("X"+multiplier, 280 + ((points + "").length()*8), 21);
    }
    if (igniteCounter < 1)
    {
      fill(234, 64, 17);
      text(1-igniteCounter, 20, 20);
    }
  }
  /**/

  /*background visual noise*/
  stroke((int)(Math.random()*80+170));
  int tempGrainY = (int)(Math.random()*height);
  int tempGrainX = (int)(Math.random()*width);
  line(tempGrainX, tempGrainY, tempGrainY+(int)(Math.random()*20-10), tempGrainY+(int)(Math.random()*20-10));
  line(tempGrainY, tempGrainX, tempGrainY+(int)(Math.random()*20-10), tempGrainX+(int)(Math.random()*20-10));
  line((int)(Math.random()*width), (int)(Math.random()*width), (int)(Math.random()*width), (int)(Math.random()*width));
  stroke((int)(Math.random()*125+130), (int)(Math.random()*125+130), (int)(Math.random()*125+130));
  line(tempGrainY, tempGrainX, tempGrainY+(int)(Math.random()*20-10), tempGrainY+(int)(Math.random()*20-10));
  line(tempGrainX, tempGrainY, tempGrainX+(int)(Math.random()*20-10), tempGrainY+(int)(Math.random()*20-10));
  /**/

  /*displays dots between title letters*/
  noStroke();
  fill(0);
  for ( int i = 70; i < 450; i +=52 )
  {
    ellipse(i, 60, 10, 10);
  }
  /**/

  /*draws background with opacity*/
  if (isSlowed == false)
  {
  if (Math.random()>.55f)
  {
    fill((int)(Math.random()*25+230), 61);
    rect(0, 0, width, height);
  }
  }
  else
  {
    fill(0);
    rect(0, 0, width, height);
  }
  /**/

  /*displays center ellipse*/
  strokeWeight(.5f);
  stroke(50);
  noFill();
  if (Math.random()>.5f)
  {
    if (Math.random()>.5f)
    {
      ellipse(width/2, height/2, 6, 6);
    } 
    else
    {
      ellipse(width/2, height/2, 8, 8);
    }
  }
  /**/

  /*creates a new Orbiter in dots when center is reached*/
  /**/

  /*dot operators for classes*/
  for (int i = 0; i < dots.size (); i ++)
  {
    dots.get(i).orbit();
    dots.get(i).show();
    dots.get(i).getX();
    dots.get(i).getY();
    dots.get(i).getRadius();
  }
  /*collectable dot operators*/
  for (int f = 0; f < freezers.size (); f ++)
  {
    freezers.get(f).orbit();
    freezers.get(f).show();
    freezers.get(f).getX();
    freezers.get(f).getY();
    freezers.get(f).getRadius();
  }
  for (int p = 0; p < pointMultipliers.size (); p ++)
  {
    pointMultipliers.get(p).orbit();
    pointMultipliers.get(p).show();
    pointMultipliers.get(p).getX();
    pointMultipliers.get(p).getY();
    pointMultipliers.get(p).getRadius();
  }
  for (int i = 0; i  < igniters.size (); i ++)
  {
    igniters.get(i).orbit();
    igniters.get(i).show();
    igniters.get(i).getX();
    igniters.get(i).getY();
    igniters.get(i).getRadius();
  }

  /**/
  gideon.orbit();
  gideon.show();
  gideon.getX();
  gideon.getY();
  gideon.getRadius();
  gideon.keyReleased(); /*radius shift*/
  gideon.reachCenter();
  gideon.collide();
}
/**/

/*orbiter class*/
public class Orbiter
{  
  protected int radius;
  protected float pos;
  protected float speed;

  protected double x;
  protected double y;
  /*constructor*/
  public Orbiter(int r, float p, float s/*,color(c)*/)
  {
    radius = r;
    pos = p;
    speed = s;
    x = 0;
    y = 0;
  }

  public void orbit() {
    double tempWiggleX;
    double tempWiggleY;
    if (isSlowed == false)
    {
      tempWiggleX = Math.random()*3-1.5f;
      tempWiggleY = Math.random()*3-1.5f;
    }
    else
    {
      tempWiggleX = 0;
      tempWiggleY = 0;
    }
    if (Math.random()>.1f)
    {
      if (radius % 6 == 0 )
      {
        /*rotate clockwise*/
        x = Math.sin(Math.toRadians((double)pos)) * radius+width/2+tempWiggleX;
        y = Math.cos(Math.toRadians((double)pos)) * radius+height/2+tempWiggleY;
      } 
      else
      {
        /*rotate counterclockwise*/
        x = Math.cos(Math.toRadians((double)pos)) * radius+width/2+tempWiggleX;
        y = Math.sin(Math.toRadians((double)pos)) * radius+height/2+tempWiggleY;
      }
    }
    speed += Math.random()*.004f-.002f;
    if (freezeAll == false)
    {
      if (isSlowed == false)
      {
        pos+=speed;
      }
      else
      {
        pos+=speed/2.8f;
      }
    }
  }



  /**/

  public void show()
  {
    /*display ellipse*/
if(isSlowed == false)
{
    fill((int)x/1.2f-60, (int)y/1.2f-100, ((int)x+(int)y)/3-80);
}
else
{
  fill(255);
}
    /*collectable influence on Orbiter color*/
    if (freezeAll)
    {
      fill(155, 202, 240);
    }
    noStroke();

    if (Math.random()>.5f)
    {
      ellipse((float)x, (float)y, 6, 6);
    }
  }
  public double getX()
  {
    return x;
  }
  public double getY()
  {
    return y;
  }
  public int getRadius()
  {
    return radius;
  }
}

/*specialOrbiter class*/
public class specialOrbiter extends Orbiter {
  /*constructor*/
  private boolean animateBackToOuterRadius;
  private float tempSpeed;
  public specialOrbiter(int r, float p, float s) {
    /*calls Orbiter constructor*/
    super(r, p, s);
    animateBackToOuterRadius = false;
    tempSpeed = 0;
  }
  public void orbit()
  {
    println(pos);
    if (pos > 360)
    {
      pos = 0;
    }
    x = Math.cos(Math.toRadians((double)pos)) * radius+width/2+Math.random()*3-1.5f;
    y = Math.sin(Math.toRadians((double)pos)) * radius+height/2+Math.random()*3-1.5f;
    /*speed based on radius*/
    if (radius < 37)
    {
      if(isSlowed)
      {
      pos += speed/((PApplet.parseFloat(getRadius()))/1.4f)/2.8f;
      }
      else
      {
         pos += speed/((PApplet.parseFloat(getRadius()))/1.4f);
      }
    } 
    else if (radius < 61)
    {
       if(isSlowed)
      {
      pos += speed/((PApplet.parseFloat(getRadius()))/2.8f)/2.8f;
      }
      else
      {
      pos += speed/((PApplet.parseFloat(getRadius()))/2.8f);
      }
    } 
    else
    {
      if(isSlowed)
      {
      pos += speed/((PApplet.parseFloat(getRadius()))/3.7f)/2.8f;
      }
      else
      {
       pos += speed/((PApplet.parseFloat(getRadius()))/3.7f);
      }
    }
    /**/
    /*collectable timer incrementation*/
    if (freezeAll == true)
    {
      freezeTimer ++;
    }
    if (multiplier != 1)
    {
      multiplierTimer ++;
    }
    /**/
  }
  public void show()
  {
    /*display ellipse*/

    /*collectable influence on specialOrbiter color*/
    if (igniteCounter < 1)
    {
      fill(242, 78, 37);
    }
    else if (multiplier != 1)
    {
      fill(255, 209, 86);
    }
    else
    {
      fill((int)x/10, (int)x/10, (int)x/10);
    }
    noStroke();
    ellipse((float)x, (float)y, 6, 6);


    /*animate character dot shooting back to radius if center reached or collide with other orbiter*/
    if (animateBackToOuterRadius)
    {
      radius += 8;
      if (  gideon.getRadius() - ((float)(dots.get(dots.size()-1).getRadius())) > 4 )
      {
        animateBackToOuterRadius = false;
      }
    }
  }
  /**/

  public double getX()
  {
    return super.getX();
  }
  public double getY()
  {
    return super.getY();
  }
  public int getRadius()
  {
    return super.getRadius();
  }

  /*radius shift*/
  public void keyReleased() {
    if ( keyPressed && canShift )
    {
      canShift = false;

      if ( keyCode == UP && radius <= dots.get(dots.size()-1).getRadius())
      {
        /*move away from center*/
        step.play();
        step.rewind();
        radius += 8;
        if (multiplier == 1)
        {
          points --;
        } 
        else
        {
          points -=multiplier;
        }
        /**/
      } 
      else if ( keyCode == DOWN && !animateBackToOuterRadius)
      {
        /*move towards center*/
        step.play();
        step.rewind();
        radius -= 8;
        if (multiplier == 1)
        {
          points ++;
        } 
        else
        {
          points +=multiplier;
        }
        /**/
      }
      else if ( key == ' ')
      {
        isSlowed = !isSlowed;
      }
    }
    /*prevents user from holding a key to continuously move*/
    if (keyPressed == false)
    { 
      canShift = true;
    }
    /**/
  }
  /**/

  /*trigger actions when character reaches center*/
  public void reachCenter() {
    if (radius<=5 && !animateBackToOuterRadius)
    {
      goodDing.play();
      goodDing.rewind();
      speed -= PApplet.parseFloat(getRadius())/20;
      /*trigger actions*/
      tempSpeed =  (float)Math.random()*.4f+.5f-(dots.size()/10);
      if (tempSpeed > 1)
      {
        tempSpeed = .5f;
      }
      if (tempSpeed < -1)
      {
        tempSpeed = -.5f;
      }
      if (Math.random()>.3f)
      {
        dots.add(new Orbiter((int)dots.get(dots.size()-1).getRadius()/*new dot is at a GREATER radius*/+8, (float)(Math.random()*361), tempSpeed));
      }
      else
      {
        dots.add(new Orbiter((int)dots.get(dots.size()-1).getRadius()/*new dot is at SAME radius*/, (float)(Math.random()*361), tempSpeed));
      }
      if (Math.random() > (.75f-(dots.size()/100))) /*chanmce of Freezer collectable showing up*/
      {
        freezers.add(new Freezer((int)(Math.random()*(dots.size()-1))*8+12, (float)(Math.random()*361), (float)0));
      }
      if (Math.random() > (.7f-(dots.size()/100))) /*chanmce of PointMultiplier collectable showing up*/
      {
        pointMultipliers.add(new PointMultiplier((int)(Math.random()*(dots.size()-1))*8+12, (float)(Math.random()*361), (float)0));
      }
      if (Math.random() > (.68f-(dots.size()/100))) /*chanmce of Igniter collectable showing up*/
      {
        igniters.add(new Igniter((int)(Math.random()*(dots.size()-1))*8+12, (float)(Math.random()*361), (float)0));
      }
      animateBackToOuterRadius = true;
      background(135, 250, 135);
    }
  }
  /**/

  /*trigger actions when character comes into contact with another orbiter*/
  public void collide() {
    for (int i = 0; i < dots.size (); i ++)
    {
      /*if both radii are close enough*/
      if (  abs((float)(dots.get(i).getRadius()) - gideon.getRadius()) <4
        &&
        (abs((int)dots.get(i).getX()-(int)gideon.getX()) < 2+radius/10)
        &&
        abs((int)dots.get(i).getY()-(int)gideon.getY()) < 2+radius/10 
        && 
        animateBackToOuterRadius == false )
      {
        /*trigger actions*/
        if (igniteCounter >= 1)
        {
          badSnap.play();
          badSnap.rewind();
          background(222, 65, 65);
          points -= ((int)(dots.size()*1.2f)*(multiplier/2));
          animateBackToOuterRadius = true;
        }
        else
        {
          burnUpSound.play();
          burnUpSound.rewind();
          dots.remove(i);
          igniteCounter ++;
          //lala
        }
      }
    }
    for (int f = 0; f < freezers.size (); f ++)
    {
      /*if both radii are close enough*/
      if (  abs((float)(freezers.get(f).getRadius()) - gideon.getRadius()) <4
        &&
        (abs((int)freezers.get(f).getX()-(int)gideon.getX()) < 2+radius/10)
        &&
        abs((int)freezers.get(f).getY()-(int)gideon.getY()) < 2+radius/10 
        && 
        animateBackToOuterRadius == false )
      {
        freezeTimer = 0;
        freezers.get(f).effect();
        freezers.get(f).removeCollectable();
      }
    }
    for (int p = 0; p < pointMultipliers.size (); p ++)
    {
      /*if both radii are close enough*/
      if (  abs((float)(pointMultipliers.get(p).getRadius()) - gideon.getRadius()) <4
        &&
        (abs((int)pointMultipliers.get(p).getX()-(int)gideon.getX()) < 2+radius/10)
        &&
        abs((int)pointMultipliers.get(p).getY()-(int)gideon.getY()) < 2+radius/10 
        && 
        animateBackToOuterRadius == false )
      {
        multiplierTimer = 0;
        pointMultipliers.get(p).effect();
        pointMultipliers.get(p).removeCollectable();
      }
    }
    for (int i = 0; i < igniters.size (); i ++)
    {
      /*if both radii are close enough*/
      if (  abs((float)(igniters.get(i).getRadius()) - gideon.getRadius()) <4
        &&
        (abs((int)igniters.get(i).getX()-(int)gideon.getX()) < 2+radius/10)
        &&
        abs((int)igniters.get(i).getY()-(int)gideon.getY()) < 2+radius/10 
        && 
        animateBackToOuterRadius == false )
      {
        igniters.get(i).effect();
        igniters.get(i).removeCollectable();
      }
    }
    if (freezeTimer > 50*dots.size())
    {
      freezeAll = false;
      freezeTimer = 0;
    }
    if (multiplierTimer > 50*dots.size())
    {
      multiplier /=2;
      multiplierTimer = 0;
    }
  }
}
/**/

/**/

abstract public class Collectable extends Orbiter {

  public Collectable(int r, float p /*angle from 0 to 360*/, float s /*always 0*/) {
    super(r, p, s);
  }
  public void orbit() /*immobile, position will still occupy a certain radius*/
  {
    super.orbit();
  }
  public void show()
  {
    /*display ellipse*/
    fill(0/*tbd*/); 
    noStroke();
    ellipse((float)x, (float)y, 6, 6);
  }

  public double getX()
  {
    return super.getX();
  }
  public double getY()
  {
    return super.getY();
  }
  public int getRadius()
  {
    return super.getRadius();
  }

  abstract public void effect();
  abstract public void removeCollectable();
}



/*Freezer collectable*/


public class Freezer extends Collectable {
  public Freezer(int r, float p, float s)
  {
    super(r, p, s);
  }
  public void orbit()
  {
    super.orbit();
  }
  public void show() {
    fill(71, 185, 206);
    ellipse((int)x, (int)y, 6, 6);
  }


  public double getX() {
    return super.getX();
  }
  public double getY() {
    return super.getY();
  }
  public int getRadius()
  {
    return super.getRadius();
  }

  public void effect() { /*specialorbiter calls this in collide()*/
    freezeCrack.play();
    freezeCrack.rewind();
    freezeAll = true;
  }
  public void removeCollectable() {
    freezers.remove(this);
    /*freezers arraylist must .remove this freezer right after its effect activates, so it doesn't activate more than once, maybe: freezers.remove(this)*/
  }
}
/**/

/*PointMultiplier collectable*/

public class PointMultiplier extends Collectable {
  public PointMultiplier(int r, float p, float s)
  {
    super(r, p, s);
  }
  public void orbit()
  {
    super.orbit();
  }
  public void show() {
    fill(255, 209, 86);
    ellipse((int)x, (int)y, 6, 6);
  }

  public double getX() {
    return super.getX();
  }
  public double getY() {
    return super.getY();
  }
  public int getRadius()
  {
    return super.getRadius();
  }

  public void effect() { /*specialorbiter calls this in collide()*/
    moneySound.play();
    moneySound.rewind();
    multiplier *=2;
  }
  public void removeCollectable() {
    pointMultipliers.remove(this);
  }
}
/**/

/*Igniter collectable*/
public class Igniter extends Collectable {
  public Igniter(int r, float p, float s)
  {
    super(r, p, s);
  }
  public void orbit()
  {
    super.orbit();
  }
  public void show() {
    fill(242, 88, 37);
    ellipse((int)x, (int)y, 6, 6);
  }

  public double getX() {
    return super.getX();
  }
  public double getY() {
    return super.getY();
  }
  public int getRadius()
  {
    return super.getRadius();
  }

  public void effect() { /*specialorbiter calls this in collide()*/
    explosionSound.play();
    explosionSound.rewind();
    igniteCounter -= 1;
  }
  public void removeCollectable() {
    igniters.remove(this);
  }
}
/*RadiusCompiler*/
//something to change directions



  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Orbituary" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
