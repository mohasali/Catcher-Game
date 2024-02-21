Ball ball;
Ball ball2;
Catcher catcher;

void setup() {
  size(800, 600);
  rectMode(CENTER);
  ball = new Ball(2,30);
  ball2 = new Ball(2,30);
  catcher = new Catcher(1,140,20);
}

void draw() {
  background(0);
  showScore();  // display the score at the top of the screen
  catcher.display();  // call the function to display the catcher
  ball.display(); // call the function to display the ball
  ball2.display();
  catcher.move();  // call the function to move the catcher
  ball.move(); // call the function to move the ball
  ball2.move();
  catcher.checkCaught(ball);  // check if the ball is touching the catcher
  catcher.checkCaught(ball2); 
}

void showScore() {
  fill(255);
  textSize(20);
  text("Score: " + catcher.getScore(), 10, 50);
}

void keyPressed() {
  if (key == 'z' || key == 'x' || key == 's') {
    catcher.setCatcherControl(key); // z, x, and s keys control movement
  }
}


class Ball{
  private float ballX; // x coordinate of the ball
  private float ballY; // y coordinate of the ball
  private float ballSpeed; // speed of movement of the ball
  private float ballWidth; // the diameter of the ball
  
  public Ball(float bSpeed, float bWidth){
    ballX = random(0, width);
    ballY = 0;
    ballSpeed = bSpeed;
    ballWidth = bWidth;
  }
  public float getX(){
    return ballX;
  }
  public float getY(){
    return ballY;
  }
  public float getWidth(){
    return ballWidth;
  }
  
  public void display() {
    fill(0, 0, 255);
    circle(ballX, ballY, ballWidth);
  }
  
  public void move() {
    ballY = (ballY + ballSpeed); // ball moves down slowly
    if (ballY >= height) { // ball at the bottom of the canvas
      resetBall();
    }
  }
  
  public void resetBall() {
    ballY = 0; // ball starts again at top
    ballX = random(0, width); // in a random position
  }
}

class Catcher{
  private float catcherX; // x coordinate of the catcher
  private float catcherY; // y coordinate of the catcher
  private float catcherWidth; // width of the catcher
  private float catcherSpeed; // speed of the catcher
  private float catcherHeight; // height of the catcher
  private char catcherControl; // key pressed to control the catcher
  private int catcherScore;  // the number of balls caught
  
  public Catcher(float cSpeed, float cWidth, float cHeight){
    catcherX = width/2; 
    catcherY = height - 100; // just up from the bottom
    catcherSpeed = cSpeed; // slow speed of the catcher
    catcherWidth = cWidth; // width of the catcher
    catcherHeight = cHeight; // height of the catcher
    catcherScore = 0; // number of balls caught
  }
  
  public int getScore(){
    return catcherScore;
  }
  
  public void display() {
    fill(255, 0, 0);
    rect(catcherX, catcherY, catcherWidth, catcherHeight);
  }
  
  public void move() {
  if (catcherControl == 'x') { // x moves right
      catcherX = catcherX + catcherSpeed;
    } else if (catcherControl == 'z') { // z moves left
      catcherX = catcherX - catcherSpeed;
    }
  }
  
  public void checkCaught(Ball ball) {
    float ballX = ball.getX();
    float ballY = ball.getY();
    float ballWidth = ball.getWidth();
    if (ballX > (catcherX - catcherWidth/2) && 
      ballX < (catcherX + catcherWidth/2) &&
      ballY + ballWidth/2 >= catcherY - catcherHeight/2 &&
      ballY - ballWidth/2 <= catcherY + catcherHeight/2) {
      increaseScore();
      ball.resetBall();
    }
  }
  
  public void increaseScore() {
    catcherScore ++;
  }
  
  public void setCatcherControl(char k){
    catcherControl = k;
  }
}
