//
//  Services.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 12.06.24.
//

final class Services {
    static let appService: AppServiceProtocol = AppService()

    static let localSearchService: LocalSearchServiceProtocol = LocalSearchService(
        lat: 47.333333,
        lng: 13.333333
    )

    static let searchService: SearchServiceProtocol = SearchService()

    static let locationManagerService: LocationManagerService = LocationManagerService()
}
