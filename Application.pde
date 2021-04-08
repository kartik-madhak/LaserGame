public class Application{

    ArrayList<Wall> walls = new ArrayList<Wall>();
    Laser laserObject = new Laser(new PVector(300, 300), radians(0));

    public Application () {
        String[] pairs = loadStrings("saves/mysave.lsg");
        int len = pairs.length;
        ArrayList<PVector> points = new ArrayList<PVector>();

        for (int i = 0; i < len; ++i) {
            float[] pair = float(trim(splitTokens(pairs[i], ",")));
            points.add(new PVector(pair[0], pair[1]));
        }
        for (int i = 0; i < points.size() - 1; i += 2) {
            PVector a = points.get(i);
            PVector b = points.get(i + 1);
            walls.add(new Wall(a, b));
        }
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
