--bullets Class
bullets = {}
bullet_speed = player_sprint * 5
bulletRateOfFire = .2	

mapWidth = love.graphics.getWidth( ) 
mapHeight = love.graphics.getHeight( )

function bullets:new(o)
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function bullets:load()
-- load image
	self.imageUp = love.graphics.newImage("bullets/bullet_up.png")
	self.imageDown = love.graphics.newImage("bullets/bullet_down.png")
	self.imageLeft = love.graphics.newImage("bullets/bullet_left.png")
	self.imageRight = love.graphics.newImage("bullets/bullet_right.png")

	canFire = false
	bulletTimerMax = bulletRateOfFire
	bulletTimer = bulletTimerMax

	--starting speed
	self.dx = 0
	self.dy = 0


end

function bullets:shoot(a,b,dt)
--updates bullets
	--*put in update

	local keyLeft = love.keyboard.isDown("a")
	local keyRight = love.keyboard.isDown("d")
	local keyUp = love.keyboard.isDown("w")
	local keyDown = love.keyboard.isDown("s")
	local keyShoot = love.keyboard.isDown("j") or love.keyboard.isDown("k")
	--a and b are player's x and y
	self.x = a
	self.y = b

	--Used for DesiCollisions (GoalXandY)
	dx, dy = 0, 0

--Moves Bullet with correct direction and velocity
	for i, bullet in ipairs(bullets) do
		--north
		if bullet.ly > 0 then
			bullet.y = bullet.y - (bullet_speed * dt)
		--south
		elseif bullet.ly < 0 then
			bullet.y = bullet.y + (bullet_speed * dt)
		--east
		elseif bullet.lx > 0 then
			bullet.x = bullet.x + (bullet_speed * dt)
		--west
		elseif bullet.lx < 0 then
			bullet.x = bullet.x - (bullet_speed * dt)
		else
			bullet.x = bullet.x
			bullet.y = bullet.y
			bullet = bullet
		end
--Collisions
		--
		local bulletFilter = function(item, other)
			if     other.kind == 'player' then return nil
			elseif other.kind == 'bullet' then return nil
			elseif other.kind == 'walls'   then return 'touch'
			elseif other.kind == 'border' then return 'touch'
			
			else return nil
			end
		end
		--check's if world has bullet
		if world:hasItem(bullet) then
			--begin's calculating object's movement with collisions considered
			bullet.x, bullet.y, cols, len = world:move(bullet, bullet.x, bullet.y, bulletFilter)
			--loads collisions resolutions into for loop (which determines how the object's destroyed) 
			for i=1,len do
				--check's what the object's hitting and destroys based on the "other" object
				other = cols[i].other
				if other.kind == 'bullet' then
					table.remove(bullets,i)
					world:remove(bullet)
				elseif other.kind == 'walls' then
					table.remove(bullets,i)
					world:remove(bullet)
				elseif other.kind == 'border' then
					table.remove(bullets,i)
					world:remove(bullet)
				elseif other.kind == 'player' then
					table.remove(bullets,i)
					world:remove(bullet)
				end
				table.remove(bullets,i)
				print(("bullet hit %s, col.item = %s, col.other = %s, col.type = %s, col.normal = %d,%d"):format(other.kind,cols[i].item, cols[i].other, cols[i].type, cols[i].normal.x, cols[i].normal.y))
			end
		end
	end

--Creates bullet with correct direction
	if keyShoot then
		-- Used only to signify direction of bullet
		lx = lx
		ly = ly
		e = e
		if keyUp then
			lx = 0
			ly = 1
			e = self.imageUp
		elseif keyDown then
			lx = 0
			ly = -1
			e = self.imageDown

		elseif keyRight then
			lx = 1
			ly = 0
			e = self.imageRight
		elseif keyLeft then
			lx = -1
			ly = 0
			e = self.imageLeft
		end

		-- Create bullets based on direction
		self:create(lx,ly,e)
	else
		lx = lx 
		ly = ly
		e = e
	end

--Bullet Timer
	if bulletTimer > 0 then
		bulletTimer = bulletTimer - dt
	else
		canFire = true
	end

end

function bullets:create(lx,ly, img)
	if canFire then
		bullet = { 	x = self.x, 
					y = self.y, 
					lx = lx, 
					ly = ly, 
					kind = 'bullet', 
					img = img 
				}

		--This is used for the object attributes
		table.insert(bullets, bullet)
		--This is used for the collision resolution
		world:add(bullet, bullet.x, bullet.y, 16,16)

		canFire = false
		bulletTimer = bulletTimerMax
	end
end

function bullets:draw()
	-- draw
	for i, bullet in ipairs(bullets) do
		love.graphics.draw(bullet.img, bullet.x, bullet.y)
	end
end
