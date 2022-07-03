local x_size = 16
local y_size = 8
local wires ={}
local entites = {}

function init_wireworld()
   for x=1, x_size do
      wires[x] = {}
      for y = 1, y_size do
         wires[x][y] = 0
      end
   end
end

function update_wireworld()
   

end

function draw_wireworld()

end
