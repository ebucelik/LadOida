//
//  GeneralSearchStation.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct GeneralSearchStation: Codable, Equatable, Hashable {
    public let `public`: Bool?
    public let evseCountryId: String?
    public let evseOperatorId: String?
    public let evseStationId: String?
    public let status: String?
    public let label: String?
    public let description: String?
    public let postCode: String?
    public let city: String?
    public let street: String?
    public let location: GeneralSearchLocation?
    public let distance: Double?
    public let contactName: String?
    public let telephone: String?
    public let email: String?
    public let website: String?
    public let directions: String?
    public let greenEnergy: Bool?
    public let freeParking: Bool?
    public let openingHours: OpeningHours?
    public let priceUrl: String?
    public let points: [GeneralSearchPoint]

    init(
        `public`: Bool?,
        evseCountryId: String?,
        evseOperatorId: String?,
        evseStationId: String?,
        status: String?,
        label: String?,
        description: String?,
        postCode: String?,
        city: String?,
        street: String?,
        location: GeneralSearchLocation?,
        distance: Double?,
        contactName: String?,
        telephone: String?,
        email: String?,
        website: String?,
        directions: String?,
        greenEnergy: Bool?,
        freeParking: Bool?,
        openingHours: OpeningHours?,
        priceUrl: String?,
        points: [GeneralSearchPoint]
    ) {
        self.public = `public`
        self.evseCountryId = evseCountryId
        self.evseOperatorId = evseOperatorId
        self.evseStationId = evseStationId
        self.status = status
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

    public func hash(into hasher: inout Hasher) {
        hasher.combine(evseCountryId)
        hasher.combine(evseOperatorId)
        hasher.combine(evseStationId)
    }
}
