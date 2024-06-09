//
//  OpeningHourDetail.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct OpeningHourDetail: Codable, Equatable {
    public let fromWeekday: String?
    public let fromTime: String?
    public let toWeekday: String?
    public let toTime: String?

    init(
        fromWeekday: String?,
        fromTime: String?,
        toWeekday: String?,
        toTime: String?
    ) {
        self.fromWeekday = fromWeekday
        self.fromTime = fromTime
        self.toWeekday = toWeekday
        self.toTime = toTime
    }
}
