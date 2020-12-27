public class SnowMan {
  int x;
  int y;
  color bodyColor;
  color inverted;
  float scale;
  
  int radiusBot = int(175 * scale);
  int radiusMid = int(140 * scale);
  int radiusTop = int(100 * scale);
  int offsetBot = this.y - radiusBot - 20;
  int offsetMid = offsetBot - (radiusBot);
  int offsetTop = offsetMid - (2*radiusTop);
  
  float snowballSize = 0;
  float snowballX;
  float snowballY;
  float snowballThrowX;
  float snowballThrowY;
  boolean reset = false;
  double scaledSpeed = 0;
  float RsnowballSize = 0;
  float RsnowballX;
  float RsnowballY;
  float RsnowballThrowX;
  float RsnowballThrowY;
  boolean Rreset = false;
  double RscaledSpeed = 0;
  
  public SnowMan() {
    this.scale = height / 800.0;    // scale 1 for height = 800
    this.x = width/2;  // centered
    this.y = height;   // bottom of screen
    this.bodyColor = color(#FFFFFF);
    this.inverted = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));
  }
  
  public SnowMan(int bodyColor){
    this.scale = height / 800.0;
    this.x = width/2;  // centered
    this.y = height;   // bottom of screen
    this.bodyColor = color(bodyColor);
    this.inverted = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));
  }
  
  public SnowMan(int bodyColor, int x, int y) {
    this.scale = height / 800.0;
    this.x = x;
    this.y = y;
    this.bodyColor = color(bodyColor);
    this.inverted = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));
  }
  
  public SnowMan(float scale, int bodyColor){
    this.scale = scale;
    this.x = width/2;  // centered
    this.y = height;   // bottom of screen
    this.bodyColor = color(bodyColor);
    this.inverted = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));
  }
  
  public SnowMan(float scale, int bodyColor, int x, int y) {
    this.scale = scale;
    this.x = x;
    this.y = y;
    this.bodyColor = color(bodyColor);
    this.inverted = color(255 - red(bodyColor), 255 - green(bodyColor), 255 - blue(bodyColor));
  }

  public void drawBody(){
    push();
    
    noStroke();
    radiusBot = int(175 * scale);
    radiusMid = int(140 * scale);
    radiusTop = int(100 * scale);
    offsetBot = this.y - radiusBot - 20;
    offsetMid = offsetBot - (radiusBot);
    offsetTop = offsetMid - (2*radiusTop);
    fill(this.bodyColor);
    ellipse(this.x, offsetBot, 2.15*radiusBot, 2*radiusBot);
    ellipse(this.x, offsetMid, 2.15*radiusMid, 2*radiusMid);
    ellipse(this.x, offsetTop, 2*radiusTop, 2*radiusTop);
    
    pop();
  }
  
  public void drawNose(){
    push();
    
    float noseHeight = 0.2 * radiusTop;
    float noseLength = 1.2 * radiusTop;
    
    noStroke();
    fill(#FFA500);
    triangle(x, offsetTop, x, offsetTop + noseHeight, x + noseLength, offsetTop);
     
    pop();
  }
  
  public void drawEyesMouth(){
    push();
    
    float radiusEyes = 0.25 * radiusTop; 
    
    // Inverted color
    fill(inverted);
    ellipse(x - (radiusTop/4), offsetTop - (radiusTop/4), radiusEyes, radiusEyes);
    ellipse(x + (radiusTop/4), offsetTop - (radiusTop/4), radiusEyes, radiusEyes);
    
    float radiusSmile = 1.25 * radiusTop;
    float smileWidth = 0.15 * radiusTop;
    
    noFill();
    stroke(inverted);
    strokeWeight(smileWidth);
    arc(x, offsetTop, radiusSmile, radiusSmile, PI/4, 3*PI/4, OPEN);
    
    pop();
  }
  
  public void drawHat(){
    push();
    
    float brimWidth = 2.5 * radiusTop;
    float brimHeight = 0.3 * radiusTop;
    float topWidth = 0.5 * brimWidth;
    float topHeight = radiusTop;
    
    fill(1);
    rect(x - brimWidth/2, offsetTop - radiusTop, brimWidth, brimHeight);
    rect(x - topWidth/2, offsetTop - radiusTop - topHeight, topWidth, topHeight);
    
    pop();
  }
  
  private void drawArms(){
    push();
    
    float armY = offsetMid - (0.3 * radiusMid);
    float leftArmX =  x - (0.9 * radiusMid);
    float rightArmX = x + (0.9 * radiusMid);
    float armLength = 1.2 * radiusMid;
    float armWidth =  0.1 * radiusMid;
    
    stroke(#4C322B);
    strokeWeight(armWidth);
    strokeCap(ROUND);

    // Left arm angle and lengths
    float thetaL = atan( abs(mouseY - armY) / abs(mouseX - leftArmX) );
    float leftHandX = armLength * cos(thetaL);
    float leftHandY = armLength * sin(thetaL);

    // If mouseX is farther to the right, add to x position
    // If mouseY is farther below, add to the y position
    leftHandX = ( mouseX > leftArmX ) ? leftHandX : -leftHandX;
    leftHandY = ( mouseY > armY ) ? leftHandY : -leftHandY;

    // Same for right arm
    float thetaR = atan( abs(mouseY - armY) / abs(mouseX - rightArmX) );
    float rightHandX = armLength * cos(thetaR);
    float rightHandY = armLength * sin(thetaR);
    rightHandX = ( mouseX > rightArmX ) ? rightHandX : -rightHandX;
    rightHandY = ( mouseY > armY ) ? rightHandY : -rightHandY;

    // Draw arms
    line(leftArmX, armY , leftArmX + leftHandX, armY + leftHandY); 
    line(rightArmX, armY , rightArmX + rightHandX, armY + rightHandY);
    
    if( (mouseButton == LEFT) ){
      // Build an increasingly large snowball when pressing the mouse
    if(reset){
     snowballSize = 0;
     reset = false;
    }
      snowballSize++;
      
      strokeWeight(3);
      stroke(0);
      snowballThrowX = mouseX;
      snowballThrowY = mouseY;
      snowballX = leftArmX + leftHandX;
      snowballY = armY + leftHandY;
      circle(snowballX, snowballY, snowballSize);
    } else {
  if(snowballX==leftHandX+leftArmX&&snowballY==leftHandY+armY){
      reset = true;
    }
      
      if( snowballSize > 0 ){
        // We have a snowball to throw!
        
        strokeWeight(3);
        stroke(0);
        circle( snowballX, snowballY, snowballSize);
        
        if( snowballX < 0 || snowballX > width || snowballY < 0 || snowballY > height ){
          // Snowball is off the screen, reset
          
          snowballSize = 0;
        } else {
          // Snowball on the screen so move it
          if(snowballSize>=190){
            snowballY+=10;
          }else{
          scaledSpeed = 190-snowballSize;
          float thetaS = atan( abs(snowballThrowY - armY) / abs(snowballThrowX - leftArmX) );
          float snowballIncX = ( snowballThrowX > leftArmX ) ? (float)scaledSpeed * cos(thetaS) : (float)-scaledSpeed * cos(thetaS);
          float snowballIncY = ( snowballThrowY > armY ) ?(float) scaledSpeed * sin(thetaS) : (float)-scaledSpeed * sin(thetaS);
          snowballX += snowballIncX;
          snowballY += snowballIncY;
          }
        }
      }
    }
    if( (mouseButton == RIGHT) ){
      // Build an increasingly large snowball when pressing the mouse
    if(Rreset){
     RsnowballSize = 0;
     Rreset = false;
    }
      snowballSize++;
      
      strokeWeight(3);
      stroke(0);
      RsnowballThrowX = mouseX;
      RsnowballThrowY = mouseY;
      RsnowballX = rightHandX;
      RsnowballY = armY + rightHandY;
      circle(RsnowballX, RsnowballY, RsnowballSize);
    } else {
  if(RsnowballX==rightHandX&&RsnowballY==rightHandY+armY){
      Rreset = true;
    }
      
      if( snowballSize > 0 ){
        // We have a snowball to throw!
        
        strokeWeight(3);
        stroke(0);
        circle( RsnowballX, RsnowballY, RsnowballSize);
        
        if( RsnowballX < 0 || RsnowballX > width || RsnowballY < 0 || RsnowballY > height ){
          // Snowball is off the screen, reset
          
          RsnowballSize = 0;
        } else {
          // Snowball on the screen so move it
          if(RsnowballSize>=190){
            RsnowballY+=10;
          }else{
          RscaledSpeed = 190-RsnowballSize;
          float RthetaS = atan( abs(RsnowballThrowY - armY) / abs(RsnowballThrowX - rightArmX) );
          float RsnowballIncX = ( RsnowballThrowX > rightArmX ) ? (float)RscaledSpeed * cos(RthetaS) : (float)-RscaledSpeed * cos(RthetaS);
          float RsnowballIncY = ( RsnowballThrowY > armY ) ?(float) RscaledSpeed * sin(RthetaS) : (float)-RscaledSpeed * sin(RthetaS);
          RsnowballX += RsnowballIncX;
          RsnowballY += RsnowballIncY;
          }
        }
      }
    }
    pop();
  }
  
  public void drawButtons(){
    push();
    
    float buttonSize = 0.25 * radiusMid;
    
    stroke(inverted);
    strokeWeight(buttonSize);
    
    point(x, offsetMid);
    point(x, offsetMid - (0.5 * radiusMid));
    point(x, offsetMid + (0.5 * radiusMid));
    
    pop();
  }
}
