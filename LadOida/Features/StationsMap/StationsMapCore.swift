//
//  StationsMapCore.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 16.06.24.
//

import ComposableArchitecture

@Reducer
public struct StationsMapCore {
    @ObservableState
    public struct State: Equatable {
        let searchStationResult: GeneralSearchStationResult
        var filteredStations: [GeneralSearchStation] = []

        @Presents
        var stationDetailCoreState: StationDetailCore.State?

        var containsFreeParking: Bool {
            searchStationResult.stations.contains(where: { $0.freeParking == true })
        }

        var containsGreenEnergy: Bool {
            searchStationResult.stations.contains(where: { $0.greenEnergy == true })
        }

        var containsTelephone: Bool {
            searchStationResult.stations.contains(where: { $0.telephone != "" })
        }

        var containsEmail: Bool {
            searchStationResult.stations.contains(where: { $0.email != "" })
        }

        var containsWebsite: Bool {
            searchStationResult.stations.contains(where: { $0.website != "" })
        }

        var containsFilterValues: Bool {
            containsFreeParking || containsGreenEnergy || containsTelephone ||
            containsEmail || containsWebsite
        }

        public enum Filter {
            case freeParking, greenEnergy, telephone, email, website
        }

        var filter: [Filter] = []

        public init(searchStationResult: GeneralSearchStationResult) {
            self.searchStationResult = searchStationResult
            self.filteredStations = searchStationResult.stations
        }
    }

    public enum Action {
        case filter(State.Filter)
        case showStationDetail(GeneralSearchStation)
        case stationDetail(PresentationAction<StationDetailCore.Action>)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .filter(filter):
                state.filter.contains(filter) ? state.filter.removeAll(where: { $0 == filter })
                : state.filter.append(filter)

                if state.filter.isEmpty {
                    state.filteredStations = state.searchStationResult.stations
                }

                state.filter.forEach { filter in
                    state.filteredStations = state.filteredStations.filter { station in
                        switch filter {
                        case .freeParking:
                            station.freeParking == true
                        case .greenEnergy:
                            station.greenEnergy == true
                        case .telephone:
                            station.telephone != ""
                        case .email:
                            station.email != ""
                        case .website:
                            station.website != ""
                        }
                    }
                }

                return .none

            case let .showStationDetail(generalSearchStation):
                state.stationDetailCoreState = StationDetailCore.State(station: generalSearchStation)

                return .none

            case .stationDetail(.dismiss):
                state.stationDetailCoreState = nil

                return .none

            case .stationDetail:
                return .none
            }
        }
        .ifLet(\.$stationDetailCoreState, action: \.stationDetail) {
            StationDetailCore()
        }
    }
}
