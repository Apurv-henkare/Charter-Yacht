CreateEnemy=Class{}

function CreateEnemy:init(x,y,w,h,status,angle,motion,speed)
  --self.enemy={}

  self.x=x
  self.y=y
  self.width=w
  self.height=h
  self.status=status
  self.v=0
  self.speed=speed
  self.angle=angle
  self.visible=0
  self.body=love.physics.newBody(world,self.x,self.y,motion)
  self.shape=love.physics.newRectangleShape(0, 0,self.width, self.height)
  self.fixture=love.physics.newFixture(self.body,self.shape, 0.5)
  self.fixture:setUserData(status)
  self.body:setLinearDamping(1.5)
  --self.fixture:setRestitution(0.1)
  self.body:setAngularDamping(1.5)
  self.body:setAngle(angle)
end

function CreateEnemy:Hit_Enemy()
--  enemy_col={}
  self.body:destroy()

end
