class Universe

  attr_reader :width, :height, :things

  def initialize(width, height, gravity)
    @things = []
    @width = width
    @height = height
    @border = true
    @gravity = gravity
  end

  def update
    @things.each do |thing|
      if @border
        bounce(thing)
      end
      mutual_gravity(thing)
      thing.add_force(@gravity * thing.mass)
      thing.update
    end
  end

  def mutual_gravity(thing)
    @things.each do |otherthing|
      if thing != otherthing
        thing.add_force(otherthing.gravity_force(thing))
      end
    end
  end

  def bounce(thing)
    if thing.loc.x < 0 + thing.radius
      thing.loc.x = 0 + thing.radius
      thing.vel.x *= -1 * thing.elastic
    elsif thing.loc.x > @width - thing.radius
      thing.loc.x = @width - thing.radius
      thing.vel.x *= -1 * thing.elastic
    end
    if thing.loc.y < 0 + thing.radius
      thing.loc.y = 0 + thing.radius
      thing.vel.y *= -1 * thing.elastic
    elsif thing.loc.y > @height - thing.radius
      thing.loc.y = @height - thing.radius
      thing.vel.y *= -1 * thing.elastic
    end
    
  end


end