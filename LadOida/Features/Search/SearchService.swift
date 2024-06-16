//
//  SearchService.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 16.06.24.
//

import Foundation

protocol SearchServiceProtocol {
    func searchStations(lat: Double, lng: Double, postalCode: String?) async throws -> GeneralSearchStationResult
}

class SearchService: APIClient, SearchServiceProtocol {
    func searchStations(
        lat: Double,
        lng: Double,
        postalCode: String?
    ) async throws -> GeneralSearchStationResult {
        try await startRequest(
            with: SearchStationsCall(
                lat: lat,
                lng: lng,
                postalCode: postalCode
            )
        )
    }
}
