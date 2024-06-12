//
//  Services.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 12.06.24.
//

final class Services {
    static let appService: AppServiceProtocol = AppService()

    static let searchService: LocalSearchServiceProtocol = LocalSearchService(
        lat: 47.6964719,
        lng: 13.3457347
    )
}
