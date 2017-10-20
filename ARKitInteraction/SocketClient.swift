/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Contains `ThresholdPanGesture` - a custom `UIPanGestureRecognizer` to track a translation threshold for panning.
 */

import SocketIO

class SocketClient {
    
    private(set) var socket: SocketIOClient
    
    init() {
        socket = SocketIOClient(socketURL: URL(string: "https://968148dd.ngrok.io")!, config: [.log(true), .compress])
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.connect()
    }
    
    public func sendObject(Virua) {
        print("socketclient.sendObject.emit")
        self.socket.emit("object")
    }
}
