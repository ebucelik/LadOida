//
//  AppService.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public protocol AppServiceProtocol {
    func fetchCountries() async throws -> [Country]
    func fetchAuthenticationModes() async throws -> [AuthenticationMode]
    func fetchConnectorTypes() async throws -> [ConnectorType]
    func fetchVehicleTypes() async throws -> [VehicleType]
}

public class AppService: APIClient, AppServiceProtocol {
    public func fetchCountries() async throws -> [Country] {
        try await startRequest(with: CountryCall())
    }
    
    public func fetchAuthenticationModes() async throws -> [AuthenticationMode] {
        try await startRequest(with: AuthenticationModesCall())
    }
    
    public func fetchConnectorTypes() async throws -> [ConnectorType] {
        try await startRequest(with: ConnectorTypesCall())
    }
    
    public func fetchVehicleTypes() async throws -> [VehicleType] {
        try await startRequest(with: VehicleTypesCall())
    }
}
