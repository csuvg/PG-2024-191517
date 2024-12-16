//
//  ToursListViewModelTests.swift
//  UVGTourTests
//
//  Created by Guillermo Santos Barrios on 8/18/24.
//

import XCTest
@testable import UVGTour
final class ToursListViewModelTests: XCTestCase {
    
    var sut: ToursListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: Initialization
    
    func testToursListViewModel_whenInit_fetchesTours() {
        // Arrange
        sut = ToursListViewModel(useCase: ListToursUseCase(toursRepository: ToursRepositoryImpl(datasource: LocalToursDatasource())))
        let expectation = XCTestExpectation(description: "Wait for tours to be fetched")
        let cancellable = sut.$tours.sink { tours in
            if !tours.isEmpty {
                expectation.fulfill()
            }
        }
        // Assert
        wait(for: [expectation], timeout: 1)
        XCTAssertFalse(sut.tours.isEmpty)
        cancellable.cancel()
    }
}
