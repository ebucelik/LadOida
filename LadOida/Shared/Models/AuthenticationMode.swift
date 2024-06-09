//
//  AuthenticationMode.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public struct AuthenticationMode: Codable, Equatable {
    public let key: String
    public let description: String

    init(
        key: String,
        description: String
    ) {
        self.key = key
        self.description = description
    }
}
