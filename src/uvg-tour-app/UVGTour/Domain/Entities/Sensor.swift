//
//  Sensor.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation


/// Data representation of a real sensor.
///
/// Each sensor has a unique identifier ``id``.
/// The ``distance`` is calculated in meters from the user's phone.
struct Sensor: Identifiable, Equatable {
    var id: String
    var distance: Float
}


