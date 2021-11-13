local function timeStringFromSeconds(seconds)
	--local s = seconds % 60
	local minutes = math.floor(seconds / 60)
	local m = minutes % 60
	local hours = math.floor(minutes / 60)
	local h = hours % 24
	--return string.format("%02d:%02d:%02d", h, m, s)
	return string.format("%02d:%02d", h, m)
end

local function update_clock(e)
	local real_time_update = global.real_time_update or 0
	if game.tick_paused then
		global.real_time_update = 0
		return
	end
	local real_ups = global.real_ups or 60
	local real_time = global.real_time or 0
	local timeStr = ""
	local update_timeout = settings.global["nco-RCONCompanion-clock_update-timeout"].value * 60
	if ((e.tick - real_time_update) < real_ups * update_timeout) then
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

if settings.global["nco-RCONCompanion-clock"].value then
	script.on_nth_tick(20, update_clock(e))
end
