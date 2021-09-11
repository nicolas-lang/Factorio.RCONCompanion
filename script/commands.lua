-------------------------------------------------------------------------------------
-- Register Commands
-------------------------------------------------------------------------------------
commands.add_command("rcon", nil, function(command)
	if (command.parameter == "print_tick") then
		msg = command.tick
	end
	
	if (command.parameter == "print_gamespeed") then
		msg = game.speed
	end
	
	if (command.parameter == "print_tickpaused") then
		msg = game.tick_paused
	end
	
	if (command.player_index ~= nil) then
		game.get_player(command.player_index).print(command.parameter .. ": " .. tostring(msg))
	else
		rcon.print(msg)
	end
end)