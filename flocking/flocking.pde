
bird flock[];
PVector obstacle[];
quadtree qt;
void setup()
{
  //fullScreen();
  size(1000,800);
  flock=new bird[600];
  obstacle=new PVector[5];
  qt=new quadtree(width/2,height/2,width,height,5);
  for(int i=0;i<flock.length;i++)
  {
    flock[i]=new bird(random(width),random(height),100);
  }
  for(int i=0;i<obstacle.length;i++)
  {
    obstacle[i]=new PVector(random(width),random(height));
  }
}
void draw()
{
  bird snap[]=flock;
  for(int i=0;i<snap.length;i++)
  {
    qt.insert(snap[i]);
  }
  background(0);
  for(bird b:flock)
  {
    b.show();
    b.update();
    b.flock(qt.query(b.pos.x,b.pos.y,10));
    for(PVector obs:obstacle)
    {
      b.flee(obs.x,obs.y);
    }
  }
  qt.show();
    
  for(PVector obs:obstacle)
  {
    fill(255,0,0,100);
    circle(obs.x,obs.y,100);
  }
  qt.cls();
  println(frameRate);
  //frameRate(1);
}
