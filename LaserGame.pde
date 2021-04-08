// Application app;
// LevelEditor le;
int choice = -1;
BaseApplication[] screens;


void settings() {
    fullScreen();
}

void setup() {
    
    screens = new BaseApplication[]{
            new MainApplication(),
            new LevelEditorApplication(),
        };
    // app = new Application();
    // le = new LevelEditor();
}

void mousePressed() {
    if(choice < screens.length && choice >= 0)
    {
        screens[choice].mousePressed();
    } else {

    }
}

void mouseReleased() {
    if(choice < screens.length && choice >= 0)
    {
        screens[choice].mouseReleased();
    } else {
        
    }
}

void mouseDragged() {
    if(choice < screens.length && choice >= 0)
    {
        screens[choice].mouseDragged();
    } else {
        
    }
}

void keyPressed()
{
    if(key == 'e')
        choice = -1;
    if(choice < screens.length && choice >= 0)
    {
        screens[choice].keyPressed();
    } else {
        try{
            choice = Integer.parseInt(key + "") - 1;
            if(choice < screens.length && choice >= 0)            
                screens[choice].reset();
        }
        catch (Exception e) {
            choice = -1;
        }
    }
  
}

void draw() {
    if(choice < screens.length && choice >= 0)
    {
        screens[choice].run();
    } else {
        String str = "Press 1 to play, 2 to edit level...";
        textSize(20);
        
        float tW = textWidth(str);
        float tH = textAscent();

        background(30);
        text(str, width / 2 - tW / 2, height / 2 - tH / 2);
    }
}