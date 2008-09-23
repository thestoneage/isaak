class Thing

  attr_reader :loc, :vel, :acc, :mass, :elastic, :radius

  def initialize(location, velocity, force, mass, elastic = 1.0)
    @acc = Vector.new
    @loc = location
    @vel = velocity
    @force = force
    @mass = mass
    @elastic = elastic
    @radius = 8
  end

  def update
    @vel.add(@acc)
    @loc.add(@vel)
    @acc.x, @acc.y = 0, 0
  end

  def add_force(force_vector)
    @acc.add(force_vector / @mass)
  end

  def gravity_force(thing)
    debug(thing)
    debug(self)
    vector = @loc - thing.loc
    distance = vector.magnitude
    vector.normalize
    return vector * ((@mass * thing.mass) / distance**2)
  end

end

class FixedThing < Thing

  attr_reader :loc, :vel, :mass, :radius

  def initialize(location, mass)
    @mass = mass
    @loc = location
    @acc = Vector.new
    @vel = Vector.new
    @radius = 16
  end

  def update

  end
  
  def add_force(force_vector)

  end

end