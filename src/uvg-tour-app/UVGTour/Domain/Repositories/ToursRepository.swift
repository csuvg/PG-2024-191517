//
//  ToursRepository.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import Foundation

/// Repository to handle tours data fetching.
///
/// Repository will:
/// - ``fetchAllTours()`` To list all available tours
protocol ToursRepository {
    /// Fetch all tours
    /// - Returns: A list of tours
    func fetchAllTours() async throws ->  [Tour]
}
