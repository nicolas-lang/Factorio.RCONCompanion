-------------------------------------------------------------------------------------
-- Register Commands
-------------------------------------------------------------------------------------
commands.add_command("rcon", nil, function(command)
	local reply
	local parameter = command.parameter
	if (parameter) then 
		--check action
		if (parameter == "print_tick") then
			reply = command.tick
		end
		if (parameter == "print_gamespeed") then
			reply = game.speed
		end
		if (parameter == "print_tickpaused") then
			reply = game.tick_paused
		end
		--reply to source
		if (command.player_index ~= nil) then
			game.get_player(command.player_index).print(parameter.. ": " .. tostring(reply))
		else
			rcon.print(reply)
		end
	end
end)