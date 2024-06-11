//
//  InfoView.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 11.06.24.
//

import SwiftUI

public struct InfoView: View {

    public enum State {
        case success(String, String)
        case info(String, String)
        case error(String, String)
        case loading
    }

    let state: State

    init(state: State) {
        self.state = state
    }

    public var body: some View {
        switch state {
        case let .success(message, systemImageName):
            stateBody(message: message, systemImageName: systemImageName)
        case let .info(message, systemImageName):
            stateBody(message: message, systemImageName: systemImageName)
        case let .error(message, systemImageName):
            stateBody(message: message, systemImageName: systemImageName)
        case .loading:
            VStack(alignment: .center, spacing: 16) {
                Spacer()

                ProgressView().progressViewStyle(.circular)

                Text("Loading...")
                    .font(.caption)

                Spacer()
            }
        }
    }

    @ViewBuilder
    private func stateBody(
        message: String,
        systemImageName: String
    ) -> some View {
        VStack(alignment: .center, spacing: 16) {
            Spacer()

            Text(message)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .center)

            Image(systemName: systemImageName)
                .resizable()
                .frame(width: 100, height: 100)

            Spacer()
        }
    }
}
