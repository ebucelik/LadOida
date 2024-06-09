//
//  Call.swift
//  LadOida
//
//  Created by Ing. Ebu Celik, BSc on 09.06.24.
//

import Foundation

public protocol Call {
    associatedtype ResponseType: Codable

    var method: HTTPMethod { get }
    var body: Data? { get }
    var parser: ResponseType.Type { get }
    var parameters: [String: String]? { get }
    var path: String { get }
}

public extension Call {
    var body: Data? { nil }
    var parameters: [String: String]? { nil }
}
