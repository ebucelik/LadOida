//
//  StationDetailCore.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 13.07.24.
//

import ComposableArchitecture

@Reducer
public struct StationDetailCore {

    @ObservableState
    public struct State: Equatable {
        public let station: GeneralSearchStation

        public init(station: GeneralSearchStation) {
            self.station = station
        }
    }

    public enum Action {

    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {}
        }
    }
}
