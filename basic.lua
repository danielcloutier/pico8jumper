function _init()

stepcount = 0 --count of every update() call. max 100, thant starting over at 0

currentcell = 0 --current cell id
currentcellx = 0 --x position of current cell
currentcelly = 0 --y position of current cell

camx = 0 --camera x position for scrolling
camy = 0 --camera x position for scrolling

texttoprint = "jump up to the moon"

playerformerx = 60
playerformery = 20
playerx = 60--x position of our player
playery = 20 --y position of our player
playerdy = 0
playerjumping = false
health = 5

collisionsplash = {}

gravity = 0.20

currentplayersprite = 64 --1 --sprite to draw at current cycle
firstplayersprite = 64 --1 --first playersprite in the sequence
lastplayersprite = 65 --2 --last playersprite in the sequence
pixelsperstep = 2 --less than 4 makes problems in current lazy collision detection

clouds = {}
bats = {}
shootingstars = {}
enemies = {}
waterfall = {}

amulettfound = false
moonjourney = false
moonx = 3
moony = 3

animationcycle = 0 --stepcounter for animation
dead = false
gamefinished = false

--flags on sprites
solid = 0

--items
dynamitecellid = 11
dynamiteinventorycellid = 12

  --camera(40, 140)
  makeclouds()
  makebats()
  makeenemies()
  makewaterfall(8*8,28*8) 
end


function makewaterfall(x, y) 
  local watertile1 = {}
  watertile1.x = x
  watertile1.y = y
  watertile1.type = "vertical"
  watertile1.frame = 68
  add(waterfall, watertile1)
  local watertile2 = {}
  watertile2.x = x
  watertile2.y = y + 8
  watertile2.type = "vertical"
  watertile2.frame = 69
  add(waterfall, watertile2)
  local watertile3 = {}
  watertile3.x = x
  watertile3.y = y + 16
  watertile3.type = "vertical"
  watertile3.frame = 70
  add(waterfall, watertile3)
  local watertile4 = {}
  watertile4.x = x - 8
  watertile4.y = y +16 
  watertile4.type = "horizontalleft"
  watertile4.frame = 71
  add(waterfall, watertile4)
  local watertile5 = {}
  watertile5.x = x + 8
  watertile5.y = y + 16
  watertile5.type = "horizontalright"
  watertile5.frame = 86
  add(waterfall, watertile5)
end

function makeshootingstar()
 if(stepcount%99==0) then 
   if(stepcount%4==0) then
   local shootingstar = {}
    shootingstar.age = 0
    shootingstar.maxage = 30
    shootingstar.dx = flr(rnd(2)) + 1
    shootingstar.x0 = flr(rnd(150))
    shootingstar.y0 = flr(rnd(150))
    shootingstar.x1 = shootingstar.x0 + flr(rnd(12))
    shootingstar.y1 = shootingstar.y0 + flr(rnd(7))
    add(shootingstars, shootingstar)
  end
  end
end

function makebats()
	for c=0,16 do
	  local bat = {}
	  bat.x = flr(rnd(300))
	  bat.y = flr(rnd(200))
	  if(rnd(2) > 1) then -- some fly left, some right
	     bat.dx = rnd(0.3)
	  else
          bat.dx = rnd(0.3) * -1	  
	  end
	  if(rnd(2) > 1) then -- some up and down
	     bat.dy = rnd(0.2)
	  else
          bat.dy = rnd(0.2) * -1	  
	  end
	  bat.sprite = flr(rnd(3))
	  add(bats, bat)
	end
end

function makeclouds()
	for c=0,15 do
	  local cloud1 = {}
	  cloud1.x = flr(rnd(200))
	  cloud1.y = flr(rnd(300))
	  cloud1.sprite1 = 41
	  cloud1.sprite2 = 42
	  cloud1.dx = rnd(0.09)
	  if(c%2==0) then 
	     cloud1.inverted = true
      else	  
	     cloud1.inverted = false
      end
	  add(clouds, cloud1)
	end
end

function makeenemies()
  local enemy = {}
  enemy.type = "imp"
  enemy.x = 20
  enemy.y = 240
  enemy.dx = rnd(0.7)
  enemy.xmax1 = 15
  enemy.xmax2 = 55
  enemy.ymax1 = 240
  enemy.ymax2 = 240
  enemy.sprite = 57
  add(enemies, enemy)
  local enemy2 = {}
  enemy2.type = "imp"
  enemy2.x = 90
  enemy2.y = 193
  enemy2.dx = rnd(0.7)
  enemy2.xmax1 = 86
  enemy2.xmax2 = 114
  enemy2.ymax1 = 193
  enemy2.ymax2 = 193
  enemy2.sprite = 58
  add(enemies, enemy2)
    local enemy3 = {}
  enemy3.type = "imp"
  enemy3.x = 90
  enemy3.y = 129
  enemy3.dx = rnd(0.7)
  enemy3.xmax1 = 86
  enemy3.xmax2 = 114
  enemy3.ymax1 = 129
  enemy3.ymax2 = 129
  enemy3.sprite = 59
  add(enemies, enemy3)
    local enemy4 = {}
  enemy4.type = "imp"
  enemy4.x = 132
  enemy4.y = 73
  enemy4.dx = rnd(0.8)
  enemy4.xmax1 = 130
  enemy4.xmax2 = 156
  enemy4.ymax1 = 129
  enemy4.ymax2 = 129
  enemy4.sprite = 59
  add(enemies, enemy4)
    local enemy5 = {}
  enemy5.type = "gargoyle"
  enemy5.x = 128
  enemy5.y = 145
  enemy5.dx = rnd(1)
  enemy5.dy = rnd(1)
  enemy5.xmax1 = 126
  enemy5.xmax2 = 130
  enemy5.ymax1 = 125
  enemy5.ymax2 = 150
  enemy5.sprite = 96
  add(enemies, enemy5)
     local enemy6 = {}
  enemy6.type = "imp"
  enemy6.x = 270
  enemy6.y = 185
  enemy6.dx = rnd(1)
  enemy6.xmax1 = 262
  enemy6.xmax2 = 282
  enemy6.ymax1 = 185
  enemy6.ymax2 = 185
  enemy6.sprite = 59
  add(enemies, enemy6)
  local enemy7 = {}
  enemy7.type = "gargoyle"
  enemy7.x = 270
  enemy7.y = 155
  enemy7.dx = rnd(0.8)
  enemy7.dy = rnd(1.2)
  enemy7.xmax1 = 268
  enemy7.xmax2 = 278
  enemy7.ymax1 = 130
  enemy7.ymax2 = 155
  enemy7.sprite = 96
  add(enemies, enemy7)
    local enemy8 = {}
  enemy8.type = "gargoyle"
  enemy8.x = 98
  enemy8.y = 70
  enemy8.dx = rnd(1.3)
  enemy8.dy = rnd(1.2)
  enemy8.xmax1 = 98
  enemy8.xmax2 = 118
  enemy8.ymax1 = 60
  enemy8.ymax2 = 105
  enemy8.sprite = 96
  add(enemies, enemy8)
     local enemy9 = {}
  enemy9.type = "imp"
  enemy9.x = 70
  enemy9.y = 65
  enemy9.dx = rnd(1.1)
  enemy9.xmax1 = 52
  enemy9.xmax2 = 82
  enemy9.ymax1 = 65
  enemy9.ymax2 = 65
  enemy9.sprite = 59
  add(enemies, enemy9)
  end

function _update()
 stepcount += 1
 if(stepcount == 100) then stepcount = 0 end
 currentcellx = getcurrentcellx(playerx)
 currentcelly = getcurrentcelly(playery)
 currentcell = mget(currentcellx,currentcelly)

 
  if (btn(0)) then
   moveplayer(-pixelsperstep, 0)
 end
 if (btn(1)) then
   moveplayer(pixelsperstep, 0)
 end
 if (btn(2)) then
   jump()
 end
 if (btn(3)) then
   moveplayer(0, pixelsperstep)
 end
 if (btn(4)) then
   fire()
 end
 
if(moonjourney) then 
   movemoon()
   if(moonx > 40) then  -- As soon as the moon is out the screen, start  
      gamefinished = true
   end
 end


 movecamera(playerx, playery)
 moveshootingstars()
 makeshootingstar() -- once every 100 steps
 moveclouds()
 movebats()
 moveenemies()
 movewaterfall()
 playerdy += gravity
 moveplayer(0, playerdy)
 playerformerx = playerx --save x for next iteration
 playerformery = playery --save y for next iteration
 
end

 function movemoon()
   moonx += 0.25
    playerx += 0.25 * 8   -- keep the player on the moon as it travels
 end
 
 --more like animate
function movewaterfall() 
if(stepcount % 5 == 0) then
  for i=1,5 do
     local water = waterfall[i]
	 if(water.type == "vertical") then
	   water.frame += 1
	   if(water.frame == 71) then
	     water.frame = 68
	   end
	 end
	 if(water.type == "horizontalleft") then
	   water.frame += 1
	   if(water.frame == 74) then
	     water.frame = 71
	   end
	 end
	 if(water.type == "horizontalright") then
	   water.frame += 1
	   if(water.frame == 89) then
	     water.frame = 86
	   end
	 end
  end
  end
end 
 
function moveplayer(changex, changey)
  local newx = playerx + changex
  local newy = playery + changey

  if(collision(newx, newy)) then
    playerdy = 0
	if(collisiondown(newx, newy)) then
	   playerjumping = false
	end
	enemiescollision()
     return
    end
 
 
 --check for final moon jump 
 if(currentcell== 46) then -- if above moon
   texttoprint = "something is missing"
   if(amulettfound) then  -- start only if the hidden amulett is found
   texttoprint = "starting moon journey"
    startmoonjourney()
    end
 end
 
  if(currentcell== 67) then
    texttoprint = "you've found an amulett!"
    amulettfound = true
	mset(22,18,09)
 end

 --check for dark mode trigger
 if(currentcell== 47) then
  texttoprint = "something changed"
  triggerdarkmode() -- make amulett isle black and grey
  mset(22,18,67) --set amulett visible
 end
 
    playerx += changex
	playery += changey

    if(stepcount%3==0) then 
     if(currentplayersprite <=lastplayersprite) then 
      currentplayersprite += 1
     else 
      currentplayersprite = firstplayersprite
     end
    end
end

function triggerdarkmode()
  mset(21,19,16)
  mset(22,19,32)
  mset(23,19,33)
  mset(24,19,17)
end

function startmoonjourney()
   moonjourney = true
   mset(4,4,24)
   mset(5,4,6)
   mset(4,5,7)
   mset(5,5,6)
   gravity = 0
   playery = 20
   playerdy = 0
   end

function moveshootingstars()
  foreach(shootingstars, moveshootingstar)
end

function moveshootingstar(star)
  if(star.age == star.maxage) then
    del(shootingstars, star)
	return
  end
  
  diffw = star.x1 - star.x0
  diffh = star.y1 - star.y0
  quotient = diffh / diffw
  
  star.x0 += star.dx
  star.x1 += star.dx
  star.y0 += quotient * star.dx
  star.y1 += quotient * star.dx
  
  ydiff = star.y1 - star.y0
  quotient = ydiff / star.y0
  star.y0 += (star.dx / 100 * quotient)
  star.y1 += (star.dx / 100 * quotient)
  star.age += 1
end

function moveenemies()
  foreach(enemies, moveenemy)
  enemiescollision()
end

function moveenemy(enemy)
  if(enemy.x < enemy.xmax1 or enemy.x > enemy.xmax2) then
    enemy.dx = enemy.dx * -1
  end
  if(enemy.type=="gargoyle") then
    if(enemy.y < enemy.ymax1 or enemy.y > enemy.ymax2) then
      enemy.dy = enemy.dy * -1
    end	
    enemy.y += enemy.dy
	end
  enemy.x += enemy.dx

end

function movebats()
  foreach(bats, movebat)  
end

function movebat(bat)
  if(bat.x < 10) then
     bat.x = 300
  end
  if(bat.y < 10) then
     bat.y = 200
  end
  if(bat.x > 300) then
     bat.x = 10
  end
  if(bat.y > 200) then
     bat.y = 10
  end
  bat.x -= bat.dx
  bat.y -= bat.dy
  if(stepcount % 3 == 0) then
	  if(bat.sprite > 3) then
		 bat.sprite = 1
	  else 
		bat.sprite += 1 
	   end	
	end
end

function moveclouds()
  foreach(clouds, movecloud)  -- call movecloud(cloud) for every entry/every cloud in table clouds
end

function movecloud(cloud)
  if(cloud.x < 10) then
     cloud.x = 300
  end
  cloud.x -= cloud.dx
end

function enemiescollision()
  foreach(enemies, enemycollision)
end

function enemycollision(enemy)
  local enx0 = enemy.x - 4
  local enx1 = enemy.x + 4
  local eny0 = enemy.y - 4
  local eny1 = enemy.y + 4
  local plx0 = playerx - 4
  local plx1 = playerx + 4
  local ply0 = playery - 8
  local ply1 = playery --+ 4
  local collisionx = false
  local collisiony = false
  
  --collisions at X
  if(enx0 > plx0 and enx0 < plx1) then
     collisionx = true
  elseif(enx1 > plx0 and enx1 < plx1) then
    collisionx = true
  end

  if(eny0 > ply0 and eny0 < ply1) then
     collisiony = true
  elseif(eny1 > ply0 and eny1 < ply1) then
    collisiony = true
  end
  
  if(collisionx) then
    if(collisiony) then  
	  collisionjump()
	  texttoprint = "ouch!"
	end
end

end

function collision(x,y) 
  if(fget(mget((x+8)/8, (y+8)/8),solid)) then 
	 return true
  elseif(fget(mget((x+8)/8, (y+15)/8),solid)) then 
	 return true
  elseif(fget(mget((x+15)/8, (y+8)/8),solid)) then 
	 return true
  elseif(fget(mget((x+15)/8, (y+15)/8),solid))  then 
	 return true
  end
end

function collisiondown(x,y) 
  if(fget(mget((x+8)/8, (y+15)/8),solid)) then 
	 return true
  elseif(fget(mget((x+15)/8, (y+15)/8),solid))  then 
	 return true
  end
end

function movecamera(x,y)
    camx = x - (128 / 2)
	camy = y - (128 / 2)

	if(moonjourney) then 
	   camx = moonx * 8 - (128 / 2)
	   camy = moony * 8 - (128 / 2)
	end
	
	if(camx < 0) then 
	   camx = 0
	end
    if(camx > 200) then 
	   camx = 200
	end
	if(camy < 0) then 
	   camy = 0
	end
	if(camy > 140) then 
	   camy = 140
	end
    camera(camx, camy)
end

function _draw()
 cls()

 if(dead) then 
   printdeadscreen()
   return
 end
 
  if(gamefinished) then 
   printendscreen()
   return
 end
 
 map(1,1)
 drawclouds()
  drawbats()
 drawshootingstars()
drawenemies()
drawwaterfall()
-- if not(moonjourney) then
    spr(currentplayersprite,playerx,playery) 
--  end 
  animatemap()
 drawmoon()
 drawui()
end

function drawmoon()
  local mooncellx = moonx*8
  local mooncelly = moony*8
  spr(74, mooncellx, mooncelly)
  spr(75, mooncellx+8, mooncelly)
  spr(90, mooncellx, mooncelly+8)
  spr(91, mooncellx+8, mooncelly+8)
end

function drawui()
 --rectfill(camx, camy+116, camx+127, camy+127, 4 )
 print(texttoprint, camx+4, camy+120, 9)
drawhearts() 
end

function drawwaterfall()

  for i=1, 5 do
    spr(waterfall[i].frame, waterfall[i].x, waterfall[i].y)
  end

end

function drawhearts()
  local posheartx = camx + 4
  local poshearty = camy + 4
  for i=1,health do
    spr(44, posheartx, poshearty)
	posheartx += 8
  end
end

function drawenemies()
  foreach(enemies, drawenemy)
end

function drawenemy(enemy)

if(stepcount % 3 == 0) then
  enemy.sprite += 1
end
if(enemy.type=="imp") then
  if(enemy.sprite == 60) then
    enemy.sprite = 57
  end
end
if(enemy.type=="gargoyle") then
  if(enemy.sprite == 99) then
    enemy.sprite = 96
  end
end

  spr(enemy.sprite, enemy.x, enemy.y)
end

function drawclouds()
  foreach(clouds, drawcloud)
end

function drawcloud(cloud)
  spr(41, cloud.x, cloud.y, 1, 1, cloud.inverted, false)
  spr(42, cloud.x-8, cloud.y, 1, 1, cloud.inverted, false)
end

function drawbats()
  foreach(bats, drawbat)
end

function drawbat(bat)
  spr(52+bat.sprite, bat.x, bat.y)
end

function drawshootingstars()
  foreach(shootingstars, drawshootingstar)
end

function drawshootingstar(star)
  line( star.x0, star.y0, star.x1, star.y1, 7)
end

function fire()
end

function jump()
  if not (playerjumping) then
    playerdy = -3
    moveplayer(0, playerdy)
    playerjumping = true
  end
end

function collisionjump()
    playerdy = -3
    moveplayer(0, playerdy)
    playerjumping = true
   health -= 1
    
	 if(health == 0) then
	   dead = true
	end

 end

 function makecollisionsplash()
   --TODO
 end

--todo: iterate over all relevant sprites from map and 
--animate generically with for each, check on fget(x,y,label)
function animatemap()
 
 -- Animate all the things!
mset(11,09, 37 + animationcycle)   --fire
mset(15,31, 37 + animationcycle)   --fire
mset(19,22, 37 + animationcycle)   --fire
mset(13,17, 37 + animationcycle)   --fire

mset(9,13, 11 + animationcycle)   --star
mset(10,06, 11 + animationcycle)   --star
mset(4,7, 27 + animationcycle)   --star
mset(6,25, 11 + animationcycle)   --star
mset(22,21, 27 + animationcycle)   --star

 if(stepcount % 10 == 0) then
   animationcycle += 1
   if(animationcycle == 4) then
     animationcycle = 0
   end 
 end
end

function printdeadscreen()
  print("! d e a d !", camx+30, camy+60, 8)
end

function printendscreen()
  print("Congratulations.", camx+1, camy+40, 11)
  print("You are now", camx+1, camy+48, 11)
  print("on the moon.", camx+1, camy+64,12)
end

function getcurrentcellx(x)
  return (x+8)/8
end

function getcurrentcelly(y)
  return (y+8)/8
end 
