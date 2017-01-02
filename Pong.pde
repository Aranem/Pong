Paddle p1, p2;
Ball b1;

boolean[] inputKeys;

void setup () {
  size(1000, 600);
  frameRate(60);
  
  // movement key array for controlling multiple inputs at once
  inputKeys = new boolean[4]; // 0 for a, 1 for d, 2 for left, 4 for right arrow

  // initializing all to false to avoid error of paddles not moving if arrows pressed first
  for (int i = 0; i < 4; i++) {
    inputKeys[i] = false;
  }
  
  p1 = new Paddle(width / 2 - 75, height - 25);
  p2 = new Paddle(width / 2 - 75, 0);
  b1 = new Ball(width / 2, height / 2);
}

void draw () {
  background(0);
  
  p1.display();
  p2.display();
  b1.display();
  
  p1.move();
  p2.moveArrow();
  b1.move();
}

class Ball {
  int ballX;
  int ballY;
  int ballXV; // x velocity
  int ballYV; // y velocity
  
  Ball (int x, int y) {
    ballX = x;
    ballY = y;
  }
  
  void display () {
    fill(255);
    rect(ballX, ballY, 10, 10);
  }
  
  void move () {
    
  }
} // Ball class

class Paddle {
  int paddleX;
  int paddleY;
  int paddleXV;
  
  Paddle (int x, int y) {
    paddleX = x;
    paddleY = y;
    paddleXV = 30;
  }
  
  void display () {
    fill(255);
    rect(paddleX, paddleY, 150, 25);
  }
  
  void move () {
    if (paddleX < width - 150 && paddleX > 0) {
      if (inputKeys[0] == true) {
        paddleX -= paddleXV;
      } else if (inputKeys[1] == true) {
          paddleX += paddleXV;
      }
    } else if (paddleX > width - 150) {
        paddleX -= paddleXV/2;
    } else if (paddleX < 0) {
        paddleX += paddleXV/2;
    }
  }
  
  void moveArrow () {
    if (paddleX < width - 150 && paddleX > 0) {
      if (inputKeys[2] == true) {
        paddleX -= paddleXV;
      } else if (inputKeys[3] == true) {
          paddleX += paddleXV;
      }
    } else if (paddleX > width - 150) {
        paddleX -= paddleXV/2;
    } else if (paddleX < 0) {
        paddleX += paddleXV/2;
    }
  }
} // Paddle class

void keyPressed () {
  if (key == 'a') {
    inputKeys[0] = true;
  }
  
  if (key == 'd') {
    inputKeys[1] = true;
  }
  
  if (keyCode == LEFT) {
    inputKeys[2] = true;
  }
  
  if (keyCode == RIGHT) {
    inputKeys[3] = true;
  }
}

void keyReleased () {
  if (key == 'a') {
    inputKeys[0] = false;
  }
  
  if (key == 'd') {
    inputKeys[1] = false;
  }
  
  if (keyCode == LEFT) {
    inputKeys[2] = false;
  }
  
  if (keyCode == RIGHT) {
    inputKeys[3] = false;
  }
}
