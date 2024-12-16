//
//  ListToursUseCase.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import Foundation


/// Lists all the available tours provided by a ``ToursRepository``.
struct ListToursUseCase {
    let toursRepository: ToursRepository
    
    func listTours() async throws -> [Tour] {
        // todo: implement
        return try await toursRepository.fetchAllTours()
    }
    
}
