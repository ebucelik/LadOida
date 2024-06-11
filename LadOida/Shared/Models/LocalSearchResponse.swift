//
//  LocalSearchResponse.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 11.06.24.
//

import MapKit

public struct LocalSearchResponse: Equatable, Codable {
    let mapItems: [MKMapItem]

    public init(mapItems: [MKMapItem]) {
        self.mapItems = mapItems
    }

    public func encode(to encoder: any Encoder) throws {
        throw APIError.decodingError
    }

    public init(from decoder: any Decoder) throws {
        throw APIError.decodingError
    }
}
