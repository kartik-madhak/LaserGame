public class Wall implements IObstacle
{
    public PVector A, B;
    public PVector mA, mB;
    public PVector mid;
    public float angle, distAB;
    public boolean movable;
    
    public ReflectedData getReflected(PVector vertex, float angle)
    {
        PVector p1 = vertex;
        PVector q1 = new PVector(cos(angle), sin(angle)).mult(10000);
        
        PVector wallLine = this.B.copy();
        wallLine.sub(this.A);
        float angle2 = 2 * atan2(wallLine.y, wallLine.x) - angle;
        
        if (doIntersect(p1, q1, this.A, this.B))
        {
            // print("COLLISION");
            PVector intersection = lineLineIntersection(p1, q1, this.A, this.B);
            
            ReflectedData reflectedData = new ReflectedData();
            reflectedData.intersection = intersection;
            reflectedData.angle = angle2;
            reflectedData.distance = dist(p1.x, p1.y, intersection.x, intersection.y);
            
            return reflectedData;
        } else {
            ReflectedData reflectedData = new ReflectedData();
            reflectedData.intersection = q1;
            reflectedData.angle = angle;
            reflectedData.distance = Float.POSITIVE_INFINITY;
            
            return reflectedData;
        }
        
        // PVector p1 = vertex;
        // PVector q1 = new PVector(
        //     cos(angle),
        //     sin(angle)).mult(10000);
        // PVector intersection = lineLineIntersection(p1, q1, this.A, this.B);
        // // println("\nBEFORE:", A, B, "<===");
        // PVector wallLine = this.B.copy();
        // wallLine.sub(this.A);
        // // println("AFTER: ", A, B, "<===");
        
        // return new Pair(intersection, angle2);
    }
    
    public Wall(PVector A, PVector B, boolean movable)
    {
        this.A = A;
        this.B = B;
        this.angle = atan2(this.B.y - this.A.y, this.B.x - this.A.x);
        this.distAB = dist(this.A.x, this.A.y, this.B.x, this.B.y);
        this.mid = PVector.div(PVector.add(this.A, this.B), 2);
        this.mA = PVector.sub(A, mid);
        this.mB = PVector.sub(B, mid);        
        this.movable = movable;
    }
    
    private boolean onSegment(PVector p, PVector q, PVector r)
    {
        if (q.x <= Math.max(p.x, r.x) && q.x >= Math.min(p.x, r.x) &&
            q.y <= Math.max(p.y, r.y) && q.y >= Math.min(p.y, r.y))
            return true;
        
        return false;
    }
    
    private boolean inRect(PVector a, PVector b, PVector c)
    {
        float minX = a.x < b.x ? a.x : b.x;
        float maxX = a.x >= b.x ? a.x : b.x;

        float minY = a.y < b.y ? a.y : b.y;
        float maxY = a.y >= b.y ? a.y : b.y;
        
        if(c.x >= minX && c.x <= maxX && c.y >= minY && c.y < maxY)
            return true;
        return false;
    }

    public boolean dragIfMouseIn()
    {
        if(!this.movable)
            return false;
        PVector mouse = new PVector(mouseX, mouseY);
        if (this.inRect(this.A, this.B, mouse)) {
            this.A = PVector.add(mouse, this.mA);
            this.B = PVector.add(mouse, this.mB);
            return true;
        }
        return false;
    }
    
    private int orientation(PVector p, PVector q, PVector r)
    {
        // See https://www.geeksforgeeks.org/orientation-3-ordered-points/
        // for details of below formula.
        float val = (q.y - p.y) * (r.x - q.x) -
              (q.x - p.x) * (r.y - q.y);
        
        if (val == 0) return 0; // colinear
        
        return(val > 0) ? 1 : 2; // clock or counterclock wise
    }
    
    private boolean doIntersect(PVector p1, PVector q1, PVector p2, PVector q2)
    {
        // Find the four orientations needed for general and
        // special cases
        int o1 = orientation(p1, q1, p2);
        int o2 = orientation(p1, q1, q2);
        int o3 = orientation(p2, q2, p1);
        int o4 = orientation(p2, q2, q1);
        
        // General case
        if (o1 != o2 && o3 != o4)
            return true;
        
        // Special Cases
        // p1, q1 and p2 are colinear and p2 lies on segment p1q1
        if (o1 == 0 && onSegment(p1, p2, q1)) return true;
        
        // p1, q1 and q2 are colinear and q2 lies on segment p1q1
        if (o2 == 0 && onSegment(p1, q2, q1)) return true;
        
        // p2, q2 and p1 are colinear and p1 lies on segment p2q2
        if (o3 == 0 && onSegment(p2, p1, q2)) return true;
        
        // p2, q2 and q1 are colinear and q1 lies on segment p2q2
        if (o4 == 0 && onSegment(p2, q1, q2)) return true;
        
        return false; // Doesn't fall in any of the above cases
    }
    
    private PVector lineLineIntersection(PVector A, PVector B, PVector C, PVector D)
    {
        // Line AB represented as a1x + b1y = c1
        float a1 = B.y - A.y;
        float b1 = A.x - B.x;
        float c1 = a1 * (A.x) + b1 * (A.y);
        
        // Line CD represented as a2x + b2y = c2
        float a2 = D.y - C.y;
        float b2 = C.x - D.x;
        float c2 = a2 * (C.x) + b2 * (C.y);
        
        float determinant = a1 * b2 - a2 * b1;
        
        if (determinant == 0)
        {
            // The lines are parallel. This is simplified
            // by returning a pair of FLT_MAX
            return new PVector(Float.MAX_VALUE, Float.MAX_VALUE);
        }
        else
        {
            float x = (b2 * c1 - b1 * c2) / determinant;
            float y = (a1 * c2 - a2 * c1) / determinant;
            return new PVector((float)x,(float)y);
        }
    }
    
    public float returnDistIfIncident(PVector vertex, float angle)
    {
        PVector p1 = vertex;
        PVector q1 = new PVector(cos(angle), sin(angle)).mult(10000);
        if (doIntersect(p1, q1, this.A, this.B))
        {
            PVector intersection = lineLineIntersection(p1, q1, this.A, this.B);
            return dist(p1.x, p1.y, intersection.x, intersection.y);
        } else return Float.POSITIVE_INFINITY;
    }
    
    public void display()
    {
        // print(A, B);
        if(!this.movable)
            stroke(255, 0, 0);
        else stroke(255, 255, 255);
        line(this.A.x, this.A.y, this.B.x, this.B.y);
    }
}