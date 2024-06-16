//
//  StationsMapView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 16.06.24.
//

import SwiftUI
import MapKit
import ComposableArchitecture

struct StationsMapView: View {

    let store: StoreOf<StationsMapCore>

    var body: some View {
        Map {
            ForEach(store.filteredStations, id: \.self) { station in
                if let location = station.location {
                    Marker(
                        station.label ?? "Ladestelle",
                        coordinate: CLLocationCoordinate2D(
                            latitude: location.latitude ?? 0,
                            longitude: location.longitude ?? 0
                        )
                    )
                    .tint(AppColors.color(.primary))
                }
            }
        }
        .mapControlVisibility(.hidden)
        .toolbarBackground(AppColors.color(.primary), for: .navigationBar)
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .leading) {
                Text("Filter")
                    .font(AppFonts.bold(.body1))
                    .padding()

                HStack(spacing: 16) {
                    Spacer()

                    if store.containsFreeParking {
                        Button {
                            store.send(.filter(.freeParking))
                        } label: {
                            Image(
                                systemName: store.filter.contains(.freeParking) ? "parkingsign.circle.fill"
                                : "parkingsign.circle"
                            )
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(AppColors.color(.primary))
                        }
                        .padding(.bottom)
                    }

                    if store.containsGreenEnergy {
                        Button {
                            store.send(.filter(.greenEnergy))
                        } label: {
                            Image(
                                systemName: store.filter.contains(.greenEnergy) ? "leaf.circle.fill"
                                : "leaf.circle"
                            )
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(AppColors.color(.primary))
                        }
                        .padding(.bottom)
                    }

                    if store.containsTelephone {
                        Button {
                            store.send(.filter(.telephone))
                        } label: {
                            Image(
                                systemName: store.filter.contains(.telephone) ? "phone.circle.fill"
                                : "phone.circle"
                            )
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(AppColors.color(.primary))
                        }
                        .padding(.bottom)
                    }

                    if store.containsEmail {
                        Button {
                            store.send(.filter(.email))
                        } label: {
                            Image(
                                systemName: store.filter.contains(.email) ? "envelope.circle.fill"
                                : "envelope.circle"
                            )
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(AppColors.color(.primary))
                        }
                        .padding(.bottom)
                    }

                    if store.containsWebsite {
                        Button {
                            store.send(.filter(.website))
                        } label: {
                            Image(
                                systemName: store.filter.contains(.website) ? "at.circle.fill"
                                : "at.circle"
                            )
                            .renderingMode(.template)
                            .resizable()
                            .frame(width: 42, height: 42)
                            .foregroundStyle(AppColors.color(.primary))
                        }
                        .padding(.bottom)
                    }

                    Spacer()
                }
            }
            .background(.thinMaterial)
        }
    }
}
