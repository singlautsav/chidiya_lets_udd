import processing.sound.*;
SoundFile file;
 
PImage bg;
boolean showSplash = true;
void setup() {
  fullScreen();
  bg = loadImage("wallpaper.jpeg");
}
 
 
color colA = color(227, 228, 229);
color colB = color(181, 182, 183);
 
String pos[] = {"airplane","balloon","cheel","chidiya","jet","kabootar","kauva","kingfisher","koyal","lufthansa","maina","makkhi","patang","rocket","sparrow","titli","totaa","udnkhatola"};
String neg[] = {"aloo","bandar","cow","gaadi","gadha","ghar","sher","table","billi","haathi","kapda","kursi","machhli","murgi","TV"};
 
int scoreA = 0;
int scoreB = 0;
int noOfPlayers = 2;
 
boolean wordChosen = false;
int choice;
String chosenWord = "Press Fingers";
void SelectWord() {
  int r = int(random(2));
  choice = r;
  if (r == 0){
    int x = int(random(pos.length));
    chosenWord = pos[x];
  }
  else {
    int x = int(random(neg.length));
    chosenWord = neg[x];
  }
  wordChosen = true;
  //file = new SoundFile(this, chosenWord);
  //file.play();
}
 
int selectPlayer() {
  if (touches.length == 1) {
    // println("One touch");
    if (touches[0].y < height/2) {
      return 0;
    }
    else return 1;
  } else if (touches.length == 2){
    return 2;
  }
  else {
    return 3;
  }
}
 
boolean is2;
 
void changeColor(ArrayList<Integer> x) {
  if (x.contains(3)) {
    if (choice == 0) {
      colA = color(0, 255, 0);
      colB = color(0, 255, 0);
      scoreA += 1;
      scoreB += 1;
    }
    else {
      colA = color(255, 0, 0);
      colB = color(255, 0, 0);
    }
  }
  else if (x.contains(1)) {
    if (choice == 0) {
      scoreA += 1;
      colA = color(0, 255, 0);
      colB = color(255, 0, 0);
    }
    else {
      scoreB += 1;
      colA = color(255, 0, 0);
      colB = color(0, 255, 0);
    }
  }
  else if (x.contains(0)) {
    if (choice == 1) {
      scoreA += 1;
      colA = color(0, 255, 0);
      colB = color(255, 0, 0);
    }
    else {
      scoreB += 1;
      colA = color(255, 0, 0);
      colB = color(0, 255, 0);
    }
  }
  else {
    if (choice == 0) {
      colA = color(255, 0, 0);
      colB = color(255, 0, 0);
    }
    else {
      scoreA += 1;
      scoreB += 1;
      colA = color(0, 255, 0);
      colB = color(0, 255, 0);
    }
    delay(500);
    is2 = true;
  }
}
int count = 0;
int m = 0, e = 0;
ArrayList<Integer> outputs = new ArrayList<Integer>();
void draw() {
  if (showSplash) {
    imageMode(CENTER);
    image(bg, width/2, height/2, width, float(188)/float(418)*height);
    textSize(80);
    textAlign(CENTER, CENTER);
    fill(20);
    text(chosenWord, width/2, height*(float(3)/float(4)));
  }
  else {
    textSize(80);
    fill(colA);
    rect(0, 0, width, height/2);
    fill(colB);
    rect(0, height/2, width, height/2);
    fill(20);
    //rectMode(CENTER);
    textAlign(CENTER, CENTER);
    text(chosenWord, width/2, height/2);
    //text(scoreA, width/2, float(height)/4);
    //text(scoreB, width/2, height*float(3)/float(4));
    //rectMode(CORNER);
    if (touches.length == noOfPlayers && wordChosen == false) {
      colA = color(227, 228, 229);
      colB = color(181, 182, 183);
      SelectWord();
      if (count == 0 && chosenWord != "Press Fingers") {
        file = new SoundFile(this, chosenWord + ".aiff");
        file.play();
        count = 1;
      }
      m = millis();
      e = m + 2100;
      //println(m,e);
      println(chosenWord);
      outputs = new ArrayList<Integer>();
    }
    else {
      if (millis() < e) {
        int x = selectPlayer();
        if (!outputs.contains(x)) {
          println(x);
          outputs.add(x);
        }
      }
      if (millis() > e) {
         changeColor(outputs);
      }
      if (touches.length == noOfPlayers && millis() > e) {
        //for (int i:outputs) println(i);      
        if (is2 == true) {
        delay(800);
        }
        wordChosen = false;
        count = 0;
        is2 = false;
      }
    }
  }
}
 
void mousePressed() {
  if (showSplash) showSplash = false;
}
