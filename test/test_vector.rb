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
  end

  def test_op_add
    assert(@x1 == @x1 + @zero, "vector + zero should be vector.")
    assert(@y1 == @y1 + @zero, "vector + zero should be vector.")
    assert(@z1 == @z1 + @zero, "vector + zero should be vector.")
    assert(Vector.new(1.0, 1.0, 0.0) == @x1 + @y1, "If the vectors a and b are added the components should be added.")
    assert(Vector.new(1.0, 0.0, 1.0) == @x1 + @z1, "If the vectors a and b are added the components should be added.")
    assert(Vector.new(0.0, 1.0, 1.0) == @y1 + @z1, "If the vectors a and b are added the components should be added.")
  end

  def test_op_sub
    assert(@x1 == @x1 - @zero, "vector + zero should be vector.")
    assert(@y1 == @y1 - @zero, "vector + zero should be vector.")
    assert(@z1 == @z1 - @zero, "vector + zero should be vector.")
    assert(@zero == @x1 - @x1, "vector - vector should be the zero vector.")
    assert(@zero == @y1 - @y1, "vector - vector should be the zero vector.")
    assert(@zero == @z1 - @z1, "vector - vector should be the zero vector.")
  end

  def test_op_negation
    assert(- @x1 == @zero - @x1, "-vector should be zerovector - vector.")
    assert(- @y1 == @zero - @y1, "-vector should be zerovector - vector.")
    assert(- @z1 == @zero - @z1, "-vector should be zerovector - vector.")
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
  end

  def test_op_scalar_division
    assert(@x1 / 1 == @x1, "Vector a / 1 should be Vector a.")
    assert(@y1 / 1 == @y1, "Vector a / 1 should be Vector a.")
    assert(@z1 / 1 == @z1, "Vector a / 1 should be Vector a.")
    assert_raise(ZeroDivisionError) { @zero / 0 }
    assert(@x1 / 2 == Vector.new(0.5, 0.0, 0.0), "Vector a / 2: result.x should be a.x / 2.")
    assert(@y1 / 2 == Vector.new(0.0, 0.5, 0.0), "Vector a / 2: result.x should be a.x / 2.")
    assert(@z1 / 2 == Vector.new(0.0, 0.0, 0.5), "Vector a / 2: result.x should be a.x / 2.")
  end

  def test_add
    vector = Vector.new
    assert_equal(@x1, vector.add(@x1))
    vector = Vector.new
    assert_equal(@y1, vector.add(@y1))
    vector = Vector.new
    assert_equal(@z1, vector.add(@z1))
  end

  def test_sub
    vector = Vector.new
    assert_equal(@zero, vector.sub(@zero))
  end

  def test_magnitude
    assert(@x1.magnitude == 1.0, "Vector should have the length of one. But has #{@x1.magnitude}.")
    assert(@y1.magnitude == 1.0, "Vector should have the length of one. But has #{@y1.magnitude}.")
    assert(@z1.magnitude == 1.0, "Vector should have the length of one. But has #{@z1.magnitude}.")
    assert(@zero.magnitude == 0.0, "Vector should have length of zero. But has #{@zero.magnitude}.")
  end

end