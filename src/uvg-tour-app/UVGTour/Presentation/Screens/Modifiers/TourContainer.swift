//
//  TourContainer.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/28/24.
//

import Foundation
import SwiftUI

/// Creates a custom container around a view. Adds some padding to it and rounded corners.
struct TourContainer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, Sizes.p20)
            .padding(.top, Sizes.p20) // Give space to the emoji
            .frame(maxWidth: .infinity)
            .background(Color.background)
            .cornerRadius(25.0)
    }
}


extension View {
    func uvgTourContainer() -> some View {
        modifier(TourContainer())
    }
}
