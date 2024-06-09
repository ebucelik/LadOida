//
//  GeneralSearchPoint.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct GeneralSearchPoint: Codable, Equatable {
    public let `public`: Bool?
    public let evseId: String?
    public let energyInKw: Double?
    public let location: GeneralSearchLocation?
    public let roaming: Bool?
    public let freeOfCharge: Bool?
    public let priceInCentPerKwh: Double?
    public let priceInCentPerMin: Double?
    public let status: String?
    public let authenticationMode: [String]
    public let connectorType: [String]
    public let vehicleType: [String]

    init(
        `public`: Bool?,
        evseId: String?,
        energyInKw: Double?,
        location: GeneralSearchLocation?,
        roaming: Bool?,
        freeOfCharge: Bool?,
        priceInCentPerKwh: Double?,
        priceInCentPerMin: Double?,
        status: String?,
        authenticationMode: [String],
        connectorType: [String],
        vehicleType: [String]
    ) {
        self.public = `public`
        self.evseId = evseId
        self.energyInKw = energyInKw
        self.location = location
        self.roaming = roaming
        self.freeOfCharge = freeOfCharge
        self.priceInCentPerKwh = priceInCentPerKwh
        self.priceInCentPerMin = priceInCentPerMin
        self.status = status
        self.authenticationMode = authenticationMode
        self.connectorType = connectorType
        self.vehicleType = vehicleType
    }
}
