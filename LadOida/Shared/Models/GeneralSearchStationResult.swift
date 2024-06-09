//
//  GeneralSearchStationResult.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct GeneralSearchStationResult: Codable, Equatable {
    public let totalResults: Int?
    public let fromIndex: Int?
    public let endIndex: Int?
    public let stations: [GeneralSearchStation]

    init(
        totalResults: Int?,
        fromIndex: Int?,
        endIndex: Int?,
        stations: [GeneralSearchStation]
    ) {
        self.totalResults = totalResults
        self.fromIndex = fromIndex
        self.endIndex = endIndex
        self.stations = stations
    }
}
