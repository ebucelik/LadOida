//
//  OpeningHours.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct OpeningHours: Codable, Equatable {
    public let text: String?
    public let details: [OpeningHourDetail]

    init(
        text: String?,
        details: [OpeningHourDetail]
    ) {
        self.text = text
        self.details = details
    }
}
