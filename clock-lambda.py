# pip install for AWS-lambda
import os,sys
os.system('pip install factorio-rcon-py -t /tmp/ --no-cache-dir')
sys.path.insert(1, '/tmp/')

# main script
import logging
import factorio_rcon
from datetime import datetime
from dateutil import tz


class rCon():
    def __init__(self, hostname, password):
        self.hostname = hostname
        self.password = password
        self.con = None
        self.con = factorio_rcon.RCONClient(
            self.hostname, 27015, self.password)

    def __del__(self):
        if self.con:
            self.con.close()
            logging.info('closed rcon connection')

    def execute(self, command):
        if self.con:
            response = self.con.send_command(command)
            logging.info(response)
            return response


def lambda_handler(event, context):
    clusterIP = ""
    rConPassword = ""
    target_zone = tz.gettz('Europe/Berlin')
    try:
        con = rCon(clusterIP, rConPassword)
        time = datetime.now(target_zone)
        timestamp = int(time.strftime("%s"))
        command = '/rcon set_clock {0}'.format(timestamp)
        result = con.execute(command)
    except:
        logging.exception('')
    print(result)
