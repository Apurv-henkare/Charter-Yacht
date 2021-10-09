Credits = Class{__includes = BaseState}
local level={0,0,0,0,0,0}
function Credits:init()

  self.file=love.filesystem.newFile("ar.txt")
  if (love.filesystem.getInfo("ar.txt"))then
     self.file:open('r')
     self.count=1
     iterator = self.file:lines( )
     for i in iterator do
       level[self.count]=i
       self.count=self.count+1
       print(i)
     end
     print(tostring(iterator))
     self.file:close()
   end
 end

function Credits:update(dt)
  if Keyboard_was_Pressed('return') then
    gStateMachine:change('title')
  end
end
function Credits:render()
  love.graphics.setFont(love.graphics.newFont(25))
  love.graphics.draw(gTextures['guide'],0,0)
  love.graphics.draw(gTextures['instruction'],750,0,0,0.8,0.8)
  love.graphics.line(700,0,700,WINDOW_HEIGHT/2+200-10)
  love.graphics.printf("Status " , -300, WINDOW_HEIGHT/2+60-280-70,WINDOW_WIDTH, 'center')
  for i=1,5 do
     love.graphics.setColor(1,1,1)
     love.graphics.printf("Points collected in Level "..i.." :"..level[i].."/"..1000*i, -300, WINDOW_HEIGHT/2+60*i-180-70,WINDOW_WIDTH, 'center')
   end

love.graphics.setFont(love.graphics.newFont(28))
love.graphics.setColor(0,1,0)
  love.graphics.printf('Press Enter To Go Back To Menu', 0, WINDOW_HEIGHT/2+220,WINDOW_WIDTH, 'center')
end
