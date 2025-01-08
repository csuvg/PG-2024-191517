//
//  ToursRepositoryImpl.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import Foundation

/// Implementation of the ``ToursRepository``.
///
/// This structure receives the datasource it will use.
struct ToursRepositoryImpl: ToursRepository {
    let datasource: ToursRepository
    
    func fetchAllTours() async throws -> [Tour] {
        return try await  datasource.fetchAllTours()
    }
}
