//
//  TourSelection.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/24/24.
//

import Foundation
import Combine

/// A state class that will allow to select a ``[Tour]``.
class TourSelection: ObservableObject {
    @Published var selectedTour: Tour?
}
