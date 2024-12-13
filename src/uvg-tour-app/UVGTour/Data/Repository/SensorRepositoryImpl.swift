//
//  SensorRepositoryImpl.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine

/// Implementation of the ``SensorRepository``.
///
/// This structure receives the datasource that will use.
struct SensorRepositoryImpl: SensorRepository {
    var datasource: SensorRepository
    var sensorsPublisher: AnyPublisher<[Sensor], Never> {
        datasource.sensorsPublisher.eraseToAnyPublisher()
    }
    
    
}
