ArrayList<Wall> walls = new ArrayList<Wall>();
Laser laserObject = new Laser(new PVector(300, 300), radians(0));

void settings() {
    fullScreen();
}

void setup() {
    walls.add(new Wall(new PVector(600, 300), new PVector(900, 1000)));
    walls.add(new Wall(new PVector(900, 0), new PVector(1200, 1000)));
    walls.add(new Wall(new PVector(900, 0), new PVector(600, 298)));
    walls.add(new Wall(new PVector(1200, 700), new PVector(600, 700)));
}

void draw() {
    background(30);
	for(Wall wall : walls)
        wall.display();

    laserObject.update(walls);
    laserObject.display();
}