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
                if searchResponse.mapItems.isEmpty {
                    InfoView(state: .error("Keine Adressen gefunden", "xmark.circle.fill"))
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(searchResponse.mapItems.count) Adressen gefunden")
                            .font(AppFonts.bold(.body2))
                            .padding()

                        SpacerView(height: 1)

                        List(searchResponse.mapItems, id: \.self) { mapItem in
                            VStack(alignment: .leading, spacing: 0) {
                                Button {
                                    store.send(.setSelectedAddress(mapItem))
                                } label: {
                                    SearchItemView(
                                        localSearchCompletion: mapItem,
                                        isSelected: store.selectedAddress == mapItem
                                    )
                                        .tag(mapItem)
                                }

                                SpacerView(height: 2)
                            }
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                        }
                        .listStyle(.plain)

                        if let selectedAddress = store.selectedAddress {
                            Button {
                                print("Test")
                            } label: {
                                HStack(alignment: .center) {
                                    VStack {
                                        Text("Ladestellen in \(selectedAddress.title) anzeigen")
                                            .font(AppFonts.bold(.body))
                                            .foregroundStyle(.white)
                                            .frame(maxWidth: .infinity)
                                    }

                                    Image(systemName: "arrow.right.circle.fill")
                                        .renderingMode(.template)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .tint(.white)
                                }
                                .padding()
                                .background(AppColors.color(.primary))
                            }
                        }
                    }
                }

            case .error:
                InfoView(state: .error("Keine Adressen gefunden", "xmark.circle.fill"))
            }
        }
        .onAppear {
            store.send(.subscribeToSearchResultChanges)
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
