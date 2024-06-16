//
//  LocalSearchService.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 11.06.24.
//

import MapKit
import Combine

protocol LocalSearchServiceProtocol {
    func request(resultType: MKLocalSearchCompleter.ResultType, searchText: String)
    func searchRequest(localSearchCompletion: MKLocalSearchCompletion) async throws -> MKPlacemark?
    var searchResultsChanged: AsyncStream<LocalSearchResponse?> { get }
}

class LocalSearchService: NSObject, LocalSearchServiceProtocol {

    private lazy var localSearchCompleter = MKLocalSearchCompleter()
    private let lat: Double
    private let lng: Double

    @Published private var searchResults: LocalSearchResponse?
    private var cancellable: AnyCancellable?

    var searchResultsChanged: AsyncStream<LocalSearchResponse?> {
        return AsyncStream { continuation in
            cancellable = $searchResults.sink { searchResults in
                continuation.yield(searchResults)
            }
        }
    }

    init(lat: Double, lng: Double) {
        self.lat = lat
        self.lng = lng

        super.init()

        self.localSearchCompleter.delegate = self
    }

    func request(
        resultType: MKLocalSearchCompleter.ResultType,
        searchText: String
    ) {
        localSearchCompleter.resultTypes = resultType
        localSearchCompleter.pointOfInterestFilter = .includingAll
        localSearchCompleter.region =  MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: lat,
                longitude: lng
            ),
            span: MKCoordinateSpan()
        )
        localSearchCompleter.cancel()

        DispatchQueue.main.async {
            self.localSearchCompleter.queryFragment = searchText
        }
    }

    func searchRequest(localSearchCompletion: MKLocalSearchCompletion) async throws -> MKPlacemark? {
        let request = MKLocalSearch.Request(completion: localSearchCompletion)
        let search = MKLocalSearch(request: request)

        let response = try await search.start()

        return response.mapItems.first?.placemark
    }
}

extension LocalSearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = LocalSearchResponse(mapItems: completer.results)
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: any Error) {
        print(error.localizedDescription)
    }
}
