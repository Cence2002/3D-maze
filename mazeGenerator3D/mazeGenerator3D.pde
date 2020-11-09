int ax; //r-size
int ay; //u-size
int az; //f-size
boolean[][][] r, u, f, s; //right, up, front...  street
float sx; //x-side length
float sy; //y-side length
float sz; //z-side length
int x; //current x-coordinate
int y; //current y-coordinate
int z; //current z-coordinate
ArrayList<Integer> px=new ArrayList<Integer>(); //previous x-coordinates
ArrayList<Integer> py=new ArrayList<Integer>(); //previous y-coordinates
ArrayList<Integer> pz=new ArrayList<Integer>(); //previous z-coordinates
boolean fin=false;
float depth;

void setup() {
  size(900, 900, P3D);
  background(0);
  depth=900;
  colorMode(RGB, 1);
  frameRate(30);
  ax=8;
  ay=8;
  az=8;
  r=new boolean[ax-1][ay][az];
  u=new boolean[ax][ay-1][az];
  f=new boolean[ax][ay][az-1];
  s=new boolean[ax][ay][az];
  s[0][0][0]=true;
  x=0;
  y=0;
  z=0;
  sx=(float)width/ax;
  sy=(float)height/ay;
  sz=(float)depth/az;
  px.add(0);
  py.add(0);
  pz.add(0);
}

void draw() {
  hint(DISABLE_DEPTH_TEST);
  lights();
  println(frameRate);
  translate(width/2, height/2, -750);
  rotateX(map(mouseY, 0, height, TWO_PI, 0));
  rotateY(map(mouseX, 0, width, TWO_PI, 0));
  translate(-width/2, -height/2, -depth/2);
  show();
  for (int i=0; i<3; i++) {
    if (!fin) {
      step();
      if (x==0&&y==0&&z==0) {
        fin=true;
        println("finished");
      }
    }
  }
}

void show() {
  background(0);

  translate(sx/2, sy/2, sz/2);

  stroke(1);
  strokeWeight(0.5);

  /*noFill();
   for (int i=0; i<ax; i++) {
   for (int j=0; j<ay; j++) {
   for (int k=0; k<az; k++) {
   if (s[i][j][k]) {
   box(sx*1.00, sy*1.00, sz*1.00);
   }
   translate(0, 0, sz);
   }
   translate(0, sy, 0);
   translate(0, 0, -sz*az);
   }
   translate(sx, 0, 0);
   translate(0, -sy*ay, 0);
   }
   translate(-sx*ax, 0, 0);*/

  stroke(1);
  /*for (int i=0; i<ax; i++) {
   for (int j=0; j<ay; j++) {
   for (int k=0; k<az-1; k++) {
   if (!f[i][j][k]) {
   line(sx*i, sy*j, sz*k, sx*i, sy*j, sz*(k+1));
   }
   }
   }
   }
   rotateX(HALF_PI);
   for (int i=0; i<ax; i++) {
   for (int j=0; j<ay-1; j++) {
   for (int k=0; k<az; k++) {
   if (!u[i][j][k]) {
   line(sx*i, sz*k, -sy*j, sx*i, sz*k, -sy*(j+1));
   }
   }
   }
   }
   rotateY(HALF_PI);
   for (int i=0; i<ax-1; i++) {
   for (int j=0; j<ay; j++) {
   for (int k=0; k<az; k++) {
   if (!r[i][j][k]) {
   line(sy*j, sz*k, sx*i, sy*j, sz*k, sx*(i+1));
   }
   }
   }
   }
   rotateY(-HALF_PI);
   rotateX(-HALF_PI);*/

  translate(-sx/2, -sy/2, -sz/2);  
  //noStroke();
  fill(0, 1, 1, 0.05);
  for (int i=0; i<ax; i++) {
    for (int j=0; j<ay; j++) {
      for (int k=0; k<az-1; k++) {
        if (f[i][j][k]) {
          translate(0, 0, sz*(k+1));
          rect(sx*i, sy*j, sx, sy);
          translate(0, 0, -sz*(k+1));
        }
      }
    }
  }
  rotateX(HALF_PI);
  for (int i=0; i<ax; i++) {
    for (int j=0; j<ay-1; j++) {
      for (int k=0; k<az; k++) {
        if (u[i][j][k]) {
          translate(0, 0, -sy*(j+1));
          rect(sx*i, sz*k, sx, sz);
          translate(0, 0, sy*(j+1));
        }
      }
    }
  }
  rotateY(HALF_PI);
  for (int i=0; i<ax-1; i++) {
    for (int j=0; j<ay; j++) {
      for (int k=0; k<az; k++) {
        if (r[i][j][k]) {
          translate(0, 0, sx*(i+1));
          rect(sy*j, sz*k, sy, sz);
          translate(0, 0, -sx*(i+1));
        }
      }
    }
  }
  rotateY(-HALF_PI);
  rotateX(-HALF_PI);

  fill(0, 1, 0, 0.1);
  rect(0, 0, sx*ax, sy*ay);
  translate(0, 0, sz*az);
  rect(0, 0, sx*ax, sy*ay);
  translate(0, 0, -sz*az);
  rotateX(HALF_PI);
  rect(0, 0, sx*ax, sz*az);
  translate(0, 0, -sy*ay);
  rect(0, 0, sx*ax, sz*az);
  translate(0, 0, sy*ay);
  rotateY(HALF_PI);
  rect(0, 0, sy*ay, sz*az);
  translate(0, 0, sx*ax);
  rect(0, 0, sy*ay, sz*az);
  translate(0, 0, -sx*ax);
  rotateY(-HALF_PI);
  rotateX(-HALF_PI);


  translate(sx/2, sy/2, sz/2);  
  noStroke();
  fill(1, 0, 0, 0.8);
  translate(sx*x, sy*y, sz*z);
  box(sx/2, sy/2, sz/2);
  translate(-sx*x, -sy*y, -sz*z);
}

/*int[][][] dis(int x, int y, int z) {
 int[][][] dis=new int[ax][ay][az];
 for (int i=0; i<ax; i++) {
 for (int j=0; j<ay; j++) {
 for (int k=0; k<az; k++) {
 dis[i][j][k]=-1;
 }
 }
 }
 dis[ax-1][ay-1][az-1]=0;
 ArrayList<Integer> xs=new ArrayList<Integer>();
 ArrayList<Integer> ys=new ArrayList<Integer>();
 ArrayList<Integer> zs=new ArrayList<Integer>();
 xs.add(x);
 ys.add(y);
 zs.add(z);
 int d=1;
 if (x==ax-1&&y==ay-1&&z==az-1) {
 return 0;
 }
 boolean allChanged=false;
 while (!allChanged) {
 allChanged=true;
 ArrayList<Integer> nxs=new ArrayList<Integer>();
 ArrayList<Integer> nys=new ArrayList<Integer>();
 for (int i=0; i<xs.size(); i++) {
 for (int dir=0; dir<4; dir++) {
 if (!hv(xs.get(i), ys.get(i), dir)) {
 int nx=0;
 int ny=0;
 switch(dir) {
 case 0:
 nx=xs.get(i)+1;
 ny=ys.get(i);
 break;
 case 1:
 nx=xs.get(i);
 ny=ys.get(i)+1;
 break;
 case 2:
 nx=xs.get(i)-1;
 ny=ys.get(i);
 break;
 case 3:
 nx=xs.get(i);
 ny=ys.get(i)-1;
 break;
 }
 if (dis[nx][ny]==0) {
 allChanged=false;
 distanceMatrix[nx][ny]=d;
 nxs.add(nx);
 nys.add(ny);
 if (nx==floor(mouseX/sx-1)&&ny==floor(mouseY/sy-1)) {
 return d;
 }
 }
 }
 }
 }
 xs.clear();
 ys.clear();
 xs.addAll(nxs);
 ys.addAll(nys);
 d++;
 }
 //System.err.print("Unreachable endPosition");
 return -1;
 }*/

/*void keyPressed() {
 if (fin) {
 int min=1000000000;
 int best=0;
 if (!hv(x, y, z, 0)) {
 int dis=dis(x+1, y);
 if (dis<min) {
 min=dis;
 best=0;
 }
 }
 if (!hv(x, y, z, 1)) {
 int dis=dis(x, y+1);
 if (dis<min) {
 min=dis;
 best=1;
 }
 }
 if (!hv(x, y, z, 2)) {
 int dis=dis(x-1, y);
 if (dis<min) {
 min=dis;
 best=2;
 }
 }
 if (!hv(x, y, z, 3)) {
 int dis=dis(x, y-1);
 if (dis<min) {
 min=dis;
 best=3;
 }
 }
 if (dis(x, y)!=0) {
 go(best);
 }
 show();
 }
 }*/

void step() {
  if (!fin) {
    int dir=-1;
    ArrayList<Integer> d=new ArrayList<Integer>();
    for (int i=0; i<6; i++) {
      if (!hv(x, y, z, i)&&!back(x, y, z, i)&&!rr(x, y, z, i)) {
        d.add(i);
      }
    }
    if (d.size()==0) {
      int min=-1;
      int best=-1;
      for (int i=0; i<6; i++) {
        if (!hv(x, y, z, i)&&!back(x, y, z, i)) {
          int dis=dis(x, y, z, i);
          if (dis<min||(min==-1&&dis!=-1)) {
            min=dis;
            best=i;
          }
        }
      }
      if (best!=-1) {
        d.add(best);
      }
    }
    if (d.size()==0) {
      for (int i=0; i<6; i++) {
        if (back(x, y, z, i)) {
          dir=i;
        }
      }
    } else {
      dir=d.get(floor(random(d.size())));
    }
    go(dir);
    for (int i=0; i<6; i++) {
      if (i!=(dir+3)%6) {
        if (!s[x][y][z]) {
          if (rr(x, y, z, i)) {
            sethv(x, y, z, i);
          }
        }
      }
    }
    s[x][y][z]=true;
    if (x==0&&y==0&&z==0) {
      fin=true;
    }
  }
}

int dis(int i, int j, int k, int dir) {
  if (!(i==ax-1&&dir==0)||(j==ay-1&&dir==1)||(k==az-1&&dir==2)||(i==0&&dir==3)||(j==0&&dir==4)||(k==0&&dir==5)) {
    switch(dir) {
    case 0:
      for (int d=0; d<px.size(); d++) {
        if (px.get(d)==i+1&&py.get(d)==j&&pz.get(d)==k) {
          return d;
        }
      }
      break;
    case 1:
      for (int d=0; d<px.size(); d++) {
        if (px.get(d)==i&&py.get(d)==j+1&&pz.get(d)==k) {
          return d;
        }
      }
      break;
    case 2:
      for (int d=0; d<px.size(); d++) {
        if (px.get(d)==i&&py.get(d)==j&&pz.get(d)==k+1) {
          return d;
        }
      }
      break;
    case 3:
      for (int d=0; d<px.size(); d++) {
        if (px.get(d)==i-1&&py.get(d)==j&&pz.get(d)==k) {
          return d;
        }
      }
      break;
    case 4:
      for (int d=0; d<px.size(); d++) {
        if (px.get(d)==i&&py.get(d)==j-1&&pz.get(d)==k) {
          return d;
        }
      }
      break;
    case 5:
      for (int d=0; d<px.size(); d++) {
        if (px.get(d)==i&&py.get(d)==j&&pz.get(d)==k-1) {
          return d;
        }
      }
      break;
    }
  }
  return -1;
}

boolean hv(int i, int j, int k, int dir) {
  if ((i==ax-1&&dir==0)||(j==ay-1&&dir==1)||(k==az-1&&dir==2)||(i==0&&dir==3)||(j==0&&dir==4)||(k==0&&dir==5)) {
    return true;
  }
  switch(dir) {
  case 0:
    return r[i][j][k];
  case 1:
    return u[i][j][k];
  case 2:
    return f[i][j][k];
  case 3:
    return r[i-1][j][k];
  case 4:
    return u[i][j-1][k];
  case 5:
    return f[i][j][k-1];
  }
  return false;
}

boolean rr(int i, int j, int k, int dir) {
  if ((i==ax-1&&dir==0)||(j==ay-1&&dir==1)||(k==az-1&&dir==2)||(i==0&&dir==3)||(j==0&&dir==4)||(k==0&&dir==5)) {
    return true;
  }
  switch(dir) {
  case 0:
    return s[i+1][j][k];
  case 1:
    return s[i][j+1][k];
  case 2:
    return s[i][j][k+1];
  case 3:
    return s[i-1][j][k];
  case 4:
    return s[i][j-1][k];
  case 5:
    return s[i][j][k-1];
  }
  return false;
}

boolean back(int i, int j, int k, int dir) {
  switch(dir) {
  case 0:
    return i+1==px.get(px.size()-1)&&j==py.get(px.size()-1)&&k==pz.get(px.size()-1);
  case 1:
    return i==px.get(px.size()-1)&&j+1==py.get(px.size()-1)&&k==pz.get(px.size()-1);
  case 2:
    return i==px.get(px.size()-1)&&j==py.get(px.size()-1)&&k+1==pz.get(px.size()-1);
  case 3:
    return i-1==px.get(px.size()-1)&&j==py.get(px.size()-1)&&k==pz.get(px.size()-1);
  case 4:
    return i==px.get(px.size()-1)&&j-1==py.get(px.size()-1)&&k==pz.get(px.size()-1);
  case 5:
    return i==px.get(px.size()-1)&&j==py.get(px.size()-1)&&k-1==pz.get(px.size()-1);
  }
  return false;
}

void go(int dir) {
  px.add(x);
  py.add(y);
  pz.add(z);
  switch(dir) {
  case 0:
    x++;
    break;
  case 1:
    y++;
    break;
  case 2:
    z++;
    break;
  case 3:
    x--;
    break;
  case 4:
    y--;
    break;
  case 5:
    z--;
    break;
  }
}

void sethv(int i, int j, int k, int dir) {
  if (!((i==ax-1&&dir==0)||(j==ay-1&&dir==1)||(k==az-1&&dir==2)||(i==0&&dir==3)||(j==0&&dir==4)||(k==0&&dir==5))) {
    switch(dir) {
    case 0:
      r[i][j][k]=true;
      break;
    case 1:
      u[i][j][k]=true;
      break;
    case 2:
      f[i][j][k]=true;
      break;
    case 3:
      r[i-1][j][k]=true;
      break;
    case 4:
      u[i][j-1][k]=true;
      break;
    case 5:
      f[i][j][k-1]=true;
      break;
    }
  }
}
