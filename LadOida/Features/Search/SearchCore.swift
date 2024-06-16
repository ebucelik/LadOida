//
//  SearchCore.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 11.06.24.
//

import Foundation
import ComposableArchitecture
import Combine
import MapKit

@Reducer
public struct SearchCore {
    @ObservableState
    public struct State: Equatable {
        var searchText: String = ""
        var searchResult: ViewState<LocalSearchResponse> = .none
        var selectedAddress: MKLocalSearchCompletion?
        var searchStations: ViewState<GeneralSearchStationResult> = .none
    }

    public enum Action: BindableAction {
        case searchAddress
        case searchStationsWithAddress
        case subscribeToSearchResultChanges
        case setSearchResult(ViewState<LocalSearchResponse>)
        case setSelectedAddress(MKLocalSearchCompletion)
        case setSearchStations(ViewState<GeneralSearchStationResult>)
        case binding(BindingAction<State>)
    }

    let localSearchService: LocalSearchServiceProtocol
    let searchService: SearchServiceProtocol

    init(
        localSearchService: LocalSearchServiceProtocol,
        searchService: SearchServiceProtocol
    ) {
        self.localSearchService = localSearchService
        self.searchService = searchService
    }

    struct DebounceId: Hashable {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .subscribeToSearchResultChanges:
                return .run { send in
                    for await searchResults in self.localSearchService.searchResultsChanged {
                        if let searchResults {
                            await send(.setSearchResult(.loaded(searchResults)))
                        }
                    }
                }
                
            case .searchAddress:
                guard state.searchText.count > 4 else { return .none }

                state.selectedAddress = nil

                return .run { [state = state] send in
                    await send(.setSearchResult(.loading))

                    self.localSearchService.request(
                        resultType: .address,
                        searchText: state.searchText
                    )
                } catch: { error, send in
                    await send(.setSearchResult(.error(error)))
                }
                .debounce(
                    id: DebounceId(),
                    for: 1.5,
                    scheduler: DispatchQueue.main.eraseToAnyScheduler()
                )

            case .searchStationsWithAddress:
                guard let selectedAddress = state.selectedAddress else { return .none }

                return .run { send in
                    await send(.setSearchStations(.loading))

                    guard let placemark = try await self.localSearchService.searchRequest(
                        localSearchCompletion: selectedAddress
                    ) else {
                        await send(.setSearchStations(.error(APIError.responseError)))

                        return
                    }

                    let searchStations = try await self.searchService.searchStations(
                        lat: placemark.coordinate.latitude,
                        lng: placemark.coordinate.longitude,
                        postalCode: placemark.postalCode
                    )

                    await send(.setSearchStations(.loaded(searchStations)))
                } catch: { error, send in
                    await send(.setSearchStations(.error(error)))
                }

            case let .setSearchResult(stateChanged):
                state.searchResult = stateChanged

                return .none

            case let .setSelectedAddress(localSearchCompletion):
                state.selectedAddress = localSearchCompletion

                return .none

            case let .setSearchStations(searchStations):
                state.searchStations = searchStations

                if case let .loaded(stations) = searchStations {
                    print(stations)
                }

                return .none

            case .binding(\.searchText):
                return .send(.searchAddress)

            case .binding:
                return .none
            }
        }
    }
}
