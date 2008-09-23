require '../lib/vector'
require '../lib/thing'

Shoes.app :width => 200, :height => 200, :resizeable => false do
  @loc = Vector.new(200/2)
  @vel = Vector.new
  @acc = Vector.new(0, 0.125)
  @thing = Thing.new(@loc, @vel, @acc)
  
  def paintv(o)
    line(o.loc.x, o.loc.y, (o.loc.x+8*o.vel.x), (o.loc.y+8*o.vel.y))
  end
  
  def paintt(t)
    oval(t.loc.x-16/2, t.loc.y-16/2, 16, 16)
  end

  animate 50 do
    clear
    if @thing.loc.y > 200
      @thing.vel.mul(-0.85)
      @thing.loc.y = 200
    end
    @thing.update
    paintt(@thing)
    paintv(@thing)
  end
end