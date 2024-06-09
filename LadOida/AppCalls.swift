//
//  AppCalls.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct CountryCall: Call {
    public typealias ResponseType = [Country]

    public var method: HTTPMethod = .GET
    public var path: String = "countries"
    public var parser = ResponseType.self

    init() {}
}

public struct AuthenticationModesCall: Call {
    public typealias ResponseType = [AuthenticationMode]

    public var method: HTTPMethod = .GET
    public var path: String = "enumerations/authenticationModes"
    public var parser = ResponseType.self

    init() {}
}

public struct ConnectorTypesCall: Call {
    public typealias ResponseType = [ConnectorType]

    public var method: HTTPMethod = .GET
    public var path: String = "enumerations/connectorTypes"
    public var parser = ResponseType.self

    init() {}
}

public struct VehicleTypesCall: Call {
    public typealias ResponseType = [VehicleType]

    public var method: HTTPMethod = .GET
    public var path: String = "enumerations/vehicleTypes"
    public var parser = ResponseType.self

    init() {}
}
