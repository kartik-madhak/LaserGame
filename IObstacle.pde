import javafx.util.Pair;

public class ReflectedData
{
  public PVector intersection;
  public float angle;
  public float distance;
}

public interface IObstacle {
  public ReflectedData getReflected(PVector vertex, float angle);
}
