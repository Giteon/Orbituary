//implement some kind of tally mark point system?

import ddf.minim.*;

boolean menu;
int tutorial;
boolean goodJob;
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
AudioPlayer soundtrack1, soundtrack2, goodDing, badSnap, step, freezeCrack, moneySound, explosionSound, burnUpSound, startBell, demonGrowl;
/**/

PFont font;

public void setup()
{
  size(550, 500);
  smooth();
  background(255);
  menu = true;
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
  /*tutorial later*/
  dots.add(new Orbiter(12, (float)(Math.random()*361), (float)(Math.random()*3)));
  /**/

  /*initialize sounds*/
  minim = new Minim(this);

  /*background music*/
  soundtrack1 = minim.loadFile("data//soundtrack-1.mp3");
  soundtrack2 = minim.loadFile("data//soundtrack-2.mp3");


  /*trigger sounds*/
  goodDing = minim.loadFile("data//good-ding.mp3");
  badSnap = minim.loadFile("data//bad-snap.mp3");
  step = minim.loadFile("data//step.mp3");

  /*collectables sounds*/
  freezeCrack = minim.loadFile("data//freeze-crack.mp3");
  moneySound = minim.loadFile("data//money-sound.mp3");
  explosionSound = minim.loadFile("data//explosion-sound.mp3");
  burnUpSound = minim.loadFile("data//burn-up-sound.mp3");
  /**/
  startBell = minim.loadFile("data//start-bell.mp3");
  //    demonGrowl = minim.loadFile("demon-growl.mp3");

  soundtrack1.loop();
  soundtrack2.loop();


  font = loadFont("CalifornianFB-Reg-48.vlw");
  textFont(font);
}
void draw() {
  /*display title*/

  if (menu)
  { 
    noFill();
    stroke(0);
    float dTemp = 30;
    for (int c = (int)(width*1.4); c>120; c-=dTemp)
    {
      if (dist(mouseX, mouseY, width/2, height/2)<c/2)
      {
        strokeWeight(.5);
        fill(c/2, c/3, c/4);
        noStroke();
        ellipse(width/2, height/2, c+(int)(Math.random()*6-3), c+(int)(Math.random()*6-3));
        dTemp -= .5;
        if (dist(mouseX, mouseY, width/2, height/2)<30)
        {
          strokeWeight(2.5);
          //          stroke(180, 75, 55);
          //           noFill();
          //          ellipse(width/2, height/2, 126, 126);
          if (mousePressed)
          {
            startBell.play();
            menu = false;
            tutorial = 1;
          }
        }
      }
    }
    int t = (int)(Math.random()*4-2);
    if (dist(mouseX, mouseY, width/2, height/2)<63)
    {
      fill(180, 50, 50);
      if (dist(mouseX, mouseY, width/2, height/2)<30)
      {
        stroke(0);
      }
      triangle(254+(int)(Math.random()*4-2), 217+(int)(Math.random()*4-2), 254+(int)(Math.random()*4-2), 287+(int)(Math.random()*4-2), 311+(int)(Math.random()*4-2), 252+(int)(Math.random()*4-2));
    }
  }
  /*"begin" text
   textSize(50);
   textAlign(CENTER, CENTER);
   if (Math.random()>.35) {
   //      text("O  ", 71, 70+(int)(Math.random()*4-2));  
   text("b", 234, height/2+(int)(Math.random()*4-2));
   }
   if (Math.random()>.35) {
   //      text("R  ", 130, 80+(int)(Math.random()*4-2)); 
   text("e", 258, height/2+(int)(Math.random()*4-2));
   }
   if (Math.random()>.35) {
   //      text("B  ", 181, 70+(int)(Math.random()*4-2)); 
   text("g", 280, height/2+(int)(Math.random()*4-2));
   }
   if (Math.random()>.35) {
   //      text("I  ", 234, 80+(int)(Math.random()*4-2)); 
   text("i", 299, height/2+(int)(Math.random()*4-2));
   }
   if (Math.random()>.35) {
   //      text("T  ", 285, 70+(int)(Math.random()*4-2)); 
   text("n", 319, height/2+(int)(Math.random()*4-2));
   }
   }
   }
   */

  /* ring showing the current radius
   stroke(254,207,200);
   noFill();
   ellipse(width/2,height/2,gideon.getRadius()*2,gideon.getRadius()*2);
   */

  /*display points*/
  if (!menu)
  {
    /*"Help" button*/
    textSize(30);
      noFill();
      stroke(0);
    if (dist(mouseX, mouseY, 533,478)<10)
    {
      if (mousePressed)
      {
      tutorial = 1;
      }
    textSize(45);
    }
    text("?", 533, 478);
    /* */
    textAlign(CENTER, CENTER);
    textSize(31);
    fill(0);
    if (Math.random()>.36)
    {
      text(int(points), width/2, 66);
      if (multiplier != 1)
      {
        fill(255, 209, 86);
        text("X"+multiplier, 297 + ((int(points) + "").length()*8), 66);
      }
      if (igniteCounter < 1)
      {
        fill(234, 64, 17);
        text(1-igniteCounter, 20, 56);
      }
    }
  }
  /**/

  /*tutorials*/
  if (tutorial == 1)
  {
    textSize(33);
    text("Welcome to Orbituary", width/2+(int)(Math.random()*6-3), 112);
    text("You are the orbiting black dot", width/2+(int)(Math.random()*6-3), 176);
    text("Press ENTER to continue", width/2+(int)(Math.random()*6-3), 331);
    if (keyPressed && key == ENTER)
    {
      tutorial = 2;
    }
  }
  if (tutorial == 2)
  {
    textSize(33);
    text("Press spacebar to move inwards", width/2+(int)(Math.random()*6-3), 112);
    textSize(29);
    text("Reach the center to increase your score", width/2+(int)(Math.random()*6-3), 176);
    text("Hit other rotating dots, your score suffers", width/2+(int)(Math.random()*6-3), 331);
    if (keyPressed && key == ' ')
    {
      if (goodJob == true)
      {
        tutorial = 3;
        goodJob=false;
      }
    }
  }
  if (tutorial == 3)
  {
    textSize(28);
    text("The ring is your current terminal radius", width/2+(int)(Math.random()*6-3), 112);
    text("It is safe", width/2+(int)(Math.random()*6-3), 156);
    text("You may never go beyond it,", width/2+(int)(Math.random()*6-3), 330);
    text("But it expands as you progress", width/2+(int)(Math.random()*6-3), 380);
    text("Press the shift key to move outwards", width/2+(int)(Math.random()*6-3), 435);
    noFill();
    stroke(60);
    ellipse(width/2, height/2, (dots.get(dots.size()-1).getRadius())+52, (dots.get(dots.size()-1).getRadius())+52);
    if (keyPressed && keyCode == SHIFT)
    {
      if (goodJob == true)
      {
        tutorial = 4;
        goodJob = false;
      }
    }
  }
  if (tutorial == 4)
  {
    textSize(33);
    text("You figured it out. Well done", width/2+(int)(Math.random()*6-3), 112);
    text("Large colorful dots may appear", width/2+(int)(Math.random()*6-3), 336);
    text("These are powerups,", width/2+(int)(Math.random()*6-3), 376);
    text("They have various effects", width/2+(int)(Math.random()*6-3), 417);
    text("Go forth, and good luck.", width/2+(int)(Math.random()*6-3), 466);
    noFill();
    stroke(100);
    ellipse(width/2, height/2, (dots.get(dots.size()-1).getRadius())+52, (dots.get(dots.size()-1).getRadius())+52);
    if (goodJob == true)
    {
      tutorial = 5;
      goodJob = false;
    }
  }
  /**/
  /*background visual noise*/
  strokeWeight(.5);
  int tempGrainY = (int)(Math.random()*height);
  int tempGrainX = (int)(Math.random()*width);
  if (!menu)
  {
    stroke((int)(Math.random()*80+170));

    line(tempGrainX, tempGrainY, tempGrainY+(int)(Math.random()*20-10), tempGrainY+(int)(Math.random()*20-10));
    line(tempGrainY, tempGrainX, tempGrainY+(int)(Math.random()*20-10), tempGrainX+(int)(Math.random()*20-10));
    line((int)(Math.random()*width), (int)(Math.random()*width), (int)(Math.random()*width), (int)(Math.random()*width));
  }
  if (!menu)
  {
    stroke((int)(Math.random()*125+130), (int)(Math.random()*125+130), (int)(Math.random()*125+130));
  } else
  {
    stroke(180, 50, 50);
    line(tempGrainY, tempGrainX, tempGrainY+(int)(Math.random()*20-10), tempGrainY+(int)(Math.random()*20-10));
    line(tempGrainX, tempGrainY, tempGrainX+(int)(Math.random()*20-10), tempGrainY+(int)(Math.random()*20-10));
  }
  /**/
  /*displays dots between title letters*/
  //  if (menu)
  //  {
  //    noStroke();
  //    fill(0);
  //    for ( int i = 90; i < 500; i +=52 )
  //    {
  //      if (Math.random()>1/*.35*/)
  //      {
  //        ellipse(i, 70, 10, 10);
  //      }
  //    }
  //  }

  /**/

  /*draws background with opacity*/
  if (isSlowed == false)
  {
    if (Math.random()>.55)
    {
      fill(236, 228, 216, 61);
      rect(0, 0, width, height);
    }
  } else
  {
    fill(0);
    rect(0, 0, width, height);
  }
  /**/

  /*displays center ellipse*/
  if (!menu)
  {
    strokeWeight(.5);
    stroke(50);
    noFill();
    if (Math.random()>.5)
    {
      if (Math.random()>.5)
      {
        ellipse(width/2, height/2, 6, 6);
      } else
      {
        ellipse(width/2, height/2, 8, 8);
      }
    }
  }
  /**/

  /*creates a new Orbiter in dots when center is reached*/
  /**/

  /*dot operators for classes*/
  if (!menu)
  {
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
    //    gideon.mousePressed();
    gideon.reachCenter();
    gideon.collide();
  }
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
      tempWiggleX = Math.random()*3-1.5;
      tempWiggleY = Math.random()*3-1.5;
    } else
    {
      tempWiggleX = 0;
      tempWiggleY = 0;
    }
    if (Math.random()>.1)
    {
      if (radius % 6 == 0 )
      {
        /*rotate clockwise*/
        x = Math.sin((double)pos/360*(2*PI)) * radius+width/2+tempWiggleX;
        y = Math.cos((double)pos/360*(2*PI)) * radius+height/2+tempWiggleY;
      } else
      {
        /*rotate counterclockwise*/
        x = Math.cos((double)pos/360*(2*PI)) * radius+width/2+tempWiggleX;
        y = Math.sin((double)pos/360*(2*PI)) * radius+height/2+tempWiggleY;
      }
    }
    speed += Math.random()*.004-.002;
    if (freezeAll == false)
    {
      if (isSlowed == false)
      {
        pos+=speed;
      } else
      {
        pos+=speed/2.8;
      }
    }
  }



  /**/

  public void show()
  {
    /*display ellipse*/
    if (isSlowed == false)
    {
      fill((int)x/1.2-60, (int)y/1.2-100, ((int)x+(int)y)/3-80);
    } else
    {
      fill(255);
    }
    /*collectable influence on Orbiter color*/
    if (freezeAll)
    {
      fill(155, 202, 240);
    }
    noStroke();

    if (Math.random()>.5)
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
    if (pos > 360)
    {
      pos = 0;
    }
    x = Math.cos((double)pos/360*(2*PI)) * radius+width/2+Math.random()*3-1.5;
    y = Math.sin((double)pos/360*(2*PI)) * radius+height/2+Math.random()*3-1.5;
    /*speed based on radius*/
    if (radius < 37)
    {
      if (isSlowed)
      {
        pos += speed/((float(getRadius()))/1.4)/2.8;
      } else
      {
        pos += speed/((float(getRadius()))/1.4);
      }
    } else if (radius < 61)
    {
      if (isSlowed)
      {
        pos += speed/((float(getRadius()))/2.8)/2.8;
      } else
      {
        pos += speed/((float(getRadius()))/2.8);
      }
    } else
    {
      if (isSlowed)
      {
        pos += speed/((float(getRadius()))/3.7)/2.8;
      } else
      {
        pos += speed/((float(getRadius()))/3.7);
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
    } else if (multiplier != 1)
    {
      fill(255, 209, 86);
    } else
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

      if ( keyCode == SHIFT)
      {
        if ( (tutorial == 3 && radius < 50) ||tutorial >3 && radius <= dots.get(dots.size()-1).getRadius()    )
        {
          /*move away from center*/
          step.play();
          step.rewind();
          radius += 8;
          if (tutorial == 3)
          {
            goodJob=true;
          }
          if (multiplier == 1)
          {
            int(points --);
          } else
          {
            int(points -=multiplier);
          }
          /**/
        }
      } else if ( key == ' '  && (tutorial == 2|| tutorial >3) && !animateBackToOuterRadius )
      {
        /*move towards center*/
        step.play();
        step.rewind();
        radius -= 8;
        if (multiplier == 1)
        {
          int(points ++);
        } else
        {
          int(points +=multiplier);
        }
        /**/
      } else if ( key == ' ')
      {
        //        isSlowed = !isSlowed;
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
  public void mousePressed()
  {
    if (!menu && canShift && mousePressed && !animateBackToOuterRadius && (tutorial == 0|| tutorial == 2||tutorial==4))
    {
      canShift = false;
      /*move towards center*/
      step.play();
      step.rewind();
      radius -= 8;
      if (multiplier == 1)
      {
        int(points ++);
      } else
      {
        int(points +=multiplier);
      }
      /**/
    }
    if (mousePressed == false)
    { 
      canShift = true;
    }
  }
  /*trigger actions when character reaches center*/
  public void reachCenter() {
    if (radius<=5 && !animateBackToOuterRadius)
    {
      goodDing.play();
      goodDing.rewind();
      points += (float)(dots.get(dots.size()-1).getRadius())/3;
      speed -= float(getRadius())/20;

      goodJob = true;
      /*trigger actions*/
      tempSpeed =  (float)Math.random()*.4+.5-(dots.size()/10);
      if (tempSpeed > 1)
      {
        tempSpeed = .5;
      }
      if (tempSpeed < -1)
      {
        tempSpeed = -.5;
      }
      if (Math.random()>.3)
      {
        dots.add(new Orbiter((int)dots.get(dots.size()-1).getRadius()/*new dot is at a GREATER radius*/+8, (float)(Math.random()*361), tempSpeed));
      } else
      {
        dots.add(new Orbiter((int)dots.get(dots.size()-1).getRadius()/*new dot is at SAME radius*/, (float)(Math.random()*361), tempSpeed));
      }
      if (dots.get(dots.size()-1).getRadius() > 45 && tutorial > 4) /*powerups only will show up after a little while*/
      {
        if (Math.random() > (.93-(dots.size()/120))) /*chanmce of Freezer collectable showing up*/
        {
          freezers.add(new Freezer((int)(Math.random()*(dots.size()-1))*8+12, (float)(Math.random()*361), (float)0));
        }
        if (Math.random() > (.92-(dots.size()/110))) /*chanmce of PointMultiplier collectable showing up*/
        {
          pointMultipliers.add(new PointMultiplier((int)(Math.random()*(dots.size()-1))*8+12, (float)(Math.random()*361), (float)0));
        }
        if (Math.random() > (.925-(dots.size()/105))) /*chanmce of Igniter collectable showing up*/
        {
          igniters.add(new Igniter((int)(Math.random()*(dots.size()-1))*8+12, (float)(Math.random()*361), (float)0));
        }
      }
      animateBackToOuterRadius = true;
      background(135, 250, 135);
    }
  }
  /**/

  /*trigger actions when character collides with another orbiter*/
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
          points -= (int)((dots.size()*1.5)*((multiplier+1)/2));
          animateBackToOuterRadius = true;
        } else
        {
          burnUpSound.play();
          burnUpSound.rewind();
          dots.remove(i);
          igniteCounter ++;
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
    ellipse((int)x, (int)y, 9, 9);
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
    ellipse((int)x, (int)y, 9, 9);
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
    ellipse((int)x, (int)y, 9, 9);
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
