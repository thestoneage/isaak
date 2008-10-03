require "test/unit"

require "../lib/vector"

class TestVector < Test::Unit::TestCase

  def setup
    @zero = Vector.new
    @x1 = Vector.new(1.0, 0.0, 0.0)
    @y1 = Vector.new(0.0, 1.0, 0.0)
    @z1 = Vector.new(0.0, 0.0, 1.0)
  end

  def test_initialization
    vector = Vector.new
    assert_nothing_raised(NoMethodError) { vector.x }
    assert_nothing_raised(NoMethodError) { vector.y }
    assert_nothing_raised(NoMethodError) { vector.z }
    
    assert_not_nil(vector.x)
    assert_not_nil(vector.y)
    assert_not_nil(vector.z)
    
    assert_equal(0.0, vector.x)
    assert_equal(0.0, vector.y)
    assert_equal(0.0, vector.z)
    
    vector = Vector.new(0.1, 0.2, 0.3)
    assert_equal(vector.x, 0.1)
    assert_equal(vector.y, 0.2)
    assert_equal(vector.z, 0.3)
  end

  def test_equality
    assert(Vector.new == Vector.new, "Vectors are equal if all their components are equal.")
    assert(Vector.new(1.0, 0.0, -1.0) == Vector.new(1.0, 0.0, -1.0), "Vectors are equal if all their components are equal.")
    assert(Vector.new(1.0, 0.0, 0.0) != Vector.new(0.0, 1.0, 0.0), "Verctors are not equal if their components are not equal.")
  end

  def test_op_add
    assert(@x1 == @x1 + @zero, "vector + zero should be vector.")
    assert(@y1 == @y1 + @zero, "vector + zero should be vector.")
    assert(@z1 == @z1 + @zero, "vector + zero should be vector.")
    assert(Vector.new(1.0, 1.0, 0.0) == @x1 + @y1, "If the vectors a and b are added the components should be added.")
    assert(Vector.new(1.0, 0.0, 1.0) == @x1 + @z1, "If the vectors a and b are added the components should be added.")
    assert(Vector.new(0.0, 1.0, 1.0) == @y1 + @z1, "If the vectors a and b are added the components should be added.")
    assert(!@x1.equal?(@x1+ @x1), "An Operator has copy sematics")
  end

  def test_op_sub
    assert(@x1 == @x1 - @zero, "vector + zero should be vector.")
    assert(@y1 == @y1 - @zero, "vector + zero should be vector.")
    assert(@z1 == @z1 - @zero, "vector + zero should be vector.")
    assert(@zero == @x1 - @x1, "vector - vector should be the zero vector.")
    assert(@zero == @y1 - @y1, "vector - vector should be the zero vector.")
    assert(@zero == @z1 - @z1, "vector - vector should be the zero vector.")
    assert(!@x1.equal?(@x1- @x1), "An Operator should have copy sematics")
  end

  def test_op_negation
    assert(- @x1 == @zero - @x1, "-vector should be zerovector - vector.")
    assert(- @y1 == @zero - @y1, "-vector should be zerovector - vector.")
    assert(- @z1 == @zero - @z1, "-vector should be zerovector - vector.")
    assert(!@x1.equal?(-@x1), "An Operator should have copy sematics")
  end

  def test_op_scalar_product
    assert(@x1 * 1 == @x1, "Vector a * 1 should be Vector a.")
    assert(@y1 * 1 == @y1, "Vector a * 1 should be Vector a.")
    assert(@z1 * 1 == @z1, "Vector a * 1 should be Vector a.")
    assert(@x1 * 0 == @zero, "Vector a * 0 should be the zero Vector.")
    assert(@y1 * 0 == @zero, "Vector a * 0 should be the zero Vector.")
    assert(@z1 * 0 == @zero, "Vector a * 0 should be the zero Vector.")
    assert(@x1 * 2 == Vector.new(2.0, 0.0, 0.0), "Vector a * 2: result.x should be Vector a.x * 2.")
    assert(@y1 * 2 == Vector.new(0.0, 2.0, 0.0), "Vector a * 2: result.y should be Vector a.y * 2.")
    assert(@z1 * 2 == Vector.new(0.0, 0.0, 2.0), "Vector a * 2: result.z should be Vector a.z * 2.")
    assert(!@x1.equal?(@x1 * 2), "Operator should have a copy sematic")
  end

  def test_op_scalar_division
    assert_raise(ZeroDivisionError) { @zero / 0 }
    assert(@x1 / 1 == @x1, "Vector a / 1 should be Vector a.")
    assert(@y1 / 1 == @y1, "Vector a / 1 should be Vector a.")
    assert(@z1 / 1 == @z1, "Vector a / 1 should be Vector a.")
    assert(@x1 / 2 == Vector.new(0.5, 0.0, 0.0), "Vector a / 2: result.x should be a.x / 2.")
    assert(@y1 / 2 == Vector.new(0.0, 0.5, 0.0), "Vector a / 2: result.x should be a.x / 2.")
    assert(@z1 / 2 == Vector.new(0.0, 0.0, 0.5), "Vector a / 2: result.x should be a.x / 2.")
    assert(!@x1.equal?(@x1 / 2), "An Operator should have copy semantics.")
  end

  def test_op_cross
    vector = Vector.new
    assert(!vector.equal?(vector.cross(Vector.new)), "Operator should have copy semanics.")
  end

  def test_add!
    vector = Vector.new
    assert_equal(@x1, vector.add!(@x1))
    vector = Vector.new
    assert_equal(@y1, vector.add!(@y1))
    vector = Vector.new
    assert_equal(@z1, vector.add!(@z1))
    vector = Vector.new
    assert(vector.equal?(vector.add!(@x1)), "Adding a Vector to another should not affect the identity of the second.")
  end

  def test_sub!
    vector = Vector.new
    assert(vector.equal?(vector.sub!(@x1)), "Adding a Vector to another should not affect the identity of the second.")
    vector = @x1.clone
    assert(vector.sub!(@x1) == @zero, "Subtracting a Vector from its cloned version should Result in a Zero Vector.")
    vector = @y1.clone
    assert(vector.sub!(@y1) == @zero, "Subtracting a Vector from its cloned version should Result in a Zero Vector.")
    vector = @z1.clone
    assert(vector.sub!(@z1) == @zero, "Subtracting a Vector from its cloned version should Result in a Zero Vector.")
    vector = @x1.clone
    assert(vector.sub!(@y1) != @zero, "Subtracting two different vectors should not result the Zero Vector.")
  end

  def test_div!
    vector = Vector.new
    assert_raise(ZeroDivisionError) { vector.div!(0) }
    vector = Vector.new
    assert(vector.equal?(vector.div!(1)), "Adding a Vector to another should not affect the identity of the second.")
    vector = @x1.clone
    assert(vector.div!(1) == vector, "Dividing a vector through 1 should return the original vector.")
    vector = @y1.clone
    assert(vector.div!(1) == vector, "Dividing a vector through 1 should return the original vector.")
    vector = @z1.clone
    assert(vector.div!(1) == vector, "Dividing a vector through 1 should return the original vector.")
    assert(Vector.new(2, 2, 2).div!(2) == Vector.new(1, 1, 1), "Vector.new(2, 2, 2).div!(2) should be equal to Vector.new(1, 1, 1)")
    assert(Vector.new(1, 1, 1).div!(0.5) == Vector.new(2, 2, 2), "Vector.new(1, 1, 1).div!(0.5) should be equal to Vector.new(2, 2, 2)")
  end

  def test_dot
    assert_equal(1, @x1.dot(@x1), "Dot Product should be 1.")
    assert_equal(1, @y1.dot(@y1), "Dot Product should be 1.")
    assert_equal(1, @z1.dot(@z1), "Dot Product should be 1.")
    assert_equal(0, @x1.dot(@y1), "Dot Product of independent Variables must be 0.")
    assert_equal(0, @x1.dot(@z1), "Dot Product of independent Variables must be 0.")
    assert_equal(0, @y1.dot(@x1), "Dot Product of independent Variables must be 0.")
    assert_equal(0, @y1.dot(@z1), "Dot Product of independent Variables must be 0.")
    assert_equal(0, @z1.dot(@x1), "Dot Product of independent Variables must be 0.")
    assert_equal(0, @z1.dot(@y1), "Dot Product of independent Variables must be 0.")
    assert_equal(3, Vector.new(1, 1, 1).dot(Vector.new(1, 1, 1)), "Dot Product of (1, 1, 1)*(1, 1, 1) should be 3.")
  end

  def test_magnitude
    assert(@x1.magnitude == 1.0, "Vector should have the length of one. But has #{@x1.magnitude}.")
    assert(@y1.magnitude == 1.0, "Vector should have the length of one. But has #{@y1.magnitude}.")
    assert(@z1.magnitude == 1.0, "Vector should have the length of one. But has #{@z1.magnitude}.")
    assert(@zero.magnitude == 0.0, "Vector should have length of zero. But has #{@zero.magnitude}.")
    vector = Vector.new(1, 1, 0)
    assert(vector.magnitude == Math.sqrt(2), "Vector should have length of sqrt(2). But has #{vector.magnitude}.")
  end

  def test_normalize!
    assert_raise(ArgumentError) { Vector.new(0, 0, 0).normalize! }
    vector = Vector.new(1, 0, 0)
    assert(vector.equal?(vector.normalize!), "The normalize! method should not affect the identity.")
    vector = Vector.new
    vector = Vector.new(1, 0, 0)
    assert(vector == vector.normalize!, "A Vector with the size of one should be equal to the normalized.")
    vector = Vector.new(0, 1, 0)
    assert(vector == vector.normalize!, "A Vector with the size of one should be equal to the normalized.")
    vector = Vector.new(0, 0, 1)
    assert(vector == vector.normalize!, "A Vector with the size of one should be equal to the normalized.")
    vector = Vector.new(12, 1, 12)
    assert(vector.normalize!.magnitude == 1, "The Magnitude of a Vector should be one.")
  end

  def test_limit!
    assert_raise(ArgumentError) { Vector.new.limit!(1) }
    vector = Vector.new(1, 1, 1)
    assert(vector.equal?(vector.limit!(1)), "Identity should not be affected.")
    vector = Vector.new(2, 0, 0)
    assert(vector.limit!(1) == Vector.new(1, 0, 0), "limit!(1) should limit the Vector (2, 0, 0) to (1, 0, 0).")
  end
  
  def test_angle2D
    assert(@x1.angle2D == 0, "Failure message.")
    assert(@y1.angle2D == Math::PI/2.0, "Failure message.")
    assert((@y1 + @x1).angle2D == Math::PI/4.0, "Failure message.")
  end

end