enemies = {}
-- Enemy class
enemyClass = {}

function enemyClass:new()
	o = o or {}
	self:load()
	return setmetatable(o, {__index=self})
end

function enemyClass:load()
	-- body
	self.image = love.graphics.newImage("enemies/blue.png")
end

function enemyClass:draw()
	-- body
end