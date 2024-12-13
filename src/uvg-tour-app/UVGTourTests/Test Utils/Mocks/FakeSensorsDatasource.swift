//
//  FakeSensorsDatasource.swift
//  UVGTourTests
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation
import Combine
@testable import UVGTour

struct FakeSensorsDatasource: SensorRepository {
    public static let sensors = [
        Sensor(id: "123", distance: 2)
    ]
    
    var sensorsPublisher: AnyPublisher<[UVGTour.Sensor], Never> {
        Just([Sensor(id: "123", distance: 2)]).eraseToAnyPublisher()
    }
}
