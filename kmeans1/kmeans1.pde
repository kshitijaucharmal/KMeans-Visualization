
PVector[] positions;
int n_points = 10000;
int k = 5;
ArrayList<ArrayList<PVector>> clusters = new ArrayList<ArrayList<PVector>>();
color[] colors = new color[k];

void setup() {
  size(600, 600);
  //fullScreen();
  
  for(int i = 0; i < k; i++){
    colors[i] = color(random(255), random(255), random(255));
  }
  
  positions = new PVector[n_points];
  for (int i = 0; i < positions.length; i++) {
    positions[i] = new PVector();
    positions[i].x = int(random(width));
    positions[i].y = int(random(height));
  }
  
  for(int i = 0; i < k; i++){
    clusters.add(new ArrayList<PVector>());
    clusters.get(i).add(positions[int(random(n_points))]);
    //clusters.get(i).add(new PVector(random(height), 1));
  }
}

void draw() {
  background(0);
  
  // k-means
  kmeans();
  
  for(int i = 0; i < k; i++){
    for(PVector pos : clusters.get(i)){
      stroke(colors[i]);
      strokeWeight(4);
      point(pos.x, pos.y);
    }
  }
  
  select_new();
}

void kmeans(){
  for(PVector pos : positions){
    int min_cluster = -1;
    float min = 1000000;
    for(int i = 0; i < k; i++){
      float dist = dist(pos.x, pos.y, clusters.get(i).get(0).x, clusters.get(i).get(0).y);
      if(dist < min){
        min = dist;
        min_cluster = i;
      }
    }
    
    clusters.get(min_cluster).add(pos);
  }
  
  for(int i = 0; i < k; i++){
    clusters.get(i).remove(0);
  }
}

void select_new(){
  for(int i = 0; i < k; i++){
    PVector mean = new PVector();
    PVector sum = new PVector();
    for(PVector pos : clusters.get(i)){
      sum.x += pos.x;
      sum.y += pos.y;
    }
    
    mean.x = sum.x / clusters.get(i).size();
    mean.y = sum.y / clusters.get(i).size();
    
    clusters.get(i).clear();
    clusters.get(i).add(mean);
    
  }
}
