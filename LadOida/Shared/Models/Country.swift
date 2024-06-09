//
//  Country.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct Country: Codable, Equatable {
    public let country: String
    public let sortKey: Int

    init(
        country: String,
        sortKey: Int
    ) {
        self.country = country
        self.sortKey = sortKey
    }
}
