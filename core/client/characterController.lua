--[[
    Copyright 2019 Teverse
    @File core/client/characterController.lua
    @Author(s) Jay
--]]

local controller = {}

controller.character = nil -- server creates this

engine.networking:bind( "characterSpawned", function()
	repeat wait() until workspace[engine.networking.me.id]
	controller.character = workspace[engine.networking.me.id]
	if controller.camera then
		controller.camera.setTarget(controller.character)
	end
end)


controller.keyBinds = {
	w = 1,
	s = 2,
	a = 3,
	d = 4
}

engine.input:keyPressed(function (inputObj)
	if inputObj.key[controller.keyBinds] then
		engine.networking:toServer("characterSetInputStarted", inputObj.key[controller.keyBinds])
	end
end)

engine.input:keyReleased(function (inputObj)
	if inputObj.key[controller.keyBinds] then
		engine.networking:toServer("characterSetInputEnded", inputObj.key[controller.keyBinds])
	end
end)

--[[controller.update = function()
	local totalForce = vector3()
	local moved = false

	for key, force in pairs(controller.keyBinds) do
		if engine.input:isKeyDown(enums.key[key]) then
			moved=true
			totalForce = totalForce + force
		end
	end
	if moved then
		controller.character:applyForce(totalForce * controller.speed)
	end
end]]

--engine.graphics:frameDrawn(controller.update)

return controller