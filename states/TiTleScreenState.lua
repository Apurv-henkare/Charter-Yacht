TiTleScreenState = Class{__includes = BaseState}
---stores co-cordinates of levels-


function TiTleScreenState:init()

  self.mouse_x=0
  self.mouse_y=0

  self.level=1
  ---Cicles Levels System
  self.Many_levels_corrdinates={}
  for i=1,2 do
    table.insert(self.Many_levels_corrdinates,{x=100,y=200*i,r=50,collide=false})
    table.insert(self.Many_levels_corrdinates,{x=285,y=200*i,r=50,collide=false})
  end
    table.insert(self.Many_levels_corrdinates,{x=100,y=600,r=50,collide=false})
  -- Rectangle Selection System
  self.Menu_selection={}
  for i=0,2 do
    table.insert(self.Menu_selection,{x=WINDOW_WIDTH/2+70-25+50+20,y=WINDOW_HEIGHT/2+50+100*i,width=300,height=50,collide=false})
  end
  music2:setLooping(true)
  music2:play()
  music2:setVolume(0.7)
end

function TiTleScreenState:update(dt)
  if Keyboard_was_Pressed('escape') then
    love.event.quit()
  end

  love.audio.stop(music)
  love.audio.stop(music3)


  self.mouse_x,self.mouse_y=push:toGame(love.mouse.getX(),love.mouse.getY())
  for keys,values in pairs(self.Menu_selection) do
    if self.mouse_x~=nil and self.mouse_y~=nil then
      if Rect_coll(values,self.mouse_x,self.mouse_y) then
         values.collide=true
      else
        values.collide=false
      end
    end
  end

  for keys,values in pairs(self.Many_levels_corrdinates) do
    if self.mouse_x~=nil and self.mouse_y~=nil then
      if Circle_coll(values,self.mouse_x,self.mouse_y) < values.r then
         values.collide=true
      else
        values.collide=false
      end
    end
  end

end


function TiTleScreenState:checking(x,y)
  for keys,values in pairs(self.Menu_selection) do
    if Rect_coll(values,x,y) then
      if keys == 3 then
        --love.event.quit()
        gStateMachine:change('bye')
      elseif keys == 1 then
        gStateMachine:change('play',{level=self.level,level_maker=LevelMaker:CreateLevel(self.level)})
      elseif keys == 2 then
        gStateMachine:change('credits')
      end
    end

  end

  for keys,values in pairs(self.Many_levels_corrdinates) do
    --if x~=nil and y~=nil then
      if Circle_coll(values,x,y) < values.r then
         self.level=keys
      end
  --  end
  end

end

function Rect_coll(values,x,y)
  return x<values.x+values.width and
        x+tonumber(2)>values.x and
        y<values.y+values.height and
        y+tonumber(2)>values.y
  end

function Circle_coll(values,x,y)
  return math.sqrt((values.x-x)^2 + (values.y-y)^2)
end

function TiTleScreenState:render()

  love.graphics.setLineWidth(4)
  love.graphics.setColor(0,1,1)
  love.graphics.rectangle('line',0,0,WINDOW_WIDTH,WINDOW_HEIGHT)
  love.graphics.setLineWidth(5)
  love.graphics.setColor(1,1,1)
  love.graphics.draw(gTextures['menu'],0,0)
  love.graphics.setColor(1,1,1)

  love.graphics.print("Play Game",WINDOW_WIDTH/2+70+25+50+20,WINDOW_HEIGHT/2+50+100*0)
  love.graphics.print("Information",WINDOW_WIDTH/2+70+25+50+20,WINDOW_HEIGHT/2+50+100*1)
  love.graphics.print("Quit",WINDOW_WIDTH/2+70+25+55+50+20,WINDOW_HEIGHT/2+50+100*2)

  love.graphics.printf('Level'..self.level, 0-500, 20,WINDOW_WIDTH, 'center')
  ---- For Play Help Exit -----
  for keys,values in pairs(self.Menu_selection) do
    if values.collide == true then
      love.graphics.setColor(1,0,1)
      love.graphics.rectangle('line',values.x,values.y,values.width,values.height,12)
      if keys == 1 then
        love.graphics.print("Play Game",WINDOW_WIDTH/2+70+25+50+20,WINDOW_HEIGHT/2+50+100*0)
      elseif keys == 2 then
        love.graphics.print("Information",WINDOW_WIDTH/2+70+25+50+20,WINDOW_HEIGHT/2+50+100*1)
      elseif keys == 3 then
        love.graphics.print("Quit",WINDOW_WIDTH/2+70+25+55+50+20,WINDOW_HEIGHT/2+50+100*2)
      end
    else
      love.graphics.setColor(1,1,1)
      love.graphics.rectangle('line',values.x,values.y,values.width,values.height,12)

    end
  end
    love.graphics.setColor(1,1,1)

  ----- For Levels Rectangle ---
  for keys,values in pairs(self.Many_levels_corrdinates) do
    if values.collide == true then
      love.graphics.setColor(1,0.4,0)
      love.graphics.circle('line',values.x,values.y,values.r)
      love.graphics.print(keys,values.x-10,values.y-20)
    else
      love.graphics.setColor(1,1,1)
      love.graphics.circle('line',values.x,values.y,values.r)
      love.graphics.print(keys,values.x-10,values.y-20)
    end
  end
end
