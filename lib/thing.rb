class Thing

  attr_reader :loc, :vel, :acc, :mass, :elastic, :radius
  attr_writer :elastic

  def initialize(location, velocity, force, mass)
    @acc = Vector.new
    @loc = location
    @vel = velocity
    @force = force
    @mass = mass
    @elastic = 1.0
    @radius = 8
  end

  def update
    @vel.add(@acc)
    @loc.add(@vel)
    @acc.x, @acc.y = 0, 0
  end

  def add_force(force_vector)
    @acc.add(force_vector / mass)
  end

end