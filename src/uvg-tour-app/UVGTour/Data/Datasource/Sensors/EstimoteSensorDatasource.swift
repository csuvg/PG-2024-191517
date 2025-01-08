//
//  EstimoteSensorDatasource.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine
import EstimoteUWB
/// Datasource that integrates Estimote's sensor API.
class EstimoteSensorDatasource: SensorRepository {
    private var uwbManager: EstimoteUWBManager?
    private var sensors: [Sensor] = []
        
    private var sensorsSubject = PassthroughSubject<[Sensor], Never>()
    
    init() {
        setupUWB()
    }
    
    /// Sets the UWB manager from estimote
    private func setupUWB() {
        uwbManager = EstimoteUWBManager(delegate: self,
                                        options: EstimoteUWBOptions(shouldHandleConnectivity: true,
                                                                    isCameraAssisted: false))
        uwbManager?.startScanning()
    }
    
    
    var sensorsPublisher: AnyPublisher<[Sensor], Never> {
        sensorsSubject
            .receive(on: RunLoop.main)  // Ensure values are received on the main thread
            .eraseToAnyPublisher()
    }
}


// Conform to Estimote SDK
extension EstimoteSensorDatasource: EstimoteUWBManagerDelegate {
    
    // MARK: Protocol Methods
    
    
    func didUpdatePosition(for device: EstimoteUWB.EstimoteUWBDevice) {
//        print("Position updated for device: \(device)")
        if let index = sensors.firstIndex(where: { sensor in
            sensor.id == device.id
        }) {
            sensors[index].distance = device.distance
        } else {
            sensors.append(Sensor(id: device.id, distance: device.distance))
        }
        sensorsSubject.send(sensors)
    }
    
    
    func didDiscover(device: UWBIdentifiable, with rssi: NSNumber, from manager: EstimoteUWBManager) {
//        print("Discovered device: \(device.publicIdentifier) rssi: \(rssi)")
    }
    
    
    func didConnect(to device: UWBIdentifiable) {
        print("Successfully connected to: \(device.publicIdentifier)")
    }
    
    
    func didDisconnect(from device: UWBIdentifiable, error: Error?) {
//        print("Disconnected from device: \(device.publicIdentifier)- error: \(String(describing: error))")
    }
    

    func didFailToConnect(to device: UWBIdentifiable, error: Error?) {
//        print("Failed to conenct to: \(device.publicIdentifier) - error: \(String(describing: error))")
    }
    
    
}
