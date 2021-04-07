Application app;
LevelEditor le;
int choice = 0;

void settings() {
    fullScreen();
}

void setup() {
    app = new Application();
    le = new LevelEditor();
}

void mousePressed() {
    switch(choice)
    {
        case 2:
           le.mousePressed();
        break;
    }
}

void mouseReleased() {
    switch(choice)
    {
        case 2:
           le.mouseReleased();    
        break;
    }
}

void keyPressed()
{
    switch(choice)
    {
        case 0:
            switch(key) {
            case '1' :
               if (choice == 0)
                choice = 1;
            break;	
            case '2' :
               if (choice == 0)
                choice = 2;
            break;	
            }       
        break;
        case 2:
            le.keyPressed();
        break;
    }
}

void draw() {
    switch(choice) {
        case 0:
          String str = "Press 1 to play, 2 to edit level...";
          textSize(20);
        
          float tW = textWidth(str);
          float tH = textAscent();
          text(str, width / 2 - tW / 2, height / 2 - tH / 2);
        break;	
        case 1:
          app.run();
        break;	
        case 2:
           le.run();
        break;
        default :
           background(10);
        break;		
    }
}