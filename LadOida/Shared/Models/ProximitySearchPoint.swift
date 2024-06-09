//
//  ProximitySearchPoint.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct ProximitySearchPoint: Codable, Equatable {
    public let evseId: String?
    public let capacityKwh: Double?
    public let location: ProximitySearchLocation?
    public let roaming: Bool?
    public let freeOfCharge: Bool?
    public let priceCentKwh: Double?
    public let priceCentMin: Double?
    public let authenticationMode: [String]
    public let connectorType: [String]
    public let vehicleType: [String]

    init(
        evseId: String?,
        capacityKwh: Double?,
        location: ProximitySearchLocation?,
        roaming: Bool?,
        freeOfCharge: Bool?,
        priceCentKwh: Double?,
        priceCentMin: Double?,
        authenticationMode: [String],
        connectorType: [String],
        vehicleType: [String]
    ) {
        self.evseId = evseId
        self.capacityKwh = capacityKwh
        self.location = location
        self.roaming = roaming
        self.freeOfCharge = freeOfCharge
        self.priceCentKwh = priceCentKwh
        self.priceCentMin = priceCentMin
        self.authenticationMode = authenticationMode
        self.connectorType = connectorType
        self.vehicleType = vehicleType
    }
}
