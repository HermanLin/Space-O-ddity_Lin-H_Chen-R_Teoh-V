class Asteroid extends GameObject {
  float angleX, angleY;

  Asteroid(PVector position, PVector velocity, PShape modl) {
    pos = position;
    vel = velocity;
    angle = angleX = angleY = 0;
    model = modl;
  }
  boolean move() {
    pos = pos.add(vel);
    return offScreenDestroy();
  }
  void spin() {
    angleX += random(PI / 64, PI / 32);
    angleY += random(PI / 64, PI / 32);
  }

  void render() {
    pushMatrix();
    lights();
    translate(pos.x, pos.y);
    rotateX(angleX);
    rotateY(angleY);
    shape(model);
    popMatrix();
  }
  boolean offScreenDestroy() {
    if (pos.x < - width / 2 - 20 || pos.x > 3 * width / 2 + 20
      || pos.y < - height / 2 - 20 || pos.y > 3 * height / 2 + 20)
      return true;
    else
      return false;
  }
  Collider getCollider() {
    return new Collider();
  }


  class Collider {
    PVector focus1;
    PVector focus2;
    int distance;

    Collider() {
      focus1 = new PVector((pos.x - 25), pos.y);
      focus2 = new PVector((pos.x + 25), pos.y);
      distance = 100;
    }

    boolean intersects(PVector other, float radius) {
      if (dist(other.x, other.y, focus1.x, focus1.y)
        + dist(other.x, other.y, focus2.x, focus2.y)
        + radius
        <= distance)
        return true;
      else
        return false;
    }

    //for dev purposes
    void render() {
      ellipse(pos.x, pos.y, 100, 86);
    }
  }
}