public class MainApplication extends BaseApplication{

    ArrayList<Wall> walls;
    Laser laserObject;

    public void reset(){
        this.walls = new ArrayList<Wall>();
        String[] pairs = loadStrings("saves/mysave.lsg");
        int len = pairs.length;
        ArrayList<PVector> points = new ArrayList<PVector>();

        float[] laserProp = float(trim(splitTokens(pairs[0], ",")));
        this.laserObject = new Laser(new PVector(laserProp[0], laserProp[1]), radians(laserProp[2]));
        for (int i = 1; i < len; ++i) {
            float[] pair = float(trim(splitTokens(pairs[i], ",")));
            points.add(new PVector(pair[0], pair[1], pair[2]));
        }

        for (int i = 0; i < points.size() - 1; i += 2) {
            PVector a = points.get(i);
            PVector b = points.get(i + 1);
            walls.add(new Wall(a, b, (a.z == 1 || b.z == 1)));
        }
    }

    public void mouseDragged() {
        for(Wall wall : walls)
            if(wall.dragIfMouseIn())
                break;
    }

    public MainApplication () {
       this.reset();
    }

    public void run()
    {
        background(30);
        for(Wall wall : walls)
            wall.display();

        laserObject.update(walls);
        laserObject.display();
    }

}
