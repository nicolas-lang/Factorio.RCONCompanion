# Factorio.RCONCompanion
Companion mod for some RCON commands to avoid disabling achievements while using RCON

Availiable commands:
- /rcon print_tick
- /rcon print_gamespeed
- /rcon print_tickpaused
- /rcon get_gamestate
- /rcon set_clock

Example Usecase:
```
#check the aws lambda_function for a complete self-contained rcon example
def getClusterUPS(self,clustername,timeframe = 5):
	try:
		clusterIP = self.getClusterIP(clustername)
		con = rCon(clusterIP,self.clusterCfg.rConPassword)
		paused = bool((con.execute('/rcon print_tickpaused')) == "true")
		if paused:
			print("Server is paused, no UPS stats avaliable")
		else:
			speed = round(float(con.execute('/rcon print_gamespeed')),3)
			tick_1 = int(con.execute('/rcon print_tick'))
			time.sleep(timeframe)
			tick_2 = int(con.execute('/rcon print_tick'))
			server_ups = (tick_2-tick_1)/timeframe
			game_ups = (speed*60)
			perf = int(round(server_ups / game_ups,2)*100)
			print("Server UPS: {0}, Expected Game UPS: {1} (Speed = {2}), Performance = {3}%".format(server_ups, game_ups, speed, perf))
	except:
		print("error, check logs")
		logging.exception('')
```