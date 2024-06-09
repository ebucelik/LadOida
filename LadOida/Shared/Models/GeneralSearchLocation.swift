//
//  GeneralSearchLocation.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct GeneralSearchLocation: Codable, Equatable {
    public let latitude: Double?
    public let longitude: Double?

    init(
        latitude: Double?,
        longitude: Double?
    ) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
