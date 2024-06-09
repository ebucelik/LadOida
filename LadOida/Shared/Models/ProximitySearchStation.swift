//
//  ProximitySearchStation.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct ProximitySearchStation: Codable, Equatable {
    public let stationId: String
    public let stationStatus: String
    public let label: String
    public let description: String?
    public let postCode: String
    public let city: String
    public let street: String
    public let location: ProximitySearchLocation?
    public let distance: Double?
    public let contactName: String
    public let telephone: String?
    public let email: String?
    public let website: String?
    public let directions: String?
    public let greenEnergy: Bool?
    public let freeParking: Bool?
    public let openingHours: OpeningHours?
    public let priceUrl: String?
    public let points: [ProximitySearchPoint]

    init(
        stationId: String,
        stationStatus: String,
        label: String,
        description: String?,
        postCode: String,
        city: String,
        street: String,
        location: ProximitySearchLocation?,
        distance: Double?,
        contactName: String,
        telephone: String?,
        email: String?,
        website: String?,
        directions: String?,
        greenEnergy: Bool?,
        freeParking: Bool?,
        openingHours: OpeningHours?,
        priceUrl: String?,
        points: [ProximitySearchPoint]
    ) {
        self.stationId = stationId
        self.stationStatus = stationStatus
        self.label = label
        self.description = description
        self.postCode = postCode
        self.city = city
        self.street = street
        self.location = location
        self.distance = distance
        self.contactName = contactName
        self.telephone = telephone
        self.email = email
        self.website = website
        self.directions = directions
        self.greenEnergy = greenEnergy
        self.freeParking = freeParking
        self.openingHours = openingHours
        self.priceUrl = priceUrl
        self.points = points
    }
}
