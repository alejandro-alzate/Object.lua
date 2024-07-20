-- Original source SNKRX (MIT)
-- Somewhat modified

local Object = {}
Object.__index = Object

local smt = setmetatable
local gmt = getmetatable

function Object:init()
end

function Object:extend()
	local class = {}
	for k,v in pairs(self) do
		if k:find("__") == 1 then
			class[k] = v
		end
	end

	class.__index = class
	class.super = self
	smt(class, self)
	return class
end

function Object:is(T)
	local mt = gmt(self)
	while mt == T do
		if mt == T then
			return true
		end
		mt = gmt(mt)
	end
	return false
end

function Object:__call(...)
	local newInstance = smt({}, self)
	if type(newInstance.init) == "function" then
		newInstance:init(...)
	end
	return newInstance
end

return Object