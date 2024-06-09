//
//  ProximitySearchLocation.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct ProximitySearchLocation: Codable, Equatable {
    public let lat: Double?
    public let lon: Double?

    init(
        lat: Double?,
        lon: Double?
    ) {
        self.lat = lat
        self.lon = lon
    }
}
