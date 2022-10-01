import controlP5.*;
ControlP5 cp5;
Button[] button = new Button[5];
Button[] help = new Button[5];
int numBttns=5;
int roundCounter = 1;
ControlTimer c;
int pedalStep;
color red = #FC0303;
color green = #21FF00;
color grey =#959468;
color yellow = #FFFF00 ;
color bg= 200;
int alert= 0;
boolean lights = true;
boolean fan = true;
String words = "";
ArrayList<Integer> list = new ArrayList<>();
boolean isFive = false;

void setup() {
  
  //braille
  
  
  
  button[0] = new Button(0, grey, true,300,0);
  button[1] = new Button(1, grey, false,300,150);
  button[2] = new Button(2, grey, false,300,275);
  button[3] = new Button(3, grey, false,300,400);
  button[4] = new Button(4, grey, false,300,525);
  
  help[0] = new Button(0,red, false, 725, 525);
  help[1] = new Button(0,50, false, 470, 525);
  help[2] = new Button(0,50, false, 580, 525);
  help[3] = new Button(0,50, false, 470, 400);
  help[4] = new Button(0,50, false, 580, 400);
  list.add(1);
  list.add(2);
  list.add(3);
  list.add(4);
  
  size(1000, 800);
  c = new ControlTimer();
  cp5 = new ControlP5(this);
  cp5.addButton("Foot Pedal").setSize(200, 50).setPosition(450, 700);
  for (int i =1; i <button.length; i++)
  {
    cp5.addButton(""+i).setSize(100, 100).setPosition(button[i].x, button[i].y).setColorBackground(button[i].btnColor).getName();
  }
  cp5.addButton("Alarm").setSize(100,100).setPosition(help[0].x, help[0].y).setColorBackground(help[0].btnColor);
  cp5.addButton("Close Door").setSize(100,100).setPosition(help[1].x, help[1].y).setColorBackground(help[1].btnColor);
  cp5.addButton("Open Door").setSize(100,100).setPosition(help[2].x, help[2].y).setColorBackground(help[2].btnColor);
  cp5.addButton("Fan").setSize(100,100).setPosition(help[3].x, help[3].y).setColorBackground(help[3].btnColor);
  cp5.addButton("Lights").setSize(100,100).setPosition(help[4].x, help[4].y).setColorBackground(help[4].btnColor);
}
void draw() {
  background(bg);
  fill(0);
  circle(120,175, 10);//braille1
  circle(135,175, 10);
  circle(150,175, 10);
  circle(120,190, 10);
  circle(150,175, 10);
  circle(180,175, 10);
  circle(165,190, 10);
  
  circle(120,335, 10);//braille2
  circle(120,350, 10);
  circle(105,350, 10);
  circle(120,320, 10);
  circle(150,320, 10);
  circle(150,335, 10);
  
  circle(120,435, 10);//braille3
  circle(120,450, 10);
  circle(120,420, 10);
  circle(105,450, 10);
  circle(150,420, 10);
  circle(165,420, 10);
  
  circle(120,565, 10);//braille4
  circle(120,580, 10);
  circle(120,550, 10);
  circle(105,580, 10);
  circle(150,550, 10);
  circle(165,550, 10);
  circle(165,565, 10);
  
  circle(865,550, 10);
  circle(865,565, 10);
  circle(865,580, 10);
  circle(880,550, 10);
  circle(905,550, 10);
  circle(905,565, 10);
  circle(920,565, 10);
  circle(950,565, 10);
  circle(950,585, 10);
  circle(965,575, 10);
  circle(935,575, 10);
  
  fill(grey);
  rect(450, 150, 250, 475);
  fill(button[1].btnColor);
  rect(199, 150, 100, 100);
  fill(button[2].btnColor);
  rect(199, 275, 100, 100);
  fill(button[3].btnColor);
  rect(199, 400, 100, 100);
  fill(button[4].btnColor);
  rect(199, 525, 100, 100);
  fill(alert);
  text(words, 460,200,240,180);
}

void mousePressed() {
  if(mouseOverRect(help[0].x, help[0].y, 100,100))
    {
        words = "We are contacting the fire department immediately!";
    }
    else if(mouseOverRect(help[2].x, help[2].y, 100,100))
    {
        words = "The door is closing!";
    }
    else if(mouseOverRect(help[1].x, help[1].y, 100,100))
    {
        words = "The door is opening";
    }
    else if(mouseOverRect(help[3].x, help[3].y, 100,100))
    {
      if(fan)
      {
        words = "You turned the fan off!";
        fan = false;
      }
      else
      {
        words = "You turned the fan on!";
        fan = true;
      }
        
    }
    else if(mouseOverRect(help[4].x, help[4].y, 100,100))
    {
        if(lights)
      {
        words = "You turned the lights off!";
        bg = 0;
        lights = false;
      }
      else
      {
        words = "You turned the lights on!";
        bg=200;
        lights = true;
      }
        
    }
    else if(!mouseOverRect(450,700,200,50))//is not over button
{
      for(int i = 1; i < 5; i++)
      {
        if(mouseOverRect(button[i].x,button[i].y,100,100))
        {
          button[i].changeGreen();
          println(list.toArray());
        }
      }
    }
    
    else
    {
      println("Butoon PRESS");
      if (roundCounter == 5 )
      {
        isFive = true;
        roundCounter = list.get(0);
        words = "Please hold down the pedal to confirm selection of the " + roundCounter + " floor!";
        
      }
      else
      {
        println(roundCounter);
        words = "Please hold down the pedal to confirm selection of the " + roundCounter + " floor!";      
      }
        c.reset();
        println();
    }
}

void mouseReleased()
{
    if(mouseOverRect(450,700,200,50))//if over button
    {
      if(c.time()>500)
      {
        if(isFive)
        {
          button[4].btnColor=green;
          button[4].selected=true;
          list.remove(list.size()-1);
          words = ("Thank you! The "+ 4+" floor has been selected");
        }
        else{
          button[roundCounter-1].btnColor=green;
          button[roundCounter-1].selected=true;
          if(button[roundCounter].selected== true)
          {
            roundCounter++;
          }
          words = ("Thank you! The "+ (button[roundCounter].floor)+" floor has been selected");
          roundCounter = 1;
          
          //select
        }
      }
      else//single click
      {
          if(button[roundCounter-1].selected==false)
          {
             button[roundCounter-1].btnColor=grey;
          }
          else if (button[4].selected==false)
          {
            button[4].btnColor=grey;
          }
          if (roundCounter==5)
          {
             roundCounter=1; 
          }
          while(button[roundCounter].selected)
          {
            if(button[roundCounter].floor == 4)
            {
              roundCounter = list.get(0);
            }
            else
              roundCounter=roundCounter+1;;
          }

          button[roundCounter].pedalChange();
          roundCounter++;
         }
      
      c.reset();
    }
}

boolean mouseOverRect(float x, float y, int w, int h) {
  return (mouseX >= x && mouseX <= x+w && mouseY >= y && mouseY <= y+h);
}


class Button {
  int floor;
  float x,y;
  color btnColor;
  boolean selected;

  Button(int floor, color btnColor, boolean selected, float x, float y) {
    this.floor=floor;
    this.btnColor=btnColor;
    this.selected=selected;
    this.x=x;
    this.y=y;
  }
  
  void pedalChange()
  {
    if (button[floor].btnColor==grey)
    {
      button[floor].btnColor=yellow;
      button[floor].selected= false;
    }
    else if (button[floor].selected== false && button[floor].btnColor==green)
    {
      button[floor].btnColor=grey;
    }
    else
      print("WTF");
  }
  
  void changeGreen()
  {
    if (button[floor].btnColor==grey)
    {
      button[floor].btnColor=green;
      button[floor].selected= true;
    }
    else if (button[floor].btnColor==green)
    {
      button[floor].btnColor=grey;
       button[floor].selected= false;
    }
    else
      print("WTF");
  }
}
