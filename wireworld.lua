local logic = include("wireworld/lib/logic")
include('wireworld/lib/entity')
local width = 0
local height = 0
local board_width = 16
local board_height = 16
local stepX
local stepY
engine.name = "PolyPerc"

local mouse_x = 0
local mouse_y = 0

function setup_mouse()
   mouse = hid.connect()
   mouse.event = mouse_event
end

function mouse_event(type, code, val)
   val = val/2

   if code == 0 then
      mouse_x = util.clamp(mouse_x + val, 1, 128)
      redraw()
   elseif code == 1 then
      mouse_y = util.clamp(mouse_y + val, 1, 64)
      redraw()
   elseif code == 272 then -- left button
      logic:set(math.floor(mouse_x / stepX) + 1, math.floor(mouse_y / stepY) + 1, 3)
   elseif code == 273 then -- rb
   elseif code == 272 then -- middle button
   end
end

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
   screen.level(15)
   screen.pixel(mouse_x, mouse_y)
   screen.fill()
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
   setup_mouse()
end
