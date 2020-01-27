--run below command in every terminal session
--alias love="/Applications/love.app/Contents/MacOS/love"

--Objects
require "player/player"
require "bullets/bullet"
require "enemies/enemyClass"

--BUMP Collision System
bump = require "lib/bump"

--Simple Tiled Implementation 
sti = require "lib/sti"

mapObjects = {}

function love.load()
	--loads game

	--STI: loading map with bump plugin
	map = sti("assets/map.lua", { "bump" })
	
	--BUMP: Prepare physics world with horizontal and vertical gravity
	world = bump.newWorld()

	--loading player
	player_1 = player:new()
	

	--STI: Create new dynamic data layer called "game" as the X layer
	map:addCustomLayer("action", 4)

	--Load player object and it's properties into BUMP world
	world:add(player_1, player_1.x, player_1.y, 32,32)

	--loading bullets
	bullet_1 = bullets:new()


	--Load STI objects and their properties into BUMP world
	for _, object in pairs(map.objects) do
		gameObj = {	name = object.name, 
					kind = object.type, 
					x = object.x, 
					y = object.y, 
					w = object.width, 
					h = object.height
				}
		world:add(gameObj, gameObj.x, gameObj.y, gameObj.w, gameObj.h)
		--[[table.insert(mapObjects,gameObj)
		--print(gameObj.kind)
		
		for k,v in ipairs(mapObjects) do
			world:add(mapObjects[k], mapObjects[k].x, mapObjects[k].y, mapObjects[k].w, mapObjects[k].h)
			print (k,v)
		end]]
		
	end
	----STI: Adds all our program objects to newly made Custom Layer
	gameLayer = map.layers["action"]
	gameLayer.objects = {
		player_1,
		bullet_1
	}
 	
	
	----STI: Update callback for Custom Layer
	function gameLayer:update(dt)
		for _, object in pairs(self.objects) do
			player_1:move(dt)
			bullet_1:shoot(player_1.x,player_1.y, dt)

		end
	end

	----STI: Draw callback for Custom Layer
	function gameLayer:draw()
		for _, object in pairs(self.objects) do
			bullet_1:draw()	
			player_1:draw()
			
		end
	end
 	
 	-- Set background where map wasn't drawn (Black)
	love.graphics.setBackgroundColor(0,0, 0)
end

function love.draw(dt)
	--draws game 
	
	--STI: Translate world so that player is always centered
	local player = gameLayer.objects[1]
	local tx = math.floor(player.x - love.graphics.getWidth() / 2)
	local ty = math.floor(player.y - love.graphics.getHeight() / 2)
	map:draw(-tx, -ty, 1, 1)
	

end

function love.update(dt)
	--updates game

	--Press X to quit game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

	--STI: Updates map
	map:update(dt)


end