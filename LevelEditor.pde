public class LevelEditor {
    
    private ArrayList<PVector> points = new ArrayList<PVector>();
    private PVector mouseP = null;

    public LevelEditor() {
        String[] pairs = loadStrings("saves/mysave.lsg");
        int len = pairs.length;

        for (int i = 0; i < len; ++i) {
            float[] pair = float(trim(splitTokens(pairs[i], ",")));
            this.points.add(new PVector(pair[0], pair[1]));
        }
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
        for (PVector v : this.points) {
            output.println(v.x + "," + v.y);
        }
        output.flush();
        output.close();
    }

    public void mousePressed()
    {
        this.mouseP = new PVector(mouseX, mouseY);
        this.points.add(this.mouseP);
    }

    public void mouseReleased() {
        PVector temp = new PVector(mouseX, mouseY);
        this.points.add(temp);
        this.mouseP = null;
    }

    public void run() {
        background(30);
        stroke(255);

        if(this.mouseP != null) {
            line(this.mouseP.x, this.mouseP.y, mouseX, mouseY);
        }
        for (int i = 0; i < this.points.size() - 1; i += 2) {
            PVector a = this.points.get(i);
            PVector b = this.points.get(i + 1);
            line(a.x, a.y, b.x, b.y);
        }
    }
}
