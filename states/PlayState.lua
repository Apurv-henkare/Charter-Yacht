PlayState = Class{__includes = BaseState}


local level =0
local types={}
local speed=-100
local level_maker
local destroyed={}
local fixtures={}

function PlayState:enter(params)
  self.level=params.level
  self.levelmaker=params.level_maker
  level_maker=params.level_maker
  self.ship=Player(self.level)
  --b=self.ship
end
function PlayState:init()

  self.score_level={0,0,0,0,0,0}
  self.treasure=0
  self.file = love.filesystem.newFile("ar.txt")

  self.count=1
  self.info=1

  self.flag = 0
	--load the highscore file
	if (love.filesystem.getInfo("ar.txt"))then

     self.file:open('r')
     iterator = self.file:lines( )
     for i in iterator do
       self.score_level[self.count]=i
       self.count=self.count+1
     end
     self.file:close()
   end

    music:setLooping(true)
    music:play()
    music:setVolume(0.4)

    music3:setLooping(true)
    music3:play()
    music3:setVolume(0.3)


end
function PlayState:update(dt)

  love.audio.stop(music2)
  psystem:emit(1)
  self.ship:update(dt)

  for k, fix in pairs(fixtures) do
         if (not fix.p1:isDestroyed()) and fix.p1:getUserData() ~='enemy_static' then
             fix.p1:destroy()
         end
         if (not fix.p2:isDestroyed()) and fix.p2:getUserData() ~='enemy_static' then
             fix.p2:destroy()
         end
     end
  for i,v in pairs(self.ship.ManyBullets) do
      if v.fixture:isDestroyed() == true  then
           table.remove(self.ship.ManyBullets,i)
      end
  end
  for keys,enemy in pairs(self.levelmaker) do
    if dist(self.ship,enemy) <=self.ship.circle_radius then
      enemy.visible=math.max(math.min(1,enemy.visible+2*dt),0)
    else
      enemy.visible=math.max(0,enemy.visible-2*dt)
    end

    if self.level == 5  then
      if enemy.status == 'enemy_dynamic'  then
        enemy.body:setY(enemy.body:getY()+enemy.speed*dt)
        if enemy.body:getY()<enemy.height/2+30 then
          enemy.body:setY(enemy.height/2+30)
          enemy.speed=-enemy.speed
        elseif enemy.body:getY()> WINDOW_HEIGHT - enemy.height/2 -30 then
           enemy.body:setY(WINDOW_HEIGHT - enemy.height/2 -30)
           enemy.speed=-enemy.speed
         end
      end
    end

    if enemy.status == 'treasure' and types['treasure'] and types['player'] then
      self.treasure =2000
      table.remove(self.levelmaker,keys)
      break
    end

    if enemy.fixture:isDestroyed() then
        if (enemy.status == 'enemy' or enemy.status == 'treasure' or enemy.status == 'enemy_dynamic')   then
          table.remove(self.levelmaker,keys)
        end
    end
  end

  fixtures={}

  for keys,bullets in pairs(self.ship.ManyBullets)do
    if bullets.body:getX()<=0 or bullets.body:getX()>=1500 then
      table.remove(self.ship.ManyBullets,keys)
    end
    if bullets.body:getY()<=0 or bullets.body:getY()>=800 then
      table.remove(self.ship.ManyBullets,keys)
    end
  end

  if types['enemy'] and types['player'] then
    self.ship.player.health=math.floor(math.max(0,self.ship.player.health-(math.sqrt((self.ship.vx)^2+(self.ship.vy)^2)*1.3*dt)))
  end
  if (types['enemy_static'] or types['enemy_dynamic'])  and types['player'] then
    self.ship.player.health=math.floor(math.max(0,self.ship.player.health-(math.sqrt((self.ship.vx)^2+(self.ship.vy)^2)*1.3*dt)))
  end
  if types['Boundary'] and types['player'] then
    self.ship.player.health=math.floor(math.max(0,self.ship.player.health-(math.sqrt((self.ship.vx)^2+(self.ship.vy)^2)*0.05*dt)))
  end

  if ((types['port'] and types['player']) and types['bullet'] == false) or self.ship.player.health <= 0 then
    if self.level == 1 then
      self.score_level[1]=math.max(self.score_level[1],(self.ship.player.health/160)*1000)
    elseif self.level == 2 then
      self.score_level[2]=math.max(self.score_level[2],(self.ship.player.health/160)*2000)
    elseif self.level == 3 then
      self.score_level[3]=math.max(self.score_level[3],(self.ship.player.health/160)*3000)
   elseif self.level == 4 then
      self.score_level[4]=math.max(self.score_level[4],(self.ship.player.health/160)*2000+self.treasure)
  elseif self.level == 5 then
      self.score_level[5]=math.max(self.score_level[5],(self.ship.player.health/160)*5000)
  end

  self.file:open('w')
  for i = 1,6 do
    self.file:write((self.score_level[i]).."\r\n")
  end
  self.file:close()
  self.file:open('r')
  iterator = self.file:lines( )
  local c=1
  self.file:close()

  local sum =0
  for i=1,6 do
    sum=sum+self.score_level[i]
  end
    gpoints=sum
    gStateMachine:change('status',{health=self.ship.player.health,level=self.levelmaker,coins=self.score_level})
  end
  if Keyboard_was_Pressed('h') then
    self.info=self.info+1
    if self.info == 2 then
      self.info =0
    end
  end
end


function beginContact(a, b, coll)

  types['canon']=false
  types['player']=false
  types['port']=false
  types['bullet']=false
  types['Boundary']=false


  types[a:getUserData()]=true
  types[b:getUserData()]=true

 if types['player']==false and
    types['canon']==false and
    types['port'] == false  and
    types['Boundary'] == false then
    table.insert(fixtures,{p1=a,p2=b})
  end

end
function endContact(a, b, coll)

  types[a:getUserData()]=false
  types[b:getUserData()]=false

  --text = false
end


function dist(p,obstacle)
  return math.sqrt((p.player.body:getX()-obstacle.body:getX())^2+(p.player.body:getY()-obstacle.body:getY())^2)
end

function PlayState:render()
  love.graphics.clear(1,1,1)
  love.graphics.draw(gTextures['Ocean'],0,0)

  for keys,enemy in pairs(self.levelmaker) do
      if keys == 1 then

     end

         if  enemy.status == 'enemy'  then
        
          if(self.level == 4) then
            love.graphics.setColor(1,1,1,enemy.visible)
            if enemy.width == 30 then
              love.graphics.draw(gTextures['ene'],enemy.body:getX(),enemy.body:getY(),enemy.body:getAngle(),1,1,15,15)
            end
            if enemy.width == 20 then
              love.graphics.draw(gTextures['ene'],enemy.body:getX(),enemy.body:getY(),enemy.body:getAngle(),0.5,0.5,15,15)
              end
          else
           love.graphics.setColor(0,0,0.7,enemy.visible)
           love.graphics.polygon("fill", enemy.body:getWorldPoints(
                                                 enemy.shape:getPoints()))
          end
        elseif enemy.status == 'enemy_static'  then
          love.graphics.setColor(0,0,0.7,enemy.visible)
          love.graphics.polygon("fill", enemy.body:getWorldPoints(
                                                enemy.shape:getPoints()))
        elseif enemy.status == 'enemy_dynamic'  then

            love.graphics.setColor(1,1,1,enemy.visible)
            love.graphics.draw(gTextures['ene'],enemy.body:getX(),enemy.body:getY(),enemy.body:getAngle(),1,1,15,15)

         elseif enemy.status == 'treasure' then
            love.graphics.setColor(1,1,1,enemy.visible)
            love.graphics.draw(gTextures['treasure'],enemy.body:getX(),enemy.body:getY(),enemy.body:getAngle(),1,1,30,25)
         end
    end
    for keys,enemy in pairs(self.levelmaker) do
      if  enemy.status == 'port'  then
        love.graphics.setColor(1,1,1)
        love.graphics.draw(gTextures['dock'],enemy.body:getX()-50,enemy.body:getY()-190)
      end
  end
  love.graphics.setColor(1,1,1)

  self.ship:render()

  love.graphics.setFont(love.graphics.newFont(20))
  love.graphics.setColor(1,1,0)
  love.graphics.printf('Radar Available', 490,20,WINDOW_WIDTH, 'center')
  love.graphics.printf(self.ship.circle_count, 600,20,WINDOW_WIDTH, 'center')
  love.graphics.printf('Health', 445,50+10,WINDOW_WIDTH, 'center')
  love.graphics.printf(self.ship.player.health,600,50+10,WINDOW_WIDTH, 'center')
  if self.level >= 4 then
    love.graphics.printf('Bullets', 445,100,WINDOW_WIDTH, 'center')
    love.graphics.printf(self.ship.maxBullets,600,100,WINDOW_WIDTH, 'center')
  end

  love.graphics.setColor(1,1,1)
  if self.info == 1 then
    if self.level == 1 then
      love.graphics.draw(gTextures['info_level1'],200,110-40,0,1,1.2)
    elseif self.level == 2 then
      love.graphics.draw(gTextures['info_level2'],200,110,0,1,1,1)
    elseif self.level == 3 then
      love.graphics.draw(gTextures['info_level3'],200,110,0,1,1,1)
    elseif self.level == 4 then
      love.graphics.draw(gTextures['info_level4'],200,110,0,1,1,1.2)
    elseif self.level == 5 then
      love.graphics.draw(gTextures['info_level5'],100,150,0,0.8,0.8)
    end
  end

end
