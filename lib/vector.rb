class Vector

  attr_reader :x, :y, :z

  attr_writer :x, :y, :z

  def initialize(x = 0.0, y = 0.0, z = 0.0)
    @x, @y, @z = x, y, z
  end

  def ==(vector)
    @x == vector.x and @y == vector.y and @z == vector.z
  end

  def +(vector)
    Vector.new(@x + vector.x, @y + vector.y, @z + vector.z)
  end

  def -(vector)
    Vector.new(@x - vector.x, @y - vector.y, @z - vector.z)
  end
  
  def -@
    Vector.new(-@x, -@y, -@z)
  end

  def *(scalar)
    Vector.new(@x * scalar, @y * scalar, @z * scalar)
  end

  def /(scalar)
    raise(ZeroDivisionError) if scalar == 0
    Vector.new(@x / scalar, @y / scalar, @z / scalar)
  end

  def add(vector)
    @x += vector.x
    @y += vector.y
    @z += vector.z
    return self
  end

  def sub(vector)
    @x -= vector.x
    @y -= vector.y
    @z -= vector.z
    return self
  end

  def mul(scalar)
    @x *= scalar
    @y *= scalar
    @z *= scalar
    return self
  end

  def div(scalar)
    raise(ZeroDivisionError) if scalar == 0
    @x /= scalar
    @y /= scalar
    @z /= scalar
    return self
  end

  def dot(vector)
    @x * vector.x + @y * vector.y + @z * vector.z
  end

  def cross(vector)
    x = @y * vector.z - vector.y * @z;
    y = @z * vector.x - vector.z * @x;
    z = @x * vector.y - vector.x * @y;
    Vector.new(x, y, z)
  end

  def magnitude
    Math.sqrt(@x**2 + @y**2 + @z**2)
  end

  def normalize
    m = magnitude
    if (m > 0)
      div(m)
    end
  end

  def limit(max)
    if (magnitude() > max)
        normalize
        mul(max);
    end
  end

  def dist(vector)
    x = @x - vector.x
    y = @y - vector.y
    z = @z - vector.z
    Math.sqrt((x ** 2) + (y ** 2) + (z ** 2))
  end

  def angle(vector)
    d = dot(vector);
    Math.acos(d / (self.magnitude * vector.magnitude))
  end

  def angle2D
    angle = Math.atan2(-@y, @x)
    return -angle
  end

   def rotate2D(theta)
      currentTheta = angle2D
      mag = magnitude
      currentTheta += theta;
      @x = mag * Math.cos(currentTheta)
      @y = mag * Math.sin(currentTheta)
      return self
    end

end