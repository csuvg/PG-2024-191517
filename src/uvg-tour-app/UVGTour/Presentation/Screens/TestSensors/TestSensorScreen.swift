//
//  TestSensorScreen.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import SwiftUI

struct TestSensorScreen: View {
    @StateObject var viewModel: TestSensorViewModel
    var body: some View {
        VStack {
            Text("Sensors detected: ")
            ForEach(viewModel.sensors) { sensor in
                VStack {
                    Text(sensor.id)
                    Text("\(sensor.distance) meters")
                }
            }
            .padding(.top, Sizes.p24)
            Spacer()
        }
    }
}

#Preview {
    let datasource = SocketIOSensorDatasource()
    let repository = SensorRepositoryImpl(datasource: datasource)
    let useCase = WatchSensorsUseCase(sensorsRepository: repository)
    let viewModel = TestSensorViewModel(watchSensorsUseCase: useCase)
    return TestSensorScreen(viewModel: viewModel)
}
