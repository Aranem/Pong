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
  background(255);
  
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
  int ballDiameter;
  
  int distanceFromPMiddle;
  
  Ball (int x, int y) {
    ballX = x;
    ballY = y;
    
    ballXV = 10;
    ballYV = 10;
    ballDiameter = 10;
  }
  
  void display () {
    fill(#08F9FF);
    stroke(#08F9FF);
    ellipse(ballX, ballY, ballDiameter, ballDiameter);
  }
  
  void move () {
    ballX += ballXV;
    
    // if structures to reverse direction when it hits a side wall
    if (ballX > width - ballDiameter - 1) { // subtract another pixel for safety
      ballXV *= -1;
    }
    
    if (ballX < 0 + 1) { // another pixel for safety
      ballXV *= -1;
    }
    
    ballY += ballYV;
    
    if (contactPaddle1() || contactPaddle2()) {
      ballYV *= -1;
    }
    
    if (contactWall1() || contactWall2()) {
      freeze();
    }
  }
  
  boolean contactPaddle1 () {
    if (ballY > height - p1.paddleHeight - ballDiameter) {
      if (ballX >= p1.paddleX && ballX <= p1.paddleX + p1.paddleLength) {
        return true;
      }
    }
    return false;
  }
  
  boolean contactPaddle2 () {
    if (ballY < 0 + p2.paddleHeight + ballDiameter) {
      if (ballX >= p2.paddleX && ballX <= p2.paddleX + p2.paddleLength) {
        return true;
      }
    }
    return false;
  }
  
  boolean contactWall1 () {
    if (ballY >= height) {
      return true;
    }
    return false;
  }
  
  boolean contactWall2 () {
    if (ballY <= 0) {
      return true;
    }
    return false;
  }
  
  void freeze () {
    ballXV = 0;
    ballYV = 0;
  }
  
  int getDistanceFromPMiddle (Paddle temp) {
    distanceFromPMiddle = temp.getPaddleMiddle() - ballX;
    return distanceFromPMiddle;
  }
} // Ball class

class Paddle {
  int paddleX;
  int paddleY;
  int paddleXV;
  int paddleHeight = 25;
  int paddleLength = 150;
  
  int paddleMiddle;
  
  Paddle (int x, int y) {
    paddleX = x;
    paddleY = y;
    paddleXV = 30;
  }
  
  void display () {
    fill(#CECECE);
    stroke(#CECECE);
    rect(paddleX, paddleY, paddleLength, paddleHeight, 10);
  }
  
  void move () {
    if (paddleX < width - paddleLength && paddleX > 0) {
      if (inputKeys[0] == true) {
        paddleX -= paddleXV;
      } else if (inputKeys[1] == true) {
          paddleX += paddleXV;
      }
    } else if (paddleX > width - paddleLength) { // stopping the paddle from going offscreen
        paddleX = width - paddleLength - 1;
    } else if (paddleX < 0) {
        paddleX = 1;
    }
  }
  
  void moveArrow () {
    if (paddleX < width - paddleLength && paddleX > 0) {
      if (inputKeys[2] == true) {
        paddleX -= paddleXV;
      } else if (inputKeys[3] == true) {
          paddleX += paddleXV;
      }
    } else if (paddleX > width - paddleLength) {
        paddleX -= paddleXV/2;
    } else if (paddleX < 0) {
        paddleX += paddleXV/2;
    }
  }
  
  int getPaddleMiddle () {
    paddleMiddle = paddleX + (paddleLength / 2);
    return paddleMiddle;
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
