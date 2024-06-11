//
//  LocalSearchService.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 11.06.24.
//

import MapKit

protocol LocalSearchServiceProtocol {
    func request(resultType: MKLocalSearch.ResultType, searchText: String) async throws -> LocalSearchResponse
}

class LocalSearchService: LocalSearchServiceProtocol {
    let lat: Double
    let lng: Double

    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng
    }

    // TODO: Adapt search with corelocation!
    func request(
        resultType: MKLocalSearch.ResultType,
        searchText: String
    ) async throws -> LocalSearchResponse {
        let request = MKLocalSearch.Request()

        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: lat,
                longitude: lng
            ),
            span: MKCoordinateSpan()
        )

        let search = MKLocalSearch(request: request)

        let response = try await search.start()

        return LocalSearchResponse(mapItems: response.mapItems)
    }
}
