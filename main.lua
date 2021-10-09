WINDOW_WIDTH = 1200+200
WINDOW_HEIGHT = 750


-- Require Files --
Class = require 'class'
require 'states/BaseState'
require 'StateMachine'
require 'states/TiTleScreenState'
require 'states/Teams'
require 'states/PlayState'
require 'states/Bye'
require 'states/Credits'
require 'states/Status'
require 'Player'
require 'LevelMaker'
require 'CreateEnemy'
push = require "push"

gpoints=0
function love.load()
  --love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT)
  math.randomseed(os.time())
  wind_x,wind_y=love.window.getMode()
  love.physics.setMeter(100)
--  c=""

  world = love.physics.newWorld(0, 0,true)
  world:setCallbacks(beginContact, endContact, preSolve, postSolve)

  push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT,wind_x,wind_y,{
      vsync = true,
      fullscreen = true,
      resizable = true,
      pixelperfect=false, highdpi = true ,stretched = false
  })
  love.graphics.setFont(love.graphics.newFont(40))

  gStateMachine=StateMachine
 { ['teams']= function() return Teams() end,
   ['title']= function() return TiTleScreenState() end,
   ['play']= function() return PlayState() end,
   ['status']= function() return Status() end,
   ['credits']= function() return Credits() end,
   ['bye']= function() return Bye() end
 }
 
 gTextures={['artilery']=love.graphics.newImage('images/bulletgun.png'),
            ['ene']=love.graphics.newImage('images/ene.png'),
            ['treasure']=love.graphics.newImage('images/KHAJANA.png'),
            ['info_level1']=love.graphics.newImage('images/INFOR LEVEL 1 WHITE.png'),
            ['info_level2']=love.graphics.newImage('images/INFO LEVEL 2.png'),
            ['info_level3']=love.graphics.newImage('images/INFO LEVEL 3 WHITE EXCLUSIVE.png'),
            ['info_level4']=love.graphics.newImage('images/INFO LEVEL 4 WHITE.png'),
            ['info_level5']=love.graphics.newImage('images/LEVEL 5 WHITE.png'),
            ['intro']=love.graphics.newImage('images/team 26.png'),
            ['Ocean']=love.graphics.newImage('images/2.png'),
            ['Ship']=love.graphics.newImage('images/SHIP.png'),
            ['Fire']=love.graphics.newImage('images/3.png'),
            ['log']=love.graphics.newImage('images/New Project (1).png'),
            ['menu']=love.graphics.newImage('images/charter yatch.png'),
            ['exit']=love.graphics.newImage('images/exit.jpg'),
            ['guide']=love.graphics.newImage('images/guide.png'),
            ['instruction']=love.graphics.newImage('images/instruc.png'),
            ['dock']=love.graphics.newImage('images/endline.png')}

music2=love.audio.newSource('music/Nebular Focus - Dan Henig.mp3','static')
gStateMachine:change('teams')
radar=love.audio.newSource('music/radar.mp3','static')
music = love.audio.newSource('music/Timeless - Lauren Duski.mp3','static')
music3 = love.audio.newSource('music/waves.mp3','static')

love.mouse.buttonsPressed = {}
keyboard_check={}

--Particle System
img = love.graphics.newImage('images/logo.png')
psystem = love.graphics.newParticleSystem(img)
psystem:setParticleLifetime(0.2,0.5) -- Particles live at least 2s and at most 5s.
psystem:setLinearAcceleration(-1000,-1000,0,1000) -- Randomized movement towards the bottom of the screen.
psystem:setColors(255, 255, 255, 255, 255, 255, 255, 0)
end

function love.resize(w,h)
  push:resize(w,h)
end
function love.update(dt)
  world:update(dt)
  psystem:update(0.5*dt)

  gStateMachine:update(dt)
  love.mouse.buttonsPressed = {}
  keyboard_check={}
end


function love.mousepressed(x, y, button, isTouch)

  love.mouse.buttonsPressed[button] = true
  x1,y1=push:toGame(x,y)

  if x1~=nil and y1~=nil then
     gStateMachine:checking(x1,y1)
  end

end

function love.keypressed(key, scancode, isrepeat)
  keyboard_check[key]=true

end

function Keyboard_was_Pressed(key)
  if keyboard_check[key] then
    return true
  else
    return false
  end
end

function love.mouse.wasPressed(button)
    if love.mouse.buttonsPressed[button] then
      return true
    else
      return false
    end
end

function love.draw()
   push:start()
   love.graphics.setFont(love.graphics.newFont(40))
   gStateMachine:render()
   push:finish()
end
