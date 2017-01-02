Paddle p1, p2;
Ball b1;

void setup () {
  size(1000, 600);
  frameRate(60);
  
  p1 = new Paddle(width / 2 - 75, height - 25);
  p2 = new Paddle(width / 2 - 75, 0);
  b1 = new Ball(width / 2, height / 2);
}

void draw () {
  background(0);
  
  p1.display();
  p2.display();
  b1.display();
  
  p1.move(key);
  p2.moveArrow(keyCode);
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
  
  void move (double xCo) {
    if (keyPressed) {
      if (paddleX < width - 150 && paddleX > 0) {
        if (key == 'a') {
          paddleX -= paddleXV;
        } else if (key == 'd') {
          paddleX += paddleXV;
        }
      } else if (paddleX > width - 150) { // avoiding getting stuck on the edges
          paddleX -= paddleXV/2;
      } else if (paddleX < 0) {
          paddleX += paddleXV/2;
      }
    }
  }
  
  void moveArrow (double xCo) {
    if (key == CODED && keyPressed) {
      if (paddleX < width - 150 && paddleX > 0) {
        if (keyCode == LEFT) {
          paddleX -= paddleXV;
        } else if (keyCode == RIGHT) {
          paddleX += paddleXV;
        }
      } else if (paddleX > width - 150) {
          paddleX -= paddleXV/2;
      } else if (paddleX < 0) {
          paddleX += paddleXV/2;
      }
    }
  }
} // Paddle class