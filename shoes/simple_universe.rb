require '../lib/vector'
require '../lib/thing'
require '../lib/universe'


Shoes.app :width => 200, :height => 200, :resizeable => false do
  @verse = Universe.new(200, 200, Vector.new(0, 0.2))
  @t1 = Thing.new(Vector.new(50, 0), Vector.new(1, 0), Vector.new(0, 0.125), 1.0, 0.9)
  @t2 = Thing.new(Vector.new(90, 0), Vector.new(5, 0), Vector.new(0, 0.125), 10.0, 0.85)
  @t3 = Thing.new(Vector.new(60, 0), Vector.new(-1, 0), Vector.new(0, 0.125), 1.0, 0.6)
  @t4 = Thing.new(Vector.new(70, 0), Vector.new(2, 0), Vector.new(0, 0.125), 1.0, 0.7)
  @t5 = Thing.new(Vector.new(80, 0), Vector.new(-2, 0), Vector.new(0, 0.125), 1.0, 0.99)
  @verse.things << @t1 << @t2 << @t3 << @t4 << @t5
  
  def paintv(o)
    x1 = o.loc.x
    y1 = o.loc.y
    x2 = (o.loc.x+8*o.vel.x)
    y2 = (o.loc.y+8*o.vel.y)
    stroke(gray(0.1))
    line(x1, y1, x2, y1)
    line(x2, y1, x2 + (x1<=>x2)*5, y1-2)
    line(x2, y1, x2 + (x1<=>x2)*5, y1+2)

    line(x1, y1, x1, y2)
    line(x1, y2, x1-2, y2 + (y1<=>y2)*5)
    line(x1, y2, x1+2, y2 + (y1<=>y2)*5)

    line(x1, y1, x2, y2)
    angle = o.vel.angle2D
#    rotate angle*Math::PI*2.0/360.0
    rotate 45
    line(x2, y2, x2-5, y2+2)
    line(x2, y2, x2-5, y2-2)
    rotate -45
  end
  
  def paintt(t)
    fill(gray(0.5))
    oval(t.loc.x-16/2, t.loc.y-16/2, 16, 16)
  end
  
  def paintu(u)
    u.things.each do |thing|
      paintv(thing)
      paintt(thing)
    end
  end
  
  nostroke
  animate 50 do
    clear
    @verse.update
    paintu(@verse)
  end
end