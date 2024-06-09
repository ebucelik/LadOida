//
//  SearchView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import SwiftUI
import ComposableArchitecture
import MapKit

struct SearchView: View {
    var body: some View {
        Map(bounds: .init(centerCoordinateBounds: .init(center: .init(latitude: 47.6964719, longitude: 13.3457347), span: .init()))) {

        }
        .mapControlVisibility(.hidden)
    }
}
