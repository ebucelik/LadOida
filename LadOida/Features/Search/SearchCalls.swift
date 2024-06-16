//
//  SearchCalls.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 16.06.24.
//

import Foundation

struct SearchStationsCall: Call {
    typealias ResponseType = GeneralSearchStationResult

    var method: HTTPMethod = .GET
    var path: String = "search/stations"
    var parser = GeneralSearchStationResult.self
    var parameters: [String : String]?

    init(
        lat: Double,
        lng: Double,
        postalCode: String?
    ) {
        self.parameters = [
            "latitude": "\(lat)",
            "longitude": "\(lng)",
            "postCode": postalCode ?? ""
        ]
    }
}
