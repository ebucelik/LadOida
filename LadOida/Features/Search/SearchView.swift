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
        NavigationStack {
            SearchBodyView(store: store)
                .onAppear {
                    store.send(.subscribeToSearchResultChanges)
                    store.send(.subscribeToLocationPermissionChanges)
                }
                .searchable(text: $store.searchText, prompt: "Adresse eingeben")
                .navigationDestination(
                    item: $store.scope(
                        state: \.stationsMapState,
                        action: \.stationsMapAction
                    )
                ) { stationsMapStore in
                    StationsMapView(store: stationsMapStore)
                }
                .navigationTitle("Lad Oida")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SearchBodyView: View {

    @Bindable
    var store: StoreOf<SearchCore>
    @Environment(\.isSearching) var isSearching

    var body: some View {
        VStack {
            switch store.searchResult {
            case .none:
                infoViewWithLocationBanner(
                    message: "Suche nach Ladestellen",
                    image: "ev.charger.fill"
                )

            case .loading:
                InfoView(state: .loading)

            case let .loaded(searchResponse):
                if searchResponse.mapItems.isEmpty {
                    infoViewWithLocationBanner(
                        message: "Keine Adressen gefunden",
                        image: "xmark.circle.fill"
                    )
                } else {
                    VStack(alignment: .leading, spacing: 0) {
                        locationBanner()

                        HStack {
                            if searchResponse.mapItems.count == 1 {
                                Text("\(searchResponse.mapItems.count) Adresse gefunden")
                                    .font(AppFonts.bold(.body2))
                            } else {
                                Text("\(searchResponse.mapItems.count) Adressen gefunden")
                                    .font(AppFonts.bold(.body2))
                            }

                            Spacer()

                            Button(role: .cancel) {
                                store.send(.reset)
                            } label: {
                                Text("Zurücksetzen")
                                    .font(AppFonts.bold(.body2))
                            }
                        }
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
                        .disabled(store.isLoadingOrIsTyping)
                        .opacity(store.isLoadingOrIsTyping ? 0.8 : 1)

                        if let selectedAddress = store.selectedAddress {
                            Button {
                                store.send(.searchStationsWithAddress)
                            } label: {
                                HStack(alignment: .center) {
                                    VStack {
                                        Text("Ladestellen in \(selectedAddress.title) anzeigen")
                                            .font(AppFonts.bold(.body))
                                            .foregroundStyle(.white)
                                            .frame(maxWidth: .infinity)
                                    }

                                    if store.searchStationResult.isLoading {
                                        ProgressView().progressViewStyle(.circular)
                                    } else {
                                        Image(systemName: "arrow.right.circle.fill")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .tint(.white)
                                    }
                                }
                                .padding()
                                .background(AppColors.color(.primary))
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 12,
                                        topTrailingRadius: 12
                                    )
                                )
                            }
                            .disabled(store.searchStationResult.isLoading)
                            .opacity(store.searchStationResult.isLoading ? 0.8 : 1)
                        }
                    }
                }

            case .error:
                InfoView(state: .error("Keine Adressen gefunden", "xmark.circle.fill"))
            }
        }
        .onChange(of: isSearching) {
            if !isSearching, store.searchResult == .loading {
                store.send(.reset)
            }
        }
    }

    @ViewBuilder
    private func locationBanner() -> some View {
        Button(
            action: {
                store.send(.showStationsNearLocation)
            },
            label: {
                VStack {
                    HStack {
                        Spacer()

                        Image(systemName: "location.fill")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)

                        Text("Ladestellen in der Nähe anzeigen")
                            .font(AppFonts.regular(.body))
                            .foregroundStyle(.white)

                        Spacer()
                    }
                    .padding()
                }
                .background(AppColors.color(.primary))
                .clipShape(
                    .rect(
                        bottomLeadingRadius: 12,
                        bottomTrailingRadius: 12
                    )
                )
            }
        )
    }

    @ViewBuilder
    private func infoViewWithLocationBanner(
        message: String,
        image: String
    ) -> some View {
        VStack(alignment: .center, spacing: 16) {
            locationBanner()

            Spacer()

            Text(message)
                .font(AppFonts.regular(.title2))
                .frame(maxWidth: .infinity, alignment: .center)

            Image(systemName: image)
                .resizable()
                .frame(width: 80, height: 80)

            Spacer()
        }
    }
}
