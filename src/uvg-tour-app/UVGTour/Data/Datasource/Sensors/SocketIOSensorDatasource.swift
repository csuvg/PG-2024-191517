//
//  SocketIOSensorDatasource.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine


/// Datasource that integrates SocketIO for sensor simulation.
class SocketIOSensorDatasource: SensorRepository {
    private var webSocketTask: URLSessionWebSocketTask?
    private var sensorsSubject = PassthroughSubject<[Sensor], Never>()
    
    init () {
        listenToSocket()
    }
    
    deinit {
        webSocketTask = nil
    }
    
    var sensorsPublisher: AnyPublisher<[Sensor], Never> {
        sensorsSubject
            .receive(on: RunLoop.main)  // Ensure values are received on the main thread
            .eraseToAnyPublisher()
    }
    
    
    // MARK: Socket
    
    /// Listents to socket updates, configures the events to update the UI.
    func listenToSocket() {
        let url = URL(string: "ws://172.20.10.2:8000")!
        let urlSession = URLSession(configuration: .default)
        webSocketTask = urlSession.webSocketTask(with: url)
        webSocketTask?.resume()
        
        receiveMessage()  // Start receiving messages
    }
    
    /// Configures the receive of a message
    func receiveMessage() {
        webSocketTask?.receive { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error receiving message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    self?.handleMessage(text)
                case .data(let data):
                    print("Received data: \(data)")
                @unknown default:
                    fatalError()
                }
                
                // Continue to listen for the next message
                self?.receiveMessage()
            }
        }
    }
    
    /// Handles a message
    func handleMessage(_ text: String) {
        // Handle your JSON message here
        if let data = text.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dictionary = json as? [String: Any], let type = dictionary["type"] as? String, type == "sensors-update" {
                    // Handle the sensor update
                    let sensorsRawData = dictionary["data"] as? Array<[String:Any]>
                    let webSocketSensors = sensorsRawData?.compactMap({ sensorData in
                        try? WebSocketSensor.fromJson(sensorData)
                    }) ?? []
                    sensorsSubject.send(webSocketSensors.map({ webSocketSensor in
                        Sensor(id: webSocketSensor.id, distance: webSocketSensor.signalStrength)
                    }))
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }
    
}
