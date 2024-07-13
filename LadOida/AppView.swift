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
        ZStack {
            if store.allMetaDataLoaded {
                NavigationStack {
                    TabView {
                        SearchView(store: store.scope(state: \.searchState, action: \.searchAction))
                            .tabItem {
                                Label("Search Stations", systemImage: "sparkle.magnifyingglass")
                            }
                    }
                    .navigationTitle("Lad Oida")
                    .navigationBarTitleDisplayMode(.inline)
                    .tint(AppColors.color(.primary))
                }
            } else {
                VStack {
                    Spacer()

                    Label("Lad Oida", systemImage: "ev.charger.fill")
                        .frame(maxWidth: .infinity)
                        .font(AppFonts.bold(.title))
                        .foregroundStyle(.white)

                    Spacer()
                }
                .background(AppColors.color(.primary))
            }
        }
        .onAppear {
            UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
            UINavigationBar.appearance().backgroundColor = AppColors.color(.primary)
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
            UISearchBar.appearance().tintColor = .white
            UITabBar.appearance().isTranslucent = false

            store.send(.onViewAppear)
        }
    }
}
