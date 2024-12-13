//
//  Errors.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import Foundation


// MARK: Web Socket Sensor
enum WebSocketSensorError: Error {
    case missingData
    case invalidData
}
