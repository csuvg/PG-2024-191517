//
//  TourStopView.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/24/24.
//

import SwiftUI

/// Screen that shows the information of a Tour ``[[Stop]]``
struct TourStopView: View {
    let stop: Stop
    var body: some View {
        VStack {
            Text(stop.name)
                .font(.title2)
                .bold()
            ScrollView {
                Text(stop.description)
                Image(stop.imageName ?? "plazauvg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250,height: 250)
                    .cornerRadius(Sizes.radiusSmall)
            }
            
        }
        .padding(.all, Sizes.p20)
    }
}


#Preview {
    TourStopView(stop: LocalToursDatasource.tours[0].stops[1])
}
