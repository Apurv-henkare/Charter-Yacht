Bye = Class{__includes = BaseState}

function Bye:init()
  self.count=0
end

function Bye:update(dt)
  self.count=self.count+20*dt

  if self.count >=100 then
    love.event.quit()
  end
end

function Bye:render()
  love.graphics.draw(gTextures['exit'],0,0)
end
