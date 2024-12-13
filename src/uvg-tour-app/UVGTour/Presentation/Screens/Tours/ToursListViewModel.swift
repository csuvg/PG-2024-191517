//
//  ToursListViewModel.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import Foundation
import Combine


/// Handles the state of a list of Tours``[Tour]``.
class ToursListViewModel: ObservableObject {
    private let useCase: ListToursUseCase
    // MARK: Published variables
    @Published private(set) var tours: [Tour] = []
    
    init(useCase: ListToursUseCase) {
        self.useCase = useCase
        Task {
            await fetchTours()
        }
    }
    
    private func fetchTours() async {
        // todo: handle errors
        let fetchedTours = (try? await self.useCase.listTours()) ?? []
        // Update the UI
        DispatchQueue.main.async {
            self.tours = fetchedTours
        }
    }
    
    // MARK: Public Functions
    
    public func select(tour: Tour) {
        // Selects a tour from the list
        
    }

}
