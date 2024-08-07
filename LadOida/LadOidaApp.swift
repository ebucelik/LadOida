//
//  LadOidaApp.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import SwiftUI
import ComposableArchitecture

@main
struct LadOidaApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                AppView(
                    store: Store(
                        initialState: AppCore.State(),
                        reducer: {
                            AppCore(
                                service: Services.appService,
                                localSearchService: Services.localSearchService,
                                searchService: Services.searchService,
                                locationManagerService: Services.locationManagerService
                            )
                        }
                    )
                )
                .preferredColorScheme(.light)

                GeometryReader { reader in
                    AppColors.color(.primary)
                        .frame(height: reader.safeAreaInsets.top, alignment: .top)
                        .ignoresSafeArea()
                }
            }
        }
    }
}
