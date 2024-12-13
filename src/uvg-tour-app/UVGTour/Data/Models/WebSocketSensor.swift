//
//  WebSocketSensor.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation

/// Identifies a sensor provided by the Web Socket
struct WebSocketSensor {
    let id: String
    let signalStrength: Float
    
    public static func fromJson(_ json: [String: Any]) throws -> WebSocketSensor  {
        let id = json["id"] as? String
        let signalStrength = json["signalStrength"] as? String
        if let id, let signalStrength, let floatSignalStrength = Float(signalStrength) {
            return WebSocketSensor(id: id, signalStrength: floatSignalStrength)
        }
        throw WebSocketSensorError.invalidData
    }
}


