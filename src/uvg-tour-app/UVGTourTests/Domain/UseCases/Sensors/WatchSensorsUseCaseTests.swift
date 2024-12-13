//
//  WatchSensorsUseCaseTests.swift
//  UVGTourTests
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import XCTest
@testable import UVGTour

final class WatchSensorsUseCaseTests: XCTestCase {
    
    var sut: WatchSensorsUseCase!
    
    // MARK: Set Up

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = WatchSensorsUseCase(sensorsRepository: SensorRepositoryImpl(datasource: FakeSensorsDatasource()))
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    // MARK: Watch Sensors
    
    func testWatchSensorsUseCase_whenWatchInitialized_subscribesToPublisher() {
        // Arrange
        let expectedSensors = FakeSensorsDatasource.sensors
        let expectation = expectation(description: "received sensor data")
        
        // Act
        sut.watchSensors { sensors in
            XCTAssertEqual(sensors, expectedSensors)
            expectation.fulfill()
        }
        // Assert
        waitForExpectations(timeout: 1, handler: nil)
    }

   

}
