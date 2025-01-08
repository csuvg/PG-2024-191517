//
//  SensorRepository.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine


/// Repository protocol that will handle interaction with sensors.
///
/// This repository will:
/// - Expose a ``sensorsPublisher`` that the client can listen to retreive sensor updates.
///
protocol SensorRepository {
    var sensorsPublisher: AnyPublisher<[Sensor], Never> { get }
}



