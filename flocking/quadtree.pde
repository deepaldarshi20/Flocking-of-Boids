class quadtree
{
  float x,y,w,h;
  bird points[];
  int cur=0;
  int cap=0;
  boolean divided=false;
  quadtree q1,q2,q3,q4;
  quadtree(float x_,float y_,float w_,float h_,int cap_)
  {
     x=x_;y=y_;w=w_;h=h_;cap=cap_; points=new bird[cap];
  }
  
  void insert(bird p)
  {
     if((p.pos.x>=(x-w/2))&&(p.pos.x<(x+w/2))&&(p.pos.y>=(y-h/2))&&(p.pos.y<(y+h/2))) 
     {
      if(divided)
      {
        q1.insert(p);
        q2.insert(p);
        q3.insert(p);
        q4.insert(p);
      }
      else
      {
        points[cur++]=p;
      }
      if(cur>=cap&&!divided)
      {
        subdivide();
      }
    }
  }
  void subdivide()
  {
      q1=new quadtree(x+w/4,y-h/4,w/2,h/2,cap);
      q2=new quadtree(x-w/4,y-h/4,w/2,h/2,cap);
      q3=new quadtree(x-w/4,y+h/4,w/2,h/2,cap);
      q4=new quadtree(x+w/4,y+h/4,w/2,h/2,cap);
      divided=true;
  }
  void show()
  {
    rectMode(CENTER);
    noFill();
    stroke(255);
    rect(x,y,w,h);
    
    if(divided)
    {
      q1.show();
      q2.show();
      q3.show();
      q4.show();
    }
  }
  bird[] query(float x1,float y1, float rad)
  {
    bird p[]=new bird [1];
    float cx=((x1>x-w/2)?(x1>x+w/2?x+w/2:x1):x-w/2);
    float cy=((y1>y-h/2)?(y1>y+h/2?y+h/2:y1):y-h/2);
    if(dist(cx,cy,x1,y1)<rad)
    {
      p=points;
    }
    else
    {
      return new bird[0];
    }
    if(divided){
        p=con(p,q1.query(x1,y1,rad));
        p=con(p,q2.query(x1,y1,rad));
        p=con(p,q3.query(x1,y1,rad));
        p=con(p,q4.query(x1,y1,rad));
        
    }
    return p;
   
  }
  bird [] con(bird p[],bird q[])
  {
    bird both[]=new bird [p.length+q.length];
    for(int i=0;i<both.length;i++)
    {
      both[i]=i<p.length?p[i]:q[i-p.length];
    }
    return both;
  }
  void cls()
  {
    points=new bird[cap];
    cur=0;
    divided=false;
    if(divided){
    q1.cls();q2.cls();q3.cls();q4.cls();}
    
  }
}
