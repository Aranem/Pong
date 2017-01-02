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
  b1 = new Ball(width / 2 - 300, height / 2); // - 300 for a starting point slightly left
}

void draw () {
  background(0);
  
  p1.display();
  p2.display();
  b1.display();
  
  p1.move();
  p2.moveArrow();
  b1.move();
  
  if (keyPressed && key == 'r') {
    reset();
  }
}

void reset () {
  b1.ballX = width / 2 - 300;
  b1.ballY = height / 2;
  b1.ballXV = 10;
  b1.ballYV = 10;
  p1.paddleX = width / 2 - 75;
  p2.paddleX = width / 2 - 75;
}

class Ball {
  int ballX;
  int ballY;
  int ballXV; // x velocity
  int ballYV; // y velocity
  
  Ball (int x, int y) {
    ballX = x;
    ballY = y;
    
    ballXV = 10;
    ballYV = 10;
  }
  
  void display () {
    fill(255);
    rect(ballX, ballY, 10, 10);
  }
  
  void move () {
    ballX += ballXV;
    
    // if structures to reverse direction when it hits a side wall
    if (ballX > width - 10 - 1) { // 10 is ball width, subtract to prevent ball offscreen by 10 plus another pixel for safety
      ballXV *= -1;
    }
    
    if (ballX < 0 + 1) { // another pixel for safety
      ballXV *= -1;
    }
    
    ballY += ballYV;
    
    if (ballY > height - 25 - 10 || ballY < 0 + 25) { // 25 for paddle height and - 10 for ball height
      if (ballX >= p1.paddleX && ballX <= p1.paddleX + 150) { // 150 for paddle length
        ballYV *= -1;
      } else if (ballX >= p2.paddleX && ballX <= p2.paddleX + 150) {
        ballYV *= -1;
      } else {
        freeze();
      }
    }
  }
  
  void freeze () {
    ballXV = 0;
    ballYV = 0;
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
    } else if (paddleX > width - 150) { // stopping the paddle from going offscreen
        paddleX = width - 151;
    } else if (paddleX < 0) {
        paddleX = 1;
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
