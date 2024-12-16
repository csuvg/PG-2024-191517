//
//  TestSensorViewModel.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine


/// State representation for the ``TestSensorScreen``.
class TestSensorViewModel: ObservableObject {
    // MARK: Use Cases
    var watchSensorsUseCase: WatchSensorsUseCase // Watch the sensor updates
    // MARK: State variables
    @Published var sensors: [Sensor] = []
    
    init(watchSensorsUseCase: WatchSensorsUseCase) {
        self.watchSensorsUseCase = watchSensorsUseCase
        startWatchingSensors()
    }
    
    
    /// Starts watching the sensors
    private func startWatchingSensors() {
        self.watchSensorsUseCase.watchSensors { sensors in
            self.sensors = sensors
        }
    }
    
}
