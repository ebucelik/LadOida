//
//  SearchCore.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 11.06.24.
//

import Foundation
import ComposableArchitecture
import Combine

@Reducer
public struct SearchCore {
    @ObservableState
    public struct State: Equatable {
        var searchText: String = ""
        var searchResult: ViewState<LocalSearchResponse> = .none
    }

    public enum Action: BindableAction {
        case searchAddress
        case subscribeToSearchResultChanges
        case setSearchResult(ViewState<LocalSearchResponse>)
        case binding(BindingAction<State>)
    }

    let searchService: LocalSearchServiceProtocol

    init(searchService: LocalSearchServiceProtocol) {
        self.searchService = searchService
    }

    struct DebounceId: Hashable {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .subscribeToSearchResultChanges:
                return .run { send in
                    for await searchResults in self.searchService.searchResultsChanged {
                        if let searchResults {
                            await send(.setSearchResult(.loaded(searchResults)))
                        }
                    }
                }
                
            case .searchAddress:
                guard state.searchText.count > 4 else { return .none }

                return .run { [state = state] send in
                    await send(.setSearchResult(.loading))

                    self.searchService.request(
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

            case let .setSearchResult(stateChanged):
                state.searchResult = stateChanged

                return .none

            case .binding(\.searchText):
                return .send(.searchAddress)

            case .binding:
                return .none
            }
        }
    }
}
