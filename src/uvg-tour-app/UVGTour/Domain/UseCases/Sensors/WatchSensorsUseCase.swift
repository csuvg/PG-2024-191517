//
//  WatchSensorsUseCase.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine

/// Watches the sensors updates.
struct WatchSensorsUseCase {
    let sensorsRepository: SensorRepository // This will be injected
    var cancellables = Set<AnyCancellable>() // Cancellable for the sensors
    
    
    /// Subscribes to the sensors publisher provided by the repository.
    mutating func watchSensors(update: @escaping ([Sensor]) -> Void) {
        sensorsRepository.sensorsPublisher
            .sink { sensors in
                update(sensors)
            }
            .store(in: &cancellables)
    }
}
