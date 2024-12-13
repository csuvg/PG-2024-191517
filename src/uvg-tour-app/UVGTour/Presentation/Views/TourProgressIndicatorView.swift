//
//  TourProgressIndicatorView.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/27/24.
//

import SwiftUI

struct TourProgressIndicatorView: View {
    let progress: Double
    private let allowedRange = 0.0...1.0
    init(progress: Double) {
        self.progress = progress
        precondition(allowedRange.contains(progress), "Progress should be contained in 0 - 1")
    }
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: Sizes.p12, style: .continuous)
                .fill(.lightBackground)
            GeometryReader { gp in
                RoundedRectangle(cornerRadius: Sizes.p12, style: .continuous)
                    .fill(.uvgGreen)
                    .frame(width: gp.size.width * progress)
            }

        }
        .frame(height: 16.0)
    }
}

#Preview {
    ZStack {
        Color.gray.ignoresSafeArea()
        TourProgressIndicatorView(progress: 0.5)
    }
    
}
