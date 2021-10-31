local function timeStringFromSeconds(seconds)
	local s = seconds % 60
	local minutes = math.floor(seconds / 60)
	local m = minutes % 60
	local hours = math.floor(minutes / 60)
	local h = hours % 24
	--return string.format("%02d:%02d:%02d", h, m, s)
	return string.format("%02d:%02d", h, m)
end

script.on_nth_tick(
	20,
	function(e)
		local real_time = global.real_time or 0
		local real_time_update = global.real_time_update or 0
		local real_ups = global.real_ups or 60
		local timeStr = ""
		if ((e.tick - global.real_time_update) < real_ups * 60 * 6) then
			-- Lambda is scheduled every 5m and UPS assumption shouldn't deviate by more than 20%
			local seconds = math.floor(real_time + (e.tick - real_time_update) / real_ups)
			timeStr = timeStringFromSeconds(seconds)
		end
		for index, player in pairs(game.connected_players) do
			--loop through all online players on the server
			local label = player.gui.top["time"]
			if label == nil then
				player.gui.top.add {type = "label", name = "time", caption = timeStr}
			else
				label.caption = timeStr
			end
		end
	end
)
