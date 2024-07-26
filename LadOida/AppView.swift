//
//  ContentView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import SwiftUI
import ComposableArchitecture
import Lottie

struct AppView: View {

    let store: StoreOf<AppCore>

    var body: some View {
        ZStack {
            if store.allMetaDataLoaded {
                TabView {
                    SearchView(store: store.scope(state: \.searchState, action: \.searchAction))
                        .tabItem {
                            Label("Suche Stationen", systemImage: "magnifyingglass")
                        }

                    MoreView()
                        .tabItem {
                            Label("Mehr", systemImage: "ellipsis")
                        }
                }
                .tint(AppColors.color(.primary))
            } else {
                VStack {
                    Spacer()

                    HStack(spacing: 8) {
                        LottieView(animation: .named("battery"))
                            .resizable()
                            .looping()
                            .frame(width: 100, height: 100)

                        Text("Lad Oida")
                            .font(AppFonts.bold(.title))
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: .infinity)

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
            UITabBar.appearance().backgroundColor = .white

            store.send(.onViewAppear)
        }
    }
}
