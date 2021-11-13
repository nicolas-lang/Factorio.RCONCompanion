# pip install custom package to /tmp/ and add to path
import os,sys
os.system('pip install factorio-rcon-py -t /tmp/ --no-cache-dir')
sys.path.insert(1, '/tmp/')

#main script
import logging
import factorio_rcon
from datetime import datetime
from dateutil import tz
from factorio_rcon import InvalidPassword
from factorio_rcon import RCONConnectError

class rCon():
	def __init__(self,hostname, password):
		self.hostname = hostname
		self.password = password
		try:
			self.con = factorio_rcon.RCONClient(self.hostname, 27015, self.password)
		except InvalidPassword:
			Print('InvalidPassword')
			logging.exception('')
		except RCONConnectError:
			Print('RCONConnectError')
			logging.exception('')
		except:
			logging.exception('')
	def __del__(self):
		try:
			if self.con:
				self.con.close()
				logging.info('closed rcon connection')
		except:
			logging.exception('')
	def execute(self, command):
		try:
			response = self.con.send_command(command)
			logging.info(response)
			return response
		except:
			logging.exception('')
			
def lambda_handler(event, context):
    clusterIP = os.environ['factorio_server']
    rConPassword = os.environ['rcon_password']
    target_zone = os.environ['timezone']
    try:
        con = rCon(clusterIP, rConPassword)
        time = datetime.now(tz.gettz(target_zone))
        timestamp = int(time.strftime("%s"))
        command = '/rcon set_clock {0}'.format(timestamp)
        result = con.execute(command)
    except:
        logging.exception('')
    print(result)