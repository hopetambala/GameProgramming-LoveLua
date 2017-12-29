
player = {}
player_speed = 200
player_sprint = player_speed * 2.5

function player:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function player:load()
-- Load Attributes
	--load images
	self.imageUp = love.graphics.newImage("player/link_up1.png")
	self.imageDown = love.graphics.newImage("player/link_down1.png")
	self.imageLeft = love.graphics.newImage("player/link_left1.png")
	self.imageRight = love.graphics.newImage("player/link_right1.png")

	--current image
	self.image = self.imageDown

	--starting position
	startingpoint = 300
	self.x = startingpoint
	self.y = startingpoint

	--starting speed
	self.dx = 0
	self.dy = 0

	self.kind = 'player'

end

function player:move(dt)
-- Player Movment
	local keyLeft = love.keyboard.isDown("a")
	local keyRight = love.keyboard.isDown("d")
	local keyUp = love.keyboard.isDown("w")
	local keyDown = love.keyboard.isDown("s")
	local keyShift = love.keyboard.isDown("lshift")

	--Used for Collisions
	dx, dy = 0, 0

---- normal movement
	if keyLeft then
		self.image = self.imageLeft
		dx =  - player_speed * dt
		self.dx = self.x + dx
	elseif keyRight then
		self.image = self.imageRight
		dx =  player_speed * dt
		self.dx = self.x + dx
	end

	if keyUp then
		self.image = self.imageUp
		dy =  - player_speed * dt
		self.dy = self.y + dy
	elseif keyDown then
		self.image = self.imageDown
		dy =  player_speed * dt
		self.dy = self.y + dy
	end

---- sprinted movement
	if keyLeft and keyShift then
		dx =  - player_sprint * dt
		self.dx = self.x + dx
	elseif keyRight and keyShift then
		dx =  player_sprint * dt
		self.dx = self.x + dx
	end

	if keyUp and keyShift then
		dy =  - player_sprint * dt
		self.dy = self.y + dy
	elseif keyDown and keyShift then
		dy =  player_sprint * dt
		self.dy = self.y + dy
	end


-- Collisions
		--Moving an item in the world, with collision resolution
	if dx ~= 0 or dy ~= 0 then
		local cols		
 		local playerFilter = function(item, other)
			if     other.kind == 'player' then return nil
			--if you want the bullet to not have a "recoil"
			elseif other.kind == 'bullet' then return 'cross'	
			--if you want the bullet to have a "recoil"
			--elseif other.kind == 'bullet' then return 'slide'
			elseif other.kind == 'walls'  then return 'slide'
			elseif other.kind == 'border' then return 'slide'
			
			else return nil
			end
		end
  		self.x, self.y, cols, len = world:move(self, self.x + dx, self.y + dy, playerFilter)
  		--handle/print collisions
		for i=1, len do
	  		local other = cols[i].other
	  		print(("player touched %s, col.other = %s, col.type = %s, col.normal = %d,%d"):format(other.kind, cols[i].other, cols[i].type, cols[i].normal.x, cols[i].normal.y))
		end
	end
end

function player:draw()
-- Draw Player
	--put in love:draw()
	local rotation, scale = 0, 1.35
	love.graphics.draw(self.image, math.floor(self.x), math.floor(self.y), rotation, scale, scale )	
end