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

    @Bindable
    var store: StoreOf<SearchCore>

    var body: some View {
        VStack {
            switch store.searchResult {
            case .none:
                InfoView(state: .info("Suche nach Ladestellen", "magnifyingglass"))

            case .loading:
                InfoView(state: .loading)

            case let .loaded(searchResponse):
                ForEach(searchResponse.mapItems, id: \.self) { mapItem in
                    Text(mapItem.name ?? "")
                }

            case .error:
                InfoView(state: .error("Keine Adresse gefunden", "xmark.circle.fill"))
            }
        }
        .searchable(text: $store.searchText, prompt: "Adresse eingeben")

        

//        Map(
//            bounds: .init(
//                centerCoordinateBounds: .init(
//                    center: .init(
//                        latitude: 47.6964719,
//                        longitude: 13.3457347
//                    ),
//                    span: .init()
//                )
//            )
//        ) {
//
//        }
//        .mapControlVisibility(.hidden)
    }
}
