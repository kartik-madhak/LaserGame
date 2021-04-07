public class LevelEditor {
    
    private ArrayList<PVector> points = new ArrayList<PVector>();
    private PVector mouseP = null;

    public LevelEditor() {
        
    }

    public void keyPressed()
    {
        if(key == 'c')
        {
            this.points = new ArrayList();
        }
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
