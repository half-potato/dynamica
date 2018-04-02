import time
from ClientChannel import ClientChannel
from PodSixNet.Server import Server

class GameServer(Server):

    channelClass = ClientChannel

    def Connected(self, channel, addr):
                print 'new connection:', channel


if __name__ == "__main__":
    server = GameServer()
    while True:
        server.Pump()
        time.sleep(0.0001)
