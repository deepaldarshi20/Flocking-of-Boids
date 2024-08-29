class bird
{
  float rad;
  PVector pos,vel,acc;
  float maxForce=random(0.3,0.2),maxSpeed=random(3,4);
  bird(float x_,float y_,float rad_)
  {
    pos=new PVector(x_,y_);
    rad=rad_;
    vel=PVector.random2D().setMag(random(2,4));
    acc=new PVector();
  }
  void show()
  {
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(vel.heading()-PI/2);
    fill(255,100);
    noStroke();
    beginShape();
    vertex(0,7.5);
    vertex(5,-7.5);
    vertex(-5,-7.5);
    vertex(0,7.5);
    endShape();
    //noFill();
    //stroke(255,0,0);
    //ellipse(0,0,7.5,7.5);
    popMatrix();
   
  }
  void update()
  {
    vel.add(acc);
    pos.add(vel.limit(maxSpeed));
    acc.mult(0);
    if(pos.x>width+7.5)
    {
       pos.x=-7.5; 
    } 
    else if(pos.x<-7.5)
    {
      pos.x=width+7.5;
    } 
    else if(pos.y<-7.5)
    {
      pos.y=height+7.5;
    }
    else if(pos.y>height+7.5)
    {
      pos.y=-7.5;
    }
  }
  void applyForce(PVector force)
  {
    acc.add(force);
  }
  
  
  
  void flock(bird b[])
  {
    PVector avgPos=new PVector();
    PVector avgVel=new PVector();
    PVector sep   =new PVector();
    int n=0;
    for(bird other:b)
    {
      if(other==null){continue;}
      float d=dist(other.pos.x,other.pos.y,pos.x,pos.y);
      if(other!=this&&d<rad)
      {
        n++;
        avgPos.add(other.pos);
        avgVel.add(other.vel);
        sep.add(PVector.sub(pos,other.pos).setMag(map(d,0,rad,2*maxSpeed,0))); 
      }
    }
    if(n>0){
    avgPos.div(n);
    avgVel.div(n).setMag(maxSpeed);
    applyForce(avgVel.sub(vel).limit(maxForce));
    applyForce(avgPos.sub(pos).sub(vel).limit(maxForce));
    applyForce(sep.sub(vel).limit(maxForce));
    }
  }
  
  void flee(float x,float y)
  {
    if(dist(pos.x,pos.y,x,y)<50)
    applyForce(PVector.sub(pos,new PVector(x,y)).sub(vel).limit(10*maxForce));
  }
  
}
