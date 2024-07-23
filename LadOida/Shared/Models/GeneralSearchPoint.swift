//
//  GeneralSearchPoint.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct GeneralSearchPoint: Codable, Identifiable, Equatable {
    public var id: String {
        evseId ?? UUID().uuidString
    }
    public let `public`: Bool?
    public let evseId: String?
    public let energyInKw: Double?
    public let location: GeneralSearchLocation?
    public let roaming: Bool?
    public let freeOfCharge: Bool?
    public let priceInCentPerKwh: Double?
    public let priceInCentPerMin: Double?
    public let status: String?
    public let authenticationModes: [String]
    public let connectorTypes: [String]
    public let vehicleTypes: [String]

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
        authenticationModes: [String],
        connectorTypes: [String],
        vehicleTypes: [String]
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
        self.authenticationModes = authenticationModes
        self.connectorTypes = connectorTypes
        self.vehicleTypes = vehicleTypes
    }
}
