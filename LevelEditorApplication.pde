public class LevelEditorApplication extends BaseApplication{
    
    private ArrayList<PVector> points;
    private PVector mouseP = null;

    public void reset() {
        this.points = new ArrayList<PVector>();
        String[] pairs = loadStrings("saves/mysave.lsg");
        int len = pairs.length;

        float[] laserProp = float(trim(splitTokens(pairs[0], ",")));
        // this.laserObject = new Laser(new PVector(laserProp[0], laserProp[1]), radians(laserProp[2]));
        for (int i = 1; i < len; ++i) {
            float[] pair = float(trim(splitTokens(pairs[i], ",")));
            points.add(new PVector(pair[0], pair[1], pair[2]));
        }
    }

    public LevelEditorApplication() {
        this.reset();
    }

    public void keyPressed()
    {
        switch (key) {
            case 'c' :
                this.points = new ArrayList();
            break;	
            case 's' :
                this.save();                
            break;	
        }
    }

    public void save()
    {
        // String name = year() + "_" + month() + "_" + day() + "." + hour() + "_" + minute() + "_" + second();
        String name = "mysave.lsg"; 
        PrintWriter output = createWriter("saves/" + name);
        output.println(100 + "," + 100 + "," + 60);
        for (PVector v : this.points) {
            output.println(v.x + "," + v.y + "," + v.z);
        }
        output.flush();
        output.close();
    }

    public void mousePressed()
    {
        int val = 1;
        if(mouseButton == RIGHT)
            val = 0;
        this.mouseP = new PVector(mouseX, mouseY, val);
        this.points.add(this.mouseP);
    }

    public void mouseReleased() {
        int val = 1;
        if(mouseButton == RIGHT)
            val = 0;
        PVector temp = new PVector(mouseX, mouseY, val);
        this.points.add(temp);
        this.mouseP = null;
    }

    public void run() {
        background(30);
        stroke(255);

        if(this.mouseP != null) {
            if(this.mouseP.z == 0)
                stroke(255, 0, 0);
            else stroke(255);
            line(this.mouseP.x, this.mouseP.y, mouseX, mouseY);
        }
        for (int i = 0; i < this.points.size() - 1; i += 2) {
            PVector a = this.points.get(i);
            PVector b = this.points.get(i + 1);
            if(a.z == 0)
                stroke(255, 0, 0);
            else stroke(255);
            line(a.x, a.y, b.x, b.y);
        }
    }
}
