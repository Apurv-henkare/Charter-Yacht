
LevelMaker=Class{}

function LevelMaker:CreateLevel(level)
  local enemy_col={}


   local boundaries={{x=2,y=WINDOW_HEIGHT/2,w=1,h=WINDOW_HEIGHT,status='Boundary',angle=0,motion='static'},
                       {x=WINDOW_WIDTH/2,y=0,w=WINDOW_WIDTH,h=1,status='Boundary',angle=0,motion='static'},
                       {x=WINDOW_WIDTH,y=WINDOW_HEIGHT/2,w=1,h=WINDOW_HEIGHT,status='Boundary',angle=0,motion='static'},
                       {x=WINDOW_WIDTH/2,y=WINDOW_HEIGHT,w=WINDOW_WIDTH,h=1,status='Boundary',angle=0,motion='static'}}

  for keys,values in pairs(boundaries) do
          enemy=CreateEnemy(values.x,values.y,values.w,values.h,values.status,values.angle,values.motion)
          table.insert(enemy_col,enemy)
  end
  if level == 1 then
    local level1_array={ {x=400,y=200,w=50,h=200,status='enemy',angle=0.4,motion='dynamic'},
                         {x=650,y=450,w=200,h=200,status='enemy',angle=0,motion='dynamic'},
                         {x=1000,y=150,w=60,h=250,status='enemy',angle=-math.pi/6,motion='dynamic'},
                         {x=1000,y=600,w=60,h=250,status='enemy',angle=math.pi/6,motion='dynamic'},
                         {x=400,y=600,w=80,h=80,status='enemy',angle=0,motion='dynamic'},
                         {x=1350,y=400,w=100,h=380,status='port',angle=0,motion='static'}}

    for keys,values in pairs(level1_array) do
      enemy=CreateEnemy(values.x,values.y,values.w,values.h,values.status,values.angle,values.motion,0)
      table.insert(enemy_col,enemy)
    end

  elseif level == 2 then
    local level1_array={{x=500,y=150,w=200,h=200,status='enemy',angle=0,motion='dynamic'},
                        {x=400,y=500,w=500,h=250,status='enemy',angle=0,motion='dynamic'},
                        {x=800,y=70,w=300,h=100,status='enemy',angle=0,motion='dynamic'},
                        {x=750,y=490,w=70,h=350,status='enemy',angle=0,motion='dynamic'},
                        {x=950,y=300,w=180,h=150,status='enemy',angle=0,motion='dynamic'},
                        {x=1050,y=650,w=220,h=150,status='enemy',angle=0,motion='dynamic'},
                        {x=1350,y=400,w=100,h=380,status='port',angle=0,motion='dynamic'}}

    for keys,values in pairs(level1_array) do
      enemy=CreateEnemy(values.x,values.y,values.w,values.h,values.status,values.angle,values.motion,0)
      table.insert(enemy_col,enemy)
    end

  elseif level == 3 then
    local level1_array={{x=400,y=140,w=200,h=200,status='enemy',angle=0,motion='dynamic'},
                        {x=200,y=400,w=350,h=80,status='enemy',angle=0,motion='dynamic'},
                        {x=350,y=650,w=550,h=100,status='enemy',angle=-math.pi/20,motion='dynamic'},
                        {x=720,y=280,w=200,h=300,status='enemy',angle=0,motion='dynamic'},
                        {x=920,y=550,w=300,h=150,status='enemy',angle=0,motion='dynamic'},
                        {x=1230,y=640,w=40,h=180,status='enemy',angle=-math.pi/4,motion='dynamic'},
                        {x=980,y=150,w=130,h=250,status='enemy',angle=0,motion='dynamic'},
                        {x=1350,y=400,w=100,h=380,status='port',angle=0,motion='dynamic'}}

                      for keys,values in pairs(level1_array) do
                        enemy=CreateEnemy(values.x,values.y,values.w,values.h,values.status,values.angle,values.motion,0)
                        table.insert(enemy_col,enemy)
                      end

  elseif level == 4 then
    local level_4={}
    for i=1,18 do
      for j=5,20 do
        table.insert(level_4,{x=400*j*0.14,y=80*i*0.5,w=20,h=20,status='enemy',angle=0,motion='static'})
      end
    end

    for i=5,20 do
      for j=1,20 do
        table.insert(level_4,{x=400*j*0.14,y=80*i*0.5,w=30,h=30,status='enemy',angle=0,motion='static'})
      end
    end
    table.insert(level_4,{x=400*math.random(0.5,2),y=80*math.random(6,8),w=60,h=50,status='treasure',angle=0,motion='static'})
    table.insert(level_4,{x=1350,y=400,w=100,h=380,status='port',angle=0,motion='dynamic'})

    for keys,values in pairs(level_4) do
      enemy=CreateEnemy(values.x,values.y,values.w,values.h,values.status,values.angle,values.motion,0)
      table.insert(enemy_col,enemy)
    end


  elseif level == 5 then
    local level5={{x=350,y=150,w=200,h=200,status='enemy_static',angle=0,motion='static',s=0},
                  {x=180,y=450,w=80,h=380-20,status='enemy_static',angle=0,motion='static',s=0},
                  {x=400,y=550,w=100,h=250,status='enemy_static',angle=0,motion='static',s=0},
                  {x=500,y=200,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=100},
                  {x=550,y=600,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=-100},
                  {x=600,y=600,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=50},
                  {x=650,y=600,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=-50},
                  {x=700,y=600,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=-100},
                  {x=750,y=600,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=75},
                  {x=800,y=600,w=30,h=30,status='enemy_dynamic',angle=0,motion='static',s=-40},
                  {x=900,y=350+50,w=100,h=450,status='enemy_static',angle=0,motion='static',s=0},
                  {x=1075+10,y=200,w=50,h=250,status='enemy_static',angle=0,motion='static',s=0},
                  {x=1075+10,y=600,w=50,h=250,status='enemy_static',angle=0,motion='static',s=0},
                  {x=1350,y=400,w=100,h=380,status='port',angle=0,motion='dynamic'}}
    for keys,values in pairs(level5) do
      enemy=CreateEnemy(values.x,values.y,values.w,values.h,values.status,values.angle,values.motion,values.s)
      table.insert(enemy_col,enemy)
    end

  end
  return enemy_col
end
