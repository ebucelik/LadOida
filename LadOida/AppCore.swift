//
//  AppCore.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct AppCore {
    @ObservableState
    public struct State: Equatable {
        var countries: ViewState<[Country]> = .none
        var authenticationModes: ViewState<[AuthenticationMode]> = .none
        var connectoryTypes: ViewState<[ConnectorType]> = .none
        var vehicleTypes: ViewState<[VehicleType]> = .none

        var searchState: SearchCore.State = SearchCore.State()

        var allMetaDataLoaded: Bool {
            if case .loaded = countries,
               case .loaded = authenticationModes,
               case .loaded = connectoryTypes,
               case .loaded = vehicleTypes {
                return true
            }

            return false
        }
    }

    public enum Action {
        case onViewAppear

        case fetchCountries
        case countriesStateChanged(ViewState<[Country]>)

        case fetchAuthenticationModes
        case authenticationModesStateChanged(ViewState<[AuthenticationMode]>)

        case fetchConnectorTypes
        case connectorTypesStateChanged(ViewState<[ConnectorType]>)

        case fetchVehicleTypes
        case vehicleTypesStateChanged(ViewState<[VehicleType]>)

        case searchAction(SearchCore.Action)
    }

    let service: AppServiceProtocol

    init(service: AppServiceProtocol) {
        self.service = service
    }

    public var body: some ReducerOf<Self> {
        Scope(
            state: \.searchState,
            action: \.searchAction
        ) {
            SearchCore(
                searchService: LocalSearchService(
                    lat: 47.6964719,
                    lng: 13.3457347
                )
            )
        }
        
        Reduce { state, action in
            switch action {
            case .onViewAppear:
                struct DebounceId: Hashable {}
                
                return .concatenate(
                    [
                        .send(.fetchCountries),
                        .send(.fetchAuthenticationModes),
                        .send(.fetchConnectorTypes),
                        .send(.fetchVehicleTypes)
                    ]
                )
                .debounce(
                    id: DebounceId(),
                    for: 1.5,
                    scheduler: DispatchQueue.main.eraseToAnyScheduler()
                )

            case .fetchCountries:
                return .run { send in
                    await send(.countriesStateChanged(.loading))

                    let countries = try await self.service.fetchCountries()

                    await send(.countriesStateChanged(.loaded(countries)))
                } catch: { error, send in
                    await send(.countriesStateChanged(.error(error)))
                }

            case let .countriesStateChanged(stateChanged):
                state.countries = stateChanged

                return .none

            case .fetchAuthenticationModes:
                return .run { send in
                    await send(.authenticationModesStateChanged(.loading))

                    let authenticationModes = try await self.service.fetchAuthenticationModes()

                    await send(.authenticationModesStateChanged(.loaded(authenticationModes)))
                } catch: { error, send in
                    await send(.authenticationModesStateChanged(.error(error)))
                }

            case let .authenticationModesStateChanged(stateChanged):
                state.authenticationModes = stateChanged

                return .none

            case .fetchConnectorTypes:
                return .run { send in
                    await send(.connectorTypesStateChanged(.loading))

                    let connectorTypes = try await self.service.fetchConnectorTypes()

                    await send(.connectorTypesStateChanged(.loaded(connectorTypes)))
                } catch: { error, send in
                    await send(.connectorTypesStateChanged(.error(error)))
                }

            case let .connectorTypesStateChanged(stateChanged):
                state.connectoryTypes = stateChanged

                return .none

            case .fetchVehicleTypes:
                return .run { send in
                    await send(.vehicleTypesStateChanged(.loading))

                    let vehicleTypes = try await self.service.fetchVehicleTypes()

                    await send(.vehicleTypesStateChanged(.loaded(vehicleTypes)))
                } catch: { error, send in
                    await send(.vehicleTypesStateChanged(.error(error)))
                }

            case let .vehicleTypesStateChanged(stateChanged):
                state.vehicleTypes = stateChanged

                return .none

            case .searchAction:
                return .none
            }
        }
    }
}
