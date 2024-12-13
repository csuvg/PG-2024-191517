//
//  TourTests.swift
//  UVGTourTests
//
//  Created by Guillermo Santos Barrios on 8/28/24.
//

import XCTest
@testable import UVGTour
final class TourTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }
    

    
    func testTour_whenAllStopsCompleted_isCompleted() {
        // Arrange
        var tour = LocalToursDatasource.tours[0]
        // Act
        for _ in tour.stops {
            tour.completeStop()
        }
        // Assert
        XCTAssertTrue(tour.completed)
    }
    
    func testTour_whenNoStopCompleted_IsNotCompleted() {
        // Arrange
        let tour = LocalToursDatasource.tours[0]
        // Assert
        XCTAssertFalse(tour.completed)
    }

}
