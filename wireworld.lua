local logic = include("wireworld/lib/logic")
include('wireworld/lib/entity')
local width = 0
local height = 0
local board_width = 16
local board_height = 16
engine.name = "PolyPerc"

function redraw()
   screen.clear()
   for x = 1, board_width do
      for y = 1, board_height do
         local entity = logic.entities[x][y]
         if entity then
            entity:draw((x - 1) * stepX, (y - 1) * stepY, stepX, stepY)
         elseif logic.cells[x][y] == 1 then
            screen.level(12)
            screen.rect((x - 1) * stepX, (y - 1) * stepY, stepX, stepY)
            screen.stroke()
         elseif logic.cells[x][y] == 2 or logic.cells[x][y] == 3 then
            screen.level(0)
            screen.level(2)
            screen.rect((x - 1) * stepX, (y - 1) * stepY, stepX, stepY)
            screen.stroke()
         end
      end
   end
   screen.update()
end

function main_loop()
   while true do
      clock.sync(1/4)
      logic:update()
      redraw()
   end
end

function init()
   engine.release(3)
   logic:init(board_width, board_height)
   logic:set(1, 3, 1)
   logic:set(2, 3, 3)
   logic:set(3, 3, 3)
   logic:set(4, 3, 3)
   logic:set(5, 2, 3)
   logic:set(5, 4, 3)
   logic:set(6, 2, 3)
   logic:set(6, 4, 3)
   logic:set(7, 3, 3)
   logic:set(8, 3, 3)
   logic:set(9, 3, 3)
   logic:set(9, 4, 3)
   logic:set(9, 5, 3)
   logic:set(9, 6, 3)
   logic:set(8, 7, 3)
   logic:set(7, 7, 3)
   logic:set(6, 7, 3)
   logic:set(10, 7, 3)
   logic:set(10, 8, 3)
   logic:set(10, 9, 3)
   
   logic:set(11, 7, 3)
   logic:set(12, 7, 3)
   logic:set(13, 7, 3)
   logic:add_entity(14,7, new_electron_generator(5))
   width = 128
   height = 64
   logic:add_entity(4,4, new_constant_note_entity(220))
   logic:add_entity(5,7, new_constant_note_entity(440))
   logic:add_entity(10,10, new_constant_note_entity(220))
   logic:add_entity(1,3, new_electron_generator(4))
   stepX = width/board_width
   stepY = height/board_height
   clock_id = clock.run(main_loop)
end
