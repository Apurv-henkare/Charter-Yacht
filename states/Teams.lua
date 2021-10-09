Teams = Class{__includes = BaseState}

function Teams:init()
  self.count =0
end

function Teams:update(dt)
  self.count=self.count+30*dt
  if Keyboard_was_Pressed('return') or self.count>=100 then
    self.count=0
    gStateMachine:change('title')
  end
end

function Teams:render()
  love.graphics.clear(0.1,0.1,0.1)
  love.graphics.draw(gTextures['intro'],0,0)
end
