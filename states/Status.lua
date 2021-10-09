Status = Class{__includes = BaseState}

local score=0
function Status:enter(params)
  self.health=params.health
  self.level=params.level
  self.coins=params.coins

end
function Status:init()

  self.score=self.health

end
function Status:update(dt)

  for _, body in pairs(world:getBodies()) do
    body:destroy()
  end
  if Keyboard_was_Pressed('return') then
    gStateMachine:change('title')
  end

end

function Status:render()
  love.graphics.setColor(1,1,1)
  love.graphics.draw(gTextures['Ocean'],0,0)
  love.graphics.setFont(love.graphics.newFont(30))
  if self.health <= 0 then
   love.graphics.printf('Ship Wrecked Try Again!!', 0, WINDOW_HEIGHT/2-250,WINDOW_WIDTH, 'center')
 else
   love.graphics.printf('Congratulation You Won!!', 0, WINDOW_HEIGHT/2-250,WINDOW_WIDTH, 'center')
 end
 love.graphics.printf('Points Earned So Far :'..gpoints, 0, WINDOW_HEIGHT/2-170,WINDOW_WIDTH, 'center')
 for i=1,5 do
    love.graphics.setColor(0,1,0)
    love.graphics.printf("Points collected in Level "..i.." :"..self.coins[i].."/"..1000*i, 0, WINDOW_HEIGHT/2+60*i-130,WINDOW_WIDTH, 'center')
  end
 love.graphics.setColor(1,1,1)
 love.graphics.printf('Press Enter To Back To Main Menu!!', 0, WINDOW_HEIGHT/2+300,WINDOW_WIDTH, 'center')


end
