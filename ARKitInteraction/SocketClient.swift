/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 Contains `ThresholdPanGesture` - a custom `UIPanGestureRecognizer` to track a translation threshold for panning.
 */

import ARKit
import SocketIO
import SwiftyJSON

protocol SocketClientDelegate: class {
    func dataReceived(_ position: SCNVector3)
}

class SocketClient {
    
    private(set) var socket: SocketIOClient
    public var delegate: SocketClientDelegate?
    
    init() {
        socket = SocketIOClient(socketURL: URL(string: "https://968148dd.ngrok.io")!, config: [.log(true), .compress])
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        
        socket.on("object") {data, ack in
            if let dict = data[0] as? NSDictionary {
                let x = Float(dict["x"] as! Float)
                let y = Float(dict["y"] as! Float)
                let z = Float(dict["z"] as! Float)
                print("dict", dict)
                
                let positon = SCNVector3(x: x, y: y, z: z)
                
                self.delegate?.dataReceived(positon)
            }
        }
        
        socket.connect()
    }
    
    public func sendObject(object: VirtualObject) {
        print("socketclient.sendObject.emit")
        
        let json = ["x": object.position.x, "y": object.position.y, "z": object.position.z]
        self.socket.emit("object", json)
    }
}
