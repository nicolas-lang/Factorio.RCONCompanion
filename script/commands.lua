-------------------------------------------------------------------------------------
local function csv_split(str, separator)
	local result = {}
	if separator then
		local pattern = "([^" .. separator .. "]+)"
		if str then
			for word in string.gmatch(str, pattern) do
				table.insert(result, word)
			end
		end
	end
	return result
end
-------------------------------------------------------------------------------------
local function tLen(myTable)
	numItems = 0
	for _, _ in pairs(myTable) do
		numItems = numItems + 1
	end
	return numItems
end
-------------------------------------------------------------------------------------
function rcon_command(command)
	local replys = {}
	if (command.parameter) then
		parameters = csv_split(command.parameter, " ")
		if #parameters > 0 then
			--check action
			if (parameters[1] == "print_tick") then
				replys["game.tick"] = command.tick
			end
			if (parameters[1] == "print_gamespeed") then
				replys["game.speed"] = game.speed
			end
			if (parameters[1] == "print_tickpaused") then
				replys["game.tick_paused"] = game.tick_paused
			end
			--complex actions
			if (parameters[1] == "get_gamestate") then
				replys["game.tick_paused"] = game.tick_paused
				replys["game.speed"] = game.speed
				replys["game.tick"] = command.tick
			end
			if (parameters[1] == "set_clock") then
				if (#parameters >= 2) then
					global.real_time = parameters[2]
					global.real_time_update = command.tick
					if (#parameters == 3) then
						global.real_ups = parameters[3]
					end
					replys["game.tick_paused"] = game.tick_paused
					replys["game.speed"] = game.speed
					replys["game.tick"] = command.tick
				end
			end
			--reply to source
			local reply = ""
			if (tLen(replys) == 1) then
				for _, value in pairs(replys) do
					reply = tostring(value)
				end
			else
				for key, value in pairs(replys) do
					reply = reply .. key .. "=" .. tostring(value) .. ";"
				end
				reply = string.gsub(reply, ";$", "")
			end
			if (command.player_index ~= nil) then
				game.get_player(command.player_index).print(reply)
			else
				rcon.print(reply)
			end
		end
	end
end

-------------------------------------------------------------------------------------
-- Register Commands
-------------------------------------------------------------------------------------
commands.add_command(
	"rcon",
	nil,
	function(command)
		rcon_command(command)
	end
)
