//
//  ContentView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import SwiftUI
import ComposableArchitecture

struct AppView: View {

    let store: StoreOf<AppCore>

    var body: some View {
        NavigationStack {
            if store.allMetaDataLoaded {
                TabView {
                    SearchView(store: store.scope(state: \.searchState, action: \.searchAction))
                        .tabItem {
                            Label("Search Stations", systemImage: "sparkle.magnifyingglass")
                        }
                }
                .navigationTitle("LAD OIDA")
                .navigationBarTitleDisplayMode(.inline)
            } else {
                Label("LAD OIDA", systemImage: "bolt.batteryblock")
            }
        }
        .onAppear {
            store.send(.onViewAppear)
        }
    }
}
