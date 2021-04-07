import javafx.util.Pair;

public class Laser {    
    public PVector origin;
    public float angleWithX;
    public ArrayList<PVector> vertices;
    
    public Laser(PVector origin, float angleWithX) {
        this.origin = origin;
        this.angleWithX = angleWithX;
        this.vertices = new ArrayList<PVector>();
    }   
    
    // Update the vertices
    public void update(ArrayList<? extends IObstacle> obstacles) {
        this.vertices = new ArrayList<PVector>();
        this.vertices.add(this.origin);
        
        float currentAngleWithX  = atan2(mouseY - this.origin.y, mouseX - this.origin.x);
        PVector currentVertex = this.origin;
        
        while(currentVertex.x >= 0 && currentVertex.x <= width && currentVertex.y >= 0 && currentVertex.y <= height) {
            
            float minDist = Float.MAX_VALUE;
            PVector nearestVertex = null;
            float angle = 0;
            for (IObstacle o : obstacles) {
                ReflectedData reflectedData = o.getReflected(currentVertex, currentAngleWithX);
                PVector newVertex = reflectedData.intersection;
                float newAngle = reflectedData.angle;
                float distance = reflectedData.distance; 
                
                if (distance < minDist && distance > 0.1)
                {
                    minDist = distance;
                    nearestVertex = newVertex;       
                    angle = newAngle;
                }
                
            }
            
            if (minDist == Float.MAX_VALUE)
            {
                currentVertex = new PVector(cos(currentAngleWithX), sin(currentAngleWithX)).mult(10000);
            } else {
                currentVertex = nearestVertex;
                currentAngleWithX = angle;
            }
            
            this.vertices.add(currentVertex);
        }
        // println(this.vertices);
    }
    
    void display() {
        for (int i = 0; i < this.vertices.size() - 1; ++i) {
            PVector X = this.vertices.get(i);
            PVector Y = this.vertices.get(i + 1);
            strokeWeight(3);
            stroke(255, 0, 0);
            line(X.x, X.y, Y.x, Y.y);
            stroke(255);
            strokeWeight(1);
        }
    }
}
