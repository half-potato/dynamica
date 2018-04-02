from PodSixNet.Channel import Channel

class ClientChannel(Channel):
    def Network(self, data):
        print(data)

    def Network_request_map(self, data):
        print("Client requested map: " + str(data))
        self.Send({"data": ["boobs":696969]})
