Player=Class{}

function Player:init(level)

  self.level=level
  self.player={}

  self.player.x=100
  self.player.y=100
  self.player.width=160
  self.player.height=40

  self.vx=0
  self.vy=0


  self.player.emit=false
  self.player.health=160
  self.player.body=love.physics.newBody(world,100,100, "dynamic")
  self.player.shape=love.physics.newRectangleShape(0, 0, 160, 40)
  self.player.fixture=love.physics.newFixture(self.player.body,self.player.shape, 0.5)
  self.player.fixture:setUserData("player")
  self.point_x=0
  self.point_y=0
  self.point_px=0
  self.point_py=0
  self.emit=0
  self.player.body:setLinearDamping(1)
  --self.invisible=0

  self.circle_x=self.player.x
  self.circle_y=self.player.y
  self.circle_count=0
  self.circle_radius=0


  self.ManyBullets={}
  self.maxBullets=250
  self.artilery={}
  self.artilery.angle=0
  self.artilery.x=self.player.x-40
  self.artilery.y=self.player.y
  self.artilery.body=love.physics.newBody(world,self.artilery.x,self.artilery.y, "dynamic")
  self.artilery.shape=love.physics.newRectangleShape(0, 0, 20, 10)
  self.artilery.fixture=love.physics.newFixture(self.artilery.body,self.artilery.shape, 0.5)
  self.artilery.fixture:setSensor(true)
  self.artilery.fixture:setUserData('canon')
  self.artilery.body:setAngularDamping(10)

  self.health={}
  self.health.x=300
  self.health.y=300-40
  self.health.width=160
  self.health.height=10
  self.health.body=love.physics.newBody(world,300,300-40, "static")
  self.health.shape=love.physics.newRectangleShape(0, 0,self.health.width, self.health.height)

  self.health.body:setLinearDamping(1)
  self.player.body:setAngularDamping(1)
  if level == 1 then
      self.circle_count=3
  elseif level == 2  then
      self.circle_count=3
  elseif level == 3  then
      self.circle_count=5
  elseif level == 4  then
      self.circle_count=30
  elseif level == 5 then
      self.circle_count=12
      self.maxBullets=15
  end


end

function Player:update(dt)

  self.player.health=math.max(0,self.player.health)
  self.health.body:setAngle(self.player.body:getAngle())
  self.health.body:setX(self.player.body:getX())
  self.health.body:setY(self.player.body:getY()-40)
  self.health.shape=love.physics.newRectangleShape(0, 0,self.health.width, self.health.height)

  self.health.width=self.player.health

  self.circle_x=self.player.body:getX()
  self.circle_y=self.player.body:getY()

  self.vx,self.vy=self.player.body:getLinearVelocity()
  self.vx=math.abs(math.floor(self.vx))
  self.vy=math.abs(math.floor(self.vy))

  self.artilery.body:setX(self.player.body:getX())
  self.artilery.body:setY(self.player.body:getY())

  ---Controls of game---
  if love.keyboard.isDown('up') then
    self.player.body:applyForce(50*(self.point_x-self.player.body:getX())*dt,50*(self.point_y-self.player.body:getY())*dt)
    self.emit=math.min(self.emit+0.5*dt,1)
  else
    self.emit=math.max(self.emit-0.5*dt,0)
  end
  if love.keyboard.isDown('down') then
    self.player.body:applyForce(-50*(self.point_x-self.player.body:getX())*dt,-50*(self.point_y-self.player.body:getY())*dt)
  end
  if love.keyboard.isDown('right') then
    self.player.body:applyTorque(500)
  end
  if love.keyboard.isDown('left') then
   self.player.body:applyTorque(-500)
  end
  if love.keyboard.isDown('e') then
    self.artilery.body:applyTorque(10)
  end
  if love.keyboard.isDown('r') then
    self.artilery.body:applyTorque(-10)
  end

  if Keyboard_was_Pressed('space') and self.circle_count> 0 then
    self.player.emit=true
    love.audio.play(radar)

  end
  if self.player.emit == true then
    self.circle_radius=self.circle_radius+1000*dt
  end
  if self.circle_radius>=2500 then
    self.circle_radius=0
    self.circle_count=self.circle_count-1
    self.player.emit=false
  end

  self.point_x=self.player.body:getX()+160/2*math.cos(self.player.body:getAngle())
  self.point_y=self.player.body:getY()+160/2*math.sin(self.player.body:getAngle())

  self.point_px=self.player.body:getX()-160/2*math.cos(self.player.body:getAngle())
  self.point_py=self.player.body:getY()-160/2*math.sin(self.player.body:getAngle())

  if self.level >= 4 then
    if Keyboard_was_Pressed('f') and self.maxBullets> 0 then
      table.insert(self.ManyBullets,self:CreateBullets())
      self.maxBullets=self.maxBullets-1
    end

    for keys,values in pairs(self.ManyBullets) do
        values.body:setLinearVelocity(400*math.cos(values.angle),400*math.sin(values.angle))
    end
  end

end

function Player:CreateBullets()
  
  Bullet={}
  Bullet.width=10
  Bullet.height=10
  Bullet.x=self.player.body:getX()
  Bullet.y=self.player.body:getY()
  Bullet.angle=self.artilery.body:getAngle()
  Bullet.status = 'bullet'
  Bullet.body=love.physics.newBody(world,Bullet.x,Bullet.y, "dynamic")
  Bullet.shape=love.physics.newRectangleShape(0, 0,Bullet.width, Bullet.height)
  Bullet.fixture=love.physics.newFixture(Bullet.body,Bullet.shape, 0.5)
  Bullet.fixture:setUserData("bullet")
  Bullet.fixture:setSensor(true)
  return Bullet

end

function Player:render()
  love.graphics.setColor(1,1,1)
  love.graphics.setColor(1,1,1,self.emit)
  love.graphics.draw(psystem,self.point_px,self.point_py,self.player.body:getAngle())
  love.graphics.setColor(1,1,1)
  love.graphics.draw(gTextures['Ship'],self.player.body:getX(),self.player.body:getY(),self.player.body:getAngle(),1,1,160/2,40/2)

  love.graphics.setColor(0,1,0)
  love.graphics.circle('line',self.circle_x,self.circle_y,self.circle_radius)
  love.graphics.polygon("fill", self.health.body:getWorldPoints(
                        self.health.shape:getPoints()))

  love.graphics.setColor(1,1,1)
  love.graphics.draw(gTextures['artilery'],self.artilery.body:getX(),self.artilery.body:getY(),self.artilery.body:getAngle(),1,1,20/2,10/2)
  love.graphics.setColor(1,1,1)
  for i,v in pairs (self.ManyBullets) do

    love.graphics.draw(gTextures['Fire'],v.body:getX(),v.body:getY(),v.body:getAngle(),1,1,10/2,10/2)
  end

end
