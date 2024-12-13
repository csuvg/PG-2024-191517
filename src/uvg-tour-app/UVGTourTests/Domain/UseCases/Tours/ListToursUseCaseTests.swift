//
//  ListToursUseCaseTests.swift
//  UVGTourTests
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import XCTest
@testable import UVGTour

final class ListToursUseCaseTests: XCTestCase {
    
    var sut: ListToursUseCase!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ListToursUseCase(toursRepository: ToursRepositoryImpl(datasource: LocalToursDatasource()))
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testListToursUseCase_whenToursRequested_returnsListOfTours() async {
        // Arrange
        let expectedTours = LocalToursDatasource.tours
        // Act
        let tours = (try? await sut.listTours()) ?? []
        // Assert
        XCTAssertNotNil(tours)
        XCTAssertEqual(tours, expectedTours)
    }

}
